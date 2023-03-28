Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F360A6CB671
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjC1F76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 01:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjC1F74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 01:59:56 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD5B1BFE;
        Mon, 27 Mar 2023 22:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679983194; x=1711519194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PHY7vJA/6nn35tg2GcYfN8n9ZPcx67cw+kTUlxblC8U=;
  b=AbshE1WQOANDaxUrnVbEu1v7ozA1bwF7p/u68TsbhTaRJ6UvfsTo7KE2
   6Rg5t1jA7u+m20QgCO4nIu39km7vI+2t5RvxQn8hgFIJgyfTwxkO/WUoO
   3ljStxgr1tPj060ZqOAIw1aBZKVeY6Wh90JdhxJ4p5rKTl2oLOAQ4yaqr
   eMQB2VeGuOsdJhmuisKGyO4cOR98NUHOukMFkkjH/vS+zbvS0TuJMuvXQ
   XOg4mBNbWRACOr7xTya4X2dHbcZj37uCIxwv9CIp/UA4xElmpe8cvU/WM
   LZFkZZrdiOC/mJw8vNw0FKFDONm3omZ4FuddFDIE2PK6o9tyAY7OZK/Py
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="342889355"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="342889355"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 22:59:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="929732531"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="929732531"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 27 Mar 2023 22:59:51 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ph2N4-000IKF-19;
        Tue, 28 Mar 2023 05:59:50 +0000
Date:   Tue, 28 Mar 2023 13:59:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v6 6/7] iio: light: ROHM BU27034 Ambient Light Sensor
Message-ID: <202303281338.X45nIbaD-lkp@intel.com>
References: <1b7d3725bf5ae829b12eaf96362204edd29c6966.1679915278.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b7d3725bf5ae829b12eaf96362204edd29c6966.1679915278.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,

I love your patch! Perhaps something to improve:

[auto build test WARNING on eeac8ede17557680855031c6f305ece2378af326]

url:    https://github.com/intel-lab-lkp/linux/commits/Matti-Vaittinen/dt-bindings-iio-light-Support-ROHM-BU27034/20230327-193728
base:   eeac8ede17557680855031c6f305ece2378af326
patch link:    https://lore.kernel.org/r/1b7d3725bf5ae829b12eaf96362204edd29c6966.1679915278.git.mazziesaccount%40gmail.com
patch subject: [PATCH v6 6/7] iio: light: ROHM BU27034 Ambient Light Sensor
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20230328/202303281338.X45nIbaD-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b824935db7c7734628f11c55cd64dc819be8798f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Matti-Vaittinen/dt-bindings-iio-light-Support-ROHM-BU27034/20230327-193728
        git checkout b824935db7c7734628f11c55cd64dc819be8798f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/iio/light/ drivers/media/i2c/ drivers/media/pci/intel/ drivers/net/usb/ net/netfilter/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303281338.X45nIbaD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/light/rohm-bu27034.c:402:8: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (mask)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
           val = FIELD_PREP(mask, sel);
                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:114:3: note: expanded from macro 'FIELD_PREP'
                   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:53: note: expanded from macro '__BF_FIELD_CHECK'
                   BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
   include/linux/compiler_types.h:397:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:385:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:377:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   1 warning generated.


vim +402 drivers/iio/light/rohm-bu27034.c

   388	
   389	/* Caller should hold the lock to protect lux reading */
   390	static int bu27034_write_gain_sel(struct bu27034_data *data, int chan, int sel)
   391	{
   392		static const int reg[] = {
   393			[BU27034_CHAN_DATA0] = BU27034_REG_MODE_CONTROL2,
   394			[BU27034_CHAN_DATA1] = BU27034_REG_MODE_CONTROL3,
   395		};
   396		int mask, val;
   397	
   398		if (chan != BU27034_CHAN_DATA0 && chan != BU27034_CHAN_DATA1)
   399			return -EINVAL;
   400	
   401		mask = BU27034_MASK_D01_GAIN;
 > 402		val = FIELD_PREP(mask, sel);
   403	
   404		if (chan == BU27034_CHAN_DATA0) {
   405			/*
   406			 * We keep the same gain for channel 2 as we set for channel 0
   407			 * We can't allow them to be individually controlled because
   408			 * setting one will impact also the other. Also, if we don't
   409			 * always update both gains we may result unsupported bit
   410			 * combinations.
   411			 *
   412			 * This is not nice but this is yet another place where the
   413			 * user space must be prepared to surprizes. Namely, see chan 2
   414			 * gain changed when chan 0 gain is changed.
   415			 *
   416			 * This is not fatal for most users though. I don't expect the
   417			 * channel 2 to be used in any generic cases - the intensity
   418			 * values provided by the sensor for IR area are not openly
   419			 * documented. Also, channel 2 is not used for visible light.
   420			 *
   421			 * So, if there is application which is written to utilize the
   422			 * channel 2 - then it is probably specifically targeted to this
   423			 * sensor and knows how to utilize those values. It is safe to
   424			 * hope such user can also cope with the gain changes.
   425			 */
   426			mask |=  BU27034_MASK_D2_GAIN_LO;
   427	
   428			/*
   429			 * The D2 gain bits are directly the lowest bits of selector.
   430			 * Just do add those bits to the value
   431			 */
   432			val |= sel & BU27034_MASK_D2_GAIN_LO;
   433		}
   434	
   435		return regmap_update_bits(data->regmap, reg[chan], mask, val);
   436	}
   437	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
