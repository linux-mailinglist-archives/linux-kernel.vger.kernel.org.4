Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3846E6AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjDRR3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjDRR3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:29:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411B293D8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681838941; x=1713374941;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oWfV+GXMmupQjQMSsG2+W4HzEvfb4pQRGtYW7Lqa1iM=;
  b=IucHXlkKc85XyrIM05kJ6ovdhmlyGDonYy9cLRuLSpxzi3NyiuY1JU+7
   KIrnO83WbD2gRnFx/jCt88A4CZeRCTvHGlZuneP8/oFbf0kZEcASJ/4Jz
   i4IwEJ0TGhe7Ju/9cit3CxZjVATFa2coNeWlp7x50+q1iq4fpRBmF4mgL
   cUj4iYbdwu9o3JQjK+FyY88IFIqa2cgMFLqJF85uRbA4YtdCy8SCXxkfl
   fh05NprIjfEQz1EgGwwDQ/VjJm+gK/Lv3Ix813e961afF7Yz5YJTQpI0g
   7O0GDQ2ITjMm/zgqZbgZ5B5/j+GDGeL8ql3mB50K9i8//dwboOXlrYA6c
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="342724815"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="342724815"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 10:29:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="802610986"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="802610986"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 18 Apr 2023 10:28:58 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pop8T-000doF-36;
        Tue, 18 Apr 2023 17:28:57 +0000
Date:   Wed, 19 Apr 2023 01:28:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qing Zhang <zhangqing@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     oe-kbuild-all@lists.linux.dev,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] LoongArch: Add pad structure members for explicit
 alignment
Message-ID: <202304190108.aA4uyDQZ-lkp@intel.com>
References: <20230418091348.9239-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418091348.9239-1-zhangqing@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qing,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.3-rc7 next-20230417]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qing-Zhang/LoongArch-Adjust-the-user_regset_copyin-parameter-to-the-correct-offset/20230418-171556
patch link:    https://lore.kernel.org/r/20230418091348.9239-1-zhangqing%40loongson.cn
patch subject: [PATCH 1/2] LoongArch: Add pad structure members for explicit alignment
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20230419/202304190108.aA4uyDQZ-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/dace28025b7b1f35b35042ddac8bdb1e412c2d7f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Qing-Zhang/LoongArch-Adjust-the-user_regset_copyin-parameter-to-the-correct-offset/20230418-171556
        git checkout dace28025b7b1f35b35042ddac8bdb1e412c2d7f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304190108.aA4uyDQZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/loongarch/kernel/ptrace.c: In function 'hw_break_set':
>> arch/loongarch/kernel/ptrace.c:626:60: error: 'PTRACE_HBP_PAD_SZ' undeclared (first use in this function); did you mean 'PTRACE_HBP_MASK_SZ'?
     626 |                                           offset, offset + PTRACE_HBP_PAD_SZ);
         |                                                            ^~~~~~~~~~~~~~~~~
         |                                                            PTRACE_HBP_MASK_SZ
   arch/loongarch/kernel/ptrace.c:626:60: note: each undeclared identifier is reported only once for each function it appears in


vim +626 arch/loongarch/kernel/ptrace.c

   571	
   572	static int hw_break_set(struct task_struct *target,
   573				const struct user_regset *regset,
   574				unsigned int pos, unsigned int count,
   575				const void *kbuf, const void __user *ubuf)
   576	{
   577		u32 ctrl;
   578		u64 addr, mask;
   579		int ret, idx = 0, offset, limit;
   580		unsigned int note_type = regset->core_note_type;
   581	
   582		/* Resource info and pad */
   583		offset = offsetof(struct user_watch_state, dbg_regs);
   584		user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf, 0, offset);
   585	
   586		/* (address, ctrl) registers */
   587		limit = regset->n * regset->size;
   588		while (count && offset < limit) {
   589			if (count < PTRACE_HBP_ADDR_SZ)
   590				return -EINVAL;
   591	
   592			ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &addr,
   593						 offset, offset + PTRACE_HBP_ADDR_SZ);
   594			if (ret)
   595				return ret;
   596	
   597			ret = ptrace_hbp_set_addr(note_type, target, idx, addr);
   598			if (ret)
   599				return ret;
   600			offset += PTRACE_HBP_ADDR_SZ;
   601	
   602			if (!count)
   603				break;
   604	
   605			ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &mask,
   606						 offset, offset + PTRACE_HBP_ADDR_SZ);
   607			if (ret)
   608				return ret;
   609	
   610			ret = ptrace_hbp_set_mask(note_type, target, idx, mask);
   611			if (ret)
   612				return ret;
   613			offset += PTRACE_HBP_MASK_SZ;
   614	
   615			ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &mask,
   616						 offset, offset + PTRACE_HBP_MASK_SZ);
   617			if (ret)
   618				return ret;
   619	
   620			ret = ptrace_hbp_set_ctrl(note_type, target, idx, ctrl);
   621			if (ret)
   622				return ret;
   623			offset += PTRACE_HBP_CTRL_SZ;
   624	
   625			user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
 > 626						  offset, offset + PTRACE_HBP_PAD_SZ);
   627			offset += PTRACE_HBP_PAD_SZ;
   628			idx++;
   629		}
   630	
   631		return 0;
   632	}
   633	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
