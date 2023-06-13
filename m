Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4794572DB4B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240173AbjFMHn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240556AbjFMHnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:43:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C0D171A;
        Tue, 13 Jun 2023 00:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686642165; x=1718178165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3Ak4/m1xzWc3DziD0sz6Zov4RGEsJQMuHazVQwECIsQ=;
  b=WRkI+BI0s7PgSqBJAoLA+ypko5V+OURoFyjpquhD7nIGfV/bGP0CaJZq
   nHQYYGC/Sx0yjvHCWxioyC1RVHq8sg0PzSs/9ldbIL6cC1B3Z8KBW337c
   +S4tsI1AqfO33M2grzTq6/LF+JWbaE/u3eBzXUzXQwMBSe8e9R6oGwUzm
   dKNjlie+ikeyqdYYJQ0JfXoBBA5njzTxKxoLIiCvpkJmcTmRKJnHKHP11
   UiIv+CPFoeDVj1XzXlbSyiuycq18u2YHUbFdiIJaaPX68z/n1jJyPb2tB
   8GJRvSCj/rNfjkw7TOA4BFONrm04FDYq7Jg8+cP6vZaMai09qvK5AIJn9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="338614737"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="338614737"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 00:42:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="781552009"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="781552009"
Received: from lkp-server01.sh.intel.com (HELO 211f47bdb1cb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 13 Jun 2023 00:42:42 -0700
Received: from kbuild by 211f47bdb1cb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q8yfp-00016c-14;
        Tue, 13 Jun 2023 07:42:41 +0000
Date:   Tue, 13 Jun 2023 15:42:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Subject: Re: [PATCH v5 2/2] remoteproc: qcom: Add remoteproc tracing
Message-ID: <202306131523.EwZZ3cVl-lkp@intel.com>
References: <12b533c73b8c6b039e90f20afef1c8dcd30b80de.1686606835.git.quic_gokukris@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12b533c73b8c6b039e90f20afef1c8dcd30b80de.1686606835.git.quic_gokukris@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gokul,

kernel test robot noticed the following build errors:

[auto build test ERROR on 1ca04f21b204e99dd704146231adfb79ea2fb366]

url:    https://github.com/intel-lab-lkp/linux/commits/Gokul-krishna-Krishnakumar/remoteproc-Introduce-traces-for-remoteproc-events/20230613-060527
base:   1ca04f21b204e99dd704146231adfb79ea2fb366
patch link:    https://lore.kernel.org/r/12b533c73b8c6b039e90f20afef1c8dcd30b80de.1686606835.git.quic_gokukris%40quicinc.com
patch subject: [PATCH v5 2/2] remoteproc: qcom: Add remoteproc tracing
config: microblaze-randconfig-r003-20230612 (https://download.01.org/0day-ci/archive/20230613/202306131523.EwZZ3cVl-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 1ca04f21b204e99dd704146231adfb79ea2fb366
        b4 shazam https://lore.kernel.org/r/12b533c73b8c6b039e90f20afef1c8dcd30b80de.1686606835.git.quic_gokukris@quicinc.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=microblaze olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306131523.EwZZ3cVl-lkp@intel.com/

All errors (new ones prefixed by >>):

   microblaze-linux-ld: drivers/remoteproc/remoteproc_core.o: in function `rproc_stop':
>> .tmp_gl_remoteproc_core.o:(.text+0xe1c): undefined reference to `__tracepoint_rproc_stop_event'
>> microblaze-linux-ld: .tmp_gl_remoteproc_core.o:(.text+0xe94): undefined reference to `__traceiter_rproc_stop_event'
   microblaze-linux-ld: drivers/remoteproc/remoteproc_core.o: in function `rproc_start':
>> .tmp_gl_remoteproc_core.o:(.text.unlikely+0x664): undefined reference to `__tracepoint_rproc_load_segment_event'
>> microblaze-linux-ld: .tmp_gl_remoteproc_core.o:(.text.unlikely+0x6dc): undefined reference to `__traceiter_rproc_load_segment_event'
   microblaze-linux-ld: drivers/remoteproc/remoteproc_core.o: in function `trace_rproc_start_event':
>> .tmp_gl_remoteproc_core.o:(.text.unlikely+0x8c8): undefined reference to `__tracepoint_rproc_start_event'
>> microblaze-linux-ld: .tmp_gl_remoteproc_core.o:(.text.unlikely+0x948): undefined reference to `__traceiter_rproc_start_event'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
