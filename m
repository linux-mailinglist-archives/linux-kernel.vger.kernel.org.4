Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAF460C0EC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiJYBW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiJYBWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:22:09 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966C751A17;
        Mon, 24 Oct 2022 17:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666658987; x=1698194987;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=zHGjl5+fq8Hm5PhqDVUfsGIFrV7NvXdcbmgRNAqSgqM=;
  b=AjduT+M/IjzyyTKwQlJcPfsEK3sWOMlZpcqhnyeI+oluB9E/Lepwr4hv
   DHL4BlplMXcOV/5hHiWePpu80N1kfWct3FtqolmnIKgqf2OMaij3baqxL
   T/mZRvWMAhCm/d/2b4gnl1xeOSBdeDmuCpi8TezSkOCXMCZvzlQ7i7Jtm
   RdWYT44syzaXF24gGxVWbW635esNcOsre5ziy/IWR0GdPlULSd2ztJb/T
   0FhV5TcE0lreiJgXqgNSc/cgmTZpULb1uVs+ClWHTKeopmMGhYg4OwIEF
   NI0d+dIiqC8uU78jQ6rAkcf2Yfs0pONMLiclLnjWuw7r8ygFKmrrosEjS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="287275725"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="287275725"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 17:49:45 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="626249275"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="626249275"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.254.208.181]) ([10.254.208.181])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 17:49:43 -0700
Subject: Re: [kbuild-all] Re: include/trace/trace_events.h:261:16: error:
 function 'trace_event_get_offsets_iwlwifi_dbg' might be a candidate for
 'gnu_printf' format attribute
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>,
        linux-wireless@vger.kernel.org
References: <202210212134.QTpb11ug-lkp@intel.com>
 <20221021101026.1708a426@gandalf.local.home>
 <ed665ca3-fa87-fee6-7284-9aed257264e4@intel.com>
 <20221024103524.43e13ab3@gandalf.local.home>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <b612432e-7f21-4c79-5553-35ad7bdc6fd2@intel.com>
Date:   Tue, 25 Oct 2022 08:49:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20221024103524.43e13ab3@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/24/2022 10:35 PM, Steven Rostedt wrote:
> On Mon, 24 Oct 2022 15:26:00 +0800
> "Chen, Rong A" <rong.a.chen@intel.com> wrote:
> 
>> On 10/21/2022 10:10 PM, Steven Rostedt wrote:
>>> On Fri, 21 Oct 2022 22:07:17 +0800
>>> kernel test robot <lkp@intel.com> wrote:
>>>    
>>>> Hi Steven,
>>>>
>>>> FYI, the error/warning still remains.
>>>
>>>     WONT FIX
>>>
>>> I thought we already discussed getting rid of this warning?
>>
>> Hi Steve,
>>
>> Sorry for the noise, the bot doesn't ignore this warning with prefix
>> 'error:', we will fix it.
> 
> Ug. Let me guess, is this compiled with -Werror?
> 
> Because a warning about a macro that may or may not create printf
> formatting, where gcc thinks it needs a gcc printf attribute and warns
> about it, is not something to fail the build on.
> 
> For any build that fails on warnings, that specific warning needs to be
> silenced.
> 
> I mean, "-Werror=suggest-attribute=format", really?

yes, it's compiled with -Werror if using 'W=1' option:

 >>>>>> include/trace/trace_events.h:261:16: error: function 
'trace_event_get_offsets_iwlwifi_dbg' might be a candidate for 
'gnu_printf' format attribute [-Werror=suggest-attribute=format]

Best Regards,
Rong Chen

> 
> -- Steve
> 
>>>    
>>>>
>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>>> head:   e35184f321518acadb681928a016da21a9a20c13
>>>> commit: c7c37bb87590886e08d24dec53089f74b89f5fbb tracing/iwlwifi: Use the new __vstring() helper
>>>> date:   3 months ago
>>>> config: x86_64-sof-customedconfig-edison-defconfig
>>>> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
>>>> reproduce (this is a W=1 build):
>>>>           # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c7c37bb87590886e08d24dec53089f74b89f5fbb
>>>>           git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>>           git fetch --no-tags linus master
>>>>           git checkout c7c37bb87590886e08d24dec53089f74b89f5fbb
>>>>           # save the config file
>>>>           mkdir build_dir && cp config build_dir/.config
>>>>           make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/wireless/intel/iwlwifi/
>>>>
>>>> If you fix the issue, kindly add following tag where applicable
>>>> | Reported-by: kernel test robot <lkp@intel.com>
>>>>
>>>> All errors (new ones prefixed by >>):
>>>>
>>>>      In file included from include/trace/define_trace.h:102,
>>>>                       from drivers/net/wireless/intel/iwlwifi/iwl-devtrace-msg.h:71,
>>>>                       from drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h:91,
>>>>                       from drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c:15:
>>>>      drivers/net/wireless/intel/iwlwifi/./iwl-devtrace-msg.h: In function 'trace_event_get_offsets_iwlwifi_dbg':
>>>>>> include/trace/trace_events.h:261:16: error: function 'trace_event_get_offsets_iwlwifi_dbg' might be a candidate for 'gnu_printf' format attribute [-Werror=suggest-attribute=format]
>>>>        261 |         struct trace_event_raw_##call __maybe_unused *entry;            \
>>>>            |                ^~~~~~~~~~~~~~~~
>>>>      include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
>>>>         40 |         DECLARE_EVENT_CLASS(name,                              \
>>>>            |         ^~~~~~~~~~~~~~~~~~~
>>>>      drivers/net/wireless/intel/iwlwifi/./iwl-devtrace-msg.h:49:1: note: in expansion of macro 'TRACE_EVENT'
>>>>         49 | TRACE_EVENT(iwlwifi_dbg,
>>>>            | ^~~~~~~~~~~
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
