Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257546950A8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjBMT1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjBMT1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:27:09 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D417C20078;
        Mon, 13 Feb 2023 11:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676316426; x=1707852426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=t+vYPG0zQjL/pLjPwKSq5XEoXTdvljDP3hBNEKzGXOQ=;
  b=Z9f/juwLdtN3AT6KIa0FEKJp2iUpKuLzCisPyjJW5eiDIqvD3isVWAYP
   dD5tzMkgEuEK1QM49Vueksyx35BxD/zcgwxPQkzKLktR8SnMQs5AGJx28
   D7MSegnYK19aUrxkK3Es91xeRxm1rRiMAdg1VP0OojC6fozmr3tO1hqdi
   hTt/5EzVqcBxMs1bfIirKkkyWimlek1Sy/4e00rbiWq4GhAt0ElKkQPyY
   9PbGOEPdS0z6XKs/BgxjKFObrLaEJ2RWe+OP9aoe5g/gxtkClaQti8G5t
   qtTw2Fhy54okTfroHinPVH4Z1QsbOlq+wZo87CNbgL9OLZ6Z6WYFyudpB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="358382946"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="358382946"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 11:26:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="701390908"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="701390908"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Feb 2023 11:26:33 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pReTA-0007yP-0x;
        Mon, 13 Feb 2023 19:26:32 +0000
Date:   Tue, 14 Feb 2023 03:25:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Eckert <fe@dev.tdt.de>, u.kleine-koenig@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, pavel@ucw.cz,
        lee@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Eckert.Florian@googlemail.com
Subject: Re: [PATCH 1/2] tty: new helper function tty_get_mget
Message-ID: <202302140320.YmmWP6V8-lkp@intel.com>
References: <20230213140638.620206-2-fe@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230213140638.620206-2-fe@dev.tdt.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus pavel-leds/for-next staging/staging-testing staging/staging-next staging/staging-linus linus/master v6.2-rc8 next-20230213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Florian-Eckert/tty-new-helper-function-tty_get_mget/20230213-223413
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20230213140638.620206-2-fe%40dev.tdt.de
patch subject: [PATCH 1/2] tty: new helper function tty_get_mget
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230214/202302140320.YmmWP6V8-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/096ca9c9428ec2a8ebab4af0798461e66585cdde
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Florian-Eckert/tty-new-helper-function-tty_get_mget/20230213-223413
        git checkout 096ca9c9428ec2a8ebab4af0798461e66585cdde
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/leds/trigger/ drivers/tty/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302140320.YmmWP6V8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/tty/tty_io.c:76:
   include/linux/tty.h:423:17: error: expected ';', ',' or ')' before 'struct'
     423 |                 struct serial_icounter_struct *icount);
         |                 ^~~~~~
>> drivers/tty/tty_io.c:2589:5: warning: no previous prototype for 'tty_get_icount' [-Wmissing-prototypes]
    2589 | int tty_get_icount(struct tty_struct *tty,
         |     ^~~~~~~~~~~~~~


vim +/tty_get_icount +2589 drivers/tty/tty_io.c

^1da177e4c3f41 drivers/char/tty_io.c Linus Torvalds   2005-04-16  2579  
d20c219c731784 drivers/tty/tty_io.c  Uwe Kleine-König 2020-12-18  2580  /**
d20c219c731784 drivers/tty/tty_io.c  Uwe Kleine-König 2020-12-18  2581   * tty_get_icount	-	get tty statistics
d20c219c731784 drivers/tty/tty_io.c  Uwe Kleine-König 2020-12-18  2582   * @tty: tty device
d20c219c731784 drivers/tty/tty_io.c  Uwe Kleine-König 2020-12-18  2583   * @icount: output parameter
d20c219c731784 drivers/tty/tty_io.c  Uwe Kleine-König 2020-12-18  2584   *
796a75a98762f1 drivers/tty/tty_io.c  Jiri Slaby       2021-11-26  2585   * Gets a copy of the @tty's icount statistics.
d20c219c731784 drivers/tty/tty_io.c  Uwe Kleine-König 2020-12-18  2586   *
d20c219c731784 drivers/tty/tty_io.c  Uwe Kleine-König 2020-12-18  2587   * Locking: none (up to the driver)
d20c219c731784 drivers/tty/tty_io.c  Uwe Kleine-König 2020-12-18  2588   */
d20c219c731784 drivers/tty/tty_io.c  Uwe Kleine-König 2020-12-18 @2589  int tty_get_icount(struct tty_struct *tty,
d20c219c731784 drivers/tty/tty_io.c  Uwe Kleine-König 2020-12-18  2590  		   struct serial_icounter_struct *icount)
d20c219c731784 drivers/tty/tty_io.c  Uwe Kleine-König 2020-12-18  2591  {
d20c219c731784 drivers/tty/tty_io.c  Uwe Kleine-König 2020-12-18  2592  	memset(icount, 0, sizeof(*icount));
d20c219c731784 drivers/tty/tty_io.c  Uwe Kleine-König 2020-12-18  2593  
d20c219c731784 drivers/tty/tty_io.c  Uwe Kleine-König 2020-12-18  2594  	if (tty->ops->get_icount)
d20c219c731784 drivers/tty/tty_io.c  Uwe Kleine-König 2020-12-18  2595  		return tty->ops->get_icount(tty, icount);
d20c219c731784 drivers/tty/tty_io.c  Uwe Kleine-König 2020-12-18  2596  	else
1b8b20868a6d64 drivers/tty/tty_io.c  Johan Hovold     2021-04-07  2597  		return -ENOTTY;
d20c219c731784 drivers/tty/tty_io.c  Uwe Kleine-König 2020-12-18  2598  }
d20c219c731784 drivers/tty/tty_io.c  Uwe Kleine-König 2020-12-18  2599  EXPORT_SYMBOL_GPL(tty_get_icount);
d20c219c731784 drivers/tty/tty_io.c  Uwe Kleine-König 2020-12-18  2600  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
