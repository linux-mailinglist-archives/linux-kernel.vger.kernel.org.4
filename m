Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135396A4FD9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 00:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjB0XwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 18:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjB0XwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 18:52:10 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE89829E13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 15:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677541928; x=1709077928;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0hu4ygXuFVSKvu6cm5ZSH8hAwRI3iH0qbGwBD+G1d7A=;
  b=QpaYQr4d9XFAP2yGm8NdJcoYJzrwPmQT4ZlPfBDCJM2loYR8V05L8ySK
   34oIE8vjap4CVAjZgqPQhqwPS/PZJmuSwkoGlfR7wQZCJlgy6FH9f3lFF
   i1nabbHtoQF63qWnu3IbWsWLeRNvJFpFwwcHC3zJgR08JvuyXCW74rfNV
   5OclaxDq0A3/78LrrQb8N6Rc6bK+suTVDfQ+NTWIeQZo0qQ+JFljc/f6Q
   aZjwh/4+eEZkArVpL9j2XFwjP5N2CrFLEfYHsJekVbSrHqQ1eUKwN/xr/
   5Wosx5Y23W+iK3R8vMaM4jEnazJijCqGNkcDgskDCYjzxyipRWdT1EhZI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="332725701"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="332725701"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 15:52:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="673924596"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="673924596"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 27 Feb 2023 15:52:06 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pWnHp-0004tC-33;
        Mon, 27 Feb 2023 23:52:05 +0000
Date:   Tue, 28 Feb 2023 07:51:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: drivers/clk/.kunitconfig: warning: ignored by one of the .gitignore
 files
Message-ID: <202302280702.GPo16kcF-lkp@intel.com>
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
head:   982818426a0ffaf93b0621826ed39a84be3d7d62
commit: 91ecf7ff1b036f3fe1183809661119b1ee109b19 kbuild: make W=1 warn files that are tracked but ignored by git
date:   5 weeks ago
config: i386-randconfig-a004-20230227 (https://download.01.org/0day-ci/archive/20230228/202302280702.GPo16kcF-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=91ecf7ff1b036f3fe1183809661119b1ee109b19
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 91ecf7ff1b036f3fe1183809661119b1ee109b19
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302280702.GPo16kcF-lkp@intel.com/

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
