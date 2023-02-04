Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C793468A859
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 06:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjBDFbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 00:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjBDFbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 00:31:39 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3912291193;
        Fri,  3 Feb 2023 21:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675488698; x=1707024698;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wiaDjmTVDYP3++nmiG+UiFzVdmXO51IFqJJgfa6KODM=;
  b=LqSbY5juRrN778HwjmG8VNQzoXeWT3s6h73XjPXeLjKeCXYk8yPhphq2
   GiMDi1xfIZ07Wn0xBH6Y54WVCT2hYOwWn8VSHKbcBH2WIBlRXGa++49ev
   b6j5N6apSnvc28twrMHcZqDP3n79dmG6euSgXLmKPmTQr/ZAHXNdanxlU
   CNmaHEefk15dFrWa5JeQkozXKprqpmq57snqwAokOqAYkDQsKCbgZQ4H2
   L4tPKHpDm/iZej3rmyK5zAg3oNNs6tKEeZR80+ZK1SWd5l4ZYgLuVsqoj
   DoC34ji9NROA5YPbHjci0aMVK8MD45vPBVqcTyHqUPfEP5YDoKuuEz5U/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="331048661"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="331048661"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 21:31:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="696350014"
X-IronPort-AV: E=Sophos;i="5.97,272,1669104000"; 
   d="scan'208";a="696350014"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 03 Feb 2023 21:31:33 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pOB9A-00014L-1O;
        Sat, 04 Feb 2023 05:31:32 +0000
Date:   Sat, 4 Feb 2023 13:30:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, macro@orcam.me.uk,
        andriy.shevchenko@linux.intel.com, lukas@wunner.de,
        cang1@live.co.uk, matthew.gerlach@linux.intel.com, deller@gmx.de,
        phil.edworthy@renesas.com, geert+renesas@glider.be,
        marpagan@redhat.com, u.kleine-koenig@pengutronix.de,
        etremblay@distech-controls.com, wander@redhat.com,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Subject: Re: [PATCH v11 tty-next 1/4] serial: 8250_pci: Add
 serial8250_pci_setup_port definition in 8250_pcilib.c
Message-ID: <202302041334.aXx6dVcJ-lkp@intel.com>
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
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20230204/202302041334.aXx6dVcJ-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/cd5f521fabae71343d59d524ad57221e2b7524fe
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kumaravel-Thiagarajan/serial-8250_pci-Add-serial8250_pci_setup_port-definition-in-8250_pcilib-c/20230204-005851
        git checkout cd5f521fabae71343d59d524ad57221e2b7524fe
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/tty/serial/8250/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/8250/8250_pcilib.c:14:5: warning: no previous prototype for 'serial8250_pci_setup_port' [-Wmissing-prototypes]
      14 | int serial8250_pci_setup_port(struct pci_dev *dev, struct uart_8250_port *port,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/serial8250_pci_setup_port +14 drivers/tty/serial/8250/8250_pcilib.c

    13	
  > 14	int serial8250_pci_setup_port(struct pci_dev *dev, struct uart_8250_port *port,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
