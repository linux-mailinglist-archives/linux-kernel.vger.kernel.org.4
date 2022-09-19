Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4F25BD3EB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiISRhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiISRgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:36:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE3042ACB;
        Mon, 19 Sep 2022 10:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663609011; x=1695145011;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Rvk8sYX+O/ZUZrjhW06HtVxtlqh/xDeDZldQxb/Hfic=;
  b=Ye53wNn3bBCbkSjEzGTtHtVJWTDSOqZ2W8gobdstLg8ANJ3WF5XuaCtO
   mypHb45c/5Iz5w6JsN9lUz0rPZQ2Q3eQJlTVUkInXj4yhdrw1xcDq9bA+
   hVFaEs+v2c3PmbpJ0QSsUQkjwNZtq98a+CoyLSppgDjrY6JLhdUG9w8/a
   5WoUzqMMAolU0ILaaPNBRHHcGrLokrQCibB9sO3ej0m196eFgE+tRSIc7
   aDc8HEyJVpPEg/v6l8nd+jB3s10B79J2vUHRzDwgjToTlgI/c5Y3yQohh
   D1lvH/4c01G3dkz/NcLXC3OqbjtPX26KPJzaTMFiBQp2XVmkC7HObXUWf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="361206178"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="361206178"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 10:36:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="596176013"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 19 Sep 2022 10:36:49 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaKhM-00028b-2K;
        Mon, 19 Sep 2022 17:36:48 +0000
Date:   Tue, 20 Sep 2022 01:36:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org,
        Azael Avalos <coproscefalo@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [pdx86-platform-drivers-x86:review-hans 63/75]
 drivers/platform/x86/toshiba_acpi.c:56:5: sparse: sparse: symbol
 'turn_on_panel_on_resume' was not declared. Should it be static?
Message-ID: <202209200116.yruuNbr4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git review-hans
head:   c710765a4742337e40199403acde2fdd3189183d
commit: 3cb1f40dfdc3b9f5449076c96b4e2523139f5cd0 [63/75] drivers/platform: toshiba_acpi: Call HCI_PANEL_POWER_ON on resume on some models
config: x86_64-randconfig-s021-20220919 (https://download.01.org/0day-ci/archive/20220920/202209200116.yruuNbr4-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?id=3cb1f40dfdc3b9f5449076c96b4e2523139f5cd0
        git remote add pdx86-platform-drivers-x86 https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
        git fetch --no-tags pdx86-platform-drivers-x86 review-hans
        git checkout 3cb1f40dfdc3b9f5449076c96b4e2523139f5cd0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/platform/x86/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/platform/x86/toshiba_acpi.c:56:5: sparse: sparse: symbol 'turn_on_panel_on_resume' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
