Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4416EA0CC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 03:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjDUBKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 21:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjDUBKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 21:10:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B524170F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 18:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682039401; x=1713575401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f+FIdRfwzetwIQKZvF1ujm8c0Ar+vB2FOLEfgo/I4Xs=;
  b=Q35UddxucjNCs1Fl3lyUt43K4vfjVXAQ4WoSyeAK85SnCSDi+EZfBJSZ
   NAePNGXlF6hCowRDA/OLNJg72/km/I2H4r3hloHLYZyQWHtccI+me4dIf
   zMYkLQo1AMmbwqLjqdgk+0CsI91kB+WXFZCaqEsMqPyCrB9/1f0NYPyuS
   v7mURyqEpN9drKsfXLIyq4NGbxx6C6qfC3tA3jQp9plCVGOBThOuplZUT
   o79aRuhVp/tGi+zQ8b4cRHWXImNqRbcGtHjlIrzGuiWLqCPF1tEKFoVBq
   jzGnh09SZG+cgwzxmEGOFlUm3Pjg8xEd+SJKFh51l5xf1BKgJErG1uHVl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="432168496"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="432168496"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 18:10:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="803546381"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="803546381"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 20 Apr 2023 18:09:59 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppfHi-000gDG-2a;
        Fri, 21 Apr 2023 01:09:58 +0000
Date:   Fri, 21 Apr 2023 09:09:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     yunchuan <yunchuan@nfschina.com>, kabel@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        yunchuan <yunchuan@nfschina.com>
Subject: Re: [PATCH] firmware:Remove unnecessary (void*) conversions
Message-ID: <202304210825.cb223IAt-lkp@intel.com>
References: <20230420073751.1031944-1-yunchuan@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420073751.1031944-1-yunchuan@nfschina.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi yunchuan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.3-rc7 next-20230419]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/yunchuan/firmware-Remove-unnecessary-void-conversions/20230420-154004
patch link:    https://lore.kernel.org/r/20230420073751.1031944-1-yunchuan%40nfschina.com
patch subject: [PATCH] firmware:Remove unnecessary (void*) conversions
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230421/202304210825.cb223IAt-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1dee3a7afbb402fc49f0af9eeb312f221e99fab6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review yunchuan/firmware-Remove-unnecessary-void-conversions/20230420-154004
        git checkout 1dee3a7afbb402fc49f0af9eeb312f221e99fab6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304210825.cb223IAt-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/firmware/turris-mox-rwtm.c: In function 'mox_hwrng_read':
>> drivers/firmware/turris-mox-rwtm.c:286:33: warning: initialization of 'struct mox_rwtm *' from 'long unsigned int' makes pointer from integer without a cast [-Wint-conversion]
     286 |         struct mox_rwtm *rwtm = rng->priv;
         |                                 ^~~


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
