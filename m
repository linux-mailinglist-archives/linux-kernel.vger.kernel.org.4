Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C068A693406
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 22:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjBKVea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 16:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjBKVe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 16:34:29 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2470218B22;
        Sat, 11 Feb 2023 13:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676151268; x=1707687268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UGdEtbEAzbSERnty//wgt/U2Epe6F7MQ024/er2PNLc=;
  b=T/I4aLIJ78omiyrVriXFdLGF0LLgv1OANiAU2dlO4nMyTOfXF86KoG7X
   byVBDjC8E9fVF+NDil/1yFqR3o8O5gafQkUuOLBFI8TQ3s7q7C/RqEg19
   yKOGQL82ukyS0U4BUmsVclVZeE3P1Io6XkEkvXAwu/WzOr4cpjnHjj6f+
   t4MB7Veyw4L80EFBvsMnkIJYdjowIyItDg2dSdFW8qq3+TcYtjKMQwEI2
   AHbSB+XtYxwBHhT85uUkuwS95llOonNgzbi9wLVE/++3xegQowWurRAcP
   lHbHpwo1Rgev2RKQcW8wcTdjtkU+6AP82HZXWKwmw9mcu3h08466WCJtm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="328356077"
X-IronPort-AV: E=Sophos;i="5.97,290,1669104000"; 
   d="scan'208";a="328356077"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2023 13:34:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="737081913"
X-IronPort-AV: E=Sophos;i="5.97,290,1669104000"; 
   d="scan'208";a="737081913"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 11 Feb 2023 13:34:26 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQxVp-0006oj-1t;
        Sat, 11 Feb 2023 21:34:25 +0000
Date:   Sun, 12 Feb 2023 05:33:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Zaidman <michael.zaidman@gmail.com>, jikos@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
        Michael Zaidman <michael.zaidman@gmail.com>
Subject: Re: [PATCH v1 1/1] HID: ft260: add GPIO support
Message-ID: <202302120552.KrGf3GNw-lkp@intel.com>
References: <20230211115752.26276-2-michael.zaidman@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230211115752.26276-2-michael.zaidman@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

I love your patch! Perhaps something to improve:

[auto build test WARNING on hid/for-next]
[also build test WARNING on linus/master v6.2-rc7 next-20230210]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Zaidman/HID-ft260-add-GPIO-support/20230211-195918
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/20230211115752.26276-2-michael.zaidman%40gmail.com
patch subject: [PATCH v1 1/1] HID: ft260: add GPIO support
config: arm-randconfig-s041-20230210 (https://download.01.org/0day-ci/archive/20230212/202302120552.KrGf3GNw-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/d3ddadc80df8c149f97dc8ab8fa51ba53f5638cb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Michael-Zaidman/HID-ft260-add-GPIO-support/20230211-195918
        git checkout d3ddadc80df8c149f97dc8ab8fa51ba53f5638cb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/hid/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302120552.KrGf3GNw-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/hid/hid-ft260.c:1289:1: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [addressable] [usertype] clock @@
   drivers/hid/hid-ft260.c:1289:1: sparse:     expected unsigned short [usertype] value
   drivers/hid/hid-ft260.c:1289:1: sparse:     got restricted __le16 [addressable] [usertype] clock

vim +1289 drivers/hid/hid-ft260.c

6a82582d9fa438 Michael Zaidman 2021-02-19  1287  
6a82582d9fa438 Michael Zaidman 2021-02-19  1288  FT260_I2CST_ATTR_SHOW(clock);
6a82582d9fa438 Michael Zaidman 2021-02-19 @1289  FT260_WORD_ATTR_STORE(clock, ft260_set_i2c_speed_report,
d3ddadc80df8c1 Michael Zaidman 2023-02-11  1290  		      FT260_SET_I2C_CLOCK_SPEED, ft260_attr_dummy_func);
6a82582d9fa438 Michael Zaidman 2021-02-19  1291  static DEVICE_ATTR_RW(clock);
6a82582d9fa438 Michael Zaidman 2021-02-19  1292  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
