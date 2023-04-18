Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84ABF6E6B67
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjDRRuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjDRRuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:50:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D86618A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681840202; x=1713376202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4g4RNFt/nvzBukVZ+1r6EaicuiIbuuWLbEhbGbUz/9M=;
  b=fJKZsUsVe8xiFG1/V6l8I2hpTvtkz3vyhlinnPJm43tDY9s8033BypAS
   4LQIFfSE48r5hlHKECcPDUbPZSHaLzQjv4PQsItsqOO6FZNuBu993pjR7
   8Sf/W0Ley4MkTtOoXYXJCAsOr6r5LUsntkztbCibZLQHe26GoMMz8AJHu
   wCJu+VcS5mgURETNaxUSrNgCqWBGbjvhGzo/K+vQYLTdx8TraJC1pcN7B
   Cu507egHel6ywLD4/+p2TI4UsjCIhCgAVbpvuqHthQRnc9BsJ9Ee2DD8c
   +CCVMqy4yIxmHY4gpP78gLbrFspsnnmrydkv+RAYFl+tpkqHt1kD3+cvE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="431527662"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="431527662"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 10:50:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="780568550"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="780568550"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Apr 2023 10:50:00 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1popSp-000dpj-1m;
        Tue, 18 Apr 2023 17:49:59 +0000
Date:   Wed, 19 Apr 2023 01:49:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lin Chun Yeh <r09921093@g.ntu.edu.tw>, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Lin Chun Yeh <r09921093@g.ntu.edu.tw>
Subject: Re: [PATCH] include/linux/rbtree.h: move the declaration of c in
 rb_find_add()
Message-ID: <202304190118.H5o8xyuA-lkp@intel.com>
References: <20230418145712.20620-1-r09921093@g.ntu.edu.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418145712.20620-1-r09921093@g.ntu.edu.tw>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lin,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.3-rc7 next-20230417]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lin-Chun-Yeh/include-linux-rbtree-h-move-the-declaration-of-c-in-rb_find_add/20230418-230031
patch link:    https://lore.kernel.org/r/20230418145712.20620-1-r09921093%40g.ntu.edu.tw
patch subject: [PATCH] include/linux/rbtree.h: move the declaration of c in rb_find_add()
config: arm-randconfig-r046-20230416 (https://download.01.org/0day-ci/archive/20230419/202304190118.H5o8xyuA-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 437b7602e4a998220871de78afcb020b9c14a661)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/9348e5c71c46a8d88c805acf5dd56c1785bc04e8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lin-Chun-Yeh/include-linux-rbtree-h-move-the-declaration-of-c-in-rb_find_add/20230418-230031
        git checkout 9348e5c71c46a8d88c805acf5dd56c1785bc04e8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/tilcdc/ drivers/memstick/host/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304190118.H5o8xyuA-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from arch/arm/kernel/asm-offsets.c:11:
   In file included from include/linux/sched.h:20:
   In file included from include/linux/hrtimer.h:16:
>> include/linux/rbtree.h:231:7: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                   int c = cmp(node, parent);
                       ^
   1 warning generated.
--
   In file included from drivers/memstick/host/r592.c:8:
   In file included from include/linux/module.h:14:
   In file included from include/linux/buildid.h:5:
   In file included from include/linux/mm_types.h:11:
>> include/linux/rbtree.h:231:7: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                   int c = cmp(node, parent);
                       ^
   drivers/memstick/host/r592.c:47:13: warning: no previous prototype for function 'memstick_debug_get_tpc_name' [-Wmissing-prototypes]
   const char *memstick_debug_get_tpc_name(int tpc)
               ^
   drivers/memstick/host/r592.c:47:7: note: declare 'static' if the function is not intended to be used outside of this translation unit
   const char *memstick_debug_get_tpc_name(int tpc)
         ^
   static 
   2 warnings generated.
--
   In file included from drivers/gpu/drm/tilcdc/tilcdc_plane.c:7:
   In file included from include/drm/drm_atomic.h:31:
   In file included from include/drm/drm_crtc.h:30:
   In file included from include/drm/drm_modeset_lock.h:28:
   In file included from include/linux/stackdepot.h:25:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:22:
   In file included from include/linux/mm_types.h:11:
>> include/linux/rbtree.h:231:7: error: mixing declarations and code is incompatible with standards before C99 [-Werror,-Wdeclaration-after-statement]
                   int c = cmp(node, parent);
                       ^
   1 error generated.
--
   In file included from arch/arm/kernel/asm-offsets.c:11:
   In file included from include/linux/sched.h:20:
   In file included from include/linux/hrtimer.h:16:
>> include/linux/rbtree.h:231:7: warning: mixing declarations and code is incompatible with standards before C99 [-Wdeclaration-after-statement]
                   int c = cmp(node, parent);
                       ^
   1 warning generated.


vim +231 include/linux/rbtree.h

   212	
   213	/**
   214	 * rb_find_add() - find equivalent @node in @tree, or add @node
   215	 * @node: node to look-for / insert
   216	 * @tree: tree to search / modify
   217	 * @cmp: operator defining the node order
   218	 *
   219	 * Returns the rb_node matching @node, or NULL when no match is found and @node
   220	 * is inserted.
   221	 */
   222	static __always_inline struct rb_node *
   223	rb_find_add(struct rb_node *node, struct rb_root *tree,
   224		    int (*cmp)(struct rb_node *, const struct rb_node *))
   225	{
   226		struct rb_node **link = &tree->rb_node;
   227		struct rb_node *parent = NULL;
   228	
   229		while (*link) {
   230			parent = *link;
 > 231			int c = cmp(node, parent);
   232	
   233			if (c < 0)
   234				link = &parent->rb_left;
   235			else if (c > 0)
   236				link = &parent->rb_right;
   237			else
   238				return parent;
   239		}
   240	
   241		rb_link_node(node, parent, link);
   242		rb_insert_color(node, tree);
   243		return NULL;
   244	}
   245	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
