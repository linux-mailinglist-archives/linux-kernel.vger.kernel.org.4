Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D236D008B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjC3KDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjC3KDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:03:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E373186A2;
        Thu, 30 Mar 2023 03:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680170570; x=1711706570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UwiIvFDGOSeFTFp9xrmlY+lVix6S4aniU0xTa6dOGNY=;
  b=cu2gpsIGel13NgcI/7JQ84chaopdJBBg4uRyebNeLZcngq6Xt4fRpaKj
   DEOV5oDNN/LYeYHBHB/OzRPQoHq46BzuZD4GYLPK5WeQwStKdYq4KDdid
   gQuui6vX8OfTaJIjZfdulAvR0TRSq8JdC+tk3YeGpJ7NDbHFEIyr2Rtde
   +NTl0GF6p7TT3G98dyWwJxVl65avZeTgxuNfIbGOFE7PNLdPDNCbH4V9/
   l3UNsU1uVyr0gVc6TliGd5M1ZXs0/cjxl/01YaRZ9rTAzfJO2kL40PftQ
   0t86m0KCZsoePTKpN3OFe6RwdLhKQ5sciUWjaHt+Qezl8ohWftPxDqSmF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="403775152"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="403775152"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 03:02:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="930673602"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="930673602"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 30 Mar 2023 03:02:47 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1php7H-000KjA-0F;
        Thu, 30 Mar 2023 10:02:47 +0000
Date:   Thu, 30 Mar 2023 18:02:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manish Mandlik <mmandlik@google.com>, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 2/4] Bluetooth: Add vhci devcoredump support
Message-ID: <202303301735.9Keuj1Mu-lkp@intel.com>
References: <20230329230447.v12.2.Ief9a81a3643d2291f6db2b3695c3a6e0159467dc@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329230447.v12.2.Ief9a81a3643d2291f6db2b3695c3a6e0159467dc@changeid>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manish,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on bluetooth/master]
[also build test ERROR on bluetooth-next/master linus/master v6.3-rc4 next-20230330]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manish-Mandlik/Bluetooth-Add-vhci-devcoredump-support/20230330-140719
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/20230329230447.v12.2.Ief9a81a3643d2291f6db2b3695c3a6e0159467dc%40changeid
patch subject: [PATCH v12 2/4] Bluetooth: Add vhci devcoredump support
config: hexagon-randconfig-r045-20230329 (https://download.01.org/0day-ci/archive/20230330/202303301735.9Keuj1Mu-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a96b21e272af3d91f47b77b297f1289c867259b4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Manish-Mandlik/Bluetooth-Add-vhci-devcoredump-support/20230330-140719
        git checkout a96b21e272af3d91f47b77b297f1289c867259b4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/bluetooth/ lib/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303301735.9Keuj1Mu-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/bluetooth/hci_vhci.c:22:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/bluetooth/hci_vhci.c:22:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/bluetooth/hci_vhci.c:22:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> drivers/bluetooth/hci_vhci.c:334:9: error: no member named 'dump' in 'struct hci_dev'
                   hdev->dump.timeout = msecs_to_jiffies(dump_data.timeout * 1000);
                   ~~~~  ^
   6 warnings and 1 error generated.


vim +334 drivers/bluetooth/hci_vhci.c

   310	
   311	static ssize_t force_devcd_write(struct file *file, const char __user *user_buf,
   312					 size_t count, loff_t *ppos)
   313	{
   314		struct vhci_data *data = file->private_data;
   315		struct hci_dev *hdev = data->hdev;
   316		struct sk_buff *skb = NULL;
   317		struct devcoredump_test_data dump_data;
   318		int ret;
   319	
   320		ret = simple_write_to_buffer(&dump_data, sizeof(dump_data), ppos,
   321					     user_buf, count);
   322		if (ret < count)
   323			return ret;
   324	
   325		skb = alloc_skb(sizeof(dump_data.data), GFP_ATOMIC);
   326		if (!skb)
   327			return -ENOMEM;
   328		skb_put_data(skb, &dump_data.data, sizeof(dump_data.data));
   329	
   330		hci_devcd_register(hdev, vhci_coredump, vhci_coredump_hdr, NULL);
   331	
   332		/* Force the devcoredump timeout */
   333		if (dump_data.timeout)
 > 334			hdev->dump.timeout = msecs_to_jiffies(dump_data.timeout * 1000);
   335	
   336		ret = hci_devcd_init(hdev, skb->len);
   337		if (ret) {
   338			BT_ERR("Failed to generate devcoredump");
   339			kfree_skb(skb);
   340			return ret;
   341		}
   342	
   343		hci_devcd_append(hdev, skb);
   344	
   345		switch (dump_data.state) {
   346		case HCI_DEVCOREDUMP_DONE:
   347			hci_devcd_complete(hdev);
   348			break;
   349		case HCI_DEVCOREDUMP_ABORT:
   350			hci_devcd_abort(hdev);
   351			break;
   352		case HCI_DEVCOREDUMP_TIMEOUT:
   353			/* Do nothing */
   354			break;
   355		default:
   356			return -EINVAL;
   357		}
   358	
   359		return count;
   360	}
   361	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
