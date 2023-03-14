Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C6E6B8B25
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 07:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjCNGUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 02:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCNGU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 02:20:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9253D4D615;
        Mon, 13 Mar 2023 23:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678774825; x=1710310825;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WI3H3I/gh8xJAjCQSPqochNxEgU32IxdnBdW6pkbJ0s=;
  b=Km/5pu1vanEc8VUlALAoEEvmkPLWEwh6y4BIfHif24Erkq8cYc+wURi3
   03ogdFGMhFlMMbY26dxubQNc2zXIEttE+8X4ay6qJvf26P1aX5ZKi+i2d
   2uOhkCQQfXcEJIFItjFRvJBRY9yxZDSyPxPuXBVxU8E5lfQ/PLGe+ZIz7
   s1KYBR9lWhgQzrG+MhAuGy+uMGciMR+j4xE5xRGZne2ZPieNh+xoExfUN
   6SFkLDWpeRE52+GN8h9+HT4YHHgbgC+/R5dQ8BvFKx4+XSbVMNCdB2Wek
   iRbMJm1lFhx06OIEuUsVIRG5UroX56hgv2UEBBAO+ZYHSSVOyTgTKKy33
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="316988369"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="316988369"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 23:20:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="802721216"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="802721216"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 13 Mar 2023 23:20:20 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pby1D-0006bU-2o;
        Tue, 14 Mar 2023 06:20:19 +0000
Date:   Tue, 14 Mar 2023 14:19:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jarkko Sonninen <kasper@iki.fi>
Cc:     oe-kbuild-all@lists.linux.dev, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: serial: xr: Add TIOCGRS485 and TIOCSRS485 ioctls
Message-ID: <202303141402.sfS74rp6-lkp@intel.com>
References: <20230313082734.886890-1-kasper@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313082734.886890-1-kasper@iki.fi>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on johan-usb-serial/usb-next]
[also build test WARNING on johan-usb-serial/usb-linus linus/master v6.3-rc2 next-20230314]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jarkko-Sonninen/USB-serial-xr-Add-TIOCGRS485-and-TIOCSRS485-ioctls/20230313-163032
base:   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git usb-next
patch link:    https://lore.kernel.org/r/20230313082734.886890-1-kasper%40iki.fi
patch subject: [PATCH v2] USB: serial: xr: Add TIOCGRS485 and TIOCSRS485 ioctls
config: sparc64-randconfig-s031-20230312 (https://download.01.org/0day-ci/archive/20230314/202303141402.sfS74rp6-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/3470fe1d77e0edf25fc417f516491abbd812dc41
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jarkko-Sonninen/USB-serial-xr-Add-TIOCGRS485-and-TIOCSRS485-ioctls/20230313-163032
        git checkout 3470fe1d77e0edf25fc417f516491abbd812dc41
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc64 SHELL=/bin/bash drivers/usb/serial/ kernel/trace/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303141402.sfS74rp6-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/usb/serial/xr_serial.c:870:37: sparse: sparse: Using plain integer as NULL pointer

vim +870 drivers/usb/serial/xr_serial.c

   853	
   854	static int xr_set_rs485_config(struct tty_struct *tty,
   855				 unsigned long __user *argp)
   856	{
   857		struct usb_serial_port *port = tty->driver_data;
   858		struct xr_data *data = usb_get_serial_port_data(port);
   859		struct serial_rs485 rs485;
   860		unsigned long flags;
   861	
   862		if (copy_from_user(&rs485, argp, sizeof(rs485)))
   863			return -EFAULT;
   864	
   865		dev_dbg(tty->dev, "Flags %02x\n", rs485.flags);
   866		rs485.flags &= SER_RS485_ENABLED;
   867		spin_lock_irqsave(&data->lock, flags);
   868		memcpy(&data->rs485, &rs485, sizeof(rs485));
   869		spin_unlock_irqrestore(&data->lock, flags);
 > 870		xr_set_flow_mode(tty, port, 0);
   871	
   872		if (copy_to_user(argp, &data->rs485, sizeof(data->rs485)))
   873			return -EFAULT;
   874	
   875		return 0;
   876	}
   877	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
