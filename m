Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363BD72CEDC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbjFLS7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFLS7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:59:16 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3349313A;
        Mon, 12 Jun 2023 11:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686596355; x=1718132355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VZa1fYkJlOSJPNfqG8vxxOmpB4Z55y+Js6DTs8pgAj4=;
  b=MOPLBkzPlZTP0DbGBZi8WmXlvGBp6P+EYEC+Zz2kfTnzbrv7Wn68sHnH
   gPtsxHSF46qQloZp6LNeaVQnKz2f1cDMx3IX5xk3Oc4nqpGZZ9lzqsfsT
   hlVqi1Wm1grmxoTfZ7GZXwZhgxi/SNVs2FEhYbIKLmE/xbhieZxu520LR
   YXJbec/mVHBQeBHjgs74G1lG1y/ubV2wCClJuGym57+dkjyXUu/pCUICh
   yoDOItDinHIHQvlRSl460Ah0iuB9MdTNiLtd2LiazhsBWiLfEWwcyBqen
   kTjz64Ebxp+h+TxiqRrFnef00A4qDFENQOpo4MAM4kFd37Z3KHmhkwKxb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="342820431"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="342820431"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 11:59:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="801125292"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="801125292"
Received: from lkp-server01.sh.intel.com (HELO 211f47bdb1cb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jun 2023 11:59:11 -0700
Received: from kbuild by 211f47bdb1cb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q8mkw-0000aG-34;
        Mon, 12 Jun 2023 18:59:10 +0000
Date:   Tue, 13 Jun 2023 02:58:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] rtc: isl12022: add support for trip level DT bindings
Message-ID: <202306130201.ai7ck1mx-lkp@intel.com>
References: <20230612113059.247275-5-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612113059.247275-5-linux@rasmusvillemoes.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rasmus,

kernel test robot noticed the following build errors:

[auto build test ERROR on abelloni/rtc-next]
[also build test ERROR on robh/for-next linus/master v6.4-rc6 next-20230609]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rasmus-Villemoes/rtc-isl12022-remove-wrong-warning-for-low-battery-level/20230612-211434
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
patch link:    https://lore.kernel.org/r/20230612113059.247275-5-linux%40rasmusvillemoes.dk
patch subject: [PATCH 4/8] rtc: isl12022: add support for trip level DT bindings
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230613/202306130201.ai7ck1mx-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add abelloni https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git
        git fetch abelloni rtc-next
        git checkout abelloni/rtc-next
        b4 shazam https://lore.kernel.org/r/20230612113059.247275-5-linux@rasmusvillemoes.dk
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306130201.ai7ck1mx-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/rtc/rtc-isl12022.c: In function 'isl12022_set_trip_levels':
>> drivers/rtc/rtc-isl12022.c:238:15: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     238 |         val = FIELD_PREP(ISL12022_REG_VB85_MASK, x85) | FIELD_PREP(ISL12022_REG_VB75_MASK, x75);
         |               ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_PREP +238 drivers/rtc/rtc-isl12022.c

   219	
   220	static void isl12022_set_trip_levels(struct device *dev)
   221	{
   222		struct regmap *regmap = dev_get_drvdata(dev);
   223		u32 level85 = 0, level75 = 0;
   224		int ret, x85, x75;
   225		u8 val, mask;
   226	
   227		device_property_read_u32(dev, "isil,trip-level85-microvolt", &level85);
   228		device_property_read_u32(dev, "isil,trip-level75-microvolt", &level75);
   229	
   230		for (x85 = 0; x85 < ARRAY_SIZE(trip_level85) - 1; ++x85)
   231			if (level85 <= trip_level85[x85])
   232				break;
   233	
   234		for (x75 = 0; x75 < ARRAY_SIZE(trip_level75) - 1; ++x75)
   235			if (level75 <= trip_level75[x75])
   236				break;
   237	
 > 238		val = FIELD_PREP(ISL12022_REG_VB85_MASK, x85) | FIELD_PREP(ISL12022_REG_VB75_MASK, x75);
   239		mask = ISL12022_REG_VB85_MASK | ISL12022_REG_VB75_MASK;
   240	
   241		ret = regmap_update_bits(regmap, ISL12022_REG_PWR_VBAT, mask, val);
   242		if (ret)
   243			dev_warn(dev, "unable to set battery alarm levels: %d\n", ret);
   244	}
   245	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
