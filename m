Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0726F719FD1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbjFAOYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbjFAOYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:24:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175A4132
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 07:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685629475; x=1717165475;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tp+SjkGXZe+Un/c0ek5fly5NDhncMHaC/CSumCRPt88=;
  b=aaWPRUlFfR5BRXorP7C9oe/jBkp31UI2upLJv3hD/EZzbYANLdwMKTBc
   EilCFf9J+k8DqhgiX3fb41Ck1ihc1qEJw7Boj5m3ElQ3v0HM8ffsgVQ92
   eFdyRzMQEoaiDfzZWHiRdxatRySGefDeAiUHQYkxZTSca5GGrHgKkVBzC
   RdLoaUthYcXqJV7wC34rxq91atTjyYA/HuWek1iNQgLU300i/Gb0t4auy
   w9YFj0En4z8ZKDCuUyqxNCTvdGCZyjKw2wL8syKI7XDMVeYLYE6biH3Wz
   H90miC1PCfXDMNPOp++8a+sg5lQXQO4N2y39sc+4YPEEOvn4V2tZ3/aOl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="419088753"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="419088753"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 07:19:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="657813874"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="657813874"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 Jun 2023 07:19:17 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4j93-0002M4-0M;
        Thu, 01 Jun 2023 14:19:17 +0000
Date:   Thu, 1 Jun 2023 22:18:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     beomsu kim <beomsu7.kim@samsung.com>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Yonggil Song <yonggil.song@samsung.com>,
        Seokhwan Kim <sukka.kim@samsung.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Seonghun Kim <seonghun-sui.kim@samsung.com>
Subject: Re: [PATCH] f2fs: including waf data in f2fs status information
Message-ID: <202306011750.kDn4yxlq-lkp@intel.com>
References: <20230531082038epcms2p256f9db0d7ac377d404694354db1c3ebc@epcms2p2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531082038epcms2p256f9db0d7ac377d404694354db1c3ebc@epcms2p2>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi beomsu,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.4-rc4]
[also build test ERROR on linus/master next-20230601]
[cannot apply to jaegeuk-f2fs/dev-test jaegeuk-f2fs/dev]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/beomsu-kim/f2fs-including-waf-data-in-f2fs-status-information/20230531-162208
base:   7877cb91f1081754a1487c144d85dc0d2e2e7fc4
patch link:    https://lore.kernel.org/r/20230531082038epcms2p256f9db0d7ac377d404694354db1c3ebc%40epcms2p2
patch subject: [PATCH] f2fs: including waf data in f2fs status information
config: x86_64-randconfig-a005-20230531 (https://download.01.org/0day-ci/archive/20230601/202306011750.kDn4yxlq-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/3a2228fdedf76cc8448b358d07b77eb26d1299a4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review beomsu-kim/f2fs-including-waf-data-in-f2fs-status-information/20230531-162208
        git checkout 3a2228fdedf76cc8448b358d07b77eb26d1299a4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/f2fs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306011750.kDn4yxlq-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   fs/f2fs/iostat.c: In function 'iostat_info_seq_show':
>> fs/f2fs/iostat.c:37:37: error: implicit declaration of function 'F2FS_STAT'; did you mean 'F2FS_CKPT'? [-Werror=implicit-function-declaration]
      37 |         struct f2fs_stat_info *si = F2FS_STAT(sbi);
         |                                     ^~~~~~~~~
         |                                     F2FS_CKPT
>> fs/f2fs/iostat.c:37:37: warning: initialization of 'struct f2fs_stat_info *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>> fs/f2fs/iostat.c:46:46: error: invalid use of undefined type 'struct f2fs_stat_info'
      46 |                 data_written_to_storage += si->sbi->iostat_bytes[j];
         |                                              ^~
   fs/f2fs/iostat.c:48:43: error: invalid use of undefined type 'struct f2fs_stat_info'
      48 |                 data_written_by_user += si->sbi->iostat_bytes[j];
         |                                           ^~
   cc1: some warnings being treated as errors


vim +37 fs/f2fs/iostat.c

    26	
    27	#define IOSTAT_INFO_SHOW(name, type)					\
    28		seq_printf(seq, "%-23s %-16llu %-16llu %-16llu\n",		\
    29				name":", sbi->iostat_bytes[type],		\
    30				sbi->iostat_count[type],			\
    31				iostat_get_avg_bytes(sbi, type))
    32	
    33	int __maybe_unused iostat_info_seq_show(struct seq_file *seq, void *offset)
    34	{
    35		struct super_block *sb = seq->private;
    36		struct f2fs_sb_info *sbi = F2FS_SB(sb);
  > 37		struct f2fs_stat_info *si = F2FS_STAT(sbi);
    38		int j;
    39		unsigned long long waf = 0;
    40		unsigned long long data_written_to_storage = 0, data_written_by_user = 0;
    41	
    42		if (!sbi->iostat_enable)
    43			return 0;
    44	
    45		for (j = FS_DATA_IO; j <= FS_CP_META_IO; j++)
  > 46			data_written_to_storage += si->sbi->iostat_bytes[j];
    47		for (j = FS_DATA_IO; j <= FS_CDATA_IO; j++)
    48			data_written_by_user += si->sbi->iostat_bytes[j];
    49	
    50		if (data_written_by_user > 0)
    51			waf = data_written_to_storage * 100 / data_written_by_user;
    52	
    53		seq_printf(seq, "time:		%-16llu\n", ktime_get_real_seconds());
    54		seq_printf(seq, "\t\t\t%-16s %-16s %-16s\n",
    55					"io_bytes", "count", "avg_bytes");
    56	
    57		/* print app write IOs */
    58		seq_puts(seq, "[WRITE]\n");
    59		IOSTAT_INFO_SHOW("app buffered data", APP_BUFFERED_IO);
    60		IOSTAT_INFO_SHOW("app direct data", APP_DIRECT_IO);
    61		IOSTAT_INFO_SHOW("app mapped data", APP_MAPPED_IO);
    62		IOSTAT_INFO_SHOW("app buffered cdata", APP_BUFFERED_CDATA_IO);
    63		IOSTAT_INFO_SHOW("app mapped cdata", APP_MAPPED_CDATA_IO);
    64	
    65		/* print fs write IOs */
    66		IOSTAT_INFO_SHOW("fs data", FS_DATA_IO);
    67		IOSTAT_INFO_SHOW("fs cdata", FS_CDATA_IO);
    68		IOSTAT_INFO_SHOW("fs node", FS_NODE_IO);
    69		IOSTAT_INFO_SHOW("fs meta", FS_META_IO);
    70		IOSTAT_INFO_SHOW("fs gc data", FS_GC_DATA_IO);
    71		IOSTAT_INFO_SHOW("fs gc node", FS_GC_NODE_IO);
    72		IOSTAT_INFO_SHOW("fs cp data", FS_CP_DATA_IO);
    73		IOSTAT_INFO_SHOW("fs cp node", FS_CP_NODE_IO);
    74		IOSTAT_INFO_SHOW("fs cp meta", FS_CP_META_IO);
    75	
    76		/* print app read IOs */
    77		seq_puts(seq, "[READ]\n");
    78		IOSTAT_INFO_SHOW("app buffered data", APP_BUFFERED_READ_IO);
    79		IOSTAT_INFO_SHOW("app direct data", APP_DIRECT_READ_IO);
    80		IOSTAT_INFO_SHOW("app mapped data", APP_MAPPED_READ_IO);
    81		IOSTAT_INFO_SHOW("app buffered cdata", APP_BUFFERED_CDATA_READ_IO);
    82		IOSTAT_INFO_SHOW("app mapped cdata", APP_MAPPED_CDATA_READ_IO);
    83	
    84		/* print fs read IOs */
    85		IOSTAT_INFO_SHOW("fs data", FS_DATA_READ_IO);
    86		IOSTAT_INFO_SHOW("fs gc data", FS_GDATA_READ_IO);
    87		IOSTAT_INFO_SHOW("fs cdata", FS_CDATA_READ_IO);
    88		IOSTAT_INFO_SHOW("fs node", FS_NODE_READ_IO);
    89		IOSTAT_INFO_SHOW("fs meta", FS_META_READ_IO);
    90	
    91		/* print other IOs */
    92		seq_puts(seq, "[OTHER]\n");
    93		IOSTAT_INFO_SHOW("fs discard", FS_DISCARD_IO);
    94		IOSTAT_INFO_SHOW("fs flush", FS_FLUSH_IO);
    95	
    96		/* print waf */
    97		seq_puts(seq, "[WAF]\n");
    98		seq_printf(seq, "fs waf:		%llu.%02llu\n", waf / 100, waf % 100);
    99	
   100		return 0;
   101	}
   102	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
