import React from 'react';
import {IconType} from '..';

export const IconCheckboxSelected: IconType = ({
  height = 16,
  width = 16,
  ...props
}) => {
  return (
    <svg
      width={width}
      height={height}
      fill="none"
      viewBox="0 0 16 16"
      {...props}
    >
      <path
        d="M16 4C16 2.93913 15.5786 1.92172 14.8284 1.17157C14.0783 0.421427 13.0609 0 12 0H4C2.93913 0 1.92172 0.421427 1.17157 1.17157C0.421427 1.92172 0 2.93913 0 4V12C0 13.0609 0.421427 14.0783 1.17157 14.8284C1.92172 15.5786 2.93913 16 4 16H12C13.0609 16 14.0783 15.5786 14.8284 14.8284C15.5786 14.0783 16 13.0609 16 12V4ZM12.2457 4.47086C12.3342 4.54049 12.408 4.62692 12.463 4.72516C12.5179 4.82341 12.553 4.93155 12.566 5.04337C12.5791 5.15519 12.5699 5.26848 12.5391 5.37675C12.5082 5.48502 12.4563 5.58614 12.3863 5.67429L7.89257 11.352C7.78354 11.5186 7.64086 11.6605 7.47371 11.7687C7.30655 11.8769 7.11861 11.9489 6.92197 11.9801C6.72532 12.0113 6.52433 12.001 6.33189 11.95C6.13945 11.8989 5.95983 11.8081 5.80457 11.6834L3.76229 10.1074C3.58224 9.96861 3.46472 9.76395 3.43557 9.53848C3.40642 9.313 3.46804 9.08519 3.60686 8.90514C3.74568 8.7251 3.95034 8.60758 4.17581 8.57843C4.40128 8.54928 4.6291 8.61089 4.80914 8.74971L6.42057 9.99429C6.48052 10.0397 6.55592 10.0598 6.63052 10.0502C6.70513 10.0406 6.77297 10.002 6.81943 9.94286L11.048 4.60914C11.1889 4.43251 11.3939 4.31881 11.6183 4.2929C11.8428 4.26698 12.0683 4.33096 12.2457 4.47086Z"
        fill="currentColor"
      />
    </svg>
  );
};