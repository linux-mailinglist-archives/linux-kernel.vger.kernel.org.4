Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096C7691C16
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjBJKAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjBJKAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:00:37 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C372A9BF;
        Fri, 10 Feb 2023 02:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676023235; x=1707559235;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ViWZMNZSsxLFXG6UH5/npJ+Pnp9/XOhtNAnBp28zA9c=;
  b=giznPBby7IoOPxgRPdU2qI++/DwdMFBVGBI42EDlsRmE2qURlkdU7COD
   2qPzEzRosS+GEn3nhXc6DjIze6b6CjA/CmPbF13OM9TT55bhJo3DJC4FJ
   iQ0tMXzSNYv3m3mBp/DTDixkZ0qZ3EjQ/VnQd9+GFMrmmyAOOFH7jBgs4
   vfUxsi8VWGRDRehdrnTA+Bl3eRf3T+LWmQ8EfqfPW2jSt5a5CntxcDAIg
   lPflmKXnF2eavUI6QY0Zq9YvvF6PL7GIDXRHylo8LLqKPi4LJmWoZerfM
   G5s4cUu0BFOyc8nKBoUm6cHTVG2OIHsuwGY4eCQRn+yTZSXaXEA3ZQZAq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="314027983"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="314027983"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 02:00:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="661355215"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="661355215"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 10 Feb 2023 02:00:32 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQQCm-0005jj-0X;
        Fri, 10 Feb 2023 10:00:32 +0000
Date:   Fri, 10 Feb 2023 18:00:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: drivers/ata/pata_octeon_cf.c:383: warning: expecting prototype for
 Read the taskfile for 16bit non(). Prototype was for octeon_cf_tf_read16()
 instead
Message-ID: <202302101722.5O56RClE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   38c1e0c65865426676123cc9a127526fa02bcac6
commit: 52042e2db45290f6a512d525518488b7bf143531 scripts: kernel-doc: validate kernel-doc markup with the actual names
date:   2 years, 1 month ago
config: mips-randconfig-r022-20230210 (https://download.01.org/0day-ci/archive/20230210/202302101722.5O56RClE-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=52042e2db45290f6a512d525518488b7bf143531
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 52042e2db45290f6a512d525518488b7bf143531
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/ata/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302101722.5O56RClE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/ata/pata_octeon_cf.c:75: warning: Function parameter or member 'tim_mult' not described in 'ns_to_tim_reg'
   drivers/ata/pata_octeon_cf.c:75: warning: Function parameter or member 'nsecs' not described in 'ns_to_tim_reg'
   drivers/ata/pata_octeon_cf.c:75: warning: expecting prototype for Convert nanosecond based time to setting used in the(). Prototype was for ns_to_tim_reg() instead
   drivers/ata/pata_octeon_cf.c:130: warning: expecting prototype for This(). Prototype was for octeon_cf_set_piomode() instead
   drivers/ata/pata_octeon_cf.c:286: warning: wrong kernel-doc identifier on line:
    * Handle an 8 bit I/O request.
   drivers/ata/pata_octeon_cf.c:325: warning: wrong kernel-doc identifier on line:
    * Handle a 16 bit I/O request.
   drivers/ata/pata_octeon_cf.c:383: warning: Function parameter or member 'ap' not described in 'octeon_cf_tf_read16'
   drivers/ata/pata_octeon_cf.c:383: warning: Function parameter or member 'tf' not described in 'octeon_cf_tf_read16'
>> drivers/ata/pata_octeon_cf.c:383: warning: expecting prototype for Read the taskfile for 16bit non(). Prototype was for octeon_cf_tf_read16() instead
   drivers/ata/pata_octeon_cf.c:468: warning: Function parameter or member 'ap' not described in 'octeon_cf_tf_load16'
   drivers/ata/pata_octeon_cf.c:468: warning: Function parameter or member 'tf' not described in 'octeon_cf_tf_load16'
>> drivers/ata/pata_octeon_cf.c:468: warning: expecting prototype for Load the taskfile for 16bit non(). Prototype was for octeon_cf_tf_load16() instead
   drivers/ata/pata_octeon_cf.c:560: warning: expecting prototype for Start a DMA transfer that was already setup(). Prototype was for octeon_cf_dma_start() instead
   drivers/ata/pata_octeon_cf.c:616: warning: Cannot understand  *
    on line 616 - I thought it was a doc line


vim +383 drivers/ata/pata_octeon_cf.c

3c929c6f5aa750 David Daney 2009-01-15  378  
3c929c6f5aa750 David Daney 2009-01-15  379  /**
3c929c6f5aa750 David Daney 2009-01-15  380   * Read the taskfile for 16bit non-True IDE only.
3c929c6f5aa750 David Daney 2009-01-15  381   */
3c929c6f5aa750 David Daney 2009-01-15  382  static void octeon_cf_tf_read16(struct ata_port *ap, struct ata_taskfile *tf)
3c929c6f5aa750 David Daney 2009-01-15 @383  {
3c929c6f5aa750 David Daney 2009-01-15  384  	u16 blob;
3c929c6f5aa750 David Daney 2009-01-15  385  	/* The base of the registers is at ioaddr.data_addr. */
3c929c6f5aa750 David Daney 2009-01-15  386  	void __iomem *base = ap->ioaddr.data_addr;
3c929c6f5aa750 David Daney 2009-01-15  387  
3c929c6f5aa750 David Daney 2009-01-15  388  	blob = __raw_readw(base + 0xc);
3c929c6f5aa750 David Daney 2009-01-15  389  	tf->feature = blob >> 8;
3c929c6f5aa750 David Daney 2009-01-15  390  
3c929c6f5aa750 David Daney 2009-01-15  391  	blob = __raw_readw(base + 2);
3c929c6f5aa750 David Daney 2009-01-15  392  	tf->nsect = blob & 0xff;
3c929c6f5aa750 David Daney 2009-01-15  393  	tf->lbal = blob >> 8;
3c929c6f5aa750 David Daney 2009-01-15  394  
3c929c6f5aa750 David Daney 2009-01-15  395  	blob = __raw_readw(base + 4);
3c929c6f5aa750 David Daney 2009-01-15  396  	tf->lbam = blob & 0xff;
3c929c6f5aa750 David Daney 2009-01-15  397  	tf->lbah = blob >> 8;
3c929c6f5aa750 David Daney 2009-01-15  398  
3c929c6f5aa750 David Daney 2009-01-15  399  	blob = __raw_readw(base + 6);
3c929c6f5aa750 David Daney 2009-01-15  400  	tf->device = blob & 0xff;
3c929c6f5aa750 David Daney 2009-01-15  401  	tf->command = blob >> 8;
3c929c6f5aa750 David Daney 2009-01-15  402  
3c929c6f5aa750 David Daney 2009-01-15  403  	if (tf->flags & ATA_TFLAG_LBA48) {
3c929c6f5aa750 David Daney 2009-01-15  404  		if (likely(ap->ioaddr.ctl_addr)) {
3c929c6f5aa750 David Daney 2009-01-15  405  			iowrite8(tf->ctl | ATA_HOB, ap->ioaddr.ctl_addr);
3c929c6f5aa750 David Daney 2009-01-15  406  
3c929c6f5aa750 David Daney 2009-01-15  407  			blob = __raw_readw(base + 0xc);
3c929c6f5aa750 David Daney 2009-01-15  408  			tf->hob_feature = blob >> 8;
3c929c6f5aa750 David Daney 2009-01-15  409  
3c929c6f5aa750 David Daney 2009-01-15  410  			blob = __raw_readw(base + 2);
3c929c6f5aa750 David Daney 2009-01-15  411  			tf->hob_nsect = blob & 0xff;
3c929c6f5aa750 David Daney 2009-01-15  412  			tf->hob_lbal = blob >> 8;
3c929c6f5aa750 David Daney 2009-01-15  413  
3c929c6f5aa750 David Daney 2009-01-15  414  			blob = __raw_readw(base + 4);
3c929c6f5aa750 David Daney 2009-01-15  415  			tf->hob_lbam = blob & 0xff;
3c929c6f5aa750 David Daney 2009-01-15  416  			tf->hob_lbah = blob >> 8;
3c929c6f5aa750 David Daney 2009-01-15  417  
3c929c6f5aa750 David Daney 2009-01-15  418  			iowrite8(tf->ctl, ap->ioaddr.ctl_addr);
3c929c6f5aa750 David Daney 2009-01-15  419  			ap->last_ctl = tf->ctl;
3c929c6f5aa750 David Daney 2009-01-15  420  		} else {
3c929c6f5aa750 David Daney 2009-01-15  421  			WARN_ON(1);
3c929c6f5aa750 David Daney 2009-01-15  422  		}
3c929c6f5aa750 David Daney 2009-01-15  423  	}
3c929c6f5aa750 David Daney 2009-01-15  424  }
3c929c6f5aa750 David Daney 2009-01-15  425  
3c929c6f5aa750 David Daney 2009-01-15  426  static u8 octeon_cf_check_status16(struct ata_port *ap)
3c929c6f5aa750 David Daney 2009-01-15  427  {
3c929c6f5aa750 David Daney 2009-01-15  428  	u16 blob;
3c929c6f5aa750 David Daney 2009-01-15  429  	void __iomem *base = ap->ioaddr.data_addr;
3c929c6f5aa750 David Daney 2009-01-15  430  
3c929c6f5aa750 David Daney 2009-01-15  431  	blob = __raw_readw(base + 6);
3c929c6f5aa750 David Daney 2009-01-15  432  	return blob >> 8;
3c929c6f5aa750 David Daney 2009-01-15  433  }
3c929c6f5aa750 David Daney 2009-01-15  434  
3c929c6f5aa750 David Daney 2009-01-15  435  static int octeon_cf_softreset16(struct ata_link *link, unsigned int *classes,
3c929c6f5aa750 David Daney 2009-01-15  436  				 unsigned long deadline)
3c929c6f5aa750 David Daney 2009-01-15  437  {
3c929c6f5aa750 David Daney 2009-01-15  438  	struct ata_port *ap = link->ap;
3c929c6f5aa750 David Daney 2009-01-15  439  	void __iomem *base = ap->ioaddr.data_addr;
3c929c6f5aa750 David Daney 2009-01-15  440  	int rc;
3c929c6f5aa750 David Daney 2009-01-15  441  	u8 err;
3c929c6f5aa750 David Daney 2009-01-15  442  
3c929c6f5aa750 David Daney 2009-01-15  443  	DPRINTK("about to softreset\n");
3c929c6f5aa750 David Daney 2009-01-15  444  	__raw_writew(ap->ctl, base + 0xe);
3c929c6f5aa750 David Daney 2009-01-15  445  	udelay(20);
3c929c6f5aa750 David Daney 2009-01-15  446  	__raw_writew(ap->ctl | ATA_SRST, base + 0xe);
3c929c6f5aa750 David Daney 2009-01-15  447  	udelay(20);
3c929c6f5aa750 David Daney 2009-01-15  448  	__raw_writew(ap->ctl, base + 0xe);
3c929c6f5aa750 David Daney 2009-01-15  449  
3c929c6f5aa750 David Daney 2009-01-15  450  	rc = ata_sff_wait_after_reset(link, 1, deadline);
3c929c6f5aa750 David Daney 2009-01-15  451  	if (rc) {
a9a79dfec23956 Joe Perches 2011-04-15  452  		ata_link_err(link, "SRST failed (errno=%d)\n", rc);
3c929c6f5aa750 David Daney 2009-01-15  453  		return rc;
3c929c6f5aa750 David Daney 2009-01-15  454  	}
3c929c6f5aa750 David Daney 2009-01-15  455  
3c929c6f5aa750 David Daney 2009-01-15  456  	/* determine by signature whether we have ATA or ATAPI devices */
3c929c6f5aa750 David Daney 2009-01-15  457  	classes[0] = ata_sff_dev_classify(&link->device[0], 1, &err);
3c929c6f5aa750 David Daney 2009-01-15  458  	DPRINTK("EXIT, classes[0]=%u [1]=%u\n", classes[0], classes[1]);
3c929c6f5aa750 David Daney 2009-01-15  459  	return 0;
3c929c6f5aa750 David Daney 2009-01-15  460  }
3c929c6f5aa750 David Daney 2009-01-15  461  
3c929c6f5aa750 David Daney 2009-01-15  462  /**
3c929c6f5aa750 David Daney 2009-01-15  463   * Load the taskfile for 16bit non-True IDE only.  The device_addr is
3c929c6f5aa750 David Daney 2009-01-15  464   * not loaded, we do this as part of octeon_cf_exec_command16.
3c929c6f5aa750 David Daney 2009-01-15  465   */
3c929c6f5aa750 David Daney 2009-01-15  466  static void octeon_cf_tf_load16(struct ata_port *ap,
3c929c6f5aa750 David Daney 2009-01-15  467  				const struct ata_taskfile *tf)
3c929c6f5aa750 David Daney 2009-01-15 @468  {
3c929c6f5aa750 David Daney 2009-01-15  469  	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
3c929c6f5aa750 David Daney 2009-01-15  470  	/* The base of the registers is at ioaddr.data_addr. */
3c929c6f5aa750 David Daney 2009-01-15  471  	void __iomem *base = ap->ioaddr.data_addr;
3c929c6f5aa750 David Daney 2009-01-15  472  
3c929c6f5aa750 David Daney 2009-01-15  473  	if (tf->ctl != ap->last_ctl) {
3c929c6f5aa750 David Daney 2009-01-15  474  		iowrite8(tf->ctl, ap->ioaddr.ctl_addr);
3c929c6f5aa750 David Daney 2009-01-15  475  		ap->last_ctl = tf->ctl;
3c929c6f5aa750 David Daney 2009-01-15  476  		ata_wait_idle(ap);
3c929c6f5aa750 David Daney 2009-01-15  477  	}
3c929c6f5aa750 David Daney 2009-01-15  478  	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
3c929c6f5aa750 David Daney 2009-01-15  479  		__raw_writew(tf->hob_feature << 8, base + 0xc);
3c929c6f5aa750 David Daney 2009-01-15  480  		__raw_writew(tf->hob_nsect | tf->hob_lbal << 8, base + 2);
3c929c6f5aa750 David Daney 2009-01-15  481  		__raw_writew(tf->hob_lbam | tf->hob_lbah << 8, base + 4);
3c929c6f5aa750 David Daney 2009-01-15  482  		VPRINTK("hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
3c929c6f5aa750 David Daney 2009-01-15  483  			tf->hob_feature,
3c929c6f5aa750 David Daney 2009-01-15  484  			tf->hob_nsect,
3c929c6f5aa750 David Daney 2009-01-15  485  			tf->hob_lbal,
3c929c6f5aa750 David Daney 2009-01-15  486  			tf->hob_lbam,
3c929c6f5aa750 David Daney 2009-01-15  487  			tf->hob_lbah);
3c929c6f5aa750 David Daney 2009-01-15  488  	}
3c929c6f5aa750 David Daney 2009-01-15  489  	if (is_addr) {
3c929c6f5aa750 David Daney 2009-01-15  490  		__raw_writew(tf->feature << 8, base + 0xc);
3c929c6f5aa750 David Daney 2009-01-15  491  		__raw_writew(tf->nsect | tf->lbal << 8, base + 2);
3c929c6f5aa750 David Daney 2009-01-15  492  		__raw_writew(tf->lbam | tf->lbah << 8, base + 4);
3c929c6f5aa750 David Daney 2009-01-15  493  		VPRINTK("feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
3c929c6f5aa750 David Daney 2009-01-15  494  			tf->feature,
3c929c6f5aa750 David Daney 2009-01-15  495  			tf->nsect,
3c929c6f5aa750 David Daney 2009-01-15  496  			tf->lbal,
3c929c6f5aa750 David Daney 2009-01-15  497  			tf->lbam,
3c929c6f5aa750 David Daney 2009-01-15  498  			tf->lbah);
3c929c6f5aa750 David Daney 2009-01-15  499  	}
3c929c6f5aa750 David Daney 2009-01-15  500  	ata_wait_idle(ap);
3c929c6f5aa750 David Daney 2009-01-15  501  }
3c929c6f5aa750 David Daney 2009-01-15  502  

:::::: The code at line 383 was first introduced by commit
:::::: 3c929c6f5aa7501790586a38dd8faca8fed9a158 libata: New driver for OCTEON SOC Compact Flash interface (v7).

:::::: TO: David Daney <ddaney@caviumnetworks.com>
:::::: CC: Jeff Garzik <jgarzik@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
