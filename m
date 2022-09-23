Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEC15E72D0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 06:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiIWEVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 00:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiIWEVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 00:21:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8484211D60C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 21:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663906893; x=1695442893;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pT2GsFKbzQR+EGbp46rGjdhBAtEL/XBSBroPWrEWed4=;
  b=QGeO/FKY23aYRRdpn+4Pp7+enQLnFg5D/LXhi1o0itnAER5EGbxfUnzb
   uIE+G+i3/6EkeXOwuaDGJ04TdOfeQ5G+an9Sd86jW4gtOu0ooVWbl4jST
   G1PQtopSkdwbcEi4ysroVhWOlRL9xeuOS1jmOPFhJe/Bk61XeK+RhYmMr
   KUQ5MS43G0AIHl9mjvTS9E+4totsxhYOj83Wd3hV8PbepGHQvHSy2gvt3
   fGCt1YZCr1aMScqTRmpe2CRUxnm5FXVKTzf1uH2jhqoHD8+oZEV4CZoVp
   MffVYM0RtAvOw3/Lk7BFCfF8+fZ4AUtzpGkDTnRDxTzN92/rRMrcTo3kO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="326834590"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="326834590"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 21:21:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="571243792"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Sep 2022 21:21:31 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obaBu-0005IY-1N;
        Fri, 23 Sep 2022 04:21:30 +0000
Date:   Fri, 23 Sep 2022 12:20:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:brauner/linux/fs.acl.rework 12/37] ERROR:
 modpost: "posix_acl_alloc" [fs/cifs/cifs.ko] undefined!
Message-ID: <202209231201.hHibG4RZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block brauner/linux/fs.acl.rework
head:   6d56d354d97c08df55b4c06e1f45903f000b7c7c
commit: 38cc77ebad48e4a1a8e5021445e013080bda5fdd [12/37] cifs: implement get acl method
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20220923/202209231201.hHibG4RZ-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/38cc77ebad48e4a1a8e5021445e013080bda5fdd
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block brauner/linux/fs.acl.rework
        git checkout 38cc77ebad48e4a1a8e5021445e013080bda5fdd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "posix_acl_alloc" [fs/cifs/cifs.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
