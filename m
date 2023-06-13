Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C7972D9C7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 08:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239839AbjFMGVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 02:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240216AbjFMGUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 02:20:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF93E6B;
        Mon, 12 Jun 2023 23:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686637242; x=1718173242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UM3IHuTsa6izrIPK7yHaYSJMoWtyJyQyl1XOgL5IY6g=;
  b=jjPtLr6yee17BFO5ayDOktnSgknBEylQwBLzFr2ZeFK34LQGp93zgiYi
   R14OEIKUE8YbOE+akuO7L1tuGsJmuV6h2Wc9tENB30Lcff9gHYi4EfADX
   0WdWyH9iL1QS/KI+4x2gBtaLMdOzeuVP/SknpcbozUiD+FVZogbQ+HR+q
   Z2OZ9T45lCbEg5so9bbnpaRKGIn7ziGTFSVceJqGS4wqpQM3ZDK3c5iYK
   0cwjPiX9psIbVjMjpCkS56qwErFzJWPQu6orKWh83KbuoAZWiv9LrFf5u
   y63rjDG7S2YV1NTigWgYI61xw9F8Bu4LKOGa7J9O0q3cajjYL383RSFml
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="357125171"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="357125171"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 23:19:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="781516543"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="781516543"
Received: from lkp-server01.sh.intel.com (HELO 211f47bdb1cb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jun 2023 23:19:36 -0700
Received: from kbuild by 211f47bdb1cb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q8xNP-00013c-1j;
        Tue, 13 Jun 2023 06:19:35 +0000
Date:   Tue, 13 Jun 2023 14:19:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Andy Gross <agross@kernel.org>,
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
Message-ID: <202306131424.QEYiIiQA-lkp@intel.com>
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
config: hexagon-randconfig-r041-20230612 (https://download.01.org/0day-ci/archive/20230613/202306131424.QEYiIiQA-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 1ca04f21b204e99dd704146231adfb79ea2fb366
        b4 shazam https://lore.kernel.org/r/12b533c73b8c6b039e90f20afef1c8dcd30b80de.1686606835.git.quic_gokukris@quicinc.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306131424.QEYiIiQA-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __tracepoint_rproc_start_event
   >>> referenced by jump_label.h:260 (include/linux/jump_label.h:260)
   >>>               drivers/remoteproc/remoteproc_core.o:(rproc_boot) in archive vmlinux.a
   >>> referenced by jump_label.h:260 (include/linux/jump_label.h:260)
   >>>               drivers/remoteproc/remoteproc_core.o:(rproc_boot) in archive vmlinux.a
   >>> referenced by jump_label.h:260 (include/linux/jump_label.h:260)
   >>>               drivers/remoteproc/remoteproc_core.o:(rproc_boot) in archive vmlinux.a
   >>> referenced 1 more times
--
>> ld.lld: error: undefined symbol: __traceiter_rproc_start_event
   >>> referenced by remoteproc_tracepoints.h:63 (include/trace/events/remoteproc_tracepoints.h:63)
   >>>               drivers/remoteproc/remoteproc_core.o:(rproc_boot) in archive vmlinux.a
   >>> referenced by remoteproc_tracepoints.h:63 (include/trace/events/remoteproc_tracepoints.h:63)
   >>>               drivers/remoteproc/remoteproc_core.o:(rproc_boot) in archive vmlinux.a
   >>> referenced by remoteproc_tracepoints.h:63 (include/trace/events/remoteproc_tracepoints.h:63)
   >>>               drivers/remoteproc/remoteproc_core.o:(rproc_boot) in archive vmlinux.a
   >>> referenced 1 more times
--
>> ld.lld: error: undefined symbol: __tracepoint_rproc_load_segment_event
   >>> referenced by remoteproc_internal.h:178 (drivers/remoteproc/remoteproc_internal.h:178)
   >>>               drivers/remoteproc/remoteproc_core.o:(rproc_start) in archive vmlinux.a
   >>> referenced by remoteproc_internal.h:178 (drivers/remoteproc/remoteproc_internal.h:178)
   >>>               drivers/remoteproc/remoteproc_core.o:(rproc_start) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: __traceiter_rproc_load_segment_event
   >>> referenced by remoteproc_tracepoints.h:17 (include/trace/events/remoteproc_tracepoints.h:17)
   >>>               drivers/remoteproc/remoteproc_core.o:(rproc_start) in archive vmlinux.a
   >>> referenced by remoteproc_tracepoints.h:17 (include/trace/events/remoteproc_tracepoints.h:17)
   >>>               drivers/remoteproc/remoteproc_core.o:(rproc_start) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: __tracepoint_rproc_stop_event
   >>> referenced by jump_label.h:260 (include/linux/jump_label.h:260)
   >>>               drivers/remoteproc/remoteproc_core.o:(trace_rproc_stop_event) in archive vmlinux.a
   >>> referenced by jump_label.h:260 (include/linux/jump_label.h:260)
   >>>               drivers/remoteproc/remoteproc_core.o:(trace_rproc_stop_event) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: __traceiter_rproc_stop_event
   >>> referenced by remoteproc_tracepoints.h:82 (include/trace/events/remoteproc_tracepoints.h:82)
   >>>               drivers/remoteproc/remoteproc_core.o:(trace_rproc_stop_event) in archive vmlinux.a
   >>> referenced by remoteproc_tracepoints.h:82 (include/trace/events/remoteproc_tracepoints.h:82)
   >>>               drivers/remoteproc/remoteproc_core.o:(trace_rproc_stop_event) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
