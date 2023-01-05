Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D4465E6E3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 09:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjAEIgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 03:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjAEIgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 03:36:40 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E384C715
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 00:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672907799; x=1704443799;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=AF42mdhQefZQTuaD10ayW8KtvwAQ4C7jkzPv3UlZbQk=;
  b=OlCm+3eD7JZuyMnQ1F6th4J3Na4MSm0ZJcdHKwOetUahhRxwTsekAisz
   KOAmPcaGPCdoDG/3FGH6maG+Sd8M4JVX/+UOsfEDlJtwv2sNu1Eg2c93z
   OvFCK0LIZ8ELM7GSxmqWYS+ez1zoj4/iEI0Vjt75IOQ4XTY+4poR2IX6f
   Y1H16kER+vO0jjpzeQbHEMnlkuEhll2M53cjbQfyLdrcS+5aTtUSjWVZC
   Sp2IS4P+vvnk36zSLD6QYYMw8vcRRo5uHf749S/AXskBYlxgFw1riWQLg
   1YRdsQpuxs/i8tNIM8nJYfSpmp5oTgdNMG0qjhEjHs6sTmnxftdH9Rizt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="319856840"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="319856840"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 00:36:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="655489599"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="655489599"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 05 Jan 2023 00:36:35 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pDLjm-0001M8-2x;
        Thu, 05 Jan 2023 08:36:34 +0000
Date:   Thu, 05 Jan 2023 16:36:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 57512b57dcfaf63c52d8ad2fb35321328cde31b0
Message-ID: <63b68bfa.ZgdUIGPTmjwGKi60%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: 57512b57dcfaf63c52d8ad2fb35321328cde31b0  perf/x86/rapl: Add support for Intel Emerald Rapids

elapsed time: 720m

configs tested: 55
configs skipped: 70

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
x86_64                            allnoconfig
x86_64                              defconfig
i386                 randconfig-a003-20230102
i386                 randconfig-a001-20230102
i386                                defconfig
x86_64                               rhel-8.3
i386                 randconfig-a002-20230102
i386                 randconfig-a005-20230102
i386                 randconfig-a006-20230102
i386                 randconfig-a004-20230102
x86_64               randconfig-a003-20230102
x86_64                    rhel-8.3-kselftests
x86_64               randconfig-a001-20230102
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64               randconfig-a004-20230102
x86_64               randconfig-a002-20230102
x86_64               randconfig-a006-20230102
x86_64               randconfig-a005-20230102
i386                             allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
sh                           se7724_defconfig
powerpc                      ppc6xx_defconfig
m68k                       m5475evb_defconfig
alpha                            alldefconfig
arm                            qcom_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
um                           x86_64_defconfig
um                             i386_defconfig

clang tested configs:
i386                 randconfig-a012-20230102
i386                 randconfig-a011-20230102
i386                 randconfig-a014-20230102
i386                 randconfig-a013-20230102
i386                 randconfig-a016-20230102
i386                 randconfig-a015-20230102
x86_64                          rhel-8.3-rust
x86_64                        randconfig-k001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
