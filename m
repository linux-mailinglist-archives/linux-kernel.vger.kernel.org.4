Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2946967539D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 12:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjATLrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 06:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjATLq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 06:46:56 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E7DAA7F3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 03:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674215160; x=1705751160;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=K9JAoUfsHYBjZEoSzGPT8uT/KjzoEUNMtW91JQTrJi4=;
  b=YbRzjZzh+0InsRmjVwb5IyaCYPCSbVlLRJf3YqB2uHj6mXjEIM/4vtC2
   S28dls/WxAToeJbt16GFaV5iD7v26G+qLTo4X52XJCKCeRiJ1Y95dI/m9
   4+eE+H6J/GtXu2VE+aICC4VOfzSr+9O9ei+C7JVz/2mDC2/CpQEcx/RmT
   QMP7gmuw7mR6f37ES1HKj523ZelGaRlmy6xjl1ez25x4CX3ssCsrV1dcn
   8J2JRy7RLRjArhBfRqw/ovRfBI9F7BGzQ5+EGLWjFMThscxgapeNltq0o
   fLHqAVEGrXloYOup4IrC0VngVRrK0jaZuNKPEVBf940u6nt4AGLlTJF4n
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="390074969"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="390074969"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 03:46:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="638138567"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="638138567"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 20 Jan 2023 03:45:58 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIpqH-0002WG-2a;
        Fri, 20 Jan 2023 11:45:57 +0000
Date:   Fri, 20 Jan 2023 19:45:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/brocade/bna/bfa_ioc.c:1904:24: sparse: sparse:
 incorrect type in argument 1 (different base types)
Message-ID: <202301201932.5wnJEdwo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stafford,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d368967cb1039b5c4cccb62b5a4b9468c50cd143
commit: ded2ee36313c941f1a12b6f85cde295b575264ae openrisc: Add pci bus support
date:   6 months ago
config: openrisc-randconfig-s052-20230120 (https://download.01.org/0day-ci/archive/20230120/202301201932.5wnJEdwo-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ded2ee36313c941f1a12b6f85cde295b575264ae
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ded2ee36313c941f1a12b6f85cde295b575264ae
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=openrisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/net/ethernet/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1924:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [assigned] [usertype] clscode @@     got restricted __be16 [usertype] @@
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1924:28: sparse:     expected unsigned short [assigned] [usertype] clscode
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1924:28: sparse:     got restricted __be16 [usertype]
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1925:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [assigned] [usertype] rsvd @@     got restricted __be16 [usertype] @@
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1925:25: sparse:     expected unsigned short [assigned] [usertype] rsvd
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1925:25: sparse:     got restricted __be16 [usertype]
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1927:29: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1938:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [assigned] [usertype] clscode @@     got restricted __be16 [usertype] @@
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1938:29: sparse:     expected unsigned short [assigned] [usertype] clscode
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1938:29: sparse:     got restricted __be16 [usertype]
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1939:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [assigned] [usertype] rsvd @@     got restricted __be16 [usertype] @@
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1939:26: sparse:     expected unsigned short [assigned] [usertype] rsvd
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1939:26: sparse:     got restricted __be16 [usertype]
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1941:30: sparse: sparse: cast to restricted __be32
>> drivers/net/ethernet/brocade/bna/bfa_ioc.c:1904:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1904:24: sparse:     expected unsigned int [usertype] value
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1904:24: sparse:     got restricted __le32 [usertype]
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:2106:31: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:2107:31: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:2108:31: sparse: sparse: cast to restricted __be16
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:2210:26: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:2423:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:2423:25: sparse:     expected unsigned int [usertype]
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:2423:25: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3069:21: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3071:23: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3074:23: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3102:21: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3104:23: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3107:23: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3141:26: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3148:40: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3149:39: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3152:41: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3154:41: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3156:41: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3158:41: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3160:41: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3162:41: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3169:26: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3177:26: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3182:35: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c: note: in included file:
   drivers/net/ethernet/brocade/bna/bfa_ioc.h:55:34: sparse: sparse: cast from restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.h:56:34: sparse: sparse: cast from restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.h:65:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_len @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/brocade/bna/bfa_ioc.h:65:22: sparse:     expected unsigned int [usertype] al_len
   drivers/net/ethernet/brocade/bna/bfa_ioc.h:65:22: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/brocade/bna/bfa_ioc.h:55:34: sparse: sparse: cast from restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.h:56:34: sparse: sparse: cast from restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.h:65:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_len @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/brocade/bna/bfa_ioc.h:65:22: sparse:     expected unsigned int [usertype] al_len
   drivers/net/ethernet/brocade/bna/bfa_ioc.h:65:22: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/brocade/bna/bfa_ioc.h:55:34: sparse: sparse: cast from restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.h:56:34: sparse: sparse: cast from restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.h:65:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_len @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/brocade/bna/bfa_ioc.h:65:22: sparse:     expected unsigned int [usertype] al_len
   drivers/net/ethernet/brocade/bna/bfa_ioc.h:65:22: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/brocade/bna/bfa_ioc.h:55:34: sparse: sparse: cast from restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.h:56:34: sparse: sparse: cast from restricted __be32

vim +1904 drivers/net/ethernet/brocade/bna/bfa_ioc.c

8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1891  
8a891429d1879a drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-25  1892  static void
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1893  bfa_ioc_mbox_send(struct bfa_ioc *ioc, void *ioc_msg, int len)
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1894  {
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1895  	u32 *msgp = (u32 *) ioc_msg;
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1896  	u32 i;
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1897  
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1898  	BUG_ON(!(len <= BFI_IOC_MSGLEN_MAX));
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1899  
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1900  	/*
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1901  	 * first write msg to mailbox registers
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1902  	 */
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1903  	for (i = 0; i < len / sizeof(u32); i++)
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23 @1904  		writel(cpu_to_le32(msgp[i]),
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1905  			      ioc->ioc_regs.hfn_mbox + i * sizeof(u32));
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1906  
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1907  	for (; i < BFI_IOC_MSGLEN_MAX / sizeof(u32); i++)
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1908  		writel(0, ioc->ioc_regs.hfn_mbox + i * sizeof(u32));
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1909  
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1910  	/*
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1911  	 * write 1 to mailbox CMD to trigger LPU event
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1912  	 */
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1913  	writel(1, ioc->ioc_regs.hfn_mbox_cmd);
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1914  	(void) readl(ioc->ioc_regs.hfn_mbox_cmd);
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1915  }
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1916  
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1917  static void
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1918  bfa_ioc_send_enable(struct bfa_ioc *ioc)
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1919  {
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1920  	struct bfi_ioc_ctrl_req enable_req;
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1921  
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1922  	bfi_h2i_set(enable_req.mh, BFI_MC_IOC, BFI_IOC_H2I_ENABLE_REQ,
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1923  		    bfa_ioc_portid(ioc));
078086f3c17fae drivers/net/ethernet/brocade/bna/bfa_ioc.c Rasesh Mody   2011-08-08  1924  	enable_req.clscode = htons(ioc->clscode);
a5af83925363eb drivers/net/ethernet/brocade/bna/bfa_ioc.c Arnd Bergmann 2017-03-23 @1925  	enable_req.rsvd = htons(0);
a5af83925363eb drivers/net/ethernet/brocade/bna/bfa_ioc.c Arnd Bergmann 2017-03-23  1926  	/* overflow in 2106 */
a5af83925363eb drivers/net/ethernet/brocade/bna/bfa_ioc.c Arnd Bergmann 2017-03-23  1927  	enable_req.tv_sec = ntohl(ktime_get_real_seconds());
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1928  	bfa_ioc_mbox_send(ioc, &enable_req, sizeof(struct bfi_ioc_ctrl_req));
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1929  }
8b230ed8ec96c9 drivers/net/bna/bfa_ioc.c                  Rasesh Mody   2010-08-23  1930  

:::::: The code at line 1904 was first introduced by commit
:::::: 8b230ed8ec96c933047dd0625cf95f739e4939a6 bna: Brocade 10Gb Ethernet device driver

:::::: TO: Rasesh Mody <rmody@brocade.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
