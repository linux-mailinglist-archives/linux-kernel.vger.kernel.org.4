Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153F169D64E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 23:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjBTW2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 17:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjBTW2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 17:28:36 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752F09760;
        Mon, 20 Feb 2023 14:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676932115; x=1708468115;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9uzJk+myGmC8/yplqkidRBa1M41hlA/b/WgDxjDLTt0=;
  b=EPZ4WNJDGnO7ORbudlAxxfFqh68BvIs1dF0SM3oISse5T3Zzx6tzG5iI
   74M27KgLzzmLShTyuL7/BWj601lO/ZPLmmv9nITZv1sS+5u+WYYI6n9Eh
   Mou9QGDjSRjm5ont4iU5JJqjLg3ZS0/ZfJeE8kdGwr4iQiWedN5wNvbQP
   rYdRAceRgenJjtiXdgpjY/KAhTCN3GVkflx1s/RjTx8+uRhnmRMP0t871
   yyOGRcwx0BwB7wvmW5C42FelQuUbh059h9uc9h2TrXzyeaPsiGdnqrJfU
   JEHjfSdG0X8eep57VpmdOGltJf1Za1OoccU+11nM9mVpSAVjAUYg8GeTB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="312131183"
X-IronPort-AV: E=Sophos;i="5.97,313,1669104000"; 
   d="scan'208";a="312131183"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 14:28:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="703823736"
X-IronPort-AV: E=Sophos;i="5.97,313,1669104000"; 
   d="scan'208";a="703823736"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 20 Feb 2023 14:28:31 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pUEe7-000EDP-0W;
        Mon, 20 Feb 2023 22:28:31 +0000
Date:   Tue, 21 Feb 2023 06:27:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Eckert <fe@dev.tdt.de>, u.kleine-koenig@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, pavel@ucw.cz,
        lee@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Eckert.Florian@googlemail.com
Subject: Re: [PATCH v4 2/2] trigger: ledtrig-tty: add additional modes
Message-ID: <202302210614.4oTMenu2-lkp@intel.com>
References: <20230220152038.3877596-3-fe@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220152038.3877596-3-fe@dev.tdt.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus pavel-leds/for-next staging/staging-testing staging/staging-next staging/staging-linus linus/master v6.2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Florian-Eckert/tty-new-helper-function-tty_get_mget/20230220-232129
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20230220152038.3877596-3-fe%40dev.tdt.de
patch subject: [PATCH v4 2/2] trigger: ledtrig-tty: add additional modes
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230221/202302210614.4oTMenu2-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/8da3a8a2edcad2e4b36fce551cac1961a5cd90a6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Florian-Eckert/tty-new-helper-function-tty_get_mget/20230220-232129
        git checkout 8da3a8a2edcad2e4b36fce551cac1961a5cd90a6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/leds/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302210614.4oTMenu2-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/leds/trigger/ledtrig-tty.c:15:24: error: 'TTY_LED_RNG' undeclared here (not in a function); did you mean 'TTY_LED_CNT'?
      15 |         TTY_LED_LAST = TTY_LED_RNG
         |                        ^~~~~~~~~~~
         |                        TTY_LED_CNT
   drivers/leds/trigger/ledtrig-tty.c:33:10: error: array index in initializer not of integer type
      33 |         [TTY_LED_RNG] = "RNG", // RNG Ring Indicator (RI)
         |          ^~~~~~~~~~~
   drivers/leds/trigger/ledtrig-tty.c:33:10: note: (near initialization for 'mode')
   drivers/leds/trigger/ledtrig-tty.c: In function 'ledtrig_tty_mode_show':
   drivers/leds/trigger/ledtrig-tty.c:48:34: error: '__TTY_LED_LAST' undeclared (first use in this function); did you mean 'TTY_LED_LAST'?
      48 |                 bool last = i == __TTY_LED_LAST;
         |                                  ^~~~~~~~~~~~~~
         |                                  TTY_LED_LAST
   drivers/leds/trigger/ledtrig-tty.c:48:34: note: each undeclared identifier is reported only once for each function it appears in
   drivers/leds/trigger/ledtrig-tty.c:50:48: warning: too many arguments for format [-Wformat-extra-args]
      50 |                 len += sysfs_emit_at(buf, len, "%s%s%s",
         |                                                ^~~~~~~~
   drivers/leds/trigger/ledtrig-tty.c: In function 'tty_led_mode_store':
   drivers/leds/trigger/ledtrig-tty.c:81:38: error: '__TTY_LED_MAX' undeclared (first use in this function); did you mean 'TTY_LED_CAR'?
      81 |         enum tty_led_mode tty_mode = __TTY_LED_MAX;
         |                                      ^~~~~~~~~~~~~
         |                                      TTY_LED_CAR
   drivers/leds/trigger/ledtrig-tty.c:88:26: error: '__TTY_LED_LAST' undeclared (first use in this function); did you mean 'TTY_LED_LAST'?
      88 |         for (i = 0; i <= __TTY_LED_LAST; i++)
         |                          ^~~~~~~~~~~~~~
         |                          TTY_LED_LAST
   drivers/leds/trigger/ledtrig-tty.c:89:17: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
      89 |                 if (strncmp(buf, mode[i], size) == 0)
         |                 ^~
   drivers/leds/trigger/ledtrig-tty.c:91:25: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
      91 |                         break;
         |                         ^~~~~
   drivers/leds/trigger/ledtrig-tty.c:91:25: error: break statement not within loop or switch
   drivers/leds/trigger/ledtrig-tty.c:81:27: warning: variable 'tty_mode' set but not used [-Wunused-but-set-variable]
      81 |         enum tty_led_mode tty_mode = __TTY_LED_MAX;
         |                           ^~~~~~~~
>> drivers/leds/trigger/ledtrig-tty.c:80:17: warning: unused variable 'ret' [-Wunused-variable]
      80 |         ssize_t ret = size;
         |                 ^~~
>> drivers/leds/trigger/ledtrig-tty.c:79:34: warning: unused variable 'trigger_data' [-Wunused-variable]
      79 |         struct ledtrig_tty_data *trigger_data = led_trigger_get_drvdata(dev);
         |                                  ^~~~~~~~~~~~
   drivers/leds/trigger/ledtrig-tty.c:92:17: error: no return statement in function returning non-void [-Werror=return-type]
      92 |                 }
         |                 ^
   drivers/leds/trigger/ledtrig-tty.c: At top level:
   drivers/leds/trigger/ledtrig-tty.c:94:9: error: expected identifier or '(' before 'if'
      94 |         if (tty_mode > __TTY_LED_LAST)
         |         ^~
   In file included from include/linux/rhashtable-types.h:14,
                    from include/linux/ipc.h:7,
                    from include/uapi/linux/sem.h:5,
                    from include/linux/sem.h:5,
                    from include/linux/sched.h:15,
                    from include/linux/delay.h:23,
                    from drivers/leds/trigger/ledtrig-tty.c:3:
   drivers/leds/trigger/ledtrig-tty.c:97:20: error: expected declaration specifiers or '...' before '&' token
      97 |         mutex_lock(&trigger_data->mutex);
         |                    ^
   include/linux/mutex.h:187:44: note: in definition of macro 'mutex_lock'
     187 | #define mutex_lock(lock) mutex_lock_nested(lock, 0)
         |                                            ^~~~
   include/linux/mutex.h:187:50: error: expected declaration specifiers or '...' before numeric constant
     187 | #define mutex_lock(lock) mutex_lock_nested(lock, 0)
         |                                                  ^
   drivers/leds/trigger/ledtrig-tty.c:97:9: note: in expansion of macro 'mutex_lock'
      97 |         mutex_lock(&trigger_data->mutex);
         |         ^~~~~~~~~~
   drivers/leds/trigger/ledtrig-tty.c:98:21: error: expected '=', ',', ';', 'asm' or '__attribute__' before '->' token
      98 |         trigger_data->mode = tty_mode;
         |                     ^~
   drivers/leds/trigger/ledtrig-tty.c:99:22: error: expected declaration specifiers or '...' before '&' token
      99 |         mutex_unlock(&trigger_data->mutex);
         |                      ^
   drivers/leds/trigger/ledtrig-tty.c:101:9: error: expected identifier or '(' before 'return'
     101 |         return ret;
         |         ^~~~~~
   drivers/leds/trigger/ledtrig-tty.c:102:1: error: expected identifier or '(' before '}' token
     102 | }
         | ^
   cc1: some warnings being treated as errors


vim +/ret +80 drivers/leds/trigger/ledtrig-tty.c

    74	
    75	static ssize_t tty_led_mode_store(struct device *dev,
    76				  struct device_attribute *attr, const char *buf,
    77				  size_t size)
    78	{
  > 79		struct ledtrig_tty_data *trigger_data = led_trigger_get_drvdata(dev);
  > 80		ssize_t ret = size;
    81		enum tty_led_mode tty_mode = __TTY_LED_MAX;
    82		int i;
    83	
    84		/* Check for new line in string*/
    85		if (size > 0 && buf[size - 1] == '\n')
    86			size -= 1;
    87	
    88		for (i = 0; i <= __TTY_LED_LAST; i++)
    89			if (strncmp(buf, mode[i], size) == 0)
    90				tty_mode = i;
  > 91				break;
    92			}
    93	
    94		if (tty_mode > __TTY_LED_LAST)
    95			return -EINVAL;
    96	
    97		mutex_lock(&trigger_data->mutex);
    98		trigger_data->mode = tty_mode;
    99		mutex_unlock(&trigger_data->mutex);
   100	
   101		return ret;
   102	}
   103	static DEVICE_ATTR_RW(tty_led_mode);
   104	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
