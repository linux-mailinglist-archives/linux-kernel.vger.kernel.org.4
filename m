Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFA86FB376
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 17:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbjEHPJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 11:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjEHPJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 11:09:43 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2D1C0;
        Mon,  8 May 2023 08:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683558582; x=1715094582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zs8Q8b77iyeTiU+NAG9KTWimf6AuNOLbyShHnGVJxFc=;
  b=YaG+TZG25CbO+we4TmkmV42Qhc3/EAz1uCQABGUB53VlTUrZylN23rYE
   bess5iqEl9vkuwxdAM5FhYnO4dtdhHrc+kMgDZf9LHpU+L0VD3WaF2nCD
   0wbzppdNJY7kwWkst4jDh3zLoK0BKozLWjp55qwJ//NHc0FIOKA2aZzpv
   bumbotBrRlQuOlzSb0SzA4SdDrwns1rxW8DeXrDyDZ7wIBat14UIV1Y0u
   BLffBefDOhxNg5a2mg3BgsQRdO9NzV5P6UN/sTGT9IvEFsylLEO3A5/Xr
   kCU0gKvMiZcmKk2jbJK8BJ5za3YTaO5IDpjAru3/F7uWDwbofgYxkla+P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="349706268"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="349706268"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 08:09:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="648917803"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="648917803"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 08 May 2023 08:09:35 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pw2UY-0001HF-1F;
        Mon, 08 May 2023 15:09:34 +0000
Date:   Mon, 8 May 2023 23:08:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Astrid Rost <astrid.rost@axis.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, kernel@axis.com,
        Astrid Rost <astridr@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/7] iio: light: vcnl4000: Add als_it for vcnl4040/4200
Message-ID: <202305082245.Fy28zlcu-lkp@intel.com>
References: <20230508070925.2123265-4-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508070925.2123265-4-astrid.rost@axis.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Astrid,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.4-rc1 next-20230508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Astrid-Rost/iio-light-vcnl4000-Add-proximity-ps_it-for-vcnl4200/20230508-161005
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20230508070925.2123265-4-astrid.rost%40axis.com
patch subject: [PATCH v1 3/7] iio: light: vcnl4000: Add als_it for vcnl4040/4200
config: i386-randconfig-a016-20230508 (https://download.01.org/0day-ci/archive/20230508/202305082245.Fy28zlcu-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/6ff2e1cf084f5b3038f2d72110fb01f2a8353a34
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Astrid-Rost/iio-light-vcnl4000-Add-proximity-ps_it-for-vcnl4200/20230508-161005
        git checkout 6ff2e1cf084f5b3038f2d72110fb01f2a8353a34
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305082245.Fy28zlcu-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/iio/light/vcnl4000.o: in function `vcnl4040_write_als_it':
>> drivers/iio/light/vcnl4000.c:580: undefined reference to `__divdi3'


vim +580 drivers/iio/light/vcnl4000.c

   552	
   553	static ssize_t vcnl4040_write_als_it(struct vcnl4000_data *data, int val)
   554	{
   555		unsigned int i;
   556		int ret, index = -1;
   557		u16 regval;
   558		const int(*als_it_times)[][2];
   559		int size;
   560	
   561		if (data->id == VCNL4200) {
   562			als_it_times = &vcnl4200_als_it_times;
   563			size = ARRAY_SIZE(vcnl4200_als_it_times);
   564		} else {
   565			als_it_times = &vcnl4040_als_it_times;
   566			size = ARRAY_SIZE(vcnl4040_als_it_times);
   567		}
   568	
   569		for (i = 0; i < size; i++) {
   570			if (val == (*als_it_times)[i][1]) {
   571				index = i;
   572				break;
   573			}
   574		}
   575	
   576		if (index < 0)
   577			return -EINVAL;
   578	
   579		data->vcnl4200_al.sampling_rate = ktime_set(0, val * 1200000);
 > 580		data->al_scale = 12000000000 / val;
   581	
   582		mutex_lock(&data->vcnl4000_lock);
   583	
   584		ret = i2c_smbus_read_word_data(data->client, VCNL4200_AL_CONF);
   585		if (ret < 0)
   586			goto out;
   587	
   588		regval = (ret & ~VCNL4040_ALS_CONF_IT) |
   589		    FIELD_PREP(VCNL4040_ALS_CONF_IT, index);
   590		ret = i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF,
   591						regval);
   592	
   593	out:
   594		mutex_unlock(&data->vcnl4000_lock);
   595		return ret;
   596	}
   597	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
