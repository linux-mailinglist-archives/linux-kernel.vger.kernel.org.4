Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361356F42C6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 13:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbjEBL1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 07:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbjEBL0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 07:26:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DA35260
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 04:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683026772; x=1714562772;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8JAWBCXiLGLZA6iIvX/6F4ftIB/0WHGwyNLAwRvyss4=;
  b=PjlEWgES2K4ZqE90xCUlRCFjGHsEpDlbG6Ho8Q1WkSvFBMFRQArZTCAX
   NgPQjXCi/kHaG/jvuOWSAPYqcTfs2LAQ3Jgdaddz8QOSfmwuBcU+KOKVN
   DnxSqdT1Efnj3r/PdWKk5d+1WOd8YlxVDMeOmh2hIYtWpUN7e2kFPmhVG
   6eZ3evY8LcxNgVA+hr2zuyNRtffBPDg7+KP72VePpwMxZ8xxXBLMMhcqw
   RoIFnLaFWJSKSd74/3ros4AJwHxDhclee9cu6PWm4ahsekzYnmVkMmyY5
   2SGKYc2KtPJ/GScEmtpLICsn++Tsn10o/kS6FIrjWxKRVU0ssra9CBUcR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="332724427"
X-IronPort-AV: E=Sophos;i="5.99,244,1677571200"; 
   d="scan'208";a="332724427"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 04:25:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="690241453"
X-IronPort-AV: E=Sophos;i="5.99,244,1677571200"; 
   d="scan'208";a="690241453"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 02 May 2023 04:25:22 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pto8H-00010e-31;
        Tue, 02 May 2023 11:25:21 +0000
Date:   Tue, 2 May 2023 19:25:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ondrej Zary <linux@zary.sk>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: drivers/ata/pata_parport/bpck.c:66 bpck_read_regr() warn:
 inconsistent indenting
Message-ID: <202305021913.nCMzH5Zj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ondrej,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   865fdb08197e657c59e74a35fa32362b12397f58
commit: 72f2b0b2185099dce354c805009f591dda3ab73d drivers/block: Move PARIDE protocol modules to drivers/ata/pata_parport
date:   3 months ago
config: x86_64-randconfig-m001-20230501 (https://download.01.org/0day-ci/archive/20230502/202305021913.nCMzH5Zj-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305021913.nCMzH5Zj-lkp@intel.com/

New smatch warnings:
drivers/ata/pata_parport/bpck.c:66 bpck_read_regr() warn: inconsistent indenting
drivers/ata/pata_parport/bpck.c:160 bpck_read_block() warn: inconsistent indenting
drivers/ata/pata_parport/bpck.c:210 bpck_probe_unit() warn: inconsistent indenting
drivers/ata/pata_parport/bpck.c:230 bpck_connect() warn: inconsistent indenting
drivers/ata/pata_parport/bpck.c:293 bpck_test_proto() warn: inconsistent indenting

Old smatch warnings:
drivers/ata/pata_parport/bpck.c:161 bpck_read_block() warn: inconsistent indenting
drivers/ata/pata_parport/bpck.c:233 bpck_connect() warn: inconsistent indenting
drivers/ata/pata_parport/bpck.c:294 bpck_test_proto() warn: inconsistent indenting

vim +66 drivers/ata/pata_parport/bpck.c

^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   52  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   53  	r = regr + cont_map[cont];
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   54  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   55  	switch (pi->mode) {
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   56  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   57  	case 0: w0(r & 0xf); w0(r); t2(2); t2(4);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   58  	        l = r1();
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   59          	t2(4);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   60          	h = r1();
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   61          	return j44(l,h);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   62  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   63  	case 1: w0(r & 0xf); w0(r); t2(2);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   64  	        e2(); t2(0x20);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   65  		t2(4); h = r0();
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  @66  	        t2(1); t2(0x20);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   67  	        return h;
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   68  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   69  	case 2:
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   70  	case 3:
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   71  	case 4: w0(r); w2(9); w2(0); w2(0x20);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   72  		h = r4();
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   73  		w2(0);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   74  		return h;
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   75  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   76  	}
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   77  	return -1;
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   78  }	
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   79  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   80  static void bpck_write_regr( PIA *pi, int cont, int regr, int val )
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   81  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   82  {	int	r;
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   83  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   84          r = regr + cont_map[cont];
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   85  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   86  	switch (pi->mode) {
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   87  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   88  	case 0:
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   89  	case 1: w0(r);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   90  		t2(2);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   91  		w0(val);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   92  		o2(); t2(4); t2(1);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   93  		break;
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   94  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   95  	case 2:
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   96  	case 3:
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   97  	case 4: w0(r); w2(9); w2(0);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   98  		w0(val); w2(1); w2(3); w2(0);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16   99  		break;
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  100  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  101  	}
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  102  }
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  103  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  104  /* These macros access the bpck registers in native addressing */
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  105  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  106  #define WR(r,v)		bpck_write_regr(pi,2,r,v)
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  107  #define RR(r)		(bpck_read_regr(pi,2,r))
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  108  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  109  static void bpck_write_block( PIA *pi, char * buf, int count )
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  110  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  111  {	int i;
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  112  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  113  	switch (pi->mode) {
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  114  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  115  	case 0: WR(4,0x40);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  116  		w0(0x40); t2(2); t2(1);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  117  		for (i=0;i<count;i++) { w0(buf[i]); t2(4); }
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  118  		WR(4,0);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  119  		break;
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  120  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  121  	case 1: WR(4,0x50);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  122                  w0(0x40); t2(2); t2(1);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  123                  for (i=0;i<count;i++) { w0(buf[i]); t2(4); }
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  124                  WR(4,0x10);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  125  		break;
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  126  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  127  	case 2: WR(4,0x48);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  128  		w0(0x40); w2(9); w2(0); w2(1);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  129  		for (i=0;i<count;i++) w4(buf[i]);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  130  		w2(0);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  131  		WR(4,8);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  132  		break;
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  133  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  134          case 3: WR(4,0x48);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  135                  w0(0x40); w2(9); w2(0); w2(1);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  136                  for (i=0;i<count/2;i++) w4w(((u16 *)buf)[i]);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  137                  w2(0);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  138                  WR(4,8);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  139                  break;
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  140   
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  141          case 4: WR(4,0x48);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  142                  w0(0x40); w2(9); w2(0); w2(1);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  143                  for (i=0;i<count/4;i++) w4l(((u32 *)buf)[i]);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  144                  w2(0);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  145                  WR(4,8);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  146                  break;
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  147   	}
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  148  }
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  149  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  150  static void bpck_read_block( PIA *pi, char * buf, int count )
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  151  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  152  {	int i, l, h;
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  153  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  154  	switch (pi->mode) {
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  155  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  156        	case 0: WR(4,0x40);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  157  		w0(0x40); t2(2);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  158  		for (i=0;i<count;i++) {
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  159  		    t2(4); l = r1();
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16 @160  		    t2(4); h = r1();
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  161  		    buf[i] = j44(l,h);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  162  		}
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  163  		WR(4,0);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  164  		break;
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  165  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  166  	case 1: WR(4,0x50);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  167  		w0(0x40); t2(2); t2(0x20);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  168        	        for(i=0;i<count;i++) { t2(4); buf[i] = r0(); }
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  169  	        t2(1); t2(0x20);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  170  	        WR(4,0x10);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  171  		break;
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  172  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  173  	case 2: WR(4,0x48);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  174  		w0(0x40); w2(9); w2(0); w2(0x20);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  175  		for (i=0;i<count;i++) buf[i] = r4();
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  176  		w2(0);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  177  		WR(4,8);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  178  		break;
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  179  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  180          case 3: WR(4,0x48);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  181                  w0(0x40); w2(9); w2(0); w2(0x20);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  182                  for (i=0;i<count/2;i++) ((u16 *)buf)[i] = r4w();
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  183                  w2(0);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  184                  WR(4,8);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  185                  break;
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  186  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  187          case 4: WR(4,0x48);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  188                  w0(0x40); w2(9); w2(0); w2(0x20);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  189                  for (i=0;i<count/4;i++) ((u32 *)buf)[i] = r4l();
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  190                  w2(0);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  191                  WR(4,8);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  192                  break;
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  193  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  194  	}
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  195  }
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  196  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  197  static int bpck_probe_unit ( PIA *pi )
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  198  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  199  {	int o1, o0, f7, id;
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  200  	int t, s;
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  201  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  202  	id = pi->unit;
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  203  	s = 0;
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  204  	w2(4); w2(0xe); r2(); t2(2); 
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  205  	o1 = r1()&0xf8;
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  206  	o0 = r0();
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  207  	w0(255-id); w2(4); w0(id);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  208  	t2(8); t2(8); t2(8);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  209  	t2(2); t = r1()&0xf8;
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16 @210  	f7 = ((id % 8) == 7);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  211  	if ((f7) || (t != o1)) { t2(2); s = r1()&0xf8; }
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  212  	if ((t == o1) && ((!f7) || (s == o1)))  {
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  213  		w2(0x4c); w0(o0);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  214  		return 0;	
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  215  	}
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  216  	t2(8); w0(0); t2(2); w2(0x4c); w0(o0);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  217  	return 1;
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  218  }
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  219  	
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  220  static void bpck_connect ( PIA *pi  )
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  221  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  222  {       pi->saved_r0 = r0();
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  223  	w0(0xff-pi->unit); w2(4); w0(pi->unit);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  224  	t2(8); t2(8); t2(8); 
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  225  	t2(2); t2(2);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  226  	
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  227  	switch (pi->mode) {
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  228  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  229  	case 0: t2(8); WR(4,0);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16 @230  		break;
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  231  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  232  	case 1: t2(8); WR(4,0x10);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  233  		break;
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  234  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  235  	case 2:
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  236          case 3:
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  237  	case 4: w2(0); WR(4,8);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  238  		break;
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  239  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  240  	}
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  241  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  242  	WR(5,8);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  243  
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  244  	if (pi->devtype == PI_PCD) {
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  245  		WR(0x46,0x10);		/* fiddle with ESS logic ??? */
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  246  		WR(0x4c,0x38);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  247  		WR(0x4d,0x88);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  248  		WR(0x46,0xa0);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  249  		WR(0x41,0);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  250  		WR(0x4e,8);
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  251  		}
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  252  }
^1da177e4c3f41 drivers/block/paride/bpck.c Linus Torvalds 2005-04-16  253  

:::::: The code at line 66 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
