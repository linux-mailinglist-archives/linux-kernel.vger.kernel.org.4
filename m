Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DF96E6B9F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjDRSBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjDRSBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:01:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C68E9EEC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 11:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681840869; x=1713376869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8u+vJor3wIKmVy+6xDJwDdFuGBx5XCO1s3un6U0ulqQ=;
  b=GGJSHzL6Rcbk60BCasXuBWrqrdNM7Wm5v67wTA1aceVIrFGakym8rkvA
   Wtb7CA8apeGp0G0UvXAJ2P3fZZJ1kI7bpVG/OAcCg1kuM7hx7rAw5OFeU
   gBXgeD9yq8uithKOOOs5nyI0fQvgqZBsTYMz4Igo1RbLZXTyDrp3mbcNY
   O21BawWp6HVGSjwzQtHjPs6ONDXcu6NPVyOPiHnJYnhbMmfOBCodf2GXj
   MpZ721vfmIwXI7Og6KtNHCTwFXy23e6d/GAlatWSC03mqRS6g3wldALKt
   7sUIPLNUjIip5KJmQHv90IxFAGq36fca+rjkxsKeQvWDLD5SdcPGAeGiQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="343995571"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="343995571"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 11:01:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="802616683"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="802616683"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 18 Apr 2023 11:01:05 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1popdT-000dqT-3D;
        Tue, 18 Apr 2023 18:00:59 +0000
Date:   Wed, 19 Apr 2023 02:00:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lin Chun Yeh <r09921093@g.ntu.edu.tw>, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Lin Chun Yeh <r09921093@g.ntu.edu.tw>
Subject: Re: [PATCH] include/linux/rbtree.h: move the declaration of c in
 rb_find_add()
Message-ID: <202304190113.SlgVhTbO-lkp@intel.com>
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
config: riscv-randconfig-r042-20230416 (https://download.01.org/0day-ci/archive/20230419/202304190113.SlgVhTbO-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9348e5c71c46a8d88c805acf5dd56c1785bc04e8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lin-Chun-Yeh/include-linux-rbtree-h-move-the-declaration-of-c-in-rb_find_add/20230418-230031
        git checkout 9348e5c71c46a8d88c805acf5dd56c1785bc04e8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash lib/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304190113.SlgVhTbO-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/mm_types.h:11,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from lib/test_bitops.c:9:
   include/linux/rbtree.h: In function 'rb_find_add':
>> include/linux/rbtree.h:231:17: error: ISO C90 forbids mixed declarations and code [-Werror=declaration-after-statement]
     231 |                 int c = cmp(node, parent);
         |                 ^~~
   cc1: all warnings being treated as errors


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
