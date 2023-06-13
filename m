Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF37C72D9AF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 08:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240238AbjFMGKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 02:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240270AbjFMGJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 02:09:53 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67640173F;
        Mon, 12 Jun 2023 23:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686636576; x=1718172576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5nLm4qe8kPcKMUnAEPMOaMOOzsBImUOGoaEZFvK0/jw=;
  b=mKYFwDXE24KKHAqpfBn87X1miBnbliXMMAaZ9+adtad37mNetlo2lHPP
   FNFekHFT4BVrByQrV+nKqYIlJ0RgPMKW6WUvFJamaOkm5Auv0matAk1Ng
   trJR2yO9lGta6PtVx8HMQ5oogJxm+uDbhZhhj85KOvR0O7ESPWlBYqT81
   NGamsVj3zmQZUcAroWZ/jxqrEHj4/l/a7wgLctdFH6O+Gg8DeLalNZ37m
   fzmKP0UFE1NoXisloqmDz4dDQBxRiutv2yH5dS3Z5AoabNIlkFON2AMtf
   gaVzTKXNvTpfKUbLBtCB+HuRpbgh4+Ap9E7ujLN7QBxq+zegB0uBytvmK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="342929507"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="342929507"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 23:09:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="776683422"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="776683422"
Received: from lkp-server01.sh.intel.com (HELO 211f47bdb1cb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jun 2023 23:09:31 -0700
Received: from kbuild by 211f47bdb1cb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q8xDf-00013D-0k;
        Tue, 13 Jun 2023 06:09:31 +0000
Date:   Tue, 13 Jun 2023 14:08:50 +0800
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
Message-ID: <202306131305.GXI4gstL-lkp@intel.com>
References: <12b533c73b8c6b039e90f20afef1c8dcd30b80de.1686606835.git.quic_gokukris@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12b533c73b8c6b039e90f20afef1c8dcd30b80de.1686606835.git.quic_gokukris@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
config: i386-randconfig-r025-20230612 (https://download.01.org/0day-ci/archive/20230613/202306131305.GXI4gstL-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build):
        git checkout 1ca04f21b204e99dd704146231adfb79ea2fb366
        b4 shazam https://lore.kernel.org/r/12b533c73b8c6b039e90f20afef1c8dcd30b80de.1686606835.git.quic_gokukris@quicinc.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306131305.GXI4gstL-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/remoteproc/remoteproc_core.o: in function `trace_rproc_stop_event':
>> include/trace/events/remoteproc_tracepoints.h:82: undefined reference to `__tracepoint_rproc_stop_event'
>> ld: include/trace/events/remoteproc_tracepoints.h:82: undefined reference to `__SCT__tp_func_rproc_stop_event'
   ld: drivers/remoteproc/remoteproc_core.o: in function `trace_rproc_load_segment_event':
>> include/trace/events/remoteproc_tracepoints.h:17: undefined reference to `__tracepoint_rproc_load_segment_event'
>> ld: include/trace/events/remoteproc_tracepoints.h:17: undefined reference to `__SCT__tp_func_rproc_load_segment_event'
   ld: drivers/remoteproc/remoteproc_core.o: in function `trace_rproc_start_event':
>> include/trace/events/remoteproc_tracepoints.h:63: undefined reference to `__tracepoint_rproc_start_event'
>> ld: include/trace/events/remoteproc_tracepoints.h:63: undefined reference to `__SCT__tp_func_rproc_start_event'
   ld: drivers/remoteproc/remoteproc_core.o:(__jump_table+0x8): undefined reference to `__tracepoint_rproc_stop_event'
>> ld: drivers/remoteproc/remoteproc_core.o:(__jump_table+0x14): undefined reference to `__tracepoint_rproc_load_segment_event'
   ld: drivers/remoteproc/remoteproc_core.o:(__jump_table+0x20): undefined reference to `__tracepoint_rproc_start_event'


vim +82 include/trace/events/remoteproc_tracepoints.h

f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   13  
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   14  /*
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   15   * Tracepoints for remoteproc and subdevice events
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   16   */
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12  @17  TRACE_EVENT(rproc_load_segment_event,
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   18  
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   19  	TP_PROTO(struct rproc *rproc, int ret),
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   20  
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   21  	TP_ARGS(rproc, ret),
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   22  
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   23  	TP_STRUCT__entry(
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   24  		__string(name, rproc->name)
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   25  		__string(firmware, rproc->firmware)
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   26  		__field(int, ret)
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   27  	),
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   28  
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   29  	TP_fast_assign(
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   30  		__assign_str(name, rproc->name);
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   31  		__assign_str(firmware, rproc->firmware);
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   32  		__entry->ret = ret;
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   33  	),
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   34  
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   35  	TP_printk("%s loading firmware %s returned %d",
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   36  			__get_str(name), __get_str(firmware),
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   37  			__entry->ret)
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   38  );
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   39  
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   40  TRACE_EVENT(rproc_attach_event,
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   41  
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   42  	TP_PROTO(struct rproc *rproc, int ret),
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   43  
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   44  	TP_ARGS(rproc, ret),
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   45  
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   46  	TP_STRUCT__entry(
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   47  		__string(name, rproc->name)
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   48  		__string(firmware, rproc->firmware)
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   49  		__field(int, ret)
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   50  	),
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   51  
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   52  	TP_fast_assign(
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   53  		__assign_str(name, rproc->name);
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   54  		__assign_str(firmware, rproc->firmware);
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   55  		__entry->ret = ret;
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   56  	),
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   57  
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   58  	TP_printk("%s attaching returned %d",
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   59  			__get_str(name),
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   60  			__entry->ret)
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   61  );
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   62  
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12  @63  TRACE_EVENT(rproc_start_event,
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   64  
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   65  	TP_PROTO(struct rproc *rproc, int ret),
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   66  
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   67  	TP_ARGS(rproc, ret),
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   68  
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   69  	TP_STRUCT__entry(
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   70  		__string(name, rproc->name)
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   71  		__field(int, ret)
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   72  	),
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   73  
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   74  	TP_fast_assign(
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   75  		__assign_str(name, rproc->name);
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   76  		__entry->ret = ret;
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   77  	),
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   78  
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   79  	TP_printk("%s %d", __get_str(name), __entry->ret)
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   80  );
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   81  
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12  @82  TRACE_EVENT(rproc_stop_event,
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   83  
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   84  	TP_PROTO(struct rproc *rproc, const char *crash_msg),
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   85  
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   86  	TP_ARGS(rproc, crash_msg),
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   87  
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   88  	TP_STRUCT__entry(
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   89  		__string(name, rproc->name)
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   90  		__string(crash_msg, crash_msg)
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   91  	),
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   92  
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   93  	TP_fast_assign(
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   94  		__assign_str(name, rproc->name);
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   95  		__assign_str(crash_msg, crash_msg)
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   96  	),
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   97  
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   98  	TP_printk("%s %s", __get_str(name), __get_str(crash_msg))
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12   99  );
f73173f7e78a04 Gokul krishna Krishnakumar 2023-06-12  100  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
