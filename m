Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC45D719FCD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbjFAOYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjFAOYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:24:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D69C186;
        Thu,  1 Jun 2023 07:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685629476; x=1717165476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F+v0KYqgmXbJzCwwpH3tD86bRW38udBiayCtr+jvjqU=;
  b=X26w7TlQBCR06/ROInIyqQR84NEpnU4eIjheD0nSLhVTBD2zRuSFE24l
   Fu2fBEHot3b+J7WVJkUdGf+LedDOmtUbYMUDb4HOGr8PrD3c5eKEeL7yh
   j7dofaaMM0Oe4J+naIzwKgs4DbTIYanYXzx7IbeRht7WHUhwDOhjXVQOW
   qGPdBDFzc1qiioErv3Bm4wqiVeujUScmVbGBUCNi90YkpInHK/MWTF38Y
   lzAp5jyxdp0Du065JEz/n+VnJVJlhkB57mCJCqFGyuBpm376ZM5sMBnIv
   mEUHRyJJ4Sqbq9wbwrQwdrsEumvnOZaYC54KGK1D6/cqrzKhF+rBvP3f2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="419088759"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="419088759"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 07:19:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="657813872"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="657813872"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 Jun 2023 07:19:17 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4j92-0002Lv-2b;
        Thu, 01 Jun 2023 14:19:16 +0000
Date:   Thu, 1 Jun 2023 22:18:20 +0800
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
Message-ID: <202306011703.PMV10K8E-lkp@intel.com>
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
config: arm64-randconfig-r036-20230531 (https://download.01.org/0day-ci/archive/20230601/202306011703.PMV10K8E-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306011703.PMV10K8E-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__tracepoint_rproc_subdev_event" [drivers/remoteproc/qcom_common.ko] undefined!
>> ERROR: modpost: "__traceiter_rproc_subdev_event" [drivers/remoteproc/qcom_common.ko] undefined!
>> ERROR: modpost: "__tracepoint_rproc_interrupt_event" [drivers/remoteproc/qcom_q6v5.ko] undefined!
>> ERROR: modpost: "__traceiter_rproc_interrupt_event" [drivers/remoteproc/qcom_q6v5.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
