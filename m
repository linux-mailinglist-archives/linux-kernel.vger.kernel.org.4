Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F4F697A61
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 12:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbjBOLCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 06:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjBOLCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 06:02:46 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6245EB77
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 03:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676458965; x=1707994965;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2TUwnGqI7t8ljM/1v47gzKY1hlENjBPmW5420etl8HI=;
  b=j6SkWh1dDvNIKklPS/iFtautU/5t6dMw3IxoVScBzYNrbH/3qBOqNyE0
   T5LY2d7eU6OQljCVS+JyBvxKuopozbtCQhQXfe8hpvsQSzIADBnEX9PTN
   cnbuWxkToeMhV5rlwb1vFwjjrvj+e+T0hJ3rjDf1slumkl7stmVMgVpjU
   SIsPqAjBkXilBbdf9ox+vV4OCfry47px8chAc420SuG8MWZqGmbYYo72i
   sAvA+Zt4+xTJGejXR7JTsWdmWqj47w6MHseIW1JF7ZBDWAnc5cmHO7gj6
   AyeespAWPjo9FfxjJULYBYUp2w6j86vnD1tDWItTfY6mCnJ3LQ5RLfjKK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="319434930"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="319434930"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 03:02:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="701985629"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="701985629"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 15 Feb 2023 03:02:44 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pSFYh-0009If-0v;
        Wed, 15 Feb 2023 11:02:43 +0000
Date:   Wed, 15 Feb 2023 19:01:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 fcb3a81d221750d2a54b4e3a82b3efbbeab8780c
Message-ID: <63ecbba0.PLUj+bhs5is2QLT6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: fcb3a81d221750d2a54b4e3a82b3efbbeab8780c  x86/hotplug: Remove incorrect comment about mwait_play_dead()

elapsed time: 728m

configs tested: 32
configs skipped: 80

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                             allyesconfig
i386                              debian-10.3
i386                                defconfig
i386                 randconfig-a011-20230213
i386                 randconfig-a012-20230213
i386                 randconfig-a013-20230213
i386                 randconfig-a014-20230213
i386                 randconfig-a015-20230213
i386                 randconfig-a016-20230213
x86_64                            allnoconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64               randconfig-a011-20230213
x86_64               randconfig-a012-20230213
x86_64               randconfig-a013-20230213
x86_64               randconfig-a014-20230213
x86_64               randconfig-a015-20230213
x86_64               randconfig-a016-20230213
x86_64                               rhel-8.3

clang tested configs:
i386                 randconfig-a001-20230213
i386                 randconfig-a002-20230213
i386                 randconfig-a003-20230213
i386                 randconfig-a004-20230213
i386                 randconfig-a005-20230213
i386                 randconfig-a006-20230213
x86_64               randconfig-a001-20230213
x86_64               randconfig-a002-20230213
x86_64               randconfig-a003-20230213
x86_64               randconfig-a004-20230213
x86_64               randconfig-a005-20230213
x86_64               randconfig-a006-20230213

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
