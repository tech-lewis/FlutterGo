#import <Foundation/Foundation.h>

NSUInteger codeLineCount(NSString *path);

int main()
{
	NSUInteger count = codeLineCount(@"/Users/Adairlin/Desktop/iOS/ThinkSNS_4.0");
	
	NSLog(@"%ld", count);
	return 0;
}

/**
 *  计算文件或文件夹的代码行数
 *
 *  @param path 全路径(文件夹或文件)
 *
 *  @return 代码总行数
 */
NSUInteger codeLineCount(NSString *path)
{
	NSFileManager *mgr = [NSFileManager defaultManager];
	
	BOOL dir = NO;
	BOOL exist = [mgr fileExistsAtPath:path isDirectory:&dir];
	
	if(!exist)
	{
		NSLog(@"文件路径不存在");
		return 0;
	}
	
	int totalCount = 0;
	if (dir) { // 文件夹
		
		NSArray *array = [mgr contentsOfDirectoryAtPath:path error:nil];
		NSLog(@"%@",array);
		
		for (NSString *filename in array)
		{
			NSString *fullPath = [NSString stringWithFormat:@"%@/%@", path, filename];
			
			// 递归调用
			totalCount += codeLineCount(fullPath);
		}
		return totalCount;
	} else { // 文件
		NSString *extension = [[path pathExtension] lowercaseString];
		if (![extension isEqualToString:@"h"]
			&& ![extension isEqualToString:@"m"]
			&& ![extension isEqualToString:@"c"]) {
			return 0;
		}
		
		NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
		NSArray *array = [content componentsSeparatedByString:@"\n"];
		
		NSRange range = [path rangeOfString:@"/Users/Adairlin/Desktop/iOS/ThinkSNS_4.0"];
		NSString *str = [path stringByReplacingCharactersInRange:range withString:@""];
		NSLog(@"%@ -- %ld", str, array.count);
		return array.count;
	}
}

void test()
{
	NSString *str = @"jack\nrose\njim";
	NSArray *array = [str componentsSeparatedByString:@"\n"];
	
	for (NSString *subStr in array)
	{
		NSLog(@"%@", subStr);
	}
}