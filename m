Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02CC674E2B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 08:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjATHd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 02:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjATHd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 02:33:56 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DEC73EE6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 23:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674200030; x=1705736030;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E/UF7TBDRgGen5SO3g0cWQwzdb9hUsBif7M3Ipox2to=;
  b=LObhrnFVD7cjCMogxRu/n7EkQGlrvwRvSPx8+1PGDrehQyChK9y6IX6F
   ARc+2GICjWnu8iysahBcRUNBKLtaD1OnK8z60Xtmx6/P7EVxWeAO/HdAO
   SKN5AbermF8QqEKUSNNJDi7IthNjkmcST9p373do/+Icu93RK45hefsCC
   UBwjHvGngY8aedjMws/o82VSSjLswRnhNcbpFRLulSLTgeayQn1iNzGzR
   JeHV4oYZqqj8g8S4hjUPJ7y70dfG1Aazdl/HgWUvehAKQFnzQtS7e+nIO
   5tPu9w9qCtE73Jwy9ud7cnpMWdYttKYwjWCiaq4EDlvefeIpjacpFMQBz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="326802303"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="326802303"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 23:33:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="690960193"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="690960193"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 19 Jan 2023 23:33:48 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIluE-0002KU-2w;
        Fri, 20 Jan 2023 07:33:46 +0000
Date:   Fri, 20 Jan 2023 15:33:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: powerpc-linux-objdump: Warning: Unable to load dwo file: <no
 .debug_str_offsets section>/<no .debug_str_offsets section>
Message-ID: <202301201500.zOhtyYyX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d368967cb1039b5c4cccb62b5a4b9468c50cd143
commit: 32ef9e5054ec0321b9336058c58ec749e9c6b0fe Makefile.debug: re-enable debug info for .S files
date:   4 months ago
config: powerpc-buildonly-randconfig-r005-20230119 (https://download.01.org/0day-ci/archive/20230120/202301201500.zOhtyYyX-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
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
