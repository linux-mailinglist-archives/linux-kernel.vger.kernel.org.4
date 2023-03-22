Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225B26C3F5E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 01:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjCVAx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 20:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjCVAxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 20:53:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB7726845
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 17:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679446400; x=1710982400;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PW5+lKHrsPBo20QJvQbLwYxaOXo5Xht6FFbihrbgyK4=;
  b=CWI/emYpQx4320ZTpO+KVUNxCbmwSFzWdusNiU3Mn2iUKJzkyEk8Rp2I
   IwWMAVB8Z3OnAdqS+Hwdsx+URJeuHkstNzooo6rLKuSnenan7swrDi4MI
   fxO9dfi53drt480zcBXwmW9HeuRbHH9TElNhtKu1G19csnsHBg9AfSEy2
   RtsfZZI+ppmFr8kKr8YskZstFFnGa12Or/bTXJkQrudeffRU2hxRM1i8R
   hVHqeSi2SWSaq8/b/yN4qfcHegiQrT+vSceCNvUsm2FlUiIq0IJaoPwWY
   LmW2Qma0giZYi+mgYeX3bUQlDYOClAf6tyISP6fnVzikJCq+EeUczNJW4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="403980138"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="403980138"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 17:53:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="1011178333"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="1011178333"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 21 Mar 2023 17:53:04 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pemit-000Ccg-25;
        Wed, 22 Mar 2023 00:53:03 +0000
Date:   Wed, 22 Mar 2023 08:52:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shenghao Ding <13916275206@139.com>, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        kevin-lu@ti.com, shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, x1077012@ti.com, peeyush@ti.com,
        navada@ti.com, Shenghao Ding <13916275206@139.com>
Subject: Re: [PATCH v5] ASoC: tas2781: Add tas2781 driver
Message-ID: <202303220800.Pz99eL6X-lkp@intel.com>
References: <20230321113130.25853-1-13916275206@139.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321113130.25853-1-13916275206@139.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shenghao,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on linus/master v6.3-rc3 next-20230321]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shenghao-Ding/ASoC-tas2781-Add-tas2781-driver/20230321-193259
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20230321113130.25853-1-13916275206%40139.com
patch subject: [PATCH v5] ASoC: tas2781: Add tas2781 driver
config: arm-randconfig-r046-20230320 (https://download.01.org/0day-ci/archive/20230322/202303220800.Pz99eL6X-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/a29d62a28a9077c66a962c69116c4eeb61f876f9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Shenghao-Ding/ASoC-tas2781-Add-tas2781-driver/20230321-193259
        git checkout a29d62a28a9077c66a962c69116c4eeb61f876f9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash sound/soc/codecs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303220800.Pz99eL6X-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/soc/codecs/tas2781-i2c.c:1608:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (i2c->dev.of_node)
               ^~~~~~~~~~~~~~~~
   sound/soc/codecs/tas2781-i2c.c:1626:6: note: uninitialized use occurs here
           if (ret < 0 && tas_dev != NULL)
               ^~~
   sound/soc/codecs/tas2781-i2c.c:1608:2: note: remove the 'if' if its condition is always true
           if (i2c->dev.of_node)
           ^~~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/tas2781-i2c.c:1580:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   1 warning generated.
--
>> sound/soc/codecs/tas2781-dsp.c:1239:7: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   if (page == TAS2781_YRAM5_PAGE) {
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/tas2781-dsp.c:1269:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   sound/soc/codecs/tas2781-dsp.c:1239:3: note: remove the 'if' if its condition is always true
                   if (page == TAS2781_YRAM5_PAGE) {
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/tas2781-dsp.c:1210:14: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   } else if (page == TAS2781_YRAM3_PAGE) {
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/tas2781-dsp.c:1269:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   sound/soc/codecs/tas2781-dsp.c:1210:10: note: remove the 'if' if its condition is always true
                   } else if (page == TAS2781_YRAM3_PAGE) {
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/tas2781-dsp.c:1195:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
>> sound/soc/codecs/tas2781-dsp.c:2066:6: warning: variable 'prog_status' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (rca_conf_no > rca->ncfgs || rca_conf_no <= 0 ||
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/tas2781-dsp.c:2151:9: note: uninitialized use occurs here
           return prog_status;
                  ^~~~~~~~~~~
   sound/soc/codecs/tas2781-dsp.c:2066:2: note: remove the 'if' if its condition is always false
           if (rca_conf_no > rca->ncfgs || rca_conf_no <= 0 ||
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> sound/soc/codecs/tas2781-dsp.c:2066:6: warning: variable 'prog_status' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
           if (rca_conf_no > rca->ncfgs || rca_conf_no <= 0 ||
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/tas2781-dsp.c:2151:9: note: uninitialized use occurs here
           return prog_status;
                  ^~~~~~~~~~~
   sound/soc/codecs/tas2781-dsp.c:2066:6: note: remove the '||' if its condition is always false
           if (rca_conf_no > rca->ncfgs || rca_conf_no <= 0 ||
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> sound/soc/codecs/tas2781-dsp.c:2066:6: warning: variable 'prog_status' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
           if (rca_conf_no > rca->ncfgs || rca_conf_no <= 0 ||
               ^~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/tas2781-dsp.c:2151:9: note: uninitialized use occurs here
           return prog_status;
                  ^~~~~~~~~~~
   sound/soc/codecs/tas2781-dsp.c:2066:6: note: remove the '||' if its condition is always false
           if (rca_conf_no > rca->ncfgs || rca_conf_no <= 0 ||
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/tas2781-dsp.c:2059:6: warning: variable 'prog_status' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (prm_no >= tas_fmw->nr_programs) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/tas2781-dsp.c:2151:9: note: uninitialized use occurs here
           return prog_status;
                  ^~~~~~~~~~~
   sound/soc/codecs/tas2781-dsp.c:2059:2: note: remove the 'if' if its condition is always false
           if (prm_no >= tas_fmw->nr_programs) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/tas2781-dsp.c:2052:6: warning: variable 'prog_status' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (cfg_no >= tas_fmw->nr_configurations) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/tas2781-dsp.c:2151:9: note: uninitialized use occurs here
           return prog_status;
                  ^~~~~~~~~~~
   sound/soc/codecs/tas2781-dsp.c:2052:2: note: remove the 'if' if its condition is always false
           if (cfg_no >= tas_fmw->nr_configurations) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   sound/soc/codecs/tas2781-dsp.c:2047:6: warning: variable 'prog_status' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (!tas_fmw) {
               ^~~~~~~~
   sound/soc/codecs/tas2781-dsp.c:2151:9: note: uninitialized use occurs here
           return prog_status;
                  ^~~~~~~~~~~
   sound/soc/codecs/tas2781-dsp.c:2047:2: note: remove the 'if' if its condition is always false
           if (!tas_fmw) {
           ^~~~~~~~~~~~~~~
   sound/soc/codecs/tas2781-dsp.c:2045:17: note: initialize the variable 'prog_status' to silence this warning
           int prog_status;
                          ^
                           = 0
   8 warnings generated.


vim +1608 sound/soc/codecs/tas2781-i2c.c

  1576	
  1577	static int tasdevice_i2c_probe(struct i2c_client *i2c)
  1578	{
  1579		struct tasdevice_priv *tas_dev = NULL;
  1580		int ret;
  1581		const struct acpi_device_id *acpi_id;
  1582		const struct i2c_device_id *id = i2c_match_id(tasdevice_id, i2c);
  1583	
  1584		tas_dev = devm_kzalloc(&i2c->dev, sizeof(*tas_dev), GFP_KERNEL);
  1585		if (!tas_dev) {
  1586			ret = -ENOMEM;
  1587			goto out;
  1588		}
  1589	
  1590		if (ACPI_HANDLE(&i2c->dev)) {
  1591			acpi_id = acpi_match_device(i2c->dev.driver->acpi_match_table,
  1592					&i2c->dev);
  1593			if (!acpi_id) {
  1594				dev_err(&i2c->dev, "No driver data\n");
  1595				ret = -EINVAL;
  1596				goto out;
  1597			}
  1598			tas_dev->chip_id = acpi_id->driver_data;
  1599			tas_dev->isacpi = true;
  1600		} else {
  1601			tas_dev->chip_id = (id != NULL) ? id->driver_data : 0;
  1602			tas_dev->isacpi = false;
  1603		}
  1604	
  1605		tas_dev->dev = &i2c->dev;
  1606		tas_dev->client = (void *)i2c;
  1607	
> 1608		if (i2c->dev.of_node)
  1609			ret = tasdevice_parse_dt(tas_dev);
  1610		else {
  1611			dev_err(tas_dev->dev, "No DTS info\n");
  1612			goto out;
  1613		}
  1614	
  1615		tas_dev->regmap = devm_regmap_init_i2c(i2c,
  1616			&tasdevice_regmap);
  1617		if (IS_ERR(tas_dev->regmap)) {
  1618			ret = PTR_ERR(tas_dev->regmap);
  1619			dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
  1620				ret);
  1621			goto out;
  1622		}
  1623		ret = tasdevice_init(tas_dev);
  1624	
  1625	out:
  1626		if (ret < 0 && tas_dev != NULL)
  1627			tasdevice_remove(tas_dev);
  1628		return ret;
  1629	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
