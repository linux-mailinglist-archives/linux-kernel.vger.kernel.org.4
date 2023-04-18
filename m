Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66A56E6668
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjDRNxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjDRNxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:53:49 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A789EDE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681826028; x=1713362028;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PmvTPh2yJEJPklH4b3KvZ5Pdr4+q5eEYF+gMvcj/pls=;
  b=JCGYlISRxH5gWkfsPodjeKmMyfmBdYtfYAQizm6Fb9+X/hyANy+aBsTU
   osAGvvuOM0znEHV4z+/UaGr2H168oBiZZUuhRDkNRckleTLApVhJ1plDg
   bi+uzjG4EPp3Eq4n2meODpUBqLNfmzy1/oV7fwjR6YnUcQklPyH/j/vAK
   IZqL98IOAHw/Pmq3tqWW7uMF7kxxOwH479ihh0j22CTZ4Ddf/Ga5C1u2t
   3wxmFA8PPDJO6IbjA1iBJ9Kz7oIsyeH3tci6Xdv3lQmgSteyzJL41Xfe4
   Lln4I9DoxFXQcgU1Nr4zs8I9sj5ilJMGtWNjG8B9Rkk6BgfrvbLJcVDwJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="408074030"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="408074030"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 06:53:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="937259187"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="937259187"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 18 Apr 2023 06:53:46 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1polmD-000dZ1-2E;
        Tue, 18 Apr 2023 13:53:45 +0000
Date:   Tue, 18 Apr 2023 21:52:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/atm/iphase.c:151 ia_hack_tcq() warn: if();
Message-ID: <202304182100.xKJSzynK-lkp@intel.com>
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
head:   6a8f57ae2eb07ab39a6f0ccad60c760743051026
commit: ded2ee36313c941f1a12b6f85cde295b575264ae openrisc: Add pci bus support
date:   9 months ago
config: openrisc-randconfig-m031-20230416 (https://download.01.org/0day-ci/archive/20230418/202304182100.xKJSzynK-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304182100.xKJSzynK-lkp@intel.com/

New smatch warnings:
drivers/atm/iphase.c:151 ia_hack_tcq() warn: if();
drivers/atm/iphase.c:562 ia_cbr_setup() warn: inconsistent indenting
drivers/atm/iphase.c:695 ia_tx_poll() warn: inconsistent indenting
drivers/atm/iphase.c:1247 rx_intr() warn: inconsistent indenting
drivers/atm/iphase.c:1558 rx_init() warn: inconsistent indenting
drivers/atm/iphase.c:1763 open_tx() warn: inconsistent indenting
drivers/atm/iphase.c:2553 ia_start() warn: inconsistent indenting
drivers/atm/iphase.c:2766 ia_ioctl() warn: inconsistent indenting
drivers/atm/iphase.c:2911 ia_pkt_tx() warn: inconsistent indenting

Old smatch warnings:
drivers/atm/iphase.c:2870 ia_ioctl() warn: inconsistent indenting

vim +151 drivers/atm/iphase.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  143  
^1da177e4c3f41 Linus Torvalds 2005-04-16  144    u_short 		desc1;
^1da177e4c3f41 Linus Torvalds 2005-04-16  145    u_short		tcq_wr;
^1da177e4c3f41 Linus Torvalds 2005-04-16  146    struct ia_vcc         *iavcc_r = NULL; 
^1da177e4c3f41 Linus Torvalds 2005-04-16  147  
^1da177e4c3f41 Linus Torvalds 2005-04-16  148    tcq_wr = readl(dev->seg_reg+TCQ_WR_PTR) & 0xffff;
^1da177e4c3f41 Linus Torvalds 2005-04-16  149    while (dev->host_tcq_wr != tcq_wr) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  150       desc1 = *(u_short *)(dev->seg_ram + dev->host_tcq_wr);
^1da177e4c3f41 Linus Torvalds 2005-04-16 @151       if (!desc1) ;
^1da177e4c3f41 Linus Torvalds 2005-04-16  152       else if (!dev->desc_tbl[desc1 -1].timestamp) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  153          IF_ABR(printk(" Desc %d is reset at %ld\n", desc1 -1, jiffies);)
^1da177e4c3f41 Linus Torvalds 2005-04-16  154          *(u_short *) (dev->seg_ram + dev->host_tcq_wr) = 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  155       }                                 
^1da177e4c3f41 Linus Torvalds 2005-04-16  156       else if (dev->desc_tbl[desc1 -1].timestamp) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  157          if (!(iavcc_r = dev->desc_tbl[desc1 -1].iavcc)) { 
^1da177e4c3f41 Linus Torvalds 2005-04-16  158             printk("IA: Fatal err in get_desc\n");
^1da177e4c3f41 Linus Torvalds 2005-04-16  159             continue;
^1da177e4c3f41 Linus Torvalds 2005-04-16  160          }
^1da177e4c3f41 Linus Torvalds 2005-04-16  161          iavcc_r->vc_desc_cnt--;
^1da177e4c3f41 Linus Torvalds 2005-04-16  162          dev->desc_tbl[desc1 -1].timestamp = 0;
849e8caa477d72 David Howells  2008-07-30  163          IF_EVENT(printk("ia_hack: return_q skb = 0x%p desc = %d\n",
849e8caa477d72 David Howells  2008-07-30  164                                     dev->desc_tbl[desc1 -1].txskb, desc1);)
^1da177e4c3f41 Linus Torvalds 2005-04-16  165          if (iavcc_r->pcr < dev->rate_limit) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  166             IA_SKB_STATE (dev->desc_tbl[desc1-1].txskb) |= IA_TX_DONE;
^1da177e4c3f41 Linus Torvalds 2005-04-16  167             if (ia_enque_rtn_q(&dev->tx_return_q, dev->desc_tbl[desc1 -1]) < 0)
^1da177e4c3f41 Linus Torvalds 2005-04-16  168                printk("ia_hack_tcq: No memory available\n");
^1da177e4c3f41 Linus Torvalds 2005-04-16  169          } 
^1da177e4c3f41 Linus Torvalds 2005-04-16  170          dev->desc_tbl[desc1 -1].iavcc = NULL;
^1da177e4c3f41 Linus Torvalds 2005-04-16  171          dev->desc_tbl[desc1 -1].txskb = NULL;
^1da177e4c3f41 Linus Torvalds 2005-04-16  172       }
^1da177e4c3f41 Linus Torvalds 2005-04-16  173       dev->host_tcq_wr += 2;
^1da177e4c3f41 Linus Torvalds 2005-04-16  174       if (dev->host_tcq_wr > dev->ffL.tcq_ed) 
^1da177e4c3f41 Linus Torvalds 2005-04-16  175          dev->host_tcq_wr = dev->ffL.tcq_st;
^1da177e4c3f41 Linus Torvalds 2005-04-16  176    }
^1da177e4c3f41 Linus Torvalds 2005-04-16  177  } /* ia_hack_tcq */
^1da177e4c3f41 Linus Torvalds 2005-04-16  178  

:::::: The code at line 151 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
