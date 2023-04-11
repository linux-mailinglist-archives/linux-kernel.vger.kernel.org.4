Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C630A6DE3F3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 20:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjDKSdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 14:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjDKSdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 14:33:35 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C00172D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 11:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681238014; x=1712774014;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SL5gzX/bq5eZJotzApGP7ZSuine7/TF6+8YCFeFeHjs=;
  b=EWYdKMc9bJY0hIj9iYv77mvWXtXchytSAdIGUTHbWzRpDvsBNY6gX/wQ
   1RIc+WxVmOIJW6lwPf+jvI3K1fqMdULzt9rRTkaWO6EB3xbprgDhQqUoN
   WPVZS5+N8ZLY1mIrPCeLNmLI1vLspd0WNN5QWAVQysgBqHxF8p4ADGRoD
   HioApEH6tQaSRR79Q+eqtGpUzOmuiXw9MaCgIc8mRWlKY9kw81FxjyJQg
   pbUPM3Pzej6sDPwwHSqa6kyvWf0WX1rveDn1+b48uVZ4PLk3067h+qmud
   zGMTjewOw/iaWAJn4qyHq14SOtDx1gyZDSsBHXNx0qHTQPJ4oT8TEyB8X
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="345492032"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="345492032"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 11:33:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="682178402"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="682178402"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 11 Apr 2023 11:33:23 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmIny-000Wbd-2f;
        Tue, 11 Apr 2023 18:33:22 +0000
Date:   Wed, 12 Apr 2023 02:33:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>
Subject: net/core/netpoll.c:317:9: sparse: sparse: incorrect type in argument
 1 (different address spaces)
Message-ID: <202304120259.7D9gPp1F-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0d3eb744aed40ffce820cded61d7eac515199165
commit: 93a4fa622eb061f75f87f0cf9609ab4e69c67d01 LoongArch: Add STACKTRACE support
date:   8 months ago
config: loongarch-randconfig-s053-20230411 (https://download.01.org/0day-ci/archive/20230412/202304120259.7D9gPp1F-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=93a4fa622eb061f75f87f0cf9609ab4e69c67d01
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 93a4fa622eb061f75f87f0cf9609ab4e69c67d01
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash net/core/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304120259.7D9gPp1F-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/core/netpoll.c:317:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/netpoll.c:317:9: sparse:     expected void *ptr
   net/core/netpoll.c:317:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/netpoll.c:317:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/netpoll.c:317:9: sparse:     expected void *ptr
   net/core/netpoll.c:317:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/netpoll.c:317:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/netpoll.c:317:9: sparse:     expected void *ptr
   net/core/netpoll.c:317:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/netpoll.c:317:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/netpoll.c:317:9: sparse:     expected void *ptr
   net/core/netpoll.c:317:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/netpoll.c:317:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/netpoll.c:317:9: sparse:     expected void *ptr
   net/core/netpoll.c:317:9: sparse:     got int [noderef] __percpu *
>> net/core/netpoll.c:317:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/netpoll.c:317:9: sparse:     expected void *ptr
   net/core/netpoll.c:317:9: sparse:     got int [noderef] __percpu *
>> net/core/netpoll.c:317:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/netpoll.c:317:9: sparse:     expected void *ptr
   net/core/netpoll.c:317:9: sparse:     got int [noderef] __percpu *
>> net/core/netpoll.c:317:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/netpoll.c:317:9: sparse:     expected void *ptr
   net/core/netpoll.c:317:9: sparse:     got int [noderef] __percpu *
   net/core/netpoll.c:348:25: sparse: sparse: context imbalance in '__netpoll_send_skb' - different lock contexts for basic block

vim +317 net/core/netpoll.c

bea3348eef27e6 Stephen Hemminger   2007-10-03  307  
2899656b494dcd Amerigo Wang        2012-08-10  308  /* call with IRQ disabled */
1ddabdfaf70c20 Eric Dumazet        2020-05-07  309  static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
^1da177e4c3f41 Linus Torvalds      2005-04-16  310  {
a54776f2c4939b Yunjian Wang        2020-04-29  311  	netdev_tx_t status = NETDEV_TX_BUSY;
307f660d056b5e Eric Dumazet        2020-05-07  312  	struct net_device *dev;
2bdfe0baeca0e2 Stephen Hemminger   2006-10-26  313  	unsigned long tries;
de85d99eb7b595 Herbert Xu          2010-06-10  314  	/* It is up to the caller to keep npinfo alive. */
2899656b494dcd Amerigo Wang        2012-08-10  315  	struct netpoll_info *npinfo;
f0d3459d072278 Matt Mackall        2005-08-11  316  
af0733937317e1 Frederic Weisbecker 2017-11-06 @317  	lockdep_assert_irqs_disabled();
2899656b494dcd Amerigo Wang        2012-08-10  318  
307f660d056b5e Eric Dumazet        2020-05-07  319  	dev = np->dev;
307f660d056b5e Eric Dumazet        2020-05-07  320  	npinfo = rcu_dereference_bh(dev->npinfo);
307f660d056b5e Eric Dumazet        2020-05-07  321  
2bdfe0baeca0e2 Stephen Hemminger   2006-10-26  322  	if (!npinfo || !netif_running(dev) || !netif_device_present(dev)) {
080b3c19a4ffe4 Eric W. Biederman   2014-03-27  323  		dev_kfree_skb_irq(skb);
1ddabdfaf70c20 Eric Dumazet        2020-05-07  324  		return NET_XMIT_DROP;
^1da177e4c3f41 Linus Torvalds      2005-04-16  325  	}
^1da177e4c3f41 Linus Torvalds      2005-04-16  326  
2bdfe0baeca0e2 Stephen Hemminger   2006-10-26  327  	/* don't get messages out of order, and no recursion */
bea3348eef27e6 Stephen Hemminger   2007-10-03  328  	if (skb_queue_len(&npinfo->txq) == 0 && !netpoll_owner_active(dev)) {
fd2ea0a79faad8 David S. Miller     2008-07-17  329  		struct netdev_queue *txq;
a49f99ffca57a2 Andrew Morton       2006-12-11  330  
4bd97d51a5e602 Paolo Abeni         2019-03-20  331  		txq = netdev_core_pick_tx(dev, skb, NULL);
fd2ea0a79faad8 David S. Miller     2008-07-17  332  
2bdfe0baeca0e2 Stephen Hemminger   2006-10-26  333  		/* try until next clock tick */
e37b8d931936f8 Andrew Morton       2006-12-09  334  		for (tries = jiffies_to_usecs(1)/USEC_PER_POLL;
e37b8d931936f8 Andrew Morton       2006-12-09  335  		     tries > 0; --tries) {
5efeac44cfca62 Eric W. Biederman   2014-03-27  336  			if (HARD_TX_TRYLOCK(dev, txq)) {
944e294857033d Eric W. Biederman   2014-03-27  337  				if (!netif_xmit_stopped(txq))
944e294857033d Eric W. Biederman   2014-03-27  338  					status = netpoll_start_xmit(skb, dev, txq);
689971b4461388 Amerigo Wang        2012-08-10  339  
5efeac44cfca62 Eric W. Biederman   2014-03-27  340  				HARD_TX_UNLOCK(dev, txq);
^1da177e4c3f41 Linus Torvalds      2005-04-16  341  
2c1644cf6d46a8 Feng Sun            2019-08-26  342  				if (dev_xmit_complete(status))
2bdfe0baeca0e2 Stephen Hemminger   2006-10-26  343  					break;
8834807b43200b Jeremy Fitzhardinge 2006-06-26  344  
0db3dc73f7a3a7 Stephen Hemminger   2007-06-27  345  			}
0db3dc73f7a3a7 Stephen Hemminger   2007-06-27  346  
2bdfe0baeca0e2 Stephen Hemminger   2006-10-26  347  			/* tickle device maybe there is some cleanup */
2a49e001cbe3eb Joe Perches         2011-06-30  348  			netpoll_poll_dev(np->dev);
^1da177e4c3f41 Linus Torvalds      2005-04-16  349  
2bdfe0baeca0e2 Stephen Hemminger   2006-10-26  350  			udelay(USEC_PER_POLL);
2bdfe0baeca0e2 Stephen Hemminger   2006-10-26  351  		}
79b1bee888d43b Dongdong Deng       2009-08-21  352  
79b1bee888d43b Dongdong Deng       2009-08-21  353  		WARN_ONCE(!irqs_disabled(),
d75f773c86a2b8 Sakari Ailus        2019-03-25  354  			"netpoll_send_skb_on_dev(): %s enabled interrupts in poll (%pS)\n",
944e294857033d Eric W. Biederman   2014-03-27  355  			dev->name, dev->netdev_ops->ndo_start_xmit);
79b1bee888d43b Dongdong Deng       2009-08-21  356  
e37b8d931936f8 Andrew Morton       2006-12-09  357  	}
f0d3459d072278 Matt Mackall        2005-08-11  358  
2c1644cf6d46a8 Feng Sun            2019-08-26  359  	if (!dev_xmit_complete(status)) {
5de4a473bda495 Stephen Hemminger   2006-10-26  360  		skb_queue_tail(&npinfo->txq, skb);
4c1ac1b49122b8 David Howells       2006-12-05  361  		schedule_delayed_work(&npinfo->tx_work,0);
2bdfe0baeca0e2 Stephen Hemminger   2006-10-26  362  	}
1ddabdfaf70c20 Eric Dumazet        2020-05-07  363  	return NETDEV_TX_OK;
^1da177e4c3f41 Linus Torvalds      2005-04-16  364  }
fb1eee476b0d3b Eric Dumazet        2020-05-07  365  

:::::: The code at line 317 was first introduced by commit
:::::: af0733937317e1e03b60f3af8cf9cd59d665593c netpoll: Use lockdep to assert IRQs are disabled/enabled

:::::: TO: Frederic Weisbecker <frederic@kernel.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
