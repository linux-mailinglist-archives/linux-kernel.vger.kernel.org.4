Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118A0609B14
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiJXHOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiJXHOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:14:05 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BEF58E84
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 00:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666595644; x=1698131644;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=e3CxRMIOA/uVAOE3wkkLwqHMzto0TfKUoin6G/0afsg=;
  b=l8cw3QO4mowiSxZTMuvM+cYbyzgniKQtGxaFwmwi85oUpT7wghHxu872
   /WDzDUa1cDvdlrq83WZt8eWcoRpJHTdOKAjwLauSVJXZX8ZoYFBcQ+rTD
   ftS8VDl9BR6+4Ji4oYy28nVCOXFpFEJSZfSM0YMmswwFK+LsPjmqZs3mA
   ElFBkD8n1lWTNsj6gnai4WMFoRUdXeCttykSws63H25aj7FGqnT9Uud4T
   U1rTn3S61t6D75mCGQ19VcGMdrCANo/J5YVqIQdPHd/yPDbZm+xaphzBQ
   +R7ML3C3FsRf+xBxglV6stJqW1vF3JYdnaELnErHwKRl2+zb5ftwV1JYN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="369423008"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="369423008"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 00:14:04 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10509"; a="633620906"
X-IronPort-AV: E=Sophos;i="5.95,207,1661842800"; 
   d="scan'208";a="633620906"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.254.212.138]) ([10.254.212.138])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 00:14:02 -0700
Subject: Re: [kbuild-all] Re: kernel/trace/trace_events_synth.c:436:68:
 sparse: sparse: incorrect type in argument 2 (different address spaces)
To:     Steven Rostedt <rostedt@goodmis.org>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
References: <202210191111.XTgMRb3E-lkp@intel.com>
 <20221019093416.1155d790@gandalf.local.home>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <97e79e49-0635-68d8-1ee0-1ba9030c45f1@intel.com>
Date:   Mon, 24 Oct 2022 15:14:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20221019093416.1155d790@gandalf.local.home>
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



On 10/19/2022 9:34 PM, Steven Rostedt wrote:
> On Wed, 19 Oct 2022 11:43:54 +0800
> kernel test robot <lkp@intel.com> wrote:
> 
>> sparse warnings: (new ones prefixed by >>)
>>>> kernel/trace/trace_events_synth.c:436:68: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *unsafe_addr @@     got char *str_val @@
>>     kernel/trace/trace_events_synth.c:436:68: sparse:     expected void const [noderef] __user *unsafe_addr
>>     kernel/trace/trace_events_synth.c:436:68: sparse:     got char *str_val
>>
>> vim +436 kernel/trace/trace_events_synth.c
>>
>>     404	
>>     405	static unsigned int trace_string(struct synth_trace_event *entry,
>>     406					 struct synth_event *event,
>>     407					 char *str_val,
>>     408					 bool is_dynamic,
>>     409					 unsigned int data_size,
>>     410					 unsigned int *n_u64)
>>     411	{
>>     412		unsigned int len = 0;
>>     413		char *str_field;
>>     414		int ret;
>>     415	
>>     416		if (is_dynamic) {
>>     417			u32 data_offset;
>>     418	
>>     419			data_offset = offsetof(typeof(*entry), fields);
>>     420			data_offset += event->n_u64 * sizeof(u64);
>>     421			data_offset += data_size;
>>     422	
>>     423			len = kern_fetch_store_strlen((unsigned long)str_val);
>>     424	
>>     425			data_offset |= len << 16;
>>     426			*(u32 *)&entry->fields[*n_u64] = data_offset;
>>     427	
>>     428			ret = kern_fetch_store_string((unsigned long)str_val, &entry->fields[*n_u64], entry);
>>     429	
>>     430			(*n_u64)++;
>>     431		} else {
>>     432			str_field = (char *)&entry->fields[*n_u64];
>>     433	
>>     434	#ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>>     435			if ((unsigned long)str_val < TASK_SIZE)
>>   > 436				ret = strncpy_from_user_nofault(str_field, str_val, STR_VAR_LEN_MAX);
>>     437			else
>>     438	#endif
>>     439				ret = strncpy_from_kernel_nofault(str_field, str_val, STR_VAR_LEN_MAX);
>>     440	
> 
> 
> Does this fix it?

Hi Steve,

I tried the below patch, it can fix the issue.

Best Regards,
Rong Chen

> 
> -- Steve
> 
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index e310052dc83c..2562d7522999 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -433,7 +433,8 @@ static unsigned int trace_string(struct synth_trace_event *entry,
>   
>   #ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>   		if ((unsigned long)str_val < TASK_SIZE)
> -			ret = strncpy_from_user_nofault(str_field, str_val, STR_VAR_LEN_MAX);
> +			ret = strncpy_from_user_nofault(str_field,
> +				(__force const void __user *)str_val, STR_VAR_LEN_MAX);
>   		else
>   #endif
>   			ret = strncpy_from_kernel_nofault(str_field, str_val, STR_VAR_LEN_MAX);
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
