Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6B2702B13
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241138AbjEOLIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240137AbjEOLIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:08:19 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A7693
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 04:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684148895; x=1715684895;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yZ99ZMCYLBwexjv8Vl1K+iIr2mtRbS8QXSedAD7Kb00=;
  b=dEsCHLtRRArfDT7mzFunDJE6BG6v7I4pP979bHQc975gca88zjtIztM6
   Un0ag8CdytKap8W4puUDcybFZ21V89DRsgtg7XKBL5oNvQHHrC9xmBW6J
   kPZ9ZBO22UcN7pJtjedDFZ46yOHi+2nBc7Eu3JOo8Q/IVxk62XPR0/bdV
   jbgC19vxih0GgvoD+odVZuU8Xf2SnrZqRDHIhYL6yTI+GueXGAmBxqElo
   quxgVevMkyraDYNJJbu1tALyjUynSLHBbeTmkoJmHM4YCU4EXEdKc7/rz
   0+lzhHK23gtS2ohfY3qrlMBuHXAyKFOz3Wt/N2eEymSyqhEuF5c/giSLC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="330792156"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="330792156"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 04:08:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="765886422"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="765886422"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 15 May 2023 04:08:13 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pyW3o-0006KA-1J;
        Mon, 15 May 2023 11:08:12 +0000
Date:   Mon, 15 May 2023 19:08:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: powerpc-linux-objdump: Warning: Unable to load dwo file: <no
 .debug_str_offsets section>/<no .debug_str_offsets section>
Message-ID: <202305151926.KbHNnoqL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
commit: 32ef9e5054ec0321b9336058c58ec749e9c6b0fe Makefile.debug: re-enable debug info for .S files
date:   8 months ago
config: powerpc-randconfig-r033-20230515 (https://download.01.org/0day-ci/archive/20230515/202305151926.KbHNnoqL-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project b0fb98227c90adf2536c9ad644a74d5e92961111)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=32ef9e5054ec0321b9336058c58ec749e9c6b0fe
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 32ef9e5054ec0321b9336058c58ec749e9c6b0fe
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305151926.KbHNnoqL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
--
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
   powerpc-linux-objdump: Warning: Unrecognized form: 0x23
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
>> powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>
   powerpc-linux-objdump: Warning: Unable to load dwo file: <no .debug_str_offsets section>/<no .debug_str_offsets section>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
