Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03B85B5120
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 22:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiIKUkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 16:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIKUkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 16:40:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A24175A5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 13:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662928810; x=1694464810;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QwfxgSgnF1dPXoZ3TJNfU8ycztSpJUJ+e7o8Qu1RWRY=;
  b=IoDkQtieAGWrSi1uOaddsQUnaTJL/UVYmRuz0kgi0YXn9EU0g2Qv9e4L
   UIS4UxYJKCo1PpzUqlANUsKIvywFaVrdb1z6ADINqq4vmo2CA2fshMz7U
   1UUpSbiHHn6neLzMpZpURk2Owqfu7r15c/VZQ2DqSfHdJ/dDq+369bjeR
   hWoJrQyMs9DVdAkbuEpLvl4v0MyjhbQM9hyUS7drlPNvC6gkILU+TUmiZ
   fg2wneCe3p6TQ8ZEQ50Imkl/bJ5DaS5HrYf6zL79f2/v5XkIMXtGrbYwD
   By8OFCWqoavFT/Q0b4llzBzzEu8LigykzWa05r4xZKS1M7b1/9ILnSbXE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="323977802"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="323977802"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 13:40:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="566955783"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 11 Sep 2022 13:40:08 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXTkN-0001nZ-1O;
        Sun, 11 Sep 2022 20:40:07 +0000
Date:   Mon, 12 Sep 2022 04:39:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marek Vasut <marex@denx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [sre-power-supply:for-next 11/13]
 drivers/power/supply/bq25890_charger.c:625:54: warning: implicit conversion
 from 'enum bq25890_fields' to 'enum bq25890_table_ids'
Message-ID: <202209120416.YZ3pmxA0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
head:   f52c4d5f0bb486bc515b5f8a56130aea69fb29db
commit: 4a4748f28b0b2547de745ed929e929a9b45563f1 [11/13] power: supply: bq25890: Add support for setting IINLIM
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220912/202209120416.YZ3pmxA0-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/commit/?id=4a4748f28b0b2547de745ed929e929a9b45563f1
        git remote add sre-power-supply https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
        git fetch --no-tags sre-power-supply for-next
        git checkout 4a4748f28b0b2547de745ed929e929a9b45563f1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/power/supply/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/power/supply/bq25890_charger.c: In function 'bq25890_power_supply_set_property':
>> drivers/power/supply/bq25890_charger.c:625:54: warning: implicit conversion from 'enum bq25890_fields' to 'enum bq25890_table_ids' [-Wenum-conversion]
     625 |                 lval = bq25890_find_idx(val->intval, F_IINLIM);
         |                                                      ^~~~~~~~


vim +625 drivers/power/supply/bq25890_charger.c

   615	
   616	static int bq25890_power_supply_set_property(struct power_supply *psy,
   617						     enum power_supply_property psp,
   618						     const union power_supply_propval *val)
   619	{
   620		struct bq25890_device *bq = power_supply_get_drvdata(psy);
   621		u8 lval;
   622	
   623		switch (psp) {
   624		case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
 > 625			lval = bq25890_find_idx(val->intval, F_IINLIM);
   626			return bq25890_field_write(bq, F_IINLIM, lval);
   627		default:
   628			return -EINVAL;
   629		}
   630	}
   631	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
