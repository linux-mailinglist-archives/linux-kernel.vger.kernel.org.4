Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526735B5D64
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 17:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiILPkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 11:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiILPj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 11:39:57 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E43A11C33
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 08:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662997195; x=1694533195;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UaFs3dRUJ7XAbN0M5SfwGdryLbvtEy5Bqx+nuyXFNvo=;
  b=P5GHVaNG67mJQLzq9li8dcViTd4yvL8Iekv8luCAbW12vO6dhUyIiC7W
   ZR/6PAQJcb+2grUlzrwyCBYFCTj1K5n/R6bYmaMB0QgwIKJ8G6FO7E4z0
   naGTwnVFpX6AgaobDgJB17YlZpra+ZIIuX04LqYuR2QgN8Rsa4NQo7YCr
   dz0WAfugeti7L+Hv3oc7rIo5XRI/bYEot7WgZKINlj4wdiC737plnBzfE
   mOTX1Bq1NJWqG3qQeqRaspYZgWin1ITTFoJnNy8x0CgSWdZ66DwM2nX/o
   t62s18VywvZSGL97VtucSzr4MUjg42OeXezDQ29pFyxD6Nwo8XOA77SrC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="324130586"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="324130586"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 08:39:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="758435197"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 12 Sep 2022 08:39:53 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXlXM-0002ch-1P;
        Mon, 12 Sep 2022 15:39:52 +0000
Date:   Mon, 12 Sep 2022 23:39:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>,
        Mark Brown <broonie@kernel.org>
Subject: [asahilinux:bits/070-audio 33/37] drivers/clk/clk.c:866:6: error:
 redefinition of 'clk_unprepare'
Message-ID: <202209122353.geLjrPFf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

First bad commit (maybe != root cause):

tree:   https://github.com/AsahiLinux/linux bits/070-audio
head:   93c9bcdfb0090e2e719e420285e444906789ea27
commit: b10958b63639b69a4d091ab76e861a91fefa38ad [33/37] ASoC: apple: mca: Start new platform driver
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220912/202209122353.geLjrPFf-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/b10958b63639b69a4d091ab76e861a91fefa38ad
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/070-audio
        git checkout b10958b63639b69a4d091ab76e861a91fefa38ad
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/clk/clk.c:866:6: error: redefinition of 'clk_unprepare'
     866 | void clk_unprepare(struct clk *clk)
         |      ^~~~~~~~~~~~~
   In file included from drivers/clk/clk.c:9:
   include/linux/clk.h:303:20: note: previous definition of 'clk_unprepare' with type 'void(struct clk *)'
     303 | static inline void clk_unprepare(struct clk *clk)
         |                    ^~~~~~~~~~~~~
>> drivers/clk/clk.c:947:5: error: redefinition of 'clk_prepare'
     947 | int clk_prepare(struct clk *clk)
         |     ^~~~~~~~~~~
   include/linux/clk.h:271:19: note: previous definition of 'clk_prepare' with type 'int(struct clk *)'
     271 | static inline int clk_prepare(struct clk *clk)
         |                   ^~~~~~~~~~~
>> drivers/clk/clk.c:1193:6: error: redefinition of 'clk_is_enabled_when_prepared'
    1193 | bool clk_is_enabled_when_prepared(struct clk *clk)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/clk.h:284:20: note: previous definition of 'clk_is_enabled_when_prepared' with type 'bool(struct clk *)' {aka '_Bool(struct clk *)'}
     284 | static inline bool clk_is_enabled_when_prepared(struct clk *clk)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for COMMON_CLK
   Depends on [n]: !HAVE_LEGACY_CLK [=y]
   Selected by [m]:
   - SND_SOC_APPLE_MCA [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && (ARCH_APPLE || COMPILE_TEST [=y])
   WARNING: unmet direct dependencies detected for APPLE_ADMAC
   Depends on [n]: DMADEVICES [=n] && (ARCH_APPLE || COMPILE_TEST [=y])
   Selected by [m]:
   - SND_SOC_APPLE_MACAUDIO [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && (ARCH_APPLE || COMPILE_TEST [=y])


vim +/clk_unprepare +866 drivers/clk/clk.c

a6adc30ba7bef8 Dong Aisheng     2016-06-30  854  
4dff95dc9477a3 Stephen Boyd     2015-04-30  855  /**
4dff95dc9477a3 Stephen Boyd     2015-04-30  856   * clk_unprepare - undo preparation of a clock source
4dff95dc9477a3 Stephen Boyd     2015-04-30  857   * @clk: the clk being unprepared
4dff95dc9477a3 Stephen Boyd     2015-04-30  858   *
4dff95dc9477a3 Stephen Boyd     2015-04-30  859   * clk_unprepare may sleep, which differentiates it from clk_disable.  In a
4dff95dc9477a3 Stephen Boyd     2015-04-30  860   * simple case, clk_unprepare can be used instead of clk_disable to gate a clk
4dff95dc9477a3 Stephen Boyd     2015-04-30  861   * if the operation may sleep.  One example is a clk which is accessed over
4dff95dc9477a3 Stephen Boyd     2015-04-30  862   * I2c.  In the complex case a clk gate operation may require a fast and a slow
4dff95dc9477a3 Stephen Boyd     2015-04-30  863   * part.  It is this reason that clk_unprepare and clk_disable are not mutually
4dff95dc9477a3 Stephen Boyd     2015-04-30  864   * exclusive.  In fact clk_disable must be called before clk_unprepare.
4dff95dc9477a3 Stephen Boyd     2015-04-30  865   */
4dff95dc9477a3 Stephen Boyd     2015-04-30 @866  void clk_unprepare(struct clk *clk)
b2476490ef1113 Mike Turquette   2012-03-15  867  {
4dff95dc9477a3 Stephen Boyd     2015-04-30  868  	if (IS_ERR_OR_NULL(clk))
4dff95dc9477a3 Stephen Boyd     2015-04-30  869  		return;
b2476490ef1113 Mike Turquette   2012-03-15  870  
a6adc30ba7bef8 Dong Aisheng     2016-06-30  871  	clk_core_unprepare_lock(clk->core);
1e435256d625c2 Olof Johansson   2013-04-27  872  }
4dff95dc9477a3 Stephen Boyd     2015-04-30  873  EXPORT_SYMBOL_GPL(clk_unprepare);
1e435256d625c2 Olof Johansson   2013-04-27  874  
4dff95dc9477a3 Stephen Boyd     2015-04-30  875  static int clk_core_prepare(struct clk_core *core)
4dff95dc9477a3 Stephen Boyd     2015-04-30  876  {
4dff95dc9477a3 Stephen Boyd     2015-04-30  877  	int ret = 0;
b2476490ef1113 Mike Turquette   2012-03-15  878  
a63347251907d7 Stephen Boyd     2015-05-06  879  	lockdep_assert_held(&prepare_lock);
a63347251907d7 Stephen Boyd     2015-05-06  880  
4dff95dc9477a3 Stephen Boyd     2015-04-30  881  	if (!core)
4dff95dc9477a3 Stephen Boyd     2015-04-30  882  		return 0;
b2476490ef1113 Mike Turquette   2012-03-15  883  
4dff95dc9477a3 Stephen Boyd     2015-04-30  884  	if (core->prepare_count == 0) {
9a34b45397e5a3 Marek Szyprowski 2017-08-21  885  		ret = clk_pm_runtime_get(core);
4dff95dc9477a3 Stephen Boyd     2015-04-30  886  		if (ret)
4dff95dc9477a3 Stephen Boyd     2015-04-30  887  			return ret;
b2476490ef1113 Mike Turquette   2012-03-15  888  
9a34b45397e5a3 Marek Szyprowski 2017-08-21  889  		ret = clk_core_prepare(core->parent);
9a34b45397e5a3 Marek Szyprowski 2017-08-21  890  		if (ret)
9a34b45397e5a3 Marek Szyprowski 2017-08-21  891  			goto runtime_put;
9a34b45397e5a3 Marek Szyprowski 2017-08-21  892  
4dff95dc9477a3 Stephen Boyd     2015-04-30  893  		trace_clk_prepare(core);
1c155b3dfe0835 Ulf Hansson      2013-03-12  894  
4dff95dc9477a3 Stephen Boyd     2015-04-30  895  		if (core->ops->prepare)
4dff95dc9477a3 Stephen Boyd     2015-04-30  896  			ret = core->ops->prepare(core->hw);
1c155b3dfe0835 Ulf Hansson      2013-03-12  897  
4dff95dc9477a3 Stephen Boyd     2015-04-30  898  		trace_clk_prepare_complete(core);
b2476490ef1113 Mike Turquette   2012-03-15  899  
9a34b45397e5a3 Marek Szyprowski 2017-08-21  900  		if (ret)
9a34b45397e5a3 Marek Szyprowski 2017-08-21  901  			goto unprepare;
b2476490ef1113 Mike Turquette   2012-03-15  902  	}
b2476490ef1113 Mike Turquette   2012-03-15  903  
4dff95dc9477a3 Stephen Boyd     2015-04-30  904  	core->prepare_count++;
b2476490ef1113 Mike Turquette   2012-03-15  905  
9461f7b33d11cb Jerome Brunet    2018-06-19  906  	/*
9461f7b33d11cb Jerome Brunet    2018-06-19  907  	 * CLK_SET_RATE_GATE is a special case of clock protection
9461f7b33d11cb Jerome Brunet    2018-06-19  908  	 * Instead of a consumer claiming exclusive rate control, it is
9461f7b33d11cb Jerome Brunet    2018-06-19  909  	 * actually the provider which prevents any consumer from making any
9461f7b33d11cb Jerome Brunet    2018-06-19  910  	 * operation which could result in a rate change or rate glitch while
9461f7b33d11cb Jerome Brunet    2018-06-19  911  	 * the clock is prepared.
9461f7b33d11cb Jerome Brunet    2018-06-19  912  	 */
9461f7b33d11cb Jerome Brunet    2018-06-19  913  	if (core->flags & CLK_SET_RATE_GATE)
9461f7b33d11cb Jerome Brunet    2018-06-19  914  		clk_core_rate_protect(core);
9461f7b33d11cb Jerome Brunet    2018-06-19  915  
4dff95dc9477a3 Stephen Boyd     2015-04-30  916  	return 0;
9a34b45397e5a3 Marek Szyprowski 2017-08-21  917  unprepare:
9a34b45397e5a3 Marek Szyprowski 2017-08-21  918  	clk_core_unprepare(core->parent);
9a34b45397e5a3 Marek Szyprowski 2017-08-21  919  runtime_put:
9a34b45397e5a3 Marek Szyprowski 2017-08-21  920  	clk_pm_runtime_put(core);
9a34b45397e5a3 Marek Szyprowski 2017-08-21  921  	return ret;
b2476490ef1113 Mike Turquette   2012-03-15  922  }
b2476490ef1113 Mike Turquette   2012-03-15  923  
a6adc30ba7bef8 Dong Aisheng     2016-06-30  924  static int clk_core_prepare_lock(struct clk_core *core)
a6adc30ba7bef8 Dong Aisheng     2016-06-30  925  {
a6adc30ba7bef8 Dong Aisheng     2016-06-30  926  	int ret;
a6adc30ba7bef8 Dong Aisheng     2016-06-30  927  
a6adc30ba7bef8 Dong Aisheng     2016-06-30  928  	clk_prepare_lock();
a6adc30ba7bef8 Dong Aisheng     2016-06-30  929  	ret = clk_core_prepare(core);
a6adc30ba7bef8 Dong Aisheng     2016-06-30  930  	clk_prepare_unlock();
a6adc30ba7bef8 Dong Aisheng     2016-06-30  931  
a6adc30ba7bef8 Dong Aisheng     2016-06-30  932  	return ret;
a6adc30ba7bef8 Dong Aisheng     2016-06-30  933  }
a6adc30ba7bef8 Dong Aisheng     2016-06-30  934  
4dff95dc9477a3 Stephen Boyd     2015-04-30  935  /**
4dff95dc9477a3 Stephen Boyd     2015-04-30  936   * clk_prepare - prepare a clock source
4dff95dc9477a3 Stephen Boyd     2015-04-30  937   * @clk: the clk being prepared
4dff95dc9477a3 Stephen Boyd     2015-04-30  938   *
4dff95dc9477a3 Stephen Boyd     2015-04-30  939   * clk_prepare may sleep, which differentiates it from clk_enable.  In a simple
4dff95dc9477a3 Stephen Boyd     2015-04-30  940   * case, clk_prepare can be used instead of clk_enable to ungate a clk if the
4dff95dc9477a3 Stephen Boyd     2015-04-30  941   * operation may sleep.  One example is a clk which is accessed over I2c.  In
4dff95dc9477a3 Stephen Boyd     2015-04-30  942   * the complex case a clk ungate operation may require a fast and a slow part.
4dff95dc9477a3 Stephen Boyd     2015-04-30  943   * It is this reason that clk_prepare and clk_enable are not mutually
4dff95dc9477a3 Stephen Boyd     2015-04-30  944   * exclusive.  In fact clk_prepare must be called before clk_enable.
4dff95dc9477a3 Stephen Boyd     2015-04-30  945   * Returns 0 on success, -EERROR otherwise.
4dff95dc9477a3 Stephen Boyd     2015-04-30  946   */
4dff95dc9477a3 Stephen Boyd     2015-04-30 @947  int clk_prepare(struct clk *clk)
b2476490ef1113 Mike Turquette   2012-03-15  948  {
035a61c314eb3d Tomeu Vizoso     2015-01-23  949  	if (!clk)
4dff95dc9477a3 Stephen Boyd     2015-04-30  950  		return 0;
035a61c314eb3d Tomeu Vizoso     2015-01-23  951  
a6adc30ba7bef8 Dong Aisheng     2016-06-30  952  	return clk_core_prepare_lock(clk->core);
7ef3dcc8145263 James Hogan      2013-07-29  953  }
4dff95dc9477a3 Stephen Boyd     2015-04-30  954  EXPORT_SYMBOL_GPL(clk_prepare);
035a61c314eb3d Tomeu Vizoso     2015-01-23  955  

:::::: The code at line 866 was first introduced by commit
:::::: 4dff95dc9477a34de77d24c59dcf1dc593687fcf clk: Remove forward declared function prototypes

:::::: TO: Stephen Boyd <sboyd@codeaurora.org>
:::::: CC: Stephen Boyd <sboyd@codeaurora.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
