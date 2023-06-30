Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C23743CFB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 15:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjF3Nrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 09:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjF3Nrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 09:47:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BCA3A8E;
        Fri, 30 Jun 2023 06:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688132851; x=1719668851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9sM2Z0ZbOcroZOD9P9vuoDOY6kcrOfhx3gRZ/Nk6+Og=;
  b=cHxMImJ8xy1efwj2ppzbgKfJFUTkW+DhEcUiue+s9MuqkWCOtVZ+AR1y
   y0EGjND7KnWLOgZuxK6j4cJ+Q1txbOIr/ToUedV/eX9D9GW/0BP8GaJql
   qkHtKWtsEKUhIsDmhl2Ci6gG5G2lRipId0PHcK60Pu0iIZRu+AlVGfuT4
   e1udSvHXbvwO2bAoBofz2MqfdALm9Pf2/yv6usfKIA9hr4u9Twx0anb2l
   c1bFKUfMhnMPH1bR5INkQi8CyXVr2A42eOlyU9yjbaGBz6lwPfgUurLuO
   GTQCzZFy2CTiq0jzKZa3ihkChl4d++GbjsMIqiDxYLnn5F7nQuWU5UDDx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="352217793"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="352217793"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 06:47:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="783083985"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="783083985"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jun 2023 06:47:27 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qFET9-000F05-0O;
        Fri, 30 Jun 2023 13:47:27 +0000
Date:   Fri, 30 Jun 2023 21:46:56 +0800
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
Message-ID: <202306302115.IYBBlrFn-lkp@intel.com>
References: <1688118281-13032-1-git-send-email-quic_vpernami@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1688118281-13032-1-git-send-email-quic_vpernami@quicinc.com>
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
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230630/202306302115.IYBBlrFn-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230630/202306302115.IYBBlrFn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306302115.IYBBlrFn-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/mhi_net.c: In function 'mhi_net_newlink':
>> drivers/net/mhi_net.c:327:37: warning: passing argument 1 of 'eth_random_addr' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     327 |                 eth_random_addr(ndev->dev_addr);
         |                                 ~~~~^~~~~~~~~~
   In file included from drivers/net/mhi_net.c:14:
   include/linux/etherdevice.h:230:40: note: expected 'u8 *' {aka 'unsigned char *'} but argument is of type 'const unsigned char *'
     230 | static inline void eth_random_addr(u8 *addr)
         |                                    ~~~~^~~~


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
