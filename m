Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63ED6B5DB6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 17:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjCKQQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 11:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjCKQQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 11:16:00 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F70E64224;
        Sat, 11 Mar 2023 08:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678551359; x=1710087359;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aHPHU16CD9i0eyQTn/doZEmUXEpScZhw8p2k0kirEyo=;
  b=VrF4YRqhRXrxgnUSeIoZ2Wd7UlgITknlFAXpwyK76C5UMm7OiUA3FmuR
   4/t0jq3syLccoFeUW5r8lOSyMWimLNa8x+9+cIpW11qS8F3heluwImMW5
   gJtlrd2IF/Nj7VKApMpnlkLbfg98bFpX5a4vXygzQtjVWl34VWDPF+ONl
   7UesdXl3VXosT3nGhI671U3iig9AUT5qfW+UaNoZWd3W7RhSQY79oDZ39
   jBrKFK7ZRt8Q520pE+CkJdhIej/F1VsObEcIUm37w+ywtpQf4q7ZiPoKy
   kv5Zuznu5LyE5+kCZbNrmiVRQhukYebPMiYvXlu/RHjnb2t9ZlUDKsBs5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="423183218"
X-IronPort-AV: E=Sophos;i="5.98,252,1673942400"; 
   d="scan'208";a="423183218"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2023 08:15:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="628146557"
X-IronPort-AV: E=Sophos;i="5.98,252,1673942400"; 
   d="scan'208";a="628146557"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 Mar 2023 08:15:56 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pb1sx-0004gP-38;
        Sat, 11 Mar 2023 16:15:55 +0000
Date:   Sun, 12 Mar 2023 00:15:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Herring <robh@kernel.org>, Michal Simek <monstr@monstr.eu>
Cc:     oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: xilinx: Use of_property_present() for testing DT
 property presence
Message-ID: <202303120017.BIw01Y21-lkp@intel.com>
References: <20230310144725.1545315-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310144725.1545315-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

I love your patch! Yet something to improve:

[auto build test ERROR on xilinx-xlnx/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rob-Herring/soc-xilinx-Use-of_property_present-for-testing-DT-property-presence/20230310-225437
base:   https://github.com/Xilinx/linux-xlnx master
patch link:    https://lore.kernel.org/r/20230310144725.1545315-1-robh%40kernel.org
patch subject: [PATCH] soc: xilinx: Use of_property_present() for testing DT property presence
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20230312/202303120017.BIw01Y21-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7d21b118deba11d338baf0365e962a8889f3ac68
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Rob-Herring/soc-xilinx-Use-of_property_present-for-testing-DT-property-presence/20230310-225437
        git checkout 7d21b118deba11d338baf0365e962a8889f3ac68
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/soc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303120017.BIw01Y21-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/soc/xilinx/zynqmp_power.c: In function 'zynqmp_pm_probe':
>> drivers/soc/xilinx/zynqmp_power.c:221:20: error: implicit declaration of function 'of_property_present'; did you mean 'fwnode_property_present'? [-Werror=implicit-function-declaration]
     221 |         } else if (of_property_present(pdev->dev.of_node, "mboxes")) {
         |                    ^~~~~~~~~~~~~~~~~~~
         |                    fwnode_property_present
   cc1: some warnings being treated as errors


vim +221 drivers/soc/xilinx/zynqmp_power.c

   183	
   184	static int zynqmp_pm_probe(struct platform_device *pdev)
   185	{
   186		int ret, irq;
   187		u32 pm_api_version;
   188		struct mbox_client *client;
   189	
   190		zynqmp_pm_get_api_version(&pm_api_version);
   191	
   192		/* Check PM API version number */
   193		if (pm_api_version < ZYNQMP_PM_VERSION)
   194			return -ENODEV;
   195	
   196		/*
   197		 * First try to use Xilinx Event Manager by registering suspend_event_callback
   198		 * for suspend/shutdown event.
   199		 * If xlnx_register_event() returns -EACCES (Xilinx Event Manager
   200		 * is not available to use) or -ENODEV(Xilinx Event Manager not compiled),
   201		 * then use ipi-mailbox or interrupt method.
   202		 */
   203		ret = xlnx_register_event(PM_INIT_SUSPEND_CB, 0, 0, false,
   204					  suspend_event_callback, NULL);
   205		if (!ret) {
   206			zynqmp_pm_init_suspend_work = devm_kzalloc(&pdev->dev,
   207								   sizeof(struct zynqmp_pm_work_struct),
   208								   GFP_KERNEL);
   209			if (!zynqmp_pm_init_suspend_work) {
   210				xlnx_unregister_event(PM_INIT_SUSPEND_CB, 0, 0,
   211						      suspend_event_callback, NULL);
   212				return -ENOMEM;
   213			}
   214			event_registered = true;
   215	
   216			INIT_WORK(&zynqmp_pm_init_suspend_work->callback_work,
   217				  zynqmp_pm_init_suspend_work_fn);
   218		} else if (ret != -EACCES && ret != -ENODEV) {
   219			dev_err(&pdev->dev, "Failed to Register with Xilinx Event manager %d\n", ret);
   220			return ret;
 > 221		} else if (of_property_present(pdev->dev.of_node, "mboxes")) {
   222			zynqmp_pm_init_suspend_work =
   223				devm_kzalloc(&pdev->dev,
   224					     sizeof(struct zynqmp_pm_work_struct),
   225					     GFP_KERNEL);
   226			if (!zynqmp_pm_init_suspend_work)
   227				return -ENOMEM;
   228	
   229			INIT_WORK(&zynqmp_pm_init_suspend_work->callback_work,
   230				  zynqmp_pm_init_suspend_work_fn);
   231			client = devm_kzalloc(&pdev->dev, sizeof(*client), GFP_KERNEL);
   232			if (!client)
   233				return -ENOMEM;
   234	
   235			client->dev = &pdev->dev;
   236			client->rx_callback = ipi_receive_callback;
   237	
   238			rx_chan = mbox_request_channel_byname(client, "rx");
   239			if (IS_ERR(rx_chan)) {
   240				dev_err(&pdev->dev, "Failed to request rx channel\n");
   241				return PTR_ERR(rx_chan);
   242			}
   243		} else if (of_property_present(pdev->dev.of_node, "interrupts")) {
   244			irq = platform_get_irq(pdev, 0);
   245			if (irq <= 0)
   246				return -ENXIO;
   247	
   248			ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
   249							zynqmp_pm_isr,
   250							IRQF_NO_SUSPEND | IRQF_ONESHOT,
   251							dev_name(&pdev->dev),
   252							&pdev->dev);
   253			if (ret) {
   254				dev_err(&pdev->dev, "devm_request_threaded_irq '%d' failed with %d\n",
   255					irq, ret);
   256				return ret;
   257			}
   258		} else {
   259			dev_err(&pdev->dev, "Required property not found in DT node\n");
   260			return -ENOENT;
   261		}
   262	
   263		ret = sysfs_create_file(&pdev->dev.kobj, &dev_attr_suspend_mode.attr);
   264		if (ret) {
   265			if (event_registered) {
   266				xlnx_unregister_event(PM_INIT_SUSPEND_CB, 0, 0, suspend_event_callback,
   267						      NULL);
   268				event_registered = false;
   269			}
   270			dev_err(&pdev->dev, "unable to create sysfs interface\n");
   271			return ret;
   272		}
   273	
   274		return 0;
   275	}
   276	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
