Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DCE682112
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 01:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjAaAva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 19:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjAaAv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 19:51:28 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FC321968
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 16:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675126287; x=1706662287;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ms81k0ksGwpWX9k63Kd5BmczEUjMDbx0W2ca3fPYGbY=;
  b=LSHC+3Qsv7AStuW+//H7GEAeychZ7YFL0LIvFFh3rqC8tlZ4u6ZsfKdn
   zkjXf9SfcWLBF81tsK/bspQ2sWnHDENmZchwbSp9hz6k2WhyI0aNeFaTD
   c/RLfgdShIa19GR+Ie94P6IZt0yTg4oCPFBXcBEp3TkGc0MlJOvXSHaX1
   XtLFWPsoLZ0FCfKD9O0F3iT6JTPyDaRPhf2VOpZigMU3XilE3iU3kbb8A
   zKTrfBbQL6Oci2hDjU6cXHG+bkDZr7PhWj/ORHvzKQmpqcsYe9dFkkd3Y
   dBgIfWmYf/lffmDDdt078Kx1hRufc/RqxSljHuTsK1VV9b7rYzWFu1rZA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="308062994"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="308062994"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 16:51:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="657657940"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="657657940"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 30 Jan 2023 16:51:26 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pMert-00040w-18;
        Tue, 31 Jan 2023 00:51:25 +0000
Date:   Tue, 31 Jan 2023 08:50:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arm-linux-gnueabi-ld: error: .btf.vmlinux.bin.o is already in final
 BE8 format
Message-ID: <202301310812.ZtXGVDzU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6d796c50f84ca79f1722bb131799e5a5710c4700
commit: 5d6f52671e76ca2d55d74e676ac4c38ceb14a2d3 ARM: rework endianess selection
date:   10 months ago
config: arm-buildonly-randconfig-r004-20230130 (https://download.01.org/0day-ci/archive/20230131/202301310812.ZtXGVDzU-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5d6f52671e76ca2d55d74e676ac4c38ceb14a2d3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5d6f52671e76ca2d55d74e676ac4c38ceb14a2d3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arm-linux-gnueabi-ld: error: .btf.vmlinux.bin.o is already in final BE8 format
   arm-linux-gnueabi-ld: failed to merge target specific data of file .btf.vmlinux.bin.o

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
