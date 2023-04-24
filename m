Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149186EC4D9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 07:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjDXFcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 01:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDXFco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 01:32:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D9A1FD8;
        Sun, 23 Apr 2023 22:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682314363; x=1713850363;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1n43/fJLjYfG3QHQXcc4cXYaQSDmQZ6CPC6WO9kddpk=;
  b=T4Dgs1Y98SMWqbiPRd5iaDgidCmAGWcqV51x8sWnk02wwXjeqnmtkF26
   zbAc3MYH02AjZTMptaQCN5dMIGQgqfRGu4KemCP1JFoRdfUqsCQPwRdo4
   Wd5iq6+FA9F4pWom57jzNBs8rprzcia2fsXQ8Bq/U1qkzMNMmyQTqCjZ6
   NSHqEVabBQZh0yLQ+CIWYddPoQWhsA7MVC5ICgqlwcdT6iNs9O4nyW25V
   4U5mWzJy9pkP4bRvvkcCpD60v9p46PvN9l97WK1slAKmyu/iNJp8yvuQw
   yFG31YDY02FGRWhQJ9TjAypCNQ1f7bCIvTTsbdo00S1M6oeYkdJM9P0hk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="349164994"
X-IronPort-AV: E=Sophos;i="5.99,221,1677571200"; 
   d="scan'208";a="349164994"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 22:32:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="836825069"
X-IronPort-AV: E=Sophos;i="5.99,221,1677571200"; 
   d="scan'208";a="836825069"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 Apr 2023 22:32:40 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pqooa-000iHg-0k;
        Mon, 24 Apr 2023 05:32:40 +0000
Date:   Mon, 24 Apr 2023 13:32:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jarkko Sonninen <kasper@iki.fi>
Cc:     oe-kbuild-all@lists.linux.dev, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] USB: serial: xr: Add TIOCGRS485 and TIOCSRS485 ioctls
Message-ID: <202304241303.WkdqPPbt-lkp@intel.com>
References: <20230423185929.1595056-1-kasper@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230423185929.1595056-1-kasper@iki.fi>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

kernel test robot noticed the following build warnings:

[auto build test WARNING on johan-usb-serial/usb-next]
[also build test WARNING on johan-usb-serial/usb-linus linus/master v6.3 next-20230421]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jarkko-Sonninen/USB-serial-xr-Add-TIOCGRS485-and-TIOCSRS485-ioctls/20230424-030038
base:   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git usb-next
patch link:    https://lore.kernel.org/r/20230423185929.1595056-1-kasper%40iki.fi
patch subject: [PATCH v4] USB: serial: xr: Add TIOCGRS485 and TIOCSRS485 ioctls
config: ia64-randconfig-s053-20230423 (https://download.01.org/0day-ci/archive/20230424/202304241303.WkdqPPbt-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/a80fa27b4fe1974bad2427d7f3260012a04b721a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jarkko-Sonninen/USB-serial-xr-Add-TIOCGRS485-and-TIOCSRS485-ioctls/20230424-030038
        git checkout a80fa27b4fe1974bad2427d7f3260012a04b721a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/usb/serial/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304241303.WkdqPPbt-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/usb/serial/xr_serial.c:856:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got struct serial_rs485 *argp @@
   drivers/usb/serial/xr_serial.c:856:26: sparse:     expected void [noderef] __user *to
   drivers/usb/serial/xr_serial.c:856:26: sparse:     got struct serial_rs485 *argp
>> drivers/usb/serial/xr_serial.c:872:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct serial_rs485 *argp @@
   drivers/usb/serial/xr_serial.c:872:36: sparse:     expected void const [noderef] __user *from
   drivers/usb/serial/xr_serial.c:872:36: sparse:     got struct serial_rs485 *argp
   drivers/usb/serial/xr_serial.c:881:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got struct serial_rs485 *argp @@
   drivers/usb/serial/xr_serial.c:881:26: sparse:     expected void [noderef] __user *to
   drivers/usb/serial/xr_serial.c:881:26: sparse:     got struct serial_rs485 *argp
>> drivers/usb/serial/xr_serial.c:893:49: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct serial_rs485 *argp @@     got void [noderef] __user *argp @@
   drivers/usb/serial/xr_serial.c:893:49: sparse:     expected struct serial_rs485 *argp
   drivers/usb/serial/xr_serial.c:893:49: sparse:     got void [noderef] __user *argp
   drivers/usb/serial/xr_serial.c:895:49: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct serial_rs485 *argp @@     got void [noderef] __user *argp @@
   drivers/usb/serial/xr_serial.c:895:49: sparse:     expected struct serial_rs485 *argp
   drivers/usb/serial/xr_serial.c:895:49: sparse:     got void [noderef] __user *argp

vim +856 drivers/usb/serial/xr_serial.c

   848	
   849	static int xr_get_rs485_config(struct tty_struct *tty,
   850				       struct serial_rs485 *argp)
   851	{
   852		struct usb_serial_port *port = tty->driver_data;
   853		struct xr_data *data = usb_get_serial_port_data(port);
   854	
   855		mutex_lock(&data->lock);
 > 856		if (copy_to_user(argp, &data->rs485, sizeof(data->rs485))) {
   857			mutex_unlock(&data->lock);
   858			return -EFAULT;
   859		}
   860		mutex_unlock(&data->lock);
   861	
   862		return 0;
   863	}
   864	
   865	static int xr_set_rs485_config(struct tty_struct *tty,
   866				       struct serial_rs485 *argp)
   867	{
   868		struct usb_serial_port *port = tty->driver_data;
   869		struct xr_data *data = usb_get_serial_port_data(port);
   870		struct serial_rs485 rs485;
   871	
 > 872		if (copy_from_user(&rs485, argp, sizeof(rs485)))
   873			return -EFAULT;
   874		xr_sanitize_serial_rs485(&rs485);
   875	
   876		mutex_lock(&data->lock);
   877		data->rs485 = rs485;
   878		xr_set_flow_mode(tty, port, NULL);
   879		mutex_unlock(&data->lock);
   880	
   881		if (copy_to_user(argp, &rs485, sizeof(rs485)))
   882			return -EFAULT;
   883	
   884		return 0;
   885	}
   886	
   887	static int xr_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
   888	{
   889		void __user *argp = (void __user *)arg;
   890	
   891		switch (cmd) {
   892		case TIOCGRS485:
 > 893			return xr_get_rs485_config(tty, argp);
   894		case TIOCSRS485:
   895			return xr_set_rs485_config(tty, argp);
   896		}
   897	
   898		return -ENOIOCTLCMD;
   899	}
   900	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
