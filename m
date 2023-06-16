Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6717334A1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343896AbjFPPWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345940AbjFPPV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:21:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EA32720
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686928914; x=1718464914;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IrUB3wm5B53SwR3zC4PoaeRdFH3cGoQDoG6SRA6sz5g=;
  b=hmsOhJKhicxCzHI2N/8REDIHqQLFHDGECAM+ETUUKSSeh41hDI6BDhpl
   UZ5nz+lNw4i7hhe+0zg1eXFDikfn4WQ6TN1ftJHNjAJqARCz96bBSD+7a
   YWAOz+XFRa3GubggsJUa7Y3k4Bt1jB6pa+Po8GweTWUSFcp9cdGLJI041
   sxa0pj7z0VA1iI86vhrENXwOePImYKOT2SBoVY7D2mUCGQvyamANCn02Z
   dP88PJk6piplwcTIS62f1psjGY07DA+MjLaryvF+QpqmwKi0XPjQjcvVl
   3ZQ+2Vr/6CBx9saU6Z1TOotMRAMs+ikbsnfK29kyUsuCZ+U/lIAxLNMPy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="445617589"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="445617589"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 08:21:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="742709717"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="742709717"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 16 Jun 2023 08:21:38 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qABGb-0001TA-2W;
        Fri, 16 Jun 2023 15:21:37 +0000
Date:   Fri, 16 Jun 2023 23:21:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Foley <pefoley2@pefoley.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>
Subject: arch/um/drivers/pcap_kern.c:18:6: warning: no previous prototype for
 'pcap_init_kern'
Message-ID: <202306162327.v3SoLRFC-lkp@intel.com>
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
head:   40f71e7cd3c6ac04293556ab0504a372393838ff
commit: 2c4d3841a82b88ae8a7b518dc6206f84f68e705a um: Avoid pcap multiple definition errors
date:   4 months ago
config: um-randconfig-r036-20230616 (https://download.01.org/0day-ci/archive/20230616/202306162327.v3SoLRFC-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230616/202306162327.v3SoLRFC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306162327.v3SoLRFC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/um/drivers/pcap_kern.c:18:6: warning: no previous prototype for 'pcap_init_kern' [-Wmissing-prototypes]
      18 | void pcap_init_kern(struct net_device *dev, void *data)
         |      ^~~~~~~~~~~~~~
   arch/um/drivers/pcap_kern.c:53:5: warning: no previous prototype for 'pcap_setup' [-Wmissing-prototypes]
      53 | int pcap_setup(char *str, char **mac_out, void *data)
         |     ^~~~~~~~~~


vim +/pcap_init_kern +18 arch/um/drivers/pcap_kern.c

    17	
  > 18	void pcap_init_kern(struct net_device *dev, void *data)
    19	{
    20		struct uml_net_private *pri;
    21		struct pcap_data *ppri;
    22		struct pcap_init *init = data;
    23	
    24		pri = netdev_priv(dev);
    25		ppri = (struct pcap_data *) pri->user;
    26		ppri->host_if = init->host_if;
    27		ppri->promisc = init->promisc;
    28		ppri->optimize = init->optimize;
    29		ppri->filter = init->filter;
    30	
    31		printk("pcap backend, host interface %s\n", ppri->host_if);
    32	}
    33	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
