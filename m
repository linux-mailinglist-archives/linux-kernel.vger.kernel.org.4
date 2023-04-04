Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8CC6D6704
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbjDDPRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbjDDPRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:17:37 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7845A420A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 08:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680621453; x=1712157453;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SxB/5J1aJZAHlUZcEKDGwZgoSpUk7ydySAQDIcrYsc0=;
  b=frQJmd7VIJwKgEQ9Ct+Zd4z1zE/fMSF5oVxe/CjqNno22wn5BKYtnGrh
   PHN4DoxVez5JszD2w+1xhqzxIhmXsE64EH7bLnpak6x7rmQO1pZGJg1kT
   KqMEYXgNA7DzmqJ7Z7mAZa+wH5gCNX7Giz7k4BzGGfn1579ObhKCQpBJt
   rSRwXH/RPyHeBXTq41Cl1jB/RitIL77ZU7LXB0UyOGQ3rITe2qT+2Ggoy
   ExqvMyH/rX3LoOSBclv9Ca14jmvgZ2R6YLYfJLco5ejcHpIt6QoDZf/3u
   31pQlF1g4y8J2LqgOt9ExhNakPE7mpM+Hyym1yoQTZ+J7S3tR+Tx8f/gz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="344781527"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="344781527"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 08:17:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="830018650"
X-IronPort-AV: E=Sophos;i="5.98,318,1673942400"; 
   d="scan'208";a="830018650"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 04 Apr 2023 08:17:31 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pjiPa-000Pos-2g;
        Tue, 04 Apr 2023 15:17:30 +0000
Date:   Tue, 4 Apr 2023 23:17:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: drivers/gpu/drm/i915/i915.o: warning: objtool:
 intel_gt_is_wedged+0xb2: relocation to !ENDBR: .text+0x47a27
Message-ID: <202304042310.zZd8wR1u-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   148341f0a2f53b5e8808d093333d85170586a15d
commit: c27cd083cfb9d392f304657ed00fcde1136704e7 Compiler attributes: GCC cold function alignment workarounds
date:   2 months ago
config: x86_64-randconfig-r021-20230403 (https://download.01.org/0day-ci/archive/20230404/202304042310.zZd8wR1u-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c27cd083cfb9d392f304657ed00fcde1136704e7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c27cd083cfb9d392f304657ed00fcde1136704e7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304042310.zZd8wR1u-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/i915/i915.o: warning: objtool: intel_gt_is_wedged+0xb2: relocation to !ENDBR: .text+0x47a27
   drivers/gpu/drm/i915/i915.o: warning: objtool: intel_gt_is_wedged+0xb2: relocation to !ENDBR: .text+0x4db77
   drivers/gpu/drm/i915/i915.o: warning: objtool: intel_gt_is_wedged+0xb2: relocation to !ENDBR: .text+0x4f277
   drivers/gpu/drm/i915/i915.o: warning: objtool: intel_gt_is_wedged+0xb2: relocation to !ENDBR: .text+0x5ff27
   drivers/gpu/drm/i915/i915.o: warning: objtool: intel_gt_is_wedged+0xb2: relocation to !ENDBR: .text+0x67167
   drivers/gpu/drm/i915/i915.o: warning: objtool: intel_gt_is_wedged+0xb2: relocation to !ENDBR: .text+0x7bfa7
   drivers/gpu/drm/i915/i915.o: warning: objtool: intel_gt_is_wedged+0xb2: relocation to !ENDBR: .text+0xb8627
   drivers/gpu/drm/i915/i915.o: warning: objtool: intel_gt_is_wedged+0xb2: relocation to !ENDBR: .text+0xc2ba7
   drivers/gpu/drm/i915/i915.o: warning: objtool: intel_gt_is_wedged+0xb2: relocation to !ENDBR: .text+0xcfd27
>> drivers/gpu/drm/i915/i915.o: warning: objtool: i915_request_await_start+0x5d5: relocation to !ENDBR: .text+0xd649a
>> drivers/gpu/drm/i915/i915.o: warning: objtool: __guc_action_self_cfg+0x1a7: relocation to !ENDBR: .text+0xf384c
   drivers/gpu/drm/i915/i915.o: warning: objtool: ct_handle_response+0x46b: relocation to !ENDBR: ct_process_request+0x0
   drivers/gpu/drm/i915/i915.o: warning: objtool: intel_gt_is_wedged+0xb2: relocation to !ENDBR: .text+0x103387


objdump-func vmlinux.o intel_gt_is_wedged:

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
