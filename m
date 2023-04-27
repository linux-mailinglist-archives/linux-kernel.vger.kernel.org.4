Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160746EFFC5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 05:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242885AbjD0DUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 23:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjD0DUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 23:20:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5162684
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 20:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682565628; x=1714101628;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ufF9LJH3PIPNlWYHXWr3QPnDwk9YPJYJrOwx31fZ0Js=;
  b=jK1n2FjN5+qBOPKRBg4TitF8haQhtgllmzPE/mf7GElzhG2jRgWbNnZC
   3gjEEZNW1IHAz22iU4PWPuVMW1yoc0xyu2GRODQbzPBSqgbPGrA7C/j3N
   NnehTDOHK2wMtwRaUmmS13EAcobbE/VG4pEIl9hCWntjfUoBrR4N5/JBt
   G9Rxt4u/Ceh2hnW8zNFO/dw8ZJPqjnVwbv1j4jErmZlc85FSeCbLLsD+B
   ZDX2hwklXC017dnByh7IlUuhGI1WN371gRQPk7A0W3PWl0pXCUSdwYOEN
   dzAIF2yFF9Bp3G7I9OVUCM+pVlek8CbLLwEBN0t0NnUFRrRfz6lO4Cxvg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="346064984"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="346064984"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 20:20:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="724702393"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="724702393"
Received: from lkp-server01.sh.intel.com (HELO 848ce1e85e7c) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 26 Apr 2023 20:20:26 -0700
Received: from kbuild by 848ce1e85e7c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1prsBF-000013-2b;
        Thu, 27 Apr 2023 03:20:25 +0000
Date:   Thu, 27 Apr 2023 11:20:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: drivers/usb/gadget/udc/omap_udc.c:1915:9: warning: variable 'stat'
 set but not used
Message-ID: <202304271143.hmZLtQOw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6e98b09da931a00bf4e0477d0fa52748bf28fcce
commit: 250c1a694ff304e5d69e74ab32755eddcc2b8f65 ARM: pxa: convert to multiplatform
date:   12 months ago
config: arm-randconfig-r001-20230427 (https://download.01.org/0day-ci/archive/20230427/202304271143.hmZLtQOw-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 437b7602e4a998220871de78afcb020b9c14a661)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=250c1a694ff304e5d69e74ab32755eddcc2b8f65
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 250c1a694ff304e5d69e74ab32755eddcc2b8f65
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/usb/gadget/udc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304271143.hmZLtQOw-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/usb/gadget/udc/omap_udc.c:1915:9: warning: variable 'stat' set but not used [-Wunused-but-set-variable]
                                   int stat;
                                       ^
   1 warning generated.


vim +/stat +1915 drivers/usb/gadget/udc/omap_udc.c

^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1887  
7d12e780e003f9 drivers/usb/gadget/omap_udc.c David Howells  2006-10-05  1888  static irqreturn_t omap_udc_pio_irq(int irq, void *_dev)
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1889  {
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1890  	u16		epn_stat, irq_src;
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1891  	irqreturn_t	status = IRQ_NONE;
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1892  	struct omap_ep	*ep;
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1893  	int		epnum;
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1894  	struct omap_udc	*udc = _dev;
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1895  	struct omap_req	*req;
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1896  	unsigned long	flags;
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1897  
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1898  	spin_lock_irqsave(&udc->lock, flags);
f35ae6346850f6 drivers/usb/gadget/omap_udc.c Tony Lindgren  2008-07-03  1899  	epn_stat = omap_readw(UDC_EPN_STAT);
f35ae6346850f6 drivers/usb/gadget/omap_udc.c Tony Lindgren  2008-07-03  1900  	irq_src = omap_readw(UDC_IRQ_SRC);
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1901  
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1902  	/* handle OUT first, to avoid some wasteful NAKs */
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1903  	if (irq_src & UDC_EPN_RX) {
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1904  		epnum = (epn_stat >> 8) & 0x0f;
f35ae6346850f6 drivers/usb/gadget/omap_udc.c Tony Lindgren  2008-07-03  1905  		omap_writew(UDC_EPN_RX, UDC_IRQ_SRC);
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1906  		status = IRQ_HANDLED;
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1907  		ep = &udc->ep[epnum];
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1908  		ep->irqs++;
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1909  
f35ae6346850f6 drivers/usb/gadget/omap_udc.c Tony Lindgren  2008-07-03  1910  		omap_writew(epnum | UDC_EP_SEL, UDC_EP_NUM);
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1911  		ep->fnf = 0;
f35ae6346850f6 drivers/usb/gadget/omap_udc.c Tony Lindgren  2008-07-03  1912  		if (omap_readw(UDC_STAT_FLG) & UDC_ACK) {
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1913  			ep->ackwait--;
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1914  			if (!list_empty(&ep->queue)) {
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16 @1915  				int stat;
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1916  				req = container_of(ep->queue.next,
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1917  						struct omap_req, queue);
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1918  				stat = read_fifo(ep, req);
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1919  				if (!ep->double_buf)
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1920  					ep->fnf = 1;
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1921  			}
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1922  		}
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1923  		/* min 6 clock delay before clearing EP_SEL ... */
f35ae6346850f6 drivers/usb/gadget/omap_udc.c Tony Lindgren  2008-07-03  1924  		epn_stat = omap_readw(UDC_EPN_STAT);
f35ae6346850f6 drivers/usb/gadget/omap_udc.c Tony Lindgren  2008-07-03  1925  		epn_stat = omap_readw(UDC_EPN_STAT);
f35ae6346850f6 drivers/usb/gadget/omap_udc.c Tony Lindgren  2008-07-03  1926  		omap_writew(epnum, UDC_EP_NUM);
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1927  
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1928  		/* enabling fifo _after_ clearing ACK, contrary to docs,
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1929  		 * reduces lossage; timer still needed though (sigh).
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1930  		 */
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1931  		if (ep->fnf) {
f35ae6346850f6 drivers/usb/gadget/omap_udc.c Tony Lindgren  2008-07-03  1932  			omap_writew(UDC_SET_FIFO_EN, UDC_CTRL);
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1933  			ep->ackwait = 1 + ep->double_buf;
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1934  		}
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1935  		mod_timer(&ep->timer, PIO_OUT_TIMEOUT);
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1936  	}
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1937  
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1938  	/* then IN transfers */
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1939  	else if (irq_src & UDC_EPN_TX) {
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1940  		epnum = epn_stat & 0x0f;
f35ae6346850f6 drivers/usb/gadget/omap_udc.c Tony Lindgren  2008-07-03  1941  		omap_writew(UDC_EPN_TX, UDC_IRQ_SRC);
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1942  		status = IRQ_HANDLED;
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1943  		ep = &udc->ep[16 + epnum];
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1944  		ep->irqs++;
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1945  
f35ae6346850f6 drivers/usb/gadget/omap_udc.c Tony Lindgren  2008-07-03  1946  		omap_writew(epnum | UDC_EP_DIR | UDC_EP_SEL, UDC_EP_NUM);
f35ae6346850f6 drivers/usb/gadget/omap_udc.c Tony Lindgren  2008-07-03  1947  		if (omap_readw(UDC_STAT_FLG) & UDC_ACK) {
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1948  			ep->ackwait = 0;
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1949  			if (!list_empty(&ep->queue)) {
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1950  				req = container_of(ep->queue.next,
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1951  						struct omap_req, queue);
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1952  				(void) write_fifo(ep, req);
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1953  			}
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1954  		}
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1955  		/* min 6 clock delay before clearing EP_SEL ... */
f35ae6346850f6 drivers/usb/gadget/omap_udc.c Tony Lindgren  2008-07-03  1956  		epn_stat = omap_readw(UDC_EPN_STAT);
f35ae6346850f6 drivers/usb/gadget/omap_udc.c Tony Lindgren  2008-07-03  1957  		epn_stat = omap_readw(UDC_EPN_STAT);
f35ae6346850f6 drivers/usb/gadget/omap_udc.c Tony Lindgren  2008-07-03  1958  		omap_writew(epnum | UDC_EP_DIR, UDC_EP_NUM);
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1959  		/* then 6 clocks before it'd tx */
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1960  	}
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1961  
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1962  	spin_unlock_irqrestore(&udc->lock, flags);
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1963  	return status;
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1964  }
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  1965  

:::::: The code at line 1915 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
