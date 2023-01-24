Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B5067991C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 14:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbjAXNTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 08:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbjAXNTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:19:45 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF44A257;
        Tue, 24 Jan 2023 05:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674566359; x=1706102359;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1PxwQkYh/JBzNsdG2xmHDSdJ5s/geVk9mr5vH+TRLMA=;
  b=fyTvyPiyT6noiT4IGzbk7p2e8fkU7+u8J1BW2bT3ALBeCAd5FNmWDziG
   PIyssgnh7MtI6IPCsXhhkdeo9cdZKIOUmSz8c5kzeb+sU/Y+XIA8z/bu6
   L2lcuNGXosT1bLeFaArUjwCMCOtV35V0Tfy8n3Z8Ky+zJ6uEJNi2iMhbt
   Nb6nJz27QdobJUJTKWNqfuhiGKBaLJU8X+njHhsvi1YFstnapM92PFImg
   4bijAZj6ZgXX4j5R2ZJN8+Uv3/2fOq0kxqqmhDXpZKtxN0UutfWf9pwZM
   O5Q+xwXFQMs1FdKT5+L7vwxb37+XsjCm5Ujg80WG8qt6qvPTO3PJS+V74
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="323986524"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="323986524"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 05:18:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="655420194"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="655420194"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 24 Jan 2023 05:18:57 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pKJCS-0006VG-2L;
        Tue, 24 Jan 2023 13:18:56 +0000
Date:   Tue, 24 Jan 2023 21:18:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manuel Traut <manuel.traut@mt.com>, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 1/3 v6] input: pwm-beeper: add feature to set volume level
Message-ID: <202301242124.R5AWMFJb-lkp@intel.com>
References: <Y8+9L7UincSjIaD9@mt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8+9L7UincSjIaD9@mt.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manuel,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on dtor-input/next]
[also build test ERROR on dtor-input/for-linus linus/master v6.2-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manuel-Traut/input-pwm-beeper-add-feature-to-set-volume-level/20230124-191549
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/Y8%2B9L7UincSjIaD9%40mt.com
patch subject: [PATCH 1/3 v6] input: pwm-beeper: add feature to set volume level
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20230124/202301242124.R5AWMFJb-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3468440a8e674e649dcf11e23f3fb3d229555e7c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Manuel-Traut/input-pwm-beeper-add-feature-to-set-volume-level/20230124-191549
        git checkout 3468440a8e674e649dcf11e23f3fb3d229555e7c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/input/misc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/input/misc/pwm-beeper.c:73:62: error: macro "DEVICE_ATTR_RW" passed 4 arguments, but takes just 1
      73 | static DEVICE_ATTR_RW(volume, 0644, volume_show, volume_store);
         |                                                              ^
   In file included from include/linux/input.h:19,
                    from drivers/input/misc/pwm-beeper.c:11:
   include/linux/device.h:131: note: macro "DEVICE_ATTR_RW" defined here
     131 | #define DEVICE_ATTR_RW(_name) \
         | 
>> drivers/input/misc/pwm-beeper.c:73:8: error: type defaults to 'int' in declaration of 'DEVICE_ATTR_RW' [-Werror=implicit-int]
      73 | static DEVICE_ATTR_RW(volume, 0644, volume_show, volume_store);
         |        ^~~~~~~~~~~~~~
>> drivers/input/misc/pwm-beeper.c:77:10: error: 'dev_attr_volume' undeclared here (not in a function); did you mean 'dev_attr_max_volume'?
      77 |         &dev_attr_volume.attr,
         |          ^~~~~~~~~~~~~~~
         |          dev_attr_max_volume
   drivers/input/misc/pwm-beeper.c:73:8: warning: 'DEVICE_ATTR_RW' defined but not used [-Wunused-variable]
      73 | static DEVICE_ATTR_RW(volume, 0644, volume_show, volume_store);
         |        ^~~~~~~~~~~~~~
   drivers/input/misc/pwm-beeper.c:54:16: warning: 'volume_store' defined but not used [-Wunused-function]
      54 | static ssize_t volume_store(struct device *dev,
         |                ^~~~~~~~~~~~
   drivers/input/misc/pwm-beeper.c:38:16: warning: 'volume_show' defined but not used [-Wunused-function]
      38 | static ssize_t volume_show(struct device *dev,
         |                ^~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/DEVICE_ATTR_RW +73 drivers/input/misc/pwm-beeper.c

  > 11	#include <linux/input.h>
    12	#include <linux/regulator/consumer.h>
    13	#include <linux/module.h>
    14	#include <linux/kernel.h>
    15	#include <linux/of.h>
    16	#include <linux/platform_device.h>
    17	#include <linux/property.h>
    18	#include <linux/pwm.h>
    19	#include <linux/slab.h>
    20	#include <linux/workqueue.h>
    21	
    22	struct pwm_beeper {
    23		struct input_dev *input;
    24		struct pwm_device *pwm;
    25		struct regulator *amplifier;
    26		struct work_struct work;
    27		unsigned long period;
    28		unsigned int bell_frequency;
    29		bool suspended;
    30		bool amplifier_on;
    31		unsigned int volume;
    32		unsigned int *volume_levels;
    33		unsigned int max_volume;
    34	};
    35	
    36	#define HZ_TO_NANOSECONDS(x) (1000000000UL/(x))
    37	
    38	static ssize_t volume_show(struct device *dev,
    39			struct device_attribute *attr, char *buf)
    40	{
    41		struct pwm_beeper *beeper = dev_get_drvdata(dev);
    42	
    43		return sprintf(buf, "%d\n", beeper->volume);
    44	}
    45	
    46	static ssize_t max_volume_show(struct device *dev,
    47			struct device_attribute *attr, char *buf)
    48	{
    49		struct pwm_beeper *beeper = dev_get_drvdata(dev);
    50	
    51		return sprintf(buf, "%d\n", beeper->max_volume);
    52	}
    53	
    54	static ssize_t volume_store(struct device *dev,
    55			struct device_attribute *attr, const char *buf, size_t count)
    56	{
    57		int rc;
    58		struct pwm_beeper *beeper = dev_get_drvdata(dev);
    59		unsigned int volume;
    60	
    61		rc = kstrtouint(buf, 0, &volume);
    62		if (rc)
    63			return rc;
    64	
    65		if (volume > beeper->max_volume)
    66			return -EINVAL;
    67		pr_debug("set volume to %u\n", volume);
    68		beeper->volume = volume;
    69	
    70		return count;
    71	}
    72	
  > 73	static DEVICE_ATTR_RW(volume, 0644, volume_show, volume_store);
    74	static DEVICE_ATTR(max_volume, 0644, max_volume_show, NULL);
    75	
    76	static struct attribute *pwm_beeper_attributes[] = {
  > 77		&dev_attr_volume.attr,
    78		&dev_attr_max_volume.attr,
    79		NULL,
    80	};
    81	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
