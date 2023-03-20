Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01146C10D6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjCTLcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjCTLcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:32:06 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A210CDDD
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679311925; x=1710847925;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Uhg6W9cYOVpGZ7/FiEjjXsbv5sVRzAtwpiVoMqnhCp8=;
  b=ko6l2YGQtIYMlJ/v/L98OxPCHoDfnX91ilFbadiBRCI1hP0xMFSIhP+e
   fpuhcW6VKhi5do/MfYCAZxl7LCEtYv6MfIcrATvogtqrVrHR1NeGFB/IM
   pNzcoFBQYw2Vis2q/kxsdBsJCKoKaMC+sijoLfaAa4Rh+55FtBjGqIFpg
   2fxKniyMl2YxUkzMFNvSb9HAw7uxqqaqrZFdTLq1sCi8071ZhjheiLw5F
   2tSs4H9L6wD5LkM8A0FCXRCTtphYpO+zdrbI827Ikpd/zA+A0VT9kej5Q
   hO7ldg4bXSRcxdDl1jc0D786zsJDjBK4Jus/pxWuIa0d6BXcY5KQt6aVE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="336140252"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="336140252"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 04:31:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="745337518"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="745337518"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 20 Mar 2023 04:31:41 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peDjo-000B0g-2z;
        Mon, 20 Mar 2023 11:31:40 +0000
Date:   Mon, 20 Mar 2023 19:30:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: xtensa-linux-ld: section .start VMA
 [00000000d1000000,00000000d1000007] overlaps section .image VMA
 [00000000d0003000,00000000d13b1fb3]
Message-ID: <202303201950.3P4Vqo8v-lkp@intel.com>
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

Hi Max,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e8d018dd0257f744ca50a729e3d042cf2ec9da65
commit: 725aea873261e8d986e527838fde2a721f0962d8 xtensa: enable KCSAN
date:   11 months ago
config: xtensa-randconfig-r036-20230319 (https://download.01.org/0day-ci/archive/20230320/202303201950.3P4Vqo8v-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=725aea873261e8d986e527838fde2a721f0962d8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 725aea873261e8d986e527838fde2a721f0962d8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303201950.3P4Vqo8v-lkp@intel.com/

All errors (new ones prefixed by >>):

>> xtensa-linux-ld: section .start VMA [00000000d1000000,00000000d1000007] overlaps section .image VMA [00000000d0003000,00000000d13b1fb3]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
