Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCF77417C4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjF1SFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 14:05:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:24695 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231454AbjF1SEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687975493; x=1719511493;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TeSOtIAiYLNKTwV2Sw1VFBxUCSl00HnIBN/n1Vq/Lus=;
  b=WLFCbkRI/mFVB3UP49cWanX8ioPJZCsQF8LIc1HL8GZgWtbBKjLecA9z
   PUgJ7Zc30VnWL7qJmhPN6DY0szkHyULi2KQvXopa9Aeqm9Z0RrI/F8FPi
   2M5HHtyV1xsPoEcS3rybBFVD7rlt3PHz806L2MFO1SlUmvMeJESc668Ry
   RNReHqBMiDmclVRM40W7uTCiYpRPfneG2PqtPyIiwowwZxTftXgxRhlE3
   ZsLeUMrrQku1D828X05vp2uJxxtFItd6eyLrx6ZbgS8u1yptz/OXAL4kt
   O1JLMJpV6kM3OpNlqxmGher6TUW8HAWlDNbh5AS+nHY9M3N+fQ6necrCU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="361963339"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="361963339"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 11:04:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="1047504448"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="1047504448"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jun 2023 11:04:50 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qEZX7-000DPt-1h;
        Wed, 28 Jun 2023 18:04:49 +0000
Date:   Thu, 29 Jun 2023 02:04:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: drivers/net/dsa/sja1105/sja1105.o: warning: objtool:
 sja1105_fast_age() falls through to next function
 sja1105_mgmt_xmit.constprop.0.isra.0.cold()
Message-ID: <202306290223.F7bMX6mq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6aeadf7896bff4ca230702daba8788455e6b866e
commit: c27cd083cfb9d392f304657ed00fcde1136704e7 Compiler attributes: GCC cold function alignment workarounds
date:   5 months ago
config: x86_64-randconfig-x052-20230628 (https://download.01.org/0day-ci/archive/20230629/202306290223.F7bMX6mq-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230629/202306290223.F7bMX6mq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306290223.F7bMX6mq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/dsa/sja1105/sja1105.o: warning: objtool: sja1105_fast_age() falls through to next function sja1105_mgmt_xmit.constprop.0.isra.0.cold()

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
