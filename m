Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54336E348D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 02:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjDPAFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 20:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDPAFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 20:05:02 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C302689
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 17:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681603500; x=1713139500;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JgFs7KIQMJ8PjqwX16Fc7qpGewozz09tLqQlWq91/uY=;
  b=guvDzjE9v3GhIwklL65sVg7VC/9TQC2nhlG+MH9PFBxrmUylzG/YuJHM
   lXnFkqlkQKaKmmwG23gTkNIBFxQNoCZvZM4LS1O5q7ser+9KtuVkIV4cl
   WWwU3FgLWBD6fRG52M+2dv/T2SMJA6KNcjQVA85iV/RaGawpimBj0wf+w
   tkOydXxIdR835BspDfFMyth+jFK4RJhhS6A0tq7fs6Q7pxVqQPmLUgus9
   XTZvV2MPlRCLNSXC24wiRuz9+WdmNd4sGck0mhPA6rJg1f44lLKQsCVYU
   OqPutiPA0kb0L9BV+2sBl/yzDqsyY8kwrlqmlrVRdNtH5QD9/vf8siVHp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10681"; a="407578015"
X-IronPort-AV: E=Sophos;i="5.99,201,1677571200"; 
   d="scan'208";a="407578015"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2023 17:04:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10681"; a="692850873"
X-IronPort-AV: E=Sophos;i="5.99,201,1677571200"; 
   d="scan'208";a="692850873"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 15 Apr 2023 17:04:56 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pnpt2-000bQb-2r;
        Sun, 16 Apr 2023 00:04:56 +0000
Date:   Sun, 16 Apr 2023 08:04:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [tip:irq/urgent 1/1] drivers/pci/msi/msi.c:763:18: error: use of
 undeclared identifier 'nvec'; did you mean 'nvev'?
Message-ID: <202304160832.bMSgCZQD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
head:   84d9651e13fb9820041d19262a55906851524c0f
commit: 84d9651e13fb9820041d19262a55906851524c0f [1/1] PCI/MSI: Remove over-zealous hardware size check in pci_msix_validate_entries()
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20230416/202304160832.bMSgCZQD-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=84d9651e13fb9820041d19262a55906851524c0f
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip irq/urgent
        git checkout 84d9651e13fb9820041d19262a55906851524c0f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/pci/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304160832.bMSgCZQD-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/msi/msi.c:763:18: error: use of undeclared identifier 'nvec'; did you mean 'nvev'?
           for (i = 0; i < nvec; i++) {
                           ^~~~
                           nvev
   drivers/pci/msi/msi.c:753:92: note: 'nvev' declared here
   static bool pci_msix_validate_entries(struct pci_dev *dev, struct msix_entry *entries, int nvev)
                                                                                              ^
   drivers/pci/msi/msi.c:765:23: error: use of undeclared identifier 'nvec'; did you mean 'nvev'?
                   for (j = i + 1; j < nvec; j++) {
                                       ^~~~
                                       nvev
   drivers/pci/msi/msi.c:753:92: note: 'nvev' declared here
   static bool pci_msix_validate_entries(struct pci_dev *dev, struct msix_entry *entries, int nvev)
                                                                                              ^
   2 errors generated.


vim +763 drivers/pci/msi/msi.c

^1da177e4c3f41 drivers/pci/msi.c     Linus Torvalds    2005-04-16  752  
84d9651e13fb98 drivers/pci/msi/msi.c Thomas Gleixner   2023-04-10  753  static bool pci_msix_validate_entries(struct pci_dev *dev, struct msix_entry *entries, int nvev)
^1da177e4c3f41 drivers/pci/msi.c     Linus Torvalds    2005-04-16  754  {
4644d22eb673f1 drivers/pci/msi/msi.c Thomas Gleixner   2022-11-11  755  	bool nogap;
ded86d8d37736d drivers/pci/msi.c     Eric W. Biederman 2007-01-28  756  	int i, j;
^1da177e4c3f41 drivers/pci/msi.c     Linus Torvalds    2005-04-16  757  
bab65e48cb064d drivers/pci/msi/msi.c Thomas Gleixner   2022-11-11  758  	if (!entries)
bab65e48cb064d drivers/pci/msi/msi.c Thomas Gleixner   2022-11-11  759  		return true;
^1da177e4c3f41 drivers/pci/msi.c     Linus Torvalds    2005-04-16  760  
4644d22eb673f1 drivers/pci/msi/msi.c Thomas Gleixner   2022-11-11  761  	nogap = pci_msi_domain_supports(dev, MSI_FLAG_MSIX_CONTIGUOUS, DENY_LEGACY);
4644d22eb673f1 drivers/pci/msi/msi.c Thomas Gleixner   2022-11-11  762  
^1da177e4c3f41 drivers/pci/msi.c     Linus Torvalds    2005-04-16 @763  	for (i = 0; i < nvec; i++) {
bab65e48cb064d drivers/pci/msi/msi.c Thomas Gleixner   2022-11-11  764  		/* Check for duplicate entries */
^1da177e4c3f41 drivers/pci/msi.c     Linus Torvalds    2005-04-16  765  		for (j = i + 1; j < nvec; j++) {
^1da177e4c3f41 drivers/pci/msi.c     Linus Torvalds    2005-04-16  766  			if (entries[i].entry == entries[j].entry)
bab65e48cb064d drivers/pci/msi/msi.c Thomas Gleixner   2022-11-11  767  				return false;
^1da177e4c3f41 drivers/pci/msi.c     Linus Torvalds    2005-04-16  768  		}
4644d22eb673f1 drivers/pci/msi/msi.c Thomas Gleixner   2022-11-11  769  		/* Check for unsupported gaps */
4644d22eb673f1 drivers/pci/msi/msi.c Thomas Gleixner   2022-11-11  770  		if (nogap && entries[i].entry != i)
4644d22eb673f1 drivers/pci/msi/msi.c Thomas Gleixner   2022-11-11  771  			return false;
^1da177e4c3f41 drivers/pci/msi.c     Linus Torvalds    2005-04-16  772  	}
bab65e48cb064d drivers/pci/msi/msi.c Thomas Gleixner   2022-11-11  773  	return true;
3ac020e0ca8bef drivers/pci/msi.c     Christoph Hellwig 2016-07-12  774  }
7bd007e480672c drivers/pci/msi.c     Eric W. Biederman 2006-10-04  775  

:::::: The code at line 763 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
