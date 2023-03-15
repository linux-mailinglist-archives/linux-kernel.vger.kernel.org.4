Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8131B6BBEC0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbjCOVQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbjCOVQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:16:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D80A8C818;
        Wed, 15 Mar 2023 14:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678914971; x=1710450971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3UXG2kNtVojFaZ42t7ZbC0xYesYIqTljgmL1BPd+M8Y=;
  b=OTu6GKVaWaj+saj54gN1SGNWAw8nHbara4fg0J11zwMqbo+jwIqpp4qg
   I6T0J6xM1Jqkr6hRChmxxTN1XRQaK6ehir48kspA0mBBABwJ5a0+mlqk1
   5UheulhVn0KoZPmfAhilHXz+XIn2aiePuM5p5p25FZ+EgOoNw7boZnoRo
   YhbdOWg7YF+YLQbGgnhfr/HVLfxtDkRrxenIUePyADPX4X1B7cZJWpWKy
   8V91T2SK0lKb8yydRSnUK2qG0CdexBjrOME2tHB3oX86kbTaW8MWiZpKh
   IEfEyLrNq5cPDSVavW4FOZ6+J0blvdP4GcRa3TFA2DQcb0xPAZGwUxgRu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="424091453"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="424091453"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 14:16:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="743867521"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="743867521"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 15 Mar 2023 14:16:08 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pcYTf-00082Z-1y;
        Wed, 15 Mar 2023 21:16:07 +0000
Date:   Thu, 16 Mar 2023 05:15:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     phinex <phinex@realtek.com>, jdelvare@suse.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, phinex@realtek.com
Subject: Re: [PATCH v1] hwmon: drivetemp: support to be a platform driver for
 thermal_of
Message-ID: <202303160519.6Xosrf2g-lkp@intel.com>
References: <20230315121606.GA71707@threadripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315121606.GA71707@threadripper>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi phinex,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on linus/master v6.3-rc2 next-20230315]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/phinex/hwmon-drivetemp-support-to-be-a-platform-driver-for-thermal_of/20230315-201903
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20230315121606.GA71707%40threadripper
patch subject: [PATCH v1] hwmon: drivetemp: support to be a platform driver for thermal_of
config: arm-randconfig-r012-20230312 (https://download.01.org/0day-ci/archive/20230316/202303160519.6Xosrf2g-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/1c53b683440a584685795fa8ff831379577081b0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review phinex/hwmon-drivetemp-support-to-be-a-platform-driver-for-thermal_of/20230315-201903
        git checkout 1c53b683440a584685795fa8ff831379577081b0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/hwmon/ fs/xfs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303160519.6Xosrf2g-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/hwmon/drivetemp.c:551:6: warning: variable 'err' set but not used [-Wunused-but-set-variable]
           int err;
               ^
>> drivers/hwmon/drivetemp.c:575:48: error: variable has incomplete type 'const struct thermal_zone_of_device_ops'
   static const struct thermal_zone_of_device_ops hdd_sensor_ops = {
                                                  ^
   drivers/hwmon/drivetemp.c:575:21: note: forward declaration of 'struct thermal_zone_of_device_ops'
   static const struct thermal_zone_of_device_ops hdd_sensor_ops = {
                       ^
>> drivers/hwmon/drivetemp.c:668:3: error: call to undeclared function 'devm_thermal_zone_of_sensor_register'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   devm_thermal_zone_of_sensor_register(
                   ^
   drivers/hwmon/drivetemp.c:668:3: note: did you mean 'devm_thermal_of_zone_register'?
   include/linux/thermal.h:303:29: note: 'devm_thermal_of_zone_register' declared here
   struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, int id, void *data,
                               ^
   1 warning and 2 errors generated.


vim +575 drivers/hwmon/drivetemp.c

   574	
 > 575	static const struct thermal_zone_of_device_ops hdd_sensor_ops = {
   576		.get_temp = hdd_read_temp,
   577	};
   578	
   579	static const struct of_device_id hdd_of_match[] = {
   580		{
   581			.compatible = "drivetemp,hdd-sensors",
   582		},
   583		{},
   584	};
   585	MODULE_DEVICE_TABLE(of, hdd_of_match);
   586	#endif
   587	
   588	static const struct hwmon_ops drivetemp_ops = {
   589		.is_visible = drivetemp_is_visible,
   590		.read = drivetemp_read,
   591	};
   592	
   593	static const struct hwmon_chip_info drivetemp_chip_info = {
   594		.ops = &drivetemp_ops,
   595		.info = drivetemp_info,
   596	};
   597	
   598	/*
   599	 * The device argument points to sdev->sdev_dev. Its parent is
   600	 * sdev->sdev_gendev, which we can use to get the scsi_device pointer.
   601	 */
   602	static int drivetemp_add(struct device *dev, struct class_interface *intf)
   603	{
   604		struct scsi_device *sdev = to_scsi_device(dev->parent);
   605		struct drivetemp_data *st;
   606		int err;
   607		struct ata_port *ap;
   608	
   609		st = kzalloc(sizeof(*st), GFP_KERNEL);
   610		if (!st)
   611			return -ENOMEM;
   612	
   613		ap = ata_shost_to_port(sdev->host);
   614	
   615		snprintf(st->drivename, MAX_NAME_LEN, "drivetemp_port%d", ap->port_no);
   616	
   617		st->sdev = sdev;
   618		st->dev = dev;
   619		mutex_init(&st->lock);
   620	
   621		if (drivetemp_identify(st)) {
   622			err = -ENODEV;
   623			goto abort;
   624		}
   625	
   626		st->hwdev = hwmon_device_register_with_info(
   627			dev->parent, st->drivename, st, &drivetemp_chip_info, NULL);
   628	
   629		if (IS_ERR(st->hwdev)) {
   630			err = PTR_ERR(st->hwdev);
   631			goto abort;
   632		}
   633	
   634		list_add(&st->list, &drivetemp_devlist);
   635		return 0;
   636	
   637	abort:
   638		kfree(st);
   639		return err;
   640	}
   641	
   642	static void drivetemp_remove(struct device *dev, struct class_interface *intf)
   643	{
   644		struct drivetemp_data *st, *tmp;
   645	
   646		list_for_each_entry_safe(st, tmp, &drivetemp_devlist, list) {
   647			if (st->dev == dev) {
   648				list_del(&st->list);
   649				hwmon_device_unregister(st->hwdev);
   650				kfree(st);
   651				break;
   652			}
   653		}
   654	}
   655	
   656	static struct class_interface drivetemp_interface = {
   657		.add_dev = drivetemp_add,
   658		.remove_dev = drivetemp_remove,
   659	};
   660	
   661	#if IS_ENABLED(CONFIG_THERMAL_OF)
   662	static int hdd_hwmon_probe(struct platform_device *pdev)
   663	{
   664		if (list_empty(&drivetemp_devlist))
   665			return -EPROBE_DEFER;
   666	
   667		if (!tz)
 > 668			devm_thermal_zone_of_sensor_register(
   669				&pdev->dev, 0, &drivetemp_devlist, &hdd_sensor_ops);
   670	
   671		return 0;
   672	}
   673	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
