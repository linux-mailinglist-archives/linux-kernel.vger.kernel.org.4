Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266A95B8D34
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiINQhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiINQhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:37:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710D75AA38
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 09:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663173432; x=1694709432;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l7sMrbj/Jo9zP60pNDWgBmP8LvBsIxR4ppehGzT0yaI=;
  b=fLWOSnkp9mLn7hWXaNEHwdNE+D0GrGeB4rVRnZM+ny6/C/tg3CW0SyWz
   oLYVh4PQmnUY2ykl2yF4lnqLYvzSqhRWMHDi9qopH6KjTEXmegze7IJgS
   9vKK3J4oeU77RMrLtJeNScV3dvIM3ssCmOX9bq262nRovRXAaaKCcixtC
   FcXKvkXlsQOgBt3r/nqO2AhgxsAh+cUWZtZuXzSi6s8jFGRZ9M1P+qjT6
   t2B2HJgpqsHA4kuwikwiiQbYu+wna5kQ1zZatZ3oxZKxhE7WZCHST2aDB
   2SOUZV4xpco3d2zBNrB8iRFXws9rzTizR0Cp+SNYnZE2BexwWVQ4WIUmb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="324733696"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="324733696"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 09:37:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="945575789"
Received: from lkp-server01.sh.intel.com (HELO d6e6b7c4e5a2) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 14 Sep 2022 09:37:01 -0700
Received: from kbuild by d6e6b7c4e5a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYVNk-0000No-24;
        Wed, 14 Sep 2022 16:37:00 +0000
Date:   Thu, 15 Sep 2022 00:36:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mcgrof:20220913-test-sysfs 8/11] lib/test_sysfs.c:26:10: fatal
 error: linux/genhd.h: No such file or directory
Message-ID: <202209150012.nsTINDjx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git 20220913-test-sysfs
head:   fd13723170f4a2381aab0b6449920c121f01a10a
commit: 1fd6d0dd327560b281f4b77ff3a400be3ec9efde [8/11] selftests: add tests_sysfs module
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220915/202209150012.nsTINDjx-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?id=1fd6d0dd327560b281f4b77ff3a400be3ec9efde
        git remote add mcgrof https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
        git fetch --no-tags mcgrof 20220913-test-sysfs
        git checkout 1fd6d0dd327560b281f4b77ff3a400be3ec9efde
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> lib/test_sysfs.c:26:10: fatal error: linux/genhd.h: No such file or directory
      26 | #include <linux/genhd.h>
         |          ^~~~~~~~~~~~~~~
   compilation terminated.


vim +26 lib/test_sysfs.c

    12	
    13	#include <linux/init.h>
    14	#include <linux/list.h>
    15	#include <linux/module.h>
    16	#include <linux/printk.h>
    17	#include <linux/fs.h>
    18	#include <linux/miscdevice.h>
    19	#include <linux/slab.h>
    20	#include <linux/uaccess.h>
    21	#include <linux/async.h>
    22	#include <linux/delay.h>
    23	#include <linux/vmalloc.h>
    24	#include <linux/debugfs.h>
    25	#include <linux/rtnetlink.h>
  > 26	#include <linux/genhd.h>
    27	#include <linux/blkdev.h>
    28	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
