Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FE368B466
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 04:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjBFDMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 22:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBFDMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 22:12:51 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2D9AD23
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 19:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675653169; x=1707189169;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hRreS5MMfbxkyYd/i6powkdrEgmup0DpblL+BOXlTA8=;
  b=iaajhGrypSS1pemXETqMaHUcojRfR0WVqPArEv9UmIDCbkvuN5eGPyBv
   qlTbkqmopICVh2Can8cqcKkEdGEbXuqyvppQGFGUOObRkpe2MKQrwKJpe
   1NArcuUmbebRtmLRj5HZRmV6R9jWWNqj70rFDinm7vQSDdR70R6q7cYX4
   QxGi65ne9TPYjdr1lThzcBrgm/74BgTE85wgtJMe1Tus4ZsybFld2gbY4
   ovh3e+XRDYKyKArUAf2F73NLiLO9cuIVXPRxtJMNwh9QgXQIaFVLgcPEH
   smWbdp9VD41Ke38QUg4Au8wOdVbQbxjD9M6FhTmUcjqwVtLYd0ClDgeae
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="391518600"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="391518600"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 19:12:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="729872531"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="729872531"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 05 Feb 2023 19:12:47 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pOrvy-0002MB-2M;
        Mon, 06 Feb 2023 03:12:46 +0000
Date:   Mon, 6 Feb 2023 11:12:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/net/wireless/intel/ipw2x00/ipw2200.c:7151:21: warning:
 variable 'supported' set but not used
Message-ID: <202302061152.0TfxrnEz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stafford,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2d11f342b179f1894a901f143ec7c008caba43e
commit: ded2ee36313c941f1a12b6f85cde295b575264ae openrisc: Add pci bus support
date:   6 months ago
config: openrisc-randconfig-r005-20230206 (https://download.01.org/0day-ci/archive/20230206/202302061152.0TfxrnEz-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ded2ee36313c941f1a12b6f85cde295b575264ae
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ded2ee36313c941f1a12b6f85cde295b575264ae
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=openrisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/net/wireless/intel/ipw2x00/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/wireless/intel/ipw2x00/ipw2200.c: In function 'ipw_fw_dma_dump_command_block':
   drivers/net/wireless/intel/ipw2x00/ipw2200.c:2819:13: warning: variable 'register_value' set but not used [-Wunused-but-set-variable]
    2819 |         u32 register_value = 0;
         |             ^~~~~~~~~~~~~~
   drivers/net/wireless/intel/ipw2x00/ipw2200.c: In function 'ipw_is_qos_active':
>> drivers/net/wireless/intel/ipw2x00/ipw2200.c:7151:21: warning: variable 'supported' set but not used [-Wunused-but-set-variable]
    7151 |         int active, supported;
         |                     ^~~~~~~~~


vim +/supported +7151 drivers/net/wireless/intel/ipw2x00/ipw2200.c

43f66a6ce8da29 drivers/net/wireless/ipw2200.c         James Ketrenos   2005-03-25  7145  
a5cf4fe65144ff drivers/net/wireless/ipw2200.c         Zhu Yi           2006-04-13  7146  static int ipw_is_qos_active(struct net_device *dev,
a5cf4fe65144ff drivers/net/wireless/ipw2200.c         Zhu Yi           2006-04-13  7147  			     struct sk_buff *skb)
43f66a6ce8da29 drivers/net/wireless/ipw2200.c         James Ketrenos   2005-03-25  7148  {
b0a4e7d8a291de drivers/net/wireless/ipw2x00/ipw2200.c John W. Linville 2009-08-20  7149  	struct ipw_priv *priv = libipw_priv(dev);
b0a4e7d8a291de drivers/net/wireless/ipw2x00/ipw2200.c John W. Linville 2009-08-20  7150  	struct libipw_qos_data *qos_data = NULL;
b095c3819805f8 drivers/net/wireless/ipw2200.c         James Ketrenos   2005-08-24 @7151  	int active, supported;
a5cf4fe65144ff drivers/net/wireless/ipw2200.c         Zhu Yi           2006-04-13  7152  	u8 *daddr = skb->data + ETH_ALEN;
a5cf4fe65144ff drivers/net/wireless/ipw2200.c         Zhu Yi           2006-04-13  7153  	int unicast = !is_multicast_ether_addr(daddr);
43f66a6ce8da29 drivers/net/wireless/ipw2200.c         James Ketrenos   2005-03-25  7154  
b095c3819805f8 drivers/net/wireless/ipw2200.c         James Ketrenos   2005-08-24  7155  	if (!(priv->status & STATUS_ASSOCIATED))
b095c3819805f8 drivers/net/wireless/ipw2200.c         James Ketrenos   2005-08-24  7156  		return 0;
b095c3819805f8 drivers/net/wireless/ipw2200.c         James Ketrenos   2005-08-24  7157  
b095c3819805f8 drivers/net/wireless/ipw2200.c         James Ketrenos   2005-08-24  7158  	qos_data = &priv->assoc_network->qos_data;
b095c3819805f8 drivers/net/wireless/ipw2200.c         James Ketrenos   2005-08-24  7159  
b095c3819805f8 drivers/net/wireless/ipw2200.c         James Ketrenos   2005-08-24  7160  	if (priv->ieee->iw_mode == IW_MODE_ADHOC) {
b095c3819805f8 drivers/net/wireless/ipw2200.c         James Ketrenos   2005-08-24  7161  		if (unicast == 0)
b095c3819805f8 drivers/net/wireless/ipw2200.c         James Ketrenos   2005-08-24  7162  			qos_data->active = 0;
b095c3819805f8 drivers/net/wireless/ipw2200.c         James Ketrenos   2005-08-24  7163  		else
b095c3819805f8 drivers/net/wireless/ipw2200.c         James Ketrenos   2005-08-24  7164  			qos_data->active = qos_data->supported;
43f66a6ce8da29 drivers/net/wireless/ipw2200.c         James Ketrenos   2005-03-25  7165  	}
b095c3819805f8 drivers/net/wireless/ipw2200.c         James Ketrenos   2005-08-24  7166  	active = qos_data->active;
b095c3819805f8 drivers/net/wireless/ipw2200.c         James Ketrenos   2005-08-24  7167  	supported = qos_data->supported;
afbf30a2b78cac drivers/net/wireless/ipw2200.c         James Ketrenos   2005-08-25  7168  	IPW_DEBUG_QOS("QoS  %d network is QoS active %d  supported %d  "
afbf30a2b78cac drivers/net/wireless/ipw2200.c         James Ketrenos   2005-08-25  7169  		      "unicast %d\n",
b095c3819805f8 drivers/net/wireless/ipw2200.c         James Ketrenos   2005-08-24  7170  		      priv->qos_data.qos_enable, active, supported, unicast);
a5cf4fe65144ff drivers/net/wireless/ipw2200.c         Zhu Yi           2006-04-13  7171  	if (active && priv->qos_data.qos_enable)
a5cf4fe65144ff drivers/net/wireless/ipw2200.c         Zhu Yi           2006-04-13  7172  		return 1;
a5cf4fe65144ff drivers/net/wireless/ipw2200.c         Zhu Yi           2006-04-13  7173  
a5cf4fe65144ff drivers/net/wireless/ipw2200.c         Zhu Yi           2006-04-13  7174  	return 0;
a5cf4fe65144ff drivers/net/wireless/ipw2200.c         Zhu Yi           2006-04-13  7175  

:::::: The code at line 7151 was first introduced by commit
:::::: b095c3819805f87d73d41641a53e4c070360d783 Catch ipw2200 up to equivelancy with v1.0.4

:::::: TO: James Ketrenos <jketreno@linux.intel.com>
:::::: CC: James Ketrenos <jketreno@linux.intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
