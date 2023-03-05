Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDE66AB371
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 00:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjCEXTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 18:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCEXTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 18:19:53 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4471212F28
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 15:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678058392; x=1709594392;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+G7Exa0ezcTq85FCbf+hOYvGCKlYRYioVNwPdeH+PDs=;
  b=lweqXEDEqd88Kh3MAVix9rFzDRVLcbDVk2gUoKFQxjwwv2C8USQ68dnS
   3g3N0PgscjoKiibVn7k2wCZVrs+N0Yebg0e+H/1Zn1OwxD3n3ho1QEZH6
   NbZ4Y7XBigx8Wwwwqh//5k88xnm0pjrgTBxHRf2Y0mxHQ+n7NXemPgebC
   9V+crhKnCwJ0cXA2X2qHDpm4WqCI1kYKwC/e8PUdu4f/FaVpGlX+pZZ/6
   yKejIEdbcIAzahH8cd5UMTqKZDbf2QIiJ4Vqa9xPFWwKW+RuUlQEELejK
   uG1w5uwqC/YP6R03kI+839Nno9e9SrrSeTXmHAC5qqp6Dc1o1cZAXtLzY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="336951328"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="336951328"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 15:19:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="799823191"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="799823191"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 05 Mar 2023 15:19:50 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pYxdt-0003A4-0i;
        Sun, 05 Mar 2023 23:19:49 +0000
Date:   Mon, 6 Mar 2023 07:19:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: drivers/net/dsa/ocelot/ocelot_ext.c:144:34: warning:
 'ocelot_ext_switch_of_match' defined but not used
Message-ID: <202303060716.BDSREmLN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f915322fe014c5c515119381e886faf07b3c9d31
commit: 3d7316ac81ac329efce221b5584138e8c637a7b1 net: dsa: ocelot: add external ocelot switch control
date:   5 weeks ago
config: i386-buildonly-randconfig-r006-20230306 (https://download.01.org/0day-ci/archive/20230306/202303060716.BDSREmLN-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3d7316ac81ac329efce221b5584138e8c637a7b1
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3d7316ac81ac329efce221b5584138e8c637a7b1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/dsa/ocelot/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303060716.BDSREmLN-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/dsa/ocelot/ocelot_ext.c:144:34: warning: 'ocelot_ext_switch_of_match' defined but not used [-Wunused-const-variable=]
     144 | static const struct of_device_id ocelot_ext_switch_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/ocelot_ext_switch_of_match +144 drivers/net/dsa/ocelot/ocelot_ext.c

   143	
 > 144	static const struct of_device_id ocelot_ext_switch_of_match[] = {
   145		{ .compatible = "mscc,vsc7512-switch" },
   146		{ },
   147	};
   148	MODULE_DEVICE_TABLE(of, ocelot_ext_switch_of_match);
   149	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
