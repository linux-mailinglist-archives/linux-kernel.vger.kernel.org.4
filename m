Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12A8737679
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 23:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjFTVOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 17:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjFTVOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 17:14:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBC9E2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687295681; x=1718831681;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lpyMpVpgjd4tmVpC7advXYeHhDC6/5DpY8mZm2fkz1E=;
  b=kBG5l7wD+sfWzNBpjtuSpR2KuOsCl+XbR8tppcR9XGsZ9I4viHjICO8Z
   Y3DrvFiIDxswiCymMgftYIpsM7e00OY/DjwUTEcLUHt9LsAfQ7AC7IZc7
   JnIzOk1E7GObd34HzTh9rRCSuTFsY/MQfeu2KN1U+FqQr3ocvnsaRY1W6
   gqKRF/HWkYA4BC5tfvXOFsM/27KN+ZJgn+M4GbgYla1xvQA3L4YatHRof
   Gu/+5PgZALLoVOB7Tvu/14tMUc+r/9gV5swGhsJGH5mP73EYcINtPjy50
   6mlRc1rkx3StKhN5oKltC6OXFmMnXSACBiLMfpBrn0tvyrsH+GJgDNVGg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="363407869"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="363407869"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 14:14:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="960927293"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="960927293"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 20 Jun 2023 14:14:39 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qBigR-0006G8-0j;
        Tue, 20 Jun 2023 21:14:39 +0000
Date:   Wed, 21 Jun 2023 05:13:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/sparc/kernel/traps_64.c:2839:13: error: no previous prototype
 for 'trap_init'
Message-ID: <202306210547.QTEAjNch-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   99ec1ed7c2ed358280588ab1d013387e8c7a9333
commit: 7e09cb0b84ac5d17086a65ca21479dfec600a232 of: Drop cpu.h include from of_device.h
date:   10 weeks ago
config: sparc64-randconfig-c003-20230620 (https://download.01.org/0day-ci/archive/20230621/202306210547.QTEAjNch-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230621/202306210547.QTEAjNch-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306210547.QTEAjNch-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/sparc/kernel/traps_64.c:252:6: error: no previous prototype for 'is_no_fault_exception' [-Werror=missing-prototypes]
     252 | bool is_no_fault_exception(struct pt_regs *regs)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/sparc/kernel/traps_64.c:2034:6: error: no previous prototype for 'do_mcd_err' [-Werror=missing-prototypes]
    2034 | void do_mcd_err(struct pt_regs *regs, struct sun4v_error_entry ent)
         |      ^~~~~~~~~~
   arch/sparc/kernel/traps_64.c:2152:6: error: no previous prototype for 'sun4v_nonresum_error_user_handled' [-Werror=missing-prototypes]
    2152 | bool sun4v_nonresum_error_user_handled(struct pt_regs *regs,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/sparc/kernel/traps_64.c:2839:13: error: no previous prototype for 'trap_init' [-Werror=missing-prototypes]
    2839 | void __init trap_init(void)
         |             ^~~~~~~~~
   cc1: all warnings being treated as errors


vim +/trap_init +2839 arch/sparc/kernel/traps_64.c

^1da177e4c3f41 arch/sparc64/kernel/traps.c Linus Torvalds 2005-04-16  2837  
^1da177e4c3f41 arch/sparc64/kernel/traps.c Linus Torvalds 2005-04-16  2838  /* Only invoked on boot processor. */
^1da177e4c3f41 arch/sparc64/kernel/traps.c Linus Torvalds 2005-04-16 @2839  void __init trap_init(void)

:::::: The code at line 2839 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
