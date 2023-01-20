Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D126752D4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 11:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjATKzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 05:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjATKzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 05:55:10 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7F693E8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 02:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674212109; x=1705748109;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WirNdjXcNBVyodVjqhh0h3CpV44jofuXffWJE1a0G6w=;
  b=RGkHXoA1MbkIKwl9Vper4gszUUUpSKAasxAOVa7S2Or5Ud12Q/w1qa1G
   X1FYf2zWEhrmkPDIBpFIK5+wSyzG2RGzOnrlW9IfTfs+KGcmwGChW3dbc
   qN8EpCPV9X9Yb6PyJIpoKl5PUu36nxjAzFIwo7JnToomM3mOrd8RlDBn2
   yxsDzryZJkBfYn6afkrcbsU3AbutTVNraSEVGhnLQVgHBz9uEHrQtjW1g
   oOfoyRRIqdkUXUlBioWPVUlmLRYxiIHRndwTEpDltXN3ZELZkqkjTt1Wi
   3X9Q0qN+QhHtOlZ2HXctS6kNq8uC/onkNAcXK6UDXjevvlJ1ZYYF4363h
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="325589525"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="325589525"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 02:55:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="784473649"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="784473649"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 20 Jan 2023 02:55:02 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIp2u-0002UI-0C;
        Fri, 20 Jan 2023 10:54:56 +0000
Date:   Fri, 20 Jan 2023 18:54:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin Krastev <krastevm@vmware.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Zack Rusin <zackr@vmware.com>
Subject: drivers/gpu/drm/vmwgfx/vmwgfx_msg.c:713:21: warning: unused function
 'mksstat_init_record'
Message-ID: <202301201858.yiiu0sKz-lkp@intel.com>
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
head:   d368967cb1039b5c4cccb62b5a4b9468c50cd143
commit: 7a7a933edd6c3a6d5d64e08093f2d564104cefcd drm/vmwgfx: Introduce VMware mks-guest-stats
date:   1 year, 7 months ago
config: x86_64-randconfig-a001-20230116 (https://download.01.org/0day-ci/archive/20230120/202301201858.yiiu0sKz-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7a7a933edd6c3a6d5d64e08093f2d564104cefcd
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7a7a933edd6c3a6d5d64e08093f2d564104cefcd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/gma500/ drivers/gpu/drm/vmwgfx/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/vmwgfx/vmwgfx_msg.c:713:21: warning: unused function 'mksstat_init_record' [-Wunused-function]
   static inline char *mksstat_init_record(mksstat_kern_stats_t stat_idx,
                       ^
   1 warning generated.


vim +/mksstat_init_record +713 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c

   701	
   702	/**
   703	 * mksstat_init_record: Initializes an MKSGuestStatCounter-based record
   704	 * for the respective mksGuestStat index.
   705	 *
   706	 * @stat_idx: Index of the MKSGuestStatCounter-based mksGuestStat record.
   707	 * @pstat: Pointer to array of MKSGuestStatCounterTime.
   708	 * @pinfo: Pointer to array of MKSGuestStatInfoEntry.
   709	 * @pstrs: Pointer to current end of the name/description sequence.
   710	 * Return: Pointer to the new end of the names/description sequence.
   711	 */
   712	
 > 713	static inline char *mksstat_init_record(mksstat_kern_stats_t stat_idx,
   714		MKSGuestStatCounterTime *pstat, MKSGuestStatInfoEntry *pinfo, char *pstrs)
   715	{
   716		char *const pstrd = pstrs + strlen(mksstat_kern_name_desc[stat_idx][0]) + 1;
   717		strcpy(pstrs, mksstat_kern_name_desc[stat_idx][0]);
   718		strcpy(pstrd, mksstat_kern_name_desc[stat_idx][1]);
   719	
   720		pinfo[stat_idx].name.s = pstrs;
   721		pinfo[stat_idx].description.s = pstrd;
   722		pinfo[stat_idx].flags = MKS_GUEST_STAT_FLAG_NONE;
   723		pinfo[stat_idx].stat.counter = (MKSGuestStatCounter *)&pstat[stat_idx];
   724	
   725		return pstrd + strlen(mksstat_kern_name_desc[stat_idx][1]) + 1;
   726	}
   727	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
