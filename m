Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8209A609B4C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiJXH2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJXH2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:28:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A26F6051A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 00:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666596503; x=1698132503;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=rDOS/rkKewoNxrYtwcE/cHjuflc+4/9R89+1cn006I8=;
  b=UhuLrCPkqCS1acj9f3x6xxW9yYli78ODZTM91zMbA53lMZd2VTc5ysM9
   K8OUhH/vZJzY9VJXBAfqVSiT1nBgKWgqYxx7aAjuJKZoBwMZXrCWH/fHV
   munFzPb/5WDmrW0aA0mE72HBlBzCuVabJSvpXhl0devjxAnlqreZZWBKL
   VCFFZdP/DNcG4Doeax1Lfp+DEg1KlKHZ0f6Hv94W77l9cJi95kdry9j9M
   Dxddbd3N8D607AeQZ1KOqOzziPeZzleg281lpPHT0c7ggOZDiEASiIDm+
   QxtJxCMRgdCuE86YX3h6IklPcjDv5Nx7aKOaYT1Nj9hhpOL39pVBT2QlM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="309043435"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="309043435"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 00:28:19 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="662349640"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="662349640"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.254.212.138]) ([10.254.212.138])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 00:26:02 -0700
Subject: Re: [kbuild-all] Re: include/trace/trace_events.h:261:16: error:
 function 'trace_event_get_offsets_iwlwifi_dbg' might be a candidate for
 'gnu_printf' format attribute
To:     Steven Rostedt <rostedt@goodmis.org>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202210212134.QTpb11ug-lkp@intel.com>
 <20221021101026.1708a426@gandalf.local.home>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <ed665ca3-fa87-fee6-7284-9aed257264e4@intel.com>
Date:   Mon, 24 Oct 2022 15:26:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20221021101026.1708a426@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/21/2022 10:10 PM, Steven Rostedt wrote:
> On Fri, 21 Oct 2022 22:07:17 +0800
> kernel test robot <lkp@intel.com> wrote:
> 
>> Hi Steven,
>>
>> FYI, the error/warning still remains.
> 
>    WONT FIX
> 
> I thought we already discussed getting rid of this warning?

Hi Steve,

Sorry for the noise, the bot doesn't ignore this warning with prefix 
'error:', we will fix it.

Best Regards,
Rong Chen

> 
> -- Steve
> 
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   e35184f321518acadb681928a016da21a9a20c13
>> commit: c7c37bb87590886e08d24dec53089f74b89f5fbb tracing/iwlwifi: Use the new __vstring() helper
>> date:   3 months ago
>> config: x86_64-sof-customedconfig-edison-defconfig
>> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
>> reproduce (this is a W=1 build):
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c7c37bb87590886e08d24dec53089f74b89f5fbb
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout c7c37bb87590886e08d24dec53089f74b89f5fbb
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/wireless/intel/iwlwifi/
>>
>> If you fix the issue, kindly add following tag where applicable
>> | Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     In file included from include/trace/define_trace.h:102,
>>                      from drivers/net/wireless/intel/iwlwifi/iwl-devtrace-msg.h:71,
>>                      from drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h:91,
>>                      from drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c:15:
>>     drivers/net/wireless/intel/iwlwifi/./iwl-devtrace-msg.h: In function 'trace_event_get_offsets_iwlwifi_dbg':
>>>> include/trace/trace_events.h:261:16: error: function 'trace_event_get_offsets_iwlwifi_dbg' might be a candidate for 'gnu_printf' format attribute [-Werror=suggest-attribute=format]
>>       261 |         struct trace_event_raw_##call __maybe_unused *entry;            \
>>           |                ^~~~~~~~~~~~~~~~
>>     include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
>>        40 |         DECLARE_EVENT_CLASS(name,                              \
>>           |         ^~~~~~~~~~~~~~~~~~~
>>     drivers/net/wireless/intel/iwlwifi/./iwl-devtrace-msg.h:49:1: note: in expansion of macro 'TRACE_EVENT'
>>        49 | TRACE_EVENT(iwlwifi_dbg,
>>           | ^~~~~~~~~~~
>>     In file included from include/trace/define_trace.h:102,
>>                      from drivers/net/wireless/intel/iwlwifi/iwl-devtrace-msg.h:71,
>>                      from drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h:91,
>>                      from drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c:15:
>>     drivers/net/wireless/intel/iwlwifi/./iwl-devtrace-msg.h: In function 'trace_event_raw_event_iwlwifi_dbg':
>>     include/trace/trace_events.h:386:16: error: function 'trace_event_raw_event_iwlwifi_dbg' might be a candidate for 'gnu_printf' format attribute [-Werror=suggest-attribute=format]
>>       386 |         struct trace_event_raw_##call *entry;                           \
>>           |                ^~~~~~~~~~~~~~~~
>>     include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
>>        40 |         DECLARE_EVENT_CLASS(name,                              \
>>           |         ^~~~~~~~~~~~~~~~~~~
>>     drivers/net/wireless/intel/iwlwifi/./iwl-devtrace-msg.h:49:1: note: in expansion of macro 'TRACE_EVENT'
>>        49 | TRACE_EVENT(iwlwifi_dbg,
>>           | ^~~~~~~~~~~
>>     In file included from include/trace/define_trace.h:103,
>>                      from drivers/net/wireless/intel/iwlwifi/iwl-devtrace-msg.h:71,
>>                      from drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h:91,
>>                      from drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c:15:
>>     drivers/net/wireless/intel/iwlwifi/./iwl-devtrace-msg.h: In function 'perf_trace_iwlwifi_dbg':
>>     include/trace/perf.h:64:16: error: function 'perf_trace_iwlwifi_dbg' might be a candidate for 'gnu_printf' format attribute [-Werror=suggest-attribute=format]
>>        64 |         struct hlist_head *head;                                        \
>>           |                ^~~~~~~~~~
>>     include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
>>        40 |         DECLARE_EVENT_CLASS(name,                              \
>>           |         ^~~~~~~~~~~~~~~~~~~
>>     drivers/net/wireless/intel/iwlwifi/./iwl-devtrace-msg.h:49:1: note: in expansion of macro 'TRACE_EVENT'
>>        49 | TRACE_EVENT(iwlwifi_dbg,
>>           | ^~~~~~~~~~~
>>     cc1: all warnings being treated as errors
>>
>>
>> vim +261 include/trace/trace_events.h
>>
>> 55de2c0b5610cb include/trace/trace_events.h Masami Hiramatsu         2021-11-22  253
>> 091ad3658e3c76 include/trace/ftrace.h       Ingo Molnar              2009-11-26  254  #undef DECLARE_EVENT_CLASS
>> 091ad3658e3c76 include/trace/ftrace.h       Ingo Molnar              2009-11-26  255  #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
>> d0ee8f4a1f5f3d include/trace/trace_events.h Steven Rostedt (Red Hat  2015-05-13  256) static inline notrace int trace_event_get_offsets_##call(		\
>> 62323a148fbeb0 include/trace/trace_events.h Steven Rostedt (Red Hat  2015-05-13  257) 	struct trace_event_data_offsets_##call *__data_offsets, proto)	\
>> 7fcb7c472f455d include/trace/ftrace.h       Li Zefan                 2009-06-01  258  {									\
>> 7fcb7c472f455d include/trace/ftrace.h       Li Zefan                 2009-06-01  259  	int __data_size = 0;						\
>> 114e7b52dee69c include/trace/ftrace.h       Filipe Brandenburger     2014-02-28  260  	int __maybe_unused __item_length;				\
>> a7237765730a10 include/trace/trace_events.h Steven Rostedt (Red Hat  2015-05-13 @261) 	struct trace_event_raw_##call __maybe_unused *entry;		\
>> 7fcb7c472f455d include/trace/ftrace.h       Li Zefan                 2009-06-01  262  									\
>> 7fcb7c472f455d include/trace/ftrace.h       Li Zefan                 2009-06-01  263  	tstruct;							\
>> 7fcb7c472f455d include/trace/ftrace.h       Li Zefan                 2009-06-01  264  									\
>> 7fcb7c472f455d include/trace/ftrace.h       Li Zefan                 2009-06-01  265  	return __data_size;						\
>> 7fcb7c472f455d include/trace/ftrace.h       Li Zefan                 2009-06-01  266  }
>> 7fcb7c472f455d include/trace/ftrace.h       Li Zefan                 2009-06-01  267
>>
>> :::::: The code at line 261 was first introduced by commit
>> :::::: a7237765730a10d429736f47ac4b89779ec6c534 tracing: Rename ftrace_raw_##call event structures to trace_event_raw_##call
>>
>> :::::: TO: Steven Rostedt (Red Hat) <rostedt@goodmis.org>
>> :::::: CC: Steven Rostedt <rostedt@goodmis.org>
>>
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
