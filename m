Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6255BA0D4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 20:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiIOS15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 14:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIOS1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 14:27:55 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FB0642E0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 11:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663266474; x=1694802474;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tPPFFKRRry5yt52/WyQl3A5q2Y6FhwDpxxeVb2aCNSY=;
  b=SuZxBbVW5yvR54nqbYA5wU+01DAiHJIoNjH5BYEsZBlfuUfUrrrXEMSJ
   VWzUh2+xwZPfDHPwz8Bfc5024DgCa6xkDvum+axImq737EFEWnVX+8KY3
   7qCk/PfnRsalgezdzd1fWfz2prKP4J61+jnrg+KPj1EfBv9K/XK1iknXM
   n7+1Cb/D62kPj6lMo+gaMx/liFRGahGaPyPE3PIAXjrVZj65Ba+rD5GUk
   k19ElX1o0Sntp50Uk9e6y77Wg80ZoeontL+4K/unqaUWCeDZuj5Zh6Rqu
   qBMz/agZkYiWIQfVQnBKD0bbMXuzdBL9WWJqTwe+GeyCxb0RM7ZPv7PJA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="385094133"
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="385094133"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 11:27:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="706467550"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Sep 2022 11:27:37 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYtaK-0000r9-24;
        Thu, 15 Sep 2022 18:27:36 +0000
Date:   Fri, 16 Sep 2022 02:27:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: sound/soc/codecs/wsa883x.c:1194:25: error: implicit declaration of
 function 'devm_gpiod_get_optional'; did you mean
 'devm_regulator_get_optional'?
Message-ID: <202209160255.25Eu5IJF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3245cb65fd91cd514801bf91f5a3066d562f0ac4
commit: 43b8c7dc85a14f36048a27bb6c627fd49144a8d1 ASoC: codecs: add wsa883x amplifier support
date:   3 months ago
config: sh-randconfig-r001-20220915 (https://download.01.org/0day-ci/archive/20220916/202209160255.25Eu5IJF-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=43b8c7dc85a14f36048a27bb6c627fd49144a8d1
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 43b8c7dc85a14f36048a27bb6c627fd49144a8d1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   sound/soc/codecs/wsa883x.c: In function 'wsa883x_probe':
>> sound/soc/codecs/wsa883x.c:1194:25: error: implicit declaration of function 'devm_gpiod_get_optional'; did you mean 'devm_regulator_get_optional'? [-Werror=implicit-function-declaration]
    1194 |         wsa883x->sd_n = devm_gpiod_get_optional(&pdev->dev, "powerdown",
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
         |                         devm_regulator_get_optional
>> sound/soc/codecs/wsa883x.c:1195:49: error: 'GPIOD_FLAGS_BIT_NONEXCLUSIVE' undeclared (first use in this function)
    1195 |                                                 GPIOD_FLAGS_BIT_NONEXCLUSIVE);
         |                                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/wsa883x.c:1195:49: note: each undeclared identifier is reported only once for each function it appears in
>> sound/soc/codecs/wsa883x.c:1213:9: error: implicit declaration of function 'gpiod_direction_output'; did you mean 'gpio_direction_output'? [-Werror=implicit-function-declaration]
    1213 |         gpiod_direction_output(wsa883x->sd_n, 1);
         |         ^~~~~~~~~~~~~~~~~~~~~~
         |         gpio_direction_output
   cc1: some warnings being treated as errors


vim +1194 sound/soc/codecs/wsa883x.c

  1170	
  1171	static int wsa883x_probe(struct sdw_slave *pdev,
  1172				 const struct sdw_device_id *id)
  1173	{
  1174		struct wsa883x_priv *wsa883x;
  1175		struct device *dev = &pdev->dev;
  1176		int ret;
  1177	
  1178		wsa883x = devm_kzalloc(&pdev->dev, sizeof(*wsa883x), GFP_KERNEL);
  1179		if (!wsa883x)
  1180			return -ENOMEM;
  1181	
  1182		wsa883x->vdd = devm_regulator_get(dev, "vdd");
  1183		if (IS_ERR(wsa883x->vdd)) {
  1184			dev_err(dev, "No vdd regulator found\n");
  1185			return PTR_ERR(wsa883x->vdd);
  1186		}
  1187	
  1188		ret = regulator_enable(wsa883x->vdd);
  1189		if (ret) {
  1190			dev_err(dev, "Failed to enable vdd regulator (%d)\n", ret);
  1191			return ret;
  1192		}
  1193	
> 1194		wsa883x->sd_n = devm_gpiod_get_optional(&pdev->dev, "powerdown",
> 1195							GPIOD_FLAGS_BIT_NONEXCLUSIVE);
  1196		if (IS_ERR(wsa883x->sd_n)) {
  1197			dev_err(&pdev->dev, "Shutdown Control GPIO not found\n");
  1198			ret = PTR_ERR(wsa883x->sd_n);
  1199			goto err;
  1200		}
  1201	
  1202		dev_set_drvdata(&pdev->dev, wsa883x);
  1203		wsa883x->slave = pdev;
  1204		wsa883x->dev = &pdev->dev;
  1205		wsa883x->sconfig.ch_count = 1;
  1206		wsa883x->sconfig.bps = 1;
  1207		wsa883x->sconfig.direction = SDW_DATA_DIR_RX;
  1208		wsa883x->sconfig.type = SDW_STREAM_PDM;
  1209	
  1210		pdev->prop.sink_ports = GENMASK(WSA883X_MAX_SWR_PORTS, 0);
  1211		pdev->prop.sink_dpn_prop = wsa_sink_dpn_prop;
  1212		pdev->prop.scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
> 1213		gpiod_direction_output(wsa883x->sd_n, 1);
  1214	
  1215		wsa883x->regmap = devm_regmap_init_sdw(pdev, &wsa883x_regmap_config);
  1216		if (IS_ERR(wsa883x->regmap)) {
  1217			dev_err(&pdev->dev, "regmap_init failed\n");
  1218			ret = PTR_ERR(wsa883x->regmap);
  1219			goto err;
  1220		}
  1221		pm_runtime_set_autosuspend_delay(dev, 3000);
  1222		pm_runtime_use_autosuspend(dev);
  1223		pm_runtime_mark_last_busy(dev);
  1224		pm_runtime_set_active(dev);
  1225		pm_runtime_enable(dev);
  1226	
  1227		ret = devm_snd_soc_register_component(&pdev->dev,
  1228						      &wsa883x_component_drv,
  1229						       wsa883x_dais,
  1230						       ARRAY_SIZE(wsa883x_dais));
  1231	err:
  1232		if (ret)
  1233			regulator_disable(wsa883x->vdd);
  1234	
  1235		return ret;
  1236	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
