Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957026B3744
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 08:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjCJHZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 02:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjCJHZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 02:25:10 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D3C101102
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 23:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678433109; x=1709969109;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=szhfwaA2qsyJowTNJVU2fZYh4jv37phL3mTzGJRXIFA=;
  b=bSZc50zL5MTAmdSkk9hbcPkTzQLgun1Y8uulsxY1vT5Ik7PIQ9tJWXcW
   XZlO9YyuBgi3MF8CWKF0zl7pQFIENz9cEJuHT6YyGPhlfZ0pFHPMQQmbx
   VVWZuzbtT/S3QQVJHr7nImzVej7txApiBZYPfL2XC+Omo8uTo5Om/UHJ1
   6/+A03cYbgUHSYEr2nRzvDuEopv2hF9LThvR/1BQB69HFTybXSpUNIHHn
   UBf1rQhiNmDAi/FtzDZPwiZhMH5udiAo0DJJZOUdhB8KHq9NVeaTCXEEV
   lqovV8Gi4tsWAhmNFPPOt3R3ecnuhOf+7oVBGbN770o7LxYoYmLA9PJKS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="401529609"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="401529609"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 23:25:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="820952416"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="820952416"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 09 Mar 2023 23:25:07 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1paX7j-0003cM-0i;
        Fri, 10 Mar 2023 07:25:07 +0000
Date:   Fri, 10 Mar 2023 15:24:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: drivers/powercap/idle_inject.c:130:40-42: WARNING !A || A && B is
 equivalent to !A || B
Message-ID: <202303101512.mR87EHWR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   44889ba56cbb3d51154660ccd15818bc77276696
commit: acbc661032b8aa0e8359ac77074769ade34a176c powercap: idle_inject: Add update callback
date:   5 weeks ago
config: i386-randconfig-c001 (https://download.01.org/0day-ci/archive/20230310/202303101512.mR87EHWR-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303101512.mR87EHWR-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/powercap/idle_inject.c:130:40-42: WARNING !A || A && B is equivalent to !A || B

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
