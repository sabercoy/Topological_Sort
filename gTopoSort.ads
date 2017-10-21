with Parent; use Parent;

generic
	type SortType is private;
	Input_File: String;
	Output_File: String;
	with function getInfo(X: ASEPtr) return String;
	with procedure put(X: SortType);
package gTopoSort is	
	function getNumOfJobs return integer;
	procedure determineJobType;
	procedure fillJobArray;
	procedure topoSortStep1;
	procedure topoSortStep2;
	procedure findLoop;
	function calcNewIndex return integer;
	function calcCheckIndex(sortValue: SortType) return integer;
	function checkNewEntry(checkValue: SortType) return boolean;
	procedure printFinal;
end gTopoSort;