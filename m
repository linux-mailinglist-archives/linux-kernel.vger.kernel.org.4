Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC5568CBD9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjBGBSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjBGBSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:18:31 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455BC35244
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 17:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675732708; x=1707268708;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=d5DDdr5zTC4VNz471nl7XHZvg+u+Z/6Y9fKCduAp4n4=;
  b=dnMeEiEtCtVD//NWFbFiF6T2kFhesk0VeFCaEAOqYs0uLGNVH9UnM4LE
   hnd+Mx413pIKQ6BYe6YlDbFrQLeVWUoUP52cmGjmDQM8rz+r5s9XeFyd/
   f3yS+UjctwECqNy0owi2GUiJ2N4jSb0bw0n0V+yQgpex7PRSOAMQvOxV4
   JiWN+0lFmt5I+TlsFewheIJ8LS4B+rlQWmfCLjAnyG61PR7U6VM/p2n9N
   P5YZbV6UOCWfJ1+r+TCe5iHaV7wNyrluBq1CvZd0L0R0iuZ+8FBs5QBXA
   V/81x50StCt69lUC+POZe+rK7Ik/Ci/0ZZteyoIY+Ypuvng/VmHbg6x7a
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="330658722"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="330658722"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 17:18:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="616623437"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="616623437"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 Feb 2023 17:18:26 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPCcs-0002vk-0D;
        Tue, 07 Feb 2023 01:18:26 +0000
Date:   Tue, 07 Feb 2023 09:18:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/microcode] BUILD SUCCESS
 f33e0c893b22bf94d7985f1f2aa3872237560c74
Message-ID: <63e1a6c8.vnOL+NJ4dbzz8J7H%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/microcode
branch HEAD: f33e0c893b22bf94d7985f1f2aa3872237560c74  x86/microcode/core: Return an error only when necessary

elapsed time: 728m

configs tested: 13
configs skipped: 74

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                            allnoconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-bpf
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                                defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                             allyesconfig

clang tested configs:
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
