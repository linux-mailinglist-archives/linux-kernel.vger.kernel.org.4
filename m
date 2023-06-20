Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CCA736A3E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjFTLFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 07:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjFTLFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:05:17 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20CF10D0;
        Tue, 20 Jun 2023 04:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687259115; x=1718795115;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CFfmNUAntTgVTL9R7eCjpkwcwWfVQildYIuC0qhS0VI=;
  b=NctgNbIRABYxPFVJoDfn7zT9VcNpekbMfF1yvvcxBpxblp1nj4Imh1mi
   yySPBu9sIZufleaPcEVjkTBTII+7fCPe7y/aOF/JMdiysIHupZTRfBKvl
   54UkBy5wfY7QPHeJ4tA4ZEZ/wznnZO/LXHjp9mEkUA3A/oVVebpFCmjqF
   jJ7lkiqHWVLVhLxq86rYYywE+mVNq6/t8fVSccq3cfmngyDf2p8dML7Oz
   05QPLylK6BWRq+4LQdIgfmH9H03OI4W2dRMkZ6YzOnTu5DoflFLn86Dz7
   5GtYFCDy/H3JLr7eu5/wcJlAoQZkLLULNDEvk1LZ/zePkocDFO9QRW9LN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="362372231"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="362372231"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 04:05:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="664242800"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="664242800"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 20 Jun 2023 04:05:13 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qBZAe-0005pa-0t;
        Tue, 20 Jun 2023 11:05:12 +0000
Date:   Tue, 20 Jun 2023 19:04:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jyan Chou <jyanchou@realtek.com>, jh80.chung@samsung.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, jyanchou@realtek.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.tai@realtek.com
Subject: Re: [PATCH] CMDQ feature is introduced to eMMC standard in v5.1,
 which can be used to improve performance.
Message-ID: <202306201816.tTRpHo0c-lkp@intel.com>
References: <20230616063731.17591-1-jyanchou@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616063731.17591-1-jyanchou@realtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jyan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.4-rc7 next-20230620]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jyan-Chou/CMDQ-feature-is-introduced-to-eMMC-standard-in-v5-1-which-can-be-used-to-improve-performance/20230616-143849
base:   linus/master
patch link:    https://lore.kernel.org/r/20230616063731.17591-1-jyanchou%40realtek.com
patch subject: [PATCH] CMDQ feature is introduced to eMMC standard in v5.1, which can be used to improve performance.
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20230620/202306201816.tTRpHo0c-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230620/202306201816.tTRpHo0c-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306201816.tTRpHo0c-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/mmc/host/dw_mmc_cqe.c:39:
>> drivers/mmc/host/dw_mmc_cqe.h:321: warning: "END" redefined
     321 | #define END(x)                          ((x & 1) << 1)
         | 
   In file included from arch/mips/include/asm/bitops.h:19,
                    from include/linux/bitops.h:68,
                    from drivers/mmc/host/dw_mmc_cqe.c:9:
   arch/mips/include/asm/asm.h:69: note: this is the location of the previous definition
      69 | #define END(function)                                   \
         | 
   drivers/mmc/host/dw_mmc_cqe.c:232:10: error: 'const struct cqhci_host_ops' has no member named 'setup_tran_desc'
     232 |         .setup_tran_desc = dw_mci_cqe_setup_tran_desc,
         |          ^~~~~~~~~~~~~~~
   drivers/mmc/host/dw_mmc_cqe.c:232:28: error: positional initialization of field in 'struct' declared with 'designated_init' attribute [-Werror=designated-init]
     232 |         .setup_tran_desc = dw_mci_cqe_setup_tran_desc,
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/host/dw_mmc_cqe.c:232:28: note: (near initialization for 'dw_mci_cqhci_host_ops')
   drivers/mmc/host/dw_mmc_cqe.c:232:28: error: initialization of 'void (*)(struct mmc_host *)' from incompatible pointer type 'void (*)(struct mmc_data *, struct cqhci_host *, u8 *, int)' {aka 'void (*)(struct mmc_data *, struct cqhci_host *, unsigned char *, int)'} [-Werror=incompatible-pointer-types]
   drivers/mmc/host/dw_mmc_cqe.c:232:28: note: (near initialization for 'dw_mci_cqhci_host_ops.pre_enable')
   drivers/mmc/host/dw_mmc_cqe.c: In function 'dw_mci_cqe_read_rsp':
>> drivers/mmc/host/dw_mmc_cqe.c:283:37: warning: variable 'rsp_tmp' set but not used [-Wunused-but-set-variable]
     283 |                                 u32 rsp_tmp[4];
         |                                     ^~~~~~~
   drivers/mmc/host/dw_mmc_cqe.c: In function 'dw_mci_cqe_err_handle':
>> drivers/mmc/host/dw_mmc_cqe.c:766:41: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     766 |                                         if (err == -DW_MCI_NOT_READY)
         |                                         ^~
   drivers/mmc/host/dw_mmc_cqe.c:769:49: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     769 |                                                 break;
         |                                                 ^~~~~
   In file included from include/linux/debugfs.h:16,
                    from drivers/mmc/host/dw_mmc_cqe.c:12:
   drivers/mmc/host/dw_mmc_cqe.c: At top level:
   drivers/mmc/host/dw_mmc_cqe.c:97:23: warning: 'dw_mci_cqe_req_fops' defined but not used [-Wunused-const-variable=]
      97 | DEFINE_SHOW_ATTRIBUTE(dw_mci_cqe_req);
         |                       ^~~~~~~~~~~~~~
   include/linux/seq_file.h:202:37: note: in definition of macro 'DEFINE_SHOW_ATTRIBUTE'
     202 | static const struct file_operations __name ## _fops = {                 \
         |                                     ^~~~~~
   cc1: some warnings being treated as errors


vim +/END +321 drivers/mmc/host/dw_mmc_cqe.h

   319	
   320	#define VALID(x)			((x & 1) << 0)
 > 321	#define END(x)				((x & 1) << 1)
   322	#define INT(x)				((x & 1) << 2)
   323	#define ACT(x)				((x & 0x7) << 3)
   324	#define DAT_LENGTH(x)			((x & 0xFFFF) << 16)
   325	
   326	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
