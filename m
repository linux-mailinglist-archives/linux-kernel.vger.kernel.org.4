Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C384A6DBAAF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 13:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjDHLwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 07:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjDHLwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 07:52:15 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46FA113C3;
        Sat,  8 Apr 2023 04:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680954711; x=1712490711;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aIahBj4lSfFWJhyMp6/dry0v3wiGin821aomnhMZTsk=;
  b=JcsgssDV/goVzEFJpuOSEHG4YiFVxyz1IMm4MWUvD8bkKCyTyphZm9tT
   gIqQDIW8zcHYVx2K6Ffh0qFccI6UudzyEFgXA0tr/Exfi+pMRpKePLsQ0
   Nh4+LN+dKeUFjj6FPYomKBeXNebz+josuT+sADdFheoA1BbWD0MnmWAdf
   T3L/0POGbZm9/QuZatnkhlnOk4f0W1lz+LgyMfr7yjofwog0Tk4ZcPQka
   FTVR4oV2UvBHlmQ0VG3KFzB4QxoFOPqfhe86sRZuyqBTLAj1a9J3lUa/R
   gFviv4E2SFrvjS7QA+KOjXhFttxKF4G3bMqvRhTZK41B7YzXfhId7/Gwt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="327225575"
X-IronPort-AV: E=Sophos;i="5.98,329,1673942400"; 
   d="scan'208";a="327225575"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2023 04:50:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="811658027"
X-IronPort-AV: E=Sophos;i="5.98,329,1673942400"; 
   d="scan'208";a="811658027"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 08 Apr 2023 04:50:47 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pl75i-000ThB-27;
        Sat, 08 Apr 2023 11:50:46 +0000
Date:   Sat, 8 Apr 2023 19:50:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>,
        srinivas.pandruvada@linux.intel.com, irenic.rajneesh@gmail.com,
        david.e.box@intel.com, hdegoede@redhat.com, markgross@kernel.org,
        rjw@rjwysocki.net
Cc:     oe-kbuild-all@lists.linux.dev, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86/intel/pmc/mtl: Put GNA/IPU/VPU devices in D3
Message-ID: <202304081931.gFShEdFu-lkp@intel.com>
References: <20230408022629.727721-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230408022629.727721-1-david.e.box@linux.intel.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 4f59630a5ed0a4e7d275bd7e5d253a8f5a425c5a]

url:    https://github.com/intel-lab-lkp/linux/commits/David-E-Box/platform-x86-intel-pmc-mtl-Put-GNA-IPU-VPU-devices-in-D3/20230408-102651
base:   4f59630a5ed0a4e7d275bd7e5d253a8f5a425c5a
patch link:    https://lore.kernel.org/r/20230408022629.727721-1-david.e.box%40linux.intel.com
patch subject: [PATCH] platform/x86/intel/pmc/mtl: Put GNA/IPU/VPU devices in D3
config: x86_64-randconfig-s023-20230403 (https://download.01.org/0day-ci/archive/20230408/202304081931.gFShEdFu-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/04453d42ee1b0c97f9fa68644c6234f7b9e2d14a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review David-E-Box/platform-x86-intel-pmc-mtl-Put-GNA-IPU-VPU-devices-in-D3/20230408-102651
        git checkout 04453d42ee1b0c97f9fa68644c6234f7b9e2d14a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/platform/x86/intel/pmc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304081931.gFShEdFu-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/platform/x86/intel/pmc/mtl.c:52:6: sparse: sparse: symbol 'mtl_set_device_d3' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
