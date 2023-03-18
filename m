Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA00A6BFD6C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 00:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjCRXOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 19:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCRXOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 19:14:05 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474D6193F7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 16:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679181240; x=1710717240;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZXLwzxX1ghBPuoVFA9SLRbbmMr0xENgIMSsN834QBFs=;
  b=OZYckqeAp0k26N9VkcmOh/OKD97zZTq+9j/WrKd9zh8Yx2dl879Xh9FN
   8g2HQB5ZVZYnWrYSX7PMHCzcuK1ymreKUHmuPsG2tXjaWSvA5ZOY6z2lI
   HZWhe/ERuBqUqWjKhAZFXN+S1WET+0nu/wDSJJKp7e9PJ0pJrTCEueHfC
   vMKWvtI44WGZ0h2aWztC8aJG2N5VdxNUZ2qtwz3cDGNcKOI40FKd6e+el
   FUrYKHzzmdH3M3AFVqe6N/f45WE/71r8oyaoED+6KOyuWDEp0ugw2klSM
   b8xx/I2GapwbneqP1NT3VwQVR5Et9w4+RCkXzV3ihGTYHCsAW6tXwLSBY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="335963489"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="335963489"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 16:13:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="713138307"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="713138307"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 18 Mar 2023 16:13:57 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdfkK-000AIo-0x;
        Sat, 18 Mar 2023 23:13:56 +0000
Date:   Sun, 19 Mar 2023 07:13:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: powerpc-linux-objdump: Warning: Unable to load dwo file: <no
 .debug_str_offsets section>/<no .debug_str_offsets section>
Message-ID: <202303190735.ggcj2qGw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   534293368afa1a953c283310b82e4dc58309d51e
commit: 32ef9e5054ec0321b9336058c58ec749e9c6b0fe Makefile.debug: re-enable debug info for .S files
date:   6 months ago
config: powerpc-randconfig-r023-20230319 (https://download.01.org/0day-ci/archive/20230319/202303190735.ggcj2qGw-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
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
| Link: https://lore.kernel.org/oe-kbuild-all/202303190735.ggcj2qGw-lkp@intel.com/

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
