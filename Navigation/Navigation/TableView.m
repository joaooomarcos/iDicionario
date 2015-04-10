//
//  TableView.m
//  Navigation
//
//  Created by João Marcos on 18/03/15.
//  Copyright (c) 2015 João Marcos. All rights reserved.
//

#import "TableView.h"
#import "DataCenter.h"
#import "Letter.h"

@interface TableView (){
    DataCenter *data;
    NSArray *results;
    Letter *let;
}

@end

@implementation TableView
@synthesize tb;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Dados
    data = [DataCenter instance];
    results = [[NSArray alloc]initWithArray:[data returnAll]];
    
    // Inciando a TableView com tamanho e posição
    tb = [[UITableView alloc]initWithFrame:CGRectMake(0.0, 20.0, self.view.bounds.size.width,self.view.bounds.size.height-50)];
    
    // Delegate e DataSource da TableView
    tb.delegate = self;
    tb.dataSource = self;
    
    // Cor de fundo TableView
    self.view.backgroundColor = [UIColor colorWithRed:206.0/255.0 green:228.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    // Adicionando a TableView na View
    [self.view addSubview:tb];
}

-(void)viewWillAppear:(BOOL)animated{
    tb.reloadData;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Retorna o numero de seções
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Retorna o numero de linhas na seção
    return results.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Ao invés de usar:
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    // Construo uma célula padrão com imagem, titulo e subtitulo
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    
    long row = [indexPath row];
    
    let = [results objectAtIndex:row];
    
    // Inserindo dados na célula
    [cell.textLabel setText:let.letter];
    [cell.detailTextLabel setText:let.word];
    [cell.imageView setImage:[UIImage imageNamed:let.image]];
    cell.backgroundColor = [UIColor colorWithRed:206.0/255.0 green:228.0/255.0 blue:255.0/255.0 alpha:1.0];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    data.search = (int)indexPath.row;
    [self.tabBarController setSelectedIndex:0];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
