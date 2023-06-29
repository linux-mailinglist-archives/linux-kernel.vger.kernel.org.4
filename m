Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96506742866
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjF2Oae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 10:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjF2OaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:30:20 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDFD359A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 07:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688049018; x=1719585018;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lIxD8bIu9Y30Bft/k39ZqgXM7t4OIxqIdozW4uTf7wU=;
  b=Dfs4pMrcuA7OVQN+rLB56Mo4b0D0wkF1uKLpC2oyks143pLF0WHOxeMk
   IIotUMNOiE2S5YMbma1jnKcLkpVxVxC9eRblq70hGgt7PyFznYKWUKFZI
   1IvwBv8jtmZu4kuKfPCbwmRwQ0QnCrVka9qqfyRgszJ81DM//l9rFUJT1
   WkT90naTqJ91Mp2O/HV0wgbryCjWuBg1ghJ+RgUvjWpWBBVHKIM2yvcVI
   zJT3txMTR5JFKp3eowZmQRyhME8mYL+7SdzaFhOd9lixUObFd/YhuzdLf
   Q+kCGMKrpnZDi8L/0CoMnPLA4bHVgszkVcR/pd2PNa7ussuWutqX/IEWK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="364688054"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="364688054"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 07:19:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="782699779"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="782699779"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 29 Jun 2023 07:19:29 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qEsUa-000ECT-2E;
        Thu, 29 Jun 2023 14:19:28 +0000
Date:   Thu, 29 Jun 2023 22:19:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
Subject: fs/f2fs/gc.c:744:5: warning: stack frame size (3024) exceeds limit
 (2048) in 'f2fs_get_victim'
Message-ID: <202306292200.SGaQImUq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3a8a670eeeaa40d87bd38a587438952741980c18
commit: 19e0e21a51183d4e0784602f27e4db7b965077be f2fs: remove struct victim_selection default_v_ops
date:   3 months ago
config: riscv-randconfig-r026-20230629 (https://download.01.org/0day-ci/archive/20230629/202306292200.SGaQImUq-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230629/202306292200.SGaQImUq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306292200.SGaQImUq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/f2fs/gc.c:744:5: warning: stack frame size (3024) exceeds limit (2048) in 'f2fs_get_victim' [-Wframe-larger-than]
     744 | int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
         |     ^
   1 warning generated.


vim +/f2fs_get_victim +744 fs/f2fs/gc.c

   735	
   736	/*
   737	 * This function is called from two paths.
   738	 * One is garbage collection and the other is SSR segment selection.
   739	 * When it is called during GC, it just gets a victim segment
   740	 * and it does not remove it from dirty seglist.
   741	 * When it is called from SSR segment selection, it finds a segment
   742	 * which has minimum valid blocks and removes it from dirty seglist.
   743	 */
 > 744	int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
   745				int gc_type, int type, char alloc_mode,
   746				unsigned long long age)
   747	{
   748		struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
   749		struct sit_info *sm = SIT_I(sbi);
   750		struct victim_sel_policy p;
   751		unsigned int secno, last_victim;
   752		unsigned int last_segment;
   753		unsigned int nsearched;
   754		bool is_atgc;
   755		int ret = 0;
   756	
   757		mutex_lock(&dirty_i->seglist_lock);
   758		last_segment = MAIN_SECS(sbi) * sbi->segs_per_sec;
   759	
   760		p.alloc_mode = alloc_mode;
   761		p.age = age;
   762		p.age_threshold = sbi->am.age_threshold;
   763	
   764	retry:
   765		select_policy(sbi, gc_type, type, &p);
   766		p.min_segno = NULL_SEGNO;
   767		p.oldest_age = 0;
   768		p.min_cost = get_max_cost(sbi, &p);
   769	
   770		is_atgc = (p.gc_mode == GC_AT || p.alloc_mode == AT_SSR);
   771		nsearched = 0;
   772	
   773		if (is_atgc)
   774			SIT_I(sbi)->dirty_min_mtime = ULLONG_MAX;
   775	
   776		if (*result != NULL_SEGNO) {
   777			if (!get_valid_blocks(sbi, *result, false)) {
   778				ret = -ENODATA;
   779				goto out;
   780			}
   781	
   782			if (sec_usage_check(sbi, GET_SEC_FROM_SEG(sbi, *result)))
   783				ret = -EBUSY;
   784			else
   785				p.min_segno = *result;
   786			goto out;
   787		}
   788	
   789		ret = -ENODATA;
   790		if (p.max_search == 0)
   791			goto out;
   792	
   793		if (__is_large_section(sbi) && p.alloc_mode == LFS) {
   794			if (sbi->next_victim_seg[BG_GC] != NULL_SEGNO) {
   795				p.min_segno = sbi->next_victim_seg[BG_GC];
   796				*result = p.min_segno;
   797				sbi->next_victim_seg[BG_GC] = NULL_SEGNO;
   798				goto got_result;
   799			}
   800			if (gc_type == FG_GC &&
   801					sbi->next_victim_seg[FG_GC] != NULL_SEGNO) {
   802				p.min_segno = sbi->next_victim_seg[FG_GC];
   803				*result = p.min_segno;
   804				sbi->next_victim_seg[FG_GC] = NULL_SEGNO;
   805				goto got_result;
   806			}
   807		}
   808	
   809		last_victim = sm->last_victim[p.gc_mode];
   810		if (p.alloc_mode == LFS && gc_type == FG_GC) {
   811			p.min_segno = check_bg_victims(sbi);
   812			if (p.min_segno != NULL_SEGNO)
   813				goto got_it;
   814		}
   815	
   816		while (1) {
   817			unsigned long cost, *dirty_bitmap;
   818			unsigned int unit_no, segno;
   819	
   820			dirty_bitmap = p.dirty_bitmap;
   821			unit_no = find_next_bit(dirty_bitmap,
   822					last_segment / p.ofs_unit,
   823					p.offset / p.ofs_unit);
   824			segno = unit_no * p.ofs_unit;
   825			if (segno >= last_segment) {
   826				if (sm->last_victim[p.gc_mode]) {
   827					last_segment =
   828						sm->last_victim[p.gc_mode];
   829					sm->last_victim[p.gc_mode] = 0;
   830					p.offset = 0;
   831					continue;
   832				}
   833				break;
   834			}
   835	
   836			p.offset = segno + p.ofs_unit;
   837			nsearched++;
   838	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
