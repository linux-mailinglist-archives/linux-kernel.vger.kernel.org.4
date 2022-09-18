Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15935BBCA4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 11:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiIRJGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 05:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiIRJG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 05:06:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED3B252B5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 02:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663491986; x=1695027986;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1g0vNmXfQvbCouEbtBb3JNKuOOsjQM2iCdGrKusjKLg=;
  b=ZxxN7cQKkWTXrKDWjyqGhEq8Sh6HtbLvBbB6nUmcryItCFag3mwtSjNU
   MUMCE/O2ih8XPsqZpdb01cj76Drjssp6tFmd66E4EkqVohCCnIV187OKk
   3I9xVYbKJ0tlll3cChlgO45Fa/H1H2a7u7OhYZxnt2RM7kf4UkDHaWYDJ
   RrgPmModigzfmOQ5dEhLxgzdns3F7+UOG4NxKtBR1BGyg1rDo3a5h0eNI
   sZUqbY6gemRqjcCUMzO/6HjPw44OBt3vpxL53ljulfW+5s2ZuZSLAkY10
   fIahTCS2Ti/DCeKsG9189TfbznZN5/aALXK+Kk4JfpvXKWCzRIXXh9UaB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10473"; a="300038254"
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="300038254"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 02:06:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="569305613"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Sep 2022 02:06:24 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZqFr-00014D-33;
        Sun, 18 Sep 2022 09:06:23 +0000
Date:   Sun, 18 Sep 2022 17:05:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.10.y 7935/8454] signal.c:undefined
 reference to `uml_pm_wake'
Message-ID: <202209181654.K1mF9OAZ-lkp@intel.com>
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

Hi Johannes,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
head:   02c4837d98bf509b70afb8368175c489a5ba7b4a
commit: b58294ce1a8ac8e234abd991255b1d1905520aed [7935/8454] um: Allow PM with suspend-to-idle
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20220918/202209181654.K1mF9OAZ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=b58294ce1a8ac8e234abd991255b1d1905520aed
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.10.y
        git checkout b58294ce1a8ac8e234abd991255b1d1905520aed
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   /usr/bin/ld: warning: arch/x86/um/checksum_32.o: missing .note.GNU-stack section implies executable stack
   /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
   /usr/bin/ld: warning: vmlinux has a LOAD segment with RWX permissions
   /usr/bin/ld: arch/um/os-Linux/signal.o: in function `sigusr1_handler':
>> signal.c:(.text+0x211): undefined reference to `uml_pm_wake'
   collect2: error: ld returned 1 exit status

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
