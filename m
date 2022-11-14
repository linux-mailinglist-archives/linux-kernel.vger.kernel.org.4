Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9744D62750D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 04:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbiKNDmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 22:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbiKNDme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 22:42:34 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5806B13D04
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 19:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668397353; x=1699933353;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8z0ajpLc6gE5Alh3knu25MNIVWlVtSK35cju1Sh60bo=;
  b=TvDPWlsYFhjtt/9EUcAtpta6ph6S4vF6T/ac2X4e8AWW3Zf/qA8VIevY
   emc04AcoWCOIv1YL7BQ3VxPCYRlbD3Mb3CzePHhT2vQnjsWcc3XmETyOA
   UqS8tNN1+vrFLZPPRFcJUNigU2dePxQIs0ScgkpW4+YayEOTT8gOv2mwQ
   8KV0TYIMSiDpljNcISYoM3LNAmhJlL7nJUCOp9pih0GtEImUPtPFEomiC
   GY54l7TzlqHAT5PG2dnEcfL1YQ8kTJk10w6sI+82g2d7Dr7w+08u5CkLn
   xAcH+vthCZrSWZobWy165KzKdiBuveMHwd9PhdJ5MNv6V9wVQgwovpHqe
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="398163881"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="398163881"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 19:42:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="638305672"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="638305672"
Received: from lkp-server01.sh.intel.com (HELO ebd99836cbe0) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 13 Nov 2022 19:42:21 -0800
Received: from kbuild by ebd99836cbe0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ouQMW-00004Z-1a;
        Mon, 14 Nov 2022 03:42:20 +0000
Date:   Mon, 14 Nov 2022 11:41:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Meng Li <li.meng@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: spdxcheck: drivers/cpufreq/amd-pstate-ut.c: 1:28 Invalid License ID:
 GPL-1.0-or-later
Message-ID: <202211141151.NSoxwxUi-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   094226ad94f471a9f19e8f8e7140a09c2625abaa
commit: 14eb1c96e3a3fd9cd377ac9af3c7a410f8bf1015 cpufreq: amd-pstate: Add test module for amd-pstate driver
date:   6 weeks ago
reproduce:
        scripts/spdxcheck.py

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

spdxcheck warnings: (new ones prefixed by >>)
>> drivers/cpufreq/amd-pstate-ut.c: 1:28 Invalid License ID: GPL-1.0-or-later
   drivers/spi/spi-gxp.c: 1:35 Invalid token: =or-later

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
