Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838C872B086
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 08:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjFKGpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 02:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjFKGpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 02:45:00 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B311B1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 23:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686465894; x=1718001894;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MZzwMU5cIxlAG1eT20H1qMNgz7pD3qFfAlbYVbyQulw=;
  b=PDdo+NZkquzlOaftqAlRjK6Dn9e2604yqpsKim3o8ZEBUZw4cn8Mkc4Z
   LFuom9Ef0WIgAh6V/h2Xbkw/ScXSByfYeHxFiMmkDs5xbqvEwtlw5/MJz
   07ZX3z3pn+7ljEpdrWs1VT7khImkoBcR/c2c4wEpfMbzf0yFXa2cPtIrU
   4rvsyLLXcaWNDGVT7SVMgo4KgYFLytLDz1sJXJ48UoECGIhB8w1PSBGfF
   bWhTcUZBO246w5xgK3AtlG0rAa033xWv641AMjGKpAEJI0IS1c5afCXb6
   C2958gZMF0PKzT7/GvWbTk+AxRY0xRkdDP7/u4uJfQM73LTEoMQ+LpeO2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="360318028"
X-IronPort-AV: E=Sophos;i="6.00,234,1681196400"; 
   d="scan'208";a="360318028"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2023 23:44:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="885037456"
X-IronPort-AV: E=Sophos;i="6.00,234,1681196400"; 
   d="scan'208";a="885037456"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 10 Jun 2023 23:44:52 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q8Eom-000Ahi-0P;
        Sun, 11 Jun 2023 06:44:52 +0000
Date:   Sun, 11 Jun 2023 14:44:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/mellanox/mlx5/core/en/qos.c:364:40: sparse:
 sparse: incorrect type in initializer (different address spaces)
Message-ID: <202306111427.LOLym1UT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   022ce8862dff83c859089cd14bc4dca0733e2f90
commit: d636fc5dd692c8f4e00ae6e0359c0eceeb5d9bdb net: sched: add rcu annotations around qdisc->qdisc_sleeping
date:   4 days ago
config: parisc-randconfig-s032-20230611 (https://download.01.org/0day-ci/archive/20230611/202306111427.LOLym1UT-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.3.0
reproduce:
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d636fc5dd692c8f4e00ae6e0359c0eceeb5d9bdb
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d636fc5dd692c8f4e00ae6e0359c0eceeb5d9bdb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc SHELL=/bin/bash drivers/net/ethernet/mellanox/mlx5/core/ kernel/rcu/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306111427.LOLym1UT-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/mellanox/mlx5/core/en/qos.c:364:40: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct Qdisc *qdisc @@     got struct Qdisc [noderef] __rcu *qdisc_sleeping @@
   drivers/net/ethernet/mellanox/mlx5/core/en/qos.c:364:40: sparse:     expected struct Qdisc *qdisc
   drivers/net/ethernet/mellanox/mlx5/core/en/qos.c:364:40: sparse:     got struct Qdisc [noderef] __rcu *qdisc_sleeping

vim +364 drivers/net/ethernet/mellanox/mlx5/core/en/qos.c

214baf22870cfa Maxim Mikityanskiy 2021-01-19  360  
462b0059993696 Moshe Tal          2022-05-02  361  void mlx5e_reset_qdisc(struct net_device *dev, u16 qid)
214baf22870cfa Maxim Mikityanskiy 2021-01-19  362  {
214baf22870cfa Maxim Mikityanskiy 2021-01-19  363  	struct netdev_queue *dev_queue = netdev_get_tx_queue(dev, qid);
214baf22870cfa Maxim Mikityanskiy 2021-01-19 @364  	struct Qdisc *qdisc = dev_queue->qdisc_sleeping;
214baf22870cfa Maxim Mikityanskiy 2021-01-19  365  
214baf22870cfa Maxim Mikityanskiy 2021-01-19  366  	if (!qdisc)
214baf22870cfa Maxim Mikityanskiy 2021-01-19  367  		return;
214baf22870cfa Maxim Mikityanskiy 2021-01-19  368  
214baf22870cfa Maxim Mikityanskiy 2021-01-19  369  	spin_lock_bh(qdisc_lock(qdisc));
214baf22870cfa Maxim Mikityanskiy 2021-01-19  370  	qdisc_reset(qdisc);
214baf22870cfa Maxim Mikityanskiy 2021-01-19  371  	spin_unlock_bh(qdisc_lock(qdisc));
214baf22870cfa Maxim Mikityanskiy 2021-01-19  372  }
214baf22870cfa Maxim Mikityanskiy 2021-01-19  373  

:::::: The code at line 364 was first introduced by commit
:::::: 214baf22870cfa437522f3bd4fbae56338674b04 net/mlx5e: Support HTB offload

:::::: TO: Maxim Mikityanskiy <maximmi@mellanox.com>
:::::: CC: Jakub Kicinski <kuba@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
