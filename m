Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89AC688FDF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 07:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjBCGxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 01:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjBCGwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 01:52:50 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149DF18B04;
        Thu,  2 Feb 2023 22:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675407169; x=1706943169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n03e8b0LCry8KyTxYlzDyGV0UdJKIZ5xiL0RLULKrP8=;
  b=WHsID/hSBc4bDefTfsarKaK/HgsE8fIHZgdKjAYl0uRrzSR05xbcTsBn
   tOV0u0a8rq3i4ktrKih+dVoN/oyAtXefhPqJFzRIyTk51c+lPKZzwiMyn
   UZL2/RjAzFJMz9Q+aZ9Tc2Uo+VwWZgVu9gayroHOllkkYlrB0FMgY17FO
   6nFZN8qgrHd7lzZAvyB8iyIZ0spp7iKseyl2EvhIZr1i/BvP7n748V94s
   WX48ZfSBT5CKJMtPnrH/HaO2tv/d/F/4kOkjLjpXliQ1bQNsBHiJEAWF3
   E4R9IOxELpzj0mOVQevDXpXY58R9FInBnwNsoFzA02wZw74Ss24tTHl+d
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="330806116"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="330806116"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 22:52:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="839495267"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="839495267"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 02 Feb 2023 22:52:43 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNpwA-0000DN-1o;
        Fri, 03 Feb 2023 06:52:42 +0000
Date:   Fri, 3 Feb 2023 14:52:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Allen Ballway <ballway@chromium.org>, benjamin.tissoires@redhat.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        jikos@kernel.org, lukas.bulwahn@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Allen Ballway <ballway@chromium.org>
Subject: Re: [PATCH] HID: multitouch: Fix typo in config check
Message-ID: <202302031440.9V6esF8X-lkp@intel.com>
References: <20230202144149.1.I7f213388b358718068c63acb698dc4937716cf35@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202144149.1.I7f213388b358718068c63acb698dc4937716cf35@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Allen,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hid/for-next]
[also build test ERROR on next-20230203]
[cannot apply to linus/master v6.2-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Allen-Ballway/HID-multitouch-Fix-typo-in-config-check/20230202-224919
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/20230202144149.1.I7f213388b358718068c63acb698dc4937716cf35%40changeid
patch subject: [PATCH] HID: multitouch: Fix typo in config check
config: x86_64-randconfig-a003 (https://download.01.org/0day-ci/archive/20230203/202302031440.9V6esF8X-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a2331d08db1030f3e3f2e0d9c9232780c27d954a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Allen-Ballway/HID-multitouch-Fix-typo-in-config-check/20230202-224919
        git checkout a2331d08db1030f3e3f2e0d9c9232780c27d954a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: i2c_hid_get_dmi_quirks
   >>> referenced by hid-quirks.c:1305 (drivers/hid/hid-quirks.c:1305)
   >>>               vmlinux.o:(hid_lookup_quirk)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
