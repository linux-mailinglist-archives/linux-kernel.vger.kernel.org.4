Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8832C68ADBB
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 02:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjBEBAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 20:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjBEBAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 20:00:10 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BA3233DA;
        Sat,  4 Feb 2023 17:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675558808; x=1707094808;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HYzoEAObKmco2oMwJFZ9Ok0gbxNT7DUEeDIgbmPNHJs=;
  b=NJ+IPAdePjUQQii7SUjy2FCF5rvtIiaEGR1sr4F9FOoWptVYL0t74/9x
   1lPYQPHQre6nQ0t20hpgnXPFvj19EfDibef5A94A8KhDs85J98TYR9Kz9
   iBHSc7XchDVWR/XCTwuYqVyPTgo69XHt2+MUrWhFpkLLEp5jXUdVbdP3J
   6VyAdiLdpEiRDBrgjiPzwUVc7+4BtlEtN9ThyNAPJWbGG4f0S/zDwnEU0
   7TCzUgu/HGdy3z6EJpajzjk+XCtlDh2vhnm7vmiV3IAGR4oOLanH1gyK2
   LQWRhc6vFPQIHBdIfuKzNTHm4Op+203EJpKqnaqROgwSEg/LZ5tRJ1/+C
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="331140830"
X-IronPort-AV: E=Sophos;i="5.97,274,1669104000"; 
   d="scan'208";a="331140830"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2023 17:00:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="666123637"
X-IronPort-AV: E=Sophos;i="5.97,274,1669104000"; 
   d="scan'208";a="666123637"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 04 Feb 2023 17:00:02 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pOTNx-0001cK-2s;
        Sun, 05 Feb 2023 01:00:01 +0000
Date:   Sun, 5 Feb 2023 08:59:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        macro@orcam.me.uk, andriy.shevchenko@linux.intel.com,
        lukas@wunner.de, cang1@live.co.uk, matthew.gerlach@linux.intel.com,
        deller@gmx.de, phil.edworthy@renesas.com, geert+renesas@glider.be,
        marpagan@redhat.com, u.kleine-koenig@pengutronix.de,
        etremblay@distech-controls.com, wander@redhat.com,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Subject: Re: [PATCH v11 tty-next 1/4] serial: 8250_pci: Add
 serial8250_pci_setup_port definition in 8250_pcilib.c
Message-ID: <202302050831.9fyXKlIq-lkp@intel.com>
References: <20230204053138.2520105-2-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230204053138.2520105-2-kumaravel.thiagarajan@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kumaravel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.2-rc6 next-20230203]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kumaravel-Thiagarajan/serial-8250_pci-Add-serial8250_pci_setup_port-definition-in-8250_pcilib-c/20230204-005851
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20230204053138.2520105-2-kumaravel.thiagarajan%40microchip.com
patch subject: [PATCH v11 tty-next 1/4] serial: 8250_pci: Add serial8250_pci_setup_port definition in 8250_pcilib.c
config: x86_64-randconfig-a001 (https://download.01.org/0day-ci/archive/20230205/202302050831.9fyXKlIq-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/cd5f521fabae71343d59d524ad57221e2b7524fe
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kumaravel-Thiagarajan/serial-8250_pci-Add-serial8250_pci_setup_port-definition-in-8250_pcilib-c/20230204-005851
        git checkout cd5f521fabae71343d59d524ad57221e2b7524fe
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/tty/serial/8250/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/8250/8250_pcilib.c:14:5: warning: no previous prototype for function 'serial8250_pci_setup_port' [-Wmissing-prototypes]
   int serial8250_pci_setup_port(struct pci_dev *dev, struct uart_8250_port *port,
       ^
   drivers/tty/serial/8250/8250_pcilib.c:14:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int serial8250_pci_setup_port(struct pci_dev *dev, struct uart_8250_port *port,
   ^
   static 
   1 warning generated.


vim +/serial8250_pci_setup_port +14 drivers/tty/serial/8250/8250_pcilib.c

    13	
  > 14	int serial8250_pci_setup_port(struct pci_dev *dev, struct uart_8250_port *port,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
