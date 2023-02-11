Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3DD693555
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 01:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjBKX4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 18:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjBKX4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 18:56:33 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5939F16310
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 15:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676159791; x=1707695791;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Qf+7zSVyfc6q4RCtZjiedzlVwz73Fq3Xup1fjjHBEA0=;
  b=TdoIPNsVH9qHqSUKCjnUhnxxqcH3ODq4OTHlX3ndXR01ueV+dnxMCgc6
   zuYYTtjyeVndeqZIUAiA8cEh8ryj1PVNAVFGX4ONtOJpdxVnQi7juaPjt
   nxsyazty5oq/qXCS0G+Tc5FX4vqnJavVgjGaxpzORNKzTOyCgUDzdKs9U
   1PSuUJ+s8r/KaisC2TbFL/6CQmQZbgSHbeP+gbS0HbRpJbaE0nZyKExpf
   ibApgscqJ+FMZLACtiPRzArNeTYAWJhaVzkSMXAFn8fwBVKjkpPuiK0Ij
   HJ/mIbIIWncWH0lLVhjbb8pPYjud0nNUVAVc+jTElWyAowi5OAs/Mia2q
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="331976612"
X-IronPort-AV: E=Sophos;i="5.97,290,1669104000"; 
   d="scan'208";a="331976612"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2023 15:56:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="661767129"
X-IronPort-AV: E=Sophos;i="5.97,290,1669104000"; 
   d="scan'208";a="661767129"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 11 Feb 2023 15:56:28 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQzjI-0006s5-07;
        Sat, 11 Feb 2023 23:56:28 +0000
Date:   Sun, 12 Feb 2023 07:55:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: drivers/tty/ipwireless/hardware.c:431:25: sparse: sparse: incorrect
 type in initializer (different base types)
Message-ID: <202302120733.XDmW1EeP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   47e9aa14ce5abca70d6584a8d8213707d197c38e
commit: 30b5e6ef4a32ea4985b99200e06d6660a69f9246 m68k: atari: Make Atari ROM port I/O write macros return void
date:   9 months ago
config: m68k-randconfig-s033-20230212 (https://download.01.org/0day-ci/archive/20230212/202302120733.XDmW1EeP-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=30b5e6ef4a32ea4985b99200e06d6660a69f9246
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 30b5e6ef4a32ea4985b99200e06d6660a69f9246
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=m68k SHELL=/bin/bash drivers/tty/ipwireless/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302120733.XDmW1EeP-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/tty/ipwireless/hardware.c:431:25: sparse: sparse: cast from restricted __le16
   drivers/tty/ipwireless/hardware.c:431:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [assigned] [usertype] raw_data @@
   drivers/tty/ipwireless/hardware.c:431:25: sparse:     expected unsigned short [usertype] val
   drivers/tty/ipwireless/hardware.c:431:25: sparse:     got restricted __le16 [assigned] [usertype] raw_data
   drivers/tty/ipwireless/hardware.c:431:25: sparse: sparse: cast from restricted __le16
   drivers/tty/ipwireless/hardware.c:431:25: sparse: sparse: cast from restricted __le16
>> drivers/tty/ipwireless/hardware.c:431:25: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned short [unused] [usertype] __v @@     got restricted __le16 [assigned] [usertype] raw_data @@
   drivers/tty/ipwireless/hardware.c:431:25: sparse:     expected unsigned short [unused] [usertype] __v
   drivers/tty/ipwireless/hardware.c:431:25: sparse:     got restricted __le16 [assigned] [usertype] raw_data
>> drivers/tty/ipwireless/hardware.c:431:25: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned short [unused] [usertype] __v @@     got restricted __le16 [assigned] [usertype] raw_data @@
   drivers/tty/ipwireless/hardware.c:431:25: sparse:     expected unsigned short [unused] [usertype] __v
   drivers/tty/ipwireless/hardware.c:431:25: sparse:     got restricted __le16 [assigned] [usertype] raw_data
   drivers/tty/ipwireless/hardware.c:445:25: sparse: sparse: cast from restricted __le16
   drivers/tty/ipwireless/hardware.c:445:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __le16 [assigned] [usertype] raw_data @@
   drivers/tty/ipwireless/hardware.c:445:25: sparse:     expected unsigned short [usertype] val
   drivers/tty/ipwireless/hardware.c:445:25: sparse:     got restricted __le16 [assigned] [usertype] raw_data
   drivers/tty/ipwireless/hardware.c:445:25: sparse: sparse: cast from restricted __le16
   drivers/tty/ipwireless/hardware.c:445:25: sparse: sparse: cast from restricted __le16
   drivers/tty/ipwireless/hardware.c:445:25: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned short [unused] [usertype] __v @@     got restricted __le16 [assigned] [usertype] raw_data @@
   drivers/tty/ipwireless/hardware.c:445:25: sparse:     expected unsigned short [unused] [usertype] __v
   drivers/tty/ipwireless/hardware.c:445:25: sparse:     got restricted __le16 [assigned] [usertype] raw_data
   drivers/tty/ipwireless/hardware.c:445:25: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned short [unused] [usertype] __v @@     got restricted __le16 [assigned] [usertype] raw_data @@
   drivers/tty/ipwireless/hardware.c:445:25: sparse:     expected unsigned short [unused] [usertype] __v
   drivers/tty/ipwireless/hardware.c:445:25: sparse:     got restricted __le16 [assigned] [usertype] raw_data
   drivers/tty/ipwireless/hardware.c:863:23: sparse: sparse: cast to restricted __le16
   drivers/tty/ipwireless/hardware.c:863:23: sparse: sparse: cast to restricted __le16
   drivers/tty/ipwireless/hardware.c:863:23: sparse: sparse: cast to restricted __le16
   drivers/tty/ipwireless/hardware.c:863:23: sparse: sparse: cast to restricted __le16
   drivers/tty/ipwireless/hardware.c:872:43: sparse: sparse: cast to restricted __le16
   drivers/tty/ipwireless/hardware.c:872:43: sparse: sparse: cast to restricted __le16
   drivers/tty/ipwireless/hardware.c:872:43: sparse: sparse: cast to restricted __le16
   drivers/tty/ipwireless/hardware.c:872:43: sparse: sparse: cast to restricted __le16
   drivers/tty/ipwireless/hardware.c:872:43: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le16 [usertype] raw_data @@     got int @@
   drivers/tty/ipwireless/hardware.c:872:43: sparse:     expected restricted __le16 [usertype] raw_data
   drivers/tty/ipwireless/hardware.c:872:43: sparse:     got int
   drivers/tty/ipwireless/hardware.c:879:23: sparse: sparse: cast to restricted __le16
   drivers/tty/ipwireless/hardware.c:879:23: sparse: sparse: cast to restricted __le16
   drivers/tty/ipwireless/hardware.c:879:23: sparse: sparse: cast to restricted __le16
   drivers/tty/ipwireless/hardware.c:879:23: sparse: sparse: cast to restricted __le16
   drivers/tty/ipwireless/hardware.c:889:43: sparse: sparse: cast to restricted __le16
   drivers/tty/ipwireless/hardware.c:889:43: sparse: sparse: cast to restricted __le16
   drivers/tty/ipwireless/hardware.c:889:43: sparse: sparse: cast to restricted __le16
   drivers/tty/ipwireless/hardware.c:889:43: sparse: sparse: cast to restricted __le16
   drivers/tty/ipwireless/hardware.c:889:43: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le16 [usertype] raw_data @@     got int @@
   drivers/tty/ipwireless/hardware.c:889:43: sparse:     expected restricted __le16 [usertype] raw_data
   drivers/tty/ipwireless/hardware.c:889:43: sparse:     got int
   drivers/tty/ipwireless/hardware.c:897:25: sparse: sparse: cast to restricted __le16
   drivers/tty/ipwireless/hardware.c:897:25: sparse: sparse: cast to restricted __le16
   drivers/tty/ipwireless/hardware.c:897:25: sparse: sparse: cast to restricted __le16
   drivers/tty/ipwireless/hardware.c:897:25: sparse: sparse: cast to restricted __le16
   drivers/tty/ipwireless/hardware.c:1051:24: sparse: sparse: cast to restricted __le16
   drivers/tty/ipwireless/hardware.c:1051:24: sparse: sparse: cast to restricted __le16
   drivers/tty/ipwireless/hardware.c:1051:24: sparse: sparse: cast to restricted __le16
   drivers/tty/ipwireless/hardware.c:1051:24: sparse: sparse: cast to restricted __le16
   drivers/tty/ipwireless/hardware.c:1062:16: sparse: sparse: cast to restricted __le16
   drivers/tty/ipwireless/hardware.c:1062:16: sparse: sparse: cast to restricted __le16
   drivers/tty/ipwireless/hardware.c:1062:16: sparse: sparse: cast to restricted __le16
   drivers/tty/ipwireless/hardware.c:1062:16: sparse: sparse: cast to restricted __le16
   drivers/tty/ipwireless/hardware.c:1607:24: sparse: sparse: cast to restricted __le16
   drivers/tty/ipwireless/hardware.c:1607:24: sparse: sparse: cast to restricted __le16
   drivers/tty/ipwireless/hardware.c:1607:24: sparse: sparse: cast to restricted __le16
   drivers/tty/ipwireless/hardware.c:1607:24: sparse: sparse: cast to restricted __le16

vim +431 drivers/tty/ipwireless/hardware.c

d54c2752f6bb6c drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  403  
93110f698fe92f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  404  static void do_send_fragment(struct ipw_hardware *hw, unsigned char *data,
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  405  			    unsigned length)
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  406  {
d4c0deb7009217 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  407  	unsigned i;
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  408  	unsigned long flags;
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  409  
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  410  	start_timing();
93110f698fe92f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  411  	BUG_ON(length > hw->ll_mtu);
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  412  
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  413  	if (ipwireless_debug)
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  414  		dump_data_bytes("send", data, length);
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  415  
63c4dbd1023b9a drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  416  	spin_lock_irqsave(&hw->lock, flags);
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  417  
eb4e545d4ac82d drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-06-06  418  	hw->tx_ready = 0;
d54c2752f6bb6c drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  419  	swap_packet_bitfield_to_le(data);
eb4e545d4ac82d drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-06-06  420  
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  421  	if (hw->hw_version == HW_VERSION_1) {
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  422  		outw((unsigned short) length, hw->base_port + IODWR);
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  423  
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  424  		for (i = 0; i < length; i += 2) {
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  425  			unsigned short d = data[i];
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  426  			__le16 raw_data;
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  427  
d4c0deb7009217 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  428  			if (i + 1 < length)
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  429  				d |= data[i + 1] << 8;
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  430  			raw_data = cpu_to_le16(d);
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07 @431  			outw(raw_data, hw->base_port + IODWR);
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  432  		}
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  433  
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  434  		outw(DCR_TXDONE, hw->base_port + IODCR);
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  435  	} else if (hw->hw_version == HW_VERSION_2) {
2e713165f892c8 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  436  		outw((unsigned short) length, hw->base_port);
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  437  
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  438  		for (i = 0; i < length; i += 2) {
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  439  			unsigned short d = data[i];
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  440  			__le16 raw_data;
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  441  
d4c0deb7009217 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  442  			if (i + 1 < length)
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  443  				d |= data[i + 1] << 8;
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  444  			raw_data = cpu_to_le16(d);
2e713165f892c8 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  445  			outw(raw_data, hw->base_port);
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  446  		}
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  447  		while ((i & 3) != 2) {
2e713165f892c8 drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  448  			outw((unsigned short) 0xDEAD, hw->base_port);
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  449  			i += 2;
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  450  		}
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  451  		writew(MEMRX_RX, &hw->memory_info_regs->memreg_rx);
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  452  	}
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  453  
63c4dbd1023b9a drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-07-28  454  	spin_unlock_irqrestore(&hw->lock, flags);
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  455  
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  456  	end_write_timing(length);
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  457  }
099dc4fb62653f drivers/char/pcmcia/ipwireless/hardware.c David Sterba 2008-02-07  458  

:::::: The code at line 431 was first introduced by commit
:::::: 099dc4fb62653f6019d78db55fba7a18ef02d65b ipwireless: driver for PC Card 3G/UMTS modem

:::::: TO: David Sterba <dsterba@suse.cz>
:::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
