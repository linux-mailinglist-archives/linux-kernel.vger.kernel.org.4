Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A525744DBC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 15:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjGBNhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 09:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjGBNhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 09:37:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16333126;
        Sun,  2 Jul 2023 06:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688305064; x=1719841064;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NNYHHNeDxU7dioHFvNlo1mYkVhxo+/tO2nZb1qvzOxA=;
  b=kTeDSRoJjm9ILvV4uNEIOK1brJqt2l0YaeODHqtleb/ZFJHDUOhJfss1
   BrlJAxsVpDLSvOtBYI4n3o8948ZmKTHplkSTOWFje/m74b7DH0wvoqana
   ivj6raXDQjx8qUcXATuyvIsWylsVxg/03a3SfsZn0Ql/iHnHB/4JfPdML
   4rqiq13Ms5UXVaZn/LXK4Wa5Evn9fV5aWl5GzWM1ygcSITYedQRS9THrq
   1tM87Atc4e5Lbfr/Glmj3A1l7wprh2fVADzMu5C4WpQdY0T3d+Fz7pb+H
   XrdC6Nd1kIgRag/sNY4J1Z/S7enlWqBGmFUFu5zfh+YsHGq81OIogY35N
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="343035014"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="343035014"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2023 06:37:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="753476256"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="753476256"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 02 Jul 2023 06:37:40 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qFxGl-000GgD-1r;
        Sun, 02 Jul 2023 13:37:39 +0000
Date:   Sun, 2 Jul 2023 21:37:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vivek Pernamitta <quic_vpernami@quicinc.com>, mhi@lists.linux.dev
Cc:     oe-kbuild-all@lists.linux.dev, mrana@quicinc.com,
        quic_qianyu@quicinc.com, manivannan.sadhasivam@linaro.org,
        Vivek Pernamitta <quic_vpernami@quicinc.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1] net: mhi : Add support to enable ethernet interface
Message-ID: <202307022148.nlp4Fazk-lkp@intel.com>
References: <1688118281-13032-1-git-send-email-quic_vpernami@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1688118281-13032-1-git-send-email-quic_vpernami@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master v6.4 next-20230630]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vivek-Pernamitta/net-mhi-Add-support-to-enable-ethernet-interface/20230630-174659
base:   net-next/main
patch link:    https://lore.kernel.org/r/1688118281-13032-1-git-send-email-quic_vpernami%40quicinc.com
patch subject: [PATCH V1] net: mhi : Add support to enable ethernet interface
config: i386-randconfig-i062-20230702 (https://download.01.org/0day-ci/archive/20230702/202307022148.nlp4Fazk-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230702/202307022148.nlp4Fazk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307022148.nlp4Fazk-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/mhi_net.c:327:37: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected unsigned char [usertype] *addr @@     got unsigned char const *dev_addr @@
   drivers/net/mhi_net.c:327:37: sparse:     expected unsigned char [usertype] *addr
   drivers/net/mhi_net.c:327:37: sparse:     got unsigned char const *dev_addr

vim +327 drivers/net/mhi_net.c

   320	
   321	static int mhi_net_newlink(struct mhi_device *mhi_dev, struct net_device *ndev, bool eth_dev)
   322	{
   323		struct mhi_net_dev *mhi_netdev;
   324		int err;
   325	
   326		if (eth_dev) {
 > 327			eth_random_addr(ndev->dev_addr);
   328			if (!is_valid_ether_addr(ndev->dev_addr))
   329				return -EADDRNOTAVAIL;
   330		}
   331	
   332		mhi_netdev = netdev_priv(ndev);
   333	
   334		dev_set_drvdata(&mhi_dev->dev, mhi_netdev);
   335		mhi_netdev->ndev = ndev;
   336		mhi_netdev->mdev = mhi_dev;
   337		mhi_netdev->skbagg_head = NULL;
   338		mhi_netdev->mru = mhi_dev->mhi_cntrl->mru;
   339		mhi_netdev->ethernet_if = eth_dev;
   340	
   341		INIT_DELAYED_WORK(&mhi_netdev->rx_refill, mhi_net_rx_refill_work);
   342		u64_stats_init(&mhi_netdev->stats.rx_syncp);
   343		u64_stats_init(&mhi_netdev->stats.tx_syncp);
   344	
   345		/* Start MHI channels */
   346		err = mhi_prepare_for_transfer(mhi_dev);
   347		if (err)
   348			return err;
   349	
   350		/* Number of transfer descriptors determines size of the queue */
   351		mhi_netdev->rx_queue_sz = mhi_get_free_desc_count(mhi_dev, DMA_FROM_DEVICE);
   352	
   353		err = register_netdev(ndev);
   354		if (err)
   355			return err;
   356	
   357		return 0;
   358	}
   359	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
