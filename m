Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10C3719FA0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbjFAOTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjFAOTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:19:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF829C0;
        Thu,  1 Jun 2023 07:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685629182; x=1717165182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I4kycmK6ZsZGDqn1h2vHJE5lPWq2KktJ9e9ABzGmIj4=;
  b=L7zxAffl6QY0zXjPop1xzlVGZfu8kjrD1ci6XKDRoKmf0S5pXJ4oQXkm
   fNfe8rCIGQfWm0c7Y9TDIVOG2MKah2hZtKk+F3tqNLOZQbrC9z2oSoZFK
   9+tKZWZz7VmyLWV4j6KrENOX8ZFtt1Z2xNtIdUjS+GBveFWPZ/ASvxsBA
   xnNp+dut2ysBCPCQh6EcAYgrHDT9HqcbAdim1XG7XgSpR8aG64epgf16V
   I4cyC5pmMPfPE4CTqjtsMgo4Wu3jW3JQ4CkzC5UCV3HMWG4IEAI1nxiXT
   d4LfJJdJv9cwdZ1xAUgW3x6yO7qAI/I8Xr1F9qZIrKdP/jjsfcilalUT+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="441931591"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="441931591"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 07:19:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="819811076"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="819811076"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jun 2023 07:19:17 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4j92-0002Ly-2y;
        Thu, 01 Jun 2023 14:19:16 +0000
Date:   Thu, 1 Jun 2023 22:18:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>,
        linux-remoteproc@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Subject: Re: [PATCH v4 2/2] remoteproc: qcom: Add remoteproc tracing
Message-ID: <202306011819.IWZmMEEa-lkp@intel.com>
References: <bd949ac8225abb842630bd7f4a2d45334c58f17f.1685486994.git.quic_gokukris@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd949ac8225abb842630bd7f4a2d45334c58f17f.1685486994.git.quic_gokukris@quicinc.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gokul,

kernel test robot noticed the following build errors:

[auto build test ERROR on remoteproc/rproc-next]
[also build test ERROR on linus/master v6.4-rc4 next-20230601]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gokul-krishna-Krishnakumar/remoteproc-Introduce-traces-for-remoteproc-events/20230601-053050
base:   git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git rproc-next
patch link:    https://lore.kernel.org/r/bd949ac8225abb842630bd7f4a2d45334c58f17f.1685486994.git.quic_gokukris%40quicinc.com
patch subject: [PATCH v4 2/2] remoteproc: qcom: Add remoteproc tracing
config: csky-randconfig-r025-20230531 (https://download.01.org/0day-ci/archive/20230601/202306011819.IWZmMEEa-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8a5252420291719cda102eb8ca72295283540cd4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Gokul-krishna-Krishnakumar/remoteproc-Introduce-traces-for-remoteproc-events/20230601-053050
        git checkout 8a5252420291719cda102eb8ca72295283540cd4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=csky olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306011819.IWZmMEEa-lkp@intel.com/

All errors (new ones prefixed by >>):

   csky-linux-ld: drivers/remoteproc/remoteproc_core.o: in function `rproc_stop':
>> remoteproc_core.c:(.text+0x4c6): undefined reference to `__traceiter_rproc_stop_event'
>> csky-linux-ld: remoteproc_core.c:(.text+0x510): undefined reference to `__tracepoint_rproc_stop_event'
>> csky-linux-ld: remoteproc_core.c:(.text+0x518): undefined reference to `__traceiter_rproc_stop_event'
   csky-linux-ld: drivers/remoteproc/remoteproc_core.o: in function `rproc_start':
>> remoteproc_core.c:(.text.unlikely+0x230): undefined reference to `__traceiter_rproc_load_event'
   csky-linux-ld: drivers/remoteproc/remoteproc_core.o: in function `trace_rproc_start_event':
>> remoteproc_core.c:(.text.unlikely+0x30a): undefined reference to `__traceiter_rproc_start_event'
>> csky-linux-ld: remoteproc_core.c:(.text.unlikely+0x31c): undefined reference to `__tracepoint_rproc_load_event'
>> csky-linux-ld: remoteproc_core.c:(.text.unlikely+0x324): undefined reference to `__traceiter_rproc_load_event'
>> csky-linux-ld: remoteproc_core.c:(.text.unlikely+0x354): undefined reference to `__tracepoint_rproc_start_event'
>> csky-linux-ld: remoteproc_core.c:(.text.unlikely+0x358): undefined reference to `__traceiter_rproc_start_event'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
