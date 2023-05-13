Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD41670145E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 06:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjEMEiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 00:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEMEiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 00:38:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086193A92
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 21:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683952685; x=1715488685;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=88zUBblgJtC7cwHXyGMtuv0mzy6yfcm6Iey5SLA4TrI=;
  b=Q8YRvEfY9SeSGouhl1Jm26mwAM/3SLaHyJDsPuimtmklbeBdYKXXfCjX
   zD98QwCB3pLjT2MJHHgP7B1VCcxGWp+2geI7F4/Ybb5UBptac7W0/9PLf
   eY4Ot0nokTmMjwYeMICnA6jIIfmo7gq07h2mrhm9TAPpvdmT9rvGujrRC
   LaDv5YRFoFjaC1LtbSMb+6mtqO0MpnN6PzLjjZ13BAYI0T7KV2MfjsSoA
   sv29Dd3+cZrZMcTn+fFdMgDuQbe8f3EN2e6LFSsdgMNnHd7Dnk9FRyUb/
   INwxrnmic6/OLrEi1LaRVZgKS+dZVhFksyaroWqF/yY+Iu/taj/Uvf/Ba
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="330542631"
X-IronPort-AV: E=Sophos;i="5.99,271,1677571200"; 
   d="scan'208";a="330542631"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 21:38:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="733270095"
X-IronPort-AV: E=Sophos;i="5.99,271,1677571200"; 
   d="scan'208";a="733270095"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 12 May 2023 21:38:04 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxh19-0005KA-1m;
        Sat, 13 May 2023 04:38:03 +0000
Date:   Sat, 13 May 2023 12:37:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: ERROR: modpost: "__divsi3_table" [lib/lz4/lz4_compress.ko] undefined!
Message-ID: <202305131258.uQTO6pF1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9a48d604672220545d209e9996c2a1edbb5637f6
commit: 5750121ae7382ebac8d47ce6d68012d6cd1d7926 kbuild: list sub-directories in ./Kbuild
date:   8 months ago
config: nios2-randconfig-r033-20230512 (https://download.01.org/0day-ci/archive/20230513/202305131258.uQTO6pF1-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5750121ae7382ebac8d47ce6d68012d6cd1d7926
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5750121ae7382ebac8d47ce6d68012d6cd1d7926
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305131258.uQTO6pF1-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "__mulsi3" [kernel/locking/test-ww_mutex.ko] undefined!
ERROR: modpost: "__mulsi3" [fs/ntfs3/ntfs3.ko] undefined!
ERROR: modpost: "__mulsi3" [fs/autofs/autofs4.ko] undefined!
ERROR: modpost: "__mulsi3" [fs/overlayfs/overlay.ko] undefined!
ERROR: modpost: "__mulsi3" [fs/btrfs/btrfs.ko] undefined!
ERROR: modpost: "__mulsi3" [crypto/essiv.ko] undefined!
ERROR: modpost: "__mulsi3" [lib/math/cordic.ko] undefined!
ERROR: modpost: "__mulsi3" [lib/lz4/lz4_compress.ko] undefined!
>> ERROR: modpost: "__divsi3_table" [lib/lz4/lz4_compress.ko] undefined!
ERROR: modpost: "__mulsi3" [lib/lzo/lzo_compress.ko] undefined!
WARNING: modpost: suppressed 412 unresolved symbol warnings because there were too many)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
