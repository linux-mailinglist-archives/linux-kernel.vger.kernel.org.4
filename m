Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADE06868CE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 15:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjBAOrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 09:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjBAOre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:47:34 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529292E80B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 06:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675262852; x=1706798852;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=e6pBa2geDJARtq4Dyyl5CQ8d74kBZf8Ahyqg/pfx6R4=;
  b=Js/0p+cACPPqaVglGipkImSJTjpzeL2jXt/qj6QFBR7bBaq5jpfI4wrt
   YC126Q5q9RXLEC8GAgUKO0h5YzCaEELm8PfDQ/qE2pUdS/rGFZHRvIKxW
   81sVeY722Yb2DLVqG3L82XXqoEo3SBlEWvSkL8u6sSyXC2pdboC9wIJQo
   MxR3TV8qRPUfk2Uh9a7qEs2Cy72kaP62hSPGOho4arDaRtLRR6qwOeXtG
   1jAFEY/9ClFkHt/vdLnktozADd94LWs68UM9nqXdM0Rew0Wgbqr/aR/br
   Uci4IjFqKQ93qiiorrOqSclyxP2kZx4nGv4s4MJfmdfNBv4/7zjFE9ABU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="414366717"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="414366717"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 06:47:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="838804789"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="838804789"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Feb 2023 06:47:30 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNEOX-0005Vc-1g;
        Wed, 01 Feb 2023 14:47:29 +0000
Date:   Wed, 1 Feb 2023 22:47:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: drivers/net/ethernet/adaptec/starfire.c:1831:41: sparse: sparse:
 incorrect type in argument 1 (different base types)
Message-ID: <202302012215.YjNBuRBU-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c0b67534c95c537f7a506a06b98e5e85d72e2b7d
commit: 548927e0312194167f7ee5de47d50c2036088cce arm64: io: Use asm-generic high level MMIO accessors
date:   8 months ago
config: arm64-randconfig-s042-20230201 (https://download.01.org/0day-ci/archive/20230201/202302012215.YjNBuRBU-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=548927e0312194167f7ee5de47d50c2036088cce
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 548927e0312194167f7ee5de47d50c2036088cce
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/net/ethernet/adaptec/ drivers/pci/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   drivers/net/ethernet/adaptec/starfire.c:1515:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __wsum [usertype] csum @@     got unsigned short [usertype] @@
   drivers/net/ethernet/adaptec/starfire.c:1515:35: sparse:     expected restricted __wsum [usertype] csum
   drivers/net/ethernet/adaptec/starfire.c:1515:35: sparse:     got unsigned short [usertype]
>> drivers/net/ethernet/adaptec/starfire.c:1831:41: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 @@
   drivers/net/ethernet/adaptec/starfire.c:1831:41: sparse:     expected unsigned short [usertype] value
   drivers/net/ethernet/adaptec/starfire.c:1831:41: sparse:     got restricted __le16

vim +1831 drivers/net/ethernet/adaptec/starfire.c

5da96be53a16a6 drivers/net/starfire.c                  Jiri Pirko     2011-07-20  1782  
^1da177e4c3f41 drivers/net/starfire.c                  Linus Torvalds 2005-04-16  1783  	if (dev->flags & IFF_PROMISC) {	/* Set promiscuous. */
^1da177e4c3f41 drivers/net/starfire.c                  Linus Torvalds 2005-04-16  1784  		rx_mode |= AcceptAll;
4cd24eaf0c6ee7 drivers/net/starfire.c                  Jiri Pirko     2010-02-08  1785  	} else if ((netdev_mc_count(dev) > multicast_filter_limit) ||
8e95a2026f3b43 drivers/net/starfire.c                  Joe Perches    2009-12-03  1786  		   (dev->flags & IFF_ALLMULTI)) {
^1da177e4c3f41 drivers/net/starfire.c                  Linus Torvalds 2005-04-16  1787  		/* Too many to match, or accept all multicasts. */
^1da177e4c3f41 drivers/net/starfire.c                  Linus Torvalds 2005-04-16  1788  		rx_mode |= AcceptBroadcast|AcceptAllMulticast|PerfectFilter;
4cd24eaf0c6ee7 drivers/net/starfire.c                  Jiri Pirko     2010-02-08  1789  	} else if (netdev_mc_count(dev) <= 14) {
^1da177e4c3f41 drivers/net/starfire.c                  Linus Torvalds 2005-04-16  1790  		/* Use the 16 element perfect filter, skip first two entries. */
^1da177e4c3f41 drivers/net/starfire.c                  Linus Torvalds 2005-04-16  1791  		void __iomem *filter_addr = ioaddr + PerfFilterTable + 2 * 16;
766607570becbd drivers/net/ethernet/adaptec/starfire.c Jakub Kicinski 2021-10-14  1792  		const __be16 *eaddrs;
22bedad3ce112d drivers/net/starfire.c                  Jiri Pirko     2010-04-01  1793  		netdev_for_each_mc_addr(ha, dev) {
22bedad3ce112d drivers/net/starfire.c                  Jiri Pirko     2010-04-01  1794  			eaddrs = (__be16 *) ha->addr;
88b1943bd3e4d2 drivers/net/starfire.c                  Al Viro        2007-08-23  1795  			writew(be16_to_cpu(eaddrs[2]), filter_addr); filter_addr += 4;
88b1943bd3e4d2 drivers/net/starfire.c                  Al Viro        2007-08-23  1796  			writew(be16_to_cpu(eaddrs[1]), filter_addr); filter_addr += 4;
88b1943bd3e4d2 drivers/net/starfire.c                  Al Viro        2007-08-23  1797  			writew(be16_to_cpu(eaddrs[0]), filter_addr); filter_addr += 8;
^1da177e4c3f41 drivers/net/starfire.c                  Linus Torvalds 2005-04-16  1798  		}
766607570becbd drivers/net/ethernet/adaptec/starfire.c Jakub Kicinski 2021-10-14  1799  		eaddrs = (const __be16 *)dev->dev_addr;
5508590c193661 drivers/net/starfire.c                  Jiri Pirko     2010-02-18  1800  		i = netdev_mc_count(dev) + 2;
^1da177e4c3f41 drivers/net/starfire.c                  Linus Torvalds 2005-04-16  1801  		while (i++ < 16) {
88b1943bd3e4d2 drivers/net/starfire.c                  Al Viro        2007-08-23  1802  			writew(be16_to_cpu(eaddrs[0]), filter_addr); filter_addr += 4;
88b1943bd3e4d2 drivers/net/starfire.c                  Al Viro        2007-08-23  1803  			writew(be16_to_cpu(eaddrs[1]), filter_addr); filter_addr += 4;
88b1943bd3e4d2 drivers/net/starfire.c                  Al Viro        2007-08-23  1804  			writew(be16_to_cpu(eaddrs[2]), filter_addr); filter_addr += 8;
^1da177e4c3f41 drivers/net/starfire.c                  Linus Torvalds 2005-04-16  1805  		}
^1da177e4c3f41 drivers/net/starfire.c                  Linus Torvalds 2005-04-16  1806  		rx_mode |= AcceptBroadcast|PerfectFilter;
^1da177e4c3f41 drivers/net/starfire.c                  Linus Torvalds 2005-04-16  1807  	} else {
^1da177e4c3f41 drivers/net/starfire.c                  Linus Torvalds 2005-04-16  1808  		/* Must use a multicast hash table. */
^1da177e4c3f41 drivers/net/starfire.c                  Linus Torvalds 2005-04-16  1809  		void __iomem *filter_addr;
766607570becbd drivers/net/ethernet/adaptec/starfire.c Jakub Kicinski 2021-10-14  1810  		const __be16 *eaddrs;
88b1943bd3e4d2 drivers/net/starfire.c                  Al Viro        2007-08-23  1811  		__le16 mc_filter[32] __attribute__ ((aligned(sizeof(long))));	/* Multicast hash filter */
^1da177e4c3f41 drivers/net/starfire.c                  Linus Torvalds 2005-04-16  1812  
^1da177e4c3f41 drivers/net/starfire.c                  Linus Torvalds 2005-04-16  1813  		memset(mc_filter, 0, sizeof(mc_filter));
22bedad3ce112d drivers/net/starfire.c                  Jiri Pirko     2010-04-01  1814  		netdev_for_each_mc_addr(ha, dev) {
fdecea66687d76 drivers/net/starfire.c                  Jeff Garzik    2005-05-12  1815  			/* The chip uses the upper 9 CRC bits
fdecea66687d76 drivers/net/starfire.c                  Jeff Garzik    2005-05-12  1816  			   as index into the hash table */
22bedad3ce112d drivers/net/starfire.c                  Jiri Pirko     2010-04-01  1817  			int bit_nr = ether_crc_le(ETH_ALEN, ha->addr) >> 23;
88b1943bd3e4d2 drivers/net/starfire.c                  Al Viro        2007-08-23  1818  			__le32 *fptr = (__le32 *) &mc_filter[(bit_nr >> 4) & ~1];
^1da177e4c3f41 drivers/net/starfire.c                  Linus Torvalds 2005-04-16  1819  
^1da177e4c3f41 drivers/net/starfire.c                  Linus Torvalds 2005-04-16  1820  			*fptr |= cpu_to_le32(1 << (bit_nr & 31));
^1da177e4c3f41 drivers/net/starfire.c                  Linus Torvalds 2005-04-16  1821  		}
^1da177e4c3f41 drivers/net/starfire.c                  Linus Torvalds 2005-04-16  1822  		/* Clear the perfect filter list, skip first two entries. */
^1da177e4c3f41 drivers/net/starfire.c                  Linus Torvalds 2005-04-16  1823  		filter_addr = ioaddr + PerfFilterTable + 2 * 16;
766607570becbd drivers/net/ethernet/adaptec/starfire.c Jakub Kicinski 2021-10-14  1824  		eaddrs = (const __be16 *)dev->dev_addr;
^1da177e4c3f41 drivers/net/starfire.c                  Linus Torvalds 2005-04-16  1825  		for (i = 2; i < 16; i++) {
88b1943bd3e4d2 drivers/net/starfire.c                  Al Viro        2007-08-23  1826  			writew(be16_to_cpu(eaddrs[0]), filter_addr); filter_addr += 4;
88b1943bd3e4d2 drivers/net/starfire.c                  Al Viro        2007-08-23  1827  			writew(be16_to_cpu(eaddrs[1]), filter_addr); filter_addr += 4;
88b1943bd3e4d2 drivers/net/starfire.c                  Al Viro        2007-08-23  1828  			writew(be16_to_cpu(eaddrs[2]), filter_addr); filter_addr += 8;
^1da177e4c3f41 drivers/net/starfire.c                  Linus Torvalds 2005-04-16  1829  		}
^1da177e4c3f41 drivers/net/starfire.c                  Linus Torvalds 2005-04-16  1830  		for (filter_addr = ioaddr + HashTable, i = 0; i < 32; filter_addr+= 16, i++)
^1da177e4c3f41 drivers/net/starfire.c                  Linus Torvalds 2005-04-16 @1831  			writew(mc_filter[i], filter_addr);
^1da177e4c3f41 drivers/net/starfire.c                  Linus Torvalds 2005-04-16  1832  		rx_mode |= AcceptBroadcast|PerfectFilter|HashFilter;
^1da177e4c3f41 drivers/net/starfire.c                  Linus Torvalds 2005-04-16  1833  	}
^1da177e4c3f41 drivers/net/starfire.c                  Linus Torvalds 2005-04-16  1834  	writel(rx_mode, ioaddr + RxFilterMode);
^1da177e4c3f41 drivers/net/starfire.c                  Linus Torvalds 2005-04-16  1835  }
^1da177e4c3f41 drivers/net/starfire.c                  Linus Torvalds 2005-04-16  1836  

:::::: The code at line 1831 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
