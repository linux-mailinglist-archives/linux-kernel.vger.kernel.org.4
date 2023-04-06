Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B2E6D96D4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 14:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237174AbjDFMMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 08:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbjDFMMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 08:12:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5B01FCC;
        Thu,  6 Apr 2023 05:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680783135; x=1712319135;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZTXrXnEhkoM+Vmt5i1EvsJ5/ntJMCMiU5AlyIZi0mIE=;
  b=hyV28nYV1iJwVbpuWI4tyd0FyyY/jfPAwKkLnH8DqZYqlp1A84UmhcvS
   a1sM+955h9/siyGUzt/Wtbo3AvJVH/+jhvfnnPzvHUeas5rDcEATKc2UZ
   YvyHrEaLgwOtUEjGORJr3JgTViy1nl+dtIkYTteBSPIX/wB5AlDl2sG6W
   dbTerjmNjPgTod1tsG8po3IE6hJ7oAiTdl62P6GiH+3f1iuaMUSimmHbc
   Bk6eytvu/iXM6O67U5EqfmKfq2TqpxW5NeL7+FsmQJQnIyUrvGWIMV1x9
   2zd3CiTDb9/Mrv3qJ/Jw6jCq8WT0LJbRWMxPnQ4rCrU+6HDlYzc47cFsH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="342726424"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="342726424"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 05:11:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="689649473"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="689649473"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 06 Apr 2023 05:11:51 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkOSz-000RLu-2k;
        Thu, 06 Apr 2023 12:11:49 +0000
Date:   Thu, 6 Apr 2023 20:11:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tze-nan Wu <Tze-nan.Wu@mediatek.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Subject: kernel/trace/trace_events_synth.c:47:1: sparse: sparse: symbol
 'lastcmd_mutex' was not declared. Should it be static?
Message-ID: <202304062033.cRStgOuP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   99ddf2254febae9eab7fb0bcc02c5322243f5c49
commit: 4ccf11c4e8a8e051499d53a12f502196c97a758e tracing/synthetic: Fix races on freeing last_cmd
date:   3 days ago
config: i386-randconfig-s031-20230403 (https://download.01.org/0day-ci/archive/20230406/202304062033.cRStgOuP-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4ccf11c4e8a8e051499d53a12f502196c97a758e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4ccf11c4e8a8e051499d53a12f502196c97a758e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304062033.cRStgOuP-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/trace/trace_events_synth.c:47:1: sparse: sparse: symbol 'lastcmd_mutex' was not declared. Should it be static?
   kernel/trace/trace_events_synth.c:475:68: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *unsafe_addr @@     got char *str_val @@
   kernel/trace/trace_events_synth.c:475:68: sparse:     expected void const [noderef] __user *unsafe_addr
   kernel/trace/trace_events_synth.c:475:68: sparse:     got char *str_val

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
