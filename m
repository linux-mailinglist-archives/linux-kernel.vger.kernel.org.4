Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060C45BD8A1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 02:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiITADs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 20:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiITADo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 20:03:44 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35FC501B9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 17:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663632221; x=1695168221;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8kGngS5hGQwtktWogbY6TTSMVixVDUF6lzm9ZW6UHw0=;
  b=m9mRmtP6/LyahpTsmFR2/4KTtNqV7I6jEHjyGr61FIrwl2FSKqWrL6T4
   Lw+mOpGhMaIcO46uabXitUi/QHSiOLe/Oolf+61E2+cj3I+UnJ17kZvqT
   wNfs38Hf1gR1PSJr0CG3MgbUGrTthYHWDLRDtoTZ+5GRXGgecadK7Dvvy
   jrtJBrQGr5y0nnnuncsZIu7BGL6MfcCQFQHhO3si7Uu9IaRr1W8ISte9R
   f9sHOhAB+XVj80IAtTn+HNrF00gcRSRDuLZXu7vLFoASFSHmLLlUcV8u+
   jy9jwbBvhMuLRzbxgTZc83aWSurioIxcQDPUqznDhAsPnHJK7f5Yg7TUV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="361291618"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="361291618"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 17:03:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="618694515"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 19 Sep 2022 17:03:38 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaQjh-0002K5-2r;
        Tue, 20 Sep 2022 00:03:37 +0000
Date:   Tue, 20 Sep 2022 08:02:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yuanchu Xie <yuanchu@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        SeongJae Park <sj@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.15.y 6634/9999]
 huge_count_read_write.c:23:9: warning: 'write' reading 4294967295 bytes from
 a region of size 1
Message-ID: <202209200744.TnQ9kRau-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
head:   d766f744e4827dc41ef6c01403a96b7bb3938132
commit: 9ea7148f61cd225959bbacc0b075db72169c8b59 [6634/9999] selftests/damon: add damon to selftests root Makefile
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=9ea7148f61cd225959bbacc0b075db72169c8b59
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.15.y
        git checkout 9ea7148f61cd225959bbacc0b075db72169c8b59
        make O=/tmp/kselftest headers
        make O=/tmp/kselftest -C tools/testing/selftests

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   huge_count_read_write.c: In function 'write_read_with_huge_count':
>> huge_count_read_write.c:23:9: warning: 'write' reading 4294967295 bytes from a region of size 1 [-Wstringop-overread]
      23 |         write(filedesc, "", 0xfffffffful);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from huge_count_read_write.c:8:
   /usr/include/unistd.h:367:16: note: in a call to function 'write' declared with attribute 'access (read_only, 2, 3)'
     367 | extern ssize_t write (int __fd, const void *__buf, size_t __n) __wur
         |                ^~~~~
>> huge_count_read_write.c:25:15: warning: 'read' writing 4294967295 bytes into a region of size 25 overflows the destination [-Wstringop-overflow=]
      25 |         ret = read(filedesc, buf, 0xfffffffful);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   huge_count_read_write.c:14:14: note: destination object 'buf' of size 25
      14 |         char buf[25];
         |              ^~~
   In file included from huge_count_read_write.c:8:
   /usr/include/unistd.h:360:16: note: in a call to function 'read' declared with attribute 'access (write_only, 2, 3)'
     360 | extern ssize_t read (int __fd, void *__buf, size_t __nbytes) __wur
         |                ^~~~

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
