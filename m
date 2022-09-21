Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1C95E560E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 00:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiIUWIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 18:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiIUWIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 18:08:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7DFA7A81
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 15:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663798126; x=1695334126;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J5sdTliUZkkADTPmofCXCPMN8Kv7ofWiA5H88bZiwcE=;
  b=Sy+GYlaX5NY4eCkYWJjbs/QUbmRYfnEK7gWAVh+bUJvhnKlS6D1lmt5Q
   owIbg+iU/uNtXyAN6DFY/neeSHpzEBwvCCHloGBHbme6qfjRsr2j0kWyR
   1yZYduI3rvTlJTZyRydUSb6TsJqiDvOIEycX0oU/U09OzNq5Ea/1ARFjL
   EteNyX1lnVJRO/Hd6wTEg+DY6/1jfd9uHqfGXhDngkxgaBcozbEZtpjaS
   5Ac0wAbPRYV2UyDWoYQTI04l2B4tYwgDk1oxsz95QWgAct20eNi8R/12r
   qtEIvAORbC+BCRmeN6bPtdGLxgFhxPmvy4QAeia7f0nZVg2ZOIK7lby5i
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="298853546"
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="298853546"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 15:08:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,334,1654585200"; 
   d="scan'208";a="597178246"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 21 Sep 2022 15:08:44 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ob7tc-00041U-04;
        Wed, 21 Sep 2022 22:08:44 +0000
Date:   Thu, 22 Sep 2022 06:08:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [jic23-iio:testing 58/58] drivers/iio/adc/mcp3911.c:274:13: warning:
 variable 'tmp0' set but not used
Message-ID: <202209220648.Wb6EtPat-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
head:   d4e1a549566b9ea8b96e80f0cdcbe99714ac256e
commit: d4e1a549566b9ea8b96e80f0cdcbe99714ac256e [58/58] iio: adc: mcp3911: add support to set PGA
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20220922/202209220648.Wb6EtPat-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?id=d4e1a549566b9ea8b96e80f0cdcbe99714ac256e
        git remote add jic23-iio https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
        git fetch --no-tags jic23-iio testing
        git checkout d4e1a549566b9ea8b96e80f0cdcbe99714ac256e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/iio/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/iio/adc/mcp3911.c: In function 'mcp3911_calc_scale_table':
>> drivers/iio/adc/mcp3911.c:274:13: warning: variable 'tmp0' set but not used [-Wunused-but-set-variable]
     274 |         int tmp0, tmp1;
         |             ^~~~


vim +/tmp0 +274 drivers/iio/adc/mcp3911.c

   268	
   269	static int mcp3911_calc_scale_table(struct mcp3911 *adc)
   270	{
   271		u32 ref = MCP3911_INT_VREF_MV;
   272		u32 div;
   273		int ret;
 > 274		int tmp0, tmp1;
   275		s64 tmp2;
   276	
   277		if (adc->vref) {
   278			ret = regulator_get_voltage(adc->vref);
   279			if (ret < 0) {
   280				dev_err(&adc->spi->dev,
   281					"failed to get vref voltage: %d\n",
   282				       ret);
   283				return ret;
   284			}
   285	
   286			ref = ret / 1000;
   287		}
   288	
   289		/*
   290		 * For 24-bit Conversion
   291		 * Raw = ((Voltage)/(Vref) * 2^23 * Gain * 1.5
   292		 * Voltage = Raw * (Vref)/(2^23 * Gain * 1.5)
   293		 *
   294		 * ref = Reference voltage
   295		 * div = (2^23 * 1.5 * gain) = 12582912 * gain
   296		 */
   297		for (int i = 0; i < MCP3911_NUM_SCALES; i++) {
   298			div = 12582912 * BIT(i);
   299			tmp2 = div_s64((s64)ref * 1000000000LL, div);
   300			tmp1 = div;
   301			tmp0 = (int)div_s64_rem(tmp2, 1000000000, &tmp1);
   302	
   303			mcp3911_scale_table[i][0] = 0;
   304			mcp3911_scale_table[i][1] = tmp1;
   305		}
   306	
   307		return 0;
   308	}
   309	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
