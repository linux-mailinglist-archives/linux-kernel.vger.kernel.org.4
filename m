Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9070368C3E5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjBFQyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjBFQyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:54:14 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F74416328;
        Mon,  6 Feb 2023 08:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675702450; x=1707238450;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VAsAX1g8MgazjysNTQpi5y5anirOqI9txAkZG3IpJe8=;
  b=dOpb9kvanoGHdhnGm6qLU5zhdpzn2Yu1dwwFofqk0wZO0jnMR7tmtACH
   ZExvhFAN9RxHWvl0ykcbLpWFnfz25CoBJkHnCJGhY3NAfjn3bfymVh0Er
   IIaVfaCuvvXgD3m9/1y9X+Lg1g2fvPNGq5bhGDMOn74gw2zltGlMd0v9b
   6e0gNww35p+Vxv0V6VSiWmY4l1u+TZR59oC5BKBH2JgBZOHfIx48WNN9R
   46wix1EATI1LIPr87y0X3hkN2Eu9wtsws60GPRE0DnlpNk4Zj/WN8UVhJ
   pQn0vAlZFoXWkvosyPLiFSODDW89fmykZBIHFsrw1DS857Y6yHPKX5REx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="393852815"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="393852815"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 08:54:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="735197329"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="735197329"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 06 Feb 2023 08:54:07 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pP4ko-0002ge-0m;
        Mon, 06 Feb 2023 16:54:06 +0000
Date:   Tue, 7 Feb 2023 00:53:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        Filipe =?iso-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: [PATCH 1/3] HID: logitech-hidpp: Add more debug statements
Message-ID: <202302070034.GqDB3Cje-lkp@intel.com>
References: <20230206135808.8840-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206135808.8840-1-hadess@hadess.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bastien,

I love your patch! Perhaps something to improve:

[auto build test WARNING on hid/for-next]
[also build test WARNING on linus/master v6.2-rc7 next-20230206]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bastien-Nocera/HID-logitech-hidpp-Retry-commands-when-device-is-busy/20230206-215940
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/20230206135808.8840-1-hadess%40hadess.net
patch subject: [PATCH 1/3] HID: logitech-hidpp: Add more debug statements
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230207/202302070034.GqDB3Cje-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f201298961e2cb71de94a0c8632cb9376975959f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Bastien-Nocera/HID-logitech-hidpp-Retry-commands-when-device-is-busy/20230206-215940
        git checkout f201298961e2cb71de94a0c8632cb9376975959f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/hid/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:566,
                    from include/asm-generic/bug.h:22,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:16,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/rcupdate.h:25,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from drivers/hid/hid-logitech-hidpp.c:13:
   drivers/hid/hid-logitech-hidpp.c: In function 'hidpp_send_fap_command_sync':
>> drivers/hid/hid-logitech-hidpp.c:343:25: warning: format '%ld' expects argument of type 'long int', but argument 5 has type 'unsigned int' [-Wformat=]
     343 |                         "Invalid number of parameters passed to command (%d != %ld)\n",
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:223:29: note: in definition of macro '__dynamic_func_call_cls'
     223 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:249:9: note: in expansion of macro '_dynamic_func_call_cls'
     249 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:272:9: note: in expansion of macro '_dynamic_func_call'
     272 |         _dynamic_func_call(fmt, __dynamic_dev_dbg,              \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   include/linux/hid.h:1202:9: note: in expansion of macro 'dev_dbg'
    1202 |         dev_dbg(&(hid)->dev, fmt, ##__VA_ARGS__)
         |         ^~~~~~~
   drivers/hid/hid-logitech-hidpp.c:342:17: note: in expansion of macro 'hid_dbg'
     342 |                 hid_dbg(hidpp->hid_dev,
         |                 ^~~~~~~
   drivers/hid/hid-logitech-hidpp.c:343:82: note: format string is defined here
     343 |                         "Invalid number of parameters passed to command (%d != %ld)\n",
         |                                                                                ~~^
         |                                                                                  |
         |                                                                                  long int
         |                                                                                %d


vim +343 drivers/hid/hid-logitech-hidpp.c

   333	
   334	static int hidpp_send_fap_command_sync(struct hidpp_device *hidpp,
   335		u8 feat_index, u8 funcindex_clientid, u8 *params, int param_count,
   336		struct hidpp_report *response)
   337	{
   338		struct hidpp_report *message;
   339		int ret;
   340	
   341		if (param_count > sizeof(message->fap.params)) {
   342			hid_dbg(hidpp->hid_dev,
 > 343				"Invalid number of parameters passed to command (%d != %ld)\n",
   344				param_count, sizeof(message->fap.params));
   345			return -EINVAL;
   346		}
   347	
   348		message = kzalloc(sizeof(struct hidpp_report), GFP_KERNEL);
   349		if (!message)
   350			return -ENOMEM;
   351	
   352		if (param_count > (HIDPP_REPORT_LONG_LENGTH - 4))
   353			message->report_id = REPORT_ID_HIDPP_VERY_LONG;
   354		else
   355			message->report_id = REPORT_ID_HIDPP_LONG;
   356		message->fap.feature_index = feat_index;
   357		message->fap.funcindex_clientid = funcindex_clientid | LINUX_KERNEL_SW_ID;
   358		memcpy(&message->fap.params, params, param_count);
   359	
   360		ret = hidpp_send_message_sync(hidpp, message, response);
   361		kfree(message);
   362		return ret;
   363	}
   364	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
