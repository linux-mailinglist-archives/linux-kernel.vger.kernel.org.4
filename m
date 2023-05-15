Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCAB702C2C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241735AbjEOMCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241731AbjEOMCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:02:33 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D78D2120
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684152042; x=1715688042;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IcWTA5yQzxTi8fAfRyfAwYBO6PgI8sfmiZgt4T9AoHc=;
  b=DdF/yeUJB/2WDb0RFz6O3TjWFXL2J8oRRN3Kd6J4BT0Sd/21U/S553GP
   IbSr/Ob/AEKer5Zhjhbi8/AHfSOPbdw7Aa+Apb/4me5W2KVHQPyJSz0WS
   lFxgq75bamvC0XCHCZeaeU6PZSTMg2JF+VUH5Pg+3wTANWZtHuoBbDdES
   EB0aFy/FqBflDITwRgS3KThdGRlfIO8A28hAk1Ya9p00trRm2tdSk97Wh
   dCQmQKjX3S69Qvpe+rO9IasBZt1v2CMqgMTCCX74lk7Z3MQntzJ9adteF
   40fbSVXElDPVhG0ZnMRMDxD0oFb/RHihXhv2LMpDiWjSqhHZlHPyu0KyN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="350019512"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="350019512"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 05:00:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="790622965"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="790622965"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 15 May 2023 05:00:13 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pyWs8-0006Ks-39;
        Mon, 15 May 2023 12:00:12 +0000
Date:   Mon, 15 May 2023 19:59:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vineet Gupta <vgupta@kernel.org>
Subject: drivers/net/ethernet/marvell/mv643xx_eth.c:1994:28: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202305151918.9gC99599-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
commit: c44f15c1c09481d50fd33478ebb5b8284f8f5edb arc: iounmap() arg is volatile
date:   7 months ago
config: arc-randconfig-s043-20230515 (https://download.01.org/0day-ci/archive/20230515/202305151918.9gC99599-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c44f15c1c09481d50fd33478ebb5b8284f8f5edb
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c44f15c1c09481d50fd33478ebb5b8284f8f5edb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash drivers/net/ethernet/marvell/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305151918.9gC99599-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/net/ethernet/marvell/mv643xx_eth.c:1955:35: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct rx_desc *rx_desc_area @@     got void [noderef] __iomem * @@
   drivers/net/ethernet/marvell/mv643xx_eth.c:1955:35: sparse:     expected struct rx_desc *rx_desc_area
   drivers/net/ethernet/marvell/mv643xx_eth.c:1955:35: sparse:     got void [noderef] __iomem *
>> drivers/net/ethernet/marvell/mv643xx_eth.c:1994:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got struct rx_desc *rx_desc_area @@
   drivers/net/ethernet/marvell/mv643xx_eth.c:1994:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/marvell/mv643xx_eth.c:1994:28: sparse:     got struct rx_desc *rx_desc_area
   drivers/net/ethernet/marvell/mv643xx_eth.c:2025:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got struct rx_desc *rx_desc_area @@
   drivers/net/ethernet/marvell/mv643xx_eth.c:2025:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/marvell/mv643xx_eth.c:2025:28: sparse:     got struct rx_desc *rx_desc_area
   drivers/net/ethernet/marvell/mv643xx_eth.c:2059:35: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct tx_desc *tx_desc_area @@     got void [noderef] __iomem * @@
   drivers/net/ethernet/marvell/mv643xx_eth.c:2059:35: sparse:     expected struct tx_desc *tx_desc_area
   drivers/net/ethernet/marvell/mv643xx_eth.c:2059:35: sparse:     got void [noderef] __iomem *
>> drivers/net/ethernet/marvell/mv643xx_eth.c:2114:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got struct tx_desc *tx_desc_area @@
   drivers/net/ethernet/marvell/mv643xx_eth.c:2114:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/marvell/mv643xx_eth.c:2114:28: sparse:     got struct tx_desc *tx_desc_area
   drivers/net/ethernet/marvell/mv643xx_eth.c:2132:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got struct tx_desc *tx_desc_area @@
   drivers/net/ethernet/marvell/mv643xx_eth.c:2132:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/marvell/mv643xx_eth.c:2132:28: sparse:     got struct tx_desc *tx_desc_area

vim +1994 drivers/net/ethernet/marvell/mv643xx_eth.c

d0412d967032b9 drivers/net/mv643xx_eth.c                  James Chapman     2006-01-27  1934  
c9df406f313826 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1935  
c9df406f313826 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1936  /* rx/tx queue initialisation ***********************************************/
64da80a29c7455 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-02  1937  static int rxq_init(struct mv643xx_eth_private *mp, int index)
^1da177e4c3f41 drivers/net/mv643xx_eth.c                  Linus Torvalds    2005-04-16  1938  {
64da80a29c7455 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-02  1939  	struct rx_queue *rxq = mp->rxq + index;
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1940  	struct rx_desc *rx_desc;
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1941  	int size;
c9df406f313826 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1942  	int i;
^1da177e4c3f41 drivers/net/mv643xx_eth.c                  Linus Torvalds    2005-04-16  1943  
64da80a29c7455 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-02  1944  	rxq->index = index;
64da80a29c7455 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-02  1945  
e7d2f4dbd9224b drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2009-02-12  1946  	rxq->rx_ring_size = mp->rx_ring_size;
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1947  
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1948  	rxq->rx_desc_count = 0;
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1949  	rxq->rx_curr_desc = 0;
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1950  	rxq->rx_used_desc = 0;
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1951  
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1952  	size = rxq->rx_ring_size * sizeof(struct rx_desc);
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1953  
f7981c1c67b53a drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-08-26  1954  	if (index == 0 && size <= mp->rx_desc_sram_size) {
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1955  		rxq->rx_desc_area = ioremap(mp->rx_desc_sram_addr,
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1956  						mp->rx_desc_sram_size);
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1957  		rxq->rx_desc_dma = mp->rx_desc_sram_addr;
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1958  	} else {
eb0519b5a1cf07 drivers/net/mv643xx_eth.c                  Gabriel Paubert   2009-05-17  1959  		rxq->rx_desc_area = dma_alloc_coherent(mp->dev->dev.parent,
eb0519b5a1cf07 drivers/net/mv643xx_eth.c                  Gabriel Paubert   2009-05-17  1960  						       size, &rxq->rx_desc_dma,
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1961  						       GFP_KERNEL);
84dd619e4dc3b0 drivers/net/mv643xx_eth.c                  Dale Farnsworth   2007-03-03  1962  	}
84dd619e4dc3b0 drivers/net/mv643xx_eth.c                  Dale Farnsworth   2007-03-03  1963  
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1964  	if (rxq->rx_desc_area == NULL) {
7542db8b1cb88a drivers/net/mv643xx_eth.c                  Joe Perches       2011-03-02  1965  		netdev_err(mp->dev,
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1966  			   "can't allocate rx ring (%d bytes)\n", size);
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1967  		goto out;
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1968  	}
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1969  	memset(rxq->rx_desc_area, 0, size);
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1970  
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1971  	rxq->rx_desc_area_size = size;
9fa8e980bb0a56 drivers/net/ethernet/marvell/mv643xx_eth.c Lubomir Rintel    2013-06-18  1972  	rxq->rx_skb = kcalloc(rxq->rx_ring_size, sizeof(*rxq->rx_skb),
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1973  				    GFP_KERNEL);
b2adaca92c63b9 drivers/net/ethernet/marvell/mv643xx_eth.c Joe Perches       2013-02-03  1974  	if (rxq->rx_skb == NULL)
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1975  		goto out_free;
c9df406f313826 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1976  
6469933605a3ec drivers/net/ethernet/marvell/mv643xx_eth.c Joe Perches       2012-06-04  1977  	rx_desc = rxq->rx_desc_area;
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1978  	for (i = 0; i < rxq->rx_ring_size; i++) {
9da7874575468a drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-08-23  1979  		int nexti;
9da7874575468a drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-08-23  1980  
9da7874575468a drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-08-23  1981  		nexti = i + 1;
9da7874575468a drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-08-23  1982  		if (nexti == rxq->rx_ring_size)
9da7874575468a drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-08-23  1983  			nexti = 0;
9da7874575468a drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-08-23  1984  
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1985  		rx_desc[i].next_desc_ptr = rxq->rx_desc_dma +
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1986  					nexti * sizeof(struct rx_desc);
fa3959f457109c drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-04-24  1987  	}
fa3959f457109c drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-04-24  1988  
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1989  	return 0;
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1990  
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1991  
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1992  out_free:
f7981c1c67b53a drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-08-26  1993  	if (index == 0 && size <= mp->rx_desc_sram_size)
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01 @1994  		iounmap(rxq->rx_desc_area);
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1995  	else
eb0519b5a1cf07 drivers/net/mv643xx_eth.c                  Gabriel Paubert   2009-05-17  1996  		dma_free_coherent(mp->dev->dev.parent, size,
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1997  				  rxq->rx_desc_area,
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1998  				  rxq->rx_desc_dma);
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  1999  
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2000  out:
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2001  	return -ENOMEM;
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2002  }
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2003  
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2004  static void rxq_deinit(struct rx_queue *rxq)
c9df406f313826 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2005  {
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2006  	struct mv643xx_eth_private *mp = rxq_to_mp(rxq);
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2007  	int i;
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2008  
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2009  	rxq_disable(rxq);
^1da177e4c3f41 drivers/net/mv643xx_eth.c                  Linus Torvalds    2005-04-16  2010  
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2011  	for (i = 0; i < rxq->rx_ring_size; i++) {
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2012  		if (rxq->rx_skb[i]) {
43cee2d2465cab drivers/net/ethernet/marvell/mv643xx_eth.c Florian Fainelli  2017-08-24  2013  			dev_consume_skb_any(rxq->rx_skb[i]);
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2014  			rxq->rx_desc_count--;
c9df406f313826 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2015  		}
c9df406f313826 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2016  	}
^1da177e4c3f41 drivers/net/mv643xx_eth.c                  Linus Torvalds    2005-04-16  2017  
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2018  	if (rxq->rx_desc_count) {
7542db8b1cb88a drivers/net/mv643xx_eth.c                  Joe Perches       2011-03-02  2019  		netdev_err(mp->dev, "error freeing rx ring -- %d skbs stuck\n",
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2020  			   rxq->rx_desc_count);
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2021  	}
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2022  
f7981c1c67b53a drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-08-26  2023  	if (rxq->index == 0 &&
64da80a29c7455 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-02  2024  	    rxq->rx_desc_area_size <= mp->rx_desc_sram_size)
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2025  		iounmap(rxq->rx_desc_area);
c9df406f313826 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2026  	else
eb0519b5a1cf07 drivers/net/mv643xx_eth.c                  Gabriel Paubert   2009-05-17  2027  		dma_free_coherent(mp->dev->dev.parent, rxq->rx_desc_area_size,
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2028  				  rxq->rx_desc_area, rxq->rx_desc_dma);
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2029  
8a578111e34335 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2030  	kfree(rxq->rx_skb);
c9df406f313826 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2031  }
^1da177e4c3f41 drivers/net/mv643xx_eth.c                  Linus Torvalds    2005-04-16  2032  
3d6b35bc5090cf drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-02  2033  static int txq_init(struct mv643xx_eth_private *mp, int index)
c9df406f313826 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2034  {
3d6b35bc5090cf drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-02  2035  	struct tx_queue *txq = mp->txq + index;
13d6428538feae drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2036  	struct tx_desc *tx_desc;
13d6428538feae drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2037  	int size;
9e911414af8caf drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2015-01-22  2038  	int ret;
c9df406f313826 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2039  	int i;
^1da177e4c3f41 drivers/net/mv643xx_eth.c                  Linus Torvalds    2005-04-16  2040  
3d6b35bc5090cf drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-02  2041  	txq->index = index;
3d6b35bc5090cf drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-02  2042  
e7d2f4dbd9224b drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2009-02-12  2043  	txq->tx_ring_size = mp->tx_ring_size;
13d6428538feae drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2044  
ee9e49561bdd6d drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2014-05-30  2045  	/* A queue must always have room for at least one skb.
ee9e49561bdd6d drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2014-05-30  2046  	 * Therefore, stop the queue when the free entries reaches
ee9e49561bdd6d drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2014-05-30  2047  	 * the maximum number of descriptors per skb.
ee9e49561bdd6d drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2014-05-30  2048  	 */
ee9e49561bdd6d drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2014-05-30  2049  	txq->tx_stop_threshold = txq->tx_ring_size - MV643XX_MAX_SKB_DESCS;
ee9e49561bdd6d drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2014-05-30  2050  	txq->tx_wake_threshold = txq->tx_stop_threshold / 2;
ee9e49561bdd6d drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2014-05-30  2051  
13d6428538feae drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2052  	txq->tx_desc_count = 0;
13d6428538feae drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2053  	txq->tx_curr_desc = 0;
13d6428538feae drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2054  	txq->tx_used_desc = 0;
13d6428538feae drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2055  
13d6428538feae drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2056  	size = txq->tx_ring_size * sizeof(struct tx_desc);
13d6428538feae drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2057  
f7981c1c67b53a drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-08-26  2058  	if (index == 0 && size <= mp->tx_desc_sram_size) {
13d6428538feae drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2059  		txq->tx_desc_area = ioremap(mp->tx_desc_sram_addr,
13d6428538feae drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2060  						mp->tx_desc_sram_size);
13d6428538feae drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2061  		txq->tx_desc_dma = mp->tx_desc_sram_addr;
13d6428538feae drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2062  	} else {
eb0519b5a1cf07 drivers/net/mv643xx_eth.c                  Gabriel Paubert   2009-05-17  2063  		txq->tx_desc_area = dma_alloc_coherent(mp->dev->dev.parent,
eb0519b5a1cf07 drivers/net/mv643xx_eth.c                  Gabriel Paubert   2009-05-17  2064  						       size, &txq->tx_desc_dma,
13d6428538feae drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2065  						       GFP_KERNEL);
13d6428538feae drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2066  	}
13d6428538feae drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2067  
13d6428538feae drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2068  	if (txq->tx_desc_area == NULL) {
7542db8b1cb88a drivers/net/mv643xx_eth.c                  Joe Perches       2011-03-02  2069  		netdev_err(mp->dev,
13d6428538feae drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2070  			   "can't allocate tx ring (%d bytes)\n", size);
99ab08e091df65 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-08-28  2071  		return -ENOMEM;
c9df406f313826 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2072  	}
13d6428538feae drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2073  	memset(txq->tx_desc_area, 0, size);
^1da177e4c3f41 drivers/net/mv643xx_eth.c                  Linus Torvalds    2005-04-16  2074  
13d6428538feae drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2075  	txq->tx_desc_area_size = size;
63c9e549148fb9 drivers/net/mv643xx_eth.c                  Dale Farnsworth   2005-09-02  2076  
6469933605a3ec drivers/net/ethernet/marvell/mv643xx_eth.c Joe Perches       2012-06-04  2077  	tx_desc = txq->tx_desc_area;
13d6428538feae drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2078  	for (i = 0; i < txq->tx_ring_size; i++) {
6b368f6859c803 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-07-11  2079  		struct tx_desc *txd = tx_desc + i;
9da7874575468a drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-08-23  2080  		int nexti;
9da7874575468a drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-08-23  2081  
9da7874575468a drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-08-23  2082  		nexti = i + 1;
9da7874575468a drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-08-23  2083  		if (nexti == txq->tx_ring_size)
9da7874575468a drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-08-23  2084  			nexti = 0;
6b368f6859c803 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-07-11  2085  
6b368f6859c803 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-07-11  2086  		txd->cmd_sts = 0;
6b368f6859c803 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-07-11  2087  		txd->next_desc_ptr = txq->tx_desc_dma +
13d6428538feae drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2088  					nexti * sizeof(struct tx_desc);
c9df406f313826 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2089  	}
^1da177e4c3f41 drivers/net/mv643xx_eth.c                  Linus Torvalds    2005-04-16  2090  
9e911414af8caf drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2015-01-22  2091  	txq->tx_desc_mapping = kcalloc(txq->tx_ring_size, sizeof(char),
9e911414af8caf drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2015-01-22  2092  				       GFP_KERNEL);
9e911414af8caf drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2015-01-22  2093  	if (!txq->tx_desc_mapping) {
9e911414af8caf drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2015-01-22  2094  		ret = -ENOMEM;
9e911414af8caf drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2015-01-22  2095  		goto err_free_desc_area;
9e911414af8caf drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2015-01-22  2096  	}
9e911414af8caf drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2015-01-22  2097  
3ae8f4e0b98b64 drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2014-05-19  2098  	/* Allocate DMA buffers for TSO MAC/IP/TCP headers */
3ae8f4e0b98b64 drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2014-05-19  2099  	txq->tso_hdrs = dma_alloc_coherent(mp->dev->dev.parent,
3ae8f4e0b98b64 drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2014-05-19  2100  					   txq->tx_ring_size * TSO_HEADER_SIZE,
3ae8f4e0b98b64 drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2014-05-19  2101  					   &txq->tso_hdrs_dma, GFP_KERNEL);
3ae8f4e0b98b64 drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2014-05-19  2102  	if (txq->tso_hdrs == NULL) {
9e911414af8caf drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2015-01-22  2103  		ret = -ENOMEM;
9e911414af8caf drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2015-01-22  2104  		goto err_free_desc_mapping;
3ae8f4e0b98b64 drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2014-05-19  2105  	}
99ab08e091df65 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-08-28  2106  	skb_queue_head_init(&txq->tx_skb);
13d6428538feae drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2107  
99ab08e091df65 drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-08-28  2108  	return 0;
9e911414af8caf drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2015-01-22  2109  
9e911414af8caf drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2015-01-22  2110  err_free_desc_mapping:
9e911414af8caf drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2015-01-22  2111  	kfree(txq->tx_desc_mapping);
9e911414af8caf drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2015-01-22  2112  err_free_desc_area:
9e911414af8caf drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2015-01-22  2113  	if (index == 0 && size <= mp->tx_desc_sram_size)
9e911414af8caf drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2015-01-22 @2114  		iounmap(txq->tx_desc_area);
9e911414af8caf drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2015-01-22  2115  	else
9e911414af8caf drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2015-01-22  2116  		dma_free_coherent(mp->dev->dev.parent, txq->tx_desc_area_size,
9e911414af8caf drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2015-01-22  2117  				  txq->tx_desc_area, txq->tx_desc_dma);
9e911414af8caf drivers/net/ethernet/marvell/mv643xx_eth.c Ezequiel Garcia   2015-01-22  2118  	return ret;
13d6428538feae drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2119  }
13d6428538feae drivers/net/mv643xx_eth.c                  Lennert Buytenhek 2008-06-01  2120  

:::::: The code at line 1994 was first introduced by commit
:::::: 8a578111e343350ff8fa75fc3630d4bba5475cae mv643xx_eth: split out rx queue state

:::::: TO: Lennert Buytenhek <buytenh@wantstofly.org>
:::::: CC: Lennert Buytenhek <buytenh@wantstofly.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
