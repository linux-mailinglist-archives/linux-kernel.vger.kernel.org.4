Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688C46067E8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiJTSIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiJTSH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:07:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B631B15A977;
        Thu, 20 Oct 2022 11:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=pWUVsfzWDBIXyjYnhK+XoMfAyHRpezXQSqYzXKvXWzI=; b=K/TLqvaF1o6pPDVyQVhY/896cK
        9e5z/VznvZSDHDEJgMkAoHAilNDANxyp7gGdBt9s67nQ/koZPxYcU6STAL3axsoNmqkj3+lFEtWnK
        NWtONsKs7kxiJlG/rIg6Ooask0AkULPvwyK8nuVmvC1mQFmj9HQ/CsVgVOeq/QeahpvQXYeNSGwmC
        Ld2kAG3nRIEMSS63yw7Zw3XedgtNQKRm/9EoMIvC8n4O9F+lTl1gVSVMAYas4VRAYdHAbG+tveG1a
        jyYOA7uj8U5YLvQr3mjkyVGyk47t6PDknJGAs1nqLPNDd/4STXGSvEwPuqb3TYxVacpiySZKwh9Cm
        f0w8heEA==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olZwn-0012aL-LV; Thu, 20 Oct 2022 18:07:13 +0000
Message-ID: <69d9ee66-c312-0387-1307-62fda7bd24ae@infradead.org>
Date:   Thu, 20 Oct 2022 11:07:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] tracing/hist: add in missing * in comment blocks
Content-Language: en-US
To:     "Colin King (gmail)" <colin.i.king@gmail.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221020133019.1547587-1-colin.i.king@gmail.com>
 <20221020234423.42816821e2d09aba61db5e69@kernel.org>
 <6005e7c0-5901-ef5a-6af7-2801975e39bc@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <6005e7c0-5901-ef5a-6af7-2801975e39bc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/22 08:10, Colin King (gmail) wrote:
> On 20/10/2022 15:44, Masami Hiramatsu (Google) wrote:
>> Hi,
>>
>> On Thu, 20 Oct 2022 14:30:19 +0100
>> Colin Ian King <colin.i.king@gmail.com> wrote:
>>
>>> There are a couple of missing * in comment blocks. Fix these.
>>> Cleans up two clang warnings:
>>>
>>> kernel/trace/trace_events_hist.c:986: warning: bad line:
>>> kernel/trace/trace_events_hist.c:3229: warning: bad line:
>>>
>>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>>
>> Thanks for the patch.
>>
>> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
>> BTW, what version of clang are you using?
>> I couldn't see this warning with clang 15.0.0. Maybe I need a kconfig option?
> 
> clang-13 and kernel W=1 for this specific case, e.g. kernel built using make  CC=clang-13 HOSTCC=clang-13 W=1
> 

but those are kernel-doc warnings, not clang (AFAIK).

> 
>>
>> Thank you,
>>
>>> ---
>>>   kernel/trace/trace_events_hist.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
>>> index 48465f7e97b4..087c19548049 100644
>>> --- a/kernel/trace/trace_events_hist.c
>>> +++ b/kernel/trace/trace_events_hist.c
>>> @@ -983,7 +983,7 @@ static struct hist_field *find_any_var_ref(struct hist_trigger_data *hist_data,
>>>    * A trigger can define one or more variables.  If any one of them is
>>>    * currently referenced by any other trigger, this function will
>>>    * determine that.
>>> -
>>> + *
>>>    * Typically used to determine whether or not a trigger can be removed
>>>    * - if there are any references to a trigger's variables, it cannot.
>>>    *
>>> @@ -3226,7 +3226,7 @@ static struct field_var *create_field_var(struct hist_trigger_data *hist_data,
>>>    * events.  However, for convenience, users are allowed to directly
>>>    * specify an event field in an action, which will be automatically
>>>    * converted into a variable on their behalf.
>>> -
>>> + *
>>>    * This function creates a field variable with the name var_name on
>>>    * the hist trigger currently being defined on the target event.  If
>>>    * subsys_name and event_name are specified, this function simply
>>> -- 
>>> 2.37.3
>>>
>>
>>
> 

-- 
~Randy
