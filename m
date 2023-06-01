Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A0771F263
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjFASvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjFASvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:51:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42908134;
        Thu,  1 Jun 2023 11:51:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3541648BE;
        Thu,  1 Jun 2023 18:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CDCC433D2;
        Thu,  1 Jun 2023 18:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685645480;
        bh=NzFKQrKH2EGIDNJCTAvo1LDUfNwrEY35AUDBGHhf5SM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nO+/7wk2iFDEmxoYeU3df/fnTl4MCfLWJSfl1zHAJHhjyOa+KEapJAagfl4LsjwTK
         qqNV0OZD79D57aUVICjHQHswmrZUdDXEQeDVK0Zmb0j+Dlk2vEC9kNT17MXF0Kgat+
         ZqG1MaQ+pD+8R1fDmczfYz891077Yv1Sxow0dT49wG1/GPzILe5aSZRVQLQJePdaOp
         cIqstT1SRENZxNU2jEv5nB2n35aj1slBp7JXTkZHJvPE0wkE4D+NBsoO4WO50eF7u6
         MS1ochzolazML+M22dqSOXGDDTxQjor5vUPccx7yzuzFSiW58OITqCAKuIo7dFd3Wu
         BSgtrZuz4zw4Q==
Date:   Thu, 1 Jun 2023 19:51:16 +0100
From:   Lee Jones <lee@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Pavel Machek <pavel@ucw.cz>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Kalle Valo <kvalo@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, kernel@sberdevices.ru
Subject: Re: [PATCH v1] leds: trigger: pattern: add support for hrtimer
Message-ID: <20230601185116.GL449117@google.com>
References: <20230522190412.374474-1-mmkurbanov@sberdevices.ru>
 <202305230549.ekneaQ89-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202305230549.ekneaQ89-lkp@intel.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023, kernel test robot wrote:

> Hi Martin,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on lee-leds/for-leds-next]
> [also build test WARNING on wireless-next/main wireless/main linus/master v6.4-rc3 next-20230522]
> [cannot apply to pavel-leds/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Martin-Kurbanov/leds-trigger-pattern-add-support-for-hrtimer/20230523-030630
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git for-leds-next
> patch link:    https://lore.kernel.org/r/20230522190412.374474-1-mmkurbanov%40sberdevices.ru
> patch subject: [PATCH v1] leds: trigger: pattern: add support for hrtimer
> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230523/202305230549.ekneaQ89-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/084f274c07fd243e864f73ab80a9eda5e940f024
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Martin-Kurbanov/leds-trigger-pattern-add-support-for-hrtimer/20230523-030630
>         git checkout 084f274c07fd243e864f73ab80a9eda5e940f024
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/leds/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202305230549.ekneaQ89-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/leds/trigger/ledtrig-pattern.c: In function 'pattern_init':
> >> drivers/leds/trigger/ledtrig-pattern.c:454:74: warning: implicit conversion from 'enum <anonymous>' to 'enum pattern_type' [-Wenum-conversion]
>      454 |         err = pattern_trig_store_patterns(led_cdev, NULL, pattern, size, false);
>          |                                                                          ^~~~~
 
Did you fix this already? 

I don't see a subsequent submission?
 
> vim +454 drivers/leds/trigger/ledtrig-pattern.c
> 
> 5fd752b6b3a223 Baolin Wang         2018-10-11  438  
> aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  439  static void pattern_init(struct led_classdev *led_cdev)
> aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  440  {
> aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  441  	unsigned int size = 0;
> aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  442  	u32 *pattern;
> aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  443  	int err;
> aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  444  
> aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  445  	pattern = led_get_default_pattern(led_cdev, &size);
> aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  446  	if (!pattern)
> aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  447  		return;
> aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  448  
> aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  449  	if (size % 2) {
> aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  450  		dev_warn(led_cdev->dev, "Expected pattern of tuples\n");
> aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  451  		goto out;
> aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  452  	}
> aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  453  
> aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09 @454  	err = pattern_trig_store_patterns(led_cdev, NULL, pattern, size, false);
> aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  455  	if (err < 0)
> aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  456  		dev_warn(led_cdev->dev,
> aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  457  			 "Pattern initialization failed with error %d\n", err);
> aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  458  
> aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  459  out:
> aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  460  	kfree(pattern);
> aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  461  }
> aa6fd10481bdb1 Krzysztof Kozlowski 2019-01-09  462  
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

-- 
Lee Jones [李琼斯]
