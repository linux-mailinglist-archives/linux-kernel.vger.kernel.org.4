Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8C267AABA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 08:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbjAYHPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 02:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjAYHPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 02:15:53 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4298537B58;
        Tue, 24 Jan 2023 23:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674630952; x=1706166952;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=44OlyVK1Da2TLv8xj0eXULV9HtAjRmmQ/wsfiiqecZU=;
  b=m+5l80wy/FJlwLpF4X/rDmaDo8nKJ9x3xY6CODNUygwXJMyNvJrJpvt0
   JcmywcimcSqXaQl3Qt/X6zuS/bO4Agn0H18iCw56G8dvyIUsgduHf1SHY
   E51/rJzGu7xnI3jSdMLu8gXHTGFCm6Pwnz7lnF1iBuUUm1eoDCR5odTcD
   b/CpC6skHe2lwZL4oG9KD5g3paRI3+xz/SHzW0TI97hRGT6vbJ48Zpoqm
   hFNUyw9WZNSLX/xRnp7Qh/WI7wvlwW/7ihxHOtJU6DVmbUwV7ibQQmLOm
   g8BC0IJkc+4LnHH5HXHRnEe9L4Md8D1ankjE8VdFAnvxPybjlWdUFn4O6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="391002140"
X-IronPort-AV: E=Sophos;i="5.97,244,1669104000"; 
   d="scan'208";a="391002140"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 23:15:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="804909011"
X-IronPort-AV: E=Sophos;i="5.97,244,1669104000"; 
   d="scan'208";a="804909011"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jan 2023 23:15:48 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pKa0Z-00078W-2v;
        Wed, 25 Jan 2023 07:15:47 +0000
Date:   Wed, 25 Jan 2023 15:14:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-doc@vger.kernel.org,
        oleg@redhat.com, avagin@gmail.com, luto@kernel.org,
        krisman@collabora.com, tglx@linutronix.de, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH v6 2/2] ptrace,syscall_user_dispatch: add a getter/setter
 for sud configuration
Message-ID: <202301251548.C0OCmAX0-lkp@intel.com>
References: <20230125025126.787431-3-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125025126.787431-3-gregory.price@memverge.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gregory,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[cannot apply to tip/core/entry]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gregory-Price/ptrace-syscall_user_dispatch-add-a-getter-setter-for-sud-configuration/20230125-115155
patch link:    https://lore.kernel.org/r/20230125025126.787431-3-gregory.price%40memverge.com
patch subject: [PATCH v6 2/2] ptrace,syscall_user_dispatch: add a getter/setter for sud configuration
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230125/202301251548.C0OCmAX0-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/581ad4d3309b94aafb967b0ca56607436c18127f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Gregory-Price/ptrace-syscall_user_dispatch-add-a-getter-setter-for-sud-configuration/20230125-115155
        git checkout 581ad4d3309b94aafb967b0ca56607436c18127f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/entry/syscall_user_dispatch.c: In function 'syscall_user_dispatch_set_config':
>> kernel/entry/syscall_user_dispatch.c:143:13: warning: unused variable 'ret' [-Wunused-variable]
     143 |         int ret;
         |             ^~~


vim +/ret +143 kernel/entry/syscall_user_dispatch.c

   138	
   139	int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
   140			void __user *data)
   141	{
   142		struct syscall_user_dispatch_config config;
 > 143		int ret;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
