Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48FF6C99C5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 04:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjC0CxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 22:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjC0CxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 22:53:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40284EF1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 19:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679885583; x=1711421583;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9eVdGH/DopYEekjVEJ36PqM+ZaOFt22BlZBQTp7DdEk=;
  b=acHyGy3PXnftHpRe5dNTQ0NLk1V1TPnHXKRM7d4b/AYMNrvvXQ6THckO
   OMDo3lFWc2u+LP9X9B6auSP8NFw57z7AAbwy6QRMH33PNT87WqXIZfuEi
   T2USbL/Ssfq7VfsesNZ9zwVr2Xm6RRRM6GPM957/QY7U6XpD7d8LkI8fI
   eY8MACsrPQnsTCa4Fs9wuC+TL0S7NeJu98GWA8DdwXtQT54N6u5BOROMb
   s/l+yFHryxY4k3ccFCEQoTw+bQaT1+tH+Q3EoMfpPl+bpodJPTzoqelqz
   jzRPgyMlhG7k5o8o1YD2CW05VUngsizDWsiTmLEci3WS2V4KfX2YzOC0p
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="324050337"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="324050337"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 19:53:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="929310306"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="929310306"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 26 Mar 2023 19:53:01 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pgcyi-000HUl-2g;
        Mon, 27 Mar 2023 02:53:00 +0000
Date:   Mon, 27 Mar 2023 10:52:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: drivers/dma/dw-edma/dw-edma-v0-regs.h:37:4: warning: field sar
 within 'struct dw_edma_v0_ch_regs' is less aligned than 'union (unnamed
 union at drivers/dma/dw-edma/dw-edma-v0-regs.h:31:2)' and is usually due to
 'struct dw_edma_v0_ch_regs' being packed, wh...
Message-ID: <202303271012.Jah7vYLr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   197b6b60ae7bc51dd0814953c562833143b292aa
commit: 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8 ARM: dove: multiplatform support
date:   12 months ago
config: arm-randconfig-r002-20230327 (https://download.01.org/0day-ci/archive/20230327/202303271012.Jah7vYLr-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/dma/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303271012.Jah7vYLr-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/dma/dw-edma/dw-edma-v0-core.c:13:
>> drivers/dma/dw-edma/dw-edma-v0-regs.h:37:4: warning: field sar within 'struct dw_edma_v0_ch_regs' is less aligned than 'union (unnamed union at drivers/dma/dw-edma/dw-edma-v0-regs.h:31:2)' and is usually due to 'struct dw_edma_v0_ch_regs' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           } sar;
             ^
>> drivers/dma/dw-edma/dw-edma-v0-regs.h:44:4: warning: field dar within 'struct dw_edma_v0_ch_regs' is less aligned than 'union (unnamed union at drivers/dma/dw-edma/dw-edma-v0-regs.h:38:2)' and is usually due to 'struct dw_edma_v0_ch_regs' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           } dar;
             ^
>> drivers/dma/dw-edma/dw-edma-v0-regs.h:51:4: warning: field llp within 'struct dw_edma_v0_ch_regs' is less aligned than 'union (unnamed union at drivers/dma/dw-edma/dw-edma-v0-regs.h:45:2)' and is usually due to 'struct dw_edma_v0_ch_regs' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           } llp;
             ^
>> drivers/dma/dw-edma/dw-edma-v0-regs.h:172:4: warning: field rd_err_status within 'struct dw_edma_v0_regs' is less aligned than 'union (unnamed union at drivers/dma/dw-edma/dw-edma-v0-regs.h:166:2)' and is usually due to 'struct dw_edma_v0_regs' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           } rd_err_status;
             ^
>> drivers/dma/dw-edma/dw-edma-v0-regs.h:182:4: warning: field rd_done_imwr within 'struct dw_edma_v0_regs' is less aligned than 'union (unnamed union at drivers/dma/dw-edma/dw-edma-v0-regs.h:176:2)' and is usually due to 'struct dw_edma_v0_regs' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           } rd_done_imwr;
             ^
>> drivers/dma/dw-edma/dw-edma-v0-regs.h:189:4: warning: field rd_abort_imwr within 'struct dw_edma_v0_regs' is less aligned than 'union (unnamed union at drivers/dma/dw-edma/dw-edma-v0-regs.h:183:2)' and is usually due to 'struct dw_edma_v0_regs' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           } rd_abort_imwr;
             ^
>> drivers/dma/dw-edma/dw-edma-v0-regs.h:71:4: warning: field wr_engine_hshake_cnt within 'struct dw_edma_v0_unroll' is less aligned than 'union (unnamed union at drivers/dma/dw-edma/dw-edma-v0-regs.h:65:2)' and is usually due to 'struct dw_edma_v0_unroll' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           } wr_engine_hshake_cnt;
             ^
>> drivers/dma/dw-edma/dw-edma-v0-regs.h:79:4: warning: field rd_engine_hshake_cnt within 'struct dw_edma_v0_unroll' is less aligned than 'union (unnamed union at drivers/dma/dw-edma/dw-edma-v0-regs.h:73:2)' and is usually due to 'struct dw_edma_v0_unroll' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           } rd_engine_hshake_cnt;
             ^
   8 warnings generated.


vim +37 drivers/dma/dw-edma/dw-edma-v0-regs.h

7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04   26  
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04   27  struct dw_edma_v0_ch_regs {
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   28  	u32 ch_control1;				/* 0x0000 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   29  	u32 ch_control2;				/* 0x0004 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   30  	u32 transfer_size;				/* 0x0008 */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18   31  	union {
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   32  		u64 reg;				/* 0x000c..0x0010 */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18   33  		struct {
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   34  			u32 lsb;			/* 0x000c */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   35  			u32 msb;			/* 0x0010 */
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04   36  		};
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  @37  	} sar;
04e0a39fc10f82 Gustavo Pimentel 2021-02-18   38  	union {
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   39  		u64 reg;				/* 0x0014..0x0018 */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18   40  		struct {
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   41  			u32 lsb;			/* 0x0014 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   42  			u32 msb;			/* 0x0018 */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18   43  		};
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  @44  	} dar;
04e0a39fc10f82 Gustavo Pimentel 2021-02-18   45  	union {
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   46  		u64 reg;				/* 0x001c..0x0020 */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18   47  		struct {
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   48  			u32 lsb;			/* 0x001c */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   49  			u32 msb;			/* 0x0020 */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18   50  		};
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  @51  	} llp;
04e0a39fc10f82 Gustavo Pimentel 2021-02-18   52  } __packed;
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04   53  
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04   54  struct dw_edma_v0_ch {
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   55  	struct dw_edma_v0_ch_regs wr;			/* 0x0200 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   56  	u32 padding_1[55];				/* 0x0224..0x02fc */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   57  	struct dw_edma_v0_ch_regs rd;			/* 0x0300 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   58  	u32 padding_2[55];				/* 0x0324..0x03fc */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18   59  } __packed;
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04   60  
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04   61  struct dw_edma_v0_unroll {
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   62  	u32 padding_1;					/* 0x00f8 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   63  	u32 wr_engine_chgroup;				/* 0x0100 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   64  	u32 rd_engine_chgroup;				/* 0x0104 */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18   65  	union {
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   66  		u64 reg;				/* 0x0108..0x010c */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18   67  		struct {
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   68  			u32 lsb;			/* 0x0108 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   69  			u32 msb;			/* 0x010c */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18   70  		};
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  @71  	} wr_engine_hshake_cnt;
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   72  	u32 padding_2[2];				/* 0x0110..0x0114 */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18   73  	union {
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   74  		u64 reg;				/* 0x0120..0x0124 */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18   75  		struct {
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   76  			u32 lsb;			/* 0x0120 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   77  			u32 msb;			/* 0x0124 */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18   78  		};
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  @79  	} rd_engine_hshake_cnt;
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   80  	u32 padding_3[2];				/* 0x0120..0x0124 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   81  	u32 wr_ch0_pwr_en;				/* 0x0128 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   82  	u32 wr_ch1_pwr_en;				/* 0x012c */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   83  	u32 wr_ch2_pwr_en;				/* 0x0130 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   84  	u32 wr_ch3_pwr_en;				/* 0x0134 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   85  	u32 wr_ch4_pwr_en;				/* 0x0138 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   86  	u32 wr_ch5_pwr_en;				/* 0x013c */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   87  	u32 wr_ch6_pwr_en;				/* 0x0140 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   88  	u32 wr_ch7_pwr_en;				/* 0x0144 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   89  	u32 padding_4[8];				/* 0x0148..0x0164 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   90  	u32 rd_ch0_pwr_en;				/* 0x0168 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   91  	u32 rd_ch1_pwr_en;				/* 0x016c */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   92  	u32 rd_ch2_pwr_en;				/* 0x0170 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   93  	u32 rd_ch3_pwr_en;				/* 0x0174 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   94  	u32 rd_ch4_pwr_en;				/* 0x0178 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   95  	u32 rd_ch5_pwr_en;				/* 0x018c */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   96  	u32 rd_ch6_pwr_en;				/* 0x0180 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   97  	u32 rd_ch7_pwr_en;				/* 0x0184 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   98  	u32 padding_5[30];				/* 0x0188..0x01fc */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18   99  	struct dw_edma_v0_ch ch[EDMA_V0_MAX_NR_CH];	/* 0x0200..0x1120 */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  100  } __packed;
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  101  
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  102  struct dw_edma_v0_legacy {
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  103  	u32 viewport_sel;				/* 0x00f8 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  104  	struct dw_edma_v0_ch_regs ch;			/* 0x0100..0x0120 */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  105  } __packed;
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  106  
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  107  struct dw_edma_v0_regs {
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  108  	/* eDMA global registers */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  109  	u32 ctrl_data_arb_prior;			/* 0x0000 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  110  	u32 padding_1;					/* 0x0004 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  111  	u32 ctrl;					/* 0x0008 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  112  	u32 wr_engine_en;				/* 0x000c */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  113  	u32 wr_doorbell;				/* 0x0010 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  114  	u32 padding_2;					/* 0x0014 */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  115  	union {
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  116  		u64 reg;				/* 0x0018..0x001c */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  117  		struct {
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  118  			u32 lsb;			/* 0x0018 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  119  			u32 msb;			/* 0x001c */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  120  		};
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  121  	} wr_ch_arb_weight;
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  122  	u32 padding_3[3];				/* 0x0020..0x0028 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  123  	u32 rd_engine_en;				/* 0x002c */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  124  	u32 rd_doorbell;				/* 0x0030 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  125  	u32 padding_4;					/* 0x0034 */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  126  	union {
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  127  		u64 reg;				/* 0x0038..0x003c */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  128  		struct {
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  129  			u32 lsb;			/* 0x0038 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  130  			u32 msb;			/* 0x003c */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  131  		};
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  132  	} rd_ch_arb_weight;
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  133  	u32 padding_5[3];				/* 0x0040..0x0048 */
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  134  	/* eDMA interrupts registers */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  135  	u32 wr_int_status;				/* 0x004c */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  136  	u32 padding_6;					/* 0x0050 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  137  	u32 wr_int_mask;				/* 0x0054 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  138  	u32 wr_int_clear;				/* 0x0058 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  139  	u32 wr_err_status;				/* 0x005c */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  140  	union {
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  141  		u64 reg;				/* 0x0060..0x0064 */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  142  		struct {
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  143  			u32 lsb;			/* 0x0060 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  144  			u32 msb;			/* 0x0064 */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  145  		};
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  146  	} wr_done_imwr;
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  147  	union {
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  148  		u64 reg;				/* 0x0068..0x006c */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  149  		struct {
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  150  			u32 lsb;			/* 0x0068 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  151  			u32 msb;			/* 0x006c */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  152  		};
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  153  	} wr_abort_imwr;
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  154  	u32 wr_ch01_imwr_data;				/* 0x0070 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  155  	u32 wr_ch23_imwr_data;				/* 0x0074 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  156  	u32 wr_ch45_imwr_data;				/* 0x0078 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  157  	u32 wr_ch67_imwr_data;				/* 0x007c */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  158  	u32 padding_7[4];				/* 0x0080..0x008c */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  159  	u32 wr_linked_list_err_en;			/* 0x0090 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  160  	u32 padding_8[3];				/* 0x0094..0x009c */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  161  	u32 rd_int_status;				/* 0x00a0 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  162  	u32 padding_9;					/* 0x00a4 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  163  	u32 rd_int_mask;				/* 0x00a8 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  164  	u32 rd_int_clear;				/* 0x00ac */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  165  	u32 padding_10;					/* 0x00b0 */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  166  	union {
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  167  		u64 reg;				/* 0x00b4..0x00b8 */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  168  		struct {
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  169  			u32 lsb;			/* 0x00b4 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  170  			u32 msb;			/* 0x00b8 */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  171  		};
04e0a39fc10f82 Gustavo Pimentel 2021-02-18 @172  	} rd_err_status;
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  173  	u32 padding_11[2];				/* 0x00bc..0x00c0 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  174  	u32 rd_linked_list_err_en;			/* 0x00c4 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  175  	u32 padding_12;					/* 0x00c8 */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  176  	union {
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  177  		u64 reg;				/* 0x00cc..0x00d0 */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  178  		struct {
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  179  			u32 lsb;			/* 0x00cc */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  180  			u32 msb;			/* 0x00d0 */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  181  		};
04e0a39fc10f82 Gustavo Pimentel 2021-02-18 @182  	} rd_done_imwr;
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  183  	union {
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  184  		u64 reg;				/* 0x00d4..0x00d8 */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  185  		struct {
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  186  			u32 lsb;			/* 0x00d4 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  187  			u32 msb;			/* 0x00d8 */
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  188  		};
04e0a39fc10f82 Gustavo Pimentel 2021-02-18 @189  	} rd_abort_imwr;
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  190  	u32 rd_ch01_imwr_data;				/* 0x00dc */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  191  	u32 rd_ch23_imwr_data;				/* 0x00e0 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  192  	u32 rd_ch45_imwr_data;				/* 0x00e4 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  193  	u32 rd_ch67_imwr_data;				/* 0x00e8 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  194  	u32 padding_13[4];				/* 0x00ec..0x00f8 */
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  195  	/* eDMA channel context grouping */
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  196  	union dw_edma_v0_type {
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  197  		struct dw_edma_v0_legacy legacy;	/* 0x00f8..0x0120 */
b79f17517ad8c9 Gustavo Pimentel 2021-02-18  198  		struct dw_edma_v0_unroll unroll;	/* 0x00f8..0x1120 */
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  199  	} type;
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  200  } __packed;
7e4b8a4fbe2cec Gustavo Pimentel 2019-06-04  201  

:::::: The code at line 37 was first introduced by commit
:::::: 04e0a39fc10f82a71b84af73351333b184cee578 dmaengine: dw-edma: Add writeq() and readq() for 64 bits architectures

:::::: TO: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
:::::: CC: Vinod Koul <vkoul@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
