Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605C2679C28
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbjAXOlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbjAXOlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:41:06 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D91E305E0;
        Tue, 24 Jan 2023 06:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674571265; x=1706107265;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LW+kv6TOdMtz0nh46n0wIo2Rr8WZf++Ct0D8mbH2UMs=;
  b=WOvjXCpkPnTxP4ZfhZnDTj4SLVpBsI6kMC1M5A31ZUxfHs7TyQyv2rOG
   OZ/iMdacQkyUvGJzXoi8+29pUXeElyjD2J9j7SfR/QfRxmGdWDtm/cAr/
   g5d1A6lQ0y74uehZS0I9p3LlgpEdz15lRWgEkjZ763DPNJemVduicFxn1
   zKFV52K2HpxHQ30ZLyF9iDPGJRFRmA23+KOUFhiy+twQFkLLTipZdKVB3
   gXYa2UzX1pDSiUxzTzgw4ZPWTMjJea/G6JemjiFKZA/zDKZaEbCO+KreZ
   kCs/T8IXMxuNDvoubvdCXLBcUcnwVhdEY0CD/lSCovcjLkquwiKPKuRx8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="324983419"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="324983419"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 06:41:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="725494134"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="725494134"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jan 2023 06:41:02 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pKKTt-0006XM-2h;
        Tue, 24 Jan 2023 14:41:01 +0000
Date:   Tue, 24 Jan 2023 22:40:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manuel Traut <manuel.traut@mt.com>, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 1/3 v6] input: pwm-beeper: add feature to set volume level
Message-ID: <202301242226.E9z7kZKT-lkp@intel.com>
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

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on dtor-input/for-linus linus/master v6.2-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manuel-Traut/input-pwm-beeper-add-feature-to-set-volume-level/20230124-191549
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/Y8%2B9L7UincSjIaD9%40mt.com
patch subject: [PATCH 1/3 v6] input: pwm-beeper: add feature to set volume level
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230124/202301242226.E9z7kZKT-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/3468440a8e674e649dcf11e23f3fb3d229555e7c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Manuel-Traut/input-pwm-beeper-add-feature-to-set-volume-level/20230124-191549
        git checkout 3468440a8e674e649dcf11e23f3fb3d229555e7c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/input/misc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/input/misc/pwm-beeper.c:73:62: error: macro "DEVICE_ATTR_RW" passed 4 arguments, but takes just 1
      73 | static DEVICE_ATTR_RW(volume, 0644, volume_show, volume_store);
         |                                                              ^
   In file included from include/linux/input.h:19,
                    from drivers/input/misc/pwm-beeper.c:11:
   include/linux/device.h:131: note: macro "DEVICE_ATTR_RW" defined here
     131 | #define DEVICE_ATTR_RW(_name) \
         | 
   drivers/input/misc/pwm-beeper.c:73:8: error: type defaults to 'int' in declaration of 'DEVICE_ATTR_RW' [-Werror=implicit-int]
      73 | static DEVICE_ATTR_RW(volume, 0644, volume_show, volume_store);
         |        ^~~~~~~~~~~~~~
   drivers/input/misc/pwm-beeper.c:77:10: error: 'dev_attr_volume' undeclared here (not in a function); did you mean 'dev_attr_max_volume'?
      77 |         &dev_attr_volume.attr,
         |          ^~~~~~~~~~~~~~~
         |          dev_attr_max_volume
>> drivers/input/misc/pwm-beeper.c:73:8: warning: 'DEVICE_ATTR_RW' defined but not used [-Wunused-variable]
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

    72	
  > 73	static DEVICE_ATTR_RW(volume, 0644, volume_show, volume_store);
    74	static DEVICE_ATTR(max_volume, 0644, max_volume_show, NULL);
    75	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
