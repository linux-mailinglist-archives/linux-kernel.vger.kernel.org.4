Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089E86063DE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiJTPKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiJTPKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:10:14 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F61D8F54;
        Thu, 20 Oct 2022 08:10:13 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bu30so35048933wrb.8;
        Thu, 20 Oct 2022 08:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fQQpq6L0etG4WsZJNoc8BsJzIxOLgNyKPl0arkE7fVI=;
        b=iZkh/1JnKPx7ySBUolSfT7kJEXRaJj+FB/5pU2Gr6AIZiILZ1zcTe/9YpqELP2qGX6
         9ljL5Ab9PeCF/cYw7gcdpBXArRlBl0de+NRqou9zVAbHx5OKJq5EOtqaw3KiY0K9zIYt
         DjIUuWRI6JswaVkTbU0A1zfPMteHI7lKvzJQwDQwcZicJLeQisvSXHSQErYcU5sM7xIU
         Ozg91DhPKCeHd00Lsin7PUaeWgIWr+dMX97k2AI6h57qppOLxyAjnJHum2Yk6d47iA9u
         B4+LJfOBSVWEsszgLplsD7c9RU7voEwEj5mkFQa8CKNVXLj2azGlBHacJ0SkD1oY0WAD
         pjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQQpq6L0etG4WsZJNoc8BsJzIxOLgNyKPl0arkE7fVI=;
        b=aNSY5dKiRsKCp3YQJ7NR26O0T7Z6KVycA8Uk23AW7seNxbWSQq5+qOxWaSuEWaeTo2
         rtSceOO4KZaU9y3G1Uy14EMJ6AV0HkiAPFYoNYaih/2Om+54HyGJnALwlrQSdz71mEOO
         K/5I7qGeEOFKFukz2iNjLukpJ0bIpUpmsKndCf8adz23MP48hdYvbo9Gpomm0Ows4MqD
         +kgvhgYzQKpL1QRvitkxcx5VqQheEIrnRSD0vurWf3W4pPo3q+ocMGcgDbb0DJmnggxE
         /cJZg1aHYI8miQnqoQi9ltUO+e/Yewz7ak+jpNPl9ddgEvNglFrJRyDEJ9BcOEf/nskb
         tU7Q==
X-Gm-Message-State: ACrzQf2V+XqMfuSxMQJseBMmXMze5NMVapnQJjKwx84MqDtqPqHK3V14
        U0cClXH3g0xffzka4BYsVe0=
X-Google-Smtp-Source: AMsMyM6mgrczjlSKxTmE0ayh8j9cS6feXrWJ5OWFEQNRc+1u3UUg4rwyvehdsIfgJDcZvgtUVL+5aQ==
X-Received: by 2002:a5d:6d86:0:b0:22e:4049:441f with SMTP id l6-20020a5d6d86000000b0022e4049441fmr9103054wrs.198.1666278611695;
        Thu, 20 Oct 2022 08:10:11 -0700 (PDT)
Received: from [192.168.0.210] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id s2-20020adfea82000000b002364835caacsm1308611wrm.112.2022.10.20.08.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 08:10:11 -0700 (PDT)
Message-ID: <6005e7c0-5901-ef5a-6af7-2801975e39bc@gmail.com>
Date:   Thu, 20 Oct 2022 16:10:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] tracing/hist: add in missing * in comment blocks
Content-Language: en-US
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221020133019.1547587-1-colin.i.king@gmail.com>
 <20221020234423.42816821e2d09aba61db5e69@kernel.org>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <20221020234423.42816821e2d09aba61db5e69@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2022 15:44, Masami Hiramatsu (Google) wrote:
> Hi,
> 
> On Thu, 20 Oct 2022 14:30:19 +0100
> Colin Ian King <colin.i.king@gmail.com> wrote:
> 
>> There are a couple of missing * in comment blocks. Fix these.
>> Cleans up two clang warnings:
>>
>> kernel/trace/trace_events_hist.c:986: warning: bad line:
>> kernel/trace/trace_events_hist.c:3229: warning: bad line:
>>
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> 
> Thanks for the patch.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> BTW, what version of clang are you using?
> I couldn't see this warning with clang 15.0.0. Maybe I need a kconfig option?

clang-13 and kernel W=1 for this specific case, e.g. kernel built using 
make  CC=clang-13 HOSTCC=clang-13 W=1


> 
> Thank you,
> 
>> ---
>>   kernel/trace/trace_events_hist.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
>> index 48465f7e97b4..087c19548049 100644
>> --- a/kernel/trace/trace_events_hist.c
>> +++ b/kernel/trace/trace_events_hist.c
>> @@ -983,7 +983,7 @@ static struct hist_field *find_any_var_ref(struct hist_trigger_data *hist_data,
>>    * A trigger can define one or more variables.  If any one of them is
>>    * currently referenced by any other trigger, this function will
>>    * determine that.
>> -
>> + *
>>    * Typically used to determine whether or not a trigger can be removed
>>    * - if there are any references to a trigger's variables, it cannot.
>>    *
>> @@ -3226,7 +3226,7 @@ static struct field_var *create_field_var(struct hist_trigger_data *hist_data,
>>    * events.  However, for convenience, users are allowed to directly
>>    * specify an event field in an action, which will be automatically
>>    * converted into a variable on their behalf.
>> -
>> + *
>>    * This function creates a field variable with the name var_name on
>>    * the hist trigger currently being defined on the target event.  If
>>    * subsys_name and event_name are specified, this function simply
>> -- 
>> 2.37.3
>>
> 
> 

