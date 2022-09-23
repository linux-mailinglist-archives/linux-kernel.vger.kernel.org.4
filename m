Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005945E7E39
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbiIWPWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbiIWPWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:22:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9A11438F0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663946518; x=1695482518;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=y0hGX04N3XAc80beCRF3+TJ7YmePdkNZr2Y++pmwHd8=;
  b=HALrgD+9mN506rEe5QNtxay1xw6/+aoWKpmX+Bn3KTRnAFGAqOTkhJ7H
   9bQw51moCsHJRy2+RS5hHRUK17RjHyEAmq0wiaxOqdGzrw5Spg0hZRf9x
   8jFs/KOV5A+EdN9FZO+4WYT/T3JkenCYYMDLnCmXITzOATJpZnJsc/qaQ
   3rNaLL5BtekVV5DYkQ8ls+HVzEGJhUJCjp95+eMfnvwNrmGdVcw/FyWsA
   EL7+9UJGqhiuFZ/63tDYZtyJkxOqb/qJJHJR31m8AUcq5FWfopvZu59T0
   cuZBasDI1Z9tiKKSkmtg9RviNNVcjJgkIJam4K95lqlTWnVN916yBrR1u
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="300596931"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="300596931"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 08:21:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="615643063"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 23 Sep 2022 08:21:57 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obkV2-0005mY-2K;
        Fri, 23 Sep 2022 15:21:56 +0000
Date:   Fri, 23 Sep 2022 23:21:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:call-depth-tracking 34/60]
 arch/x86/lib/copy_page_64.o: warning: objtool: .altinstr_replacement():
 can't find starting instruction
Message-ID: <202209232315.eRwoBhq2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git call-depth-tracking
head:   856304fc062b9ad34742a604b98cc775846c0cb3
commit: c2a8b8187418956af92d2d954ee4574f87f5e188 [34/60] objtool: Rework instruction -> symbol mapping
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220923/202209232315.eRwoBhq2-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=c2a8b8187418956af92d2d954ee4574f87f5e188
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue call-depth-tracking
        git checkout c2a8b8187418956af92d2d954ee4574f87f5e188
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/lib/copy_page_64.o: warning: objtool: .altinstr_replacement(): can't find starting instruction

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
