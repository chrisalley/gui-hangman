{ *********************************************************************** }
{                                                                         }
{  GUI Hangman                                                            }
{  Version 1.0 - First release of program                                 }
{  Last Revised: 27nd of July 2004                                        }
{  Copyright (c) 2004 Chris Alley                                         }
{                                                                         }
{ *********************************************************************** }

unit UConstantsAndTypes;

interface

const
  Easy   = 'Easy';
  Normal = 'Normal';
  Hard   = 'Hard';

  EasyWordListFilePath   = 'WordLists/EasyWordList.txt';
  NormalWordListFilePath = 'WordLists/NormalWordList.txt';
  HardWordListFilePath   = 'WordLists/HardWordList.txt';

  MysteryLetter = '*';

type
  TLetterSet = set of char;

implementation

end.
