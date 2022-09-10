Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B310F5B43E3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 05:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiIJDtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 23:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiIJDtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 23:49:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEF05FDB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 20:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662781774; x=1694317774;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ot8IDxW2fdHVXVqZXnIKJhABRQWz5o2GhIZGebSiIWg=;
  b=d564eam5bCnCnVY9YQ+Lhr52iKPvk78CbL+u13mUXfnN8r7Y9lSifjmi
   2KwzGlX5vnyRxpv3G509w0GBqjnBBr0KeCNND1EF52uHRluXxj2yNP09S
   HAtkZbhr9Tl9/LhRBFSshx+Ed6KxKc+gsLJ013FLWvHAUUuSRCW0amXgu
   iPsSjG3PkzRQ116IoLwX3gYjBj/nQWFxdFjNPGm4xRQI3+Oeqd/RkMzKD
   uheE/1tLdn9V6eNwNVxBA0/L+lE5B0RjDji3AwSa8DhcEtya0FCv1WbrK
   bZtHNEGc6dNcS9czbfN+7fOQU/ifzEdhcecicS4/Gi2wrf5m8qA3z2K/J
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="298948479"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="298948479"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 20:49:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="592841714"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 09 Sep 2022 20:49:32 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWrUp-00025B-2V;
        Sat, 10 Sep 2022 03:49:31 +0000
Date:   Sat, 10 Sep 2022 11:49:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Joey Gouly <joey.gouly@arm.com>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [ammarfaizi2-block:arm64/linux/for-next/gettimeofday 2/3]
 arch/arm64/kernel/alternative.c:198:6: warning: no previous prototype for
 'apply_alternatives_vdso'
Message-ID: <202209101157.EfOSTasF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block arm64/linux/for-next/gettimeofday
head:   9025cebf12d1763de36d5e09e2b0a1e4f9b13b28
commit: 4e3bca8f7cdd3b658ee7ad700fdce95b5e13a441 [2/3] arm64: alternative: patch alternatives in the vDSO
config: arm64-buildonly-randconfig-r001-20220907 (https://download.01.org/0day-ci/archive/20220910/202209101157.EfOSTasF-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/4e3bca8f7cdd3b658ee7ad700fdce95b5e13a441
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block arm64/linux/for-next/gettimeofday
        git checkout 4e3bca8f7cdd3b658ee7ad700fdce95b5e13a441
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kernel/alternative.c:198:6: warning: no previous prototype for 'apply_alternatives_vdso' [-Wmissing-prototypes]
     198 | void apply_alternatives_vdso(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~


vim +/apply_alternatives_vdso +198 arch/arm64/kernel/alternative.c

   197	
 > 198	void apply_alternatives_vdso(void)
   199	{
   200		struct alt_region region;
   201		const struct elf64_hdr *hdr;
   202		const struct elf64_shdr *shdr;
   203		const struct elf64_shdr *alt;
   204		DECLARE_BITMAP(all_capabilities, ARM64_NPATCHABLE);
   205	
   206		bitmap_fill(all_capabilities, ARM64_NPATCHABLE);
   207	
   208		hdr = (struct elf64_hdr *)vdso_start;
   209		shdr = (void *)hdr + hdr->e_shoff;
   210		alt = find_section(hdr, shdr, ".altinstructions");
   211		if (!alt)
   212			return;
   213	
   214		region = (struct alt_region){
   215			.begin	= (void *)hdr + alt->sh_offset,
   216			.end	= (void *)hdr + alt->sh_offset + alt->sh_size,
   217		};
   218	
   219		__apply_alternatives(&region, false, &all_capabilities[0]);
   220	}
   221	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
