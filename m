Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DA6733DAB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 04:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjFQCtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 22:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjFQCtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 22:49:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12ED12D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 19:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686970149; x=1718506149;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JeHJD950M6yuXb6mwy4z5Mx9/VJF6OSE4Ji+YDaScTY=;
  b=WJv761W24GXVQH85yzsnK1xQQYowrUVneADKotKqTwWpuZMNYcNSZj3l
   xYK4u3vOHPk0OTT1oGaE5iSt/xVOBcWZhtE1f1OMmCjuDa/mvLN5/TKi9
   0KXcRjGjwQle9zwKJaM+rs1VbIk29YtrPgmv8CoGTtYWV4JMMA7gepQyP
   0v7WyB1QdFlGlCvGGS8UmM3bbPytixVNCjGLCtu/Pmu8P1jSnHHdVnvzP
   D1rRrRjSmDkwgH55wNWj67ZKu5Xl0DB/ey5/RptfXRQvRktzISRok8S4w
   p0f931+x/Hs2kjPK0JLBEwKio3SI7IbpkEdvJB1i8AdCXd2xAxS3bKrno
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="349064199"
X-IronPort-AV: E=Sophos;i="6.00,249,1681196400"; 
   d="scan'208";a="349064199"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 19:49:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="837228092"
X-IronPort-AV: E=Sophos;i="6.00,249,1681196400"; 
   d="scan'208";a="837228092"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 16 Jun 2023 19:49:08 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qALzv-000288-12;
        Sat, 17 Jun 2023 02:49:07 +0000
Date:   Sat, 17 Jun 2023 10:48:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>
Subject: arch/um/drivers/virt-pci.c:537:21: warning: no previous prototype
 for 'pcibios_get_phb_of_node'
Message-ID: <202306171053.SOGnteNi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1639fae5132bc8a904af28d97cea0bedb3af802e
commit: 314a1408b79a844dafdcde867d90de5d509409b7 um: virt-pci: implement pcibios_get_phb_of_node()
date:   4 months ago
config: um-randconfig-r026-20230617 (https://download.01.org/0day-ci/archive/20230617/202306171053.SOGnteNi-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230617/202306171053.SOGnteNi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306171053.SOGnteNi-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/um/drivers/virt-pci.c:537:21: warning: no previous prototype for 'pcibios_get_phb_of_node' [-Wmissing-prototypes]
     537 | struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
         |                     ^~~~~~~~~~~~~~~~~~~~~~~


vim +/pcibios_get_phb_of_node +537 arch/um/drivers/virt-pci.c

   535	
   536	/* Copied from arch/x86/kernel/devicetree.c */
 > 537	struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
   538	{
   539		struct device_node *np;
   540	
   541		for_each_node_by_type(np, "pci") {
   542			const void *prop;
   543			unsigned int bus_min;
   544	
   545			prop = of_get_property(np, "bus-range", NULL);
   546			if (!prop)
   547				continue;
   548			bus_min = be32_to_cpup(prop);
   549			if (bus->number == bus_min)
   550				return np;
   551		}
   552		return NULL;
   553	}
   554	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
