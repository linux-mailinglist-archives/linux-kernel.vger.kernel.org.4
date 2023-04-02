Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F74D6D35EA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 09:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjDBHcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 03:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDBHcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 03:32:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF9AC676
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 00:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680420726; x=1711956726;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lo5nEgqiNIXNsZUgeozg0vNJ8HL2LgYV1BYTIKtHqUw=;
  b=gUsnyuvdyxNt2orJDz/oJ/isv/9EXmm4Ct4xj3QjXnVXNkjhVWgFKxkI
   Ee8o+pQmqUHlDGacnuVyQkWab5GXqPeCkOLaf+me2dXgj++IursmSW4Io
   3tTj2rAQqOhNFhHGY1gFFxpwaEoQPK3Z8CHINPCzllfa8Hv7IuyTlme73
   Xwh0YWUtP3kNQC7A1wPpcQ7rNDEsYHYRM2smNyxQYim7qW/jqHoBfXZrq
   PbTfDTRciP99Buv0KPKzj5E0j0W/MImBnn+k6m2tqyoIwM1lvT9fOYy/x
   cwAnAG0632XucMDp/RZQ9y9LytracT7o5oz7mVUE9OgQv/aos3pylL622
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="344264319"
X-IronPort-AV: E=Sophos;i="5.98,312,1673942400"; 
   d="scan'208";a="344264319"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2023 00:32:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="754863004"
X-IronPort-AV: E=Sophos;i="5.98,312,1673942400"; 
   d="scan'208";a="754863004"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 02 Apr 2023 00:31:53 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pisBs-000NIP-08;
        Sun, 02 Apr 2023 07:31:52 +0000
Date:   Sun, 2 Apr 2023 15:31:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/xtensa/lib/kcsan-stubs.c:6:6: sparse: sparse: symbol
 '__atomic_store_8' was not declared. Should it be static?
Message-ID: <202304021532.n6LwHMwd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   00c7b5f4ddc5b346df62b757ec73f9357bb452af
commit: 725aea873261e8d986e527838fde2a721f0962d8 xtensa: enable KCSAN
date:   11 months ago
config: xtensa-randconfig-s053-20230402 (https://download.01.org/0day-ci/archive/20230402/202304021532.n6LwHMwd-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=725aea873261e8d986e527838fde2a721f0962d8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 725aea873261e8d986e527838fde2a721f0962d8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=xtensa olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304021532.n6LwHMwd-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/xtensa/lib/kcsan-stubs.c:6:6: sparse: sparse: symbol '__atomic_store_8' was not declared. Should it be static?
>> arch/xtensa/lib/kcsan-stubs.c:11:5: sparse: sparse: symbol '__atomic_load_8' was not declared. Should it be static?
>> arch/xtensa/lib/kcsan-stubs.c:16:5: sparse: sparse: symbol '__atomic_exchange_8' was not declared. Should it be static?
>> arch/xtensa/lib/kcsan-stubs.c:21:6: sparse: sparse: symbol '__atomic_compare_exchange_8' was not declared. Should it be static?
>> arch/xtensa/lib/kcsan-stubs.c:26:5: sparse: sparse: symbol '__atomic_fetch_add_8' was not declared. Should it be static?
>> arch/xtensa/lib/kcsan-stubs.c:31:5: sparse: sparse: symbol '__atomic_fetch_sub_8' was not declared. Should it be static?
>> arch/xtensa/lib/kcsan-stubs.c:36:5: sparse: sparse: symbol '__atomic_fetch_and_8' was not declared. Should it be static?
>> arch/xtensa/lib/kcsan-stubs.c:41:5: sparse: sparse: symbol '__atomic_fetch_or_8' was not declared. Should it be static?
>> arch/xtensa/lib/kcsan-stubs.c:46:5: sparse: sparse: symbol '__atomic_fetch_xor_8' was not declared. Should it be static?
>> arch/xtensa/lib/kcsan-stubs.c:51:5: sparse: sparse: symbol '__atomic_fetch_nand_8' was not declared. Should it be static?

vim +/__atomic_store_8 +6 arch/xtensa/lib/kcsan-stubs.c

     5	
   > 6	void __atomic_store_8(volatile void *p, u64 v, int i)
     7	{
     8		BUG();
     9	}
    10	
  > 11	u64 __atomic_load_8(const volatile void *p, int i)
    12	{
    13		BUG();
    14	}
    15	
  > 16	u64 __atomic_exchange_8(volatile void *p, u64 v, int i)
    17	{
    18		BUG();
    19	}
    20	
  > 21	bool __atomic_compare_exchange_8(volatile void *p1, void *p2, u64 v, bool b, int i1, int i2)
    22	{
    23		BUG();
    24	}
    25	
  > 26	u64 __atomic_fetch_add_8(volatile void *p, u64 v, int i)
    27	{
    28		BUG();
    29	}
    30	
  > 31	u64 __atomic_fetch_sub_8(volatile void *p, u64 v, int i)
    32	{
    33		BUG();
    34	}
    35	
  > 36	u64 __atomic_fetch_and_8(volatile void *p, u64 v, int i)
    37	{
    38		BUG();
    39	}
    40	
  > 41	u64 __atomic_fetch_or_8(volatile void *p, u64 v, int i)
    42	{
    43		BUG();
    44	}
    45	
  > 46	u64 __atomic_fetch_xor_8(volatile void *p, u64 v, int i)
    47	{
    48		BUG();
    49	}
    50	
  > 51	u64 __atomic_fetch_nand_8(volatile void *p, u64 v, int i)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
