//
//  MFDBookListTableViewController.m
//  Books
//
//  Created by Adland Lee on 6/2/14.
//  Copyright (c) 2014 Adland Lee. All rights reserved.
//

#import "MFDBookListTableViewController.h"
#import "MFDBook.h"
#import "MFDBookDetailViewController.h"

@interface MFDBookListTableViewController ()

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
//@property NSMutableArray *books;

@end

@implementation MFDBookListTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
//    self.books = [[NSMutableArray alloc] init];
//    [self loadInitialData];
}

- (void)loadInitialData {
//    MFDBook *item1 = [[MFDBook alloc] init];
//    item1.title = @"AAAA";
//    item1.author = @"Alpha";
//    [self.books addObject:item1];
//    
//    MFDBook *item2 = [[MFDBook alloc] init];
//    item2.title = @"BBBB";
//    item2.author = @"Bravo";
//    [self.books addObject:item2];
//
//    MFDBook *item3 = [[MFDBook alloc] init];
//    item3.title = @"CCCC";
//    item3.author = @"Charlie";
//    [self.books addObject:item3];

//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Book detail support

- (void)returnFromBookDetailViewController:(MFDBookDetailViewController *)controller didFinishWithSave:(BOOL)save
{
    ALog(@"BOOL[%@]", save ? @"YES" : @"NO");
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ListPrototypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    MFDBook *book = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = book.title;
    cell.detailTextLabel.text = book.author;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
//        [self.books removeObjectAtIndex:indexPath.row];
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error;
        if (![context save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Fetched results controller

/*
 Returns the fetched results controller. Creates and configures the controller if necessary.
 */
- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    // Create and configure a fetch request with the Book entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [
    	NSEntityDescription
        entityForName:@"Book"
        inManagedObjectContext:self.managedObjectContext
        ];
    [fetchRequest setEntity:entity];
    
    // Create the sort descriptors array.
    NSSortDescriptor *authorDescriptor = [[NSSortDescriptor alloc] initWithKey:@"author" ascending:YES];
    NSSortDescriptor *titleDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    NSArray *sortDescriptors = @[authorDescriptor, titleDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Create and initialize the fetch results controller.
    _fetchedResultsController = [
    	[NSFetchedResultsController alloc]
        initWithFetchRequest:fetchRequest
        managedObjectContext:self.managedObjectContext
        sectionNameKeyPath:@"author"
        cacheName:@"Root"
        ];
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

/*
 NSFetchedResultsController delegate methods to respond to additions, removals and so on.
 */
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"CreateBook"]) {
        ALog(@"CreateBook");
        UINavigationController *navController = (UINavigationController *)[segue destinationViewController];
        MFDBookDetailViewController *bookDetailViewController = (MFDBookDetailViewController *)[navController topViewController];
        bookDetailViewController.delegate = self;
        
        NSManagedObjectContext *creatingContext = [
        	[NSManagedObjectContext alloc]
            initWithConcurrencyType:NSMainQueueConcurrencyType
            ];
        [creatingContext setParentContext:[self.fetchedResultsController managedObjectContext]];
        
        MFDBook *newBook = (MFDBook *)[
        	NSEntityDescription
            insertNewObjectForEntityForName:@"Book"
            inManagedObjectContext:self.managedObjectContext
            ];
        
        bookDetailViewController.managedObjectContext = self.managedObjectContext;
        bookDetailViewController.book = newBook;
        [bookDetailViewController setCreating];
    }
    else if ([[segue identifier] isEqualToString:@"ShowBook"]) {
        ALog(@"ShowBook");
        MFDBookDetailViewController *bookDetailViewController = (MFDBookDetailViewController *)[segue destinationViewController];

        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        MFDBook *selectedBook = (MFDBook *)[self.fetchedResultsController objectAtIndexPath:indexPath];

        bookDetailViewController.book = selectedBook;
        [bookDetailViewController setShowing];
    }
}

//-(IBAction)cancelReturnToList:(UIStoryboardSegue *)segue
//{
//    ALog();
//}
//
//-(IBAction)storeReturnToList:(UIStoryboardSegue *)segue
//{
//    ALog();
//    MFDBookDetailViewController *source = [segue sourceViewController];
//    MFDBook *book = source.book;
//    if (book != nil) {
////        [self.books addObject:book];
//        [self.tableView reloadData];
//    }
//}

@end
