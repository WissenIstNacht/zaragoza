import React from 'react';
import {IconType} from '..';

export const IconChevronUp: IconType = ({
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
        fillRule="evenodd"
        clipRule="evenodd"
        d="M3.29243 10.6953C3.47973 10.8824 3.73374 10.9875 3.99858 10.9875C4.26342 10.9875 4.51743 10.8824 4.70473 10.6953L7.99376 7.40894L11.2828 10.6953C11.3749 10.7906 11.4851 10.8667 11.607 10.919C11.7288 10.9713 11.8599 10.9988 11.9925 11C12.1251 11.0011 12.2567 10.9759 12.3794 10.9257C12.5022 10.8755 12.6137 10.8014 12.7075 10.7077C12.8012 10.614 12.8754 10.5026 12.9256 10.3799C12.9758 10.2573 13.0011 10.1258 13 9.99334C12.9988 9.86082 12.9713 9.72987 12.9189 9.60811C12.8666 9.48635 12.7905 9.37623 12.6951 9.28417L8.6999 5.2922C8.5126 5.1051 8.2586 5 7.99376 5C7.72891 5 7.47491 5.1051 7.28761 5.2922L3.29243 9.28417C3.10519 9.47132 3 9.72511 3 9.98974C3 10.2544 3.10519 10.5082 3.29243 10.6953Z"
        fill="currentColor"
      />
    </svg>
  );
};
