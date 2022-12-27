Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC71656DC0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 18:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiL0R4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 12:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiL0R4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 12:56:36 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99191AD
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 09:56:33 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso6550742wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 09:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EwM/fBfrUUVz1mduvq+vEFx/4zKbQs6z+L9h8AqPjss=;
        b=PvJ9V5qD0ps1iC5jYEKfr1CnBFhI5u8GCyYZ6RMyLQgXtCNxGGEzE8bMtj3FkLrvFz
         A2SeCi+cNfrcyMZ54oYtXHtucY05FFGXUrEToYUrc/sdLCOrO6h9eqrIFbo8ETKY1vJj
         cErJ4uTZ7Qxg/9kZ9KpI2p/97m7XTWsexON2mvdO0JOv4EAh0kXEF7o6uKQc21QSAgPB
         lzLOotUzA0Al2zm5jN1bt/LZu7sNeNfwxa8V5+qJ9z50pR//zOhdf7MRxDmi4zemfHUy
         n46wu/IP/QeWVIpUOmbYjCUzWkxQvYFw0VYNa4RH9QyRBC8amQgvbhwnuuGLw+KBYDj8
         TY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EwM/fBfrUUVz1mduvq+vEFx/4zKbQs6z+L9h8AqPjss=;
        b=DJSRpNBAd2h3Ucvt6XkysLkrDU4gbzzClbe0XUof1wsYIowwK8SjBZb7BiCmM4aWks
         rvtIdVuSYPqgNh4NTuAE/ATTam4TT501vegF9hu+JTD4yJy9VksYmtA6MqrPReNM69bK
         JcKi2Zt/cIuWucgprZtyMJkCNgllholRbf+QxHD2nsmwBeoFrKRy65v9SO9cuPgxG/Zi
         eUNKFFcIT/lN5L38xoAOmdvKZKCcRK5p6Y3lHHWG952Q8PufMeeADYNI5JtQpyQuGHw8
         0gNcS8Q5HC4uh74UY1aI5MqKtoyuqHIHiGeWYwyZpsqdb4UxXN4Zqn/2HiyIcMXnmHJ6
         7AYg==
X-Gm-Message-State: AFqh2komyK9UBlQZP524JLsqWVUERjcYOkoUcjvHMQPB/y7aOkGjiiTm
        dgurBkA6q0CNeeLgDPgqgTE=
X-Google-Smtp-Source: AMrXdXt1eWy+mK/C9i2KYXdq0iHfulaobi/jCqO9yAxprpQfVaO+v6BgCuSHTbPwmMK4KouYLRv7Pg==
X-Received: by 2002:a05:600c:3493:b0:3d2:370b:97f4 with SMTP id a19-20020a05600c349300b003d2370b97f4mr19251819wmq.16.1672163792312;
        Tue, 27 Dec 2022 09:56:32 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m8-20020a05600c4f4800b003cfaae07f68sm24123899wmq.17.2022.12.27.09.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 09:56:31 -0800 (PST)
Date:   Tue, 27 Dec 2022 20:56:27 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: drivers/pci/controller/vmd.c:876 vmd_enable_domain() error:
 uninitialized symbol 'ret'.
Message-ID: <202212262019.g63LQtiD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1b929c02afd37871d5afb9d498426f83432e71c2
commit: 0a584655ef89541dae4d48d2c523b1480ae80284 PCI: vmd: Fix secondary bus reset for Intel bridges
config: x86_64-randconfig-m001-20221226
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/pci/controller/vmd.c:876 vmd_enable_domain() error: uninitialized symbol 'ret'.

vim +/ret +876 drivers/pci/controller/vmd.c

6788958e4f3ca1 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  712  static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  713  {
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  714  	struct pci_sysdata *sd = &vmd->sysdata;
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  715  	struct resource *res;
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  716  	u32 upper_bits;
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  717  	unsigned long flags;
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  718  	LIST_HEAD(resources);
6788958e4f3ca1 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  719  	resource_size_t offset[2] = {0};
e3dffa4f6c3612 drivers/pci/controller/vmd.c Jon Derrick       2019-09-16  720  	resource_size_t membar2_offset = 0x2000;
0294951030eb8e drivers/pci/controller/vmd.c Jon Derrick       2018-12-13  721  	struct pci_bus *child;
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  722  	struct pci_dev *dev;
030109c0376c8f drivers/pci/controller/vmd.c Jon Derrick       2020-07-28  723  	int ret;
6788958e4f3ca1 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  724  
6788958e4f3ca1 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  725  	/*
6788958e4f3ca1 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  726  	 * Shadow registers may exist in certain VMD device ids which allow
6788958e4f3ca1 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  727  	 * guests to correctly assign host physical addresses to the root ports
6788958e4f3ca1 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  728  	 * and child devices. These registers will either return the host value
6788958e4f3ca1 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  729  	 * or 0, depending on an enable bit in the VMD device.
6788958e4f3ca1 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  730  	 */
6788958e4f3ca1 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  731  	if (features & VMD_FEAT_HAS_MEMBAR_SHADOW) {
a1a30170138c9c drivers/pci/controller/vmd.c Jon Derrick       2019-09-16  732  		membar2_offset = MB2_SHADOW_OFFSET + MB2_SHADOW_SIZE;
030109c0376c8f drivers/pci/controller/vmd.c Jon Derrick       2020-07-28  733  		ret = vmd_get_phys_offsets(vmd, true, &offset[0], &offset[1]);
030109c0376c8f drivers/pci/controller/vmd.c Jon Derrick       2020-07-28  734  		if (ret)
030109c0376c8f drivers/pci/controller/vmd.c Jon Derrick       2020-07-28  735  			return ret;
030109c0376c8f drivers/pci/controller/vmd.c Jon Derrick       2020-07-28  736  	} else if (features & VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP) {
030109c0376c8f drivers/pci/controller/vmd.c Jon Derrick       2020-07-28  737  		ret = vmd_get_phys_offsets(vmd, false, &offset[0], &offset[1]);
030109c0376c8f drivers/pci/controller/vmd.c Jon Derrick       2020-07-28  738  		if (ret)
030109c0376c8f drivers/pci/controller/vmd.c Jon Derrick       2020-07-28  739  			return ret;
51f939b11cb1c4 drivers/pci/controller/vmd.c Jon Derrick       2020-05-27  740  	}
51f939b11cb1c4 drivers/pci/controller/vmd.c Jon Derrick       2020-05-27  741  
2a5a9c9a20f919 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  742  	/*
2a5a9c9a20f919 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  743  	 * Certain VMD devices may have a root port configuration option which
08bcdd22ecdb01 drivers/pci/controller/vmd.c Jon Derrick       2019-11-12  744  	 * limits the bus range to between 0-127, 128-255, or 224-255
2a5a9c9a20f919 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  745  	 */
2a5a9c9a20f919 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  746  	if (features & VMD_FEAT_HAS_BUS_RESTRICTIONS) {
2e1224183b1bec drivers/pci/controller/vmd.c Jon Derrick       2020-07-28  747  		ret = vmd_get_bus_number_start(vmd);
2e1224183b1bec drivers/pci/controller/vmd.c Jon Derrick       2020-07-28  748  		if (ret)
2e1224183b1bec drivers/pci/controller/vmd.c Jon Derrick       2020-07-28  749  			return ret;
2a5a9c9a20f919 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  750  	}
2a5a9c9a20f919 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  751  
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  752  	res = &vmd->dev->resource[VMD_CFGBAR];
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  753  	vmd->resources[0] = (struct resource) {
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  754  		.name  = "VMD CFGBAR",
e3dffa4f6c3612 drivers/pci/controller/vmd.c Jon Derrick       2019-09-16  755  		.start = vmd->busn_start,
e3dffa4f6c3612 drivers/pci/controller/vmd.c Jon Derrick       2019-09-16  756  		.end   = vmd->busn_start + (resource_size(res) >> 20) - 1,
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  757  		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  758  	};
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  759  
83cc54a608b66d arch/x86/pci/vmd.c           Keith Busch       2016-03-02  760  	/*
83cc54a608b66d arch/x86/pci/vmd.c           Keith Busch       2016-03-02  761  	 * If the window is below 4GB, clear IORESOURCE_MEM_64 so we can
83cc54a608b66d arch/x86/pci/vmd.c           Keith Busch       2016-03-02  762  	 * put 32-bit resources in the window.
83cc54a608b66d arch/x86/pci/vmd.c           Keith Busch       2016-03-02  763  	 *
83cc54a608b66d arch/x86/pci/vmd.c           Keith Busch       2016-03-02  764  	 * There's no hardware reason why a 64-bit window *couldn't*
83cc54a608b66d arch/x86/pci/vmd.c           Keith Busch       2016-03-02  765  	 * contain a 32-bit resource, but pbus_size_mem() computes the
83cc54a608b66d arch/x86/pci/vmd.c           Keith Busch       2016-03-02  766  	 * bridge window size assuming a 64-bit window will contain no
83cc54a608b66d arch/x86/pci/vmd.c           Keith Busch       2016-03-02  767  	 * 32-bit resources.  __pci_assign_resource() enforces that
83cc54a608b66d arch/x86/pci/vmd.c           Keith Busch       2016-03-02  768  	 * artificial restriction to make sure everything will fit.
83cc54a608b66d arch/x86/pci/vmd.c           Keith Busch       2016-03-02  769  	 *
f6b6aefee70aa5 drivers/pci/controller/vmd.c Bjorn Helgaas     2019-05-30  770  	 * The only way we could use a 64-bit non-prefetchable MEMBAR is
83cc54a608b66d arch/x86/pci/vmd.c           Keith Busch       2016-03-02  771  	 * if its address is <4GB so that we can convert it to a 32-bit
83cc54a608b66d arch/x86/pci/vmd.c           Keith Busch       2016-03-02  772  	 * resource.  To be visible to the host OS, all VMD endpoints must
83cc54a608b66d arch/x86/pci/vmd.c           Keith Busch       2016-03-02  773  	 * be initially configured by platform BIOS, which includes setting
83cc54a608b66d arch/x86/pci/vmd.c           Keith Busch       2016-03-02  774  	 * up these resources.  We can assume the device is configured
83cc54a608b66d arch/x86/pci/vmd.c           Keith Busch       2016-03-02  775  	 * according to the platform needs.
83cc54a608b66d arch/x86/pci/vmd.c           Keith Busch       2016-03-02  776  	 */
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  777  	res = &vmd->dev->resource[VMD_MEMBAR1];
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  778  	upper_bits = upper_32_bits(res->end);
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  779  	flags = res->flags & ~IORESOURCE_SIZEALIGN;
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  780  	if (!upper_bits)
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  781  		flags &= ~IORESOURCE_MEM_64;
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  782  	vmd->resources[1] = (struct resource) {
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  783  		.name  = "VMD MEMBAR1",
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  784  		.start = res->start,
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  785  		.end   = res->end,
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  786  		.flags = flags,
2c2c5c5cd213ae arch/x86/pci/vmd.c           Jon Derrick       2016-02-24  787  		.parent = res,
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  788  	};
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  789  
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  790  	res = &vmd->dev->resource[VMD_MEMBAR2];
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  791  	upper_bits = upper_32_bits(res->end);
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  792  	flags = res->flags & ~IORESOURCE_SIZEALIGN;
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  793  	if (!upper_bits)
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  794  		flags &= ~IORESOURCE_MEM_64;
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  795  	vmd->resources[2] = (struct resource) {
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  796  		.name  = "VMD MEMBAR2",
6788958e4f3ca1 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  797  		.start = res->start + membar2_offset,
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  798  		.end   = res->end,
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  799  		.flags = flags,
2c2c5c5cd213ae arch/x86/pci/vmd.c           Jon Derrick       2016-02-24  800  		.parent = res,
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  801  	};
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  802  
34067c56fa177d drivers/pci/controller/vmd.c Jon Derrick       2020-01-21  803  	sd->vmd_dev = vmd->dev;
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  804  	sd->domain = vmd_find_free_domain();
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  805  	if (sd->domain < 0)
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  806  		return sd->domain;
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  807  
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  808  	sd->node = pcibus_to_node(vmd->dev->bus);
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  809  
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  810  	/*
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  811  	 * Currently MSI remapping must be enabled in guest passthrough mode
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  812  	 * due to some missing interrupt remapping plumbing. This is probably
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  813  	 * acceptable because the guest is usually CPU-limited and MSI
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  814  	 * remapping doesn't become a performance bottleneck.
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  815  	 */
c94f732e8001a8 drivers/pci/controller/vmd.c Nirmal Patel      2022-05-11  816  	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  817  	    offset[0] || offset[1]) {
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  818  		ret = vmd_alloc_irqs(vmd);
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  819  		if (ret)
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  820  			return ret;
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  821  
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  822  		vmd_set_msi_remapping(vmd, true);
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  823  
1552b11ba15e93 drivers/pci/controller/vmd.c Jon Derrick       2020-07-28  824  		ret = vmd_create_irq_domain(vmd);
1552b11ba15e93 drivers/pci/controller/vmd.c Jon Derrick       2020-07-28  825  		if (ret)
1552b11ba15e93 drivers/pci/controller/vmd.c Jon Derrick       2020-07-28  826  			return ret;
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  827  
d7f954e54079b4 drivers/pci/controller/vmd.c Thomas Gleixner   2020-08-26  828  		/*
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  829  		 * Override the IRQ domain bus token so the domain can be
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  830  		 * distinguished from a regular PCI/MSI domain.
d7f954e54079b4 drivers/pci/controller/vmd.c Thomas Gleixner   2020-08-26  831  		 */
d7f954e54079b4 drivers/pci/controller/vmd.c Thomas Gleixner   2020-08-26  832  		irq_domain_update_bus_token(vmd->irq_domain, DOMAIN_BUS_VMD_MSI);
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  833  	} else {
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  834  		vmd_set_msi_remapping(vmd, false);
ee81ee84f8739e drivers/pci/controller/vmd.c Jon Derrick       2021-02-10  835  	}
d7f954e54079b4 drivers/pci/controller/vmd.c Thomas Gleixner   2020-08-26  836  
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  837  	pci_add_resource(&resources, &vmd->resources[0]);
6788958e4f3ca1 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  838  	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
6788958e4f3ca1 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  839  	pci_add_resource_offset(&resources, &vmd->resources[2], offset[1]);
6788958e4f3ca1 drivers/pci/host/vmd.c       Jon Derrick       2018-05-18  840  
e3dffa4f6c3612 drivers/pci/controller/vmd.c Jon Derrick       2019-09-16  841  	vmd->bus = pci_create_root_bus(&vmd->dev->dev, vmd->busn_start,
e3dffa4f6c3612 drivers/pci/controller/vmd.c Jon Derrick       2019-09-16  842  				       &vmd_ops, sd, &resources);
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  843  	if (!vmd->bus) {
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  844  		pci_free_resource_list(&resources);
1552b11ba15e93 drivers/pci/controller/vmd.c Jon Derrick       2020-07-28  845  		vmd_remove_irq_domain(vmd);
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  846  		return -ENODEV;
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  847  	}
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  848  
04b12ef163d10e drivers/pci/controller/vmd.c Kai-Heng Feng     2021-12-03  849  	vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
04b12ef163d10e drivers/pci/controller/vmd.c Kai-Heng Feng     2021-12-03  850  				   to_pci_host_bridge(vmd->bus->bridge));
04b12ef163d10e drivers/pci/controller/vmd.c Kai-Heng Feng     2021-12-03  851  
2c2c5c5cd213ae arch/x86/pci/vmd.c           Jon Derrick       2016-02-24  852  	vmd_attach_resources(vmd);
1552b11ba15e93 drivers/pci/controller/vmd.c Jon Derrick       2020-07-28  853  	if (vmd->irq_domain)
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  854  		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
886e67100b904c drivers/pci/controller/vmd.c Nirmal Patel      2022-05-11  855  	else
886e67100b904c drivers/pci/controller/vmd.c Nirmal Patel      2022-05-11  856  		dev_set_msi_domain(&vmd->bus->dev,
886e67100b904c drivers/pci/controller/vmd.c Nirmal Patel      2022-05-11  857  				   dev_get_msi_domain(&vmd->dev->dev));
0294951030eb8e drivers/pci/controller/vmd.c Jon Derrick       2018-12-13  858  
59dc33252ee777 drivers/pci/controller/vmd.c Rafael J. Wysocki 2021-08-24  859  	vmd_acpi_begin();
59dc33252ee777 drivers/pci/controller/vmd.c Rafael J. Wysocki 2021-08-24  860  
0294951030eb8e drivers/pci/controller/vmd.c Jon Derrick       2018-12-13  861  	pci_scan_child_bus(vmd->bus);
6aab5622296b99 drivers/pci/controller/vmd.c Nirmal Patel      2021-11-16  862  	vmd_domain_reset(vmd);
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  863  
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  864  	/* When Intel VMD is enabled, the OS does not discover the Root Ports
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  865  	 * owned by Intel VMD within the MMCFG space. pci_reset_bus() applies
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  866  	 * a reset to the parent of the PCI device supplied as argument. This
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  867  	 * is why we pass a child device, so the reset can be triggered at
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  868  	 * the Intel bridge level and propagated to all the children in the
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  869  	 * hierarchy.
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  870  	 */
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  871  	list_for_each_entry(child, &vmd->bus->children, node) {
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  872  		if (!list_empty(&child->devices)) {
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  873  			dev = list_first_entry(&child->devices,
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  874  					       struct pci_dev, bus_list);
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  875  			if (pci_reset_bus(dev))
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05 @876  				pci_warn(dev, "can't reset device: %d\n", ret);

"ret" not initialized/useful at this point.

0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  877  
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  878  			break;
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  879  		}
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  880  	}
0a584655ef8954 drivers/pci/controller/vmd.c Francisco Munoz   2022-12-05  881  
0294951030eb8e drivers/pci/controller/vmd.c Jon Derrick       2018-12-13  882  	pci_assign_unassigned_bus_resources(vmd->bus);
0294951030eb8e drivers/pci/controller/vmd.c Jon Derrick       2018-12-13  883  
0294951030eb8e drivers/pci/controller/vmd.c Jon Derrick       2018-12-13  884  	/*
0294951030eb8e drivers/pci/controller/vmd.c Jon Derrick       2018-12-13  885  	 * VMD root buses are virtual and don't return true on pci_is_pcie()
0294951030eb8e drivers/pci/controller/vmd.c Jon Derrick       2018-12-13  886  	 * and will fail pcie_bus_configure_settings() early. It can instead be
0294951030eb8e drivers/pci/controller/vmd.c Jon Derrick       2018-12-13  887  	 * run on each of the real root ports.
0294951030eb8e drivers/pci/controller/vmd.c Jon Derrick       2018-12-13  888  	 */
0294951030eb8e drivers/pci/controller/vmd.c Jon Derrick       2018-12-13  889  	list_for_each_entry(child, &vmd->bus->children, node)
0294951030eb8e drivers/pci/controller/vmd.c Jon Derrick       2018-12-13  890  		pcie_bus_configure_settings(child);
0294951030eb8e drivers/pci/controller/vmd.c Jon Derrick       2018-12-13  891  
0294951030eb8e drivers/pci/controller/vmd.c Jon Derrick       2018-12-13  892  	pci_bus_add_devices(vmd->bus);
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  893  
59dc33252ee777 drivers/pci/controller/vmd.c Rafael J. Wysocki 2021-08-24  894  	vmd_acpi_end();
59dc33252ee777 drivers/pci/controller/vmd.c Rafael J. Wysocki 2021-08-24  895  
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  896  	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  897  			       "domain"), "Can't create symlink to domain\n");
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  898  	return 0;
185a383ada2e77 arch/x86/pci/vmd.c           Keith Busch       2016-01-12  899  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

