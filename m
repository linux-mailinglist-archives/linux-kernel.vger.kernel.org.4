Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08D46E013D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjDLVyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjDLVy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:54:28 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180B6448F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681336467; x=1712872467;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Yu0r1HUDwvkkkFHvh8gHu28JvpA5snRQx5ktJBSc9w8=;
  b=YOl0cedhS58JzZ3pjm7NLMil622U5qods1e3WnrT3bwmC1crqiZ+MtoD
   8ThqcSvAWIAqL8JPzzovUVzVtyQKntc9WC3tWfrUyGW7G3B7KruajDRCV
   8KKMogBXh1ZYdvNF0wyRBdZjlTto98E3zD6tlfVQ1oKVoxoDQnpi9taDs
   gz7iMaFIpYbdieFVS3950U7+dQ1e1hbnfvQauLz3XPy5DITWqIthXpT2Z
   VCH9po+7K/XgdJmiVlF9P8l49zgPLVPGGaOHyX/8TkviJOudlBl6sN5Hi
   KrIXW/mqHUwzYvKhqDRdWoY0ZyA+yGifc6G84DqMtMTIDPC+Ic3JfSozx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="341522888"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="341522888"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 14:54:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="863477654"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="863477654"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 12 Apr 2023 14:54:24 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmiQ3-000Y4V-2b;
        Wed, 12 Apr 2023 21:54:23 +0000
Date:   Thu, 13 Apr 2023 05:53:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gal Pressman <gal@nvidia.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Eric Dumazet <edumazet@google.com>
Subject: xtensa-linux-ld: section .start VMA
 [00000000d1000000,00000000d1000007] overlaps section .image VMA
 [00000000d0003000,00000000d100bbe7]
Message-ID: <202304130556.wv6Mc4BM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0bcc4025550403ae28d2984bddacafbca0a2f112
commit: 48cec899e357cfb92d022a9c0df6bbe72a7f6951 tcp: Add a stub for sk_defer_free_flush()
date:   1 year, 3 months ago
config: xtensa-buildonly-randconfig-r004-20230412 (https://download.01.org/0day-ci/archive/20230413/202304130556.wv6Mc4BM-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=48cec899e357cfb92d022a9c0df6bbe72a7f6951
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 48cec899e357cfb92d022a9c0df6bbe72a7f6951
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304130556.wv6Mc4BM-lkp@intel.com/

All errors (new ones prefixed by >>):

>> xtensa-linux-ld: section .start VMA [00000000d1000000,00000000d1000007] overlaps section .image VMA [00000000d0003000,00000000d100bbe7]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
