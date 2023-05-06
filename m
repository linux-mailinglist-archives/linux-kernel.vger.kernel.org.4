Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616B66F8E8C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 06:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjEFE1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 00:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjEFE1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 00:27:41 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8857DAD
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 21:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683347260; x=1714883260;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HmfWaeU0aFJnkRQl+Fn9eJRDVTAOl6JP0JdVj0Kyo2k=;
  b=IQwkYZ8glDsdy1+48+nI+hAUBVBEu4tNuESfuW+tAqae18KsNbNVKuFM
   rjpVw/3ZHUvPLL3mT4D+d2sKolAmLsnRIZW9B2kE+71Jp86CiRlSV5tfk
   zxuk7nqnga9NTHm1amDHvmYhxWYmh7eyfq2ar4Fx1EqVvzl7M8HPfmEW4
   uOAFNlqxcY5gESwo7fuM5xzZWZ6X4Mh0/6YvXY4epWoTqi9nrMpXgx/s4
   HZekoVZk4/wBGh0AI/F3mJhHQMR1fGE+9gD54rK8pZacDr/qYM3uLNS8w
   vZpJBjYDodk7UswQVrBonKspKTxodWJYFxdMCKUGbYC+Abpi3Np0wn2cb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="412587644"
X-IronPort-AV: E=Sophos;i="5.99,254,1677571200"; 
   d="scan'208";a="412587644"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 21:27:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="728370673"
X-IronPort-AV: E=Sophos;i="5.99,254,1677571200"; 
   d="scan'208";a="728370673"
Received: from lkp-server01.sh.intel.com (HELO fe5d646e317d) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 05 May 2023 21:27:38 -0700
Received: from kbuild by fe5d646e317d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pv9WD-00019J-1h;
        Sat, 06 May 2023 04:27:37 +0000
Date:   Sat, 6 May 2023 12:27:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ondrej Zary <linux@zary.sk>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: drivers/ata/pata_parport/frpw.c:234 frpw_test_proto() warn:
 inconsistent indenting
Message-ID: <202305061212.EPgEMLXl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2e1e1337881b0e9844d687982aa54b31b1269b11
commit: 5f1145d8304f93286be774482db6298c40dfe812 ata: pata_parport: use dev_* instead of printk
date:   6 weeks ago
config: x86_64-randconfig-m001-20230501 (https://download.01.org/0day-ci/archive/20230506/202305061212.EPgEMLXl-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305061212.EPgEMLXl-lkp@intel.com/

New smatch warnings:
drivers/ata/pata_parport/frpw.c:234 frpw_test_proto() warn: inconsistent indenting

Old smatch warnings:
drivers/ata/pata_parport/frpw.c:239 frpw_test_proto() warn: inconsistent indenting

vim +234 drivers/ata/pata_parport/frpw.c

^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  225  
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  226  {       int     j, k, r;
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  227  	int	e[2] = {0,0};
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  228  
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  229  	if ((pi->private>>1) != pi->port)
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  230  	   pi->private = frpw_test_pnp(pi) + 2*pi->port;
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  231  
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  232  	if (((pi->private%2) == 0) && (pi->mode > 2)) {
5f1145d8304f93 drivers/ata/pata_parport/frpw.c Ondrej Zary    2023-02-18  233  		dev_dbg(&pi->dev, "frpw: Xilinx does not support mode %d\n", pi->mode);
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16 @234  	   return 1;
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  235  	}
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  236  
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  237  	if (((pi->private%2) == 1) && (pi->mode == 2)) {
5f1145d8304f93 drivers/ata/pata_parport/frpw.c Ondrej Zary    2023-02-18  238  		dev_dbg(&pi->dev, "frpw: ASIC does not support mode 2\n");
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  239  	   return 1;
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  240  	}
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  241  
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  242  	frpw_connect(pi);
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  243  	for (j=0;j<2;j++) {
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  244                  frpw_write_regr(pi,0,6,0xa0+j*0x10);
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  245                  for (k=0;k<256;k++) {
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  246                          frpw_write_regr(pi,0,2,k^0xaa);
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  247                          frpw_write_regr(pi,0,3,k^0x55);
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  248                          if (frpw_read_regr(pi,0,2) != (k^0xaa)) e[j]++;
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  249                          }
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  250                  }
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  251  	frpw_disconnect(pi);
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  252  
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  253  	frpw_connect(pi);
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  254          frpw_read_block_int(pi,scratch,512,0x10);
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  255          r = 0;
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  256          for (k=0;k<128;k++) if (scratch[k] != k) r++;
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  257  	frpw_disconnect(pi);
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  258  
5f1145d8304f93 drivers/ata/pata_parport/frpw.c Ondrej Zary    2023-02-18  259  	dev_dbg(&pi->dev, "frpw: port 0x%x, chip %ld, mode %d, test=(%d,%d,%d)\n",
a4f2ff92ed4a03 drivers/ata/pata_parport/frpw.c Ondrej Zary    2023-02-18  260  	       pi->port, (pi->private%2), pi->mode, e[0], e[1], r);
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  261  
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  262          return (r || (e[0] && e[1]));
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  263  }
^1da177e4c3f41 drivers/block/paride/frpw.c     Linus Torvalds 2005-04-16  264  

:::::: The code at line 234 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
