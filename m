Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEC9621D18
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 20:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiKHTjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 14:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKHTjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 14:39:07 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC649FFF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 11:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667936342; x=1699472342;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Lcf9P0FcYc5LLTbakzSAXRs343d/Oy0cLAUs5ipFs+4=;
  b=GwNiQzIcHqJpJ8yrPdoztXfq77cpshXhmKMSlkk5jPpRXjHtq/wuEZHa
   7id0ffw9aAwh+f09waY0Xn6ybhY9Nd5Ugs9UsSRh2G2ZMilIYixBDJVdT
   1ePS2uljI8Y3U+exTvCdfdiUJWkVPluAFtfEa/8paznTfGg8LkBq81sRs
   KdiNwlXL6rMJH8PSsnXqWP8HLE2etCEjFmSultzY61FHizTFprBUFzoRS
   A1yYZ+EYxOPsYH8IB7uH9XFVunXxw1pKhbMjZtMAj1SazaWf5kLS6k+dQ
   50jgchQK86fBAIc4LnNKkM63KWosf8k5Y98QT2XbhxpM1EsKGoYimkB0z
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="310788849"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="310788849"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 11:39:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="705420625"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="705420625"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 08 Nov 2022 11:38:59 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1osUR0-0000YK-2U;
        Tue, 08 Nov 2022 19:38:58 +0000
Date:   Wed, 9 Nov 2022 03:38:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: drivers/gpu/drm/qxl/qxl_kms.c:275:21: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202211090348.wzvaHU8A-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="isCNExCefFs+QYIc"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--isCNExCefFs+QYIc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   59f2f4b8a757412fce372f6d0767bdb55da127a8
commit: d803336abdbc1bfacdb32b2cf9f4fdbee072b8ee ARM: mm: kill unused runtime hook arch_iounmap()
date:   4 months ago
config: arm-randconfig-s032-20221108
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d803336abdbc1bfacdb32b2cf9f4fdbee072b8ee
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d803336abdbc1bfacdb32b2cf9f4fdbee072b8ee
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/qxl/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   drivers/gpu/drm/qxl/qxl_kms.c:168:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct qxl_rom *rom @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/qxl/qxl_kms.c:168:19: sparse:     expected struct qxl_rom *rom
   drivers/gpu/drm/qxl/qxl_kms.c:168:19: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/qxl/qxl_kms.c:186:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct qxl_ram_header *ram_header @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/qxl/qxl_kms.c:186:26: sparse:     expected struct qxl_ram_header *ram_header
   drivers/gpu/drm/qxl/qxl_kms.c:186:26: sparse:     got void [noderef] __iomem *
>> drivers/gpu/drm/qxl/qxl_kms.c:275:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got struct qxl_ram_header *ram_header @@
   drivers/gpu/drm/qxl/qxl_kms.c:275:21: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/gpu/drm/qxl/qxl_kms.c:275:21: sparse:     got struct qxl_ram_header *ram_header
>> drivers/gpu/drm/qxl/qxl_kms.c:279:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got struct qxl_rom *rom @@
   drivers/gpu/drm/qxl/qxl_kms.c:279:21: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/gpu/drm/qxl/qxl_kms.c:279:21: sparse:     got struct qxl_rom *rom
   drivers/gpu/drm/qxl/qxl_kms.c:323:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got struct qxl_ram_header *ram_header @@
   drivers/gpu/drm/qxl/qxl_kms.c:323:21: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/gpu/drm/qxl/qxl_kms.c:323:21: sparse:     got struct qxl_ram_header *ram_header
   drivers/gpu/drm/qxl/qxl_kms.c:324:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got struct qxl_rom *rom @@
   drivers/gpu/drm/qxl/qxl_kms.c:324:21: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/gpu/drm/qxl/qxl_kms.c:324:21: sparse:     got struct qxl_rom *rom

vim +275 drivers/gpu/drm/qxl/qxl_kms.c

f64122c1f6ade3 Dave Airlie             2013-02-25  108  
2b65d5677a797f Gabriel Krisman Bertazi 2017-01-19  109  int qxl_device_init(struct qxl_device *qdev,
aa5b62bac05d4b Gabriel Krisman Bertazi 2017-02-27  110  		    struct pci_dev *pdev)
f64122c1f6ade3 Dave Airlie             2013-02-25  111  {
35541782dcc1e5 Gerd Hoffmann           2013-10-11  112  	int r, sb;
f64122c1f6ade3 Dave Airlie             2013-02-25  113  
cbdded7f8a633e Gabriel Krisman Bertazi 2017-01-26  114  	pci_set_drvdata(pdev, &qdev->ddev);
cbdded7f8a633e Gabriel Krisman Bertazi 2017-01-26  115  
f64122c1f6ade3 Dave Airlie             2013-02-25  116  	mutex_init(&qdev->gem.mutex);
f64122c1f6ade3 Dave Airlie             2013-02-25  117  	mutex_init(&qdev->update_area_mutex);
f64122c1f6ade3 Dave Airlie             2013-02-25  118  	mutex_init(&qdev->release_mutex);
f64122c1f6ade3 Dave Airlie             2013-02-25  119  	mutex_init(&qdev->surf_evict_mutex);
b3740e88601d69 Christophe Fergeau      2016-11-08  120  	qxl_gem_init(qdev);
f64122c1f6ade3 Dave Airlie             2013-02-25  121  
f64122c1f6ade3 Dave Airlie             2013-02-25  122  	qdev->rom_base = pci_resource_start(pdev, 2);
f64122c1f6ade3 Dave Airlie             2013-02-25  123  	qdev->rom_size = pci_resource_len(pdev, 2);
f64122c1f6ade3 Dave Airlie             2013-02-25  124  	qdev->vram_base = pci_resource_start(pdev, 0);
f64122c1f6ade3 Dave Airlie             2013-02-25  125  	qdev->io_base = pci_resource_start(pdev, 3);
f64122c1f6ade3 Dave Airlie             2013-02-25  126  
f64122c1f6ade3 Dave Airlie             2013-02-25  127  	qdev->vram_mapping = io_mapping_create_wc(qdev->vram_base, pci_resource_len(pdev, 0));
5043348a4969ae Anton Vasilyev          2018-07-27  128  	if (!qdev->vram_mapping) {
5043348a4969ae Anton Vasilyev          2018-07-27  129  		pr_err("Unable to create vram_mapping");
a9b0b24a6fff2d Daniel Vetter           2020-04-15  130  		return -ENOMEM;
5043348a4969ae Anton Vasilyev          2018-07-27  131  	}
35541782dcc1e5 Gerd Hoffmann           2013-10-11  132  
35541782dcc1e5 Gerd Hoffmann           2013-10-11  133  	if (pci_resource_len(pdev, 4) > 0) {
35541782dcc1e5 Gerd Hoffmann           2013-10-11  134  		/* 64bit surface bar present */
35541782dcc1e5 Gerd Hoffmann           2013-10-11  135  		sb = 4;
35541782dcc1e5 Gerd Hoffmann           2013-10-11  136  		qdev->surfaceram_base = pci_resource_start(pdev, sb);
35541782dcc1e5 Gerd Hoffmann           2013-10-11  137  		qdev->surfaceram_size = pci_resource_len(pdev, sb);
35541782dcc1e5 Gerd Hoffmann           2013-10-11  138  		qdev->surface_mapping =
35541782dcc1e5 Gerd Hoffmann           2013-10-11  139  			io_mapping_create_wc(qdev->surfaceram_base,
35541782dcc1e5 Gerd Hoffmann           2013-10-11  140  					     qdev->surfaceram_size);
35541782dcc1e5 Gerd Hoffmann           2013-10-11  141  	}
35541782dcc1e5 Gerd Hoffmann           2013-10-11  142  	if (qdev->surface_mapping == NULL) {
35541782dcc1e5 Gerd Hoffmann           2013-10-11  143  		/* 64bit surface bar not present (or mapping failed) */
35541782dcc1e5 Gerd Hoffmann           2013-10-11  144  		sb = 1;
35541782dcc1e5 Gerd Hoffmann           2013-10-11  145  		qdev->surfaceram_base = pci_resource_start(pdev, sb);
35541782dcc1e5 Gerd Hoffmann           2013-10-11  146  		qdev->surfaceram_size = pci_resource_len(pdev, sb);
35541782dcc1e5 Gerd Hoffmann           2013-10-11  147  		qdev->surface_mapping =
35541782dcc1e5 Gerd Hoffmann           2013-10-11  148  			io_mapping_create_wc(qdev->surfaceram_base,
35541782dcc1e5 Gerd Hoffmann           2013-10-11  149  					     qdev->surfaceram_size);
5043348a4969ae Anton Vasilyev          2018-07-27  150  		if (!qdev->surface_mapping) {
5043348a4969ae Anton Vasilyev          2018-07-27  151  			pr_err("Unable to create surface_mapping");
5043348a4969ae Anton Vasilyev          2018-07-27  152  			r = -ENOMEM;
5043348a4969ae Anton Vasilyev          2018-07-27  153  			goto vram_mapping_free;
5043348a4969ae Anton Vasilyev          2018-07-27  154  		}
35541782dcc1e5 Gerd Hoffmann           2013-10-11  155  	}
35541782dcc1e5 Gerd Hoffmann           2013-10-11  156  
35541782dcc1e5 Gerd Hoffmann           2013-10-11  157  	DRM_DEBUG_KMS("qxl: vram %llx-%llx(%dM %dk), surface %llx-%llx(%dM %dk, %s)\n",
970fa986fadb11 Dave Airlie             2013-05-31  158  		 (unsigned long long)qdev->vram_base,
970fa986fadb11 Dave Airlie             2013-05-31  159  		 (unsigned long long)pci_resource_end(pdev, 0),
f64122c1f6ade3 Dave Airlie             2013-02-25  160  		 (int)pci_resource_len(pdev, 0) / 1024 / 1024,
f64122c1f6ade3 Dave Airlie             2013-02-25  161  		 (int)pci_resource_len(pdev, 0) / 1024,
970fa986fadb11 Dave Airlie             2013-05-31  162  		 (unsigned long long)qdev->surfaceram_base,
35541782dcc1e5 Gerd Hoffmann           2013-10-11  163  		 (unsigned long long)pci_resource_end(pdev, sb),
f64122c1f6ade3 Dave Airlie             2013-02-25  164  		 (int)qdev->surfaceram_size / 1024 / 1024,
35541782dcc1e5 Gerd Hoffmann           2013-10-11  165  		 (int)qdev->surfaceram_size / 1024,
35541782dcc1e5 Gerd Hoffmann           2013-10-11  166  		 (sb == 4) ? "64bit" : "32bit");
f64122c1f6ade3 Dave Airlie             2013-02-25  167  
59ab4ee012f016 Cong Liu                2022-03-24  168  	qdev->rom = ioremap_wc(qdev->rom_base, qdev->rom_size);
f64122c1f6ade3 Dave Airlie             2013-02-25  169  	if (!qdev->rom) {
f64122c1f6ade3 Dave Airlie             2013-02-25  170  		pr_err("Unable to ioremap ROM\n");
5043348a4969ae Anton Vasilyev          2018-07-27  171  		r = -ENOMEM;
5043348a4969ae Anton Vasilyev          2018-07-27  172  		goto surface_mapping_free;
f64122c1f6ade3 Dave Airlie             2013-02-25  173  	}
f64122c1f6ade3 Dave Airlie             2013-02-25  174  
5043348a4969ae Anton Vasilyev          2018-07-27  175  	if (!qxl_check_device(qdev)) {
5043348a4969ae Anton Vasilyev          2018-07-27  176  		r = -ENODEV;
dbe3ad61dcebc4 Markus Elfring          2019-11-07  177  		goto rom_unmap;
5043348a4969ae Anton Vasilyev          2018-07-27  178  	}
f64122c1f6ade3 Dave Airlie             2013-02-25  179  
f64122c1f6ade3 Dave Airlie             2013-02-25  180  	r = qxl_bo_init(qdev);
f64122c1f6ade3 Dave Airlie             2013-02-25  181  	if (r) {
f64122c1f6ade3 Dave Airlie             2013-02-25  182  		DRM_ERROR("bo init failed %d\n", r);
5043348a4969ae Anton Vasilyev          2018-07-27  183  		goto rom_unmap;
f64122c1f6ade3 Dave Airlie             2013-02-25  184  	}
f64122c1f6ade3 Dave Airlie             2013-02-25  185  
59ab4ee012f016 Cong Liu                2022-03-24  186  	qdev->ram_header = ioremap_wc(qdev->vram_base +
f64122c1f6ade3 Dave Airlie             2013-02-25  187  				   qdev->rom->ram_header_offset,
f64122c1f6ade3 Dave Airlie             2013-02-25  188  				   sizeof(*qdev->ram_header));
5043348a4969ae Anton Vasilyev          2018-07-27  189  	if (!qdev->ram_header) {
5043348a4969ae Anton Vasilyev          2018-07-27  190  		DRM_ERROR("Unable to ioremap RAM header\n");
5043348a4969ae Anton Vasilyev          2018-07-27  191  		r = -ENOMEM;
5043348a4969ae Anton Vasilyev          2018-07-27  192  		goto bo_fini;
5043348a4969ae Anton Vasilyev          2018-07-27  193  	}
f64122c1f6ade3 Dave Airlie             2013-02-25  194  
f64122c1f6ade3 Dave Airlie             2013-02-25  195  	qdev->command_ring = qxl_ring_create(&(qdev->ram_header->cmd_ring_hdr),
f64122c1f6ade3 Dave Airlie             2013-02-25  196  					     sizeof(struct qxl_command),
f64122c1f6ade3 Dave Airlie             2013-02-25  197  					     QXL_COMMAND_RING_SIZE,
f64122c1f6ade3 Dave Airlie             2013-02-25  198  					     qdev->io_base + QXL_IO_NOTIFY_CMD,
f64122c1f6ade3 Dave Airlie             2013-02-25  199  					     false,
f64122c1f6ade3 Dave Airlie             2013-02-25  200  					     &qdev->display_event);
5043348a4969ae Anton Vasilyev          2018-07-27  201  	if (!qdev->command_ring) {
5043348a4969ae Anton Vasilyev          2018-07-27  202  		DRM_ERROR("Unable to create command ring\n");
5043348a4969ae Anton Vasilyev          2018-07-27  203  		r = -ENOMEM;
5043348a4969ae Anton Vasilyev          2018-07-27  204  		goto ram_header_unmap;
5043348a4969ae Anton Vasilyev          2018-07-27  205  	}
f64122c1f6ade3 Dave Airlie             2013-02-25  206  
f64122c1f6ade3 Dave Airlie             2013-02-25  207  	qdev->cursor_ring = qxl_ring_create(
f64122c1f6ade3 Dave Airlie             2013-02-25  208  				&(qdev->ram_header->cursor_ring_hdr),
f64122c1f6ade3 Dave Airlie             2013-02-25  209  				sizeof(struct qxl_command),
f64122c1f6ade3 Dave Airlie             2013-02-25  210  				QXL_CURSOR_RING_SIZE,
80e5f89da3ab94 Huacai Chen             2020-03-31  211  				qdev->io_base + QXL_IO_NOTIFY_CURSOR,
f64122c1f6ade3 Dave Airlie             2013-02-25  212  				false,
f64122c1f6ade3 Dave Airlie             2013-02-25  213  				&qdev->cursor_event);
f64122c1f6ade3 Dave Airlie             2013-02-25  214  
5043348a4969ae Anton Vasilyev          2018-07-27  215  	if (!qdev->cursor_ring) {
5043348a4969ae Anton Vasilyev          2018-07-27  216  		DRM_ERROR("Unable to create cursor ring\n");
5043348a4969ae Anton Vasilyev          2018-07-27  217  		r = -ENOMEM;
5043348a4969ae Anton Vasilyev          2018-07-27  218  		goto command_ring_free;
5043348a4969ae Anton Vasilyev          2018-07-27  219  	}
5043348a4969ae Anton Vasilyev          2018-07-27  220  
f64122c1f6ade3 Dave Airlie             2013-02-25  221  	qdev->release_ring = qxl_ring_create(
f64122c1f6ade3 Dave Airlie             2013-02-25  222  				&(qdev->ram_header->release_ring_hdr),
f64122c1f6ade3 Dave Airlie             2013-02-25  223  				sizeof(uint64_t),
f64122c1f6ade3 Dave Airlie             2013-02-25  224  				QXL_RELEASE_RING_SIZE, 0, true,
f64122c1f6ade3 Dave Airlie             2013-02-25  225  				NULL);
f64122c1f6ade3 Dave Airlie             2013-02-25  226  
5043348a4969ae Anton Vasilyev          2018-07-27  227  	if (!qdev->release_ring) {
5043348a4969ae Anton Vasilyev          2018-07-27  228  		DRM_ERROR("Unable to create release ring\n");
5043348a4969ae Anton Vasilyev          2018-07-27  229  		r = -ENOMEM;
5043348a4969ae Anton Vasilyev          2018-07-27  230  		goto cursor_ring_free;
5043348a4969ae Anton Vasilyev          2018-07-27  231  	}
f64122c1f6ade3 Dave Airlie             2013-02-25  232  
5d4c1edf0ddcf8 Deepak R Varma          2020-11-06  233  	idr_init_base(&qdev->release_idr, 1);
f64122c1f6ade3 Dave Airlie             2013-02-25  234  	spin_lock_init(&qdev->release_idr_lock);
2f453ed4038526 Maarten Lankhorst       2014-04-02  235  	spin_lock_init(&qdev->release_lock);
f64122c1f6ade3 Dave Airlie             2013-02-25  236  
5d4c1edf0ddcf8 Deepak R Varma          2020-11-06  237  	idr_init_base(&qdev->surf_id_idr, 1);
f64122c1f6ade3 Dave Airlie             2013-02-25  238  	spin_lock_init(&qdev->surf_id_idr_lock);
f64122c1f6ade3 Dave Airlie             2013-02-25  239  
f64122c1f6ade3 Dave Airlie             2013-02-25  240  	mutex_init(&qdev->async_io_mutex);
f64122c1f6ade3 Dave Airlie             2013-02-25  241  
f64122c1f6ade3 Dave Airlie             2013-02-25  242  	/* reset the device into a known state - no memslots, no primary
f64122c1f6ade3 Dave Airlie             2013-02-25  243  	 * created, no surfaces. */
f64122c1f6ade3 Dave Airlie             2013-02-25  244  	qxl_io_reset(qdev);
f64122c1f6ade3 Dave Airlie             2013-02-25  245  
f64122c1f6ade3 Dave Airlie             2013-02-25  246  	/* must initialize irq before first async io - slot creation */
f64122c1f6ade3 Dave Airlie             2013-02-25  247  	r = qxl_irq_init(qdev);
5043348a4969ae Anton Vasilyev          2018-07-27  248  	if (r) {
5043348a4969ae Anton Vasilyev          2018-07-27  249  		DRM_ERROR("Unable to init qxl irq\n");
2ec6bd67b76ea0 Gerd Hoffmann           2019-01-18  250  		goto release_ring_free;
5043348a4969ae Anton Vasilyev          2018-07-27  251  	}
f64122c1f6ade3 Dave Airlie             2013-02-25  252  
f64122c1f6ade3 Dave Airlie             2013-02-25  253  	/*
f64122c1f6ade3 Dave Airlie             2013-02-25  254  	 * Note that virtual is surface0. We rely on the single ioremap done
f64122c1f6ade3 Dave Airlie             2013-02-25  255  	 * before.
f64122c1f6ade3 Dave Airlie             2013-02-25  256  	 */
2ec6bd67b76ea0 Gerd Hoffmann           2019-01-18  257  	setup_slot(qdev, &qdev->main_slot, 0, "main",
f64122c1f6ade3 Dave Airlie             2013-02-25  258  		   (unsigned long)qdev->vram_base,
2ec6bd67b76ea0 Gerd Hoffmann           2019-01-18  259  		   (unsigned long)qdev->rom->ram_header_offset);
2ec6bd67b76ea0 Gerd Hoffmann           2019-01-18  260  	setup_slot(qdev, &qdev->surfaces_slot, 1, "surfaces",
d9bbf1895f354c Gerd Hoffmann           2013-10-11  261  		   (unsigned long)qdev->surfaceram_base,
d9bbf1895f354c Gerd Hoffmann           2013-10-11  262  		   (unsigned long)qdev->surfaceram_size);
f64122c1f6ade3 Dave Airlie             2013-02-25  263  
f64122c1f6ade3 Dave Airlie             2013-02-25  264  	INIT_WORK(&qdev->gc_work, qxl_gc_work);
f64122c1f6ade3 Dave Airlie             2013-02-25  265  
f64122c1f6ade3 Dave Airlie             2013-02-25  266  	return 0;
5043348a4969ae Anton Vasilyev          2018-07-27  267  
5043348a4969ae Anton Vasilyev          2018-07-27  268  release_ring_free:
5043348a4969ae Anton Vasilyev          2018-07-27  269  	qxl_ring_free(qdev->release_ring);
5043348a4969ae Anton Vasilyev          2018-07-27  270  cursor_ring_free:
5043348a4969ae Anton Vasilyev          2018-07-27  271  	qxl_ring_free(qdev->cursor_ring);
5043348a4969ae Anton Vasilyev          2018-07-27  272  command_ring_free:
5043348a4969ae Anton Vasilyev          2018-07-27  273  	qxl_ring_free(qdev->command_ring);
5043348a4969ae Anton Vasilyev          2018-07-27  274  ram_header_unmap:
5043348a4969ae Anton Vasilyev          2018-07-27 @275  	iounmap(qdev->ram_header);
5043348a4969ae Anton Vasilyev          2018-07-27  276  bo_fini:
5043348a4969ae Anton Vasilyev          2018-07-27  277  	qxl_bo_fini(qdev);
5043348a4969ae Anton Vasilyev          2018-07-27  278  rom_unmap:
5043348a4969ae Anton Vasilyev          2018-07-27 @279  	iounmap(qdev->rom);
5043348a4969ae Anton Vasilyev          2018-07-27  280  surface_mapping_free:
5043348a4969ae Anton Vasilyev          2018-07-27  281  	io_mapping_free(qdev->surface_mapping);
5043348a4969ae Anton Vasilyev          2018-07-27  282  vram_mapping_free:
5043348a4969ae Anton Vasilyev          2018-07-27  283  	io_mapping_free(qdev->vram_mapping);
5043348a4969ae Anton Vasilyev          2018-07-27  284  	return r;
f64122c1f6ade3 Dave Airlie             2013-02-25  285  }
f64122c1f6ade3 Dave Airlie             2013-02-25  286  

:::::: The code at line 275 was first introduced by commit
:::::: 5043348a4969ae1661c008efe929abd0d76e3792 drm: qxl: Fix error handling at qxl_device_init

:::::: TO: Anton Vasilyev <vasilyev@ispras.ru>
:::::: CC: Gerd Hoffmann <kraxel@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

--isCNExCefFs+QYIc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated file; DO NOT EDIT.
# Linux/arm 5.19.0-rc3 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="arm-linux-gnueabi-gcc (GCC) 12.1.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=120100
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23800
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23800
CONFIG_LLD_VERSION=0
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_COMPILE_TEST=y
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
CONFIG_KERNEL_LZ4=y
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_SHOW_LEVEL=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_IRQ_FASTEOI_HIERARCHY_HANDLERS=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_GENERIC_IRQ_MULTI_HANDLER=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_TIME_KUNIT_TEST=m

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

CONFIG_BPF=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
# end of BPF subsystem

CONFIG_PREEMPT_NONE_BUILD=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
# CONFIG_TASKSTATS is not set
CONFIG_PSI=y
# CONFIG_PSI_DEFAULT_DISABLED is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_NEED_SEGCBLIST=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=17
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_PRINTK_INDEX=y
CONFIG_GENERIC_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
# CONFIG_CGROUP_FREEZER is not set
CONFIG_CGROUP_DEVICE=y
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
CONFIG_SYSFS_DEPRECATED=y
CONFIG_SYSFS_DEPRECATED_V2=y
CONFIG_RELAY=y
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_BOOT_CONFIG is not set
# CONFIG_INITRAMFS_PRESERVE_MTIME is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
# end of General setup

CONFIG_ARM=y
CONFIG_ARM_HAS_SG_CHAIN=y
CONFIG_ARM_DMA_USE_IOMMU=y
CONFIG_ARM_DMA_IOMMU_ALIGNMENT=8
CONFIG_SYS_SUPPORTS_APM_EMULATION=y
CONFIG_HAVE_PROC_CPU=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_ARM_PATCH_PHYS_VIRT=y
CONFIG_GENERIC_BUG=y
CONFIG_PGTABLE_LEVELS=2

#
# System Type
#
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MULTIPLATFORM=y

#
# Multiple platform selection
#

#
# CPU Core family selection
#
CONFIG_ARCH_MULTI_V4=y
# CONFIG_ARCH_MULTI_V4T is not set
CONFIG_ARCH_MULTI_V5=y
CONFIG_ARCH_MULTI_V4_V5=y
# CONFIG_ARCH_MULTI_V6 is not set
# CONFIG_ARCH_MULTI_V7 is not set
# end of Multiple platform selection

CONFIG_ARCH_IXP4XX=y

#
# Processor Type
#
CONFIG_CPU_FA526=y
CONFIG_CPU_XSCALE=y
CONFIG_CPU_THUMB_CAPABLE=y
CONFIG_CPU_32v4=y
CONFIG_CPU_32v5=y
CONFIG_CPU_ABRT_EV4=y
CONFIG_CPU_ABRT_EV5T=y
CONFIG_CPU_PABRT_LEGACY=y
CONFIG_CPU_CACHE_VIVT=y
CONFIG_CPU_CACHE_FA=y
CONFIG_CPU_COPY_FA=y
CONFIG_CPU_TLB_V4WBI=y
CONFIG_CPU_TLB_FA=y
CONFIG_CPU_CP15=y
CONFIG_CPU_CP15_MMU=y
CONFIG_CPU_USE_DOMAINS=y

#
# Processor Features
#
# CONFIG_CPU_LITTLE_ENDIAN is not set
CONFIG_CPU_BIG_ENDIAN=y
CONFIG_CPU_ENDIAN_BE32=y
# CONFIG_CPU_DCACHE_DISABLE is not set
CONFIG_CPU_DCACHE_WRITETHROUGH=y
CONFIG_CPU_BPREDICT_DISABLE=y
CONFIG_NEED_KUSER_HELPERS=y
CONFIG_KUSER_HELPERS=y
CONFIG_ARM_L1_CACHE_SHIFT=5
CONFIG_IWMMXT=y
# end of System Type

CONFIG_KRAIT_L2_ACCESSORS=y

#
# Bus support
#
# end of Bus support

#
# Kernel Features
#
CONFIG_IRQSTACKS=y
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_KASAN_SHADOW_OFFSET=0x9f000000
CONFIG_ARCH_NR_GPIO=0
CONFIG_HZ_FIXED=0
# CONFIG_HZ_100 is not set
CONFIG_HZ_200=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_500 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=200
CONFIG_SCHED_HRTICK=y
CONFIG_AEABI=y
CONFIG_OABI_COMPAT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
# CONFIG_HIGHMEM is not set
# CONFIG_CPU_SW_DOMAIN_PAN is not set
CONFIG_ARM_MODULE_PLTS=y
CONFIG_FORCE_MAX_ZONEORDER=11
CONFIG_ALIGNMENT_TRAP=y
# CONFIG_UACCESS_WITH_MEMCPY is not set
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_CC_HAVE_STACKPROTECTOR_TLS=y
# end of Kernel Features

#
# Boot options
#
CONFIG_USE_OF=y
# CONFIG_ATAGS is not set
CONFIG_ZBOOT_ROM_TEXT=0x0
CONFIG_ZBOOT_ROM_BSS=0x0
CONFIG_ARM_APPENDED_DTB=y
CONFIG_ARM_ATAG_DTB_COMPAT=y
# CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER is not set
CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND=y
CONFIG_CMDLINE=""
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_AUTO_ZRELADDR=y
# end of Boot options

#
# CPU Power Management
#

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_ONDEMAND=m
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y

#
# CPU frequency scaling drivers
#
CONFIG_CPUFREQ_DT=y
CONFIG_CPUFREQ_DT_PLATDEV=y
# CONFIG_ARM_BRCMSTB_AVS_CPUFREQ is not set
CONFIG_ARM_MEDIATEK_CPUFREQ_HW=m
CONFIG_ARM_QCOM_CPUFREQ_HW=m
CONFIG_ARM_RASPBERRYPI_CPUFREQ=y
CONFIG_ARM_SCMI_CPUFREQ=y
# CONFIG_QORIQ_CPUFREQ is not set
# end of CPU Frequency scaling

#
# CPU Idle
#
# CONFIG_CPU_IDLE is not set
# end of CPU Idle
# end of CPU Power Management

#
# Floating point emulation
#

#
# At least one emulation must be selected
#
CONFIG_FPE_NWFPE=y
CONFIG_FPE_NWFPE_XP=y
CONFIG_FPE_FASTFPE=y
# end of Floating point emulation

#
# Power management options
#
# CONFIG_SUSPEND is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
# CONFIG_HIBERNATION_SNAPSHOT_DEV is not set
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_AUTOSLEEP=y
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
CONFIG_PM_WAKELOCKS_GC=y
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
CONFIG_PM_SLEEP_DEBUG=y
CONFIG_APM_EMULATION=m
CONFIG_PM_CLK=y
CONFIG_PM_GENERIC_DOMAINS=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_PM_GENERIC_DOMAINS_SLEEP=y
CONFIG_PM_GENERIC_DOMAINS_OF=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARM_CPU_SUSPEND=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
# end of Power management options

# CONFIG_ARM_CRYPTO is not set
CONFIG_AS_VFP_VMRS_FPINST=y

#
# General architecture-dependent options
#
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_GENERIC_IDLE_POLL_SETUP=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_KEEPINITRD=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP=y
# CONFIG_SECCOMP is not set
CONFIG_HAVE_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_LTO_NONE=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT=y
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_CPU_NO_EFFICIENT_FFS=y
CONFIG_ARCH_OPTIONAL_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
# CONFIG_STRICT_KERNEL_RWX is not set
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
# CONFIG_STRICT_MODULE_RWX is not set
CONFIG_ARCH_HAS_PHYS_TO_DMA=y
CONFIG_LOCK_EVENT_COUNTS=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_HAVE_ARCH_PFN_VALID=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
CONFIG_MODULE_SRCVERSION_ALL=y
CONFIG_MODULE_SIG=y
CONFIG_MODULE_SIG_FORCE=y
CONFIG_MODULE_SIG_ALL=y
CONFIG_MODULE_SIG_SHA1=y
# CONFIG_MODULE_SIG_SHA224 is not set
# CONFIG_MODULE_SIG_SHA256 is not set
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha1"
# CONFIG_MODULE_COMPRESS_NONE is not set
CONFIG_MODULE_COMPRESS_GZIP=y
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
CONFIG_MODULE_DECOMPRESS=y
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
CONFIG_BLK_DEV_THROTTLING_LOW=y
CONFIG_BLK_WBT=y
# CONFIG_BLK_WBT_MQ is not set
CONFIG_BLK_CGROUP_IOLATENCY=y
# CONFIG_BLK_CGROUP_FC_APPID is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_CGROUP_IOPRIO=y
# CONFIG_BLK_DEBUG_FS is not set
# CONFIG_BLK_SED_OPAL is not set
CONFIG_BLK_INLINE_ENCRYPTION=y
# CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
CONFIG_AIX_PARTITION=y
# CONFIG_OSF_PARTITION is not set
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
# CONFIG_MSDOS_PARTITION is not set
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
CONFIG_KARMA_PARTITION=y
# CONFIG_EFI_PARTITION is not set
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_FREEZER=y

#
# Executable file formats
#
# CONFIG_BINFMT_ELF is not set
CONFIG_BINFMT_ELF_FDPIC=y
CONFIG_ELFCORE=y
# CONFIG_BINFMT_SCRIPT is not set
CONFIG_ARCH_HAS_BINFMT_FLAT=y
CONFIG_BINFMT_FLAT=y
CONFIG_BINFMT_FLAT_ARGVP_ENVP_ON_STACK=y
CONFIG_BINFMT_FLAT_OLD=y
# CONFIG_BINFMT_ZFLAT is not set
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
CONFIG_ZSWAP_DEFAULT_ON=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lz4"
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC=y
CONFIG_ZSWAP_ZPOOL_DEFAULT="zsmalloc"
# CONFIG_ZBUD is not set
CONFIG_Z3FOLD=m
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y

#
# SLAB allocator options
#
CONFIG_SLAB=y
# CONFIG_SLUB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
CONFIG_SLAB_FREELIST_HARDENED=y
# end of SLAB allocator options

# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_COMPAT_BRK=y
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_ARCH_KEEP_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_SPLIT_PTLOCK_CPUS=999999
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_NEED_PER_CPU_KM=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_SYSFS=y
CONFIG_CMA_AREAS=7
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_PERCPU_STATS=y
CONFIG_GUP_TEST=y
# CONFIG_ANON_VMA_NAME is not set
# CONFIG_USERFAULTFD is not set

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_REDIRECT=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=m
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
# CONFIG_UNIX_DIAG is not set
CONFIG_XDP_SOCKETS=y
CONFIG_XDP_SOCKETS_DIAG=y
# CONFIG_INET is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
# CONFIG_ATM is not set
CONFIG_STP=y
CONFIG_GARP=m
CONFIG_BRIDGE=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_BRIDGE_MRP=y
CONFIG_BRIDGE_CFM=y
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
# CONFIG_VLAN_8021Q_MVRP is not set
# CONFIG_DECNET is not set
CONFIG_LLC=y
# CONFIG_LLC2 is not set
CONFIG_ATALK=y
# CONFIG_DEV_APPLETALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
# CONFIG_NET_SCH_CBQ is not set
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
# CONFIG_NET_SCH_MULTIQ is not set
# CONFIG_NET_SCH_RED is not set
CONFIG_NET_SCH_SFB=y
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=y
CONFIG_NET_SCH_CBS=y
CONFIG_NET_SCH_ETF=m
CONFIG_NET_SCH_TAPRIO=m
# CONFIG_NET_SCH_GRED is not set
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
# CONFIG_NET_SCH_QFQ is not set
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
# CONFIG_NET_SCH_FQ is not set
CONFIG_NET_SCH_HHF=y
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
# CONFIG_NET_SCH_INGRESS is not set
CONFIG_NET_SCH_PLUG=y
CONFIG_NET_SCH_ETS=m
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_CODEL is not set
# CONFIG_DEFAULT_FQ_CODEL is not set
# CONFIG_DEFAULT_SFQ is not set
CONFIG_DEFAULT_PFIFO_FAST=y
CONFIG_DEFAULT_NET_SCH="pfifo_fast"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
# CONFIG_NET_CLS_TCINDEX is not set
# CONFIG_NET_CLS_FW is not set
CONFIG_NET_CLS_U32=y
# CONFIG_CLS_U32_PERF is not set
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=y
CONFIG_NET_CLS_RSVP6=y
CONFIG_NET_CLS_FLOW=m
# CONFIG_NET_CLS_CGROUP is not set
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=y
# CONFIG_NET_EMATCH is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=y
# CONFIG_NET_ACT_GACT is not set
CONFIG_NET_ACT_MIRRED=y
# CONFIG_NET_ACT_SAMPLE is not set
CONFIG_NET_ACT_NAT=y
# CONFIG_NET_ACT_PEDIT is not set
CONFIG_NET_ACT_SIMP=m
# CONFIG_NET_ACT_SKBEDIT is not set
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=y
# CONFIG_NET_ACT_BPF is not set
# CONFIG_NET_ACT_SKBMOD is not set
CONFIG_NET_ACT_IFE=y
CONFIG_NET_ACT_TUNNEL_KEY=y
# CONFIG_NET_ACT_GATE is not set
CONFIG_NET_IFE_SKBMARK=m
CONFIG_NET_IFE_SKBPRIO=m
CONFIG_NET_IFE_SKBTCINDEX=y
CONFIG_NET_TC_SKB_EXT=y
CONFIG_NET_SCH_FIFO=y
# CONFIG_DCB is not set
# CONFIG_DNS_RESOLVER is not set
CONFIG_BATMAN_ADV=y
# CONFIG_BATMAN_ADV_BATMAN_V is not set
# CONFIG_BATMAN_ADV_NC is not set
CONFIG_BATMAN_ADV_DEBUG=y
CONFIG_VSOCKETS=y
CONFIG_VSOCKETS_DIAG=y
# CONFIG_VSOCKETS_LOOPBACK is not set
CONFIG_VIRTIO_VSOCKETS=y
CONFIG_VIRTIO_VSOCKETS_COMMON=y
CONFIG_NETLINK_DIAG=y
CONFIG_MPLS=y
# CONFIG_NET_MPLS_GSO is not set
CONFIG_MPLS_ROUTING=y
# CONFIG_MPLS_IPTUNNEL is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_QRTR is not set
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y

#
# Network testing
#
# end of Network testing
# end of Networking options

CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=y
CONFIG_AX25_DAMA_SLAVE=y
# CONFIG_NETROM is not set
# CONFIG_ROSE is not set

#
# AX.25 network device drivers
#
# CONFIG_MKISS is not set
CONFIG_6PACK=m
CONFIG_BPQETHER=m
CONFIG_BAYCOM_SER_FDX=y
CONFIG_BAYCOM_SER_HDX=y
CONFIG_BAYCOM_PAR=m
CONFIG_BAYCOM_EPP=y
CONFIG_YAM=y
# end of AX.25 network device drivers

# CONFIG_CAN is not set
# CONFIG_BT is not set
CONFIG_MCTP=y
# CONFIG_WIRELESS is not set
CONFIG_RFKILL=y
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
CONFIG_RFKILL_GPIO=m
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=m
# CONFIG_NET_9P_VIRTIO is not set
CONFIG_NET_9P_DEBUG=y
CONFIG_CAIF=m
# CONFIG_CAIF_DEBUG is not set
# CONFIG_CAIF_NETDEV is not set
CONFIG_CAIF_USB=m
CONFIG_NFC=m
CONFIG_NFC_DIGITAL=m
CONFIG_NFC_NCI=m
CONFIG_NFC_NCI_UART=m
CONFIG_NFC_HCI=m
CONFIG_NFC_SHDLC=y

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_SIM=m
# CONFIG_NFC_PORT100 is not set
CONFIG_NFC_VIRTUAL_NCI=m
CONFIG_NFC_FDP=m
CONFIG_NFC_FDP_I2C=m
CONFIG_NFC_PN544=m
CONFIG_NFC_PN544_I2C=m
CONFIG_NFC_PN533=m
CONFIG_NFC_PN533_USB=m
CONFIG_NFC_PN533_I2C=m
CONFIG_NFC_PN532_UART=m
CONFIG_NFC_MICROREAD=m
CONFIG_NFC_MICROREAD_I2C=m
# CONFIG_NFC_MRVL_USB is not set
# CONFIG_NFC_MRVL_UART is not set
CONFIG_NFC_ST21NFCA=m
CONFIG_NFC_ST21NFCA_I2C=m
CONFIG_NFC_ST_NCI=m
CONFIG_NFC_ST_NCI_I2C=m
CONFIG_NFC_NXP_NCI=m
CONFIG_NFC_NXP_NCI_I2C=m
CONFIG_NFC_S3FWRN5=m
CONFIG_NFC_S3FWRN5_I2C=m
# CONFIG_NFC_S3FWRN82_UART is not set
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=m
CONFIG_NET_IFE=y
CONFIG_LWTUNNEL=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=y
# CONFIG_ETHTOOL_NETLINK is not set
CONFIG_NETDEV_ADDR_LIST_TEST=m

#
# Device Drivers
#
CONFIG_ARM_AMBA=y
CONFIG_HAVE_PCI=y
CONFIG_FORCE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_DOMAINS_GENERIC=y
CONFIG_PCI_SYSCALL=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEFAULT is not set
CONFIG_PCIEASPM_POWERSAVE=y
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
# CONFIG_PCIE_PTM is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
CONFIG_PCI_DEBUG=y
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
# CONFIG_PCI_STUB is not set
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_IOV=y
# CONFIG_PCI_PRI is not set
CONFIG_PCI_PASID=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# PCI controller drivers
#
# CONFIG_PCI_AARDVARK is not set
CONFIG_PCIE_XILINX_NWL=y
CONFIG_PCI_FTPCI100=y
# CONFIG_PCI_IXP4XX is not set
CONFIG_PCI_TEGRA=y
CONFIG_PCI_RCAR_GEN2=y
# CONFIG_PCIE_RCAR_HOST is not set
CONFIG_PCI_HOST_COMMON=y
CONFIG_PCI_HOST_GENERIC=y
CONFIG_PCIE_XILINX=y
CONFIG_PCIE_XILINX_CPM=y
CONFIG_PCI_XGENE=y
# CONFIG_PCI_XGENE_MSI is not set
CONFIG_PCI_V3_SEMI=y
# CONFIG_PCI_VERSATILE is not set
CONFIG_PCIE_IPROC=m
# CONFIG_PCIE_IPROC_PLATFORM is not set
CONFIG_PCIE_IPROC_BCMA=m
CONFIG_PCIE_IPROC_MSI=y
CONFIG_PCIE_ALTERA=y
CONFIG_PCIE_ALTERA_MSI=y
CONFIG_PCI_HOST_THUNDER_PEM=y
# CONFIG_PCI_HOST_THUNDER_ECAM is not set
# CONFIG_PCIE_ROCKCHIP_HOST is not set
# CONFIG_PCIE_MEDIATEK is not set
# CONFIG_PCIE_MEDIATEK_GEN3 is not set
CONFIG_PCIE_BRCMSTB=y
# CONFIG_PCI_LOONGSON is not set
CONFIG_PCIE_MICROCHIP_HOST=y
CONFIG_PCIE_APPLE_MSI_DOORBELL_ADDR=0xfffff000
CONFIG_PCIE_APPLE=y
CONFIG_PCIE_MT7621=m

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
# CONFIG_PCI_DRA7XX_HOST is not set
# CONFIG_PCIE_DW_PLAT_HOST is not set
CONFIG_PCI_EXYNOS=y
# CONFIG_PCI_IMX6 is not set
# CONFIG_PCIE_SPEAR13XX is not set
# CONFIG_PCI_KEYSTONE_HOST is not set
# CONFIG_PCI_LAYERSCAPE is not set
CONFIG_PCI_HISI=y
CONFIG_PCIE_QCOM=y
# CONFIG_PCIE_ARMADA_8K is not set
# CONFIG_PCIE_ARTPEC6_HOST is not set
CONFIG_PCIE_ROCKCHIP_DW_HOST=y
# CONFIG_PCIE_INTEL_GW is not set
# CONFIG_PCIE_KEEMBAY_HOST is not set
CONFIG_PCIE_KIRIN=m
# CONFIG_PCIE_HISI_STB is not set
CONFIG_PCI_MESON=y
CONFIG_PCIE_TEGRA194=y
CONFIG_PCIE_TEGRA194_HOST=y
# CONFIG_PCIE_VISCONTI_HOST is not set
# CONFIG_PCIE_UNIPHIER is not set
CONFIG_PCIE_AL=y
# CONFIG_PCIE_FU740 is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# CONFIG_PCIE_MOBIVEIL_PLAT is not set
# CONFIG_PCIE_LAYERSCAPE_GEN4 is not set
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
CONFIG_PCIE_CADENCE=y
CONFIG_PCIE_CADENCE_HOST=y
CONFIG_PCIE_CADENCE_PLAT=y
CONFIG_PCIE_CADENCE_PLAT_HOST=y
# CONFIG_PCI_J721E_HOST is not set
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=m
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
CONFIG_PCCARD=m
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
# CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
CONFIG_RAPIDIO_DEBUG=y
CONFIG_RAPIDIO_ENUM_BASIC=m
CONFIG_RAPIDIO_CHMAN=y
CONFIG_RAPIDIO_MPORT_CDEV=y

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_CPS_XX=y
CONFIG_RAPIDIO_CPS_GEN2=m
# CONFIG_RAPIDIO_RXS_GEN3 is not set
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
# CONFIG_DEVTMPFS is not set
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
# CONFIG_FW_LOADER_COMPRESS is not set
# CONFIG_FW_CACHE is not set
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_SOC_BUS=y
CONFIG_REGMAP=y
CONFIG_REGMAP_AC97=m
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=m
CONFIG_REGMAP_W1=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SOUNDWIRE=m
CONFIG_REGMAP_SOUNDWIRE_MBQ=m
CONFIG_REGMAP_SCCB=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_ARM_INTEGRATOR_LM is not set
CONFIG_BRCMSTB_GISB_ARB=y
CONFIG_BT1_APB=y
# CONFIG_BT1_AXI is not set
# CONFIG_HISILICON_LPC is not set
CONFIG_INTEL_IXP4XX_EB=y
# CONFIG_QCOM_EBI2 is not set
CONFIG_VEXPRESS_CONFIG=m
# CONFIG_FSL_MC_BUS is not set
# CONFIG_MHI_BUS is not set
CONFIG_MHI_BUS_EP=y
# end of Bus devices

CONFIG_CONNECTOR=y
# CONFIG_PROC_EVENTS is not set

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# CONFIG_ARM_SCMI_PROTOCOL is not set
# CONFIG_ARM_SCMI_POWER_DOMAIN is not set
# end of ARM System Control and Management Interface Protocol

CONFIG_ARM_SCPI_POWER_DOMAIN=m
CONFIG_FW_CFG_SYSFS=m
CONFIG_FW_CFG_SYSFS_CMDLINE=y
CONFIG_QCOM_SCM=y
CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT=y
# CONFIG_BCM47XX_NVRAM is not set
CONFIG_TEE_BNXT_FW=m
CONFIG_CS_DSP=m
# CONFIG_GOOGLE_FIRMWARE is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=m
CONFIG_GNSS_SERIAL=m
CONFIG_GNSS_MTK_SERIAL=m
CONFIG_GNSS_SIRF_SERIAL=m
CONFIG_GNSS_UBX_SERIAL=m
CONFIG_GNSS_USB=m
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=m
# CONFIG_MTD_BCM63XX_PARTS is not set
CONFIG_MTD_CMDLINE_PARTS=m
# CONFIG_MTD_OF_PARTS is not set
# CONFIG_MTD_PARSER_IMAGETAG is not set
CONFIG_MTD_AFS_PARTS=m
CONFIG_MTD_PARSER_TRX=m
CONFIG_MTD_SHARPSL_PARTS=m
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
# CONFIG_MTD_BLOCK is not set
CONFIG_MTD_BLOCK_RO=m

#
# Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
#
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
CONFIG_SSFDC=m
CONFIG_SM_FTL=m
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=m
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=m
CONFIG_MTD_CFI_ADV_OPTIONS=y
CONFIG_MTD_CFI_NOSWAP=y
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
CONFIG_MTD_CFI_GEOMETRY=y
# CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
CONFIG_MTD_MAP_BANK_WIDTH_32=y
# CONFIG_MTD_CFI_I1 is not set
# CONFIG_MTD_CFI_I2 is not set
CONFIG_MTD_CFI_I4=y
# CONFIG_MTD_CFI_I8 is not set
# CONFIG_MTD_OTP is not set
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=m
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=m
CONFIG_MTD_RAM=m
# CONFIG_MTD_ROM is not set
CONFIG_MTD_ABSENT=m
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=m
# CONFIG_MTD_PHYSMAP_COMPAT is not set
CONFIG_MTD_PHYSMAP_OF=y
# CONFIG_MTD_PHYSMAP_BT1_ROM is not set
# CONFIG_MTD_PHYSMAP_VERSATILE is not set
CONFIG_MTD_PHYSMAP_GEMINI=y
CONFIG_MTD_PHYSMAP_IXP4XX=y
# CONFIG_MTD_PHYSMAP_GPIO_ADDR is not set
CONFIG_MTD_SC520CDP=m
CONFIG_MTD_NETSC520=m
# CONFIG_MTD_TS5500 is not set
CONFIG_MTD_PCI=m
CONFIG_MTD_INTEL_VR_NOR=m
CONFIG_MTD_PLATRAM=m
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=m
CONFIG_MTD_PMC551_BUGFIX=y
CONFIG_MTD_PMC551_DEBUG=y
CONFIG_MTD_SPEAR_SMI=m
CONFIG_MTD_SLRAM=m
# CONFIG_MTD_PHRAM is not set
CONFIG_MTD_MTDRAM=m
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=m
# CONFIG_MTD_ONENAND is not set
CONFIG_MTD_RAW_NAND=m

#
# Raw/parallel NAND flash controllers
#
CONFIG_MTD_NAND_DENALI=m
# CONFIG_MTD_NAND_DENALI_PCI is not set
CONFIG_MTD_NAND_DENALI_DT=m
CONFIG_MTD_NAND_AMS_DELTA=m
CONFIG_MTD_NAND_SHARPSL=m
CONFIG_MTD_NAND_CAFE=m
# CONFIG_MTD_NAND_ATMEL is not set
CONFIG_MTD_NAND_MARVELL=m
CONFIG_MTD_NAND_SLC_LPC32XX=m
CONFIG_MTD_NAND_MLC_LPC32XX=m
CONFIG_MTD_NAND_TMIO=m
CONFIG_MTD_NAND_BRCMNAND=m
CONFIG_MTD_NAND_BRCMNAND_BCMA=m
CONFIG_MTD_NAND_BCM47XXNFLASH=m
# CONFIG_MTD_NAND_OXNAS is not set
# CONFIG_MTD_NAND_FSL_IFC is not set
# CONFIG_MTD_NAND_VF610_NFC is not set
CONFIG_MTD_NAND_MXC=m
# CONFIG_MTD_NAND_SH_FLCTL is not set
CONFIG_MTD_NAND_DAVINCI=m
# CONFIG_MTD_NAND_TXX9NDFMC is not set
# CONFIG_MTD_NAND_JZ4780 is not set
CONFIG_MTD_NAND_FSMC=m
CONFIG_MTD_NAND_SUNXI=m
CONFIG_MTD_NAND_HISI504=m
CONFIG_MTD_NAND_QCOM=m
CONFIG_MTD_NAND_MTK=m
# CONFIG_MTD_NAND_MXIC is not set
CONFIG_MTD_NAND_TEGRA=m
CONFIG_MTD_NAND_STM32_FMC2=m
CONFIG_MTD_NAND_MESON=m
CONFIG_MTD_NAND_GPIO=m
CONFIG_MTD_NAND_PLATFORM=m
CONFIG_MTD_NAND_CADENCE=m
CONFIG_MTD_NAND_ARASAN=m
CONFIG_MTD_NAND_INTEL_LGM=m
# CONFIG_MTD_NAND_RENESAS is not set

#
# Misc
#
CONFIG_MTD_SM_COMMON=m
CONFIG_MTD_NAND_NANDSIM=m
CONFIG_MTD_NAND_RICOH=m
CONFIG_MTD_NAND_DISKONCHIP=m
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=y

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
# CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
CONFIG_MTD_NAND_ECC_SW_BCH=y
# CONFIG_MTD_NAND_ECC_MXIC is not set
CONFIG_MTD_NAND_ECC_MEDIATEK=m
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=m
CONFIG_MTD_QINFO_PROBE=m
CONFIG_MTD_LPDDR2_NVM=m
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
CONFIG_MTD_UBI_FASTMAP=y
CONFIG_MTD_UBI_GLUEBI=m
CONFIG_MTD_UBI_BLOCK=y
CONFIG_MTD_HYPERBUS=m
CONFIG_HBMC_AM654=m
CONFIG_DTC=y
CONFIG_OF=y
CONFIG_OF_UNITTEST=y
CONFIG_OF_ALL_DTBS=y
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_RESERVED_MEM=y
CONFIG_OF_RESOLVE=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_SERIAL=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_AX88796=y
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
# CONFIG_BLK_DEV is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_MULTIPATH is not set
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_PASSTHRU=y
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
# CONFIG_NVME_TARGET_FCLOOP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
CONFIG_AD525X_DPOT=m
# CONFIG_AD525X_DPOT_I2C is not set
CONFIG_DUMMY_IRQ=y
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=y
# CONFIG_TIFM_7XX1 is not set
CONFIG_ICS932S401=m
CONFIG_ATMEL_SSC=m
CONFIG_ENCLOSURE_SERVICES=y
CONFIG_HP_ILO=y
CONFIG_QCOM_COINCELL=m
CONFIG_QCOM_FASTRPC=m
CONFIG_APDS9802ALS=y
# CONFIG_ISL29003 is not set
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=y
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
CONFIG_DS1682=y
CONFIG_PCH_PHUB=m
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
CONFIG_PCI_ENDPOINT_TEST=y
CONFIG_XILINX_SDFEC=y
CONFIG_MISC_RTSX=y
CONFIG_HISI_HIKEY_USB=m
CONFIG_OPEN_DICE=m
CONFIG_C2PORT=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

CONFIG_CB710_CORE=m
CONFIG_CB710_DEBUG=y
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
CONFIG_TI_ST=y
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
# CONFIG_ALTERA_STAPL is not set
CONFIG_ECHO=y
CONFIG_BCM_VK=m
CONFIG_BCM_VK_TTY=y
CONFIG_MISC_ALCOR_PCI=y
CONFIG_MISC_RTSX_PCI=y
CONFIG_MISC_RTSX_USB=y
# CONFIG_HABANA_AI is not set
CONFIG_UACCE=y
CONFIG_PVPANIC=y
CONFIG_PVPANIC_MMIO=m
# CONFIG_PVPANIC_PCI is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
CONFIG_CHR_DEV_ST=y
CONFIG_CHR_DEV_SG=m
# CONFIG_BLK_DEV_BSG is not set
CONFIG_CHR_DEV_SCH=y
# CONFIG_SCSI_ENCLOSURE is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
CONFIG_SCSI_ISCSI_ATTRS=y
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=y
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_BNX2_ISCSI=y
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=y
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=m
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC79XX=y
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=5000
# CONFIG_AIC79XX_BUILD_FIRMWARE is not set
CONFIG_AIC79XX_DEBUG_ENABLE=y
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_AIC79XX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC94XX=y
# CONFIG_AIC94XX_DEBUG is not set
CONFIG_SCSI_HISI_SAS=m
CONFIG_SCSI_HISI_SAS_DEBUGFS_DEFAULT_ENABLE=y
# CONFIG_SCSI_MVSAS is not set
CONFIG_SCSI_MVUMI=m
CONFIG_SCSI_ADVANSYS=y
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=m
# CONFIG_MEGARAID_MAILBOX is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
CONFIG_SCSI_SMARTPQI=m
CONFIG_SCSI_HPTIOP=y
CONFIG_SCSI_MYRB=y
CONFIG_SCSI_MYRS=y
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
CONFIG_SCSI_FDOMAIN=m
CONFIG_SCSI_FDOMAIN_PCI=m
CONFIG_SCSI_IPS=y
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_PPA=m
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_IZIP_EPP16=y
CONFIG_SCSI_IZIP_SLOW_CTR=y
CONFIG_SCSI_STEX=m
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
CONFIG_SCSI_SYM53C8XX_MMIO=y
CONFIG_SCSI_IPR=y
# CONFIG_SCSI_IPR_TRACE is not set
CONFIG_SCSI_IPR_DUMP=y
CONFIG_SCSI_QLOGIC_1280=y
# CONFIG_SCSI_QLA_ISCSI is not set
CONFIG_SCSI_DC395x=y
CONFIG_SCSI_AM53C974=y
# CONFIG_SCSI_NSP32 is not set
CONFIG_SCSI_WD719X=y
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
# CONFIG_SCSI_PM8001 is not set
CONFIG_SCSI_VIRTIO=m
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
# CONFIG_SCSI_DH_HP_SW is not set
CONFIG_SCSI_DH_EMC=m
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
CONFIG_SATA_AHCI_PLATFORM=y
CONFIG_AHCI_BRCM=y
CONFIG_AHCI_DA850=m
# CONFIG_AHCI_DM816 is not set
CONFIG_AHCI_IMX=y
CONFIG_AHCI_CEVA=m
# CONFIG_AHCI_MTK is not set
# CONFIG_AHCI_MVEBU is not set
# CONFIG_AHCI_SUNXI is not set
CONFIG_AHCI_TEGRA=y
CONFIG_AHCI_XGENE=m
CONFIG_AHCI_QORIQ=y
# CONFIG_SATA_FSL is not set
# CONFIG_SATA_GEMINI is not set
CONFIG_SATA_AHCI_SEATTLE=y
CONFIG_SATA_INIC162X=y
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
CONFIG_SATA_QSTOR=m
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
# CONFIG_ATA_PIIX is not set
CONFIG_SATA_HIGHBANK=y
CONFIG_SATA_MV=y
CONFIG_SATA_NV=y
CONFIG_SATA_PROMISE=m
# CONFIG_SATA_RCAR is not set
# CONFIG_SATA_SIL is not set
CONFIG_SATA_SIS=y
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=y
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=m
# CONFIG_PATA_AMD is not set
CONFIG_PATA_ARTOP=m
# CONFIG_PATA_ATIIXP is not set
CONFIG_PATA_ATP867X=m
CONFIG_PATA_BK3710=m
# CONFIG_PATA_CMD64X is not set
CONFIG_PATA_CS5520=y
# CONFIG_PATA_CS5530 is not set
CONFIG_PATA_CS5536=m
CONFIG_PATA_CYPRESS=m
CONFIG_PATA_EFAR=y
# CONFIG_PATA_HPT366 is not set
CONFIG_PATA_HPT37X=y
CONFIG_PATA_HPT3X2N=m
# CONFIG_PATA_HPT3X3 is not set
CONFIG_PATA_IMX=y
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
CONFIG_PATA_JMICRON=m
CONFIG_PATA_MARVELL=y
CONFIG_PATA_NETCELL=m
# CONFIG_PATA_NINJA32 is not set
CONFIG_PATA_NS87415=m
# CONFIG_PATA_OLDPIIX is not set
CONFIG_PATA_OPTIDMA=y
CONFIG_PATA_PDC2027X=m
# CONFIG_PATA_PDC_OLD is not set
CONFIG_PATA_RADISYS=m
CONFIG_PATA_RDC=y
# CONFIG_PATA_SC1200 is not set
CONFIG_PATA_SCH=m
CONFIG_PATA_SERVERWORKS=y
CONFIG_PATA_SIL680=y
CONFIG_PATA_SIS=y
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_VIA=m
CONFIG_PATA_PXA=y
CONFIG_PATA_WINBOND=y

#
# PIO-only SFF controllers
#
CONFIG_PATA_CMD640_PCI=y
# CONFIG_PATA_IXP4XX_CF is not set
CONFIG_PATA_MPIIX=y
CONFIG_PATA_NS87410=y
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set
CONFIG_PATA_SAMSUNG_CF=m

#
# Generic fallback / legacy drivers
#
CONFIG_ATA_GENERIC=m
CONFIG_PATA_LEGACY=y
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
CONFIG_FUSION=y
# CONFIG_FUSION_SPI is not set
CONFIG_FUSION_SAS=y
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
CONFIG_FIREWIRE_NOSY=m
# end of IEEE 1394 (FireWire) support

CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_DUMMY is not set
CONFIG_EQUALIZER=y
# CONFIG_NET_FC is not set
CONFIG_IFB=m
CONFIG_NET_TEAM=m
# CONFIG_NET_TEAM_MODE_BROADCAST is not set
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
# CONFIG_NET_TEAM_MODE_RANDOM is not set
# CONFIG_NET_TEAM_MODE_ACTIVEBACKUP is not set
# CONFIG_NET_TEAM_MODE_LOADBALANCE is not set
CONFIG_MACVLAN=m
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
# CONFIG_NETCONSOLE_DYNAMIC is not set
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
# CONFIG_NTB_NETDEV is not set
CONFIG_RIONET=y
CONFIG_RIONET_TX_SIZE=128
CONFIG_RIONET_RX_SIZE=128
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=y
CONFIG_NLMON=y
CONFIG_SUNGEM_PHY=y
CONFIG_ARCNET=y
CONFIG_ARCNET_1201=m
# CONFIG_ARCNET_1051 is not set
# CONFIG_ARCNET_RAW is not set
CONFIG_ARCNET_CAP=m
# CONFIG_ARCNET_COM90xx is not set
CONFIG_ARCNET_COM90xxIO=m
CONFIG_ARCNET_RIM_I=m
CONFIG_ARCNET_COM20020=y
CONFIG_ARCNET_COM20020_PCI=m
CONFIG_CAIF_DRIVERS=y
CONFIG_CAIF_TTY=m
# CONFIG_CAIF_VIRTIO is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=m
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
# CONFIG_TYPHOON is not set
# CONFIG_NET_VENDOR_ACTIONS is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
CONFIG_SLICOSS=y
CONFIG_NET_VENDOR_ALTEON=y
CONFIG_ACENIC=y
CONFIG_ACENIC_OMIT_TIGON_I=y
CONFIG_ALTERA_TSE=m
# CONFIG_NET_VENDOR_AMAZON is not set
# CONFIG_NET_VENDOR_AMD is not set
# CONFIG_NET_XGENE is not set
# CONFIG_NET_XGENE_V2 is not set
# CONFIG_NET_VENDOR_AQUANTIA is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_ARC_EMAC_CORE=y
# CONFIG_ARC_EMAC is not set
CONFIG_EMAC_ROCKCHIP=y
CONFIG_NET_VENDOR_ASIX=y
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=y
# CONFIG_ATL1 is not set
CONFIG_ATL1E=m
CONFIG_ATL1C=m
CONFIG_ALX=m
CONFIG_CX_ECAT=m
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCM4908_ENET is not set
# CONFIG_BCMGENET is not set
CONFIG_BNX2=y
CONFIG_CNIC=y
CONFIG_TIGON3=m
CONFIG_TIGON3_HWMON=y
CONFIG_BNX2X=m
# CONFIG_BNX2X_SRIOV is not set
# CONFIG_BGMAC_BCMA is not set
# CONFIG_BGMAC_PLATFORM is not set
CONFIG_SYSTEMPORT=y
CONFIG_BNXT=m
CONFIG_BNXT_SRIOV=y
# CONFIG_BNXT_FLOWER_OFFLOAD is not set
CONFIG_BNXT_HWMON=y
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_CALXEDA_XGMAC=y
# CONFIG_NET_VENDOR_CAVIUM is not set
CONFIG_NET_VENDOR_CHELSIO=y
CONFIG_CHELSIO_T1=m
# CONFIG_CHELSIO_T1_1G is not set
CONFIG_CHELSIO_T4=m
CONFIG_CHELSIO_T4VF=y
CONFIG_CHELSIO_INLINE_CRYPTO=y
CONFIG_NET_VENDOR_CIRRUS=y
CONFIG_CS89x0=m
CONFIG_CS89x0_PLATFORM=m
CONFIG_EP93XX_ETH=y
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=y
# CONFIG_NET_VENDOR_CORTINA is not set
CONFIG_NET_VENDOR_DAVICOM=y
CONFIG_DM9000=m
# CONFIG_DM9000_FORCE_SIMPLE_PHY_POLL is not set
CONFIG_DNET=y
# CONFIG_NET_VENDOR_DEC is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
CONFIG_SUNDANCE=y
CONFIG_SUNDANCE_MMIO=y
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
# CONFIG_BE2NET_HWMON is not set
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
# CONFIG_NET_VENDOR_ENGLEDER is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_EZCHIP_NPS_MANAGEMENT_ENET=m
# CONFIG_NET_VENDOR_FARADAY is not set
CONFIG_NET_VENDOR_FREESCALE=y
# CONFIG_FEC is not set
# CONFIG_FSL_FMAN is not set
CONFIG_FSL_PQ_MDIO=y
CONFIG_FSL_XGMAC_MDIO=y
CONFIG_GIANFAR=y
CONFIG_FSL_ENETC=y
CONFIG_FSL_ENETC_VF=m
CONFIG_FSL_ENETC_IERB=y
CONFIG_FSL_ENETC_MDIO=y
CONFIG_FSL_ENETC_QOS=y
# CONFIG_NET_VENDOR_FUNGIBLE is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_NET_VENDOR_HISILICON is not set
# CONFIG_NET_VENDOR_HUAWEI is not set
# CONFIG_NET_VENDOR_INTEL is not set
CONFIG_JME=m
CONFIG_KORINA=m
# CONFIG_NET_VENDOR_LITEX is not set
# CONFIG_NET_VENDOR_MARVELL is not set
# CONFIG_NET_VENDOR_MEDIATEK is not set
# CONFIG_NET_VENDOR_MELLANOX is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
# CONFIG_NET_VENDOR_MICROSOFT is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
CONFIG_NI_XGE_MANAGEMENT_ENET=y
CONFIG_NET_VENDOR_NATSEMI=y
CONFIG_NATSEMI=m
# CONFIG_NS83820 is not set
# CONFIG_NET_VENDOR_NETERION is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NFP=m
CONFIG_NFP_DEBUG=y
# CONFIG_NET_VENDOR_8390 is not set
CONFIG_NET_VENDOR_NVIDIA=y
CONFIG_FORCEDETH=m
CONFIG_LPC_ENET=y
# CONFIG_NET_VENDOR_OKI is not set
CONFIG_ETHOC=m
# CONFIG_NET_VENDOR_PACKET_ENGINES is not set
# CONFIG_NET_VENDOR_PENSANDO is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
# CONFIG_NET_VENDOR_QUALCOMM is not set
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
# CONFIG_NET_VENDOR_RENESAS is not set
# CONFIG_NET_VENDOR_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
CONFIG_SXGBE_ETH=m
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SILAN=y
CONFIG_SC92031=m
# CONFIG_NET_VENDOR_SIS is not set
# CONFIG_NET_VENDOR_SOLARFLARE is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_SMC91X=y
CONFIG_EPIC100=m
# CONFIG_SMC911X is not set
CONFIG_SMSC911X=m
CONFIG_SMSC9420=y
# CONFIG_NET_VENDOR_SOCIONEXT is not set
CONFIG_NET_VENDOR_STMICRO=y
CONFIG_STMMAC_ETH=m
CONFIG_STMMAC_PLATFORM=m
CONFIG_DWMAC_DWC_QOS_ETH=m
# CONFIG_DWMAC_GENERIC is not set
# CONFIG_DWMAC_ANARION is not set
CONFIG_DWMAC_INGENIC=m
# CONFIG_DWMAC_IPQ806X is not set
# CONFIG_DWMAC_LPC18XX is not set
# CONFIG_DWMAC_MEDIATEK is not set
CONFIG_DWMAC_MESON=m
# CONFIG_DWMAC_OXNAS is not set
CONFIG_DWMAC_QCOM_ETHQOS=m
CONFIG_DWMAC_ROCKCHIP=m
CONFIG_DWMAC_SOCFPGA=m
# CONFIG_DWMAC_STI is not set
CONFIG_DWMAC_STM32=m
CONFIG_DWMAC_SUNXI=m
CONFIG_DWMAC_SUN8I=m
CONFIG_DWMAC_IMX8=m
# CONFIG_DWMAC_INTEL_PLAT is not set
CONFIG_DWMAC_VISCONTI=m
CONFIG_DWMAC_LOONGSON=m
CONFIG_STMMAC_PCI=m
CONFIG_NET_VENDOR_SUN=y
CONFIG_HAPPYMEAL=m
CONFIG_SUNGEM=y
CONFIG_CASSINI=m
CONFIG_NIU=y
CONFIG_NET_VENDOR_SUNPLUS=y
CONFIG_SP7021_EMAC=y
# CONFIG_NET_VENDOR_SYNOPSYS is not set
CONFIG_NET_VENDOR_TEHUTI=y
CONFIG_TEHUTI=y
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_VERTEXCOM is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_NET_VENDOR_XILINX is not set
CONFIG_FDDI=m
CONFIG_DEFXX=m
CONFIG_SKFP=m
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=m
# CONFIG_MESON_GXL_PHY is not set
# CONFIG_ADIN_PHY is not set
CONFIG_ADIN1100_PHY=m
CONFIG_AQUANTIA_PHY=m
CONFIG_AX88796B_PHY=m
CONFIG_BROADCOM_PHY=m
CONFIG_BCM54140_PHY=y
CONFIG_BCM63XX_PHY=y
# CONFIG_BCM7XXX_PHY is not set
CONFIG_BCM84881_PHY=y
CONFIG_BCM87XX_PHY=y
CONFIG_BCM_CYGNUS_PHY=m
CONFIG_BCM_NET_PHYLIB=y
CONFIG_CICADA_PHY=y
CONFIG_CORTINA_PHY=m
CONFIG_DAVICOM_PHY=y
# CONFIG_ICPLUS_PHY is not set
CONFIG_LXT_PHY=y
CONFIG_INTEL_XWAY_PHY=m
# CONFIG_LSI_ET1011C_PHY is not set
CONFIG_MARVELL_PHY=m
CONFIG_MARVELL_10G_PHY=m
CONFIG_MARVELL_88X2222_PHY=m
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
CONFIG_MICREL_PHY=m
# CONFIG_MICROCHIP_PHY is not set
CONFIG_MICROCHIP_T1_PHY=y
# CONFIG_MICROSEMI_PHY is not set
CONFIG_MOTORCOMM_PHY=m
CONFIG_NATIONAL_PHY=y
CONFIG_NXP_C45_TJA11XX_PHY=m
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_AT803X_PHY is not set
CONFIG_QSEMI_PHY=y
CONFIG_REALTEK_PHY=m
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=y
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
CONFIG_DP83822_PHY=m
CONFIG_DP83TC811_PHY=m
CONFIG_DP83848_PHY=m
CONFIG_DP83867_PHY=y
# CONFIG_DP83869_PHY is not set
CONFIG_DP83TD510_PHY=y
CONFIG_VITESSE_PHY=y
# CONFIG_XILINX_GMII2RGMII is not set

#
# MCTP Device Drivers
#
CONFIG_MCTP_SERIAL=m
# CONFIG_MCTP_TRANSPORT_I2C is not set
# end of MCTP Device Drivers

CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_OF_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_SUN4I is not set
# CONFIG_MDIO_XGENE is not set
# CONFIG_MDIO_ASPEED is not set
# CONFIG_MDIO_BITBANG is not set
CONFIG_MDIO_BCM_IPROC=y
CONFIG_MDIO_BCM_UNIMAC=y
CONFIG_MDIO_CAVIUM=y
CONFIG_MDIO_HISI_FEMAC=y
CONFIG_MDIO_MVUSB=m
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_MOXART is not set
CONFIG_MDIO_OCTEON=y
CONFIG_MDIO_IPQ4019=m
CONFIG_MDIO_IPQ8064=m

#
# MDIO Multiplexers
#
CONFIG_MDIO_BUS_MUX=y
CONFIG_MDIO_BUS_MUX_MESON_G12A=y
CONFIG_MDIO_BUS_MUX_BCM6368=m
CONFIG_MDIO_BUS_MUX_BCM_IPROC=y
# CONFIG_MDIO_BUS_MUX_GPIO is not set
# CONFIG_MDIO_BUS_MUX_MULTIPLEXER is not set
CONFIG_MDIO_BUS_MUX_MMIOREG=m

#
# PCS device drivers
#
CONFIG_PCS_XPCS=m
CONFIG_PCS_LYNX=y
# end of PCS device drivers

CONFIG_PLIP=y
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
# CONFIG_PPP_DEFLATE is not set
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_MPPE=m
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPPOE=m
# CONFIG_PPP_ASYNC is not set
# CONFIG_PPP_SYNC_TTY is not set
CONFIG_SLIP=m
CONFIG_SLHC=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
CONFIG_USB_KAWETH=y
CONFIG_USB_PEGASUS=y
CONFIG_USB_RTL8150=m
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_HSO is not set
CONFIG_USB_IPHETH=m
# CONFIG_WLAN is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

CONFIG_NET_FAILOVER=y
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
# CONFIG_INPUT_SPARSEKMAP is not set
CONFIG_INPUT_MATRIXKMAP=y
CONFIG_INPUT_VIVALDIFMAP=m

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADP5588=m
CONFIG_KEYBOARD_ADP5589=y
# CONFIG_KEYBOARD_ATKBD is not set
CONFIG_KEYBOARD_QT1050=m
# CONFIG_KEYBOARD_QT1070 is not set
CONFIG_KEYBOARD_QT2160=m
CONFIG_KEYBOARD_CLPS711X=m
CONFIG_KEYBOARD_DLINK_DIR685=y
CONFIG_KEYBOARD_LKKBD=m
CONFIG_KEYBOARD_EP93XX=m
CONFIG_KEYBOARD_GPIO=y
# CONFIG_KEYBOARD_GPIO_POLLED is not set
CONFIG_KEYBOARD_TCA6416=y
CONFIG_KEYBOARD_TCA8418=m
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
CONFIG_KEYBOARD_LM8333=y
CONFIG_KEYBOARD_MAX7359=y
CONFIG_KEYBOARD_MCS=y
CONFIG_KEYBOARD_MPR121=y
CONFIG_KEYBOARD_SNVS_PWRKEY=y
# CONFIG_KEYBOARD_IMX is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_KEYBOARD_OPENCORES=m
# CONFIG_KEYBOARD_PMIC8XXX is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
CONFIG_KEYBOARD_GOLDFISH_EVENTS=y
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_KEYBOARD_ST_KEYSCAN=y
# CONFIG_KEYBOARD_SUNKBD is not set
CONFIG_KEYBOARD_SH_KEYSC=y
# CONFIG_KEYBOARD_STMPE is not set
CONFIG_KEYBOARD_IQS62X=y
# CONFIG_KEYBOARD_OMAP4 is not set
CONFIG_KEYBOARD_TC3589X=y
CONFIG_KEYBOARD_TM2_TOUCHKEY=m
CONFIG_KEYBOARD_XTKBD=m
CONFIG_KEYBOARD_CROS_EC=m
CONFIG_KEYBOARD_CAP11XX=m
CONFIG_KEYBOARD_BCM=y
CONFIG_KEYBOARD_MT6779=y
# CONFIG_KEYBOARD_MTK_PMIC is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
CONFIG_MOUSE_SERIAL=y
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=y
CONFIG_MOUSE_CYAPA=y
CONFIG_MOUSE_ELAN_I2C=m
# CONFIG_MOUSE_ELAN_I2C_I2C is not set
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=y
CONFIG_MOUSE_GPIO=m
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
CONFIG_JOYSTICK_A3D=y
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
CONFIG_JOYSTICK_GRIP=m
CONFIG_JOYSTICK_GRIP_MP=m
CONFIG_JOYSTICK_GUILLEMOT=m
CONFIG_JOYSTICK_INTERACT=m
CONFIG_JOYSTICK_SIDEWINDER=m
CONFIG_JOYSTICK_TMDC=y
# CONFIG_JOYSTICK_IFORCE is not set
CONFIG_JOYSTICK_WARRIOR=y
# CONFIG_JOYSTICK_MAGELLAN is not set
CONFIG_JOYSTICK_SPACEORB=y
CONFIG_JOYSTICK_SPACEBALL=m
CONFIG_JOYSTICK_STINGER=y
CONFIG_JOYSTICK_TWIDJOY=m
CONFIG_JOYSTICK_ZHENHUA=y
CONFIG_JOYSTICK_DB9=y
# CONFIG_JOYSTICK_GAMECON is not set
CONFIG_JOYSTICK_TURBOGRAFX=y
CONFIG_JOYSTICK_AS5011=y
# CONFIG_JOYSTICK_JOYDUMP is not set
CONFIG_JOYSTICK_XPAD=m
# CONFIG_JOYSTICK_XPAD_FF is not set
# CONFIG_JOYSTICK_XPAD_LEDS is not set
CONFIG_JOYSTICK_WALKERA0701=m
# CONFIG_JOYSTICK_PXRC is not set
CONFIG_JOYSTICK_QWIIC=y
CONFIG_JOYSTICK_FSIA6B=m
CONFIG_JOYSTICK_SENSEHAT=y
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
CONFIG_TABLET_USB_HANWANG=y
CONFIG_TABLET_USB_KBTAB=y
CONFIG_TABLET_USB_PEGASUS=y
CONFIG_TABLET_SERIAL_WACOM4=m
CONFIG_INPUT_TOUCHSCREEN=y
# CONFIG_TOUCHSCREEN_AD7879 is not set
CONFIG_TOUCHSCREEN_AR1021_I2C=m
CONFIG_TOUCHSCREEN_ATMEL_MXT=m
# CONFIG_TOUCHSCREEN_ATMEL_MXT_T37 is not set
CONFIG_TOUCHSCREEN_AUO_PIXCIR=m
CONFIG_TOUCHSCREEN_BU21013=y
CONFIG_TOUCHSCREEN_BU21029=y
CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=m
CONFIG_TOUCHSCREEN_CY8CTMA140=y
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
CONFIG_TOUCHSCREEN_DA9034=m
CONFIG_TOUCHSCREEN_DA9052=m
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
CONFIG_TOUCHSCREEN_HAMPSHIRE=m
CONFIG_TOUCHSCREEN_EETI=y
# CONFIG_TOUCHSCREEN_EGALAX is not set
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
CONFIG_TOUCHSCREEN_GOODIX=m
CONFIG_TOUCHSCREEN_HIDEEP=m
# CONFIG_TOUCHSCREEN_HYCON_HY46XX is not set
CONFIG_TOUCHSCREEN_ILI210X=y
# CONFIG_TOUCHSCREEN_ILITEK is not set
# CONFIG_TOUCHSCREEN_IPROC is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
CONFIG_TOUCHSCREEN_GUNZE=y
CONFIG_TOUCHSCREEN_EKTF2127=y
CONFIG_TOUCHSCREEN_ELAN=m
CONFIG_TOUCHSCREEN_ELO=y
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=y
CONFIG_TOUCHSCREEN_MAX11801=m
# CONFIG_TOUCHSCREEN_MCS5000 is not set
CONFIG_TOUCHSCREEN_MMS114=m
CONFIG_TOUCHSCREEN_MELFAS_MIP4=y
# CONFIG_TOUCHSCREEN_MSG2638 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
CONFIG_TOUCHSCREEN_IMAGIS=y
CONFIG_TOUCHSCREEN_IMX6UL_TSC=m
# CONFIG_TOUCHSCREEN_INEXIO is not set
CONFIG_TOUCHSCREEN_MK712=m
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
CONFIG_TOUCHSCREEN_RASPBERRYPI_FW=m
CONFIG_TOUCHSCREEN_MIGOR=y
CONFIG_TOUCHSCREEN_TOUCHRIGHT=m
CONFIG_TOUCHSCREEN_TOUCHWIN=y
# CONFIG_TOUCHSCREEN_TI_AM335X_TSC is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
CONFIG_TOUCHSCREEN_WM831X=y
# CONFIG_TOUCHSCREEN_WM97XX is not set
CONFIG_TOUCHSCREEN_USB_COMPOSITE=y
CONFIG_TOUCHSCREEN_MC13783=y
CONFIG_TOUCHSCREEN_USB_EGALAX=y
CONFIG_TOUCHSCREEN_USB_PANJIT=y
CONFIG_TOUCHSCREEN_USB_3M=y
CONFIG_TOUCHSCREEN_USB_ITM=y
CONFIG_TOUCHSCREEN_USB_ETURBO=y
CONFIG_TOUCHSCREEN_USB_GUNZE=y
CONFIG_TOUCHSCREEN_USB_DMC_TSC10=y
CONFIG_TOUCHSCREEN_USB_IRTOUCH=y
CONFIG_TOUCHSCREEN_USB_IDEALTEK=y
CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=y
CONFIG_TOUCHSCREEN_USB_GOTOP=y
CONFIG_TOUCHSCREEN_USB_JASTEC=y
CONFIG_TOUCHSCREEN_USB_ELO=y
CONFIG_TOUCHSCREEN_USB_E2I=y
CONFIG_TOUCHSCREEN_USB_ZYTRONIC=y
CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=y
CONFIG_TOUCHSCREEN_USB_NEXIO=y
CONFIG_TOUCHSCREEN_USB_EASYTOUCH=y
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TS4800 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
CONFIG_TOUCHSCREEN_TSC200X_CORE=y
CONFIG_TOUCHSCREEN_TSC2004=y
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
CONFIG_TOUCHSCREEN_SIS_I2C=y
CONFIG_TOUCHSCREEN_ST1232=m
CONFIG_TOUCHSCREEN_STMFTS=y
# CONFIG_TOUCHSCREEN_STMPE is not set
# CONFIG_TOUCHSCREEN_SUN4I is not set
CONFIG_TOUCHSCREEN_SUR40=m
CONFIG_TOUCHSCREEN_SX8654=y
CONFIG_TOUCHSCREEN_TPS6507X=m
CONFIG_TOUCHSCREEN_ZET6223=m
# CONFIG_TOUCHSCREEN_ZFORCE is not set
CONFIG_TOUCHSCREEN_ROHM_BU21023=m
CONFIG_TOUCHSCREEN_IQS5XX=y
CONFIG_TOUCHSCREEN_ZINITIX=y
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_PARKBD=m
CONFIG_SERIO_AMBAKMI=y
CONFIG_SERIO_PCIPS2=m
# CONFIG_SERIO_LIBPS2 is not set
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=m
CONFIG_SERIO_APBPS2=m
CONFIG_SERIO_OLPC_APSP=y
CONFIG_SERIO_SUN4I_PS2=m
CONFIG_SERIO_GPIO_PS2=y
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=m
CONFIG_GAMEPORT_EMU10K1=y
CONFIG_GAMEPORT_FM801=m
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_LDISC_AUTOLOAD is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=m
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_PCI=m
CONFIG_SERIAL_8250_EXAR=m
CONFIG_SERIAL_8250_MEN_MCB=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
CONFIG_SERIAL_8250_ASPEED_VUART=m
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
# CONFIG_SERIAL_8250_RSA is not set
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_BCM2835AUX is not set
CONFIG_SERIAL_8250_DW=m
# CONFIG_SERIAL_8250_EM is not set
CONFIG_SERIAL_8250_IOC3=m
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_OMAP=m
# CONFIG_SERIAL_8250_LPC18XX is not set
# CONFIG_SERIAL_8250_MT6577 is not set
CONFIG_SERIAL_8250_UNIPHIER=m
# CONFIG_SERIAL_8250_INGENIC is not set
CONFIG_SERIAL_8250_LPSS=m
CONFIG_SERIAL_8250_MID=m
CONFIG_SERIAL_8250_PERICOM=m
CONFIG_SERIAL_8250_PXA=m
CONFIG_SERIAL_8250_TEGRA=m
# CONFIG_SERIAL_8250_BCM7271 is not set
CONFIG_SERIAL_OF_PLATFORM=m

#
# Non-8250 serial port support
#
CONFIG_SERIAL_AMBA_PL010=y
CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
# CONFIG_SERIAL_AMBA_PL011 is not set
CONFIG_SERIAL_EARLYCON_ARM_SEMIHOST=y
CONFIG_SERIAL_ATMEL=y
# CONFIG_SERIAL_ATMEL_CONSOLE is not set
CONFIG_SERIAL_ATMEL_PDC=y
# CONFIG_SERIAL_ATMEL_TTYAT is not set
CONFIG_SERIAL_MESON=y
CONFIG_SERIAL_MESON_CONSOLE=y
CONFIG_SERIAL_CLPS711X=y
# CONFIG_SERIAL_CLPS711X_CONSOLE is not set
CONFIG_SERIAL_SAMSUNG=m
CONFIG_SERIAL_SAMSUNG_UARTS_4=y
CONFIG_SERIAL_SAMSUNG_UARTS=4
# CONFIG_SERIAL_SAMSUNG_CONSOLE is not set
CONFIG_SERIAL_TEGRA=y
CONFIG_SERIAL_IMX=m
CONFIG_SERIAL_IMX_CONSOLE=m
# CONFIG_SERIAL_IMX_EARLYCON is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_SH_SCI=m
CONFIG_SERIAL_SH_SCI_NR_UARTS=2
CONFIG_SERIAL_HS_LPC32XX=y
CONFIG_SERIAL_HS_LPC32XX_CONSOLE=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_ICOM is not set
CONFIG_SERIAL_JSM=y
CONFIG_SERIAL_MSM=y
CONFIG_SERIAL_MSM_CONSOLE=y
# CONFIG_SERIAL_QCOM_GENI is not set
CONFIG_SERIAL_VT8500=y
CONFIG_SERIAL_VT8500_CONSOLE=y
# CONFIG_SERIAL_OMAP is not set
# CONFIG_SERIAL_SIFIVE is not set
CONFIG_SERIAL_LANTIQ=m
CONFIG_SERIAL_SCCNXP=y
# CONFIG_SERIAL_SCCNXP_CONSOLE is not set
# CONFIG_SERIAL_SC16IS7XX is not set
CONFIG_SERIAL_TIMBERDALE=y
CONFIG_SERIAL_BCM63XX=m
CONFIG_SERIAL_ALTERA_JTAGUART=m
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
# CONFIG_SERIAL_ALTERA_UART_CONSOLE is not set
CONFIG_SERIAL_PCH_UART=y
CONFIG_SERIAL_PCH_UART_CONSOLE=y
CONFIG_SERIAL_MXS_AUART=y
CONFIG_SERIAL_MXS_AUART_CONSOLE=y
CONFIG_SERIAL_XILINX_PS_UART=y
CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
# CONFIG_SERIAL_MPS2_UART_CONSOLE is not set
CONFIG_SERIAL_MPS2_UART=y
CONFIG_SERIAL_ARC=y
CONFIG_SERIAL_ARC_CONSOLE=y
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=y
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
CONFIG_SERIAL_FSL_LINFLEXUART=m
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_ST_ASC is not set
CONFIG_SERIAL_MEN_Z135=m
CONFIG_SERIAL_SPRD=y
CONFIG_SERIAL_SPRD_CONSOLE=y
CONFIG_SERIAL_STM32=y
CONFIG_SERIAL_STM32_CONSOLE=y
# CONFIG_SERIAL_MVEBU_UART is not set
CONFIG_SERIAL_OWL=m
CONFIG_SERIAL_RDA=y
# CONFIG_SERIAL_RDA_CONSOLE is not set
CONFIG_SERIAL_MILBEAUT_USIO=y
CONFIG_SERIAL_MILBEAUT_USIO_PORTS=4
CONFIG_SERIAL_MILBEAUT_USIO_CONSOLE=y
# CONFIG_SERIAL_LITEUART is not set
CONFIG_SERIAL_SUNPLUS=m
CONFIG_SERIAL_SUNPLUS_CONSOLE=y
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_N_GSM=m
CONFIG_NOZOMI=y
CONFIG_NULL_TTY=y
CONFIG_HVC_DRIVER=y
CONFIG_HVC_DCC=y
CONFIG_RPMSG_TTY=m
CONFIG_SERIAL_DEV_BUS=m
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
# CONFIG_PPDEV is not set
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
# CONFIG_IPMI_SSIF is not set
CONFIG_IPMI_IPMB=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=y
# CONFIG_ASPEED_KCS_IPMI_BMC is not set
# CONFIG_NPCM7XX_KCS_IPMI_BMC is not set
# CONFIG_ASPEED_BT_IPMI_BMC is not set
CONFIG_IPMB_DEVICE_INTERFACE=m
# CONFIG_HW_RANDOM is not set
CONFIG_APPLICOM=y
CONFIG_DEVMEM=y
CONFIG_DEVPORT=y
CONFIG_TCG_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SYNQUACER is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
# CONFIG_TCG_TIS_I2C_ATMEL is not set
# CONFIG_TCG_TIS_I2C_INFINEON is not set
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
# CONFIG_TCG_ATMEL is not set
CONFIG_TCG_VTPM_PROXY=y
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
CONFIG_XILLYBUS_CLASS=y
# CONFIG_XILLYBUS is not set
CONFIG_XILLYUSB=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_ARB_GPIO_CHALLENGE is not set
# CONFIG_I2C_MUX_GPIO is not set
CONFIG_I2C_MUX_GPMUX=m
CONFIG_I2C_MUX_LTC4306=m
CONFIG_I2C_MUX_PCA9541=m
# CONFIG_I2C_MUX_PCA954x is not set
CONFIG_I2C_MUX_PINCTRL=m
CONFIG_I2C_MUX_REG=m
CONFIG_I2C_DEMUX_PINCTRL=m
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_CCGX_UCSI=m
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_HIX5HD2=m
# CONFIG_I2C_I801 is not set
CONFIG_I2C_ISCH=m
CONFIG_I2C_PIIX4=m
# CONFIG_I2C_NFORCE2 is not set
CONFIG_I2C_NVIDIA_GPU=m
# CONFIG_I2C_SIS5595 is not set
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_ALTERA=y
CONFIG_I2C_ASPEED=m
# CONFIG_I2C_AT91 is not set
CONFIG_I2C_AXXIA=y
CONFIG_I2C_BCM2835=y
CONFIG_I2C_BCM_IPROC=y
# CONFIG_I2C_BCM_KONA is not set
CONFIG_I2C_BRCMSTB=y
CONFIG_I2C_CADENCE=m
CONFIG_I2C_CBUS_GPIO=y
# CONFIG_I2C_DAVINCI is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_DIGICOLOR is not set
# CONFIG_I2C_EG20T is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_EXYNOS5=y
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_HIGHLANDER=m
CONFIG_I2C_HISI=y
# CONFIG_I2C_IMG is not set
CONFIG_I2C_IMX=m
# CONFIG_I2C_IMX_LPI2C is not set
CONFIG_I2C_IOP3XX=y
# CONFIG_I2C_JZ4780 is not set
CONFIG_I2C_KEMPLD=m
CONFIG_I2C_LPC2K=m
# CONFIG_I2C_MESON is not set
CONFIG_I2C_MT65XX=m
CONFIG_I2C_MT7621=y
CONFIG_I2C_MV64XXX=m
CONFIG_I2C_MXS=y
CONFIG_I2C_NOMADIK=y
# CONFIG_I2C_NPCM7XX is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_OMAP=y
# CONFIG_I2C_OWL is not set
CONFIG_I2C_APPLE=m
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_PNX=y
CONFIG_I2C_PXA=y
# CONFIG_I2C_PXA_SLAVE is not set
CONFIG_I2C_QCOM_CCI=y
# CONFIG_I2C_QCOM_GENI is not set
# CONFIG_I2C_QUP is not set
CONFIG_I2C_RIIC=m
CONFIG_I2C_RK3X=y
CONFIG_I2C_S3C2410=m
CONFIG_I2C_SH_MOBILE=m
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_SPRD is not set
CONFIG_I2C_ST=m
CONFIG_I2C_STM32F4=m
CONFIG_I2C_STM32F7=m
CONFIG_I2C_SUN6I_P2WI=m
CONFIG_I2C_SYNQUACER=m
CONFIG_I2C_TEGRA=y
CONFIG_I2C_TEGRA_BPMP=m
CONFIG_I2C_UNIPHIER=y
# CONFIG_I2C_UNIPHIER_F is not set
CONFIG_I2C_VERSATILE=m
CONFIG_I2C_WMT=y
CONFIG_I2C_XILINX=m
# CONFIG_I2C_XLP9XX is not set
CONFIG_I2C_RCAR=m

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_DLN2=m
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=y
CONFIG_I2C_ROBOTFUZZ_OSIF=y
CONFIG_I2C_TAOS_EVM=m
CONFIG_I2C_TINY_USB=m
# CONFIG_I2C_VIPERBOARD is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=y
CONFIG_I2C_CROS_EC_TUNNEL=m
CONFIG_I2C_FSI=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
CONFIG_I2C_SLAVE_TESTUNIT=m
CONFIG_I2C_DEBUG_CORE=y
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#
CONFIG_OMAP_SSI=m

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set
CONFIG_PPS=m
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=m
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=m
CONFIG_PTP_1588_CLOCK_OPTIONAL=m
# CONFIG_PTP_1588_CLOCK_DTE is not set
# CONFIG_PTP_1588_CLOCK_QORIQ is not set
CONFIG_DP83640_PHY=m
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_PCH=m
CONFIG_PTP_1588_CLOCK_IDT82P33=m
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
CONFIG_PTP_1588_CLOCK_OCP=m
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_AS3722=m
# CONFIG_PINCTRL_AT91PIO4 is not set
CONFIG_PINCTRL_AXP209=m
CONFIG_PINCTRL_BM1880=y
# CONFIG_PINCTRL_DA850_PUPD is not set
CONFIG_PINCTRL_EQUILIBRIUM=y
CONFIG_PINCTRL_INGENIC=y
CONFIG_PINCTRL_LPC18XX=y
CONFIG_PINCTRL_MCP23S08_I2C=y
CONFIG_PINCTRL_MCP23S08=y
CONFIG_PINCTRL_MICROCHIP_SGPIO=y
# CONFIG_PINCTRL_OCELOT is not set
CONFIG_PINCTRL_PISTACHIO=y
# CONFIG_PINCTRL_RK805 is not set
CONFIG_PINCTRL_ROCKCHIP=y
CONFIG_PINCTRL_SINGLE=m
# CONFIG_PINCTRL_STARFIVE is not set
CONFIG_PINCTRL_STMFX=y
CONFIG_PINCTRL_SX150X=y
# CONFIG_PINCTRL_OWL is not set
CONFIG_PINCTRL_ASPEED=y
CONFIG_PINCTRL_ASPEED_G4=y
# CONFIG_PINCTRL_ASPEED_G5 is not set
# CONFIG_PINCTRL_ASPEED_G6 is not set
# CONFIG_PINCTRL_BCM281XX is not set
CONFIG_PINCTRL_BCM2835=m
# CONFIG_PINCTRL_BCM4908 is not set
CONFIG_PINCTRL_BCM63XX=y
# CONFIG_PINCTRL_BCM6318 is not set
CONFIG_PINCTRL_BCM6328=y
# CONFIG_PINCTRL_BCM6358 is not set
# CONFIG_PINCTRL_BCM6362 is not set
# CONFIG_PINCTRL_BCM6368 is not set
# CONFIG_PINCTRL_BCM63268 is not set
CONFIG_PINCTRL_IPROC_GPIO=y
# CONFIG_PINCTRL_CYGNUS_MUX is not set
CONFIG_PINCTRL_NS=y
# CONFIG_PINCTRL_NSP_GPIO is not set
CONFIG_PINCTRL_NS2_MUX=y
# CONFIG_PINCTRL_NSP_MUX is not set
CONFIG_PINCTRL_BERLIN=y
# CONFIG_PINCTRL_AS370 is not set
CONFIG_PINCTRL_BERLIN_BG4CT=y
CONFIG_PINCTRL_MADERA=m
CONFIG_PINCTRL_CS47L15=y
CONFIG_PINCTRL_CS47L35=y
CONFIG_PINCTRL_CS47L92=y

#
# Intel pinctrl drivers
#
# end of Intel pinctrl drivers

#
# MediaTek pinctrl drivers
#
CONFIG_EINT_MTK=y
CONFIG_PINCTRL_MTK=y
CONFIG_PINCTRL_MTK_V2=y
CONFIG_PINCTRL_MTK_MOORE=y
CONFIG_PINCTRL_MTK_PARIS=y
CONFIG_PINCTRL_MT2701=y
# CONFIG_PINCTRL_MT7623 is not set
# CONFIG_PINCTRL_MT7629 is not set
# CONFIG_PINCTRL_MT8135 is not set
CONFIG_PINCTRL_MT8127=y
# CONFIG_PINCTRL_MT2712 is not set
# CONFIG_PINCTRL_MT6765 is not set
CONFIG_PINCTRL_MT6779=m
# CONFIG_PINCTRL_MT6795 is not set
CONFIG_PINCTRL_MT6797=y
# CONFIG_PINCTRL_MT7622 is not set
CONFIG_PINCTRL_MT7986=y
CONFIG_PINCTRL_MT8167=y
CONFIG_PINCTRL_MT8173=y
# CONFIG_PINCTRL_MT8183 is not set
# CONFIG_PINCTRL_MT8186 is not set
CONFIG_PINCTRL_MT8192=y
# CONFIG_PINCTRL_MT8195 is not set
# CONFIG_PINCTRL_MT8365 is not set
# CONFIG_PINCTRL_MT8516 is not set
CONFIG_PINCTRL_MT6397=y
# end of MediaTek pinctrl drivers

# CONFIG_PINCTRL_MESON is not set
# CONFIG_PINCTRL_WPCM450 is not set
CONFIG_PINCTRL_NPCM7XX=y
CONFIG_PINCTRL_PXA=y
CONFIG_PINCTRL_PXA25X=m
CONFIG_PINCTRL_PXA27X=m
CONFIG_PINCTRL_MSM=y
# CONFIG_PINCTRL_APQ8064 is not set
CONFIG_PINCTRL_APQ8084=y
CONFIG_PINCTRL_IPQ4019=y
# CONFIG_PINCTRL_IPQ8064 is not set
# CONFIG_PINCTRL_IPQ8074 is not set
CONFIG_PINCTRL_IPQ6018=y
# CONFIG_PINCTRL_MSM8226 is not set
CONFIG_PINCTRL_MSM8660=m
CONFIG_PINCTRL_MSM8960=y
# CONFIG_PINCTRL_MDM9607 is not set
CONFIG_PINCTRL_MDM9615=y
CONFIG_PINCTRL_MSM8X74=y
# CONFIG_PINCTRL_MSM8916 is not set
CONFIG_PINCTRL_MSM8953=y
CONFIG_PINCTRL_MSM8976=y
CONFIG_PINCTRL_MSM8994=y
CONFIG_PINCTRL_MSM8996=m
CONFIG_PINCTRL_MSM8998=m
CONFIG_PINCTRL_QCM2290=m
CONFIG_PINCTRL_QCS404=m
CONFIG_PINCTRL_QCOM_SSBI_PMIC=m
# CONFIG_PINCTRL_SC7180 is not set
# CONFIG_PINCTRL_SC7280 is not set
CONFIG_PINCTRL_SC7280_LPASS_LPI=m
CONFIG_PINCTRL_SC8180X=y
CONFIG_PINCTRL_SC8280XP=m
CONFIG_PINCTRL_SDM660=y
CONFIG_PINCTRL_SDM845=y
CONFIG_PINCTRL_SDX55=m
CONFIG_PINCTRL_SM6115=y
CONFIG_PINCTRL_SM6125=m
CONFIG_PINCTRL_SM6350=m
CONFIG_PINCTRL_SDX65=m
CONFIG_PINCTRL_SM8150=m
# CONFIG_PINCTRL_SM8250 is not set
CONFIG_PINCTRL_SM8250_LPASS_LPI=m
# CONFIG_PINCTRL_SM8350 is not set
# CONFIG_PINCTRL_SM8450 is not set
CONFIG_PINCTRL_LPASS_LPI=m

#
# Renesas pinctrl drivers
#
CONFIG_PINCTRL_RENESAS=y
CONFIG_PINCTRL_SH_PFC=y
CONFIG_PINCTRL_SH_PFC_GPIO=y
CONFIG_PINCTRL_SH_FUNC_GPIO=y
# CONFIG_PINCTRL_PFC_EMEV2 is not set
# CONFIG_PINCTRL_PFC_R8A77995 is not set
# CONFIG_PINCTRL_PFC_R8A7794 is not set
CONFIG_PINCTRL_PFC_R8A77990=y
CONFIG_PINCTRL_PFC_R8A7779=y
# CONFIG_PINCTRL_PFC_R8A7790 is not set
# CONFIG_PINCTRL_PFC_R8A77950 is not set
# CONFIG_PINCTRL_PFC_R8A77951 is not set
CONFIG_PINCTRL_PFC_R8A7778=y
CONFIG_PINCTRL_PFC_R8A7793=y
CONFIG_PINCTRL_PFC_R8A7791=y
# CONFIG_PINCTRL_PFC_R8A77965 is not set
CONFIG_PINCTRL_PFC_R8A77960=y
CONFIG_PINCTRL_PFC_R8A77961=y
CONFIG_PINCTRL_PFC_R8A779F0=y
CONFIG_PINCTRL_PFC_R8A7792=y
# CONFIG_PINCTRL_PFC_R8A77980 is not set
# CONFIG_PINCTRL_PFC_R8A77970 is not set
# CONFIG_PINCTRL_PFC_R8A779A0 is not set
# CONFIG_PINCTRL_PFC_R8A7740 is not set
CONFIG_PINCTRL_PFC_R8A73A4=y
# CONFIG_PINCTRL_RZA1 is not set
# CONFIG_PINCTRL_RZA2 is not set
# CONFIG_PINCTRL_RZG2L is not set
CONFIG_PINCTRL_PFC_R8A77470=y
CONFIG_PINCTRL_PFC_R8A7745=y
# CONFIG_PINCTRL_PFC_R8A7742 is not set
# CONFIG_PINCTRL_PFC_R8A7743 is not set
CONFIG_PINCTRL_PFC_R8A7744=y
# CONFIG_PINCTRL_PFC_R8A774C0 is not set
# CONFIG_PINCTRL_PFC_R8A774E1 is not set
CONFIG_PINCTRL_PFC_R8A774A1=y
CONFIG_PINCTRL_PFC_R8A774B1=y
# CONFIG_PINCTRL_RZN1 is not set
# CONFIG_PINCTRL_PFC_SH7203 is not set
CONFIG_PINCTRL_PFC_SH7264=y
CONFIG_PINCTRL_PFC_SH7269=y
CONFIG_PINCTRL_PFC_SH7720=y
# CONFIG_PINCTRL_PFC_SH7722 is not set
CONFIG_PINCTRL_PFC_SH7734=y
CONFIG_PINCTRL_PFC_SH7757=y
CONFIG_PINCTRL_PFC_SH7785=y
CONFIG_PINCTRL_PFC_SH7786=y
CONFIG_PINCTRL_PFC_SH73A0=y
# CONFIG_PINCTRL_PFC_SH7723 is not set
CONFIG_PINCTRL_PFC_SH7724=y
CONFIG_PINCTRL_PFC_SHX3=y
# end of Renesas pinctrl drivers

CONFIG_PINCTRL_SAMSUNG=y
CONFIG_PINCTRL_EXYNOS=y
# CONFIG_PINCTRL_EXYNOS_ARM is not set
CONFIG_PINCTRL_EXYNOS_ARM64=y
CONFIG_PINCTRL_S3C24XX=y
CONFIG_PINCTRL_S3C64XX=y
CONFIG_PINCTRL_SPRD=m
CONFIG_PINCTRL_SPRD_SC9860=m
CONFIG_PINCTRL_STM32=y
CONFIG_PINCTRL_STM32F429=y
CONFIG_PINCTRL_STM32F469=y
CONFIG_PINCTRL_STM32F746=y
# CONFIG_PINCTRL_STM32F769 is not set
# CONFIG_PINCTRL_STM32H743 is not set
# CONFIG_PINCTRL_STM32MP135 is not set
CONFIG_PINCTRL_STM32MP157=y
CONFIG_PINCTRL_TI_IODELAY=y
# CONFIG_PINCTRL_UNIPHIER is not set
# CONFIG_PINCTRL_TMPV7700 is not set
CONFIG_ARCH_HAVE_CUSTOM_GPIO_H=y
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_REGMAP=y
CONFIG_GPIO_MAX730X=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
CONFIG_GPIO_ALTERA=m
# CONFIG_GPIO_ASPEED is not set
CONFIG_GPIO_ASPEED_SGPIO=y
# CONFIG_GPIO_ATH79 is not set
CONFIG_GPIO_RASPBERRYPI_EXP=y
# CONFIG_GPIO_BCM_KONA is not set
CONFIG_GPIO_BCM_XGS_IPROC=y
CONFIG_GPIO_BRCMSTB=m
CONFIG_GPIO_CADENCE=y
# CONFIG_GPIO_CLPS711X is not set
# CONFIG_GPIO_DWAPB is not set
CONFIG_GPIO_EIC_SPRD=m
# CONFIG_GPIO_EM is not set
CONFIG_GPIO_EXAR=m
# CONFIG_GPIO_FTGPIO010 is not set
CONFIG_GPIO_GENERIC_PLATFORM=m
CONFIG_GPIO_GRGPIO=m
CONFIG_GPIO_HISI=m
# CONFIG_GPIO_HLWD is not set
CONFIG_GPIO_IOP=y
CONFIG_GPIO_IXP4XX=y
CONFIG_GPIO_LOGICVC=m
CONFIG_GPIO_LPC18XX=y
# CONFIG_GPIO_LPC32XX is not set
CONFIG_GPIO_MB86S7X=m
# CONFIG_GPIO_MENZ127 is not set
CONFIG_GPIO_MPC8XXX=y
CONFIG_GPIO_MT7621=y
CONFIG_GPIO_MXC=y
CONFIG_GPIO_MXS=y
CONFIG_GPIO_OMAP=y
CONFIG_GPIO_PL061=m
# CONFIG_GPIO_PMIC_EIC_SPRD is not set
CONFIG_GPIO_PXA=y
CONFIG_GPIO_RCAR=y
# CONFIG_GPIO_RDA is not set
# CONFIG_GPIO_ROCKCHIP is not set
CONFIG_GPIO_SAMA5D2_PIOBU=y
# CONFIG_GPIO_SIFIVE is not set
CONFIG_GPIO_SIOX=m
CONFIG_GPIO_SNPS_CREG=y
CONFIG_GPIO_SPRD=m
CONFIG_GPIO_STP_XWAY=y
CONFIG_GPIO_SYSCON=y
CONFIG_GPIO_TEGRA=m
# CONFIG_GPIO_TEGRA186 is not set
# CONFIG_GPIO_TS4800 is not set
CONFIG_GPIO_UNIPHIER=m
CONFIG_GPIO_VISCONTI=y
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_XGENE_SB=m
CONFIG_GPIO_XILINX=m
# CONFIG_GPIO_XLP is not set
# CONFIG_GPIO_ZEVIO is not set
CONFIG_GPIO_AMD_FCH=m
CONFIG_GPIO_IDT3243X=m
# end of Memory mapped GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_ADNP is not set
# CONFIG_GPIO_GW_PLD is not set
CONFIG_GPIO_MAX7300=m
CONFIG_GPIO_MAX732X=m
CONFIG_GPIO_PCA953X=m
CONFIG_GPIO_PCA953X_IRQ=y
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_TPIC2810=y
# CONFIG_GPIO_TS4900 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_BD71815=m
CONFIG_GPIO_BD71828=m
# CONFIG_GPIO_BD9571MWV is not set
CONFIG_GPIO_DA9052=y
CONFIG_GPIO_DLN2=m
CONFIG_HTC_EGPIO=y
CONFIG_GPIO_JANZ_TTL=m
CONFIG_GPIO_KEMPLD=m
# CONFIG_GPIO_LP3943 is not set
CONFIG_GPIO_LP873X=y
CONFIG_GPIO_LP87565=y
CONFIG_GPIO_MADERA=m
# CONFIG_GPIO_SL28CPLD is not set
# CONFIG_GPIO_STMPE is not set
# CONFIG_GPIO_TC3589X is not set
CONFIG_GPIO_TIMBERDALE=y
# CONFIG_GPIO_TPS65086 is not set
CONFIG_GPIO_TPS65910=y
# CONFIG_GPIO_TQMX86 is not set
# CONFIG_GPIO_WM831X is not set
CONFIG_GPIO_WM8350=y
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=m
CONFIG_GPIO_BT8XX=m
CONFIG_GPIO_ML_IOH=y
# CONFIG_GPIO_PCH is not set
CONFIG_GPIO_PCI_IDIO_16=m
CONFIG_GPIO_PCIE_IDIO_24=y
CONFIG_GPIO_RDC321X=y
# end of PCI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=m
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
CONFIG_GPIO_MOCKUP=y
# CONFIG_GPIO_VIRTIO is not set
CONFIG_GPIO_SIM=m
# end of Virtual GPIO drivers

CONFIG_W1=y
# CONFIG_W1_CON is not set

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=y
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_MXC=m
# CONFIG_W1_MASTER_DS1WM is not set
CONFIG_W1_MASTER_GPIO=y
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=m
# CONFIG_W1_SLAVE_DS2405 is not set
# CONFIG_W1_SLAVE_DS2408 is not set
# CONFIG_W1_SLAVE_DS2413 is not set
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=y
# CONFIG_W1_SLAVE_DS2805 is not set
CONFIG_W1_SLAVE_DS2430=m
CONFIG_W1_SLAVE_DS2431=y
# CONFIG_W1_SLAVE_DS2433 is not set
# CONFIG_W1_SLAVE_DS2438 is not set
# CONFIG_W1_SLAVE_DS250X is not set
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=m
CONFIG_W1_SLAVE_DS28E04=y
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
# CONFIG_POWER_SUPPLY_HWMON is not set
CONFIG_PDA_POWER=m
CONFIG_APM_POWER=m
CONFIG_IP5XXX_POWER=m
CONFIG_MAX8925_POWER=y
CONFIG_WM831X_BACKUP=m
CONFIG_WM831X_POWER=m
# CONFIG_WM8350_POWER is not set
CONFIG_TEST_POWER=y
CONFIG_CHARGER_ADP5061=y
# CONFIG_BATTERY_ACT8945A is not set
CONFIG_BATTERY_CW2015=m
CONFIG_BATTERY_DS2760=y
CONFIG_BATTERY_DS2780=y
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=m
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=m
CONFIG_MANAGER_SBS=m
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_BATTERY_DA9030=y
CONFIG_BATTERY_DA9052=m
CONFIG_BATTERY_DA9150=m
CONFIG_BATTERY_MAX17040=m
CONFIG_BATTERY_MAX17042=m
CONFIG_BATTERY_MAX1721X=m
CONFIG_CHARGER_ISP1704=m
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
CONFIG_CHARGER_GPIO=m
CONFIG_CHARGER_MANAGER=m
# CONFIG_CHARGER_LT3651 is not set
CONFIG_CHARGER_LTC4162L=y
CONFIG_CHARGER_DETECTOR_MAX14656=m
CONFIG_CHARGER_MAX77976=m
CONFIG_CHARGER_MAX8998=m
# CONFIG_CHARGER_MT6360 is not set
# CONFIG_CHARGER_QCOM_SMBB is not set
# CONFIG_CHARGER_BQ2415X is not set
CONFIG_CHARGER_BQ24190=m
CONFIG_CHARGER_BQ24257=m
# CONFIG_CHARGER_BQ24735 is not set
CONFIG_CHARGER_BQ2515X=y
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_BQ25980=y
CONFIG_CHARGER_BQ256XX=m
CONFIG_CHARGER_SMB347=y
CONFIG_CHARGER_TPS65090=y
CONFIG_CHARGER_TPS65217=y
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
CONFIG_BATTERY_GOLDFISH=y
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_CHARGER_CROS_USBPD=m
# CONFIG_CHARGER_CROS_PCHG is not set
CONFIG_CHARGER_SC2731=y
CONFIG_CHARGER_UCS1002=m
CONFIG_CHARGER_BD99954=m
CONFIG_BATTERY_ACER_A500=m
CONFIG_BATTERY_UG3105=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=m
# CONFIG_SENSORS_ADM1021 is not set
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM1177=y
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=y
# CONFIG_SENSORS_ADT7475 is not set
CONFIG_SENSORS_AHT10=m
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_AXI_FAN_CONTROL=y
CONFIG_SENSORS_ASPEED=m
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_BT1_PVT is not set
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_DA9052_ADC=m
CONFIG_SENSORS_I5K_AMB=y
# CONFIG_SENSORS_SPARX5 is not set
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=m
# CONFIG_SENSORS_GSC is not set
CONFIG_SENSORS_MC13783_ADC=m
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
CONFIG_SENSORS_GPIO_FAN=m
CONFIG_SENSORS_HIH6130=y
CONFIG_SENSORS_IBMAEM=y
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_IT87=y
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWR1220 is not set
# CONFIG_SENSORS_LAN966X is not set
CONFIG_SENSORS_LINEAGE=y
CONFIG_SENSORS_LTC2945=y
# CONFIG_SENSORS_LTC2947_I2C is not set
CONFIG_SENSORS_LTC2990=m
CONFIG_SENSORS_LTC2992=m
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=m
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=m
CONFIG_SENSORS_LTC4260=m
# CONFIG_SENSORS_LTC4261 is not set
CONFIG_SENSORS_MAX127=m
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX31730=m
# CONFIG_SENSORS_MAX6620 is not set
CONFIG_SENSORS_MAX6621=m
CONFIG_SENSORS_MAX6639=m
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=m
CONFIG_SENSORS_MAX31790=m
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_TC654 is not set
CONFIG_SENSORS_TPS23861=y
CONFIG_SENSORS_MENF21BMC_HWMON=m
# CONFIG_SENSORS_MR75203 is not set
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=m
# CONFIG_SENSORS_LM80 is not set
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=m
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=m
# CONFIG_SENSORS_LM95245 is not set
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775_CORE=y
CONFIG_SENSORS_NCT6775=y
# CONFIG_SENSORS_NCT6775_I2C is not set
CONFIG_SENSORS_NCT7802=m
CONFIG_SENSORS_NPCM7XX=y
CONFIG_SENSORS_NSA320=y
# CONFIG_SENSORS_OCC_P8_I2C is not set
CONFIG_SENSORS_PCF8591=y
CONFIG_PMBUS=m
# CONFIG_SENSORS_PMBUS is not set
CONFIG_SENSORS_ADM1266=m
CONFIG_SENSORS_ADM1275=m
CONFIG_SENSORS_BEL_PFE=m
CONFIG_SENSORS_BPA_RS600=m
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
# CONFIG_SENSORS_FSP_3Y is not set
CONFIG_SENSORS_IBM_CFFPS=m
CONFIG_SENSORS_DPS920AB=m
# CONFIG_SENSORS_INSPUR_IPSPS is not set
CONFIG_SENSORS_IR35221=m
CONFIG_SENSORS_IR36021=m
CONFIG_SENSORS_IR38064=m
# CONFIG_SENSORS_IR38064_REGULATOR is not set
CONFIG_SENSORS_IRPS5401=m
CONFIG_SENSORS_ISL68137=m
# CONFIG_SENSORS_LM25066 is not set
# CONFIG_SENSORS_LTC2978 is not set
CONFIG_SENSORS_LTC3815=m
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
CONFIG_SENSORS_MAX16601=m
# CONFIG_SENSORS_MAX20730 is not set
CONFIG_SENSORS_MAX20751=m
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
CONFIG_SENSORS_MP2888=m
CONFIG_SENSORS_MP2975=m
CONFIG_SENSORS_MP5023=m
CONFIG_SENSORS_PIM4328=m
CONFIG_SENSORS_PLI1209BC=m
CONFIG_SENSORS_PLI1209BC_REGULATOR=y
CONFIG_SENSORS_PM6764TR=m
CONFIG_SENSORS_PXE1610=m
# CONFIG_SENSORS_Q54SJ108A2 is not set
CONFIG_SENSORS_STPDDC60=m
CONFIG_SENSORS_TPS40422=m
CONFIG_SENSORS_TPS53679=m
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE152 is not set
CONFIG_SENSORS_XDPE122=m
# CONFIG_SENSORS_XDPE122_REGULATOR is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_PWM_FAN is not set
CONFIG_SENSORS_RASPBERRYPI_HWMON=m
CONFIG_SENSORS_SL28CPLD=m
# CONFIG_SENSORS_SBTSI is not set
CONFIG_SENSORS_SBRMI=m
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHT3x=y
CONFIG_SENSORS_SHT4x=y
CONFIG_SENSORS_SHTC1=y
CONFIG_SENSORS_SIS5595=m
# CONFIG_SENSORS_SY7636A is not set
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=y
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_AMC6821=y
# CONFIG_SENSORS_INA209 is not set
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA238 is not set
CONFIG_SENSORS_INA3221=m
CONFIG_SENSORS_TC74=m
CONFIG_SENSORS_THMC50=m
# CONFIG_SENSORS_TMP102 is not set
# CONFIG_SENSORS_TMP103 is not set
CONFIG_SENSORS_TMP108=m
CONFIG_SENSORS_TMP401=m
# CONFIG_SENSORS_TMP421 is not set
CONFIG_SENSORS_TMP464=m
CONFIG_SENSORS_TMP513=m
CONFIG_SENSORS_VEXPRESS=m
CONFIG_SENSORS_VIA686A=y
# CONFIG_SENSORS_VT1211 is not set
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=y
CONFIG_SENSORS_W83795_FANCTRL=y
CONFIG_SENSORS_W83L785TS=y
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=m
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_WM831X is not set
CONFIG_SENSORS_WM8350=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
# CONFIG_THERMAL_GOV_USER_SPACE is not set
CONFIG_CPU_THERMAL=y
CONFIG_CPU_FREQ_THERMAL=y
CONFIG_DEVFREQ_THERMAL=y
CONFIG_THERMAL_EMULATION=y
CONFIG_THERMAL_MMIO=m
CONFIG_HISI_THERMAL=y
CONFIG_IMX_THERMAL=y
CONFIG_IMX8MM_THERMAL=y
# CONFIG_K3_THERMAL is not set
# CONFIG_QORIQ_THERMAL is not set
# CONFIG_SPEAR_THERMAL is not set
# CONFIG_SUN8I_THERMAL is not set
# CONFIG_ROCKCHIP_THERMAL is not set
# CONFIG_RCAR_THERMAL is not set
CONFIG_RCAR_GEN3_THERMAL=y
CONFIG_RZG2L_THERMAL=y
CONFIG_KIRKWOOD_THERMAL=y
CONFIG_DOVE_THERMAL=y
CONFIG_ARMADA_THERMAL=y
CONFIG_DA9062_THERMAL=m
# CONFIG_MTK_THERMAL is not set

#
# Intel thermal drivers
#

#
# ACPI INT340X thermal drivers
#
# end of ACPI INT340X thermal drivers
# end of Intel thermal drivers

#
# Broadcom thermal drivers
#
# CONFIG_BCM2711_THERMAL is not set
CONFIG_BCM2835_THERMAL=y
CONFIG_BRCMSTB_THERMAL=y
CONFIG_BCM_NS_THERMAL=y
# CONFIG_BCM_SR_THERMAL is not set
# end of Broadcom thermal drivers

#
# Texas Instruments thermal drivers
#
# CONFIG_TI_SOC_THERMAL is not set
# end of Texas Instruments thermal drivers

#
# Samsung thermal drivers
#
# CONFIG_EXYNOS_THERMAL is not set
# end of Samsung thermal drivers

#
# NVIDIA Tegra thermal drivers
#
CONFIG_TEGRA_SOCTHERM=m
# CONFIG_TEGRA_BPMP_THERMAL is not set
# CONFIG_TEGRA30_TSENSOR is not set
# end of NVIDIA Tegra thermal drivers

#
# Qualcomm thermal drivers
#
# end of Qualcomm thermal drivers

# CONFIG_UNIPHIER_THERMAL is not set
CONFIG_SPRD_THERMAL=y
CONFIG_KHADAS_MCU_FAN_THERMAL=m
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_MIPS=y
CONFIG_BCMA_PFLASH=y
# CONFIG_BCMA_SFLASH is not set
CONFIG_BCMA_NFLASH=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_ACT8945A is not set
CONFIG_MFD_SUN4I_GPADC=m
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_AS3722=m
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_AT91_USART=y
CONFIG_MFD_ATMEL_FLEXCOM=m
CONFIG_MFD_ATMEL_HLCDC=y
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=m
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_CROS_EC_DEV=m
CONFIG_MFD_MADERA=m
CONFIG_MFD_MADERA_I2C=m
CONFIG_MFD_CS47L15=y
CONFIG_MFD_CS47L35=y
# CONFIG_MFD_CS47L85 is not set
# CONFIG_MFD_CS47L90 is not set
CONFIG_MFD_CS47L92=y
# CONFIG_MFD_ASIC3 is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=m
CONFIG_MFD_DLN2=m
CONFIG_MFD_ENE_KB3930=y
# CONFIG_MFD_EXYNOS_LPASS is not set
CONFIG_MFD_GATEWORKS_GSC=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_I2C=y
# CONFIG_MFD_MP2629 is not set
# CONFIG_MFD_MXS_LRADC is not set
# CONFIG_MFD_MX25_TSADC is not set
CONFIG_MFD_HI6421_PMIC=m
CONFIG_MFD_HI655X_PMIC=m
CONFIG_HTC_PASIC3=y
CONFIG_HTC_I2CPLD=y
# CONFIG_LPC_ICH is not set
CONFIG_LPC_SCH=m
CONFIG_MFD_IQS62X=y
CONFIG_MFD_JANZ_CMODIO=m
CONFIG_MFD_KEMPLD=m
CONFIG_MFD_88PM800=y
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77620 is not set
# CONFIG_MFD_MAX77650 is not set
CONFIG_MFD_MAX77686=y
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77714 is not set
CONFIG_MFD_MAX77843=y
# CONFIG_MFD_MAX8907 is not set
CONFIG_MFD_MAX8925=y
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6360=y
CONFIG_MFD_MT6397=m
CONFIG_MFD_MENF21BMC=m
CONFIG_MFD_VIPERBOARD=y
CONFIG_MFD_NTXEC=m
CONFIG_MFD_RETU=y
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
CONFIG_MFD_PM8XXX=m
CONFIG_MFD_RDC321X=y
# CONFIG_MFD_RT4831 is not set
CONFIG_MFD_RT5033=m
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_RK808=m
CONFIG_MFD_RN5T618=m
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SIMPLE_MFD_I2C=y
CONFIG_MFD_SL28CPLD=y
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=m
CONFIG_ABX500_CORE=y
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
# CONFIG_STMPE_I2C is not set
# end of STMicroelectronics STMPE Interface Drivers

CONFIG_MFD_SUN6I_PRCM=y
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=m
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=m
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=m
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TPS65217=y
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TI_LP87565=y
# CONFIG_MFD_TPS65218 is not set
# CONFIG_MFD_TPS6586X is not set
CONFIG_MFD_TPS65910=y
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=m
CONFIG_MFD_LM3533=m
CONFIG_MFD_TIMBERDALE=y
CONFIG_MFD_TC3589X=y
CONFIG_MFD_TMIO=y
# CONFIG_MFD_T7L66XB is not set
CONFIG_MFD_TC6387XB=y
CONFIG_MFD_TC6393XB=y
# CONFIG_MFD_TQMX86 is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_LOCHNAGAR is not set
# CONFIG_MFD_ARIZONA_I2C is not set
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
# CONFIG_MFD_WM8994 is not set
CONFIG_MFD_STW481X=m
CONFIG_MFD_ROHM_BD718XX=y
CONFIG_MFD_ROHM_BD71828=m
# CONFIG_MFD_ROHM_BD957XMUF is not set
CONFIG_MFD_STM32_LPTIMER=m
CONFIG_MFD_STM32_TIMERS=m
CONFIG_MFD_STPMIC1=m
CONFIG_MFD_STMFX=y
# CONFIG_MFD_WCD934X is not set
CONFIG_MFD_ATC260X=y
CONFIG_MFD_ATC260X_I2C=y
CONFIG_MFD_KHADAS_MCU=m
CONFIG_MFD_ACER_A500_EC=m
# CONFIG_MFD_QCOM_PM8008 is not set
CONFIG_MFD_VEXPRESS_SYSREG=m
# CONFIG_RAVE_SP_CORE is not set
CONFIG_MFD_RSMU_I2C=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=m
CONFIG_REGULATOR_88PG86X=m
# CONFIG_REGULATOR_88PM800 is not set
CONFIG_REGULATOR_ACT8865=m
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_ANATOP=y
# CONFIG_REGULATOR_ARIZONA_LDO1 is not set
# CONFIG_REGULATOR_ARIZONA_MICSUPP is not set
# CONFIG_REGULATOR_AS3722 is not set
CONFIG_REGULATOR_ATC260X=y
# CONFIG_REGULATOR_AXP20X is not set
# CONFIG_REGULATOR_BCM590XX is not set
# CONFIG_REGULATOR_BD71815 is not set
CONFIG_REGULATOR_BD71828=m
# CONFIG_REGULATOR_BD718XX is not set
# CONFIG_REGULATOR_BD9571MWV is not set
CONFIG_REGULATOR_CROS_EC=m
CONFIG_REGULATOR_DA903X=y
# CONFIG_REGULATOR_DA9052 is not set
CONFIG_REGULATOR_DA9063=y
CONFIG_REGULATOR_DA9121=y
CONFIG_REGULATOR_DA9210=y
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_FAN53880=y
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_HI6421=m
CONFIG_REGULATOR_HI6421V530=m
CONFIG_REGULATOR_HI655X=m
CONFIG_REGULATOR_ISL9305=m
CONFIG_REGULATOR_ISL6271A=m
CONFIG_REGULATOR_LM363X=m
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=m
CONFIG_REGULATOR_LP872X=m
CONFIG_REGULATOR_LP873X=m
# CONFIG_REGULATOR_LP8755 is not set
# CONFIG_REGULATOR_LP87565 is not set
# CONFIG_REGULATOR_LP8788 is not set
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX77620=m
# CONFIG_REGULATOR_MAX77650 is not set
CONFIG_REGULATOR_MAX8649=m
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8893=m
CONFIG_REGULATOR_MAX8907=y
# CONFIG_REGULATOR_MAX8925 is not set
# CONFIG_REGULATOR_MAX8952 is not set
CONFIG_REGULATOR_MAX8973=y
CONFIG_REGULATOR_MAX8998=m
CONFIG_REGULATOR_MAX20086=m
CONFIG_REGULATOR_MAX77686=y
CONFIG_REGULATOR_MAX77693=m
CONFIG_REGULATOR_MAX77802=m
CONFIG_REGULATOR_MAX77826=y
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=m
CONFIG_REGULATOR_MC13892=y
# CONFIG_REGULATOR_MCP16502 is not set
# CONFIG_REGULATOR_MP5416 is not set
# CONFIG_REGULATOR_MP8859 is not set
# CONFIG_REGULATOR_MP886X is not set
CONFIG_REGULATOR_MPQ7920=y
# CONFIG_REGULATOR_MT6311 is not set
# CONFIG_REGULATOR_MT6323 is not set
CONFIG_REGULATOR_MT6358=m
CONFIG_REGULATOR_MT6359=m
CONFIG_REGULATOR_MT6360=m
# CONFIG_REGULATOR_MT6380 is not set
CONFIG_REGULATOR_MT6397=m
CONFIG_REGULATOR_PBIAS=y
CONFIG_REGULATOR_PCA9450=m
CONFIG_REGULATOR_PF8X00=y
# CONFIG_REGULATOR_PFUZE100 is not set
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=m
CONFIG_REGULATOR_PV88090=m
CONFIG_REGULATOR_PWM=m
# CONFIG_REGULATOR_QCOM_RPMH is not set
CONFIG_REGULATOR_QCOM_SPMI=m
CONFIG_REGULATOR_QCOM_USB_VBUS=y
CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY=y
CONFIG_REGULATOR_RK808=m
CONFIG_REGULATOR_RN5T618=m
CONFIG_REGULATOR_ROHM=m
CONFIG_REGULATOR_RT4801=m
# CONFIG_REGULATOR_RT5033 is not set
CONFIG_REGULATOR_RT5190A=y
CONFIG_REGULATOR_RT5759=m
# CONFIG_REGULATOR_RT6160 is not set
CONFIG_REGULATOR_RT6245=y
# CONFIG_REGULATOR_RTQ2134 is not set
CONFIG_REGULATOR_RTMV20=y
CONFIG_REGULATOR_RTQ6752=m
CONFIG_REGULATOR_S2MPA01=m
CONFIG_REGULATOR_S2MPS11=m
CONFIG_REGULATOR_S5M8767=y
CONFIG_REGULATOR_SC2731=y
CONFIG_REGULATOR_SKY81452=m
CONFIG_REGULATOR_SLG51000=m
# CONFIG_REGULATOR_STM32_BOOSTER is not set
# CONFIG_REGULATOR_STM32_VREFBUF is not set
# CONFIG_REGULATOR_STM32_PWR is not set
# CONFIG_REGULATOR_STPMIC1 is not set
# CONFIG_REGULATOR_TI_ABB is not set
CONFIG_REGULATOR_STW481X_VMMC=y
# CONFIG_REGULATOR_SY7636A is not set
# CONFIG_REGULATOR_SY8106A is not set
CONFIG_REGULATOR_SY8824X=m
# CONFIG_REGULATOR_SY8827N is not set
CONFIG_REGULATOR_TPS51632=m
CONFIG_REGULATOR_TPS6105X=m
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS6286X=y
CONFIG_REGULATOR_TPS65023=m
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65086=m
CONFIG_REGULATOR_TPS65090=m
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS65217=m
CONFIG_REGULATOR_TPS65910=y
# CONFIG_REGULATOR_TPS68470 is not set
# CONFIG_REGULATOR_UNIPHIER is not set
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_VEXPRESS=m
CONFIG_REGULATOR_WM831X=m
CONFIG_REGULATOR_WM8350=y
CONFIG_REGULATOR_WM8400=y
# CONFIG_REGULATOR_QCOM_LABIBB is not set
CONFIG_RC_CORE=y
# CONFIG_LIRC is not set
CONFIG_RC_MAP=y
CONFIG_RC_DECODERS=y
# CONFIG_IR_IMON_DECODER is not set
CONFIG_IR_JVC_DECODER=y
CONFIG_IR_MCE_KBD_DECODER=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=y
# CONFIG_IR_RCMM_DECODER is not set
# CONFIG_IR_SANYO_DECODER is not set
# CONFIG_IR_SHARP_DECODER is not set
# CONFIG_IR_SONY_DECODER is not set
CONFIG_IR_XMP_DECODER=m
# CONFIG_RC_DEVICES is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
CONFIG_CEC_PIN=y

#
# CEC support
#
CONFIG_MEDIA_CEC_RC=y
# CONFIG_CEC_PIN_ERROR_INJ is not set
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
CONFIG_CEC_CROS_EC=m
# CONFIG_CEC_MESON_AO is not set
CONFIG_CEC_MESON_G12A_AO=y
CONFIG_CEC_GPIO=m
CONFIG_CEC_SAMSUNG_S5P=y
CONFIG_CEC_STI=m
CONFIG_CEC_STM32=m
CONFIG_CEC_TEGRA=m
CONFIG_USB_PULSE8_CEC=y
# CONFIG_USB_RAINSHADOW_CEC is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
# CONFIG_MEDIA_SUPPORT_FILTER is not set
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
CONFIG_VIDEO_ADV_DEBUG=y
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_VIDEO_TUNER=m
CONFIG_V4L2_H264=m
CONFIG_V4L2_VP9=m
CONFIG_V4L2_MEM2MEM_DEV=m
CONFIG_V4L2_FLASH_LED_CLASS=m
CONFIG_V4L2_FWNODE=m
CONFIG_V4L2_ASYNC=m
# end of Video4Linux options

#
# Media controller options
#
CONFIG_MEDIA_CONTROLLER_DVB=y
CONFIG_MEDIA_CONTROLLER_REQUEST_API=y
# end of Media controller options

#
# Digital TV options
#
CONFIG_DVB_MMAP=y
CONFIG_DVB_MAX_ADAPTERS=16
# CONFIG_DVB_DYNAMIC_MINORS is not set
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
CONFIG_DVB_ULE_DEBUG=y
# end of Digital TV options

#
# Media drivers
#

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
# CONFIG_VIDEO_CPIA2 is not set
CONFIG_USB_GSPCA=m
CONFIG_USB_GSPCA_BENQ=m
CONFIG_USB_GSPCA_CONEX=m
CONFIG_USB_GSPCA_CPIA1=m
# CONFIG_USB_GSPCA_DTCS033 is not set
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
# CONFIG_USB_GSPCA_JL2005BCD is not set
CONFIG_USB_GSPCA_KINECT=m
CONFIG_USB_GSPCA_KONICA=m
CONFIG_USB_GSPCA_MARS=m
CONFIG_USB_GSPCA_MR97310A=m
# CONFIG_USB_GSPCA_NW80X is not set
CONFIG_USB_GSPCA_OV519=m
CONFIG_USB_GSPCA_OV534=m
CONFIG_USB_GSPCA_OV534_9=m
CONFIG_USB_GSPCA_PAC207=m
CONFIG_USB_GSPCA_PAC7302=m
# CONFIG_USB_GSPCA_PAC7311 is not set
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
CONFIG_USB_GSPCA_SN9C20X=m
# CONFIG_USB_GSPCA_SONIXB is not set
# CONFIG_USB_GSPCA_SONIXJ is not set
# CONFIG_USB_GSPCA_SPCA1528 is not set
# CONFIG_USB_GSPCA_SPCA500 is not set
CONFIG_USB_GSPCA_SPCA501=m
# CONFIG_USB_GSPCA_SPCA505 is not set
CONFIG_USB_GSPCA_SPCA506=m
CONFIG_USB_GSPCA_SPCA508=m
CONFIG_USB_GSPCA_SPCA561=m
CONFIG_USB_GSPCA_SQ905=m
CONFIG_USB_GSPCA_SQ905C=m
CONFIG_USB_GSPCA_SQ930X=m
CONFIG_USB_GSPCA_STK014=m
# CONFIG_USB_GSPCA_STK1135 is not set
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
CONFIG_USB_GSPCA_T613=m
CONFIG_USB_GSPCA_TOPRO=m
CONFIG_USB_GSPCA_TOUPTEK=m
CONFIG_USB_GSPCA_TV8532=m
CONFIG_USB_GSPCA_VC032X=m
# CONFIG_USB_GSPCA_VICAM is not set
CONFIG_USB_GSPCA_XIRLINK_CIT=m
# CONFIG_USB_GSPCA_ZC3XX is not set
# CONFIG_USB_GL860 is not set
CONFIG_USB_M5602=m
CONFIG_USB_STV06XX=m
CONFIG_USB_PWC=m
CONFIG_USB_PWC_DEBUG=y
# CONFIG_USB_PWC_INPUT_EVDEV is not set
CONFIG_USB_S2255=m
# CONFIG_USB_STKWEBCAM is not set
CONFIG_VIDEO_USBTV=m
# CONFIG_USB_VIDEO_CLASS is not set
# CONFIG_USB_ZR364XX is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_GO7007=m
CONFIG_VIDEO_GO7007_USB=m
CONFIG_VIDEO_GO7007_LOADER=m
# CONFIG_VIDEO_GO7007_USB_S2250_BOARD is not set
CONFIG_VIDEO_HDPVR=m
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
# CONFIG_VIDEO_PVRUSB2_DVB is not set
CONFIG_VIDEO_PVRUSB2_DEBUGIFC=y
CONFIG_VIDEO_STK1160_COMMON=m
CONFIG_VIDEO_STK1160=m

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=m
CONFIG_VIDEO_AU0828_V4L2=y
CONFIG_VIDEO_AU0828_RC=y
CONFIG_VIDEO_CX231XX=m
# CONFIG_VIDEO_CX231XX_RC is not set
CONFIG_VIDEO_CX231XX_ALSA=m
CONFIG_VIDEO_CX231XX_DVB=m
# CONFIG_VIDEO_TM6000 is not set

#
# Digital TV USB devices
#
# CONFIG_DVB_AS102 is not set
CONFIG_DVB_B2C2_FLEXCOP_USB=m
CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG=y
# CONFIG_DVB_USB_V2 is not set
# CONFIG_DVB_USB is not set
CONFIG_SMS_USB_DRV=m
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m

#
# Webcam, TV (analog/digital) USB devices
#
# CONFIG_VIDEO_EM28XX is not set

#
# Software defined radio USB devices
#
CONFIG_USB_AIRSPY=m
# CONFIG_USB_HACKRF is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_RADIO_ADAPTERS=m
CONFIG_RADIO_MAXIRADIO=m
CONFIG_RADIO_SAA7706H=m
# CONFIG_RADIO_SHARK is not set
CONFIG_RADIO_SHARK2=m
# CONFIG_RADIO_SI4713 is not set
# CONFIG_RADIO_SI476X is not set
CONFIG_RADIO_TEA575X=m
CONFIG_RADIO_TEA5764=m
CONFIG_RADIO_TEF6862=m
# CONFIG_RADIO_TIMBERDALE is not set
CONFIG_RADIO_WL1273=m
# CONFIG_USB_DSBR is not set
CONFIG_USB_KEENE=m
CONFIG_USB_MA901=m
CONFIG_USB_MR800=m
# CONFIG_USB_RAREMONO is not set
CONFIG_RADIO_SI470X=m
CONFIG_USB_SI470X=m
CONFIG_I2C_SI470X=m
CONFIG_RADIO_WL128X=m
# CONFIG_V4L_RADIO_ISA_DRIVERS is not set
CONFIG_MEDIA_PLATFORM_DRIVERS=y
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set

#
# Allegro DVT media platform drivers
#

#
# Amlogic media platform drivers
#

#
# Amphion drivers
#

#
# Aspeed media platform drivers
#

#
# Atmel media platform drivers
#

#
# Cadence media platform drivers
#
# CONFIG_VIDEO_CADENCE_CSI2RX is not set
CONFIG_VIDEO_CADENCE_CSI2TX=m

#
# Chips&Media media platform drivers
#

#
# Intel media platform drivers
#

#
# Marvell media platform drivers
#

#
# Mediatek media platform drivers
#

#
# NVidia media platform drivers
#

#
# NXP media platform drivers
#
CONFIG_VIDEO_IMX_MIPI_CSIS=m

#
# Qualcomm media platform drivers
#

#
# Renesas media platform drivers
#

#
# Rockchip media platform drivers
#

#
# Samsung media platform drivers
#

#
# STMicroelectronics media platform drivers
#

#
# Sunxi media platform drivers
#

#
# Texas Instruments drivers
#

#
# VIA media platform drivers
#

#
# Xilinx media platform drivers
#

#
# MMC/SDIO DVB adapters
#
CONFIG_SMS_SDIO_DRV=m
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_DVB_B2C2_FLEXCOP_DEBUG=y
CONFIG_SMS_SIANO_MDTV=m
# CONFIG_SMS_SIANO_RC is not set
CONFIG_SMS_SIANO_DEBUGFS=y
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_DMA_CONTIG=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y

#
# IR I2C driver auto-selected by 'Autoselect ancillary drivers'
#
CONFIG_VIDEO_IR_I2C=m

#
# Camera sensor devices
#
CONFIG_VIDEO_APTINA_PLL=m
CONFIG_VIDEO_CCS_PLL=m
CONFIG_VIDEO_HI556=m
CONFIG_VIDEO_HI846=m
CONFIG_VIDEO_HI847=m
# CONFIG_VIDEO_IMX208 is not set
CONFIG_VIDEO_IMX214=m
CONFIG_VIDEO_IMX219=m
CONFIG_VIDEO_IMX258=m
# CONFIG_VIDEO_IMX274 is not set
CONFIG_VIDEO_IMX290=m
# CONFIG_VIDEO_IMX319 is not set
CONFIG_VIDEO_IMX334=m
CONFIG_VIDEO_IMX335=m
# CONFIG_VIDEO_IMX355 is not set
# CONFIG_VIDEO_IMX412 is not set
CONFIG_VIDEO_MAX9271_LIB=m
CONFIG_VIDEO_MT9M001=m
CONFIG_VIDEO_MT9M032=m
CONFIG_VIDEO_MT9M111=m
CONFIG_VIDEO_MT9P031=m
CONFIG_VIDEO_MT9T001=m
CONFIG_VIDEO_MT9T112=m
CONFIG_VIDEO_MT9V011=m
# CONFIG_VIDEO_MT9V032 is not set
CONFIG_VIDEO_MT9V111=m
CONFIG_VIDEO_NOON010PC30=m
CONFIG_VIDEO_OG01A1B=m
# CONFIG_VIDEO_OV02A10 is not set
CONFIG_VIDEO_OV08D10=m
CONFIG_VIDEO_OV13858=m
CONFIG_VIDEO_OV13B10=m
CONFIG_VIDEO_OV2640=m
# CONFIG_VIDEO_OV2659 is not set
CONFIG_VIDEO_OV2680=m
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
CONFIG_VIDEO_OV5640=m
CONFIG_VIDEO_OV5645=m
CONFIG_VIDEO_OV5647=m
CONFIG_VIDEO_OV5648=m
CONFIG_VIDEO_OV5670=m
CONFIG_VIDEO_OV5675=m
# CONFIG_VIDEO_OV5693 is not set
# CONFIG_VIDEO_OV5695 is not set
CONFIG_VIDEO_OV6650=m
CONFIG_VIDEO_OV7251=m
CONFIG_VIDEO_OV7640=m
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV772X is not set
CONFIG_VIDEO_OV7740=m
CONFIG_VIDEO_OV8856=m
CONFIG_VIDEO_OV8865=m
CONFIG_VIDEO_OV9282=m
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV9734 is not set
# CONFIG_VIDEO_RDACM20 is not set
CONFIG_VIDEO_RDACM21=m
# CONFIG_VIDEO_RJ54N1 is not set
CONFIG_VIDEO_S5K4ECGX=m
CONFIG_VIDEO_S5K5BAF=m
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K6AA is not set
CONFIG_VIDEO_SR030PC30=m
CONFIG_VIDEO_VS6624=m
CONFIG_VIDEO_CCS=m
# CONFIG_VIDEO_ET8EK8 is not set
CONFIG_VIDEO_M5MOLS=m
# end of Camera sensor devices

#
# Lens drivers
#
CONFIG_VIDEO_AD5820=m
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
CONFIG_VIDEO_DW9768=m
CONFIG_VIDEO_DW9807_VCM=m
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
CONFIG_VIDEO_LM3560=m
CONFIG_VIDEO_LM3646=m
# end of Flash devices

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_CS3308 is not set
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_SONY_BTF_MPX=m
# CONFIG_VIDEO_TDA1997X is not set
# CONFIG_VIDEO_TDA7432 is not set
# CONFIG_VIDEO_TDA9840 is not set
CONFIG_VIDEO_TEA6415C=m
CONFIG_VIDEO_TEA6420=m
CONFIG_VIDEO_TLV320AIC23B=m
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_UDA1342=m
# CONFIG_VIDEO_VP27SMPX is not set
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_WM8775=m
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
CONFIG_VIDEO_ADV7183=m
CONFIG_VIDEO_ADV748X=m
# CONFIG_VIDEO_ADV7604 is not set
CONFIG_VIDEO_ADV7842=m
# CONFIG_VIDEO_ADV7842_CEC is not set
CONFIG_VIDEO_BT819=m
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
CONFIG_VIDEO_ISL7998X=m
CONFIG_VIDEO_KS0127=m
# CONFIG_VIDEO_MAX9286 is not set
# CONFIG_VIDEO_ML86V7667 is not set
CONFIG_VIDEO_SAA7110=m
CONFIG_VIDEO_SAA711X=m
CONFIG_VIDEO_TC358743=m
# CONFIG_VIDEO_TC358743_CEC is not set
CONFIG_VIDEO_TVP514X=m
# CONFIG_VIDEO_TVP5150 is not set
CONFIG_VIDEO_TVP7002=m
CONFIG_VIDEO_TW2804=m
CONFIG_VIDEO_TW9903=m
CONFIG_VIDEO_TW9906=m
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m
# end of Video decoders

#
# Video encoders
#
CONFIG_VIDEO_AD9389B=m
CONFIG_VIDEO_ADV7170=m
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
CONFIG_VIDEO_ADV7511=m
CONFIG_VIDEO_ADV7511_CEC=y
CONFIG_VIDEO_AK881X=m
CONFIG_VIDEO_SAA7127=m
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m
# end of Video improvement chips

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set
# end of Audio/Video compression chips

#
# SDR tuner chips
#
CONFIG_SDR_MAX2175=m
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_I2C=m
# CONFIG_VIDEO_M52790 is not set
CONFIG_VIDEO_ST_MIPID02=m
# CONFIG_VIDEO_THS7303 is not set
# end of Miscellaneous helper chips

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
# CONFIG_MEDIA_TUNER_FC2580 is not set
# CONFIG_MEDIA_TUNER_IT913X is not set
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_MT2266=m
# CONFIG_MEDIA_TUNER_MXL301RF is not set
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
# CONFIG_MEDIA_TUNER_QT1010 is not set
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_TDA18218=m
# CONFIG_MEDIA_TUNER_TDA18250 is not set
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_XC5000=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
# CONFIG_DVB_M88DS3103 is not set
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_STB0899=m
# CONFIG_DVB_STB6100 is not set
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
# CONFIG_DVB_STV6110x is not set
# CONFIG_DVB_STV6111 is not set

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_TDA18271C2DD=m

#
# DVB-S (satellite) frontends
#
# CONFIG_DVB_CX24110 is not set
CONFIG_DVB_CX24116=m
# CONFIG_DVB_CX24117 is not set
CONFIG_DVB_CX24120=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_MT312=m
CONFIG_DVB_S5H1420=m
# CONFIG_DVB_SI21XX is not set
# CONFIG_DVB_STB6000 is not set
CONFIG_DVB_STV0288=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV0900=m
# CONFIG_DVB_STV6110 is not set
CONFIG_DVB_TDA10071=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TS2020=m
# CONFIG_DVB_TUA6100 is not set
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m

#
# DVB-T (terrestrial) frontends
#
# CONFIG_DVB_AF9013 is not set
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
# CONFIG_DVB_DIB3000MB is not set
CONFIG_DVB_DIB3000MC=m
# CONFIG_DVB_DIB7000M is not set
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_DIB9000=m
# CONFIG_DVB_DRXD is not set
CONFIG_DVB_EC100=m
CONFIG_DVB_L64781=m
CONFIG_DVB_MT352=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_RTL2832_SDR=m
# CONFIG_DVB_S5H1432 is not set
CONFIG_DVB_SI2168=m
# CONFIG_DVB_SP887X is not set
CONFIG_DVB_STV0367=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_ZD1301_DEMOD=m
CONFIG_DVB_ZL10353=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_STV0297=m
# CONFIG_DVB_TDA10021 is not set
# CONFIG_DVB_TDA10023 is not set
CONFIG_DVB_VES1820=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_BCM3510=m
# CONFIG_DVB_LG2160 is not set
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_MXL692=m
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m
CONFIG_DVB_S921=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_MN88443X=m
CONFIG_DVB_TC90522=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
# CONFIG_DVB_TUNER_DIB0090 is not set

#
# SEC control devices for DVB-S
#
# CONFIG_DVB_A8293 is not set
CONFIG_DVB_AF9033=m
CONFIG_DVB_ASCOT2E=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_HELENE=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_LGS8GL5=m
# CONFIG_DVB_LGS8GXX is not set
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBH29=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_TDA665x=m
# CONFIG_DVB_DRX39XYJ is not set

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
CONFIG_DVB_SP2=m
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_TEGRA_HOST1X_CONTEXT_BUS=y
CONFIG_TEGRA_HOST1X=m
# CONFIG_TEGRA_HOST1X_FIREWALL is not set
CONFIG_IMX_IPUV3_CORE=y
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DEBUG_MM is not set
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=y
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_DP_AUX_BUS=y
CONFIG_DRM_DISPLAY_HELPER=y
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_TTM=y
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
CONFIG_DRM_I2C_SIL164=y
CONFIG_DRM_I2C_NXP_TDA998X=m
CONFIG_DRM_I2C_NXP_TDA9950=y
# end of I2C encoder or helper chips

#
# ARM devices
#
CONFIG_DRM_HDLCD=m
# CONFIG_DRM_HDLCD_SHOW_UNDERRUN is not set
CONFIG_DRM_MALI_DISPLAY=m
# CONFIG_DRM_KOMEDA is not set
# end of ARM devices

CONFIG_DRM_RADEON=y
# CONFIG_DRM_RADEON_USERPTR is not set
CONFIG_DRM_AMDGPU=m
CONFIG_DRM_AMDGPU_SI=y
# CONFIG_DRM_AMDGPU_CIK is not set
# CONFIG_DRM_AMDGPU_USERPTR is not set

#
# ACP (Audio CoProcessor) Configuration
#
# CONFIG_DRM_AMD_ACP is not set
# end of ACP (Audio CoProcessor) Configuration

#
# Display Engine Configuration
#
# CONFIG_DRM_AMD_DC is not set
# end of Display Engine Configuration

CONFIG_DRM_NOUVEAU=m
# CONFIG_NOUVEAU_LEGACY_CTX_SUPPORT is not set
CONFIG_NOUVEAU_DEBUG=5
CONFIG_NOUVEAU_DEBUG_DEFAULT=3
# CONFIG_NOUVEAU_DEBUG_MMU is not set
CONFIG_NOUVEAU_DEBUG_PUSH=y
# CONFIG_DRM_NOUVEAU_BACKLIGHT is not set
CONFIG_DRM_KMB_DISPLAY=y
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_EXYNOS=y

#
# CRTCs
#
# CONFIG_DRM_EXYNOS_FIMD is not set
CONFIG_DRM_EXYNOS5433_DECON=y
# CONFIG_DRM_EXYNOS7_DECON is not set
# CONFIG_DRM_EXYNOS_MIXER is not set
CONFIG_DRM_EXYNOS_VIDI=y

#
# Encoders and Bridges
#
# CONFIG_DRM_EXYNOS_DSI is not set
CONFIG_DRM_EXYNOS_HDMI=y
CONFIG_DRM_EXYNOS_MIC=y

#
# Sub-drivers
#
CONFIG_DRM_EXYNOS_G2D=y
# CONFIG_DRM_EXYNOS_FIMC is not set
# CONFIG_DRM_EXYNOS_ROTATOR is not set
# CONFIG_DRM_EXYNOS_SCALER is not set
# CONFIG_DRM_EXYNOS_GSC is not set
CONFIG_DRM_UDL=y
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_ARMADA=m
CONFIG_DRM_ATMEL_HLCDC=m
# CONFIG_DRM_RCAR_DU is not set
CONFIG_DRM_RCAR_DW_HDMI=m
# CONFIG_DRM_RCAR_USE_LVDS is not set
CONFIG_DRM_RCAR_MIPI_DSI=m
CONFIG_DRM_SHMOBILE=m
# CONFIG_DRM_SUN4I is not set
# CONFIG_DRM_OMAP is not set
CONFIG_DRM_TILCDC=m
CONFIG_DRM_QXL=y
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_DRM_MSM=m
CONFIG_DRM_MSM_GPU_STATE=y
CONFIG_DRM_MSM_MDSS=y
CONFIG_DRM_MSM_MDP4=y
CONFIG_DRM_MSM_MDP5=y
CONFIG_DRM_MSM_DPU=y
# CONFIG_DRM_MSM_DP is not set
# CONFIG_DRM_MSM_DSI is not set
# CONFIG_DRM_MSM_HDMI is not set
# CONFIG_DRM_FSL_DCU is not set
CONFIG_DRM_TEGRA=m
# CONFIG_DRM_TEGRA_DEBUG is not set
# CONFIG_DRM_TEGRA_STAGING is not set
CONFIG_DRM_STM=m
CONFIG_DRM_STM_DSI=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_ARM_VERSATILE is not set
# CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596 is not set
# CONFIG_DRM_PANEL_BOE_BF060Y8M_AJ0 is not set
CONFIG_DRM_PANEL_BOE_HIMAX8279D=m
# CONFIG_DRM_PANEL_BOE_TV101WUM_NL6 is not set
CONFIG_DRM_PANEL_DSI_CM=m
CONFIG_DRM_PANEL_LVDS=y
CONFIG_DRM_PANEL_SIMPLE=m
# CONFIG_DRM_PANEL_EDP is not set
CONFIG_DRM_PANEL_ELIDA_KD35T133=m
CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02=m
CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D=y
CONFIG_DRM_PANEL_ILITEK_ILI9881C=y
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=y
CONFIG_DRM_PANEL_JDI_LT070ME05000=y
CONFIG_DRM_PANEL_JDI_R63452=m
CONFIG_DRM_PANEL_KHADAS_TS050=m
# CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04 is not set
# CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W is not set
CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829=m
# CONFIG_DRM_PANEL_NOVATEK_NT35510 is not set
CONFIG_DRM_PANEL_NOVATEK_NT35560=y
# CONFIG_DRM_PANEL_NOVATEK_NT35950 is not set
CONFIG_DRM_PANEL_NOVATEK_NT36672A=y
# CONFIG_DRM_PANEL_MANTIX_MLAF057WE51 is not set
CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO=y
CONFIG_DRM_PANEL_ORISETECH_OTM8009A=m
CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS=y
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=y
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=m
CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
CONFIG_DRM_PANEL_RAYDIUM_RM68200=m
# CONFIG_DRM_PANEL_RONBO_RB070D30 is not set
# CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6D16D0=y
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=m
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0=y
# CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_DSI is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01=m
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
CONFIG_DRM_PANEL_SAMSUNG_SOFEF00=y
CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=y
# CONFIG_DRM_PANEL_SHARP_LS037V7DW01 is not set
# CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set
CONFIG_DRM_PANEL_SHARP_LS060T1SX01=y
CONFIG_DRM_PANEL_SITRONIX_ST7701=m
# CONFIG_DRM_PANEL_SITRONIX_ST7703 is not set
CONFIG_DRM_PANEL_SONY_TULIP_TRULY_NT35521=m
# CONFIG_DRM_PANEL_TDO_TL070WSH30 is not set
# CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA is not set
# CONFIG_DRM_PANEL_VISIONOX_RM69299 is not set
# CONFIG_DRM_PANEL_XINPENG_XPP055C272 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_CDNS_DSI is not set
CONFIG_DRM_CHIPONE_ICN6211=m
# CONFIG_DRM_CHRONTEL_CH7033 is not set
# CONFIG_DRM_CROS_EC_ANX7688 is not set
CONFIG_DRM_DISPLAY_CONNECTOR=y
CONFIG_DRM_FSL_LDB=m
CONFIG_DRM_ITE_IT6505=y
CONFIG_DRM_LONTIUM_LT8912B=y
CONFIG_DRM_LONTIUM_LT9211=y
CONFIG_DRM_LONTIUM_LT9611=m
CONFIG_DRM_LONTIUM_LT9611UXC=m
CONFIG_DRM_ITE_IT66121=y
# CONFIG_DRM_LVDS_CODEC is not set
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=m
CONFIG_DRM_NWL_MIPI_DSI=m
CONFIG_DRM_NXP_PTN3460=m
CONFIG_DRM_PARADE_PS8622=y
# CONFIG_DRM_PARADE_PS8640 is not set
# CONFIG_DRM_SIL_SII8620 is not set
# CONFIG_DRM_SII902X is not set
CONFIG_DRM_SII9234=y
CONFIG_DRM_SIMPLE_BRIDGE=y
# CONFIG_DRM_THINE_THC63LVD1024 is not set
CONFIG_DRM_TOSHIBA_TC358762=y
CONFIG_DRM_TOSHIBA_TC358764=m
CONFIG_DRM_TOSHIBA_TC358767=m
# CONFIG_DRM_TOSHIBA_TC358768 is not set
CONFIG_DRM_TOSHIBA_TC358775=y
CONFIG_DRM_TI_TFP410=m
CONFIG_DRM_TI_SN65DSI83=m
# CONFIG_DRM_TI_SN65DSI86 is not set
CONFIG_DRM_TI_TPD12S015=y
CONFIG_DRM_ANALOGIX_ANX6345=m
CONFIG_DRM_ANALOGIX_ANX78XX=m
CONFIG_DRM_ANALOGIX_DP=m
CONFIG_DRM_ANALOGIX_ANX7625=m
CONFIG_DRM_I2C_ADV7511=m
CONFIG_DRM_I2C_ADV7511_AUDIO=y
CONFIG_DRM_I2C_ADV7511_CEC=y
# CONFIG_DRM_CDNS_MHDP8546 is not set
CONFIG_DRM_DW_HDMI=m
CONFIG_DRM_DW_HDMI_AHB_AUDIO=m
CONFIG_DRM_DW_HDMI_I2S_AUDIO=m
CONFIG_DRM_DW_HDMI_GP_AUDIO=m
CONFIG_DRM_DW_HDMI_CEC=m
CONFIG_DRM_DW_MIPI_DSI=m
# end of Display Interface Bridges

# CONFIG_DRM_STI is not set
# CONFIG_DRM_IMX is not set
CONFIG_DRM_INGENIC=m
# CONFIG_DRM_INGENIC_IPU is not set
CONFIG_DRM_V3D=y
CONFIG_DRM_VC4=m
# CONFIG_DRM_VC4_HDMI_CEC is not set
# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_HISI_HIBMC=m
CONFIG_DRM_MXS=y
CONFIG_DRM_MXSFB=y
# CONFIG_DRM_MESON is not set
# CONFIG_DRM_ARCPGU is not set
# CONFIG_DRM_BOCHS is not set
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
CONFIG_DRM_SIMPLEDRM=m
CONFIG_DRM_PL111=m
CONFIG_DRM_TVE200=y
# CONFIG_DRM_LIMA is not set
CONFIG_DRM_PANFROST=m
# CONFIG_DRM_ASPEED_GFX is not set
CONFIG_DRM_MCDE=y
# CONFIG_DRM_TIDSS is not set
CONFIG_DRM_GUD=y
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_SPRD is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
# CONFIG_FB is not set
CONFIG_MMP_DISP=m
# CONFIG_MMP_DISP_CONTROLLER is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_PLATFORM is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=y
# CONFIG_BACKLIGHT_LM3533 is not set
# CONFIG_BACKLIGHT_OMAP1 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_DA903X=m
CONFIG_BACKLIGHT_DA9052=m
CONFIG_BACKLIGHT_MAX8925=m
CONFIG_BACKLIGHT_QCOM_WLED=y
CONFIG_BACKLIGHT_WM831X=y
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=m
# CONFIG_BACKLIGHT_LM3630A is not set
CONFIG_BACKLIGHT_LM3639=m
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_LP8788 is not set
CONFIG_BACKLIGHT_SKY81452=m
CONFIG_BACKLIGHT_TPS65217=y
CONFIG_BACKLIGHT_GPIO=m
CONFIG_BACKLIGHT_LV5207LP=m
CONFIG_BACKLIGHT_BD6107=m
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_BACKLIGHT_LED=m
# end of Backlight & LCD device support

CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_DUMMY_CONSOLE=y
# end of Console display driver support
# end of Graphics support

CONFIG_SOUND=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_PCM_IEC958=y
CONFIG_SND_DMAENGINE_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
# CONFIG_SND_VERBOSE_PROCFS is not set
CONFIG_SND_VERBOSE_PRINTK=y
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_CTL_LED=m
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
# CONFIG_SND_DRIVERS is not set
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
CONFIG_SND_AW2=m
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
# CONFIG_SND_CMIPCI is not set
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CS5535AUDIO=m
CONFIG_SND_CTXFI=m
# CONFIG_SND_DARLA20 is not set
CONFIG_SND_GINA20=m
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
# CONFIG_SND_MONA is not set
CONFIG_SND_MIA=m
# CONFIG_SND_ECHO3G is not set
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
# CONFIG_SND_INDIGOIOX is not set
CONFIG_SND_INDIGODJX=m
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
CONFIG_SND_FM801=m
# CONFIG_SND_FM801_TEA575X_BOOL is not set
# CONFIG_SND_HDSP is not set
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
# CONFIG_SND_INTEL8X0M is not set
CONFIG_SND_KORG1212=m
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
CONFIG_SND_MIXART=m
CONFIG_SND_NM256=m
CONFIG_SND_PCXHR=m
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_GENERIC_LEDS=y
# CONFIG_SND_HDA_INTEL is not set
# CONFIG_SND_HDA_HWDEP is not set
CONFIG_SND_HDA_RECONFIG=y
# CONFIG_SND_HDA_INPUT_BEEP is not set
CONFIG_SND_HDA_PATCH_LOADER=y
# CONFIG_SND_HDA_CODEC_REALTEK is not set
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CS8409=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
# CONFIG_SND_HDA_CODEC_CA0110 is not set
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
# CONFIG_SND_HDA_CODEC_CMEDIA is not set
# CONFIG_SND_HDA_CODEC_SI3054 is not set
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=64
CONFIG_SND_INTEL_DSP_CONFIG=m
# CONFIG_SND_ARM is not set
CONFIG_SND_USB=y
# CONFIG_SND_USB_AUDIO is not set
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
# CONFIG_SND_USB_HIFACE is not set
# CONFIG_SND_BCD2000 is not set
CONFIG_SND_USB_LINE6=m
# CONFIG_SND_USB_POD is not set
CONFIG_SND_USB_PODHD=m
CONFIG_SND_USB_TONEPORT=m
CONFIG_SND_USB_VARIAX=m
CONFIG_SND_SOC=m
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_TOPOLOGY_KUNIT_TEST=m
CONFIG_SND_SOC_UTILS_KUNIT_TEST=m
CONFIG_SND_SOC_ADI=m
CONFIG_SND_SOC_ADI_AXI_I2S=m
CONFIG_SND_SOC_ADI_AXI_SPDIF=m
CONFIG_SND_SOC_AMD_ACP=m
# CONFIG_SND_SOC_AMD_CZ_RT5645_MACH is not set
# CONFIG_SND_AMD_ACP_CONFIG is not set
CONFIG_SND_ATMEL_SOC=m
CONFIG_SND_ATMEL_SOC_PDC=y
CONFIG_SND_ATMEL_SOC_DMA=y
CONFIG_SND_ATMEL_SOC_SSC=m
CONFIG_SND_ATMEL_SOC_SSC_PDC=m
CONFIG_SND_ATMEL_SOC_SSC_DMA=m
CONFIG_SND_AT91_SOC_SAM9G20_WM8731=m
CONFIG_SND_ATMEL_SOC_WM8904=m
CONFIG_SND_AT91_SOC_SAM9X5_WM8731=m
# CONFIG_SND_ATMEL_SOC_CLASSD is not set
CONFIG_SND_ATMEL_SOC_PDMIC=m
# CONFIG_SND_ATMEL_SOC_I2S is not set
# CONFIG_SND_SOC_MIKROE_PROTO is not set
CONFIG_SND_MCHP_SOC_I2S_MCC=m
# CONFIG_SND_MCHP_SOC_SPDIFTX is not set
CONFIG_SND_MCHP_SOC_SPDIFRX=m
# CONFIG_SND_MCHP_SOC_PDMC is not set
# CONFIG_SND_BCM2835_SOC_I2S is not set
# CONFIG_SND_SOC_CYGNUS is not set
CONFIG_SND_BCM63XX_I2S_WHISTLER=m
CONFIG_SND_EP93XX_SOC=m
CONFIG_SND_DESIGNWARE_I2S=m
# CONFIG_SND_DESIGNWARE_PCM is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
CONFIG_SND_SOC_FSL_ASRC=m
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
CONFIG_SND_SOC_FSL_SSI=m
CONFIG_SND_SOC_FSL_SPDIF=m
# CONFIG_SND_SOC_FSL_ESAI is not set
CONFIG_SND_SOC_FSL_MICFIL=m
# CONFIG_SND_SOC_FSL_EASRC is not set
CONFIG_SND_SOC_FSL_XCVR=m
CONFIG_SND_SOC_FSL_AUD2HTX=m
# CONFIG_SND_SOC_FSL_RPMSG is not set
CONFIG_SND_SOC_IMX_AUDMUX=m
# CONFIG_SND_IMX_SOC is not set
# end of SoC Audio for Freescale CPUs

# CONFIG_SND_I2S_HI6210_I2S is not set
# CONFIG_SND_JZ4740_SOC_I2S is not set
# CONFIG_SND_KIRKWOOD_SOC is not set
CONFIG_SND_SOC_IMG=y
CONFIG_SND_SOC_IMG_I2S_IN=m
CONFIG_SND_SOC_IMG_I2S_OUT=m
CONFIG_SND_SOC_IMG_PARALLEL_OUT=m
CONFIG_SND_SOC_IMG_SPDIF_IN=m
CONFIG_SND_SOC_IMG_SPDIF_OUT=m
CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC=m
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SOC_INTEL_KEEMBAY=m
CONFIG_SND_SOC_INTEL_AVS=m
CONFIG_SND_SOC_INTEL_MACH=y
# CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES is not set
CONFIG_SND_SOC_MEDIATEK=m
CONFIG_SND_SOC_MTK_BTCVSD=m
CONFIG_SND_SOC_MT8195=m
CONFIG_SND_SOC_MT8195_MT6359=m

#
# ASoC support for Amlogic platforms
#
# CONFIG_SND_MESON_AIU is not set
CONFIG_SND_MESON_AXG_FIFO=m
CONFIG_SND_MESON_AXG_FRDDR=m
# CONFIG_SND_MESON_AXG_TODDR is not set
CONFIG_SND_MESON_AXG_TDM_FORMATTER=m
CONFIG_SND_MESON_AXG_TDM_INTERFACE=m
CONFIG_SND_MESON_AXG_TDMIN=m
CONFIG_SND_MESON_AXG_TDMOUT=m
CONFIG_SND_MESON_AXG_SOUND_CARD=m
CONFIG_SND_MESON_AXG_SPDIFOUT=m
# CONFIG_SND_MESON_AXG_SPDIFIN is not set
# CONFIG_SND_MESON_AXG_PDM is not set
CONFIG_SND_MESON_CARD_UTILS=m
CONFIG_SND_MESON_CODEC_GLUE=m
CONFIG_SND_MESON_GX_SOUND_CARD=m
CONFIG_SND_MESON_G12A_TOACODEC=m
CONFIG_SND_MESON_G12A_TOHDMITX=m
CONFIG_SND_SOC_MESON_T9015=m
# end of ASoC support for Amlogic platforms

# CONFIG_SND_MXS_SOC is not set
# CONFIG_SND_PXA2XX_SOC is not set
CONFIG_SND_SOC_QCOM=m
CONFIG_SND_SOC_LPASS_CPU=m
CONFIG_SND_SOC_LPASS_HDMI=m
CONFIG_SND_SOC_LPASS_PLATFORM=m
CONFIG_SND_SOC_LPASS_CDC_DMA=m
CONFIG_SND_SOC_LPASS_IPQ806X=m
CONFIG_SND_SOC_LPASS_SC7280=m
CONFIG_SND_SOC_STORM=m
# CONFIG_SND_SOC_APQ8016_SBC is not set
CONFIG_SND_SOC_QCOM_COMMON=m
CONFIG_SND_SOC_QDSP6_COMMON=m
CONFIG_SND_SOC_QDSP6_CORE=m
CONFIG_SND_SOC_QDSP6_AFE=m
CONFIG_SND_SOC_QDSP6_AFE_DAI=m
CONFIG_SND_SOC_QDSP6_AFE_CLOCKS=m
CONFIG_SND_SOC_QDSP6_ADM=m
CONFIG_SND_SOC_QDSP6_ROUTING=m
CONFIG_SND_SOC_QDSP6_ASM=m
CONFIG_SND_SOC_QDSP6_ASM_DAI=m
CONFIG_SND_SOC_QDSP6_APM_DAI=m
CONFIG_SND_SOC_QDSP6_APM_LPASS_DAI=m
CONFIG_SND_SOC_QDSP6_APM=m
CONFIG_SND_SOC_QDSP6_PRM_LPASS_CLOCKS=m
CONFIG_SND_SOC_QDSP6_PRM=m
CONFIG_SND_SOC_QDSP6=m
# CONFIG_SND_SOC_MSM8996 is not set
CONFIG_SND_SOC_SDM845=m
# CONFIG_SND_SOC_SM8250 is not set
# CONFIG_SND_SOC_SC7180 is not set
CONFIG_SND_SOC_SC7280=m
CONFIG_SND_SOC_ROCKCHIP=m
CONFIG_SND_SOC_ROCKCHIP_I2S=m
CONFIG_SND_SOC_ROCKCHIP_I2S_TDM=m
CONFIG_SND_SOC_ROCKCHIP_PDM=m
# CONFIG_SND_SOC_ROCKCHIP_SPDIF is not set
CONFIG_SND_SOC_ROCKCHIP_MAX98090=m
# CONFIG_SND_SOC_ROCKCHIP_RT5645 is not set
CONFIG_SND_SOC_RK3288_HDMI_ANALOG=m
# CONFIG_SND_SOC_SAMSUNG is not set

#
# SoC Audio support for Renesas SoCs
#
CONFIG_SND_SOC_SH4_FSI=m
CONFIG_SND_SOC_RCAR=m
CONFIG_SND_SOC_RZ=m
# end of SoC Audio support for Renesas SoCs

# CONFIG_SND_SOC_SOF_TOPLEVEL is not set
CONFIG_SND_SOC_SPRD=m
# CONFIG_SND_SOC_SPRD_MCDT is not set
CONFIG_SND_SOC_STI=m

#
# STMicroelectronics STM32 SOC audio support
#
CONFIG_SND_SOC_STM32_SAI=m
CONFIG_SND_SOC_STM32_I2S=m
CONFIG_SND_SOC_STM32_SPDIFRX=m
# end of STMicroelectronics STM32 SOC audio support

#
# Allwinner SoC Audio support
#
CONFIG_SND_SUN4I_CODEC=m
# CONFIG_SND_SUN8I_CODEC is not set
CONFIG_SND_SUN8I_CODEC_ANALOG=m
CONFIG_SND_SUN50I_CODEC_ANALOG=m
CONFIG_SND_SUN4I_I2S=m
CONFIG_SND_SUN4I_SPDIF=m
CONFIG_SND_SUN8I_ADDA_PR_REGMAP=m
# end of Allwinner SoC Audio support

CONFIG_SND_SOC_TEGRA=m
CONFIG_SND_SOC_TEGRA20_AC97=m
CONFIG_SND_SOC_TEGRA20_DAS=m
CONFIG_SND_SOC_TEGRA20_I2S=m
# CONFIG_SND_SOC_TEGRA20_SPDIF is not set
# CONFIG_SND_SOC_TEGRA30_AHUB is not set
# CONFIG_SND_SOC_TEGRA30_I2S is not set
# CONFIG_SND_SOC_TEGRA210_AHUB is not set
CONFIG_SND_SOC_TEGRA210_DMIC=m
# CONFIG_SND_SOC_TEGRA210_I2S is not set
# CONFIG_SND_SOC_TEGRA186_ASRC is not set
# CONFIG_SND_SOC_TEGRA186_DSPK is not set
CONFIG_SND_SOC_TEGRA210_ADMAIF=m
CONFIG_SND_SOC_TEGRA210_MVC=m
CONFIG_SND_SOC_TEGRA210_SFC=m
CONFIG_SND_SOC_TEGRA210_AMX=m
# CONFIG_SND_SOC_TEGRA210_ADX is not set
CONFIG_SND_SOC_TEGRA210_MIXER=m
CONFIG_SND_SOC_TEGRA_MACHINE_DRV=m
CONFIG_SND_SOC_TEGRA_RT5640=m
CONFIG_SND_SOC_TEGRA_WM8753=m
CONFIG_SND_SOC_TEGRA_WM8903=m
CONFIG_SND_SOC_TEGRA_WM9712=m
CONFIG_SND_SOC_TEGRA_TRIMSLICE=m
# CONFIG_SND_SOC_TEGRA_ALC5632 is not set
CONFIG_SND_SOC_TEGRA_MAX98090=m
CONFIG_SND_SOC_TEGRA_RT5677=m
CONFIG_SND_SOC_TEGRA_SGTL5000=m

#
# Audio support for Texas Instruments SoCs
#
CONFIG_SND_SOC_TI_EDMA_PCM=m
CONFIG_SND_SOC_TI_SDMA_PCM=m
CONFIG_SND_SOC_TI_UDMA_PCM=m

#
# Texas Instruments DAI support for:
#
CONFIG_SND_SOC_DAVINCI_ASP=m
CONFIG_SND_SOC_DAVINCI_MCASP=m
CONFIG_SND_SOC_DAVINCI_VCIF=m
CONFIG_SND_SOC_OMAP_DMIC=m
CONFIG_SND_SOC_OMAP_MCBSP=m
# CONFIG_SND_SOC_OMAP_MCPDM is not set

#
# Audio support for boards with Texas Instruments SoCs
#
# CONFIG_SND_SOC_OMAP_HDMI is not set
# CONFIG_SND_SOC_J721E_EVM is not set
# end of Audio support for Texas Instruments SoCs

# CONFIG_SND_SOC_UNIPHIER is not set
CONFIG_SND_SOC_XILINX_I2S=m
CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER=m
CONFIG_SND_SOC_XILINX_SPDIF=m
# CONFIG_SND_SOC_XTFPGA_I2S is not set
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
CONFIG_SND_SOC_ALL_CODECS=m
# CONFIG_SND_SOC_88PM860X is not set
CONFIG_SND_SOC_WM_HUBS=m
CONFIG_SND_SOC_WM_ADSP=m
CONFIG_SND_SOC_AB8500_CODEC=m
CONFIG_SND_SOC_AC97_CODEC=m
# CONFIG_SND_SOC_AD1836 is not set
CONFIG_SND_SOC_AD193X=m
# CONFIG_SND_SOC_AD193X_SPI is not set
CONFIG_SND_SOC_AD193X_I2C=m
CONFIG_SND_SOC_AD1980=m
CONFIG_SND_SOC_AD73311=m
CONFIG_SND_SOC_ADAU_UTILS=m
CONFIG_SND_SOC_ADAU1372=m
CONFIG_SND_SOC_ADAU1372_I2C=m
# CONFIG_SND_SOC_ADAU1372_SPI is not set
CONFIG_SND_SOC_ADAU1373=m
# CONFIG_SND_SOC_ADAU1701 is not set
CONFIG_SND_SOC_ADAU17X1=m
# CONFIG_SND_SOC_ADAU1761_I2C is not set
# CONFIG_SND_SOC_ADAU1761_SPI is not set
CONFIG_SND_SOC_ADAU1781=m
CONFIG_SND_SOC_ADAU1781_I2C=m
# CONFIG_SND_SOC_ADAU1781_SPI is not set
CONFIG_SND_SOC_ADAU1977=m
# CONFIG_SND_SOC_ADAU1977_SPI is not set
CONFIG_SND_SOC_ADAU1977_I2C=m
CONFIG_SND_SOC_ADAU7002=m
CONFIG_SND_SOC_ADAU7118=m
CONFIG_SND_SOC_ADAU7118_HW=m
CONFIG_SND_SOC_ADAU7118_I2C=m
CONFIG_SND_SOC_ADAV80X=m
# CONFIG_SND_SOC_ADAV801 is not set
CONFIG_SND_SOC_ADAV803=m
CONFIG_SND_SOC_ADS117X=m
# CONFIG_SND_SOC_AK4104 is not set
CONFIG_SND_SOC_AK4118=m
# CONFIG_SND_SOC_AK4375 is not set
# CONFIG_SND_SOC_AK4458 is not set
CONFIG_SND_SOC_AK4535=m
# CONFIG_SND_SOC_AK4554 is not set
CONFIG_SND_SOC_AK4613=m
CONFIG_SND_SOC_AK4641=m
CONFIG_SND_SOC_AK4642=m
CONFIG_SND_SOC_AK4671=m
CONFIG_SND_SOC_AK5386=m
# CONFIG_SND_SOC_AK5558 is not set
CONFIG_SND_SOC_ALC5623=m
CONFIG_SND_SOC_ALC5632=m
# CONFIG_SND_SOC_AW8738 is not set
# CONFIG_SND_SOC_BD28623 is not set
CONFIG_SND_SOC_BT_SCO=m
CONFIG_SND_SOC_CQ0093VC=m
CONFIG_SND_SOC_CROS_EC_CODEC=m
CONFIG_SND_SOC_CS35L32=m
# CONFIG_SND_SOC_CS35L33 is not set
CONFIG_SND_SOC_CS35L34=m
CONFIG_SND_SOC_CS35L35=m
CONFIG_SND_SOC_CS35L36=m
CONFIG_SND_SOC_CS35L41_LIB=m
CONFIG_SND_SOC_CS35L41=m
# CONFIG_SND_SOC_CS35L41_SPI is not set
CONFIG_SND_SOC_CS35L41_I2C=m
# CONFIG_SND_SOC_CS35L45_SPI is not set
# CONFIG_SND_SOC_CS35L45_I2C is not set
CONFIG_SND_SOC_CS42L42=m
CONFIG_SND_SOC_CS42L51=m
CONFIG_SND_SOC_CS42L51_I2C=m
CONFIG_SND_SOC_CS42L52=m
CONFIG_SND_SOC_CS42L56=m
CONFIG_SND_SOC_CS42L73=m
CONFIG_SND_SOC_CS4234=m
CONFIG_SND_SOC_CS4265=m
# CONFIG_SND_SOC_CS4270 is not set
CONFIG_SND_SOC_CS4271=m
CONFIG_SND_SOC_CS4271_I2C=m
# CONFIG_SND_SOC_CS4271_SPI is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
CONFIG_SND_SOC_CS43130=m
CONFIG_SND_SOC_CS4341=m
CONFIG_SND_SOC_CS4349=m
CONFIG_SND_SOC_CS47L15=m
# CONFIG_SND_SOC_CS47L24 is not set
CONFIG_SND_SOC_CS47L35=m
# CONFIG_SND_SOC_CS47L85 is not set
# CONFIG_SND_SOC_CS47L90 is not set
CONFIG_SND_SOC_CS47L92=m
CONFIG_SND_SOC_CS53L30=m
CONFIG_SND_SOC_CX20442=m
CONFIG_SND_SOC_CX2072X=m
# CONFIG_SND_SOC_JZ4740_CODEC is not set
CONFIG_SND_SOC_JZ4725B_CODEC=m
CONFIG_SND_SOC_JZ4760_CODEC=m
# CONFIG_SND_SOC_JZ4770_CODEC is not set
CONFIG_SND_SOC_L3=m
CONFIG_SND_SOC_DA7210=m
CONFIG_SND_SOC_DA7213=m
CONFIG_SND_SOC_DA7218=m
CONFIG_SND_SOC_DA7219=m
CONFIG_SND_SOC_DA732X=m
CONFIG_SND_SOC_DA9055=m
CONFIG_SND_SOC_DMIC=m
CONFIG_SND_SOC_HDMI_CODEC=m
CONFIG_SND_SOC_ES7134=m
# CONFIG_SND_SOC_ES7241 is not set
CONFIG_SND_SOC_ES8316=m
CONFIG_SND_SOC_ES8328=m
CONFIG_SND_SOC_ES8328_I2C=m
# CONFIG_SND_SOC_ES8328_SPI is not set
CONFIG_SND_SOC_GTM601=m
CONFIG_SND_SOC_HDAC_HDMI=m
CONFIG_SND_SOC_HDAC_HDA=m
# CONFIG_SND_SOC_ICS43432 is not set
# CONFIG_SND_SOC_INNO_RK3036 is not set
CONFIG_SND_SOC_ISABELLE=m
CONFIG_SND_SOC_LM49453=m
# CONFIG_SND_SOC_LOCHNAGAR_SC is not set
CONFIG_SND_SOC_MADERA=m
# CONFIG_SND_SOC_MAX98088 is not set
CONFIG_SND_SOC_MAX98090=m
CONFIG_SND_SOC_MAX98095=m
CONFIG_SND_SOC_MAX98357A=m
CONFIG_SND_SOC_MAX98371=m
CONFIG_SND_SOC_MAX98504=m
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98925=m
CONFIG_SND_SOC_MAX98926=m
CONFIG_SND_SOC_MAX98927=m
# CONFIG_SND_SOC_MAX98520 is not set
CONFIG_SND_SOC_MAX98373=m
CONFIG_SND_SOC_MAX98373_I2C=m
CONFIG_SND_SOC_MAX98373_SDW=m
CONFIG_SND_SOC_MAX98390=m
CONFIG_SND_SOC_MAX98396=m
CONFIG_SND_SOC_MAX9850=m
# CONFIG_SND_SOC_MAX9860 is not set
# CONFIG_SND_SOC_MSM8916_WCD_ANALOG is not set
CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
CONFIG_SND_SOC_PCM1681=m
CONFIG_SND_SOC_PCM1789=m
CONFIG_SND_SOC_PCM1789_I2C=m
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM179X_SPI is not set
CONFIG_SND_SOC_PCM186X=m
CONFIG_SND_SOC_PCM186X_I2C=m
# CONFIG_SND_SOC_PCM186X_SPI is not set
CONFIG_SND_SOC_PCM3008=m
CONFIG_SND_SOC_PCM3060=m
CONFIG_SND_SOC_PCM3060_I2C=m
# CONFIG_SND_SOC_PCM3060_SPI is not set
CONFIG_SND_SOC_PCM3168A=m
CONFIG_SND_SOC_PCM3168A_I2C=m
# CONFIG_SND_SOC_PCM3168A_SPI is not set
CONFIG_SND_SOC_PCM5102A=m
# CONFIG_SND_SOC_PCM512x_I2C is not set
# CONFIG_SND_SOC_PCM512x_SPI is not set
# CONFIG_SND_SOC_RK3328 is not set
CONFIG_SND_SOC_RK817=m
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RL6347A=m
CONFIG_SND_SOC_RT274=m
CONFIG_SND_SOC_RT286=m
CONFIG_SND_SOC_RT298=m
CONFIG_SND_SOC_RT1011=m
CONFIG_SND_SOC_RT1015=m
CONFIG_SND_SOC_RT1015P=m
CONFIG_SND_SOC_RT1016=m
CONFIG_SND_SOC_RT1019=m
CONFIG_SND_SOC_RT1305=m
CONFIG_SND_SOC_RT1308=m
CONFIG_SND_SOC_RT1308_SDW=m
# CONFIG_SND_SOC_RT1316_SDW is not set
CONFIG_SND_SOC_RT5514=m
CONFIG_SND_SOC_RT5616=m
CONFIG_SND_SOC_RT5631=m
CONFIG_SND_SOC_RT5640=m
CONFIG_SND_SOC_RT5645=m
CONFIG_SND_SOC_RT5651=m
CONFIG_SND_SOC_RT5659=m
CONFIG_SND_SOC_RT5660=m
CONFIG_SND_SOC_RT5663=m
CONFIG_SND_SOC_RT5665=m
CONFIG_SND_SOC_RT5668=m
CONFIG_SND_SOC_RT5670=m
CONFIG_SND_SOC_RT5677=m
CONFIG_SND_SOC_RT5682=m
CONFIG_SND_SOC_RT5682_I2C=m
CONFIG_SND_SOC_RT5682_SDW=m
CONFIG_SND_SOC_RT5682S=m
CONFIG_SND_SOC_RT700=m
CONFIG_SND_SOC_RT700_SDW=m
CONFIG_SND_SOC_RT711=m
CONFIG_SND_SOC_RT711_SDW=m
CONFIG_SND_SOC_RT711_SDCA_SDW=m
CONFIG_SND_SOC_RT715=m
CONFIG_SND_SOC_RT715_SDW=m
CONFIG_SND_SOC_RT715_SDCA_SDW=m
CONFIG_SND_SOC_RT9120=m
# CONFIG_SND_SOC_SDW_MOCKUP is not set
CONFIG_SND_SOC_SGTL5000=m
CONFIG_SND_SOC_SI476X=m
CONFIG_SND_SOC_SIGMADSP=m
CONFIG_SND_SOC_SIGMADSP_REGMAP=m
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
# CONFIG_SND_SOC_SIMPLE_MUX is not set
CONFIG_SND_SOC_SPDIF=m
CONFIG_SND_SOC_SSM2305=m
CONFIG_SND_SOC_SSM2518=m
# CONFIG_SND_SOC_SSM2602_SPI is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=m
CONFIG_SND_SOC_STA32X=m
CONFIG_SND_SOC_STA350=m
CONFIG_SND_SOC_STA529=m
CONFIG_SND_SOC_STAC9766=m
# CONFIG_SND_SOC_STI_SAS is not set
# CONFIG_SND_SOC_TAS2552 is not set
CONFIG_SND_SOC_TAS2562=m
CONFIG_SND_SOC_TAS2764=m
CONFIG_SND_SOC_TAS2770=m
CONFIG_SND_SOC_TAS5086=m
# CONFIG_SND_SOC_TAS571X is not set
CONFIG_SND_SOC_TAS5720=m
CONFIG_SND_SOC_TAS5805M=m
CONFIG_SND_SOC_TAS6424=m
# CONFIG_SND_SOC_TDA7419 is not set
# CONFIG_SND_SOC_TFA9879 is not set
CONFIG_SND_SOC_TFA989X=m
CONFIG_SND_SOC_TLV320ADC3XXX=m
CONFIG_SND_SOC_TLV320AIC23=m
CONFIG_SND_SOC_TLV320AIC23_I2C=m
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
# CONFIG_SND_SOC_TLV320AIC26 is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
CONFIG_SND_SOC_TLV320AIC32X4=m
CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
CONFIG_SND_SOC_TLV320AIC3X=m
CONFIG_SND_SOC_TLV320AIC3X_I2C=m
# CONFIG_SND_SOC_TLV320AIC3X_SPI is not set
CONFIG_SND_SOC_TLV320DAC33=m
# CONFIG_SND_SOC_TLV320ADCX140 is not set
CONFIG_SND_SOC_TS3A227E=m
CONFIG_SND_SOC_TSCS42XX=m
# CONFIG_SND_SOC_TSCS454 is not set
# CONFIG_SND_SOC_TWL4030 is not set
# CONFIG_SND_SOC_TWL6040 is not set
# CONFIG_SND_SOC_UDA1334 is not set
CONFIG_SND_SOC_UDA134X=m
CONFIG_SND_SOC_UDA1380=m
CONFIG_SND_SOC_WCD9335=m
CONFIG_SND_SOC_WCD_MBHC=m
# CONFIG_SND_SOC_WCD934X is not set
CONFIG_SND_SOC_WCD938X=m
CONFIG_SND_SOC_WCD938X_SDW=m
CONFIG_SND_SOC_WL1273=m
# CONFIG_SND_SOC_WM0010 is not set
CONFIG_SND_SOC_WM1250_EV1=m
CONFIG_SND_SOC_WM2000=m
CONFIG_SND_SOC_WM2200=m
CONFIG_SND_SOC_WM5100=m
# CONFIG_SND_SOC_WM5102 is not set
# CONFIG_SND_SOC_WM5110 is not set
CONFIG_SND_SOC_WM8350=m
CONFIG_SND_SOC_WM8400=m
CONFIG_SND_SOC_WM8510=m
# CONFIG_SND_SOC_WM8523 is not set
CONFIG_SND_SOC_WM8524=m
# CONFIG_SND_SOC_WM8580 is not set
# CONFIG_SND_SOC_WM8711 is not set
CONFIG_SND_SOC_WM8727=m
CONFIG_SND_SOC_WM8728=m
CONFIG_SND_SOC_WM8731=m
CONFIG_SND_SOC_WM8731_I2C=m
# CONFIG_SND_SOC_WM8731_SPI is not set
CONFIG_SND_SOC_WM8737=m
CONFIG_SND_SOC_WM8741=m
CONFIG_SND_SOC_WM8750=m
CONFIG_SND_SOC_WM8753=m
# CONFIG_SND_SOC_WM8770 is not set
CONFIG_SND_SOC_WM8776=m
CONFIG_SND_SOC_WM8782=m
CONFIG_SND_SOC_WM8804=m
CONFIG_SND_SOC_WM8804_I2C=m
# CONFIG_SND_SOC_WM8804_SPI is not set
CONFIG_SND_SOC_WM8900=m
CONFIG_SND_SOC_WM8903=m
CONFIG_SND_SOC_WM8904=m
CONFIG_SND_SOC_WM8940=m
CONFIG_SND_SOC_WM8955=m
CONFIG_SND_SOC_WM8960=m
CONFIG_SND_SOC_WM8961=m
# CONFIG_SND_SOC_WM8962 is not set
CONFIG_SND_SOC_WM8971=m
CONFIG_SND_SOC_WM8974=m
CONFIG_SND_SOC_WM8978=m
CONFIG_SND_SOC_WM8983=m
CONFIG_SND_SOC_WM8985=m
CONFIG_SND_SOC_WM8988=m
CONFIG_SND_SOC_WM8990=m
CONFIG_SND_SOC_WM8991=m
CONFIG_SND_SOC_WM8993=m
CONFIG_SND_SOC_WM8994=m
CONFIG_SND_SOC_WM8995=m
CONFIG_SND_SOC_WM8996=m
# CONFIG_SND_SOC_WM8997 is not set
# CONFIG_SND_SOC_WM8998 is not set
CONFIG_SND_SOC_WM9081=m
CONFIG_SND_SOC_WM9090=m
CONFIG_SND_SOC_WM9705=m
CONFIG_SND_SOC_WM9712=m
CONFIG_SND_SOC_WM9713=m
CONFIG_SND_SOC_WSA881X=m
# CONFIG_SND_SOC_ZL38060 is not set
CONFIG_SND_SOC_LM4857=m
# CONFIG_SND_SOC_MAX9759 is not set
CONFIG_SND_SOC_MAX9768=m
CONFIG_SND_SOC_MAX9877=m
CONFIG_SND_SOC_MC13783=m
CONFIG_SND_SOC_ML26124=m
# CONFIG_SND_SOC_MT6351 is not set
CONFIG_SND_SOC_MT6358=m
CONFIG_SND_SOC_MT6359=m
CONFIG_SND_SOC_MT6359_ACCDET=m
CONFIG_SND_SOC_MT6660=m
CONFIG_SND_SOC_NAU8315=m
# CONFIG_SND_SOC_NAU8540 is not set
CONFIG_SND_SOC_NAU8810=m
# CONFIG_SND_SOC_NAU8821 is not set
CONFIG_SND_SOC_NAU8822=m
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_NAU8825=m
CONFIG_SND_SOC_TPA6130A2=m
CONFIG_SND_SOC_LPASS_MACRO_COMMON=m
CONFIG_SND_SOC_LPASS_WSA_MACRO=m
CONFIG_SND_SOC_LPASS_VA_MACRO=m
# CONFIG_SND_SOC_LPASS_RX_MACRO is not set
# CONFIG_SND_SOC_LPASS_TX_MACRO is not set
# end of CODEC drivers

CONFIG_SND_SIMPLE_CARD_UTILS=m
CONFIG_SND_SIMPLE_CARD=m
# CONFIG_SND_AUDIO_GRAPH_CARD is not set
CONFIG_SND_AUDIO_GRAPH_CARD2=m
CONFIG_SND_AUDIO_GRAPH_CARD2_CUSTOM_SAMPLE=m
CONFIG_SND_TEST_COMPONENT=m
# CONFIG_SND_VIRTIO is not set
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=m
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
CONFIG_UHID=m
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
CONFIG_HID_ACRUX=m
CONFIG_HID_ACRUX_FF=y
# CONFIG_HID_APPLE is not set
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
CONFIG_HID_CHERRY=m
# CONFIG_HID_COUGAR is not set
CONFIG_HID_MACALLY=m
CONFIG_HID_CMEDIA=m
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
CONFIG_DRAGONRISE_FF=y
CONFIG_HID_EMS_FF=m
CONFIG_HID_ELECOM=m
CONFIG_HID_EZKEY=m
# CONFIG_HID_GEMBIRD is not set
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
CONFIG_HID_VIVALDI_COMMON=m
CONFIG_HID_VIVALDI=m
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_WALTOP=m
CONFIG_HID_VIEWSONIC=m
CONFIG_HID_XIAOMI=m
# CONFIG_HID_GYRATION is not set
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_MAGICMOUSE=m
# CONFIG_HID_MALTRON is not set
CONFIG_HID_MAYFLASH=m
CONFIG_HID_REDRAGON=m
# CONFIG_HID_MICROSOFT is not set
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NINTENDO=m
CONFIG_NINTENDO_FF=y
# CONFIG_HID_NTI is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
CONFIG_PANTHERLORD_FF=y
# CONFIG_HID_PETALYNX is not set
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PLAYSTATION is not set
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SEMITEK=m
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
# CONFIG_HID_GREENASIA is not set
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_UDRAW_PS3=m
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# end of Special HID drivers

#
# USB HID support
#
# CONFIG_USB_HID is not set
# CONFIG_HID_PID is not set
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID_OF=m
CONFIG_I2C_HID_OF_GOODIX=m
# end of I2C HID support

CONFIG_I2C_HID_CORE=m

#
# Intel ISH HID support
#
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
CONFIG_AMD_SFH_HID=m
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_EHCI_BIG_ENDIAN_MMIO=y
CONFIG_USB_EHCI_BIG_ENDIAN_DESC=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
CONFIG_USB_ULPI_BUS=y
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
CONFIG_USB_FEW_INIT_RETRIES=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
CONFIG_USB_OTG_PRODUCTLIST=y
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
# CONFIG_USB_MON is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=m
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=m
# CONFIG_USB_XHCI_PCI_RENESAS is not set
CONFIG_USB_XHCI_PLATFORM=m
CONFIG_USB_XHCI_HISTB=m
# CONFIG_USB_XHCI_MTK is not set
# CONFIG_USB_XHCI_MVEBU is not set
CONFIG_USB_XHCI_RCAR=m
# CONFIG_USB_BRCMSTB is not set
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OXU210HP_HCD is not set
CONFIG_USB_ISP116X_HCD=y
# CONFIG_USB_ISP1362_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_OHCI_HCD_SPEAR=m
# CONFIG_USB_OHCI_HCD_STI is not set
# CONFIG_USB_OHCI_HCD_S3C2410 is not set
CONFIG_USB_OHCI_HCD_AT91=m
# CONFIG_USB_OHCI_HCD_OMAP3 is not set
# CONFIG_USB_OHCI_HCD_DAVINCI is not set
CONFIG_USB_OHCI_HCD_PCI=m
CONFIG_USB_OHCI_HCD_SSB=y
CONFIG_USB_OHCI_SH=y
CONFIG_USB_OHCI_EXYNOS=m
# CONFIG_USB_CNS3XXX_OHCI is not set
CONFIG_USB_OHCI_HCD_PLATFORM=m
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_U132_HCD=y
CONFIG_USB_SL811_HCD=y
CONFIG_USB_SL811_HCD_ISO=y
# CONFIG_USB_R8A66597_HCD is not set
CONFIG_USB_HCD_BCMA=m
CONFIG_USB_HCD_SSB=y
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=y
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_REALTEK=m
# CONFIG_REALTEK_AUTOPM is not set
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
# CONFIG_USB_STORAGE_ISD200 is not set
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
CONFIG_USB_CDNS_SUPPORT=m
CONFIG_USB_CDNS_HOST=y
CONFIG_USB_CDNS3=m
CONFIG_USB_CDNS3_HOST=y
CONFIG_USB_CDNS3_TI=m
CONFIG_USB_CDNS3_IMX=m
# CONFIG_USB_MTU3 is not set
CONFIG_USB_MUSB_HDRC=m
CONFIG_USB_MUSB_HOST=y

#
# Platform Glue Layer
#
CONFIG_USB_MUSB_TUSB6010=m
CONFIG_USB_MUSB_DSPS=m
CONFIG_USB_MUSB_UX500=m
CONFIG_USB_MUSB_MEDIATEK=m

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1760_HOST_ROLE=y

#
# USB port drivers
#
CONFIG_USB_USS720=y
CONFIG_USB_SERIAL=y
# CONFIG_USB_SERIAL_CONSOLE is not set
# CONFIG_USB_SERIAL_GENERIC is not set
# CONFIG_USB_SERIAL_SIMPLE is not set
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=y
# CONFIG_USB_SERIAL_BELKIN is not set
CONFIG_USB_SERIAL_CH341=y
CONFIG_USB_SERIAL_WHITEHEAT=y
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=y
# CONFIG_USB_SERIAL_CP210X is not set
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=y
CONFIG_USB_SERIAL_FTDI_SIO=y
CONFIG_USB_SERIAL_VISOR=y
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
CONFIG_USB_SERIAL_F8153X=m
CONFIG_USB_SERIAL_GARMIN=y
# CONFIG_USB_SERIAL_IPW is not set
CONFIG_USB_SERIAL_IUU=m
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
CONFIG_USB_SERIAL_KEYSPAN=y
CONFIG_USB_SERIAL_KLSI=y
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
CONFIG_USB_SERIAL_MCT_U232=y
CONFIG_USB_SERIAL_METRO=m
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
CONFIG_USB_SERIAL_MXUPORT=m
CONFIG_USB_SERIAL_NAVMAN=y
CONFIG_USB_SERIAL_PL2303=y
CONFIG_USB_SERIAL_OTI6858=y
CONFIG_USB_SERIAL_QCAUX=m
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
CONFIG_USB_SERIAL_TI=y
CONFIG_USB_SERIAL_CYBERJACK=y
CONFIG_USB_SERIAL_WWAN=y
CONFIG_USB_SERIAL_OPTION=y
# CONFIG_USB_SERIAL_OMNINET is not set
CONFIG_USB_SERIAL_OPTICON=y
CONFIG_USB_SERIAL_XSENS_MT=y
CONFIG_USB_SERIAL_WISHBONE=y
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
CONFIG_USB_SERIAL_UPD78F0730=m
# CONFIG_USB_SERIAL_XR is not set
# CONFIG_USB_SERIAL_DEBUG is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
CONFIG_USB_EMI26=y
CONFIG_USB_ADUTUX=m
# CONFIG_USB_SEVSEG is not set
CONFIG_USB_LEGOTOWER=y
# CONFIG_USB_LCD is not set
CONFIG_USB_CYPRESS_CY7C63=y
CONFIG_USB_CYTHERM=m
# CONFIG_USB_IDMOUSE is not set
CONFIG_USB_FTDI_ELAN=y
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_QCOM_EUD is not set
CONFIG_APPLE_MFI_FASTCHARGE=m
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_LD=m
CONFIG_USB_TRANCEVIBRATOR=y
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
CONFIG_USB_EHSET_TEST_FIXTURE=y
CONFIG_USB_ISIGHTFW=m
CONFIG_USB_YUREX=m
CONFIG_USB_EZUSB_FX2=y
CONFIG_USB_HUB_USB251XB=y
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
CONFIG_USB_LINK_LAYER_TEST=m
CONFIG_BRCM_USB_PINMAP=y

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_ISP1301_OMAP=y
CONFIG_KEYSTONE_USB_PHY=m
CONFIG_NOP_USB_XCEIV=m
# CONFIG_AM335X_PHY_USB is not set
CONFIG_USB_GPIO_VBUS=y
CONFIG_TAHVO_USB=y
# CONFIG_TAHVO_USB_HOST_BY_DEFAULT is not set
# CONFIG_USB_ISP1301 is not set
CONFIG_USB_TEGRA_PHY=m
CONFIG_USB_ULPI=y
CONFIG_USB_ULPI_VIEWPORT=y
CONFIG_JZ4770_PHY=y
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
CONFIG_TYPEC_TCPM=m
CONFIG_TYPEC_TCPCI=m
# CONFIG_TYPEC_RT1711H is not set
CONFIG_TYPEC_MT6360=m
CONFIG_TYPEC_TCPCI_MAXIM=m
# CONFIG_TYPEC_FUSB302 is not set
CONFIG_TYPEC_TPS6598X=m
CONFIG_TYPEC_RT1719=m
# CONFIG_TYPEC_HD3SS3220 is not set
CONFIG_TYPEC_STUSB160X=m
CONFIG_TYPEC_QCOM_PMIC=m
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_FSA4480=y
CONFIG_TYPEC_MUX_PI3USB30532=m
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
CONFIG_TYPEC_DP_ALTMODE=m
CONFIG_TYPEC_NVIDIA_ALTMODE=m
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=m
CONFIG_MMC=y
CONFIG_PWRSEQ_EMMC=y
CONFIG_PWRSEQ_SIMPLE=m
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set
CONFIG_MMC_CRYPTO=y

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
# CONFIG_MMC_ARMMMCI is not set
# CONFIG_MMC_SDHCI is not set
CONFIG_MMC_MESON_GX=m
# CONFIG_MMC_MESON_MX_SDHC is not set
CONFIG_MMC_MESON_MX_SDIO=m
CONFIG_MMC_MOXART=y
CONFIG_MMC_OMAP_HS=m
CONFIG_MMC_ALCOR=m
CONFIG_MMC_TIFM_SD=y
CONFIG_MMC_MVSDIO=m
# CONFIG_MMC_DAVINCI is not set
CONFIG_MMC_S3C=m
# CONFIG_MMC_S3C_HW_SDIO_IRQ is not set
CONFIG_MMC_S3C_PIO=y
# CONFIG_MMC_S3C_DMA is not set
CONFIG_MMC_TMIO_CORE=y
# CONFIG_MMC_TMIO is not set
CONFIG_MMC_SDHI=y
# CONFIG_MMC_SDHI_SYS_DMAC is not set
# CONFIG_MMC_SDHI_INTERNAL_DMAC is not set
CONFIG_MMC_UNIPHIER=m
CONFIG_MMC_CB710=m
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_DW=m
CONFIG_MMC_DW_PLTFM=m
CONFIG_MMC_DW_BLUEFIELD=m
# CONFIG_MMC_DW_EXYNOS is not set
# CONFIG_MMC_DW_HI3798CV200 is not set
# CONFIG_MMC_DW_K3 is not set
# CONFIG_MMC_DW_PCI is not set
CONFIG_MMC_SH_MMCIF=m
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
CONFIG_MMC_USDHI6ROL0=y
# CONFIG_MMC_REALTEK_PCI is not set
# CONFIG_MMC_REALTEK_USB is not set
CONFIG_MMC_SUNXI=m
CONFIG_MMC_CQHCI=y
CONFIG_MMC_HSQ=y
CONFIG_MMC_TOSHIBA_PCI=m
CONFIG_MMC_BCM2835=y
# CONFIG_MMC_MTK is not set
CONFIG_MMC_OWL=m
CONFIG_MMC_LITEX=y
CONFIG_SCSI_UFSHCD=y
CONFIG_SCSI_UFS_BSG=y
CONFIG_SCSI_UFS_CRYPTO=y
# CONFIG_SCSI_UFS_HPB is not set
CONFIG_SCSI_UFS_FAULT_INJECTION=y
CONFIG_SCSI_UFS_HWMON=y
CONFIG_SCSI_UFSHCD_PCI=y
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
CONFIG_SCSI_UFSHCD_PLATFORM=m
# CONFIG_SCSI_UFS_CDNS_PLATFORM is not set
CONFIG_SCSI_UFS_DWC_TC_PLATFORM=m
CONFIG_SCSI_UFS_HISI=m
CONFIG_SCSI_UFS_TI_J721E=y
CONFIG_SCSI_UFS_EXYNOS=m
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=m
CONFIG_LEDS_CLASS_MULTICOLOR=m
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_AN30259A is not set
CONFIG_LEDS_ARIEL=y
CONFIG_LEDS_AW2013=y
CONFIG_LEDS_BCM6328=m
CONFIG_LEDS_BCM6358=m
CONFIG_LEDS_TURRIS_OMNIA=m
# CONFIG_LEDS_LM3530 is not set
CONFIG_LEDS_LM3532=y
# CONFIG_LEDS_LM3533 is not set
CONFIG_LEDS_LM3642=y
# CONFIG_LEDS_LM3692X is not set
CONFIG_LEDS_MT6323=m
CONFIG_LEDS_S3C24XX=y
CONFIG_LEDS_COBALT_QUBE=y
CONFIG_LEDS_COBALT_RAQ=y
CONFIG_LEDS_PCA9532=y
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=y
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
# CONFIG_LEDS_LP5523 is not set
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_LP8788=m
CONFIG_LEDS_LP8860=m
CONFIG_LEDS_PCA955X=m
# CONFIG_LEDS_PCA955X_GPIO is not set
CONFIG_LEDS_PCA963X=m
# CONFIG_LEDS_WM831X_STATUS is not set
# CONFIG_LEDS_WM8350 is not set
# CONFIG_LEDS_DA903X is not set
CONFIG_LEDS_DA9052=m
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_REGULATOR is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_LT3593=m
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_NS2=y
CONFIG_LEDS_NETXBIG=m
CONFIG_LEDS_TCA6507=y
# CONFIG_LEDS_TLC591XX is not set
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_OT200=y
CONFIG_LEDS_MENF21BMC=m
CONFIG_LEDS_IS31FL319X=m
CONFIG_LEDS_IS31FL32XX=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_PM8058=m
CONFIG_LEDS_MLXREG=m
CONFIG_LEDS_USER=m
CONFIG_LEDS_TI_LMU_COMMON=y
CONFIG_LEDS_LM3697=m
CONFIG_LEDS_LM36274=m
# CONFIG_LEDS_TPS6105X is not set
CONFIG_LEDS_IP30=y
# CONFIG_LEDS_ACER_A500 is not set
CONFIG_LEDS_LGM=m

#
# Flash and Torch LED drivers
#
CONFIG_LEDS_AAT1290=m
CONFIG_LEDS_AS3645A=m
CONFIG_LEDS_KTD2692=m
CONFIG_LEDS_LM3601X=m
CONFIG_LEDS_MT6360=m
# CONFIG_LEDS_RT4505 is not set
CONFIG_LEDS_RT8515=m
CONFIG_LEDS_SGM3140=m

#
# RGB LED drivers
#
CONFIG_LEDS_PWM_MULTICOLOR=m

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_DISK=y
# CONFIG_LEDS_TRIGGER_MTD is not set
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_ACTIVITY=m
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
# CONFIG_LEDS_TRIGGER_CAMERA is not set
CONFIG_LEDS_TRIGGER_PANIC=y
CONFIG_LEDS_TRIGGER_NETDEV=y
CONFIG_LEDS_TRIGGER_PATTERN=m
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
CONFIG_ACCESSIBILITY=y
CONFIG_A11Y_BRAILLE_CONSOLE=y

#
# Speakup console speech
#
CONFIG_SPEAKUP=y
CONFIG_SPEAKUP_SERIALIO=y
# CONFIG_SPEAKUP_SYNTH_ACNTSA is not set
CONFIG_SPEAKUP_SYNTH_ACNTPC=m
CONFIG_SPEAKUP_SYNTH_APOLLO=m
CONFIG_SPEAKUP_SYNTH_AUDPTR=m
# CONFIG_SPEAKUP_SYNTH_BNS is not set
CONFIG_SPEAKUP_SYNTH_DECTLK=y
CONFIG_SPEAKUP_SYNTH_DECEXT=m
# CONFIG_SPEAKUP_SYNTH_DECPC is not set
# CONFIG_SPEAKUP_SYNTH_DTLK is not set
# CONFIG_SPEAKUP_SYNTH_KEYPC is not set
CONFIG_SPEAKUP_SYNTH_LTLK=m
# CONFIG_SPEAKUP_SYNTH_SOFT is not set
CONFIG_SPEAKUP_SYNTH_SPKOUT=y
CONFIG_SPEAKUP_SYNTH_TXPRT=y
CONFIG_SPEAKUP_SYNTH_DUMMY=y
# end of Speakup console speech

CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=m
# CONFIG_EDAC_LEGACY_SYSFS is not set
CONFIG_EDAC_DEBUG=y
CONFIG_EDAC_AL_MC=m
# CONFIG_EDAC_XGENE is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
# CONFIG_RTC_SYSTOHC is not set
CONFIG_RTC_DEBUG=y
CONFIG_RTC_LIB_KUNIT_TEST=m
# CONFIG_RTC_NVMEM is not set

#
# RTC interfaces
#
# CONFIG_RTC_INTF_SYSFS is not set
# CONFIG_RTC_INTF_PROC is not set
# CONFIG_RTC_INTF_DEV is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM80X=m
CONFIG_RTC_DRV_ABB5ZES3=y
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
# CONFIG_RTC_DRV_BRCMSTB is not set
# CONFIG_RTC_DRV_AS3722 is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=y
# CONFIG_RTC_DRV_DS1672 is not set
CONFIG_RTC_DRV_HYM8563=m
CONFIG_RTC_DRV_LP8788=m
CONFIG_RTC_DRV_MAX6900=y
# CONFIG_RTC_DRV_MAX8907 is not set
CONFIG_RTC_DRV_MAX8925=y
CONFIG_RTC_DRV_MAX8998=m
# CONFIG_RTC_DRV_MAX77686 is not set
CONFIG_RTC_DRV_RK808=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
# CONFIG_RTC_DRV_ISL12022 is not set
CONFIG_RTC_DRV_ISL12026=y
CONFIG_RTC_DRV_X1205=y
CONFIG_RTC_DRV_PCF8523=y
CONFIG_RTC_DRV_PCF85063=m
CONFIG_RTC_DRV_PCF85363=m
# CONFIG_RTC_DRV_PCF8563 is not set
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=y
# CONFIG_RTC_DRV_M41T80_WDT is not set
CONFIG_RTC_DRV_BD70528=m
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_TPS65910 is not set
CONFIG_RTC_DRV_RC5T619=m
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
CONFIG_RTC_DRV_RX8010=y
# CONFIG_RTC_DRV_RX8581 is not set
CONFIG_RTC_DRV_RX8025=y
CONFIG_RTC_DRV_EM3027=y
CONFIG_RTC_DRV_RV3028=y
CONFIG_RTC_DRV_RV3032=y
CONFIG_RTC_DRV_RV8803=y
CONFIG_RTC_DRV_S5M=m
CONFIG_RTC_DRV_SD3078=m

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
CONFIG_RTC_DRV_PCF2127=y
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
CONFIG_RTC_DRV_RX6110=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=y
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=y
CONFIG_RTC_DRV_DS2404=y
CONFIG_RTC_DRV_DA9052=y
# CONFIG_RTC_DRV_DA9063 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
CONFIG_RTC_DRV_M48T86=y
CONFIG_RTC_DRV_M48T35=y
CONFIG_RTC_DRV_M48T59=y
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=y
CONFIG_RTC_DRV_RP5C01=m
# CONFIG_RTC_DRV_V3020 is not set
CONFIG_RTC_DRV_GAMECUBE=y
CONFIG_RTC_DRV_WM831X=y
CONFIG_RTC_DRV_WM8350=m
# CONFIG_RTC_DRV_SC27XX is not set
# CONFIG_RTC_DRV_SPEAR is not set
CONFIG_RTC_DRV_ZYNQMP=m
# CONFIG_RTC_DRV_CROS_EC is not set
CONFIG_RTC_DRV_NTXEC=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_ASM9260 is not set
CONFIG_RTC_DRV_DAVINCI=m
# CONFIG_RTC_DRV_DIGICOLOR is not set
CONFIG_RTC_DRV_FSL_FTM_ALARM=m
CONFIG_RTC_DRV_MESON=y
CONFIG_RTC_DRV_MESON_VRTC=m
# CONFIG_RTC_DRV_OMAP is not set
CONFIG_RTC_DRV_S3C=m
CONFIG_RTC_DRV_EP93XX=y
# CONFIG_RTC_DRV_VR41XX is not set
CONFIG_RTC_DRV_PL030=y
CONFIG_RTC_DRV_PL031=y
# CONFIG_RTC_DRV_AT91RM9200 is not set
# CONFIG_RTC_DRV_AT91SAM9 is not set
# CONFIG_RTC_DRV_RZN1 is not set
CONFIG_RTC_DRV_GENERIC=y
CONFIG_RTC_DRV_VT8500=m
CONFIG_RTC_DRV_SUN6I=y
CONFIG_RTC_DRV_SUNXI=y
# CONFIG_RTC_DRV_MV is not set
# CONFIG_RTC_DRV_ARMADA38X is not set
# CONFIG_RTC_DRV_CADENCE is not set
CONFIG_RTC_DRV_FTRTC010=y
CONFIG_RTC_DRV_STMP=y
# CONFIG_RTC_DRV_MC13XXX is not set
# CONFIG_RTC_DRV_JZ4740 is not set
CONFIG_RTC_DRV_LPC24XX=y
CONFIG_RTC_DRV_LPC32XX=y
# CONFIG_RTC_DRV_PM8XXX is not set
CONFIG_RTC_DRV_TEGRA=m
CONFIG_RTC_DRV_MXC=y
# CONFIG_RTC_DRV_MXC_V2 is not set
# CONFIG_RTC_DRV_SNVS is not set
CONFIG_RTC_DRV_MOXART=y
CONFIG_RTC_DRV_MT2712=y
# CONFIG_RTC_DRV_MT6397 is not set
CONFIG_RTC_DRV_MT7622=y
CONFIG_RTC_DRV_XGENE=y
CONFIG_RTC_DRV_R7301=m
CONFIG_RTC_DRV_STM32=m
CONFIG_RTC_DRV_RTD119X=y
CONFIG_RTC_DRV_ASPEED=m

#
# HID Sensor RTC drivers
#
CONFIG_RTC_DRV_GOLDFISH=m
CONFIG_RTC_DRV_MSC313=m
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
CONFIG_DMABUF_MOVE_NOTIFY=y
CONFIG_DMABUF_DEBUG=y
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
CONFIG_DMABUF_SYSFS_STATS=y
# CONFIG_DMABUF_HEAPS_SYSTEM is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_LINEDISP=y
CONFIG_HD44780_COMMON=y
# CONFIG_HD44780 is not set
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_IMG_ASCII_LCD=y
CONFIG_LCD2S=m
CONFIG_PARPORT_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
# CONFIG_PANEL_CHANGE_MESSAGE is not set
# CONFIG_CHARLCD_BL_OFF is not set
CONFIG_CHARLCD_BL_ON=y
# CONFIG_CHARLCD_BL_FLASH is not set
CONFIG_PANEL=y
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=y
CONFIG_UIO_DMEM_GENIRQ=m
# CONFIG_UIO_AEC is not set
CONFIG_UIO_SERCOS3=m
# CONFIG_UIO_PCI_GENERIC is not set
CONFIG_UIO_NETX=m
CONFIG_UIO_PRUSS=m
CONFIG_UIO_MF624=y
CONFIG_VFIO=y
CONFIG_VFIO_IOMMU_TYPE1=y
CONFIG_VFIO_VIRQFD=y
# CONFIG_VFIO_NOIOMMU is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI is not set
CONFIG_VFIO_PLATFORM=y
# CONFIG_VFIO_AMBA is not set
CONFIG_VFIO_PLATFORM_CALXEDAXGMAC_RESET=y
CONFIG_VFIO_PLATFORM_AMDXGBE_RESET=m
# CONFIG_VFIO_PLATFORM_BCMFLEXRM_RESET is not set
# CONFIG_VFIO_MDEV is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
CONFIG_VIRTIO_BALLOON=y
# CONFIG_VIRTIO_INPUT is not set
CONFIG_VIRTIO_MMIO=m
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
CONFIG_VIRTIO_DMA_SHARED_BUFFER=y
# CONFIG_VDPA is not set
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
CONFIG_GREYBUS_ES2=m
# CONFIG_COMEDI is not set
CONFIG_STAGING=y
# CONFIG_RTS5208 is not set
CONFIG_OCTEON_ETHERNET=m
CONFIG_STAGING_MEDIA=y
# CONFIG_VIDEO_HANTRO is not set
# CONFIG_VIDEO_IMX_MEDIA is not set
CONFIG_VIDEO_MAX96712=m
# CONFIG_VIDEO_MESON_VDEC is not set
# CONFIG_VIDEO_OMAP4 is not set
CONFIG_VIDEO_ROCKCHIP_VDEC=m
# CONFIG_VIDEO_SUNXI is not set
# CONFIG_VIDEO_ZORAN is not set
CONFIG_VIDEO_TEGRA=m
# CONFIG_VIDEO_TEGRA_TPG is not set
# CONFIG_DVB_AV7110 is not set
CONFIG_STAGING_BOARD=y
CONFIG_LTE_GDM724X=m
CONFIG_COMMON_CLK_XLNX_CLKWZRD=y
CONFIG_MOST_COMPONENTS=m
CONFIG_MOST_NET=m
CONFIG_MOST_VIDEO=m
CONFIG_MOST_DIM2=m
CONFIG_MOST_I2C=m
CONFIG_GREYBUS_AUDIO=m
CONFIG_GREYBUS_AUDIO_APB_CODEC=m
CONFIG_GREYBUS_BOOTROM=y
# CONFIG_GREYBUS_HID is not set
CONFIG_GREYBUS_LIGHT=y
# CONFIG_GREYBUS_LOG is not set
CONFIG_GREYBUS_LOOPBACK=y
CONFIG_GREYBUS_POWER=m
CONFIG_GREYBUS_RAW=m
CONFIG_GREYBUS_VIBRATOR=y
# CONFIG_GREYBUS_BRIDGED_PHY is not set
CONFIG_GREYBUS_ARCHE=m
CONFIG_BCM_VIDEOCORE=y
CONFIG_BCM2835_VCHIQ=m
# CONFIG_VCHIQ_CDEV is not set
CONFIG_SND_BCM2835=m
# CONFIG_VIDEO_BCM2835 is not set
# CONFIG_BCM2835_VCHIQ_MMAL is not set
CONFIG_XIL_AXIS_FIFO=m
# CONFIG_FIELDBUS_DEV is not set
CONFIG_QLGE=m

#
# VME Device Drivers
#
# CONFIG_GOLDFISH is not set
CONFIG_CHROME_PLATFORMS=y
CONFIG_CROS_EC=y
CONFIG_CROS_EC_I2C=m
CONFIG_CROS_EC_RPMSG=m
CONFIG_CROS_EC_PROTO=y
CONFIG_CROS_EC_CHARDEV=m
CONFIG_CROS_EC_LIGHTBAR=m
CONFIG_CROS_EC_VBC=m
CONFIG_CROS_EC_DEBUGFS=m
# CONFIG_CROS_EC_SENSORHUB is not set
CONFIG_CROS_EC_SYSFS=m
CONFIG_CROS_EC_TYPEC=m
# CONFIG_CROS_USBPD_LOGGER is not set
CONFIG_CROS_USBPD_NOTIFY=m
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_OLPC_XO175=y
# CONFIG_SURFACE_PLATFORMS is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_WM831X=y

#
# Clock driver for ARM Reference designs
#
CONFIG_CLK_ICST=y
# CONFIG_CLK_SP810 is not set
CONFIG_CLK_VEXPRESS_OSC=m
# end of Clock driver for ARM Reference designs

CONFIG_CLK_HSDK=y
# CONFIG_COMMON_CLK_APPLE_NCO is not set
CONFIG_COMMON_CLK_MAX77686=y
CONFIG_COMMON_CLK_MAX9485=m
# CONFIG_COMMON_CLK_RK808 is not set
CONFIG_COMMON_CLK_HI655X=m
# CONFIG_COMMON_CLK_SCMI is not set
CONFIG_COMMON_CLK_SCPI=m
CONFIG_COMMON_CLK_SI5341=m
# CONFIG_COMMON_CLK_SI5351 is not set
CONFIG_COMMON_CLK_SI514=y
CONFIG_COMMON_CLK_SI544=y
# CONFIG_COMMON_CLK_SI570 is not set
CONFIG_COMMON_CLK_BM1880=y
CONFIG_COMMON_CLK_CDCE706=y
CONFIG_COMMON_CLK_TPS68470=y
# CONFIG_COMMON_CLK_CDCE925 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_EN7523 is not set
# CONFIG_COMMON_CLK_FSL_FLEXSPI is not set
# CONFIG_COMMON_CLK_FSL_SAI is not set
# CONFIG_COMMON_CLK_GEMINI is not set
CONFIG_COMMON_CLK_LAN966X=y
CONFIG_COMMON_CLK_ASPEED=y
CONFIG_COMMON_CLK_S2MPS11=m
# CONFIG_COMMON_CLK_AXI_CLKGEN is not set
CONFIG_CLK_QORIQ=y
CONFIG_CLK_LS1028A_PLLDIG=m
CONFIG_COMMON_CLK_XGENE=y
CONFIG_COMMON_CLK_PWM=m
# CONFIG_COMMON_CLK_OXNAS is not set
CONFIG_COMMON_CLK_RS9_PCIE=y
CONFIG_COMMON_CLK_VC5=y
CONFIG_COMMON_CLK_MMP2_AUDIO=m
# CONFIG_COMMON_CLK_BD718XX is not set
CONFIG_COMMON_CLK_FIXED_MMIO=y
CONFIG_CLK_ACTIONS=y
CONFIG_CLK_OWL_S500=y
# CONFIG_CLK_OWL_S700 is not set
CONFIG_CLK_OWL_S900=y
# CONFIG_CLK_BAIKAL_T1 is not set
CONFIG_CLK_BCM2711_DVP=m
# CONFIG_CLK_BCM2835 is not set
CONFIG_CLK_BCM_63XX=y
CONFIG_CLK_BCM_63XX_GATE=y
CONFIG_CLK_BCM_KONA=y
CONFIG_COMMON_CLK_IPROC=y
CONFIG_CLK_BCM_CYGNUS=y
CONFIG_CLK_BCM_HR2=y
CONFIG_CLK_BCM_NSP=y
# CONFIG_CLK_BCM_NS2 is not set
CONFIG_CLK_BCM_SR=y
CONFIG_CLK_RASPBERRYPI=y
CONFIG_COMMON_CLK_HI3516CV300=y
CONFIG_COMMON_CLK_HI3519=m
CONFIG_COMMON_CLK_HI3559A=y
CONFIG_COMMON_CLK_HI3660=y
CONFIG_COMMON_CLK_HI3670=y
CONFIG_COMMON_CLK_HI3798CV200=y
CONFIG_COMMON_CLK_HI6220=y
CONFIG_RESET_HISI=y
CONFIG_COMMON_CLK_BOSTON=y
CONFIG_MXC_CLK=y
CONFIG_CLK_IMX8MM=y
CONFIG_CLK_IMX8MN=m
# CONFIG_CLK_IMX8MP is not set
CONFIG_CLK_IMX8MQ=y
CONFIG_CLK_IMX8ULP=y
CONFIG_CLK_IMX93=m

#
# Ingenic SoCs drivers
#
CONFIG_INGENIC_CGU_COMMON=y
# CONFIG_INGENIC_CGU_JZ4740 is not set
CONFIG_INGENIC_CGU_JZ4725B=y
CONFIG_INGENIC_CGU_JZ4760=y
CONFIG_INGENIC_CGU_JZ4770=y
CONFIG_INGENIC_CGU_JZ4780=y
# CONFIG_INGENIC_CGU_X1000 is not set
CONFIG_INGENIC_CGU_X1830=y
CONFIG_INGENIC_TCU_CLK=y
# end of Ingenic SoCs drivers

CONFIG_COMMON_CLK_KEYSTONE=y
CONFIG_TI_SYSCON_CLK=y

#
# Clock driver for MediaTek SoC
#
CONFIG_COMMON_CLK_MEDIATEK=y
# CONFIG_COMMON_CLK_MT2701 is not set
CONFIG_COMMON_CLK_MT2712=y
CONFIG_COMMON_CLK_MT2712_BDPSYS=y
CONFIG_COMMON_CLK_MT2712_IMGSYS=y
# CONFIG_COMMON_CLK_MT2712_JPGDECSYS is not set
CONFIG_COMMON_CLK_MT2712_MFGCFG=y
CONFIG_COMMON_CLK_MT2712_MMSYS=y
CONFIG_COMMON_CLK_MT2712_VDECSYS=y
# CONFIG_COMMON_CLK_MT2712_VENCSYS is not set
# CONFIG_COMMON_CLK_MT6765 is not set
# CONFIG_COMMON_CLK_MT6779 is not set
# CONFIG_COMMON_CLK_MT6797 is not set
# CONFIG_COMMON_CLK_MT7622 is not set
CONFIG_COMMON_CLK_MT7629=y
# CONFIG_COMMON_CLK_MT7629_ETHSYS is not set
# CONFIG_COMMON_CLK_MT7629_HIFSYS is not set
CONFIG_COMMON_CLK_MT7986=y
CONFIG_COMMON_CLK_MT7986_ETHSYS=y
# CONFIG_COMMON_CLK_MT8135 is not set
CONFIG_COMMON_CLK_MT8167=y
# CONFIG_COMMON_CLK_MT8167_AUDSYS is not set
CONFIG_COMMON_CLK_MT8167_IMGSYS=y
# CONFIG_COMMON_CLK_MT8167_MFGCFG is not set
# CONFIG_COMMON_CLK_MT8167_MMSYS is not set
# CONFIG_COMMON_CLK_MT8167_VDECSYS is not set
CONFIG_COMMON_CLK_MT8173=y
# CONFIG_COMMON_CLK_MT8173_MMSYS is not set
CONFIG_COMMON_CLK_MT8183=y
# CONFIG_COMMON_CLK_MT8183_AUDIOSYS is not set
CONFIG_COMMON_CLK_MT8183_CAMSYS=y
CONFIG_COMMON_CLK_MT8183_IMGSYS=y
CONFIG_COMMON_CLK_MT8183_IPU_CORE0=y
# CONFIG_COMMON_CLK_MT8183_IPU_CORE1 is not set
CONFIG_COMMON_CLK_MT8183_IPU_ADL=y
# CONFIG_COMMON_CLK_MT8183_IPU_CONN is not set
CONFIG_COMMON_CLK_MT8183_MFGCFG=y
CONFIG_COMMON_CLK_MT8183_MMSYS=y
# CONFIG_COMMON_CLK_MT8183_VDECSYS is not set
# CONFIG_COMMON_CLK_MT8183_VENCSYS is not set
# CONFIG_COMMON_CLK_MT8186 is not set
# CONFIG_COMMON_CLK_MT8192 is not set
CONFIG_COMMON_CLK_MT8195=y
CONFIG_COMMON_CLK_MT8516=y
# CONFIG_COMMON_CLK_MT8516_AUDSYS is not set
# end of Clock driver for MediaTek SoC

#
# Clock support for Amlogic platforms
#
# CONFIG_COMMON_CLK_MESON8B is not set
# CONFIG_COMMON_CLK_AXG_AUDIO is not set
# end of Clock support for Amlogic platforms

CONFIG_MSTAR_MSC313_MPLL=y
CONFIG_MCHP_CLK_MPFS=y
CONFIG_COMMON_CLK_PISTACHIO=y
CONFIG_KRAIT_CLOCKS=y
CONFIG_QCOM_GDSC=y
CONFIG_COMMON_CLK_QCOM=y
# CONFIG_QCOM_A53PLL is not set
# CONFIG_QCOM_A7PLL is not set
# CONFIG_QCOM_CLK_APCS_MSM8916 is not set
CONFIG_QCOM_CLK_APCS_SDX55=y
# CONFIG_APQ_GCC_8084 is not set
# CONFIG_APQ_MMCC_8084 is not set
CONFIG_IPQ_APSS_PLL=y
CONFIG_IPQ_APSS_6018=y
# CONFIG_IPQ_GCC_4019 is not set
# CONFIG_IPQ_GCC_6018 is not set
CONFIG_IPQ_GCC_806X=m
CONFIG_IPQ_LCC_806X=m
# CONFIG_IPQ_GCC_8074 is not set
# CONFIG_MSM_GCC_8660 is not set
CONFIG_MSM_GCC_8916=m
# CONFIG_MSM_GCC_8939 is not set
CONFIG_MSM_GCC_8960=m
CONFIG_MSM_LCC_8960=m
# CONFIG_MDM_GCC_9607 is not set
CONFIG_MDM_GCC_9615=m
# CONFIG_MDM_LCC_9615 is not set
CONFIG_MSM_MMCC_8960=m
CONFIG_MSM_GCC_8953=m
CONFIG_MSM_GCC_8974=y
CONFIG_MSM_MMCC_8974=y
CONFIG_MSM_GCC_8976=y
CONFIG_MSM_MMCC_8994=y
CONFIG_MSM_GCC_8994=y
CONFIG_MSM_GCC_8996=m
CONFIG_MSM_MMCC_8996=m
CONFIG_MSM_GCC_8998=y
# CONFIG_MSM_GPUCC_8998 is not set
CONFIG_MSM_MMCC_8998=m
CONFIG_QCM_GCC_2290=y
CONFIG_QCM_DISPCC_2290=y
CONFIG_QCS_GCC_404=m
# CONFIG_SC_CAMCC_7180 is not set
CONFIG_SC_CAMCC_7280=y
CONFIG_SC_DISPCC_7180=m
CONFIG_SC_DISPCC_7280=y
CONFIG_SC_GCC_7180=y
CONFIG_SC_GCC_7280=y
CONFIG_SC_GCC_8180X=m
CONFIG_SC_GCC_8280XP=y
CONFIG_SC_GPUCC_7180=y
CONFIG_SC_GPUCC_7280=m
CONFIG_SC_LPASSCC_7280=y
CONFIG_SC_LPASS_CORECC_7180=m
CONFIG_SC_LPASS_CORECC_7280=y
CONFIG_SC_MSS_7180=y
CONFIG_SC_VIDEOCC_7180=y
# CONFIG_SC_VIDEOCC_7280 is not set
CONFIG_SDM_CAMCC_845=m
CONFIG_SDM_GCC_660=y
# CONFIG_SDM_MMCC_660 is not set
CONFIG_SDM_GPUCC_660=y
# CONFIG_QCS_TURING_404 is not set
CONFIG_QCS_Q6SSTOP_404=m
CONFIG_SDM_GCC_845=y
CONFIG_SDM_GPUCC_845=m
CONFIG_SDM_VIDEOCC_845=m
CONFIG_SDM_DISPCC_845=m
# CONFIG_SDM_LPASSCC_845 is not set
CONFIG_SDX_GCC_55=m
CONFIG_SDX_GCC_65=y
# CONFIG_SM_CAMCC_8250 is not set
# CONFIG_SM_DISPCC_6125 is not set
CONFIG_SM_DISPCC_8250=m
# CONFIG_SM_DISPCC_6350 is not set
# CONFIG_SM_GCC_6115 is not set
CONFIG_SM_GCC_6125=y
CONFIG_SM_GCC_6350=y
CONFIG_SM_GCC_8150=y
CONFIG_SM_GCC_8250=y
CONFIG_SM_GCC_8350=m
CONFIG_SM_GCC_8450=m
CONFIG_SM_GPUCC_6350=y
CONFIG_SM_GPUCC_8150=m
# CONFIG_SM_GPUCC_8250 is not set
CONFIG_SM_VIDEOCC_8150=y
CONFIG_SM_VIDEOCC_8250=y
# CONFIG_SPMI_PMIC_CLKDIV is not set
# CONFIG_QCOM_HFPLL is not set
CONFIG_KPSS_XCC=m
CONFIG_KRAITCC=m
CONFIG_CLK_GFM_LPASS_SM8250=y
# CONFIG_CLK_MT7621 is not set
CONFIG_CLK_RENESAS=y
# CONFIG_CLK_EMEV2 is not set
CONFIG_CLK_RZA1=y
CONFIG_CLK_R7S9210=y
CONFIG_CLK_R8A73A4=y
# CONFIG_CLK_R8A7740 is not set
CONFIG_CLK_R8A7742=y
CONFIG_CLK_R8A7743=y
# CONFIG_CLK_R8A7745 is not set
# CONFIG_CLK_R8A77470 is not set
CONFIG_CLK_R8A774A1=y
# CONFIG_CLK_R8A774B1 is not set
CONFIG_CLK_R8A774C0=y
# CONFIG_CLK_R8A774E1 is not set
# CONFIG_CLK_R8A7778 is not set
# CONFIG_CLK_R8A7779 is not set
CONFIG_CLK_R8A7790=y
CONFIG_CLK_R8A7791=y
# CONFIG_CLK_R8A7792 is not set
# CONFIG_CLK_R8A7794 is not set
# CONFIG_CLK_R8A7795 is not set
# CONFIG_CLK_R8A77960 is not set
CONFIG_CLK_R8A77961=y
# CONFIG_CLK_R8A77965 is not set
# CONFIG_CLK_R8A77970 is not set
# CONFIG_CLK_R8A77980 is not set
# CONFIG_CLK_R8A77990 is not set
# CONFIG_CLK_R8A77995 is not set
CONFIG_CLK_R8A779A0=y
# CONFIG_CLK_R8A779F0 is not set
CONFIG_CLK_R8A779G0=y
CONFIG_CLK_R9A06G032=y
# CONFIG_CLK_R9A07G043 is not set
# CONFIG_CLK_R9A07G044 is not set
# CONFIG_CLK_R9A07G054 is not set
# CONFIG_CLK_R9A09G011 is not set
CONFIG_CLK_SH73A0=y
CONFIG_CLK_RCAR_CPG_LIB=y
CONFIG_CLK_RCAR_GEN2_CPG=y
CONFIG_CLK_RCAR_GEN3_CPG=y
CONFIG_CLK_RCAR_GEN4_CPG=y
CONFIG_CLK_RCAR_USB2_CLOCK_SEL=y
# CONFIG_CLK_RZG2L is not set
CONFIG_CLK_RENESAS_CPG_MSSR=y
CONFIG_CLK_RENESAS_CPG_MSTP=y
CONFIG_CLK_RENESAS_DIV6=y
# CONFIG_COMMON_CLK_SAMSUNG is not set
# CONFIG_S3C2410_COMMON_CLK is not set
# CONFIG_S3C2412_COMMON_CLK is not set
# CONFIG_S3C2443_COMMON_CLK is not set
# CONFIG_CLK_SIFIVE is not set
CONFIG_CLK_INTEL_SOCFPGA=y
CONFIG_CLK_INTEL_SOCFPGA32=y
CONFIG_CLK_INTEL_SOCFPGA64=y
CONFIG_SPRD_COMMON_CLK=m
CONFIG_SPRD_SC9860_CLK=m
# CONFIG_SPRD_SC9863A_CLK is not set
# CONFIG_CLK_STARFIVE_JH7100 is not set
# CONFIG_CLK_SUNXI is not set
CONFIG_SUNXI_CCU=m
CONFIG_SUNIV_F1C100S_CCU=m
CONFIG_SUN20I_D1_CCU=m
CONFIG_SUN20I_D1_R_CCU=m
# CONFIG_SUN50I_A64_CCU is not set
# CONFIG_SUN50I_A100_CCU is not set
# CONFIG_SUN50I_A100_R_CCU is not set
CONFIG_SUN50I_H6_CCU=m
CONFIG_SUN50I_H616_CCU=m
CONFIG_SUN50I_H6_R_CCU=m
CONFIG_SUN4I_A10_CCU=m
CONFIG_SUN6I_A31_CCU=m
CONFIG_SUN6I_RTC_CCU=m
CONFIG_SUN8I_A23_CCU=m
CONFIG_SUN8I_A33_CCU=m
CONFIG_SUN8I_A83T_CCU=m
# CONFIG_SUN8I_H3_CCU is not set
CONFIG_SUN8I_V3S_CCU=m
# CONFIG_SUN8I_DE2_CCU is not set
# CONFIG_SUN8I_R40_CCU is not set
CONFIG_SUN9I_A80_CCU=m
CONFIG_SUN8I_R_CCU=m
# CONFIG_COMMON_CLK_TI_ADPLL is not set
# CONFIG_CLK_UNIPHIER is not set
# CONFIG_COMMON_CLK_VISCONTI is not set
# CONFIG_CLK_LGM_CGU is not set
CONFIG_XILINX_VCU=m
CONFIG_COMMON_CLK_ZYNQMP=y
CONFIG_CLK_KUNIT_TEST=m
CONFIG_CLK_GATE_KUNIT_TEST=m
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKSRC_MMIO=y
CONFIG_BCM2835_TIMER=y
# CONFIG_BCM_KONA_TIMER is not set
# CONFIG_DAVINCI_TIMER is not set
CONFIG_DIGICOLOR_TIMER=y
CONFIG_DW_APB_TIMER=y
CONFIG_FTTMR010_TIMER=y
CONFIG_IXP4XX_TIMER=y
CONFIG_ROCKCHIP_TIMER=y
# CONFIG_ARMADA_370_XP_TIMER is not set
CONFIG_MESON6_TIMER=y
# CONFIG_ORION_TIMER is not set
CONFIG_OWL_TIMER=y
CONFIG_RDA_TIMER=y
CONFIG_SUN4I_TIMER=y
# CONFIG_SUN5I_HSTIMER is not set
CONFIG_TEGRA_TIMER=y
CONFIG_VT8500_TIMER=y
CONFIG_NPCM7XX_TIMER=y
# CONFIG_CADENCE_TTC_TIMER is not set
CONFIG_ASM9260_TIMER=y
# CONFIG_CLKSRC_NOMADIK_MTU is not set
# CONFIG_CLKSRC_DBX500_PRCMU is not set
CONFIG_CLPS711X_TIMER=y
# CONFIG_MXS_TIMER is not set
CONFIG_NSPIRE_TIMER=y
CONFIG_KEYSTONE_TIMER=y
# CONFIG_INTEGRATOR_AP_TIMER is not set
# CONFIG_CLKSRC_LPC32XX is not set
# CONFIG_CLKSRC_PISTACHIO is not set
CONFIG_CLKSRC_TI_32K=y
# CONFIG_CLKSRC_STM32 is not set
CONFIG_CLKSRC_STM32_LP=y
CONFIG_CLKSRC_MPS2=y
CONFIG_ARC_TIMERS=y
# CONFIG_ARC_TIMERS_64BIT is not set
# CONFIG_ARM_GLOBAL_TIMER is not set
# CONFIG_ARM_TIMER_SP804 is not set
CONFIG_ARMV7M_SYSTICK=y
# CONFIG_ATMEL_PIT is not set
CONFIG_ATMEL_ST=y
CONFIG_ATMEL_TCB_CLKSRC=y
CONFIG_CLKSRC_EXYNOS_MCT=y
CONFIG_CLKSRC_SAMSUNG_PWM=y
# CONFIG_FSL_FTM_TIMER is not set
# CONFIG_OXNAS_RPS_TIMER is not set
CONFIG_MTK_TIMER=y
CONFIG_CLKSRC_JCORE_PIT=y
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_RENESAS_OSTM is not set
CONFIG_SH_TIMER_TMU=y
CONFIG_EM_TIMER_STI=y
CONFIG_CLKSRC_QCOM=y
CONFIG_CLKSRC_VERSATILE=y
CONFIG_CLKSRC_PXA=y
# CONFIG_CLKSRC_IMX_GPT is not set
# CONFIG_CLKSRC_IMX_TPM is not set
# CONFIG_TIMER_IMX_SYS_CTR is not set
CONFIG_CLKSRC_ST_LPC=y
# CONFIG_GXP_TIMER is not set
# CONFIG_MILBEAUT_TIMER is not set
# CONFIG_MSC313E_TIMER is not set
CONFIG_INGENIC_TIMER=y
CONFIG_INGENIC_SYSOST=y
# CONFIG_INGENIC_OST is not set
# CONFIG_MICROCHIP_PIT64B is not set
# CONFIG_GOLDFISH_TIMER is not set
# end of Clock Source drivers

# CONFIG_MAILBOX is not set
CONFIG_IOMMU_IOVA=m
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IO_PGTABLE=y
CONFIG_IOMMU_IO_PGTABLE_LPAE=y
CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST=y
CONFIG_IOMMU_IO_PGTABLE_ARMV7S=y
CONFIG_IOMMU_IO_PGTABLE_ARMV7S_SELFTEST=y
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
# CONFIG_IOMMU_DEFAULT_DMA_LAZY is not set
CONFIG_IOMMU_DEFAULT_PASSTHROUGH=y
CONFIG_OF_IOMMU=y
CONFIG_MSM_IOMMU=y
CONFIG_OMAP_IOMMU=y
CONFIG_OMAP_IOMMU_DEBUG=y
# CONFIG_ROCKCHIP_IOMMU is not set
# CONFIG_SUN50I_IOMMU is not set
CONFIG_ARM_SMMU=m
CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT=y
CONFIG_S390_CCW_IOMMU=y
CONFIG_S390_AP_IOMMU=y
CONFIG_MTK_IOMMU=m
CONFIG_MTK_IOMMU_V1=m
CONFIG_SPRD_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=m
CONFIG_RPMSG_CHAR=m
CONFIG_RPMSG_CTRL=m
CONFIG_RPMSG_NS=m
CONFIG_RPMSG_VIRTIO=m
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=m

#
# SoundWire Devices
#
# CONFIG_SOUNDWIRE_QCOM is not set

#
# SOC (System On Chip) specific Drivers
#
# CONFIG_OWL_PM_DOMAINS is not set

#
# Amlogic SoC drivers
#
# CONFIG_MESON_CANVAS is not set
# CONFIG_MESON_CLK_MEASURE is not set
CONFIG_MESON_GX_SOCINFO=y
CONFIG_MESON_GX_PM_DOMAINS=m
CONFIG_MESON_EE_PM_DOMAINS=m
# CONFIG_MESON_MX_SOCINFO is not set
# end of Amlogic SoC drivers

#
# Apple SoC drivers
#
# CONFIG_APPLE_PMGR_PWRSTATE is not set
CONFIG_APPLE_SART=y
# end of Apple SoC drivers

#
# ASPEED SoC drivers
#
CONFIG_ASPEED_LPC_CTRL=y
# CONFIG_ASPEED_LPC_SNOOP is not set
CONFIG_ASPEED_UART_ROUTING=y
CONFIG_ASPEED_P2A_CTRL=m
CONFIG_ASPEED_SOCINFO=y
# end of ASPEED SoC drivers

CONFIG_AT91_SOC_ID=y
CONFIG_AT91_SOC_SFR=m

#
# Broadcom SoC drivers
#
CONFIG_BCM2835_POWER=y
# CONFIG_SOC_BCM63XX is not set
# CONFIG_SOC_BRCMSTB is not set
CONFIG_BCM_PMB=y
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# CONFIG_QUICC_ENGINE is not set
CONFIG_DPAA2_CONSOLE=y
# CONFIG_FSL_RCPM is not set
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# CONFIG_IMX_GPCV2_PM_DOMAINS is not set
CONFIG_SOC_IMX8M=y
# end of i.MX SoC drivers

#
# IXP4xx SoC drivers
#
# CONFIG_IXP4XX_QMGR is not set
CONFIG_IXP4XX_NPE=y
# end of IXP4xx SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
CONFIG_LITEX=y
CONFIG_LITEX_SOC_CONTROLLER=m
# end of Enable LiteX SoC Builder specific drivers

#
# MediaTek SoC drivers
#
# CONFIG_MTK_CMDQ is not set
CONFIG_MTK_DEVAPC=m
# CONFIG_MTK_INFRACFG is not set
CONFIG_MTK_PMIC_WRAP=y
# CONFIG_MTK_SCPSYS is not set
# CONFIG_MTK_SCPSYS_PM_DOMAINS is not set
# CONFIG_MTK_MMSYS is not set
# end of MediaTek SoC drivers

#
# Qualcomm SoC drivers
#
CONFIG_QCOM_COMMAND_DB=y
CONFIG_QCOM_GENI_SE=m
CONFIG_QCOM_GSBI=m
CONFIG_QCOM_LLCC=y
CONFIG_QCOM_PDR_HELPERS=m
CONFIG_QCOM_QMI_HELPERS=m
# CONFIG_QCOM_RPMH is not set
# CONFIG_QCOM_SMD_RPM is not set
CONFIG_QCOM_SPM=y
CONFIG_QCOM_WCNSS_CTRL=m
CONFIG_QCOM_APR=m
# end of Qualcomm SoC drivers

# CONFIG_SOC_RENESAS is not set
CONFIG_ROCKCHIP_GRF=y
CONFIG_ROCKCHIP_IODOMAIN=m
# CONFIG_ROCKCHIP_PM_DOMAINS is not set
CONFIG_SOC_SAMSUNG=y
# CONFIG_EXYNOS_CHIPID is not set
# CONFIG_EXYNOS_USI is not set
CONFIG_EXYNOS_PMU=y
CONFIG_EXYNOS_PMU_ARM_DRIVERS=y
CONFIG_EXYNOS_PM_DOMAINS=y
CONFIG_EXYNOS_REGULATOR_COUPLER=y
CONFIG_SOC_TEGRA20_VOLTAGE_COUPLER=y
CONFIG_SOC_TEGRA30_VOLTAGE_COUPLER=y
CONFIG_SOC_TI=y
# CONFIG_UX500_SOC_ID is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
CONFIG_DEVFREQ_GOV_POWERSAVE=m
CONFIG_DEVFREQ_GOV_USERSPACE=m
CONFIG_DEVFREQ_GOV_PASSIVE=m

#
# DEVFREQ Drivers
#
CONFIG_ARM_EXYNOS_BUS_DEVFREQ=m
# CONFIG_ARM_IMX_BUS_DEVFREQ is not set
# CONFIG_ARM_TEGRA_DEVFREQ is not set
CONFIG_ARM_SUN8I_A33_MBUS_DEVFREQ=m
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP=y
CONFIG_DEVFREQ_EVENT_EXYNOS_PPMU=m
CONFIG_DEVFREQ_EVENT_ROCKCHIP_DFI=m
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_FSA9480=y
# CONFIG_EXTCON_GPIO is not set
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX77843=y
CONFIG_EXTCON_PTN5150=m
CONFIG_EXTCON_QCOM_SPMI_MISC=m
CONFIG_EXTCON_RT8973A=y
# CONFIG_EXTCON_SM5502 is not set
CONFIG_EXTCON_USB_GPIO=m
# CONFIG_EXTCON_USBC_CROS_EC is not set
CONFIG_EXTCON_USBC_TUSB320=y
CONFIG_MEMORY=y
CONFIG_DDR=y
# CONFIG_ARM_PL172_MPMC is not set
# CONFIG_ATMEL_SDRAMC is not set
# CONFIG_ATMEL_EBI is not set
# CONFIG_BRCMSTB_DPFE is not set
# CONFIG_BT1_L2_CTL is not set
# CONFIG_TI_AEMIF is not set
CONFIG_TI_EMIF=y
# CONFIG_OMAP_GPMC is not set
# CONFIG_MVEBU_DEVBUS is not set
CONFIG_FSL_CORENET_CF=y
# CONFIG_FSL_IFC is not set
CONFIG_JZ4780_NEMC=y
CONFIG_MTK_SMI=m
CONFIG_DA8XX_DDRCTL=y
# CONFIG_PL353_SMC is not set
CONFIG_RENESAS_RPCIF=m
CONFIG_STM32_FMC2_EBI=m
# CONFIG_SAMSUNG_MC is not set
CONFIG_TEGRA_MC=y
# CONFIG_TEGRA20_EMC is not set
CONFIG_TEGRA30_EMC=y
CONFIG_TEGRA124_EMC=y
CONFIG_TEGRA210_EMC_TABLE=y
CONFIG_TEGRA210_EMC=m
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_EPF is not set
CONFIG_NTB_SWITCHTEC=m
CONFIG_NTB_PINGPONG=m
CONFIG_NTB_TOOL=m
# CONFIG_NTB_PERF is not set
CONFIG_NTB_TRANSPORT=m
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_DEBUG=y
CONFIG_PWM_ATMEL=m
# CONFIG_PWM_ATMEL_HLCDC_PWM is not set
CONFIG_PWM_ATMEL_TCB=m
CONFIG_PWM_BCM_IPROC=m
# CONFIG_PWM_BCM_KONA is not set
# CONFIG_PWM_BCM2835 is not set
CONFIG_PWM_BERLIN=y
CONFIG_PWM_BRCMSTB=y
# CONFIG_PWM_CLPS711X is not set
CONFIG_PWM_CROS_EC=y
CONFIG_PWM_DWC=m
CONFIG_PWM_EP93XX=y
CONFIG_PWM_FSL_FTM=y
CONFIG_PWM_HIBVT=m
# CONFIG_PWM_IMG is not set
CONFIG_PWM_IMX1=m
# CONFIG_PWM_IMX27 is not set
# CONFIG_PWM_IMX_TPM is not set
CONFIG_PWM_INTEL_LGM=m
# CONFIG_PWM_IQS620A is not set
CONFIG_PWM_JZ4740=m
CONFIG_PWM_KEEMBAY=y
CONFIG_PWM_LP3943=y
# CONFIG_PWM_LPC18XX_SCT is not set
CONFIG_PWM_LPC32XX=m
CONFIG_PWM_LPSS=m
# CONFIG_PWM_LPSS_PCI is not set
CONFIG_PWM_LPSS_PLATFORM=m
CONFIG_PWM_MESON=y
CONFIG_PWM_MTK_DISP=m
CONFIG_PWM_MEDIATEK=m
CONFIG_PWM_MXS=y
# CONFIG_PWM_NTXEC is not set
# CONFIG_PWM_OMAP_DMTIMER is not set
CONFIG_PWM_PCA9685=m
# CONFIG_PWM_PXA is not set
CONFIG_PWM_RASPBERRYPI_POE=m
CONFIG_PWM_RCAR=m
CONFIG_PWM_RENESAS_TPU=y
CONFIG_PWM_ROCKCHIP=y
CONFIG_PWM_SAMSUNG=y
# CONFIG_PWM_SIFIVE is not set
CONFIG_PWM_SL28CPLD=m
# CONFIG_PWM_SPEAR is not set
CONFIG_PWM_SPRD=y
CONFIG_PWM_STI=m
CONFIG_PWM_STM32=m
# CONFIG_PWM_STM32_LP is not set
CONFIG_PWM_STMPE=y
CONFIG_PWM_SUN4I=m
CONFIG_PWM_SUNPLUS=y
CONFIG_PWM_TEGRA=y
CONFIG_PWM_TIECAP=m
# CONFIG_PWM_TIEHRPWM is not set
# CONFIG_PWM_VISCONTI is not set
CONFIG_PWM_VT8500=m
# CONFIG_PWM_XILINX is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
# CONFIG_AL_FIC is not set
CONFIG_IXP4XX_IRQ=y
CONFIG_MADERA_IRQ=m
# CONFIG_JCORE_AIC is not set
CONFIG_RENESAS_INTC_IRQPIN=y
# CONFIG_RENESAS_IRQC is not set
CONFIG_RENESAS_RZA1_IRQC=y
# CONFIG_SL28CPLD_INTC is not set
CONFIG_TS4800_IRQ=y
# CONFIG_XILINX_INTC is not set
CONFIG_INGENIC_TCU_IRQ=y
CONFIG_IRQ_UNIPHIER_AIDET=y
CONFIG_MESON_IRQ_GPIO=y
# CONFIG_IMX_IRQSTEER is not set
CONFIG_IMX_INTMUX=y
CONFIG_EXYNOS_IRQ_COMBINER=y
# CONFIG_LOONGSON_PCH_PIC is not set
# CONFIG_LOONGSON_PCH_MSI is not set
CONFIG_MST_IRQ=y
CONFIG_MCHP_EIC=y
# end of IRQ chip support

CONFIG_IPACK_BUS=y
CONFIG_BOARD_TPCI200=m
CONFIG_SERIAL_IPOCTAL=m
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_ATH79=y
# CONFIG_RESET_AXS10X is not set
CONFIG_RESET_BCM6345=y
# CONFIG_RESET_BERLIN is not set
# CONFIG_RESET_BRCMSTB is not set
CONFIG_RESET_BRCMSTB_RESCAL=y
CONFIG_RESET_HSDK=y
# CONFIG_RESET_IMX7 is not set
CONFIG_RESET_INTEL_GW=y
# CONFIG_RESET_K210 is not set
# CONFIG_RESET_LANTIQ is not set
CONFIG_RESET_LPC18XX=y
CONFIG_RESET_MCHP_SPARX5=y
# CONFIG_RESET_MESON is not set
# CONFIG_RESET_MESON_AUDIO_ARB is not set
# CONFIG_RESET_NPCM is not set
CONFIG_RESET_PISTACHIO=y
# CONFIG_RESET_QCOM_AOSS is not set
CONFIG_RESET_QCOM_PDC=y
CONFIG_RESET_RASPBERRYPI=y
CONFIG_RESET_RZG2L_USBPHY_CTRL=m
CONFIG_RESET_SCMI=y
CONFIG_RESET_SIMPLE=y
CONFIG_RESET_SOCFPGA=y
CONFIG_RESET_STARFIVE_JH7100=y
CONFIG_RESET_SUNXI=y
CONFIG_RESET_TI_SCI=m
CONFIG_RESET_TI_SYSCON=y
CONFIG_RESET_TN48M_CPLD=y
CONFIG_RESET_UNIPHIER=y
CONFIG_RESET_UNIPHIER_GLUE=y
# CONFIG_RESET_ZYNQ is not set
CONFIG_COMMON_RESET_HI3660=m
CONFIG_COMMON_RESET_HI6220=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_PHY_LPC18XX_USB_OTG=m
CONFIG_PHY_PISTACHIO_USB=m
CONFIG_PHY_XGENE=y
CONFIG_USB_LGM_PHY=y
# CONFIG_PHY_CAN_TRANSCEIVER is not set
# CONFIG_PHY_SUN4I_USB is not set
CONFIG_PHY_SUN6I_MIPI_DPHY=m
CONFIG_PHY_SUN9I_USB=m
CONFIG_PHY_SUN50I_USB3=y
# CONFIG_PHY_MESON8_HDMI_TX is not set
CONFIG_PHY_MESON8B_USB2=m
CONFIG_PHY_MESON_GXL_USB2=y
CONFIG_PHY_MESON_G12A_USB2=m
# CONFIG_PHY_MESON_G12A_USB3_PCIE is not set
# CONFIG_PHY_MESON_AXG_PCIE is not set
CONFIG_PHY_MESON_AXG_MIPI_PCIE_ANALOG=m
CONFIG_PHY_MESON_AXG_MIPI_DPHY=y

#
# PHY drivers for Broadcom platforms
#
# CONFIG_PHY_BCM63XX_USBH is not set
CONFIG_PHY_CYGNUS_PCIE=m
# CONFIG_PHY_BCM_SR_USB is not set
CONFIG_BCM_KONA_USB2_PHY=y
# CONFIG_PHY_BCM_NS_USB2 is not set
# CONFIG_PHY_BCM_NS_USB3 is not set
CONFIG_PHY_NS2_PCIE=y
# CONFIG_PHY_NS2_USB_DRD is not set
# CONFIG_PHY_BRCM_SATA is not set
# CONFIG_PHY_BRCM_USB is not set
# CONFIG_PHY_BCM_SR_PCIE is not set
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_CADENCE_TORRENT=y
# CONFIG_PHY_CADENCE_DPHY is not set
CONFIG_PHY_CADENCE_DPHY_RX=y
# CONFIG_PHY_CADENCE_SIERRA is not set
CONFIG_PHY_CADENCE_SALVO=y
# CONFIG_PHY_FSL_IMX8MQ_USB is not set
CONFIG_PHY_MIXEL_MIPI_DPHY=m
# CONFIG_PHY_FSL_IMX8M_PCIE is not set
CONFIG_PHY_FSL_LYNX_28G=y
CONFIG_PHY_HI6220_USB=m
CONFIG_PHY_HI3660_USB=y
CONFIG_PHY_HI3670_USB=y
# CONFIG_PHY_HI3670_PCIE is not set
CONFIG_PHY_HISTB_COMBPHY=y
# CONFIG_PHY_HISI_INNO_USB2 is not set
# CONFIG_PHY_INGENIC_USB is not set
# CONFIG_PHY_LANTIQ_VRX200_PCIE is not set
# CONFIG_PHY_LANTIQ_RCU_USB2 is not set
CONFIG_ARMADA375_USBCLUSTER_PHY=y
CONFIG_PHY_BERLIN_SATA=m
# CONFIG_PHY_BERLIN_USB is not set
# CONFIG_PHY_MVEBU_A3700_UTMI is not set
CONFIG_PHY_MVEBU_A38X_COMPHY=y
CONFIG_PHY_MVEBU_CP110_UTMI=m
CONFIG_PHY_PXA_28NM_HSIC=m
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_PHY_PXA_USB=m
# CONFIG_PHY_MMP3_USB is not set
CONFIG_PHY_MMP3_HSIC=y
CONFIG_PHY_MTK_TPHY=y
# CONFIG_PHY_MTK_UFS is not set
# CONFIG_PHY_MTK_XSPHY is not set
CONFIG_PHY_MTK_HDMI=y
# CONFIG_PHY_MTK_MIPI_DSI is not set
# CONFIG_PHY_SPARX5_SERDES is not set
# CONFIG_PHY_LAN966X_SERDES is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
# CONFIG_PHY_OCELOT_SERDES is not set
CONFIG_PHY_ATH79_USB=m
CONFIG_PHY_QCOM_EDP=m
CONFIG_PHY_QCOM_IPQ4019_USB=m
CONFIG_PHY_QCOM_PCIE2=y
# CONFIG_PHY_QCOM_QMP is not set
# CONFIG_PHY_QCOM_QUSB2 is not set
CONFIG_PHY_QCOM_USB_HS=y
CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=m
# CONFIG_PHY_QCOM_USB_HSIC is not set
CONFIG_PHY_QCOM_USB_HS_28NM=m
CONFIG_PHY_QCOM_USB_SS=m
CONFIG_PHY_QCOM_IPQ806X_USB=y
CONFIG_PHY_MT7621_PCI=m
# CONFIG_PHY_RALINK_USB is not set
# CONFIG_PHY_RCAR_GEN3_USB3 is not set
CONFIG_PHY_ROCKCHIP_DPHY_RX0=y
CONFIG_PHY_ROCKCHIP_INNO_HDMI=y
# CONFIG_PHY_ROCKCHIP_INNO_USB2 is not set
CONFIG_PHY_ROCKCHIP_INNO_CSIDPHY=m
# CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY is not set
# CONFIG_PHY_ROCKCHIP_PCIE is not set
CONFIG_PHY_ROCKCHIP_TYPEC=m
# CONFIG_PHY_EXYNOS_DP_VIDEO is not set
# CONFIG_PHY_EXYNOS_MIPI_VIDEO is not set
CONFIG_PHY_EXYNOS_PCIE=y
CONFIG_PHY_SAMSUNG_UFS=y
CONFIG_PHY_SAMSUNG_USB2=m
CONFIG_PHY_S5PV210_USB2=y
# CONFIG_PHY_UNIPHIER_USB2 is not set
CONFIG_PHY_UNIPHIER_USB3=m
# CONFIG_PHY_UNIPHIER_PCIE is not set
# CONFIG_PHY_UNIPHIER_AHCI is not set
CONFIG_PHY_ST_SPEAR1310_MIPHY=m
# CONFIG_PHY_ST_SPEAR1340_MIPHY is not set
CONFIG_PHY_STIH407_USB=m
CONFIG_PHY_STM32_USBPHYC=y
CONFIG_PHY_TEGRA194_P2U=y
CONFIG_PHY_DA8XX_USB=y
# CONFIG_PHY_DM816X_USB is not set
CONFIG_PHY_AM654_SERDES=y
# CONFIG_PHY_J721E_WIZ is not set
CONFIG_OMAP_CONTROL_PHY=y
CONFIG_TI_PIPE3=y
# CONFIG_PHY_TUSB1210 is not set
CONFIG_PHY_INTEL_KEEMBAY_EMMC=y
CONFIG_PHY_INTEL_KEEMBAY_USB=m
# CONFIG_PHY_INTEL_LGM_COMBO is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
CONFIG_PHY_INTEL_THUNDERBAY_EMMC=m
CONFIG_PHY_XILINX_ZYNQMP=y
# end of PHY Subsystem

CONFIG_POWERCAP=y
# CONFIG_DTPM is not set
CONFIG_MCB=m
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
# CONFIG_ARM_CCN is not set
# CONFIG_ARM_CMN is not set
# CONFIG_ARM_PMU is not set
CONFIG_FSL_IMX8_DDR_PMU=m
# CONFIG_ARM_DMC620_PMU is not set
# end of Performance monitor support

CONFIG_RAS=y
CONFIG_USB4=m
# CONFIG_USB4_DEBUGFS_WRITE is not set
CONFIG_USB4_DMA_TEST=m

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

# CONFIG_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_IMX_IIM=m
# CONFIG_NVMEM_IMX_OCOTP is not set
# CONFIG_JZ4780_EFUSE is not set
CONFIG_NVMEM_LPC18XX_EEPROM=m
# CONFIG_NVMEM_LPC18XX_OTP is not set
# CONFIG_NVMEM_MXS_OCOTP is not set
# CONFIG_MTK_EFUSE is not set
CONFIG_NVMEM_NINTENDO_OTP=m
# CONFIG_QCOM_QFPROM is not set
# CONFIG_ROCKCHIP_EFUSE is not set
# CONFIG_ROCKCHIP_OTP is not set
CONFIG_NVMEM_BCM_OCOTP=y
CONFIG_NVMEM_STM32_ROMEM=y
# CONFIG_UNIPHIER_EFUSE is not set
# CONFIG_NVMEM_VF610_OCOTP is not set
# CONFIG_MESON_MX_EFUSE is not set
# CONFIG_NVMEM_SNVS_LPGPR is not set
# CONFIG_SC27XX_EFUSE is not set
# CONFIG_SPRD_EFUSE is not set
CONFIG_NVMEM_RMEM=y
CONFIG_NVMEM_BRCM_NVRAM=m
# CONFIG_NVMEM_LAYERSCAPE_SFP is not set
# CONFIG_NVMEM_SUNPLUS_OCOTP is not set
CONFIG_NVMEM_APPLE_EFUSES=m

#
# HW tracing support
#
CONFIG_STM=y
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
# CONFIG_STM_DUMMY is not set
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_FSI=y
# CONFIG_FSI_NEW_DEV_NODE is not set
CONFIG_FSI_MASTER_GPIO=m
CONFIG_FSI_MASTER_HUB=y
CONFIG_FSI_MASTER_ASPEED=y
CONFIG_FSI_SCOM=y
CONFIG_FSI_SBEFIFO=y
# CONFIG_FSI_OCC is not set
CONFIG_TEE=m
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=m
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=m
CONFIG_SIOX_BUS_GPIO=m
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y
CONFIG_INTERCONNECT=y
CONFIG_INTERCONNECT_IMX=y
CONFIG_INTERCONNECT_IMX8MM=m
CONFIG_INTERCONNECT_IMX8MN=m
# CONFIG_INTERCONNECT_IMX8MQ is not set
CONFIG_INTERCONNECT_QCOM_OSM_L3=m
# CONFIG_INTERCONNECT_SAMSUNG is not set
CONFIG_COUNTER=m
CONFIG_104_QUAD_8=m
# CONFIG_INTERRUPT_CNT is not set
# CONFIG_STM32_TIMER_CNT is not set
# CONFIG_STM32_LPTIMER_CNT is not set
CONFIG_TI_EQEP=m
CONFIG_FTM_QUADDEC=m
CONFIG_MICROCHIP_TCB_CAPTURE=m
# CONFIG_INTEL_QEP is not set
CONFIG_MOST=m
CONFIG_MOST_USB_HDM=m
CONFIG_MOST_CDEV=m
# CONFIG_MOST_SND is not set
# CONFIG_PECI is not set
CONFIG_HTE=y
# end of Device Drivers

#
# File systems
#
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=y
# CONFIG_EXT4_FS_POSIX_ACL is not set
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_EXT4_KUNIT_TESTS=m
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_CHECK=y
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_WARN=y
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=m
# CONFIG_BTRFS_FS is not set
CONFIG_NILFS2_FS=y
# CONFIG_F2FS_FS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FS_VERITY=y
# CONFIG_FS_VERITY_DEBUG is not set
CONFIG_FS_VERITY_BUILTIN_SIGNATURES=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_PRINT_QUOTA_WARNING is not set
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_FUSE_FS=y
CONFIG_CUSE=m
CONFIG_VIRTIO_FS=m
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
CONFIG_FSCACHE_DEBUG=y
CONFIG_CACHEFILES=m
CONFIG_CACHEFILES_DEBUG=y
# CONFIG_CACHEFILES_ERROR_INJECTION is not set
# CONFIG_CACHEFILES_ONDEMAND is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_EXFAT_FS is not set
CONFIG_NTFS_FS=y
CONFIG_NTFS_DEBUG=y
# CONFIG_NTFS_RW is not set
CONFIG_NTFS3_FS=m
CONFIG_NTFS3_LZX_XPRESS=y
CONFIG_NTFS3_FS_POSIX_ACL=y
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

# CONFIG_MISC_FILESYSTEMS is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=y
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=y
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=m
# CONFIG_NLS_ISO8859_5 is not set
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=y
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_MAC_ROMAN=y
# CONFIG_NLS_MAC_CELTIC is not set
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=m
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y
CONFIG_UNICODE=y
# CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
# CONFIG_PERSISTENT_KEYRINGS is not set
CONFIG_TRUSTED_KEYS=m
# CONFIG_TRUSTED_KEYS_TPM is not set
CONFIG_TRUSTED_KEYS_TEE=y
CONFIG_ENCRYPTED_KEYS=m
CONFIG_USER_DECRYPTED_DATA=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_TOMOYO=y
CONFIG_SECURITY_TOMOYO_MAX_ACCEPT_ENTRY=2048
CONFIG_SECURITY_TOMOYO_MAX_AUDIT_LOG=1024
CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER=y
CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING=y
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
CONFIG_SECURITY_SAFESETID=y
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_SECURITY_LANDLOCK=y
# CONFIG_INTEGRITY is not set
CONFIG_DEFAULT_SECURITY_TOMOYO=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
CONFIG_INIT_STACK_ALL_PATTERN=y
# CONFIG_INIT_STACK_ALL_ZERO is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=y
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=m
CONFIG_CRYPTO_ECDSA=y
# CONFIG_CRYPTO_ECRDSA is not set
CONFIG_CRYPTO_SM2=y
CONFIG_CRYPTO_CURVE25519=y

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=m
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=m
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_OFB=y
# CONFIG_CRYPTO_PCBC is not set
# CONFIG_CRYPTO_XTS is not set
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_NHPOLY1305=y
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_ESSIV=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=m
# CONFIG_CRYPTO_XXHASH is not set
CONFIG_CRYPTO_BLAKE2B=y
# CONFIG_CRYPTO_BLAKE2S is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=m
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_FCRYPT is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SM4=m
CONFIG_CRYPTO_SM4_GENERIC=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=m
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=m
CONFIG_CRYPTO_USER_API_RNG=y
CONFIG_CRYPTO_USER_API_RNG_CAVP=y
# CONFIG_CRYPTO_USER_API_AEAD is not set
# CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE is not set
CONFIG_CRYPTO_STATS=y
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=m
CONFIG_PKCS7_MESSAGE_PARSER=y
CONFIG_PKCS7_TEST_KEY=m
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
# CONFIG_MODULE_SIG_KEY_TYPE_RSA is not set
CONFIG_MODULE_SIG_KEY_TYPE_ECDSA=y
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
CONFIG_SECONDARY_TRUSTED_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_SYSTEM_REVOCATION_LIST=y
CONFIG_SYSTEM_REVOCATION_KEYS=""
CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE=y
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=y
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_STMP_DEVICE=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
# CONFIG_CRYPTO_LIB_CHACHA is not set
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=9
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_LIB_MEMNEQ=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=m
CONFIG_CRC64_ROCKSOFT=m
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
CONFIG_CRC4=y
CONFIG_CRC7=m
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
CONFIG_AUDIT_GENERIC=y
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=m
CONFIG_842_DECOMPRESS=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_MICROLZMA=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=m
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=m
CONFIG_INTERVAL_TREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_HAS_DMA_WRITE_COMBINE=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_ARCH_HAS_SETUP_DMA_OPS=y
CONFIG_ARCH_HAS_TEARDOWN_DMA_OPS=y
CONFIG_DMA_NONCOHERENT_MMAP=y
# CONFIG_DMA_CMA is not set
CONFIG_DMA_API_DEBUG=y
CONFIG_DMA_API_DEBUG_SG=y
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=m
CONFIG_NLATTR=y
CONFIG_GENERIC_ATOMIC64=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_DIMLIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_SG_POOL=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_STACK_HASH_ORDER=20
CONFIG_REF_TRACKER=y
CONFIG_SBITMAP=y
CONFIG_PARMAN=m
# CONFIG_OBJAGG is not set
# end of Library routines

CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
CONFIG_STACKTRACE_BUILD_ID=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_COMPRESSED is not set
CONFIG_DEBUG_INFO_SPLIT=y
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_GDB_SCRIPTS=y
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_ARCH_WANT_FRAME_POINTERS=y
CONFIG_FRAME_POINTER=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_UBSAN=y
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
# CONFIG_UBSAN_SHIFT is not set
CONFIG_UBSAN_DIV_ZERO=y
# CONFIG_UBSAN_UNREACHABLE is not set
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
CONFIG_TEST_UBSAN=m
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
CONFIG_NET_DEV_REFCNT_TRACKER=y
CONFIG_NET_NS_REFCNT_TRACKER=y
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_SLAB is not set
CONFIG_PAGE_OWNER=y
CONFIG_PAGE_POISONING=y
CONFIG_DEBUG_WX=y
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_SCHED_STACK_END_CHECK=y
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=y
CONFIG_KASAN_KUNIT_TEST=m
CONFIG_KASAN_MODULE_TEST=m
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
# CONFIG_WQ_WATCHDOG is not set
CONFIG_TEST_LOCKUP=m
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
# CONFIG_SCF_TORTURE_TEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=y
CONFIG_RCU_SCALE_TEST=y
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_REF_SCALE_TEST=m
CONFIG_RCU_TRACE=y
CONFIG_RCU_EQS_DEBUG=y
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_LATENCYTOP is not set
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACE_CLOCK=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_SAMPLES is not set
# CONFIG_STRICT_DEVMEM is not set

#
# arm Debugging
#
CONFIG_ARM_PTDUMP_CORE=y
# CONFIG_ARM_PTDUMP_DEBUGFS is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# CONFIG_UNWINDER_ARM is not set
# CONFIG_DEBUG_USER is not set
CONFIG_DEBUG_LL=y
CONFIG_DEBUG_ICEDCC=y
# CONFIG_DEBUG_SEMIHOSTING is not set
# CONFIG_DEBUG_LL_UART_8250 is not set
# CONFIG_DEBUG_LL_UART_PL01X is not set
# CONFIG_DEBUG_UART_FLOW_CONTROL is not set
CONFIG_DEBUG_LL_INCLUDE="debug/8250.S"
CONFIG_DEBUG_UART_8250=y
CONFIG_DEBUG_UART_PHYS=0xc8000003
CONFIG_DEBUG_UART_VIRT=0xfec00003
CONFIG_DEBUG_UART_8250_SHIFT=2
# CONFIG_DEBUG_UART_8250_WORD is not set
# CONFIG_DEBUG_UART_8250_PALMCHIP is not set
# CONFIG_DEBUG_UNCOMPRESS is not set
CONFIG_UNCOMPRESS_INCLUDE="debug/uncompress.h"
# CONFIG_EARLY_PRINTK is not set
CONFIG_CORESIGHT=y
CONFIG_CORESIGHT_LINKS_AND_SINKS=m
# CONFIG_CORESIGHT_LINK_AND_SINK_TMC is not set
CONFIG_CORESIGHT_SINK_TPIU=m
CONFIG_CORESIGHT_SINK_ETBV10=m
CONFIG_CORESIGHT_SOURCE_ETM3X=m
# CONFIG_CORESIGHT_CPU_DEBUG is not set
CONFIG_CORESIGHT_CTI=m
# CONFIG_CORESIGHT_CTI_INTEGRATION_REGS is not set
# end of arm Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=m
CONFIG_KUNIT_DEBUGFS=y
CONFIG_KUNIT_TEST=m
CONFIG_KUNIT_EXAMPLE_TEST=m
CONFIG_KUNIT_ALL_TESTS=m
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FAULT_INJECTION=y
CONFIG_FAILSLAB=y
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
# CONFIG_FAIL_MAKE_REQUEST is not set
CONFIG_FAIL_IO_TIMEOUT=y
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_MMC_REQUEST is not set
# CONFIG_FAULT_INJECTION_STACKTRACE_FILTER is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
CONFIG_ARCH_USE_MEMTEST=y
CONFIG_MEMTEST=y
# end of Kernel Testing and Coverage

CONFIG_WARN_MISSING_DOCUMENTS=y
# CONFIG_WARN_ABI_ERRORS is not set
# end of Kernel hacking

--isCNExCefFs+QYIc--
