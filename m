Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83C96A47A2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjB0ROB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjB0RNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:13:36 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35552068D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677518013; x=1709054013;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EfJ+wiUku1hkq0d47Oy5g8m14Cz3X/xe9TB1bDrDMVg=;
  b=hv04K0b2vCgW6NFyolSPaFgHuooc6dpGwsvUC4PmkSM7gD5kOvcaKriA
   HrL/zOh70y11TT/29pzGTRRWSaKh1q/GsVdzaE4abB5a+67c1vJ4pay6Y
   xCrd1GjbfTBFnvXP7igZHJjpLy+p6ixythwmB+DzFE3w2aBFVMzK+WeH3
   QPHDrPo+fdICrCl/wbj9mmIGCuaDIm5Y5v5kXraBSkt6giLsX3a406+Ea
   bJ6YIj0g0o/nGEPZaH2M/n0UPyoR2Ut5rtE2/URpBoeGWnRxDbkHdkNnS
   aK8jTjK0uRNSctAeRsCg21XNLwNwQIinDholbJnrwLV3g02VIhDt5oArK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="314339983"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="314339983"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 09:09:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="704099478"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="704099478"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 27 Feb 2023 09:09:52 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pWh0Z-0004bv-0m;
        Mon, 27 Feb 2023 17:09:51 +0000
Date:   Tue, 28 Feb 2023 01:08:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: drivers/clk/.kunitconfig: warning: ignored by one of the .gitignore
 files
Message-ID: <202302280150.LBCCD7Fo-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f3a2439f20d918930cc4ae8f76fe1c1afd26958f
commit: 91ecf7ff1b036f3fe1183809661119b1ee109b19 kbuild: make W=1 warn files that are tracked but ignored by git
date:   5 weeks ago
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20230228/202302280150.LBCCD7Fo-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=91ecf7ff1b036f3fe1183809661119b1ee109b19
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 91ecf7ff1b036f3fe1183809661119b1ee109b19
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302280150.LBCCD7Fo-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Documentation/devicetree/bindings/.yamllint: warning: ignored by one of the .gitignore files
>> drivers/clk/.kunitconfig: warning: ignored by one of the .gitignore files
>> drivers/gpu/drm/tests/.kunitconfig: warning: ignored by one of the .gitignore files
>> drivers/hid/.kunitconfig: warning: ignored by one of the .gitignore files
>> fs/ext4/.kunitconfig: warning: ignored by one of the .gitignore files
>> fs/fat/.kunitconfig: warning: ignored by one of the .gitignore files
>> kernel/kcsan/.kunitconfig: warning: ignored by one of the .gitignore files
>> lib/kunit/.kunitconfig: warning: ignored by one of the .gitignore files
>> mm/kfence/.kunitconfig: warning: ignored by one of the .gitignore files
>> tools/testing/selftests/arm64/tags/.gitignore: warning: ignored by one of the .gitignore files
>> tools/testing/selftests/arm64/tags/Makefile: warning: ignored by one of the .gitignore files
>> tools/testing/selftests/arm64/tags/run_tags_test.sh: warning: ignored by one of the .gitignore files
>> tools/testing/selftests/arm64/tags/tags_test.c: warning: ignored by one of the .gitignore files
>> tools/testing/selftests/kvm/.gitignore: warning: ignored by one of the .gitignore files
>> tools/testing/selftests/kvm/Makefile: warning: ignored by one of the .gitignore files
>> tools/testing/selftests/kvm/config: warning: ignored by one of the .gitignore files
>> tools/testing/selftests/kvm/settings: warning: ignored by one of the .gitignore files

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
