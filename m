Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9146B5B9379
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 06:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiIOEJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 00:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIOEJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 00:09:15 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0088C8E0EF;
        Wed, 14 Sep 2022 21:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663214954; x=1694750954;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TzphYM1h+6I8Oo1m4GyReXXjD1TCLY++ypjD7c+v8/c=;
  b=lU/UKNN/lijyxU674Md/oHJeM8yK5+J13Ze3kd4pik8075EIBL1XRk8R
   B25hHhlPFnWA9erTd1/Bp6ulz5h/0m5T4EyotBD058Hp04yco6x4duXVo
   epYH4Bdxk9Lex+cVqKcCL7bJpbsH8YatixTW65jadJ8Hf3N2KPJZ4Z9Jt
   gX8JwhRot5ifus/PSuBc3a+8ooo6K3QkMzMhr7/lCt8eA53Slyvcbh0Va
   6Xkzsq2F4Pvn0SYkOaMtfwwL8u3+f7NjqUqIz2TkxmdfQAtJsOsctz7JU
   5S9Za95sRZMyybsaAwu6NWXZZCv47a2vDFDHPG1QAyuyPm8L6mrG4ng4+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="360345510"
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="360345510"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 21:09:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,316,1654585200"; 
   d="scan'208";a="594659869"
Received: from lkp-server01.sh.intel.com (HELO d6e6b7c4e5a2) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Sep 2022 21:09:13 -0700
Received: from kbuild by d6e6b7c4e5a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYgBc-0000qu-17;
        Thu, 15 Sep 2022 04:09:12 +0000
Date:   Thu, 15 Sep 2022 12:09:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [ammarfaizi2-block:palmer/linux/riscv-hwprobe 2/4] htmldocs:
 Documentation/riscv/hwprobe.rst:40: WARNING: Unexpected indentation.
Message-ID: <202209151152.HqgJ1dvn-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block palmer/linux/riscv-hwprobe
head:   9be297f7ed349945cccc85f8df9d90e5ab68c1d9
commit: b4d5e48f9f63b0c36801f57df0c22c7328f841c2 [2/4] (WIP) RISC-V: hwprobe: Add support for RISCV_HWPROBE_BASE_BEHAVIOR_IMA
reproduce:
        # https://github.com/ammarfaizi2/linux-block/commit/b4d5e48f9f63b0c36801f57df0c22c7328f841c2
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block palmer/linux/riscv-hwprobe
        git checkout b4d5e48f9f63b0c36801f57df0c22c7328f841c2
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/riscv/hwprobe.rst:40: WARNING: Unexpected indentation.

vim +40 Documentation/riscv/hwprobe.rst

    27	
    28	* :RISCV_HWPROBE_KEY_MVENDORID:: Contains the value of :mvendorid:, as per the
    29	  ISA specifications.
    30	* :RISCV_HWPROBE_KEY_MARCHID:: Contains the value of :marchid:, as per the ISA
    31	  specifications.
    32	* :RISCV_HWPROBE_KEY_MIMPLID:: Contains the value of :mimplid:, as per the ISA
    33	  specifications.
    34	* :RISCV_HWPROBE_KEY_BASE_BEHAVIOR:: A bitmask containing the base user-visible
    35	  behavior that this kernel supports.  The following base user ABIs are defined:
    36	    * :RISCV_HWPROBE_BASE_BEHAVIOR_IMA:: Support for rv32ima or rv64ima, as
    37	      defined by version 2.2 of the user ISA and version 1.10 of the privileged
    38	      ISA, with the following known exceptions (more exceptions may be added,
    39	      but only if it can be demonstrated that the user ABI is not broken):
  > 40	        * The :fence.i: instruction cannot be directly executed by userspace

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
