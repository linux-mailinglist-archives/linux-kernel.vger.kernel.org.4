Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D64669530C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjBMV3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjBMV3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:29:46 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7DC21A1A;
        Mon, 13 Feb 2023 13:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676323784; x=1707859784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=F209uMdaTJjwNR4utw9uYPO01gO8UlW+GOrDssBEwJ0=;
  b=UXzYmFDlr7J7BViev8UcxdLq8lXVAzbJN05xPIZ4EISD5KKKVYCoD2n5
   PbY47WuQCys0yNc1vi/ayEHLx3pE4x56fi2rZ69fwXZsi6lo/XZqqkyh6
   B/EywX2/FeAgPsZ+r0ZgFalny54HsY2TWD4vbAZEhEIJ1Eg331F0Zn/yw
   M239Oj5k4tRerbjiQK1Q/Ovw0UdsZ7qFxt8ZhzBSvPdHvx9iC20DMS88z
   As2FHoDz1VIbuSRcPeKMxFc5tYt6PgIBtoDzuc/tbR+DgV/HZ7KkTlYya
   iHqmoL+OiVi9YYEUrywSjNreN4jSATLZCK4tXo6xwQPpoM8utctKL8oAk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="333142496"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="333142496"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 13:29:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="757743668"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="757743668"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Feb 2023 13:29:35 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pRgOE-000819-0Z;
        Mon, 13 Feb 2023 21:29:34 +0000
Date:   Tue, 14 Feb 2023 05:28:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Eckert <fe@dev.tdt.de>, u.kleine-koenig@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, pavel@ucw.cz,
        lee@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Eckert.Florian@googlemail.com
Subject: Re: [PATCH 1/2] tty: new helper function tty_get_mget
Message-ID: <202302140516.F9Riaass-lkp@intel.com>
References: <20230213140638.620206-2-fe@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230213140638.620206-2-fe@dev.tdt.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on tty/tty-next tty/tty-linus staging/staging-testing staging/staging-next staging/staging-linus linus/master v6.2-rc8 next-20230213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Florian-Eckert/tty-new-helper-function-tty_get_mget/20230213-223413
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20230213140638.620206-2-fe%40dev.tdt.de
patch subject: [PATCH 1/2] tty: new helper function tty_get_mget
config: riscv-buildonly-randconfig-r005-20230212 (https://download.01.org/0day-ci/archive/20230214/202302140516.F9Riaass-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db0e6591612b53910a1b366863348bdb9d7d2fb1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/096ca9c9428ec2a8ebab4af0798461e66585cdde
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Florian-Eckert/tty-new-helper-function-tty_get_mget/20230213-223413
        git checkout 096ca9c9428ec2a8ebab4af0798461e66585cdde
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/misc/bcm-vk/ drivers/tty/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302140516.F9Riaass-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/tty/tty_io.c:76:
   include/linux/tty.h:423:3: error: expected ')'
                   struct serial_icounter_struct *icount);
                   ^
   include/linux/tty.h:422:19: note: to match this '('
   int tty_get_icount(struct tty_struct *tty
                     ^
>> drivers/tty/tty_io.c:2589:5: error: conflicting types for 'tty_get_icount'
   int tty_get_icount(struct tty_struct *tty,
       ^
   include/linux/tty.h:422:5: note: previous declaration is here
   int tty_get_icount(struct tty_struct *tty
       ^
>> drivers/tty/tty_io.c:2606:31: error: too many arguments to function call, expected 1, have 2
           retval = tty_get_icount(tty, &icount);
                    ~~~~~~~~~~~~~~      ^~~~~~~
   drivers/tty/tty_io.c:2599:19: note: 'tty_get_icount' declared here
   EXPORT_SYMBOL_GPL(tty_get_icount);
                     ^
   3 errors generated.
--
   In file included from drivers/tty/tty_port.c:8:
   include/linux/tty.h:423:3: error: expected ')'
                   struct serial_icounter_struct *icount);
                   ^
   include/linux/tty.h:422:19: note: to match this '('
   int tty_get_icount(struct tty_struct *tty
                     ^
>> drivers/tty/tty_port.c:266:2: warning: implicit conversion from 'unsigned long' to 'unsigned int' changes value from 18446744073709551615 to 4294967295 [-Wconstant-conversion]
           INIT_KFIFO(port->xmit_fifo);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kfifo.h:130:69: note: expanded from macro 'INIT_KFIFO'
           __kfifo->mask = __is_kfifo_ptr(__tmp) ? 0 : ARRAY_SIZE(__tmp->buf) - 1;\
                         ~                             ~~~~~~~~~~~~~~~~~~~~~~~^~~
   1 warning and 1 error generated.
--
   In file included from drivers/misc/bcm-vk/bcm_vk_dev.c:20:
   In file included from drivers/misc/bcm-vk/bcm_vk.h:18:
   include/linux/tty.h:423:3: error: expected ')'
                   struct serial_icounter_struct *icount);
                   ^
   include/linux/tty.h:422:19: note: to match this '('
   int tty_get_icount(struct tty_struct *tty
                     ^
>> drivers/misc/bcm-vk/bcm_vk_dev.c:1320:6: warning: shift count >= width of type [-Wshift-count-overflow]
                                           DMA_BIT_MASK(BCM_VK_DMA_BITS));
                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   1 warning and 1 error generated.


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
d281da7ff6f70e drivers/char/tty_io.c Alan Cox         2010-09-16  2601  static int tty_tiocgicount(struct tty_struct *tty, void __user *arg)
d281da7ff6f70e drivers/char/tty_io.c Alan Cox         2010-09-16  2602  {
d281da7ff6f70e drivers/char/tty_io.c Alan Cox         2010-09-16  2603  	struct serial_icounter_struct icount;
d20c219c731784 drivers/tty/tty_io.c  Uwe Kleine-König 2020-12-18  2604  	int retval;
d20c219c731784 drivers/tty/tty_io.c  Uwe Kleine-König 2020-12-18  2605  
d20c219c731784 drivers/tty/tty_io.c  Uwe Kleine-König 2020-12-18 @2606  	retval = tty_get_icount(tty, &icount);
d281da7ff6f70e drivers/char/tty_io.c Alan Cox         2010-09-16  2607  	if (retval != 0)
d281da7ff6f70e drivers/char/tty_io.c Alan Cox         2010-09-16  2608  		return retval;
d20c219c731784 drivers/tty/tty_io.c  Uwe Kleine-König 2020-12-18  2609  
d281da7ff6f70e drivers/char/tty_io.c Alan Cox         2010-09-16  2610  	if (copy_to_user(arg, &icount, sizeof(icount)))
d281da7ff6f70e drivers/char/tty_io.c Alan Cox         2010-09-16  2611  		return -EFAULT;
d281da7ff6f70e drivers/char/tty_io.c Alan Cox         2010-09-16  2612  	return 0;
d281da7ff6f70e drivers/char/tty_io.c Alan Cox         2010-09-16  2613  }
d281da7ff6f70e drivers/char/tty_io.c Alan Cox         2010-09-16  2614  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
