Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723936B7F7F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjCMR2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 13:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCMR2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:28:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3258012F38;
        Mon, 13 Mar 2023 10:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678728501; x=1710264501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kPAFGU9vgAgBlFPcvlsMHCCQb7nmszEtpgeA8dHnmE8=;
  b=MG8DJAJZ9k6Sd3soOOKN00aAUwP59g6EzyFbtL8xEetxw+9j8tJ+A9Di
   RhURvzAr6DIHpc5L47HL4wsF1ib4dhhRBbyJIJ+6vzQcYOpMK2H1nrXaW
   rGb+DW72nnVIjd3NqsCPJ+UlOiFdpIWOHkanzytHUijmADid3wbGgBW4l
   8K7vaqBy/oTr8N++4puO5Muvf9PE4xNs6fPOwX9IWeDlhk7ZgBlnd5B6v
   YIcA0ei7U9gqqceTgc7SkfMjRNMHmiFVpSabTgpwuaeh4ObjdBl6pVA+T
   1p/v3slEY7UWilmv46jBapVRv2ZaME7QLooTuAqPGzgcLweQFT4da33GQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="317598095"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="317598095"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 10:27:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="802535312"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="802535312"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 13 Mar 2023 10:27:33 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pblxM-0005vi-2D;
        Mon, 13 Mar 2023 17:27:32 +0000
Date:   Tue, 14 Mar 2023 01:27:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [rft, PATCH v1 1/1] gpio: Drop unused inclusions from of_gpio.h
Message-ID: <202303140154.SFYdafUn-lkp@intel.com>
References: <20230313144557.35856-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313144557.35856-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Yet something to improve:

[auto build test ERROR on brgl/gpio/for-next]
[also build test ERROR on linus/master v6.3-rc2 next-20230310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/gpio-Drop-unused-inclusions-from-of_gpio-h/20230313-224656
base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
patch link:    https://lore.kernel.org/r/20230313144557.35856-1-andriy.shevchenko%40linux.intel.com
patch subject: [rft, PATCH v1 1/1] gpio: Drop unused inclusions from of_gpio.h
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20230314/202303140154.SFYdafUn-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b108d11788b6db9e37a6c4b3110c09cecf30a46c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/gpio-Drop-unused-inclusions-from-of_gpio-h/20230313-224656
        git checkout b108d11788b6db9e37a6c4b3110c09cecf30a46c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303140154.SFYdafUn-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/tty/serial/pic32_uart.c: In function 'pic32_uart_get_mctrl':
>> drivers/tty/serial/pic32_uart.c:169:18: error: implicit declaration of function 'gpiod_get_value' [-Werror=implicit-function-declaration]
     169 |         else if (gpiod_get_value(sport->cts_gpiod))
         |                  ^~~~~~~~~~~~~~~
   drivers/tty/serial/pic32_uart.c: In function 'pic32_uart_probe':
>> drivers/tty/serial/pic32_uart.c:899:28: error: implicit declaration of function 'devm_gpiod_get_optional'; did you mean 'devm_clk_get_optional'? [-Werror=implicit-function-declaration]
     899 |         sport->cts_gpiod = devm_gpiod_get_optional(dev, "cts", GPIOD_IN);
         |                            ^~~~~~~~~~~~~~~~~~~~~~~
         |                            devm_clk_get_optional
>> drivers/tty/serial/pic32_uart.c:899:64: error: 'GPIOD_IN' undeclared (first use in this function); did you mean 'IOC_IN'?
     899 |         sport->cts_gpiod = devm_gpiod_get_optional(dev, "cts", GPIOD_IN);
         |                                                                ^~~~~~~~
         |                                                                IOC_IN
   drivers/tty/serial/pic32_uart.c:899:64: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/tty/serial/pic32_uart.c:902:9: error: implicit declaration of function 'gpiod_set_consumer_name' [-Werror=implicit-function-declaration]
     902 |         gpiod_set_consumer_name(sport->cts_gpiod, "CTS");
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/gpiod_get_value +169 drivers/tty/serial/pic32_uart.c

157b9394709ed5 Andrei Pistirica 2016-01-13  159  
157b9394709ed5 Andrei Pistirica 2016-01-13  160  /* serial core request to return the state of misc UART input pins */
157b9394709ed5 Andrei Pistirica 2016-01-13  161  static unsigned int pic32_uart_get_mctrl(struct uart_port *port)
157b9394709ed5 Andrei Pistirica 2016-01-13  162  {
157b9394709ed5 Andrei Pistirica 2016-01-13  163  	struct pic32_sport *sport = to_pic32_sport(port);
157b9394709ed5 Andrei Pistirica 2016-01-13  164  	unsigned int mctrl = 0;
157b9394709ed5 Andrei Pistirica 2016-01-13  165  
e9c9d3bb158df0 Andy Shevchenko  2022-08-07  166  	/* get the state of CTS input pin for this port */
e9c9d3bb158df0 Andy Shevchenko  2022-08-07  167  	if (!sport->cts_gpiod)
157b9394709ed5 Andrei Pistirica 2016-01-13  168  		mctrl |= TIOCM_CTS;
e9c9d3bb158df0 Andy Shevchenko  2022-08-07 @169  	else if (gpiod_get_value(sport->cts_gpiod))
157b9394709ed5 Andrei Pistirica 2016-01-13  170  		mctrl |= TIOCM_CTS;
157b9394709ed5 Andrei Pistirica 2016-01-13  171  
157b9394709ed5 Andrei Pistirica 2016-01-13  172  	/* DSR and CD are not supported in PIC32, so return 1
157b9394709ed5 Andrei Pistirica 2016-01-13  173  	 * RI is not supported in PIC32, so return 0
157b9394709ed5 Andrei Pistirica 2016-01-13  174  	 */
157b9394709ed5 Andrei Pistirica 2016-01-13  175  	mctrl |= TIOCM_CD;
157b9394709ed5 Andrei Pistirica 2016-01-13  176  	mctrl |= TIOCM_DSR;
157b9394709ed5 Andrei Pistirica 2016-01-13  177  
157b9394709ed5 Andrei Pistirica 2016-01-13  178  	return mctrl;
157b9394709ed5 Andrei Pistirica 2016-01-13  179  }
157b9394709ed5 Andrei Pistirica 2016-01-13  180  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
