Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6893868C721
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjBFT6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjBFT6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:58:23 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA9B2529C;
        Mon,  6 Feb 2023 11:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675713502; x=1707249502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UIapvv7U+q+921kWLqdNFbESCnm/nzRFWlKArB41l4U=;
  b=JPuKj4WJ+CMUQ+1w4e1DNpbozOUihNxFWfhS8k29QL46i9+Arl68CDr2
   rB/E8L1tOITx3gplyJBJeOeQk4zPr7AP4Wku+7fzAT2/GQyBmOmry23vR
   eCOW6BFrYq8+jIVoSLdNJdTd1bcGEKU4UwdMyYJFp75Im2Jh2C3yTdDLA
   hnH6z8G1iwT7Q4Qzcph++bcdxbyKx6q/W/r/rwT/lgk/m3eM20HijYJ+g
   1ZTqtVGYS/1IOhWckP+fjwlxc9Wad37kAAWt/j5zBD6T7j6jOhj0rTjyT
   tRo4hn52+nNROWQnZGtt2Hn1nMZgGcvzs5xP6WMcifA+ShJuMWEmx9sv6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="331435552"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="331435552"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 11:58:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="666592985"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="666592985"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 06 Feb 2023 11:58:12 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pP7cx-0002kq-0A;
        Mon, 06 Feb 2023 19:58:11 +0000
Date:   Tue, 7 Feb 2023 03:57:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin Liu <liumartin@google.com>, robh+dt@kernel.org,
        frowand.list@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, surenb@google.com,
        minchan@kernel.org, tkjos@google.com, liumartin@google.com
Subject: Re: [PATCH] of: reserved-mem: expose reserved-mem details via debugfs
Message-ID: <202302070307.dJ4f1zXY-lkp@intel.com>
References: <20230206142714.4151047-1-liumartin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206142714.4151047-1-liumartin@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.2-rc7 next-20230206]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Martin-Liu/of-reserved-mem-expose-reserved-mem-details-via-debugfs/20230206-222927
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230206142714.4151047-1-liumartin%40google.com
patch subject: [PATCH] of: reserved-mem: expose reserved-mem details via debugfs
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230207/202302070307.dJ4f1zXY-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/5d479d32b3863f2ec8d10d756aa57cf29046e334
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Martin-Liu/of-reserved-mem-expose-reserved-mem-details-via-debugfs/20230206-222927
        git checkout 5d479d32b3863f2ec8d10d756aa57cf29046e334
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/of/of_reserved_mem.c: In function 'of_reserved_mem_debug_show':
>> drivers/of/of_reserved_mem.c:465:46: warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'phys_addr_t' {aka 'unsigned int'} [-Wformat=]
     465 |                 seq_printf(m, "%pa..%pa ( %7lu KB ) %5s %12s %s\n", &rmem->base,
         |                                           ~~~^
         |                                              |
         |                                              long unsigned int
         |                                           %7u
     466 |                            &end, rmem->size / 1024,
         |                                  ~~~~~~~~~~~~~~~~~
         |                                             |
         |                                             phys_addr_t {aka unsigned int}


vim +465 drivers/of/of_reserved_mem.c

   450	
   451	#if defined(CONFIG_DEBUG_FS)
   452	static int of_reserved_mem_debug_show(struct seq_file *m, void *private)
   453	{
   454		unsigned int i;
   455		size_t sum = 0;
   456	
   457		for (i = 0; i < reserved_mem_count; i++) {
   458			const struct reserved_mem *rmem = &reserved_mem[i];
   459			unsigned long node = rmem->fdt_node;
   460			phys_addr_t end = rmem->base + rmem->size - 1;
   461			bool nomap = (of_get_flat_dt_prop(node, "no-map", NULL)) != NULL;
   462			bool reusable = (of_get_flat_dt_prop(node, "reusable", NULL)) != NULL;
   463	
   464			sum += rmem->size;
 > 465			seq_printf(m, "%pa..%pa ( %7lu KB ) %5s %12s %s\n", &rmem->base,
   466				   &end, rmem->size / 1024,
   467				   nomap ? "nomap" : "map",
   468				   reusable ? "reusable" : "non-reusable",
   469				   rmem->name ? rmem->name : "unknown");
   470		}
   471		seq_printf(m, "Total %d regions, %zu KB\n",
   472			   reserved_mem_count,
   473			   sum / 1024);
   474		return 0;
   475	}
   476	DEFINE_SHOW_ATTRIBUTE(of_reserved_mem_debug);
   477	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
