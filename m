Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BEA689A3D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 14:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjBCNwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 08:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbjBCNwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 08:52:18 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEBBA146C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 05:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675432324; x=1706968324;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=T/w/r9aOZL8XZDQyx28jeos1sAMd7v+mO86lUonWkZ0=;
  b=ip1mQ/ZgCXIR3lzmiXjKBZUGYxlFSEUM+Jf+3eRr4cGNSJGgBhbpjJ1d
   kx/oY7jrBOHHtUXc3to5SGuTjvtAC9EnuqBAmGmqI8pJS07UPnrwJjgAV
   Zg0FjEDLe1OfzvDPZy9whPdT6GNpk9Brh6QnsHhwxJ8enuv0torJCuxTc
   bNjJrnL1vP10c7vBvJZvuS9iaTtgZbKYj4YbQFqRMwMxtqOZ7IBXoJHTL
   M2iIvz9UI+50I8650PBUiC9WvlOkOrtNfmtySrisv0V8LztMAp++Vu/yP
   xggZn0LlJPde9sjOU9bTUoOJoSN0HEsfsiVnpOxfLxkKQshQkcScvzfOj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="356091197"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="356091197"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 05:52:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="667649533"
X-IronPort-AV: E=Sophos;i="5.97,270,1669104000"; 
   d="scan'208";a="667649533"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 03 Feb 2023 05:52:02 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNwTx-0000Wn-0d;
        Fri, 03 Feb 2023 13:52:01 +0000
Date:   Fri, 03 Feb 2023 21:51:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/tdx] BUILD SUCCESS
 1e70c680375aa33cca97bff0bca68c0f82f5023c
Message-ID: <63dd114b.vBT3a0DsIQBSI4dw%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/tdx
branch HEAD: 1e70c680375aa33cca97bff0bca68c0f82f5023c  x86/tdx: Do not corrupt frame-pointer in __tdx_hypercall()

elapsed time: 774m

configs tested: 34
configs skipped: 68

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
um                           x86_64_defconfig
um                             i386_defconfig
i386                                defconfig
ia64                             allmodconfig
i386                             allyesconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                          rhel-8.3-rust
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
