Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E820E74C847
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 23:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjGIVAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 17:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGIVAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 17:00:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76C4118
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 13:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688936398; x=1720472398;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KloZCkYP5B/AWtYp/xV0r+yGiPoNmALbfjg2j3dh/eY=;
  b=KM7HwFLkS9HHL2H3WfIgOerv0Zs5r9xu4mbY/mPSb0Db2jZUFVwh2NuO
   SIcePLt2sDqRIKM4YA3LDYMo5q+KFeWP1P7LGe9i1QDJtaePgEvbwA+M1
   ppQj7XdYiX3T+fthVFQbySaMqZDeHxurMCTWY5A0xow9ge+6ac08B+kw0
   +Te1thTiISrHtMiEAwGu1Ksf33lEEaGk4nGnB4+YaMfRJ1mu/Ririf3dV
   HUcppRp+ySQ2FEh11H4SFuMcf/arz0zy4E+HcoD9x0gFi6Ndcx9038sH/
   ea/KPIPfpNRCoLGN2uaQ9E+oG6uMN5yXLQPJhr8YRFxeTdjhJhenmSojV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="430277442"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="430277442"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 13:59:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="785920609"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="785920609"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jul 2023 13:59:56 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qIbVb-0003Ng-2A;
        Sun, 09 Jul 2023 20:59:55 +0000
Date:   Mon, 10 Jul 2023 04:59:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shenghao Ding <13916275206@139.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: {standard input}:866: Error: value -148 out of range
Message-ID: <202307100413.lPlgpaPd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c192ac7357683f78c2e6d6e75adfcc29deb8c4ae
commit: ef3bcde75d06d65f78ba38a30d5a87fb83a5cdae ASoC: tas2781: Add tas2781 driver
date:   3 weeks ago
config: m68k-randconfig-r015-20230710 (https://download.01.org/0day-ci/archive/20230710/202307100413.lPlgpaPd-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230710/202307100413.lPlgpaPd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307100413.lPlgpaPd-lkp@intel.com/

All errors (new ones prefixed by >>):

   {standard input}: Assembler messages:
>> {standard input}:866: Error: value -148 out of range
>> {standard input}:866: Error: value of ffffff6c too large for field of 1 byte at 0000043b

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
