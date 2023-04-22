Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1798F6EBA82
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 19:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjDVQ74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 12:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjDVQ7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 12:59:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DD12696;
        Sat, 22 Apr 2023 09:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682182793; x=1713718793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZS4KU5+dce0YnhegEVKh13hC9j+klWPpmY7iHHIWemE=;
  b=ntVn7qJliD/FiCWjMc/oxa7fx+8DCUVe4c6I4Hp7NJ3zbUAcyc8yTmz4
   Vt2/YJ02E8X1tySzKO1i6FG/Ix4beo1J30XhUcEbfasPrZVlvtOFZKkCa
   JZEkjpfX+eTBsmuZyPYkjk6L1e6fDxeRXOh6idQGhqhFvgdoYuqIx3l/b
   vVYymruaNzY4cIif4W26VEdirpXzJsp/9TLgs5BZE+hWyKfyYR//MhI0H
   c0y+w52N79/Dv5WHV/lqZvztXUYJYEbz7DXwsNZSanE+j4L9SfK3L6vRd
   /v5dAa8/FqzAIKWRcMRWXsxeSVlYUG4U2lfmSDFFDHHpxV9+2qkRR+C1S
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="326504316"
X-IronPort-AV: E=Sophos;i="5.99,218,1677571200"; 
   d="scan'208";a="326504316"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 09:59:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="670024662"
X-IronPort-AV: E=Sophos;i="5.99,218,1677571200"; 
   d="scan'208";a="670024662"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Apr 2023 09:59:49 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pqGaT-000hPU-0W;
        Sat, 22 Apr 2023 16:59:49 +0000
Date:   Sun, 23 Apr 2023 00:59:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Subject: Re: [PATCH v9 04/11] LSM: syscalls for current process attributes
Message-ID: <202304230040.qjeOFf1q-lkp@intel.com>
References: <20230421174259.2458-5-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421174259.2458-5-casey@schaufler-ca.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Casey,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/perf/core]
[also build test WARNING on acme/perf/core shuah-kselftest/next shuah-kselftest/fixes linus/master v6.3-rc7]
[cannot apply to next-20230421]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Casey-Schaufler/LSM-Maintain-a-table-of-LSM-attribute-data/20230422-024331
base:   tip/perf/core
patch link:    https://lore.kernel.org/r/20230421174259.2458-5-casey%40schaufler-ca.com
patch subject: [PATCH v9 04/11] LSM: syscalls for current process attributes
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/78ea54cc31d7bd9e5a5c7fe8cf34fba9516fde95
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Casey-Schaufler/LSM-Maintain-a-table-of-LSM-attribute-data/20230422-024331
        git checkout 78ea54cc31d7bd9e5a5c7fe8cf34fba9516fde95
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304230040.qjeOFf1q-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/userspace-api/lsm.rst:61: WARNING: Title underline too short.

vim +61 Documentation/userspace-api/lsm.rst

    56	
    57	.. kernel-doc:: security/lsm_syscalls.c
    58	    :identifiers: sys_lsm_set_self_attr
    59	
    60	Get the specified security attributes of the current process
  > 61	--------------------------------------------------
    62	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
