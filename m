Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3B66E31F6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 16:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjDOOoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 10:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjDOOo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 10:44:26 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75BF4C32
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 07:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681569861; x=1713105861;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c2lMCSvwqFQY1REy4vSaDvs3TbQ8k9zYaciNwSsJzNY=;
  b=L0FmrDw/+RIfJzu4QfR5xbo8HIw3Lq/WBFoWQ7PlVhkbmK2UekUK1txm
   D0a/B3NsZrCP1oePtcM1iY+b1nJL97t9jfkyCXhx7J8lhirPN4lEKytqs
   bOmmXPbMIM73te5eIIb4ofPaFpQMSM1LKd8JxQLS483SGcvzSS/jRADV+
   gNIPpK1qolhPx9karZGcInnG7QpDkyLuKb3bvXydJpypW/dt0+fYok28F
   kNTZBRG8/l8paCYO1H/Ym11C73mYIeHdaWYi86PuTwvqlB8yX5kfdRVDF
   FImTXr5FdiNyNDAU3uGlCHrpy4+7zicthjW0DrWjBlOpsfpqDQUg8fQrn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10681"; a="343407702"
X-IronPort-AV: E=Sophos;i="5.99,199,1677571200"; 
   d="scan'208";a="343407702"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2023 07:43:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10681"; a="814269800"
X-IronPort-AV: E=Sophos;i="5.99,199,1677571200"; 
   d="scan'208";a="814269800"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Apr 2023 07:43:44 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pnh7v-000b7l-1w;
        Sat, 15 Apr 2023 14:43:43 +0000
Date:   Sat, 15 Apr 2023 22:43:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: refactor struct f2fs_attr macro
Message-ID: <202304152234.wjaY3IYm-lkp@intel.com>
References: <20230415132446.13063-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230415132446.13063-1-frank.li@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jaegeuk-f2fs/dev-test]
[also build test WARNING on jaegeuk-f2fs/dev]
[cannot apply to linus/master v6.3-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yangtao-Li/f2fs-refactor-struct-f2fs_attr-macro/20230415-212520
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
patch link:    https://lore.kernel.org/r/20230415132446.13063-1-frank.li%40vivo.com
patch subject: [PATCH] f2fs: refactor struct f2fs_attr macro
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230415/202304152234.wjaY3IYm-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/280d6a5b38dd6b5a5303f5426e9f71466a13f047
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yangtao-Li/f2fs-refactor-struct-f2fs_attr-macro/20230415-212520
        git checkout 280d6a5b38dd6b5a5303f5426e9f71466a13f047
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304152234.wjaY3IYm-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/f2fs/sysfs.c:981:1: warning: data definition has no type or storage class
     981 | FAULT_INFO_TYPE_GENERAL_RW_ATTR(inject_type);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/f2fs/sysfs.c:981:1: error: type defaults to 'int' in declaration of 'FAULT_INFO_TYPE_GENERAL_RW_ATTR' [-Werror=implicit-int]
>> fs/f2fs/sysfs.c:981:1: warning: parameter names (without types) in function declaration
   fs/f2fs/sysfs.c:1045:27: error: 'f2fs_attr_inject_type' undeclared here (not in a function); did you mean 'f2fs_attr_inject_rate'?
    1045 | #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
         |                           ^~~~~~~~~~
   fs/f2fs/sysfs.c:1094:9: note: in expansion of macro 'ATTR_LIST'
    1094 |         ATTR_LIST(inject_type),
         |         ^~~~~~~~~
   cc1: some warnings being treated as errors


vim +981 fs/f2fs/sysfs.c

   977	
   978	/* FAULT_INFO ATTR */
   979	#ifdef CONFIG_F2FS_FAULT_INJECTION
   980	FAULT_INFO_RATE_GENERAL_RW_ATTR(inject_rate);
 > 981	FAULT_INFO_TYPE_GENERAL_RW_ATTR(inject_type);
   982	#endif
   983	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
