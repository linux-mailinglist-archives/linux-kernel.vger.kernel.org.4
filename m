Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF89F6E71E5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 05:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjDSDyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 23:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjDSDyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 23:54:32 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C316193
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 20:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681876470; x=1713412470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R1qaT336hNAFzmGgj8Jazc2I9A2sSxxMVokaZFnldcI=;
  b=mg2RWfxt6Xo+WshCmjgFtDOpVIsra4LHRQdYnQjjOrXjAQrb5xYzquu6
   fW97A6+x6SCPmEyR7H9Gap2gciKWPO4WblOZ+tPO+LNxnnvjAVkLUxtgf
   HtCVLz3AQJltsemMppNoyoVEGQSiJIXsYPQODp1DyIGxLTEsBDyPmakgP
   oj3aQF6iJUakm6tfVZf7RXwXsFLklel/ZsxfbFK+3EQ1vHc7HFjpNKOY4
   OWTWwZj8WmnErLYPhA2SxIO4Z7DU1LcKTA+n5cywzDyVB0TijEW7FOn1n
   CCnnpv2mWuCwmees51PgOaIeNy5ydEzdYnSwoDWMa8t4WNmSe0EMckdLX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="373224325"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="373224325"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 20:54:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="721750476"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="721750476"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 18 Apr 2023 20:54:28 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1poytn-000eSM-3B;
        Wed, 19 Apr 2023 03:54:27 +0000
Date:   Wed, 19 Apr 2023 11:54:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lin Chun Yeh <r09921093@g.ntu.edu.tw>, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Lin Chun Yeh <r09921093@g.ntu.edu.tw>
Subject: Re: [PATCH] include/linux/rbtree.h: move the declaration of c in
 rb_find_add()
Message-ID: <202304191107.GfNLJjsT-lkp@intel.com>
References: <20230418145712.20620-1-r09921093@g.ntu.edu.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418145712.20620-1-r09921093@g.ntu.edu.tw>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lin,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.3-rc7 next-20230418]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lin-Chun-Yeh/include-linux-rbtree-h-move-the-declaration-of-c-in-rb_find_add/20230418-230031
patch link:    https://lore.kernel.org/r/20230418145712.20620-1-r09921093%40g.ntu.edu.tw
patch subject: [PATCH] include/linux/rbtree.h: move the declaration of c in rb_find_add()
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20230419/202304191107.GfNLJjsT-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9348e5c71c46a8d88c805acf5dd56c1785bc04e8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lin-Chun-Yeh/include-linux-rbtree-h-move-the-declaration-of-c-in-rb_find_add/20230418-230031
        git checkout 9348e5c71c46a8d88c805acf5dd56c1785bc04e8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/lib/ lib/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304191107.GfNLJjsT-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/mm_types.h:11,
                    from include/linux/uio.h:10,
                    from include/linux/socket.h:8,
                    from include/linux/compat.h:15,
                    from arch/powerpc/kernel/asm-offsets.c:12:
   include/linux/rbtree.h: In function 'rb_find_add':
>> include/linux/rbtree.h:231:17: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     231 |                 int c = cmp(node, parent);
         |                 ^~~
--
   In file included from include/linux/hrtimer.h:16,
                    from include/linux/sched.h:20,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from lib/radix-tree.c:15:
   include/linux/rbtree.h: In function 'rb_find_add':
>> include/linux/rbtree.h:231:17: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     231 |                 int c = cmp(node, parent);
         |                 ^~~
   lib/radix-tree.c: At top level:
   lib/radix-tree.c:288:6: warning: no previous prototype for 'radix_tree_node_rcu_free' [-Wmissing-prototypes]
     288 | void radix_tree_node_rcu_free(struct rcu_head *head)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/mm_types.h:11,
                    from include/linux/mmzone.h:22,
                    from include/linux/gfp.h:7,
                    from include/linux/xarray.h:15,
                    from include/linux/radix-tree.h:21,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/clk-provider.h:9,
                    from lib/vsprintf.c:23:
   include/linux/rbtree.h: In function 'rb_find_add':
>> include/linux/rbtree.h:231:17: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     231 |                 int c = cmp(node, parent);
         |                 ^~~
   lib/vsprintf.c: In function 'va_format':
   lib/vsprintf.c:1681:9: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1681 |         buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
         |         ^~~
--
   In file included from include/linux/mm_types.h:11,
                    from include/linux/mmzone.h:22,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:15,
                    from arch/powerpc/lib/alloc.c:4:
   include/linux/rbtree.h: In function 'rb_find_add':
>> include/linux/rbtree.h:231:17: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
     231 |                 int c = cmp(node, parent);
         |                 ^~~
   cc1: all warnings being treated as errors
--
   In file included from include/linux/hrtimer.h:16,
                    from include/linux/sched.h:20,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from include/linux/kprobes.h:28,
                    from arch/powerpc/lib/sstep.c:8:
   include/linux/rbtree.h: In function 'rb_find_add':
>> include/linux/rbtree.h:231:17: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
     231 |                 int c = cmp(node, parent);
         |                 ^~~
   arch/powerpc/lib/sstep.c: In function 'analyse_instr':
   arch/powerpc/lib/sstep.c:1355:28: error: variable 'suffix' set but not used [-Werror=unused-but-set-variable]
    1355 |         unsigned int word, suffix;
         |                            ^~~~~~
   arch/powerpc/lib/sstep.c:1351:38: error: variable 'rc' set but not used [-Werror=unused-but-set-variable]
    1351 |         unsigned int opcode, ra, rb, rc, rd, spr, u;
         |                                      ^~
   cc1: all warnings being treated as errors
--
   In file included from include/linux/mm_types.h:11,
                    from include/linux/uio.h:10,
                    from include/linux/socket.h:8,
                    from include/linux/compat.h:15,
                    from arch/powerpc/kernel/asm-offsets.c:12:
   include/linux/rbtree.h: In function 'rb_find_add':
>> include/linux/rbtree.h:231:17: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     231 |                 int c = cmp(node, parent);
         |                 ^~~


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
