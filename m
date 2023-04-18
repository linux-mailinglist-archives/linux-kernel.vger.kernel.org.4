Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FAA6E6B69
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjDRRuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbjDRRuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:50:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AEAAF08
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681840207; x=1713376207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=suSvHCfDMVSDhb6qb/XPBOCF60iPIwXhOcIrEcKHZ7k=;
  b=CWazJW3j0+DnEd+jZeS7zcwo87lisGaoIeOX0erZc/TCcBVSDZVfNurU
   ALgRM6wJa7Noj7VQw9BnSe7vlzfNhgmkiFkLucGYtDBjIYAeqKqvD4fQm
   J0Dvl6+7zbqo1xhjkxBYKURykt+dkwvYQoKul+dpdPwyGBWUefk+4NABg
   60p3SkDguHbVkChrggFTTGZ6hhxsk+V6CiykJCygTZh9MfH4MpJd09DQ1
   moWM+CVMzqiJS3FYsY9+caUHT7PZFbnd4GY8J6QErITJTaSfHP7lBiV+w
   oTobXReVzwZsG4iBLd2GmJ/RAPD3+2EdaAAkvJWHuNNO7Zm2z5nhAwbUc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="334051336"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="334051336"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 10:50:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="937337182"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="937337182"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 18 Apr 2023 10:50:05 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1popSp-000dpn-1v;
        Tue, 18 Apr 2023 17:49:59 +0000
Date:   Wed, 19 Apr 2023 01:49:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lin Chun Yeh <r09921093@g.ntu.edu.tw>, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Lin Chun Yeh <r09921093@g.ntu.edu.tw>
Subject: Re: [PATCH] include/linux/rbtree.h: move the declaration of c in
 rb_find_add()
Message-ID: <202304190130.57DBIvkF-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.3-rc7 next-20230417]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lin-Chun-Yeh/include-linux-rbtree-h-move-the-declaration-of-c-in-rb_find_add/20230418-230031
patch link:    https://lore.kernel.org/r/20230418145712.20620-1-r09921093%40g.ntu.edu.tw
patch subject: [PATCH] include/linux/rbtree.h: move the declaration of c in rb_find_add()
config: arc-randconfig-r043-20230416 (https://download.01.org/0day-ci/archive/20230419/202304190130.57DBIvkF-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9348e5c71c46a8d88c805acf5dd56c1785bc04e8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lin-Chun-Yeh/include-linux-rbtree-h-move-the-declaration-of-c-in-rb_find_add/20230418-230031
        git checkout 9348e5c71c46a8d88c805acf5dd56c1785bc04e8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc prepare

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304190130.57DBIvkF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/hrtimer.h:16,
                    from include/linux/sched.h:20,
                    from arch/arc/kernel/asm-offsets.c:6:
   include/linux/rbtree.h: In function 'rb_find_add':
>> include/linux/rbtree.h:231:17: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     231 |                 int c = cmp(node, parent);
         |                 ^~~
--
   In file included from include/linux/mm_types.h:11,
                    from include/linux/mmzone.h:22,
                    from include/linux/gfp.h:7,
                    from include/linux/xarray.h:15,
                    from include/linux/list_lru.h:14,
                    from include/linux/fs.h:13,
                    from include/linux/decompress/mm.h:80,
                    from lib/decompress_inflate.c:32:
   include/linux/rbtree.h: In function 'rb_find_add':
>> include/linux/rbtree.h:231:17: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     231 |                 int c = cmp(node, parent);
         |                 ^~~
   lib/decompress_inflate.c: At top level:
   lib/decompress_inflate.c:42:17: warning: no previous prototype for '__gunzip' [-Wmissing-prototypes]
      42 | STATIC int INIT __gunzip(unsigned char *buf, long len,
         |                 ^~~~~~~~
--
   In file included from include/linux/mm_types.h:11,
                    from include/linux/mmzone.h:22,
                    from include/linux/gfp.h:7,
                    from include/linux/xarray.h:15,
                    from include/linux/list_lru.h:14,
                    from include/linux/fs.h:13,
                    from include/linux/decompress/mm.h:80,
                    from lib/decompress_unxz.c:107:
   include/linux/rbtree.h: In function 'rb_find_add':
>> include/linux/rbtree.h:231:17: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     231 |                 int c = cmp(node, parent);
         |                 ^~~
   lib/decompress_unxz.c: At top level:
   lib/decompress_unxz.c:251:17: warning: no previous prototype for 'unxz' [-Wmissing-prototypes]
     251 | STATIC int INIT unxz(unsigned char *in, long in_size,
         |                 ^~~~
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
   In file included from include/linux/hrtimer.h:16,
                    from include/linux/sched.h:20,
                    from lib/ubsan.c:15:
   include/linux/rbtree.h: In function 'rb_find_add':
>> include/linux/rbtree.h:231:17: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     231 |                 int c = cmp(node, parent);
         |                 ^~~
   lib/ubsan.c: At top level:
   lib/ubsan.c:226:6: warning: no previous prototype for '__ubsan_handle_divrem_overflow' [-Wmissing-prototypes]
     226 | void __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/ubsan.c:307:6: warning: no previous prototype for '__ubsan_handle_type_mismatch' [-Wmissing-prototypes]
     307 | void __ubsan_handle_type_mismatch(struct type_mismatch_data *data,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/ubsan.c:321:6: warning: no previous prototype for '__ubsan_handle_type_mismatch_v1' [-Wmissing-prototypes]
     321 | void __ubsan_handle_type_mismatch_v1(void *_data, void *ptr)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/ubsan.c:335:6: warning: no previous prototype for '__ubsan_handle_out_of_bounds' [-Wmissing-prototypes]
     335 | void __ubsan_handle_out_of_bounds(void *_data, void *index)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/ubsan.c:352:6: warning: no previous prototype for '__ubsan_handle_shift_out_of_bounds' [-Wmissing-prototypes]
     352 | void __ubsan_handle_shift_out_of_bounds(void *_data, void *lhs, void *rhs)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/ubsan.c:394:6: warning: no previous prototype for '__ubsan_handle_builtin_unreachable' [-Wmissing-prototypes]
     394 | void __ubsan_handle_builtin_unreachable(void *_data)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/ubsan.c:404:6: warning: no previous prototype for '__ubsan_handle_load_invalid_value' [-Wmissing-prototypes]
     404 | void __ubsan_handle_load_invalid_value(void *_data, void *val)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/mm_types.h:11,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from lib/test_ubsan.c:4:
   include/linux/rbtree.h: In function 'rb_find_add':
>> include/linux/rbtree.h:231:17: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     231 |                 int c = cmp(node, parent);
         |                 ^~~
   lib/test_ubsan.c: In function 'test_ubsan_out_of_bounds':
   lib/test_ubsan.c:40:22: warning: variable 'arr' set but not used [-Wunused-but-set-variable]
      40 |         volatile int arr[4];
         |                      ^~~
   lib/test_ubsan.c:39:23: warning: variable 'above' set but not used [-Wunused-but-set-variable]
      39 |         volatile char above[4] = { }; /* Protect surrounding memory. */
         |                       ^~~~~
   lib/test_ubsan.c: In function 'test_ubsan_load_invalid_value':
   lib/test_ubsan.c:62:44: warning: variable 'eptr' set but not used [-Wunused-but-set-variable]
      62 |         enum ubsan_test_enum eval, eval2, *eptr;
         |                                            ^~~~
   lib/test_ubsan.c:61:26: warning: variable 'ptr' set but not used [-Wunused-but-set-variable]
      61 |         bool val, val2, *ptr;
         |                          ^~~
   lib/test_ubsan.c: At top level:
   lib/test_ubsan.c:100:28: warning: 'skip_ubsan_array' defined but not used [-Wunused-const-variable=]
     100 | static const test_ubsan_fp skip_ubsan_array[] = {
         |                            ^~~~~~~~~~~~~~~~
--
   In file included from include/linux/mm_types.h:11,
                    from include/linux/mmzone.h:22,
                    from include/linux/gfp.h:7,
                    from include/linux/xarray.h:15,
                    from include/linux/list_lru.h:14,
                    from include/linux/fs.h:13,
                    from include/linux/debugfs.h:15,
                    from lib/kunit/debugfs.c:7:
   include/linux/rbtree.h: In function 'rb_find_add':
>> include/linux/rbtree.h:231:17: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     231 |                 int c = cmp(node, parent);
         |                 ^~~
   lib/kunit/debugfs.c: At top level:
   lib/kunit/debugfs.c:28:6: warning: no previous prototype for 'kunit_debugfs_cleanup' [-Wmissing-prototypes]
      28 | void kunit_debugfs_cleanup(void)
         |      ^~~~~~~~~~~~~~~~~~~~~
   lib/kunit/debugfs.c:33:6: warning: no previous prototype for 'kunit_debugfs_init' [-Wmissing-prototypes]
      33 | void kunit_debugfs_init(void)
         |      ^~~~~~~~~~~~~~~~~~
   lib/kunit/debugfs.c:92:6: warning: no previous prototype for 'kunit_debugfs_create_suite' [-Wmissing-prototypes]
      92 | void kunit_debugfs_create_suite(struct kunit_suite *suite)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/kunit/debugfs.c:108:6: warning: no previous prototype for 'kunit_debugfs_destroy_suite' [-Wmissing-prototypes]
     108 | void kunit_debugfs_destroy_suite(struct kunit_suite *suite)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/mm_types.h:11,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from lib/crc64.c:36:
   include/linux/rbtree.h: In function 'rb_find_add':
>> include/linux/rbtree.h:231:17: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     231 |                 int c = cmp(node, parent);
         |                 ^~~
   lib/crc64.c: At top level:
   lib/crc64.c:39:10: fatal error: crc64table.h: No such file or directory
      39 | #include "crc64table.h"
         |          ^~~~~~~~~~~~~~
   compilation terminated.
--
   In file included from include/linux/hrtimer.h:16,
                    from include/linux/sched.h:20,
                    from arch/arc/kernel/asm-offsets.c:6:
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
