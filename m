Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA946EF98E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbjDZRmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbjDZRmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:42:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718981FDE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 10:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682530969; x=1714066969;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xRcs0B/eRzmEcbNKZvEudSDHNaIPum++FQBk4XtumU8=;
  b=ZLe7+LbFqh8Cs9ZPdidKKNle3YXpNpwD/EkCKzOcsRRLQ/Q7eSXk3B3d
   MrhrwOTyqOUTBtx6Y4tXO+dpqHJcYXHRV0OWoLY3wYdtunPb4HegdYCtP
   qPxj/euXZwBmaGMBG3yC8Vf8niY/QJ84+4j5K2PELunfPRbLzS5m3rHZG
   +pSglYVTbvA0gZ625EoIFcp64dBxRweivfXP6TeYb5mpfQUb/fgn1PCQ/
   bMh1JaYRndUXB9Y/8Ucf4U4vI5/xYT/1yfSYliGWPjWQPMCLbjIlIqxDo
   2izqZ7iX+yBLlA4A3EySTkfQp7ASpsyhMGYpeaFmwbsPaU0lWCtDEjsTY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="326791668"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="326791668"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 10:42:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="1023722535"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="1023722535"
Received: from lkp-server01.sh.intel.com (HELO 041f065c1b1b) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 26 Apr 2023 10:42:47 -0700
Received: from kbuild by 041f065c1b1b with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1prjAE-0000Pa-28;
        Wed, 26 Apr 2023 17:42:46 +0000
Date:   Thu, 27 Apr 2023 01:42:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Justin Stitt <jstitt007@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: drivers/net/ethernet/mediatek/mtk_eth_soc.c:2237:38: sparse: sparse:
 incorrect type in assignment (different base types)
Message-ID: <202304270116.SvhuHUfR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0cfd8703e7da687924371e9bc77a025bdeba9637
commit: d30dfd490f7dc4cb6a7c11a647bd1ff7a22139e7 include/uapi/linux/swab.h: move explicit cast outside ternary
date:   10 months ago
config: alpha-randconfig-s032-20230426 (https://download.01.org/0day-ci/archive/20230427/202304270116.SvhuHUfR-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d30dfd490f7dc4cb6a7c11a647bd1ff7a22139e7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d30dfd490f7dc4cb6a7c11a647bd1ff7a22139e7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha SHELL=/bin/bash drivers/net/ethernet/mediatek/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304270116.SvhuHUfR-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1371:45: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __sum16 [usertype] check @@     got restricted __be16 [usertype] @@
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1371:45: sparse:     expected restricted __sum16 [usertype] check
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1371:45: sparse:     got restricted __be16 [usertype]
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:2132:22: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] ip @@
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:2132:22: sparse:     expected unsigned int [usertype] val
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:2132:22: sparse:     got restricted __be32 [usertype] ip
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:2177:40: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] ip4dst @@
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:2177:40: sparse:     expected unsigned int [usertype] val
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:2177:40: sparse:     got restricted __be32 [usertype] ip4dst
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:2177:40: sparse: sparse: cast from restricted __be32
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:2177:40: sparse: sparse: cast from restricted __be32
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:2177:40: sparse: sparse: cast from restricted __be32
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:2177:40: sparse: sparse: cast from restricted __be32
>> drivers/net/ethernet/mediatek/mtk_eth_soc.c:2237:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] ip4dst @@     got unsigned int [usertype] @@
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:2237:38: sparse:     expected restricted __be32 [usertype] ip4dst
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:2237:38: sparse:     got unsigned int [usertype]
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:2241:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] ip4src @@     got unsigned int @@
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:2241:38: sparse:     expected restricted __be32 [usertype] ip4src
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:2241:38: sparse:     got unsigned int
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:2243:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] psrc @@     got int @@
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:2243:36: sparse:     expected restricted __be16 [usertype] psrc
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:2243:36: sparse:     got int
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:2245:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] pdst @@     got int @@
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:2245:36: sparse:     expected restricted __be16 [usertype] pdst
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:2245:36: sparse:     got int
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:820:9: sparse: sparse: context imbalance in 'mtk_stats_update' - different lock contexts for basic block
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:845:50: sparse: sparse: context imbalance in 'mtk_get_stats64' - wrong count at exit
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:3145:13: sparse: sparse: context imbalance in 'mtk_get_ethtool_stats' - different lock contexts for basic block

vim +2237 drivers/net/ethernet/mediatek/mtk_eth_soc.c

7aab747e5563ec Nelson Chang  2016-09-17  2224  
7aab747e5563ec Nelson Chang  2016-09-17  2225  static int mtk_hwlro_get_fdir_entry(struct net_device *dev,
7aab747e5563ec Nelson Chang  2016-09-17  2226  				    struct ethtool_rxnfc *cmd)
7aab747e5563ec Nelson Chang  2016-09-17  2227  {
7aab747e5563ec Nelson Chang  2016-09-17  2228  	struct mtk_mac *mac = netdev_priv(dev);
7aab747e5563ec Nelson Chang  2016-09-17  2229  	struct ethtool_rx_flow_spec *fsp =
7aab747e5563ec Nelson Chang  2016-09-17  2230  		(struct ethtool_rx_flow_spec *)&cmd->fs;
7aab747e5563ec Nelson Chang  2016-09-17  2231  
e7e7104e2d5ddf Dan Carpenter 2022-05-26  2232  	if (fsp->location >= ARRAY_SIZE(mac->hwlro_ip))
e7e7104e2d5ddf Dan Carpenter 2022-05-26  2233  		return -EINVAL;
e7e7104e2d5ddf Dan Carpenter 2022-05-26  2234  
7aab747e5563ec Nelson Chang  2016-09-17  2235  	/* only tcp dst ipv4 is meaningful, others are meaningless */
7aab747e5563ec Nelson Chang  2016-09-17  2236  	fsp->flow_type = TCP_V4_FLOW;
7aab747e5563ec Nelson Chang  2016-09-17 @2237  	fsp->h_u.tcp_ip4_spec.ip4dst = ntohl(mac->hwlro_ip[fsp->location]);
7aab747e5563ec Nelson Chang  2016-09-17  2238  	fsp->m_u.tcp_ip4_spec.ip4dst = 0;
7aab747e5563ec Nelson Chang  2016-09-17  2239  
7aab747e5563ec Nelson Chang  2016-09-17  2240  	fsp->h_u.tcp_ip4_spec.ip4src = 0;
7aab747e5563ec Nelson Chang  2016-09-17  2241  	fsp->m_u.tcp_ip4_spec.ip4src = 0xffffffff;
7aab747e5563ec Nelson Chang  2016-09-17  2242  	fsp->h_u.tcp_ip4_spec.psrc = 0;
7aab747e5563ec Nelson Chang  2016-09-17  2243  	fsp->m_u.tcp_ip4_spec.psrc = 0xffff;
7aab747e5563ec Nelson Chang  2016-09-17  2244  	fsp->h_u.tcp_ip4_spec.pdst = 0;
7aab747e5563ec Nelson Chang  2016-09-17  2245  	fsp->m_u.tcp_ip4_spec.pdst = 0xffff;
7aab747e5563ec Nelson Chang  2016-09-17  2246  	fsp->h_u.tcp_ip4_spec.tos = 0;
7aab747e5563ec Nelson Chang  2016-09-17  2247  	fsp->m_u.tcp_ip4_spec.tos = 0xff;
7aab747e5563ec Nelson Chang  2016-09-17  2248  
7aab747e5563ec Nelson Chang  2016-09-17  2249  	return 0;
7aab747e5563ec Nelson Chang  2016-09-17  2250  }
7aab747e5563ec Nelson Chang  2016-09-17  2251  

:::::: The code at line 2237 was first introduced by commit
:::::: 7aab747e5563ecbc9f3cb64ddea13fe7b9fee2bd net: ethernet: mediatek: add ethtool functions to configure RX flows of HW LRO

:::::: TO: Nelson Chang <nelson.chang@mediatek.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
