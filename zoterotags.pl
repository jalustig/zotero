#!/usr/bin/perl -w

use DBI;

use strict;

# quit zotero safely using applescript...
system("osascript", "-e", "quit app \"Zotero\"");

my $username = $ENV{LOGNAME} || $ENV{USER} || getpwuid($<);

my $db = DBI->connect("dbi:SQLite:/Users/$username/Zotero/zotero.sqlite",  "", "",
{RaiseError => 1, AutoCommit => 1});

# Gets a list of all items with attachments and will add macOS tags to indicate **which kind of object** it is (right now, article, book, or thesis)

my $items = $db->selectall_arrayref("select items.itemID, items.itemTypeID, typeName, itemAttachments.path from items, itemAttachments, itemTypes where itemTypes.itemTypeID = items.itemTypeID and items.itemID = itemAttachments.parentItemID and itemAttachments.path like '/Users/%';");

print "item types\n\n";

foreach my $item (@$items) {
	my ($itemID,$itemTypeID,$typeName,$path) = @$item;
	print $itemID;
	print "\n";
	print $typeName;
	print "\n";
	print $path;
	print "\n-----\n";
	if ($typeName eq "journalArticle") {
		system("tag", "--add", "article", $path);
	}
	if ($typeName eq "book") {
		system("tag", "--add", "book", $path);
	}
	if ($typeName eq "thesis") {
		system("tag", "--add", "dissertation", $path);
	}
}

print "\n\n------\n\nTAGS\n\n";

# Gets a list of all items with tags and adds macOS tags to indicate them...

my $itemsTags = $db->selectall_arrayref("select items.itemID, tags.name, itemAttachments.path from items, itemAttachments, itemTags, tags where items.itemID = itemAttachments.parentItemID and itemAttachments.path like '/Users/%' and itemTags.itemID = items.itemID and itemTags.tagID = tags.tagID");

foreach my $item (@$itemsTags) {
	my ($itemID,$tagName,$path) = @$item;
	print $itemID;
	print "\n";
	print $tagName;
	print "\n";
	print $path;
	print "\n-----\n";
	if ($tagName eq "important") {
		system("tag", "--add", "important", $path);
	}
}

system("open", "/Applications/Zotero.app");

#for typeName in $(sqlite3 ~/Zotero/zotero.sqlite "select items.itemID, items.itemTypeID, typeName, itemAttachments.path from items, itemAttachments, itemTypes where itemTypes.itemTypeID = items.itemTypeID and items.itemID = itemAttachments.parentItemID and itemAttachments.path like '/Users/%';"); do
#	echo $typeName
#	echo $path
#done
