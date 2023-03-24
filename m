Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1481D6C888B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjCXWpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjCXWpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:45:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C94198
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679697938; x=1711233938;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zQ3MI8B9RVTHygEN65D8goJyoiq8A5LUXqctd+ZsGkQ=;
  b=Yd3Jksl0APCarQxC4wG264+LW/8FZqrdYmwi05e2yStcF6djvI4h6Ur1
   opFMRG1KjzOnAbP9wT3qF3whNKQphQJ0ckEi5tbneLIj6ofbVvCX4jxok
   jzCYz8sfH84HhCQb+5qfWgLyEGgetRvqGPCqVogK2JReaYJ4IuIRz74it
   GIVUqr2V6cwbQn0s2QT3bxhGjgQef+qWWlOcb1io9wlITu5TBnGsAmdPJ
   HrEgNBCGG4kSXEawm9pQrYGybr//Pw17OUvKbP3B6u5lqthcQSrrLDyFO
   IuT0qLxHbKH5xXEZKFKZu5NdPahPdFnIJzY2nZJMfUiYYWq/lGyZIu6Zb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="319555353"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="319555353"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 15:45:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="632990127"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="632990127"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Mar 2023 15:45:36 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfqAC-000Fit-0o;
        Fri, 24 Mar 2023 22:45:36 +0000
Date:   Sat, 25 Mar 2023 06:44:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fsfa3 17/17]
 lib/zstd/decompress/huf_decompress.c:1122:5: warning: 'HUF_fillDTableX2'
 accessing 624 bytes in a region of size 52
Message-ID: <202303250602.DR5hZJXz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fsfa3
head:   2226ddb6a576f7f89a8a06a3f89b68f5109ded53
commit: 2226ddb6a576f7f89a8a06a3f89b68f5109ded53 [17/17] Makefile: Enable -Wstringop-overflow and -Warray-bounds
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20230325/202303250602.DR5hZJXz-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?id=2226ddb6a576f7f89a8a06a3f89b68f5109ded53
        git remote add gustavoars https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
        git fetch --no-tags gustavoars testing/fsfa3
        git checkout 2226ddb6a576f7f89a8a06a3f89b68f5109ded53
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash lib/zstd/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303250602.DR5hZJXz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   lib/zstd/decompress/huf_decompress.c: In function 'HUF_readDTableX2_wksp_bmi2':
>> lib/zstd/decompress/huf_decompress.c:1122:5: warning: 'HUF_fillDTableX2' accessing 624 bytes in a region of size 52 [-Wstringop-overflow=]
    1122 |     HUF_fillDTableX2(dt, maxTableLog,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1123 |                    wksp->sortedSymbol,
         |                    ~~~~~~~~~~~~~~~~~~~
    1124 |                    wksp->rankStart0, wksp->rankVal, maxW,
         |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1125 |                    tableLog+1);
         |                    ~~~~~~~~~~~
   lib/zstd/decompress/huf_decompress.c:1122:5: note: referencing argument 5 of type 'U32[12][13]' {aka 'unsigned int[12][13]'}
   lib/zstd/decompress/huf_decompress.c:986:13: note: in a call to function 'HUF_fillDTableX2'
     986 | static void HUF_fillDTableX2(HUF_DEltX2* DTable, const U32 targetLog,
         |             ^~~~~~~~~~~~~~~~
>> lib/zstd/decompress/huf_decompress.c:1122:5: warning: 'HUF_fillDTableX2' accessing 624 bytes in a region of size 52 [-Wstringop-overflow=]
    1122 |     HUF_fillDTableX2(dt, maxTableLog,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1123 |                    wksp->sortedSymbol,
         |                    ~~~~~~~~~~~~~~~~~~~
    1124 |                    wksp->rankStart0, wksp->rankVal, maxW,
         |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1125 |                    tableLog+1);
         |                    ~~~~~~~~~~~
   lib/zstd/decompress/huf_decompress.c:1122:5: note: referencing argument 5 of type 'U32[12][13]' {aka 'unsigned int[12][13]'}
   lib/zstd/decompress/huf_decompress.c:986:13: note: in a call to function 'HUF_fillDTableX2'
     986 | static void HUF_fillDTableX2(HUF_DEltX2* DTable, const U32 targetLog,
         |             ^~~~~~~~~~~~~~~~


vim +/HUF_fillDTableX2 +1122 lib/zstd/decompress/huf_decompress.c

2aa14b1ab2c41a Nick Terrell 2022-10-17  1047  
2aa14b1ab2c41a Nick Terrell 2022-10-17  1048  size_t HUF_readDTableX2_wksp_bmi2(HUF_DTable* DTable,
2aa14b1ab2c41a Nick Terrell 2022-10-17  1049                         const void* src, size_t srcSize,
2aa14b1ab2c41a Nick Terrell 2022-10-17  1050                               void* workSpace, size_t wkspSize, int bmi2)
2aa14b1ab2c41a Nick Terrell 2022-10-17  1051  {
2aa14b1ab2c41a Nick Terrell 2022-10-17  1052      U32 tableLog, maxW, nbSymbols;
e0c1b49f5b674c Nick Terrell 2020-09-11  1053      DTableDesc dtd = HUF_getDTableDesc(DTable);
2aa14b1ab2c41a Nick Terrell 2022-10-17  1054      U32 maxTableLog = dtd.maxTableLog;
e0c1b49f5b674c Nick Terrell 2020-09-11  1055      size_t iSize;
e0c1b49f5b674c Nick Terrell 2020-09-11  1056      void* dtPtr = DTable+1;   /* force compiler to avoid strict-aliasing */
e0c1b49f5b674c Nick Terrell 2020-09-11  1057      HUF_DEltX2* const dt = (HUF_DEltX2*)dtPtr;
e0c1b49f5b674c Nick Terrell 2020-09-11  1058      U32 *rankStart;
e0c1b49f5b674c Nick Terrell 2020-09-11  1059  
e0c1b49f5b674c Nick Terrell 2020-09-11  1060      HUF_ReadDTableX2_Workspace* const wksp = (HUF_ReadDTableX2_Workspace*)workSpace;
e0c1b49f5b674c Nick Terrell 2020-09-11  1061  
e0c1b49f5b674c Nick Terrell 2020-09-11  1062      if (sizeof(*wksp) > wkspSize) return ERROR(GENERIC);
e0c1b49f5b674c Nick Terrell 2020-09-11  1063  
e0c1b49f5b674c Nick Terrell 2020-09-11  1064      rankStart = wksp->rankStart0 + 1;
e0c1b49f5b674c Nick Terrell 2020-09-11  1065      ZSTD_memset(wksp->rankStats, 0, sizeof(wksp->rankStats));
e0c1b49f5b674c Nick Terrell 2020-09-11  1066      ZSTD_memset(wksp->rankStart0, 0, sizeof(wksp->rankStart0));
e0c1b49f5b674c Nick Terrell 2020-09-11  1067  
e0c1b49f5b674c Nick Terrell 2020-09-11  1068      DEBUG_STATIC_ASSERT(sizeof(HUF_DEltX2) == sizeof(HUF_DTable));   /* if compiler fails here, assertion is wrong */
e0c1b49f5b674c Nick Terrell 2020-09-11  1069      if (maxTableLog > HUF_TABLELOG_MAX) return ERROR(tableLog_tooLarge);
e0c1b49f5b674c Nick Terrell 2020-09-11  1070      /* ZSTD_memset(weightList, 0, sizeof(weightList)); */  /* is not necessary, even though some analyzer complain ... */
e0c1b49f5b674c Nick Terrell 2020-09-11  1071  
2aa14b1ab2c41a Nick Terrell 2022-10-17  1072      iSize = HUF_readStats_wksp(wksp->weightList, HUF_SYMBOLVALUE_MAX + 1, wksp->rankStats, &nbSymbols, &tableLog, src, srcSize, wksp->calleeWksp, sizeof(wksp->calleeWksp), bmi2);
e0c1b49f5b674c Nick Terrell 2020-09-11  1073      if (HUF_isError(iSize)) return iSize;
e0c1b49f5b674c Nick Terrell 2020-09-11  1074  
e0c1b49f5b674c Nick Terrell 2020-09-11  1075      /* check result */
e0c1b49f5b674c Nick Terrell 2020-09-11  1076      if (tableLog > maxTableLog) return ERROR(tableLog_tooLarge);   /* DTable can't fit code depth */
2aa14b1ab2c41a Nick Terrell 2022-10-17  1077      if (tableLog <= HUF_DECODER_FAST_TABLELOG && maxTableLog > HUF_DECODER_FAST_TABLELOG) maxTableLog = HUF_DECODER_FAST_TABLELOG;
e0c1b49f5b674c Nick Terrell 2020-09-11  1078  
e0c1b49f5b674c Nick Terrell 2020-09-11  1079      /* find maxWeight */
e0c1b49f5b674c Nick Terrell 2020-09-11  1080      for (maxW = tableLog; wksp->rankStats[maxW]==0; maxW--) {}  /* necessarily finds a solution before 0 */
e0c1b49f5b674c Nick Terrell 2020-09-11  1081  
e0c1b49f5b674c Nick Terrell 2020-09-11  1082      /* Get start index of each weight */
e0c1b49f5b674c Nick Terrell 2020-09-11  1083      {   U32 w, nextRankStart = 0;
e0c1b49f5b674c Nick Terrell 2020-09-11  1084          for (w=1; w<maxW+1; w++) {
e0c1b49f5b674c Nick Terrell 2020-09-11  1085              U32 curr = nextRankStart;
e0c1b49f5b674c Nick Terrell 2020-09-11  1086              nextRankStart += wksp->rankStats[w];
e0c1b49f5b674c Nick Terrell 2020-09-11  1087              rankStart[w] = curr;
e0c1b49f5b674c Nick Terrell 2020-09-11  1088          }
e0c1b49f5b674c Nick Terrell 2020-09-11  1089          rankStart[0] = nextRankStart;   /* put all 0w symbols at the end of sorted list*/
2aa14b1ab2c41a Nick Terrell 2022-10-17  1090          rankStart[maxW+1] = nextRankStart;
e0c1b49f5b674c Nick Terrell 2020-09-11  1091      }
e0c1b49f5b674c Nick Terrell 2020-09-11  1092  
e0c1b49f5b674c Nick Terrell 2020-09-11  1093      /* sort symbols by weight */
e0c1b49f5b674c Nick Terrell 2020-09-11  1094      {   U32 s;
e0c1b49f5b674c Nick Terrell 2020-09-11  1095          for (s=0; s<nbSymbols; s++) {
e0c1b49f5b674c Nick Terrell 2020-09-11  1096              U32 const w = wksp->weightList[s];
e0c1b49f5b674c Nick Terrell 2020-09-11  1097              U32 const r = rankStart[w]++;
e0c1b49f5b674c Nick Terrell 2020-09-11  1098              wksp->sortedSymbol[r].symbol = (BYTE)s;
e0c1b49f5b674c Nick Terrell 2020-09-11  1099          }
e0c1b49f5b674c Nick Terrell 2020-09-11  1100          rankStart[0] = 0;   /* forget 0w symbols; this is beginning of weight(1) */
e0c1b49f5b674c Nick Terrell 2020-09-11  1101      }
e0c1b49f5b674c Nick Terrell 2020-09-11  1102  
e0c1b49f5b674c Nick Terrell 2020-09-11  1103      /* Build rankVal */
e0c1b49f5b674c Nick Terrell 2020-09-11  1104      {   U32* const rankVal0 = wksp->rankVal[0];
e0c1b49f5b674c Nick Terrell 2020-09-11  1105          {   int const rescale = (maxTableLog-tableLog) - 1;   /* tableLog <= maxTableLog */
e0c1b49f5b674c Nick Terrell 2020-09-11  1106              U32 nextRankVal = 0;
e0c1b49f5b674c Nick Terrell 2020-09-11  1107              U32 w;
e0c1b49f5b674c Nick Terrell 2020-09-11  1108              for (w=1; w<maxW+1; w++) {
e0c1b49f5b674c Nick Terrell 2020-09-11  1109                  U32 curr = nextRankVal;
e0c1b49f5b674c Nick Terrell 2020-09-11  1110                  nextRankVal += wksp->rankStats[w] << (w+rescale);
e0c1b49f5b674c Nick Terrell 2020-09-11  1111                  rankVal0[w] = curr;
e0c1b49f5b674c Nick Terrell 2020-09-11  1112          }   }
e0c1b49f5b674c Nick Terrell 2020-09-11  1113          {   U32 const minBits = tableLog+1 - maxW;
e0c1b49f5b674c Nick Terrell 2020-09-11  1114              U32 consumed;
e0c1b49f5b674c Nick Terrell 2020-09-11  1115              for (consumed = minBits; consumed < maxTableLog - minBits + 1; consumed++) {
e0c1b49f5b674c Nick Terrell 2020-09-11  1116                  U32* const rankValPtr = wksp->rankVal[consumed];
e0c1b49f5b674c Nick Terrell 2020-09-11  1117                  U32 w;
e0c1b49f5b674c Nick Terrell 2020-09-11  1118                  for (w = 1; w < maxW+1; w++) {
e0c1b49f5b674c Nick Terrell 2020-09-11  1119                      rankValPtr[w] = rankVal0[w] >> consumed;
e0c1b49f5b674c Nick Terrell 2020-09-11  1120      }   }   }   }
e0c1b49f5b674c Nick Terrell 2020-09-11  1121  
e0c1b49f5b674c Nick Terrell 2020-09-11 @1122      HUF_fillDTableX2(dt, maxTableLog,
2aa14b1ab2c41a Nick Terrell 2022-10-17  1123                     wksp->sortedSymbol,
e0c1b49f5b674c Nick Terrell 2020-09-11  1124                     wksp->rankStart0, wksp->rankVal, maxW,
2aa14b1ab2c41a Nick Terrell 2022-10-17  1125                     tableLog+1);
e0c1b49f5b674c Nick Terrell 2020-09-11  1126  
e0c1b49f5b674c Nick Terrell 2020-09-11  1127      dtd.tableLog = (BYTE)maxTableLog;
e0c1b49f5b674c Nick Terrell 2020-09-11  1128      dtd.tableType = 1;
e0c1b49f5b674c Nick Terrell 2020-09-11  1129      ZSTD_memcpy(DTable, &dtd, sizeof(dtd));
e0c1b49f5b674c Nick Terrell 2020-09-11  1130      return iSize;
e0c1b49f5b674c Nick Terrell 2020-09-11  1131  }
e0c1b49f5b674c Nick Terrell 2020-09-11  1132  

:::::: The code at line 1122 was first introduced by commit
:::::: e0c1b49f5b674cca7b10549c53b3791d0bbc90a8 lib: zstd: Upgrade to latest upstream zstd version 1.4.10

:::::: TO: Nick Terrell <terrelln@fb.com>
:::::: CC: Nick Terrell <terrelln@fb.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
