Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECB969D5D3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 22:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbjBTVgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 16:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbjBTVge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 16:36:34 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460CF212A2;
        Mon, 20 Feb 2023 13:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676928993; x=1708464993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w2bTio2+n94BCqE5in+uzbaZH9Mysz6HXfVYmqRQfz4=;
  b=Lu5G7rATHb9cvBzEVWIWJZFqC2+qNRv1awoV2KMdoQzy+VZPoHzbHpYk
   AxHrkIz2tLBvHX7/q5g0O9Xpkzr3p2v1Iuf4JY+3iyspcOruYskwmCLR1
   8M2QhJEueXc11cGWU04bQIiO8yxxl31LVeB3ZHp5/XiuXE2s2yC27gWMN
   1fHTGtvyvpBqtpjDyJIAVyKc/gDfunwRJcG8KFbLmuA+OPmEyFd1b9ogc
   m86yYDflTdPX/jgJWnZkRxX+hkV7vf1GVVDoh8qcdBApTtUVWEFpLtnGd
   SJG2qq4eUZ82SMvAxM4JwsidQh8gVkNtIzjmtHkRG9O9qYp3U6XssBteU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="330214450"
X-IronPort-AV: E=Sophos;i="5.97,313,1669104000"; 
   d="scan'208";a="330214450"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 13:36:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="648948637"
X-IronPort-AV: E=Sophos;i="5.97,313,1669104000"; 
   d="scan'208";a="648948637"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 20 Feb 2023 13:36:30 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pUDpl-000EBk-3C;
        Mon, 20 Feb 2023 21:36:29 +0000
Date:   Tue, 21 Feb 2023 05:36:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     marius.cristea@microchip.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        marius.cristea@microchip.com
Subject: Re: [PATCH v1 2/2] iio: adc: adding support for pac193x
Message-ID: <202302210551.5yGSdcbc-lkp@intel.com>
References: <20230220123232.413029-3-marius.cristea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220123232.413029-3-marius.cristea@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I love your patch! Perhaps something to improve:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.2 next-20230220]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/marius-cristea-microchip-com/dt-bindings-iio-adc-adding-dt-bindings-for-PAC193X/20230220-203540
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20230220123232.413029-3-marius.cristea%40microchip.com
patch subject: [PATCH v1 2/2] iio: adc: adding support for pac193x
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20230221/202302210551.5yGSdcbc-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/fd3be916ffe18735a98bdc55ccc0cb5f3097582c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review marius-cristea-microchip-com/dt-bindings-iio-adc-adding-dt-bindings-for-PAC193X/20230220-203540
        git checkout fd3be916ffe18735a98bdc55ccc0cb5f3097582c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302210551.5yGSdcbc-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/adc/pac193x.c: In function 'pac193x_acpi_get_acpi_match_entry':
   drivers/iio/adc/pac193x.c:1402:21: warning: variable 'status' set but not used [-Wunused-but-set-variable]
    1402 |         acpi_status status;
         |                     ^~~~~~
   drivers/iio/adc/pac193x.c: In function 'pac193x_match_acpi_device':
>> drivers/iio/adc/pac193x.c:1469:57: warning: '<<' in boolean context, did you mean '<'? [-Wint-in-bool-context]
    1469 |         chip_info->bi_dir[0] = (bi_dir_mask & (1 << 1)) << 1;
         |                                ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
   drivers/iio/adc/pac193x.c:1470:57: warning: '<<' in boolean context, did you mean '<'? [-Wint-in-bool-context]
    1470 |         chip_info->bi_dir[0] = (bi_dir_mask & (1 << 2)) << 2;
         |                                ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
   drivers/iio/adc/pac193x.c:1471:57: warning: '<<' in boolean context, did you mean '<'? [-Wint-in-bool-context]
    1471 |         chip_info->bi_dir[0] = (bi_dir_mask & (1 << 3)) << 3;
         |                                ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~


vim +1469 drivers/iio/adc/pac193x.c

  1411	
  1412	static const char *pac193x_match_acpi_device(struct i2c_client *client,
  1413						     struct pac193x_chip_info *chip_info)
  1414	{
  1415		char *name;
  1416		acpi_handle handle;
  1417		union acpi_object *rez;
  1418		unsigned short bi_dir_mask;
  1419		int idx, i;
  1420	
  1421		handle = ACPI_HANDLE(&client->dev);
  1422		name = pac193x_acpi_get_acpi_match_entry(handle);
  1423		if (!name)
  1424			return NULL;
  1425	
  1426		rez = pac193x_acpi_eval_function(handle, 0, PAC193X_ACPI_GET_NAMES_AND_MOHMS_VALS);
  1427	
  1428		if (!rez)
  1429			return NULL;
  1430	
  1431		for (i = 0; i < rez->package.count; i += 2) {
  1432			idx = i / 2;
  1433			chip_info->channel_names[idx] =
  1434				devm_kmemdup(&client->dev, rez->package.elements[i].string.pointer,
  1435					     (size_t)rez->package.elements[i].string.length + 1,
  1436					     GFP_KERNEL);
  1437			chip_info->channel_names[idx][rez->package.elements[i].string.length] = '\0';
  1438			chip_info->shunts[idx] =
  1439				rez->package.elements[i + 1].integer.value * 1000;
  1440			chip_info->active_channels[idx] = (chip_info->shunts[idx] != 0);
  1441		}
  1442	
  1443		kfree(rez);
  1444	
  1445		rez = pac193x_acpi_eval_function(handle, 1, PAC193X_ACPI_GET_UOHMS_VALS);
  1446		if (!rez) {
  1447			/*
  1448			 * initialising with default values
  1449			 * we assume all channels are unidectional(the mask is zero)
  1450			 * and assign the default sampling rate
  1451			 */
  1452			chip_info->sample_rate_value = PAC193X_DEFAULT_CHIP_SAMP_SPEED;
  1453			return name;
  1454		}
  1455	
  1456		for (i = 0; i < rez->package.count; i++) {
  1457			idx = i;
  1458			chip_info->shunts[idx] = rez->package.elements[i].integer.value;
  1459			chip_info->active_channels[idx] = (chip_info->shunts[idx] != 0);
  1460		}
  1461	
  1462		kfree(rez);
  1463	
  1464		rez = pac193x_acpi_eval_function(handle, 1, PAC193X_ACPI_GET_BIPOLAR_SETTINGS);
  1465		if (!rez)
  1466			return NULL;
  1467		bi_dir_mask = rez->package.elements[0].integer.value;
  1468		chip_info->bi_dir[0] = (bi_dir_mask & (1 << 0)) << 0;
> 1469		chip_info->bi_dir[0] = (bi_dir_mask & (1 << 1)) << 1;
  1470		chip_info->bi_dir[0] = (bi_dir_mask & (1 << 2)) << 2;
  1471		chip_info->bi_dir[0] = (bi_dir_mask & (1 << 3)) << 3;
  1472		kfree(rez);
  1473	
  1474		rez = pac193x_acpi_eval_function(handle, 1, PAC193X_ACPI_GET_SAMP);
  1475		if (!rez)
  1476			return NULL;
  1477	
  1478		chip_info->sample_rate_value = rez->package.elements[0].integer.value;
  1479		kfree(rez);
  1480	
  1481		return name;
  1482	}
  1483	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
