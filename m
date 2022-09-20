Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C6C5BED93
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 21:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiITTX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 15:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiITTXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:23:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777135467E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 12:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663701782; x=1695237782;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KGOmGLFXa/AHId60Y5h76Pqaa93QttmT+20FZZNUBns=;
  b=gUWQLosH9h9ax5utUz3SXoVcTXhU6bgSpVSQHqjfo16/OSztY/RepVnd
   8z0VHHTLUz0RVPJwikoME8dtMjzmNfohy9cH00raRUZXXzoOORey9oVx/
   IvioQ2CFBnmoh6F/rrVwv1nohKPlaj1T6Us80mWfo76WvojKrom8omW3w
   dpxf5Kd7oi2rBhxR1E67cX8h4pZS0lltIridjUeFgF6eEfcFSsaGfSvaD
   RyClGw1dKZK47ybvDoGzw5YWnVvuJoN1Puk4O20aW2SJAW/ZH8PvVCsJN
   monsYg7hXmANtmSiIw2y37/S8fjInW/njYoW47PH3m8FmUvi79xUyFZeW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="363774040"
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="363774040"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 12:23:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="596647284"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 20 Sep 2022 12:23:00 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaipf-0002ub-2r;
        Tue, 20 Sep 2022 19:22:59 +0000
Date:   Wed, 21 Sep 2022 03:17:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ban Tao <fengzheng923@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [broonie-ci:20220920_kuninori_morimoto_gx_asoc_soc_h_random_cleanup
 35/44] sound/soc/sunxi/sun50i-dmic.c:268:34: warning: unused variable
 'sun50i_dmic_of_match'
Message-ID: <202209210327.k80A7Kzb-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git 20220920_kuninori_morimoto_gx_asoc_soc_h_random_cleanup
head:   3289dc026a8cf5d6469eb49d838bc971f4370f9d
commit: 9fc2c8ed923d8ec8a49cf5b5076c84867126ca69 [35/44] ASoC: sunxi: Add Allwinner H6 Digital MIC driver
config: arm-randconfig-r024-20220921 (https://download.01.org/0day-ci/archive/20220921/202209210327.k80A7Kzb-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git/commit/?id=9fc2c8ed923d8ec8a49cf5b5076c84867126ca69
        git remote add broonie-ci https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git
        git fetch --no-tags broonie-ci 20220920_kuninori_morimoto_gx_asoc_soc_h_random_cleanup
        git checkout 9fc2c8ed923d8ec8a49cf5b5076c84867126ca69
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash sound/soc/sunxi/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/sunxi/sun50i-dmic.c:268:34: warning: unused variable 'sun50i_dmic_of_match' [-Wunused-const-variable]
   static const struct of_device_id sun50i_dmic_of_match[] = {
                                    ^
   1 warning generated.


vim +/sun50i_dmic_of_match +268 sound/soc/sunxi/sun50i-dmic.c

   267	
 > 268	static const struct of_device_id sun50i_dmic_of_match[] = {
   269		{
   270			.compatible = "allwinner,sun50i-h6-dmic",
   271		},
   272		{ /* sentinel */ }
   273	};
   274	MODULE_DEVICE_TABLE(of, sun50i_dmic_of_match);
   275	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
