Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5852873EA72
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 20:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjFZSt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 14:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjFZStY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:49:24 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21652AC;
        Mon, 26 Jun 2023 11:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687805363; x=1719341363;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4FXEvqNsXVOZIJNJKS8nlLP3wxU9zrGyi+lgppLAd+o=;
  b=H5mDEol9CPEzvdVvlnZ1FHV2nnAtFfgqIE9P4Yo3/OvklnJ1jGrbb9Rv
   rJEUbavmCHMdFswGGxx3tMIa5mDYJ/lygXA4ty6SLX3YWBKoeekcM37ms
   0NpqBBtP3guTzEF60j3gozjivdbaqfjzvkQepQkZSrvyNhvHi+rF35uqD
   5hYq08SViPmZLR25Yar7oVK/LdQ1ajox6FQgUF9OalC7enV2kRydEoYYe
   12OBwGReuMuLZ2rf0e7JflG6hiUmctGC0JlSqoEQRX8Keij67y7EvtghA
   8eztcvHbw2JyPkphnaSwrdXxG7ZAm4XyJbdR4U3S3/ccSSzj0A+F40ISx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="340944187"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="340944187"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 11:49:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="840385390"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="840385390"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2023 11:49:18 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qDrH3-000AtL-2T;
        Mon, 26 Jun 2023 18:49:17 +0000
Date:   Tue, 27 Jun 2023 02:49:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Valek - 2N <jiriv@axis.com>,
        krzysztof.kozlowski+dt@linaro.org, dmitry.torokhov@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, jiriv@axis.com,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH v3 2/2] Input: cap11xx - add advanced sensitivity settings
Message-ID: <202306270246.llRp2LOP-lkp@intel.com>
References: <20230626130006.850254-3-jiriv@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626130006.850254-3-jiriv@axis.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

kernel test robot noticed the following build warnings:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on dtor-input/for-linus linus/master v6.4 next-20230626]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiri-Valek-2N/dt-bindings-input-microchip-cap11xx-add-advanced-sensitivity-settings/20230626-210123
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/20230626130006.850254-3-jiriv%40axis.com
patch subject: [PATCH v3 2/2] Input: cap11xx - add advanced sensitivity settings
config: i386-randconfig-i013-20230626 (https://download.01.org/0day-ci/archive/20230627/202306270246.llRp2LOP-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230627/202306270246.llRp2LOP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306270246.llRp2LOP-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/input/keyboard/cap11xx.c: In function 'cap11xx_i2c_probe':
>> drivers/input/keyboard/cap11xx.c:521:23: warning: unused variable 'irq' [-Wunused-variable]
     521 |         int i, error, irq;
         |                       ^~~


vim +/irq +521 drivers/input/keyboard/cap11xx.c

   514	
   515	static int cap11xx_i2c_probe(struct i2c_client *i2c_client)
   516	{
   517		const struct i2c_device_id *id = i2c_client_get_device_id(i2c_client);
   518		struct device *dev = &i2c_client->dev;
   519		struct cap11xx_priv *priv;
   520		const struct cap11xx_hw_model *cap;
 > 521		int i, error, irq;
   522		unsigned int val, rev;
   523	
   524		if (id->driver_data >= ARRAY_SIZE(cap11xx_devices)) {
   525			dev_err(dev, "Invalid device ID %lu\n", id->driver_data);
   526			return -EINVAL;
   527		}
   528	
   529		cap = &cap11xx_devices[id->driver_data];
   530		if (!cap || !cap->num_channels) {
   531			dev_err(dev, "Invalid device configuration\n");
   532			return -EINVAL;
   533		}
   534	
   535		priv = devm_kzalloc(dev,
   536				    struct_size(priv, keycodes, cap->num_channels),
   537				    GFP_KERNEL);
   538		if (!priv)
   539			return -ENOMEM;
   540	
   541		priv->dev = dev;
   542	
   543		priv->regmap = devm_regmap_init_i2c(i2c_client, &cap11xx_regmap_config);
   544		if (IS_ERR(priv->regmap))
   545			return PTR_ERR(priv->regmap);
   546	
   547		error = regmap_read(priv->regmap, CAP11XX_REG_PRODUCT_ID, &val);
   548		if (error)
   549			return error;
   550	
   551		if (val != cap->product_id) {
   552			dev_err(dev, "Product ID: Got 0x%02x, expected 0x%02x\n",
   553				val, cap->product_id);
   554			return -ENXIO;
   555		}
   556	
   557		error = regmap_read(priv->regmap, CAP11XX_REG_MANUFACTURER_ID, &val);
   558		if (error)
   559			return error;
   560	
   561		if (val != CAP11XX_MANUFACTURER_ID) {
   562			dev_err(dev, "Manufacturer ID: Got 0x%02x, expected 0x%02x\n",
   563				val, CAP11XX_MANUFACTURER_ID);
   564			return -ENXIO;
   565		}
   566	
   567		error = regmap_read(priv->regmap, CAP11XX_REG_REVISION, &rev);
   568		if (error < 0)
   569			return error;
   570	
   571		dev_info(dev, "CAP11XX detected, model %s, revision 0x%02x\n",
   572				 id->name, rev);
   573	
   574		priv->model = cap;
   575		priv->id = id->driver_data;
   576	
   577		dev_info(dev, "CAP11XX device detected, model %s, revision 0x%02x\n",
   578			 id->name, rev);
   579	
   580		error = cap11xx_init_keys(priv);
   581		if (error)
   582			return error;
   583	
   584		priv->idev = devm_input_allocate_device(dev);
   585		if (!priv->idev)
   586			return -ENOMEM;
   587	
   588		priv->idev->name = "CAP11XX capacitive touch sensor";
   589		priv->idev->id.bustype = BUS_I2C;
   590		priv->idev->evbit[0] = BIT_MASK(EV_KEY);
   591	
   592		if (of_property_read_bool(dev->of_node, "autorepeat"))
   593			__set_bit(EV_REP, priv->idev->evbit);
   594	
   595		for (i = 0; i < cap->num_channels; i++)
   596			__set_bit(priv->keycodes[i], priv->idev->keybit);
   597	
   598		__clear_bit(KEY_RESERVED, priv->idev->keybit);
   599	
   600		priv->idev->keycode = priv->keycodes;
   601		priv->idev->keycodesize = sizeof(priv->keycodes[0]);
   602		priv->idev->keycodemax = cap->num_channels;
   603	
   604		priv->idev->id.vendor = CAP11XX_MANUFACTURER_ID;
   605		priv->idev->id.product = cap->product_id;
   606		priv->idev->id.version = rev;
   607	
   608		priv->idev->open = cap11xx_input_open;
   609		priv->idev->close = cap11xx_input_close;
   610	
   611		error = cap11xx_init_leds(dev, priv, cap->num_leds);
   612		if (error)
   613			return error;
   614	
   615		input_set_drvdata(priv->idev, priv);
   616	
   617		/*
   618		 * Put the device in deep sleep mode for now.
   619		 * ->open() will bring it back once the it is actually needed.
   620		 */
   621		cap11xx_set_sleep(priv, true);
   622	
   623		error = input_register_device(priv->idev);
   624		if (error)
   625			return error;
   626	
   627		error = devm_request_threaded_irq(dev, i2c_client->irq, NULL,
   628						cap11xx_thread_func, IRQF_ONESHOT, dev_name(dev), priv);
   629		if (error)
   630			return error;
   631	
   632		return 0;
   633	}
   634	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
