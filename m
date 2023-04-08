Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DA56DBCD8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 22:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjDHUAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 16:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDHUAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 16:00:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767DA5FF4
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 13:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680984012; x=1712520012;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tY/Gl6NuQcpBrDTkzM19LOcQ4VHeZxYJtQOk5A47ffY=;
  b=YNo0NIUdBSRkaxx3I1B9p4Qd5gzKLV8+dxzzHZroVT6E7vfmuYoTtxwI
   r5LQsApieriE6ZXds76ZZMdJMng8LUflzUjZxVDn45P2UbXEYWxpyyrW+
   McuZWjs3IFU+bTgfMsH5UJj8q7ojezy9MaKN5lXZ1NtryOjaQ1o6bZDV/
   KPRDanQvtwRqZM2HhkB2rBv4mWBkevCbtXmCBsTLzZUq3sPCpLPWDO3Qh
   otZK3YsH9ON4FZk2ruF3dce8qpiPn0qHFBRh6jdCjw+GPpof23WbcGcAs
   fWA5N3+0ezauRbubt+X5P5diBwpgqFVK6fxWfYx1KCnkYhbLQFWxdY1x3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10674"; a="322797542"
X-IronPort-AV: E=Sophos;i="5.98,330,1673942400"; 
   d="scan'208";a="322797542"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2023 13:00:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10674"; a="799044181"
X-IronPort-AV: E=Sophos;i="5.98,330,1673942400"; 
   d="scan'208";a="799044181"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 08 Apr 2023 13:00:11 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1plEjK-000U41-1T;
        Sat, 08 Apr 2023 20:00:10 +0000
Date:   Sun, 9 Apr 2023 03:59:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [tip:objtool/core 22/23] kernel/sched/build_policy.o: warning:
 objtool: do_idle() falls through to next function play_idle_precise()
Message-ID: <202304090346.erhqxnlt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool/core
head:   fb799447ae2974a07907906dff5bd4b9e47b7123
commit: 071c44e4278156f18a6a56958617223b6bffa6ab [22/23] sched/idle: Mark arch_cpu_idle_dead() __noreturn
config: x86_64-randconfig-c022-20230403 (https://download.01.org/0day-ci/archive/20230409/202304090346.erhqxnlt-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=071c44e4278156f18a6a56958617223b6bffa6ab
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip objtool/core
        git checkout 071c44e4278156f18a6a56958617223b6bffa6ab
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304090346.erhqxnlt-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/sched/build_policy.o: warning: objtool: do_idle() falls through to next function play_idle_precise()

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
