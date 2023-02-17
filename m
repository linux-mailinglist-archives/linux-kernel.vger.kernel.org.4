Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B0769A514
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 06:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBQF1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 00:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBQF1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 00:27:05 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0BC5B752
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 21:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676611623; x=1708147623;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=y8sdwyVNjgp+rES3f9O5lbxG6cfNN//6Yvo8qu3BJC8=;
  b=W70AzASjqdKlZuVV2O2Lk+NYcWnpej41k/HdadIccnMcRrkiqXRdcz2R
   cN7dBLyEJRQu0klMPeAT6uiotJHlkdgUSfvNBf3wNRhNPk5jPL7967yz6
   irwzIGLmea40DxKoaEm87/jF7Rrm/UzK7jJ+KbbMX8Ro4hv41V7MHawdm
   wW2kZI+YdafadREp3AJVaGzX4eBS/Hql4zmRDmF1m9ix9XZ67OxNMMuFR
   f+KEUWBW007sZSi1OTWbyHjyjQtBjRaXoA7AE13vDe32JqS+4csdNvPpq
   apv1RTzxr851STE63E9btdVM/UfH1/rH9CFp7zVvfHwbhRBlhYb8DoGV/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="394388410"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="394388410"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 21:27:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="700789426"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="700789426"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 16 Feb 2023 21:27:00 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pStGu-000B93-0N;
        Fri, 17 Feb 2023 05:27:00 +0000
Date:   Fri, 17 Feb 2023 13:26:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Muhammad Sammar <muhammads@nvidia.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v0.c:1170:1:
 warning: stack frame size (1168) exceeds limit (1024) in
 'dr_ste_v0_build_eth_ipv6_l3_l4_tag'
Message-ID: <202302171359.vvB4yivq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3ac88fa4605ec98e545fb3ad0154f575fda2de5f
commit: 7766c9b922febe18b4eb124eb731dd9a1ec71373 net/mlx5: DR, Add missing reserved fields to dr_match_param
date:   1 year, 2 months ago
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20230217/202302171359.vvB4yivq-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7766c9b922febe18b4eb124eb731dd9a1ec71373
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7766c9b922febe18b4eb124eb731dd9a1ec71373
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/net/ethernet/mellanox/ drivers/platform/ drivers/staging/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302171359.vvB4yivq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v0.c:1170:1: warning: stack frame size (1168) exceeds limit (1024) in 'dr_ste_v0_build_eth_ipv6_l3_l4_tag' [-Wframe-larger-than]
   dr_ste_v0_build_eth_ipv6_l3_l4_tag(struct mlx5dr_match_param *value,
   ^
   56/1168 (4.79%) spills, 1112/1168 (95.21%) variables
   1 warning generated.


vim +/dr_ste_v0_build_eth_ipv6_l3_l4_tag +1170 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ste_v0.c

d65e841de80375 Yevgeny Kliteynik 2020-11-19  1168  
d65e841de80375 Yevgeny Kliteynik 2020-11-19  1169  static int
d65e841de80375 Yevgeny Kliteynik 2020-11-19 @1170  dr_ste_v0_build_eth_ipv6_l3_l4_tag(struct mlx5dr_match_param *value,
d65e841de80375 Yevgeny Kliteynik 2020-11-19  1171  				   struct mlx5dr_ste_build *sb,
d65e841de80375 Yevgeny Kliteynik 2020-11-19  1172  				   u8 *tag)
d65e841de80375 Yevgeny Kliteynik 2020-11-19  1173  {
d65e841de80375 Yevgeny Kliteynik 2020-11-19  1174  	struct mlx5dr_match_spec *spec = sb->inner ? &value->inner : &value->outer;
0733535d59e154 Yevgeny Kliteynik 2021-07-04  1175  	struct mlx5dr_match_misc *misc = &value->misc;
d65e841de80375 Yevgeny Kliteynik 2020-11-19  1176  
d65e841de80375 Yevgeny Kliteynik 2020-11-19  1177  	DR_STE_SET_TAG(eth_l4, tag, dst_port, spec, tcp_dport);
d65e841de80375 Yevgeny Kliteynik 2020-11-19  1178  	DR_STE_SET_TAG(eth_l4, tag, src_port, spec, tcp_sport);
d65e841de80375 Yevgeny Kliteynik 2020-11-19  1179  	DR_STE_SET_TAG(eth_l4, tag, dst_port, spec, udp_dport);
d65e841de80375 Yevgeny Kliteynik 2020-11-19  1180  	DR_STE_SET_TAG(eth_l4, tag, src_port, spec, udp_sport);
d65e841de80375 Yevgeny Kliteynik 2020-11-19  1181  	DR_STE_SET_TAG(eth_l4, tag, protocol, spec, ip_protocol);
d65e841de80375 Yevgeny Kliteynik 2020-11-19  1182  	DR_STE_SET_TAG(eth_l4, tag, fragmented, spec, frag);
d65e841de80375 Yevgeny Kliteynik 2020-11-19  1183  	DR_STE_SET_TAG(eth_l4, tag, dscp, spec, ip_dscp);
d65e841de80375 Yevgeny Kliteynik 2020-11-19  1184  	DR_STE_SET_TAG(eth_l4, tag, ecn, spec, ip_ecn);
d65e841de80375 Yevgeny Kliteynik 2020-11-19  1185  	DR_STE_SET_TAG(eth_l4, tag, ipv6_hop_limit, spec, ttl_hoplimit);
d65e841de80375 Yevgeny Kliteynik 2020-11-19  1186  
0733535d59e154 Yevgeny Kliteynik 2021-07-04  1187  	if (sb->inner)
0733535d59e154 Yevgeny Kliteynik 2021-07-04  1188  		DR_STE_SET_TAG(eth_l4, tag, flow_label, misc, inner_ipv6_flow_label);
0733535d59e154 Yevgeny Kliteynik 2021-07-04  1189  	else
0733535d59e154 Yevgeny Kliteynik 2021-07-04  1190  		DR_STE_SET_TAG(eth_l4, tag, flow_label, misc, outer_ipv6_flow_label);
0733535d59e154 Yevgeny Kliteynik 2021-07-04  1191  
d65e841de80375 Yevgeny Kliteynik 2020-11-19  1192  	if (spec->tcp_flags) {
d65e841de80375 Yevgeny Kliteynik 2020-11-19  1193  		DR_STE_SET_TCP_FLAGS(eth_l4, tag, spec);
d65e841de80375 Yevgeny Kliteynik 2020-11-19  1194  		spec->tcp_flags = 0;
d65e841de80375 Yevgeny Kliteynik 2020-11-19  1195  	}
d65e841de80375 Yevgeny Kliteynik 2020-11-19  1196  
d65e841de80375 Yevgeny Kliteynik 2020-11-19  1197  	return 0;
d65e841de80375 Yevgeny Kliteynik 2020-11-19  1198  }
d65e841de80375 Yevgeny Kliteynik 2020-11-19  1199  

:::::: The code at line 1170 was first introduced by commit
:::::: d65e841de80375372f9842ed71756d3b90d96dc4 net/mlx5: DR, Move HW STEv0 match logic to a separate file

:::::: TO: Yevgeny Kliteynik <kliteyn@nvidia.com>
:::::: CC: Saeed Mahameed <saeedm@nvidia.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
