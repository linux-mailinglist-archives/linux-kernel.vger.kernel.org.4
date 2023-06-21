Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CDD737AFA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjFUFzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 01:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjFUFzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 01:55:03 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1667BCA
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 22:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687326901; x=1718862901;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AnKoyt07jyE0JSq/KjyoMyx60atWQ9DwUQeQAPnkltI=;
  b=ju8GEZvDHMSGasSpdeax8wQXFJsULKGSvfhy3+SgemVenqY6Cc+iVrnt
   DEROZjb8jPbtD82EQwlyTyoqeXVvqT/ee7YML6uCUvQR/ETO12LZu1BPL
   KkB3xonqi5AFzYVxPn+swyAaHhxOLm57CbVvxS3Pz1kYSoR5UnIBw8isw
   YHxRoanCZu/t5508FHBVqz6xXXx5h4QszXzov3t7xH05H4hGf9Tc5+sYw
   3Y7/jrq/aeUQ+BRNXYyw+zYoX5bQPVsC/huLdLPKIkEADnWn4IIr/YoCq
   GXBKQABkHLTaNZG632vW+YUi6qH/YezPTvbqDfhbLQ+OYy/g+Yiu1i2QB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="357572536"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="357572536"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 22:55:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="744035640"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="744035640"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 20 Jun 2023 22:54:58 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qBqnx-0006bH-2A;
        Wed, 21 Jun 2023 05:54:57 +0000
Date:   Wed, 21 Jun 2023 13:54:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: drivers/dma/dw-edma/dw-edma-v0-regs.h:37:4: warning: field sar
 within 'struct dw_edma_v0_ch_regs' is less aligned than 'union (unnamed
 union at drivers/dma/dw-edma/dw-edma-v0-regs.h:31:2)' and is usually due to
 'struct dw_edma_v0_ch_regs' being packed, wh...
Message-ID: <202306211351.AsP2oCg8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e660abd551f1172e428b4e4003de887176a8a1fd
commit: df99e7bbbec3180693b3d932a9cbc88346e2a30e ARM: omap1: use pci_remap_iospace() for omap_cf
date:   1 year, 2 months ago
config: arm-randconfig-r004-20230621 (https://download.01.org/0day-ci/archive/20230621/202306211351.AsP2oCg8-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230621/202306211351.AsP2oCg8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306211351.AsP2oCg8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/dma/dw-edma/dw-edma-v0-debugfs.c:13:
>> drivers/dma/dw-edma/dw-edma-v0-regs.h:37:4: warning: field sar within 'struct dw_edma_v0_ch_regs' is less aligned than 'union (unnamed union at drivers/dma/dw-edma/dw-edma-v0-regs.h:31:2)' and is usually due to 'struct dw_edma_v0_ch_regs' being packed, which can lead to unaligned accesses [-Wunaligned-access]
      37 |         } sar;
         |           ^
>> drivers/dma/dw-edma/dw-edma-v0-regs.h:44:4: warning: field dar within 'struct dw_edma_v0_ch_regs' is less aligned than 'union (unnamed union at drivers/dma/dw-edma/dw-edma-v0-regs.h:38:2)' and is usually due to 'struct dw_edma_v0_ch_regs' being packed, which can lead to unaligned accesses [-Wunaligned-access]
      44 |         } dar;
         |           ^
>> drivers/dma/dw-edma/dw-edma-v0-regs.h:51:4: warning: field llp within 'struct dw_edma_v0_ch_regs' is less aligned than 'union (unnamed union at drivers/dma/dw-edma/dw-edma-v0-regs.h:45:2)' and is usually due to 'struct dw_edma_v0_ch_regs' being packed, which can lead to unaligned accesses [-Wunaligned-access]
      51 |         } llp;
         |           ^
>> drivers/dma/dw-edma/dw-edma-v0-regs.h:172:4: warning: field rd_err_status within 'struct dw_edma_v0_regs' is less aligned than 'union (unnamed union at drivers/dma/dw-edma/dw-edma-v0-regs.h:166:2)' and is usually due to 'struct dw_edma_v0_regs' being packed, which can lead to unaligned accesses [-Wunaligned-access]
     172 |         } rd_err_status;
         |           ^
>> drivers/dma/dw-edma/dw-edma-v0-regs.h:182:4: warning: field rd_done_imwr within 'struct dw_edma_v0_regs' is less aligned than 'union (unnamed union at drivers/dma/dw-edma/dw-edma-v0-regs.h:176:2)' and is usually due to 'struct dw_edma_v0_regs' being packed, which can lead to unaligned accesses [-Wunaligned-access]
     182 |         } rd_done_imwr;
         |           ^
>> drivers/dma/dw-edma/dw-edma-v0-regs.h:189:4: warning: field rd_abort_imwr within 'struct dw_edma_v0_regs' is less aligned than 'union (unnamed union at drivers/dma/dw-edma/dw-edma-v0-regs.h:183:2)' and is usually due to 'struct dw_edma_v0_regs' being packed, which can lead to unaligned accesses [-Wunaligned-access]
     189 |         } rd_abort_imwr;
         |           ^
>> drivers/dma/dw-edma/dw-edma-v0-regs.h:71:4: warning: field wr_engine_hshake_cnt within 'struct dw_edma_v0_unroll' is less aligned than 'union (unnamed union at drivers/dma/dw-edma/dw-edma-v0-regs.h:65:2)' and is usually due to 'struct dw_edma_v0_unroll' being packed, which can lead to unaligned accesses [-Wunaligned-access]
      71 |         } wr_engine_hshake_cnt;
         |           ^
>> drivers/dma/dw-edma/dw-edma-v0-regs.h:79:4: warning: field rd_engine_hshake_cnt within 'struct dw_edma_v0_unroll' is less aligned than 'union (unnamed union at drivers/dma/dw-edma/dw-edma-v0-regs.h:73:2)' and is usually due to 'struct dw_edma_v0_unroll' being packed, which can lead to unaligned accesses [-Wunaligned-access]
      79 |         } rd_engine_hshake_cnt;
         |           ^
   8 warnings generated.


vim +37 drivers/dma/dw-edma/dw-edma-v0-regs.h

7e4b8a4fbe2ceca Gustavo Pimentel 2019-06-04   26  
7e4b8a4fbe2ceca Gustavo Pimentel 2019-06-04   27  struct dw_edma_v0_ch_regs {
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   28  	u32 ch_control1;				/* 0x0000 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   29  	u32 ch_control2;				/* 0x0004 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   30  	u32 transfer_size;				/* 0x0008 */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18   31  	union {
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   32  		u64 reg;				/* 0x000c..0x0010 */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18   33  		struct {
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   34  			u32 lsb;			/* 0x000c */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   35  			u32 msb;			/* 0x0010 */
7e4b8a4fbe2ceca Gustavo Pimentel 2019-06-04   36  		};
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  @37  	} sar;
04e0a39fc10f82a Gustavo Pimentel 2021-02-18   38  	union {
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   39  		u64 reg;				/* 0x0014..0x0018 */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18   40  		struct {
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   41  			u32 lsb;			/* 0x0014 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   42  			u32 msb;			/* 0x0018 */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18   43  		};
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  @44  	} dar;
04e0a39fc10f82a Gustavo Pimentel 2021-02-18   45  	union {
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   46  		u64 reg;				/* 0x001c..0x0020 */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18   47  		struct {
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   48  			u32 lsb;			/* 0x001c */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   49  			u32 msb;			/* 0x0020 */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18   50  		};
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  @51  	} llp;
04e0a39fc10f82a Gustavo Pimentel 2021-02-18   52  } __packed;
7e4b8a4fbe2ceca Gustavo Pimentel 2019-06-04   53  
7e4b8a4fbe2ceca Gustavo Pimentel 2019-06-04   54  struct dw_edma_v0_ch {
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   55  	struct dw_edma_v0_ch_regs wr;			/* 0x0200 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   56  	u32 padding_1[55];				/* 0x0224..0x02fc */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   57  	struct dw_edma_v0_ch_regs rd;			/* 0x0300 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   58  	u32 padding_2[55];				/* 0x0324..0x03fc */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18   59  } __packed;
7e4b8a4fbe2ceca Gustavo Pimentel 2019-06-04   60  
7e4b8a4fbe2ceca Gustavo Pimentel 2019-06-04   61  struct dw_edma_v0_unroll {
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   62  	u32 padding_1;					/* 0x00f8 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   63  	u32 wr_engine_chgroup;				/* 0x0100 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   64  	u32 rd_engine_chgroup;				/* 0x0104 */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18   65  	union {
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   66  		u64 reg;				/* 0x0108..0x010c */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18   67  		struct {
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   68  			u32 lsb;			/* 0x0108 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   69  			u32 msb;			/* 0x010c */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18   70  		};
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  @71  	} wr_engine_hshake_cnt;
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   72  	u32 padding_2[2];				/* 0x0110..0x0114 */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18   73  	union {
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   74  		u64 reg;				/* 0x0120..0x0124 */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18   75  		struct {
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   76  			u32 lsb;			/* 0x0120 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   77  			u32 msb;			/* 0x0124 */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18   78  		};
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  @79  	} rd_engine_hshake_cnt;
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   80  	u32 padding_3[2];				/* 0x0120..0x0124 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   81  	u32 wr_ch0_pwr_en;				/* 0x0128 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   82  	u32 wr_ch1_pwr_en;				/* 0x012c */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   83  	u32 wr_ch2_pwr_en;				/* 0x0130 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   84  	u32 wr_ch3_pwr_en;				/* 0x0134 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   85  	u32 wr_ch4_pwr_en;				/* 0x0138 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   86  	u32 wr_ch5_pwr_en;				/* 0x013c */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   87  	u32 wr_ch6_pwr_en;				/* 0x0140 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   88  	u32 wr_ch7_pwr_en;				/* 0x0144 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   89  	u32 padding_4[8];				/* 0x0148..0x0164 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   90  	u32 rd_ch0_pwr_en;				/* 0x0168 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   91  	u32 rd_ch1_pwr_en;				/* 0x016c */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   92  	u32 rd_ch2_pwr_en;				/* 0x0170 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   93  	u32 rd_ch3_pwr_en;				/* 0x0174 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   94  	u32 rd_ch4_pwr_en;				/* 0x0178 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   95  	u32 rd_ch5_pwr_en;				/* 0x018c */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   96  	u32 rd_ch6_pwr_en;				/* 0x0180 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   97  	u32 rd_ch7_pwr_en;				/* 0x0184 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   98  	u32 padding_5[30];				/* 0x0188..0x01fc */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18   99  	struct dw_edma_v0_ch ch[EDMA_V0_MAX_NR_CH];	/* 0x0200..0x1120 */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  100  } __packed;
7e4b8a4fbe2ceca Gustavo Pimentel 2019-06-04  101  
7e4b8a4fbe2ceca Gustavo Pimentel 2019-06-04  102  struct dw_edma_v0_legacy {
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  103  	u32 viewport_sel;				/* 0x00f8 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  104  	struct dw_edma_v0_ch_regs ch;			/* 0x0100..0x0120 */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  105  } __packed;
7e4b8a4fbe2ceca Gustavo Pimentel 2019-06-04  106  
7e4b8a4fbe2ceca Gustavo Pimentel 2019-06-04  107  struct dw_edma_v0_regs {
7e4b8a4fbe2ceca Gustavo Pimentel 2019-06-04  108  	/* eDMA global registers */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  109  	u32 ctrl_data_arb_prior;			/* 0x0000 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  110  	u32 padding_1;					/* 0x0004 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  111  	u32 ctrl;					/* 0x0008 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  112  	u32 wr_engine_en;				/* 0x000c */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  113  	u32 wr_doorbell;				/* 0x0010 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  114  	u32 padding_2;					/* 0x0014 */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  115  	union {
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  116  		u64 reg;				/* 0x0018..0x001c */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  117  		struct {
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  118  			u32 lsb;			/* 0x0018 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  119  			u32 msb;			/* 0x001c */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  120  		};
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  121  	} wr_ch_arb_weight;
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  122  	u32 padding_3[3];				/* 0x0020..0x0028 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  123  	u32 rd_engine_en;				/* 0x002c */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  124  	u32 rd_doorbell;				/* 0x0030 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  125  	u32 padding_4;					/* 0x0034 */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  126  	union {
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  127  		u64 reg;				/* 0x0038..0x003c */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  128  		struct {
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  129  			u32 lsb;			/* 0x0038 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  130  			u32 msb;			/* 0x003c */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  131  		};
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  132  	} rd_ch_arb_weight;
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  133  	u32 padding_5[3];				/* 0x0040..0x0048 */
7e4b8a4fbe2ceca Gustavo Pimentel 2019-06-04  134  	/* eDMA interrupts registers */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  135  	u32 wr_int_status;				/* 0x004c */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  136  	u32 padding_6;					/* 0x0050 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  137  	u32 wr_int_mask;				/* 0x0054 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  138  	u32 wr_int_clear;				/* 0x0058 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  139  	u32 wr_err_status;				/* 0x005c */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  140  	union {
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  141  		u64 reg;				/* 0x0060..0x0064 */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  142  		struct {
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  143  			u32 lsb;			/* 0x0060 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  144  			u32 msb;			/* 0x0064 */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  145  		};
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  146  	} wr_done_imwr;
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  147  	union {
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  148  		u64 reg;				/* 0x0068..0x006c */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  149  		struct {
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  150  			u32 lsb;			/* 0x0068 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  151  			u32 msb;			/* 0x006c */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  152  		};
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  153  	} wr_abort_imwr;
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  154  	u32 wr_ch01_imwr_data;				/* 0x0070 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  155  	u32 wr_ch23_imwr_data;				/* 0x0074 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  156  	u32 wr_ch45_imwr_data;				/* 0x0078 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  157  	u32 wr_ch67_imwr_data;				/* 0x007c */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  158  	u32 padding_7[4];				/* 0x0080..0x008c */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  159  	u32 wr_linked_list_err_en;			/* 0x0090 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  160  	u32 padding_8[3];				/* 0x0094..0x009c */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  161  	u32 rd_int_status;				/* 0x00a0 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  162  	u32 padding_9;					/* 0x00a4 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  163  	u32 rd_int_mask;				/* 0x00a8 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  164  	u32 rd_int_clear;				/* 0x00ac */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  165  	u32 padding_10;					/* 0x00b0 */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  166  	union {
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  167  		u64 reg;				/* 0x00b4..0x00b8 */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  168  		struct {
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  169  			u32 lsb;			/* 0x00b4 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  170  			u32 msb;			/* 0x00b8 */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  171  		};
04e0a39fc10f82a Gustavo Pimentel 2021-02-18 @172  	} rd_err_status;
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  173  	u32 padding_11[2];				/* 0x00bc..0x00c0 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  174  	u32 rd_linked_list_err_en;			/* 0x00c4 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  175  	u32 padding_12;					/* 0x00c8 */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  176  	union {
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  177  		u64 reg;				/* 0x00cc..0x00d0 */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  178  		struct {
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  179  			u32 lsb;			/* 0x00cc */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  180  			u32 msb;			/* 0x00d0 */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  181  		};
04e0a39fc10f82a Gustavo Pimentel 2021-02-18 @182  	} rd_done_imwr;
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  183  	union {
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  184  		u64 reg;				/* 0x00d4..0x00d8 */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  185  		struct {
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  186  			u32 lsb;			/* 0x00d4 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  187  			u32 msb;			/* 0x00d8 */
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  188  		};
04e0a39fc10f82a Gustavo Pimentel 2021-02-18 @189  	} rd_abort_imwr;
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  190  	u32 rd_ch01_imwr_data;				/* 0x00dc */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  191  	u32 rd_ch23_imwr_data;				/* 0x00e0 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  192  	u32 rd_ch45_imwr_data;				/* 0x00e4 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  193  	u32 rd_ch67_imwr_data;				/* 0x00e8 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  194  	u32 padding_13[4];				/* 0x00ec..0x00f8 */
7e4b8a4fbe2ceca Gustavo Pimentel 2019-06-04  195  	/* eDMA channel context grouping */
7e4b8a4fbe2ceca Gustavo Pimentel 2019-06-04  196  	union dw_edma_v0_type {
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  197  		struct dw_edma_v0_legacy legacy;	/* 0x00f8..0x0120 */
b79f17517ad8c92 Gustavo Pimentel 2021-02-18  198  		struct dw_edma_v0_unroll unroll;	/* 0x00f8..0x1120 */
7e4b8a4fbe2ceca Gustavo Pimentel 2019-06-04  199  	} type;
04e0a39fc10f82a Gustavo Pimentel 2021-02-18  200  } __packed;
7e4b8a4fbe2ceca Gustavo Pimentel 2019-06-04  201  

:::::: The code at line 37 was first introduced by commit
:::::: 04e0a39fc10f82a71b84af73351333b184cee578 dmaengine: dw-edma: Add writeq() and readq() for 64 bits architectures

:::::: TO: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
:::::: CC: Vinod Koul <vkoul@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
