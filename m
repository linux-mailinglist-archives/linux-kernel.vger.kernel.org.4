Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8837734461
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 00:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbjFQWc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 18:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjFQWc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 18:32:57 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F5A10C9
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 15:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687041175; x=1718577175;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/4w5GHjcc0Rw0RGeZhXuEg8WDdISXO3VmVWgd31VMVo=;
  b=VpmBSz2F9fZTbws4ol0z/9B06Sx42HqPR+4tN3OGvFS+F58/GsDB6r3O
   VZXwD634IW9Xj0wKpgMPbc5x6Ds0M7KuTzJMEmlQdA03KAslGgLC+nsKb
   nzpqwHxwc2EDX3mNFgwjChiHgPubiM/mM8IgDRq/Ey2hpv4GnKm9MZvGf
   9YKr1sLQzmzNIF8uRACdGSaTdFZuG95MdROY020Zlt2rPryhd3VOWjRqf
   bBq4xvEJnap+D9rb/Z6nV75nOln+jH3ijthRF1SkbYuzoAw7x1B/B938M
   eJXC0r/LlO3RkN6th/6afhFAhBmrPjAyExj6VNRjlF7WCpAJJDm2X8MbQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10744"; a="362847296"
X-IronPort-AV: E=Sophos;i="6.00,251,1681196400"; 
   d="scan'208";a="362847296"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2023 15:32:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10744"; a="857784065"
X-IronPort-AV: E=Sophos;i="6.00,251,1681196400"; 
   d="scan'208";a="857784065"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jun 2023 15:32:53 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qAeTU-0003Ay-1t;
        Sat, 17 Jun 2023 22:32:52 +0000
Date:   Sun, 18 Jun 2023 06:32:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vineet Gupta <vgupta@kernel.org>
Subject: drivers/scsi/hptiop.c:643:34: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202306180605.3ls3bvu7-lkp@intel.com>
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

Hi Randy,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1b29d271614abd97cc39782daa9d6dd70e98609f
commit: c44f15c1c09481d50fd33478ebb5b8284f8f5edb arc: iounmap() arg is volatile
date:   8 months ago
config: arc-randconfig-s051-20230618 (https://download.01.org/0day-ci/archive/20230618/202306180605.3ls3bvu7-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230618/202306180605.3ls3bvu7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306180605.3ls3bvu7-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/scsi/hptiop.c:150:53: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:171:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:171:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:171:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:208:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:208:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:208:18: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:209:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:209:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:209:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:244:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] result @@     got int @@
   drivers/scsi/hptiop.c:244:44: sparse:     expected restricted __le32 [usertype] result
   drivers/scsi/hptiop.c:244:44: sparse:     got int
   drivers/scsi/hptiop.c:289:35: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:276:32: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:277:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] cur_rptr @@     got restricted __le32 [usertype] outlist_rptr @@
   drivers/scsi/hptiop.c:277:34: sparse:     expected unsigned int [usertype] cur_rptr
   drivers/scsi/hptiop.c:277:34: sparse:     got restricted __le32 [usertype] outlist_rptr
   drivers/scsi/hptiop.c:283:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] _tag @@     got restricted __le32 [usertype] val @@
   drivers/scsi/hptiop.c:283:38: sparse:     expected unsigned int [usertype] _tag
   drivers/scsi/hptiop.c:283:38: sparse:     got restricted __le32 [usertype] val
   drivers/scsi/hptiop.c:288:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] outlist_rptr @@     got unsigned int [assigned] [usertype] cur_rptr @@
   drivers/scsi/hptiop.c:288:52: sparse:     expected restricted __le32 [usertype] outlist_rptr
   drivers/scsi/hptiop.c:288:52: sparse:     got unsigned int [assigned] [usertype] cur_rptr
   drivers/scsi/hptiop.c:369:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:369:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:369:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:370:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:370:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:370:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:453:64: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct hpt_iop_request_get_config *info @@     got struct hpt_iop_request_get_config [noderef] __iomem *config @@
   drivers/scsi/hptiop.c:453:64: sparse:     expected struct hpt_iop_request_get_config *info
   drivers/scsi/hptiop.c:453:64: sparse:     got struct hpt_iop_request_get_config [noderef] __iomem *config
   drivers/scsi/hptiop.c:455:25: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:557:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:557:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:557:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:637:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct hpt_iopmv_regs *regs @@     got void [noderef] __iomem * @@
   drivers/scsi/hptiop.c:637:24: sparse:     expected struct hpt_iopmv_regs *regs
   drivers/scsi/hptiop.c:637:24: sparse:     got void [noderef] __iomem *
>> drivers/scsi/hptiop.c:643:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got struct hpt_iopmv_regs *regs @@
   drivers/scsi/hptiop.c:643:34: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:643:34: sparse:     got struct hpt_iopmv_regs *regs
   drivers/scsi/hptiop.c:667:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got struct hpt_iopmv_regs *regs @@
   drivers/scsi/hptiop.c:667:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:667:26: sparse:     got struct hpt_iopmv_regs *regs
   drivers/scsi/hptiop.c:933:27: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:938:34: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:939:30: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:943:43: sparse: sparse: invalid assignment: &=
   drivers/scsi/hptiop.c:943:43: sparse:    left side has type restricted __le32
   drivers/scsi/hptiop.c:943:43: sparse:    right side has type int
   drivers/scsi/hptiop.c:944:43: sparse: sparse: invalid assignment: ^=
   drivers/scsi/hptiop.c:944:43: sparse:    left side has type restricted __le32
   drivers/scsi/hptiop.c:944:43: sparse:    right side has type int
   drivers/scsi/hptiop.c:949:57: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:949:48: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] intrfc_len @@     got unsigned int @@
   drivers/scsi/hptiop.c:949:48: sparse:     expected restricted __le32 [usertype] intrfc_len
   drivers/scsi/hptiop.c:949:48: sparse:     got unsigned int
   drivers/scsi/hptiop.c:950:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:975:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:977:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:980:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:982:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:985:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:987:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:990:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] inlist_wptr @@     got unsigned int @@
   drivers/scsi/hptiop.c:990:35: sparse:     expected restricted __le32 [usertype] inlist_wptr
   drivers/scsi/hptiop.c:990:35: sparse:     got unsigned int
   drivers/scsi/hptiop.c:991:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] @@     got unsigned int @@
   drivers/scsi/hptiop.c:991:37: sparse:     expected restricted __le32 [usertype]
   drivers/scsi/hptiop.c:991:37: sparse:     got unsigned int
   drivers/scsi/hptiop.c:992:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] outlist_rptr @@     got unsigned int @@
   drivers/scsi/hptiop.c:992:36: sparse:     expected restricted __le32 [usertype] outlist_rptr
   drivers/scsi/hptiop.c:992:36: sparse:     got unsigned int
   drivers/scsi/hptiop.c:1531:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:1531:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:1531:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:1532:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:1532:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:1532:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:150:51: sparse: sparse: dereference of noderef expression
   drivers/scsi/hptiop.c:150:51: sparse: sparse: dereference of noderef expression

vim +643 drivers/scsi/hptiop.c

00f5970193e22c4 HighPoint Linux Team 2007-12-13  634  
00f5970193e22c4 HighPoint Linux Team 2007-12-13  635  static int hptiop_map_pci_bar_mv(struct hptiop_hba *hba)
00f5970193e22c4 HighPoint Linux Team 2007-12-13  636  {
00f5970193e22c4 HighPoint Linux Team 2007-12-13  637  	hba->u.mv.regs = hptiop_map_pci_bar(hba, 0);
9bcf091083065c7 Harvey Harrison      2008-05-22  638  	if (hba->u.mv.regs == NULL)
00f5970193e22c4 HighPoint Linux Team 2007-12-13  639  		return -1;
00f5970193e22c4 HighPoint Linux Team 2007-12-13  640  
00f5970193e22c4 HighPoint Linux Team 2007-12-13  641  	hba->u.mv.mu = hptiop_map_pci_bar(hba, 2);
9bcf091083065c7 Harvey Harrison      2008-05-22  642  	if (hba->u.mv.mu == NULL) {
00f5970193e22c4 HighPoint Linux Team 2007-12-13 @643  		iounmap(hba->u.mv.regs);
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  644  		return -1;
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  645  	}
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  646  
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  647  	return 0;
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  648  }
ede1e6f8b43246a HighPoint Linux Team 2006-05-16  649  

:::::: The code at line 643 was first introduced by commit
:::::: 00f5970193e22c48f399a2430635d6416b51befe [SCSI] hptiop: add more adapter models and other fixes

:::::: TO: HighPoint Linux Team <linux@highpoint-tech.com>
:::::: CC: James Bottomley <James.Bottomley@HansenPartnership.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
