Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C317496BE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 09:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbjGFHsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 03:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjGFHsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:48:23 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBEE10B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 00:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688629702; x=1720165702;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Xo0fbN1VsjDMVKPWre0XhLetnWjzyPPJcL/tUzOSN2c=;
  b=dIKqaO3qsbAXMVitx38wLT3U8b9ethDvcs5UbpFKQRs6y/DjY3Te1FQ/
   06F03w9BDifG430cJrpYarA9AjZS46Flwf/Aa1IkaK4UHWCZB5/NzvNT7
   R+o6IK+maRsdIb2eWLNk3YuZeam9IX7XInwmziQvLmStH00/vk7GUVrYJ
   +aJlxQ9bRrMSA/yT7AnBtEpUr4nk0kNOWPRHt712zntVD9oDwTfSFV2+h
   u8uUsTszIhJj5cqlKfH33+AW5eHdaAApEgalRAbOAnldyGN5bF5caJnhs
   Gz2s1pdd7cEZBKTdFuujQ9mMdSciXJ/irEXlMXxBc3tngE5cRifVqKvAj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="429577058"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="429577058"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 00:48:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="789455211"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="789455211"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jul 2023 00:48:20 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qHJit-0001AU-1i;
        Thu, 06 Jul 2023 07:48:19 +0000
Date:   Thu, 6 Jul 2023 15:48:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: drivers/regulator/raa215300.c:42:12: sparse: sparse: symbol
 'xin_name' was not declared. Should it be static?
Message-ID: <202307061555.Gx6hEBT4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c17414a273b81fe4e34e11d69fc30cc8b1431614
commit: 7bce16630837c705f72e8fd53a11ae8c236236f4 regulator: Add Renesas PMIC RAA215300 driver
date:   13 days ago
config: i386-randconfig-i061-20230706 (https://download.01.org/0day-ci/archive/20230706/202307061555.Gx6hEBT4-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230706/202307061555.Gx6hEBT4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307061555.Gx6hEBT4-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/regulator/raa215300.c:42:12: sparse: sparse: symbol 'xin_name' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
