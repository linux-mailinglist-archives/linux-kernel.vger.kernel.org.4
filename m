Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48B06E9361
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbjDTLvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDTLu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:50:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06491701
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 04:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681991455; x=1713527455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sNOFjEyQCbOWuEv6Cq+5maJTcQvQE6wHy8hTlQf7qyM=;
  b=OAhTSMeZQQEh77tTqFWt13PJRpepxcFNTV0tNV3bmxMwqLdenb4RO5o7
   pkreGAO3o1Wu/40UwjLATzVkF1xqGnJM0/UjgyFlzcpfwg5hyJiYsoCT9
   Fi1HvnrRRjMMK5W25KaojdrzzhY+vwQllvlMoBGE4XkTb+ilXsU5BTyzp
   ICgL02DqWYvqOCOOV31MSQfaaHyXIj+ygqkjmKqlGmvvgI8K0aHPnSWqO
   sD+4I20XLYbEEo9A1DPD8euLcNHTnuxy2B+4LPBS8TR3iEUzXEwCEdTuE
   FN7puC2xYPnTG2wbDRjh1ak0Wf1dffJY0akfLvuxr+W08LiY9FaQLaslD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="334542603"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="334542603"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 04:50:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="685326524"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="685326524"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 20 Apr 2023 04:50:45 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppSoB-000fno-2H;
        Thu, 20 Apr 2023 11:50:39 +0000
Date:   Thu, 20 Apr 2023 19:49:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     yunchuan <yunchuan@nfschina.com>, kabel@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, yunchuan <yunchuan@nfschina.com>
Subject: Re: [PATCH] firmware:Remove unnecessary (void*) conversions
Message-ID: <202304201916.8OvkVl9W-lkp@intel.com>
References: <20230420073751.1031944-1-yunchuan@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420073751.1031944-1-yunchuan@nfschina.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi yunchuan,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.3-rc7 next-20230419]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/yunchuan/firmware-Remove-unnecessary-void-conversions/20230420-154004
patch link:    https://lore.kernel.org/r/20230420073751.1031944-1-yunchuan%40nfschina.com
patch subject: [PATCH] firmware:Remove unnecessary (void*) conversions
config: hexagon-randconfig-r034-20230420 (https://download.01.org/0day-ci/archive/20230420/202304201916.8OvkVl9W-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 437b7602e4a998220871de78afcb020b9c14a661)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1dee3a7afbb402fc49f0af9eeb312f221e99fab6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review yunchuan/firmware-Remove-unnecessary-void-conversions/20230420-154004
        git checkout 1dee3a7afbb402fc49f0af9eeb312f221e99fab6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/firmware/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304201916.8OvkVl9W-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/firmware/turris-mox-rwtm.c:11:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
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
   In file included from drivers/firmware/turris-mox-rwtm.c:11:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/firmware/turris-mox-rwtm.c:11:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
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
>> drivers/firmware/turris-mox-rwtm.c:286:19: error: incompatible integer to pointer conversion initializing 'struct mox_rwtm *' with an expression of type 'unsigned long' [-Wint-conversion]
           struct mox_rwtm *rwtm = rng->priv;
                            ^      ~~~~~~~~~
   6 warnings and 1 error generated.


vim +286 drivers/firmware/turris-mox-rwtm.c

   283	
   284	static int mox_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
   285	{
 > 286		struct mox_rwtm *rwtm = rng->priv;
   287		struct armada_37xx_rwtm_tx_msg msg;
   288		int ret;
   289	
   290		if (max > 4096)
   291			max = 4096;
   292	
   293		msg.command = MBOX_CMD_GET_RANDOM;
   294		msg.args[0] = 1;
   295		msg.args[1] = rwtm->buf_phys;
   296		msg.args[2] = (max + 3) & ~3;
   297	
   298		if (!wait) {
   299			if (!mutex_trylock(&rwtm->busy))
   300				return -EBUSY;
   301		} else {
   302			mutex_lock(&rwtm->busy);
   303		}
   304	
   305		ret = mbox_send_message(rwtm->mbox, &msg);
   306		if (ret < 0)
   307			goto unlock_mutex;
   308	
   309		ret = wait_for_completion_interruptible(&rwtm->cmd_done);
   310		if (ret < 0)
   311			goto unlock_mutex;
   312	
   313		ret = mox_get_status(MBOX_CMD_GET_RANDOM, rwtm->reply.retval);
   314		if (ret < 0)
   315			goto unlock_mutex;
   316	
   317		memcpy(data, rwtm->buf, max);
   318		ret = max;
   319	
   320	unlock_mutex:
   321		mutex_unlock(&rwtm->busy);
   322		return ret;
   323	}
   324	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
