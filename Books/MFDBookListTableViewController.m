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

@property (nonatomic, weak) NSFetchedResultsController *fetchedResultsController;
@property NSMutableArray *books;

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
    
    self.books = [[NSMutableArray alloc] init];
    [self loadInitialData];
}

- (void)loadInitialData {
    MFDBook *item1 = [[MFDBook alloc] init];
    item1.title = @"AAAA";
    item1.author = @"Alpha";
    [self.books addObject:item1];
    
    MFDBook *item2 = [[MFDBook alloc] init];
    item2.title = @"BBBB";
    item2.author = @"Bravo";
    [self.books addObject:item2];

    MFDBook *item3 = [[MFDBook alloc] init];
    item3.title = @"CCCC";
    item3.author = @"Charlie";
    [self.books addObject:item3];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [self.books count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ListPrototypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    MFDBook *book = [self.books objectAtIndex:indexPath.row];
    cell.textLabel.text = book.title;
    
    return cell;
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
        [self.books removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
        [bookDetailViewController setCreating];
    }
    else if ([[segue identifier] isEqualToString:@"ShowBook"]) {
        ALog(@"ShowBook");
        MFDBookDetailViewController *bookDetailViewController = (MFDBookDetailViewController *)[segue destinationViewController];

        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        MFDBook *selectedBook = (MFDBook *)[self.books objectAtIndex:indexPath.row];

        bookDetailViewController.book = selectedBook;
        [bookDetailViewController setShowing];
    }
}

-(IBAction)cancelReturnToList:(UIStoryboardSegue *)segue
{
    ALog();
}

-(IBAction)storeReturnToList:(UIStoryboardSegue *)segue
{
    ALog();
    MFDBookDetailViewController *source = [segue sourceViewController];
    MFDBook *book = source.book;
    if (book != nil) {
        [self.books addObject:book];
        [self.tableView reloadData];
    }
}

@end
