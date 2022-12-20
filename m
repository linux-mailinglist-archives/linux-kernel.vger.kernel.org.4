Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C32651721
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 01:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbiLTAUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 19:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiLTAUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 19:20:43 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AA71106
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 16:20:42 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id s16so5603242iln.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 16:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DUmTkQx7tlD5TtKn/80kREr/JVEYJaIJGvPROtM0mL0=;
        b=V1bSJIjuBtSv1w3SCnclZTPLvXyYvVXc/LPgCKLTtKSAfsB8hOrwi33/EEocHBEyeJ
         CCM2zV5bYQH4zUR1U/KtO9Wd/kQly6llVM8lZsiPhymWipFBD/iZJ2XVMUxsIdqr7y6A
         ovm7qpfayvFhzp5b0o/hs8RpO/Xs6LFKzcdbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DUmTkQx7tlD5TtKn/80kREr/JVEYJaIJGvPROtM0mL0=;
        b=6SbJeNETkzOXUa5kgRT6U0mp38pVhqF8AASS09TM4BhNOllwdVp6Mn705mK+11cN9t
         HmXJPVtxVIlN6wUBf8o4r29qQpRVmDQdIfFYIiFu5G0vGbOnO7GTiTwhhO8Z1w8035gf
         rSEwLPXrp4pI5ECsgmZuQtz3a9S5KMa/aIdfKs1bARhwauGMF6pmuND5bQnzXQ3kxURW
         jsTUtZXORjDD9UvA8zrxs/Z/JNhKKNK0nHsPaLSj2ioHiREW/m4lYxYxQ54Y7jr+Wfh9
         OB9VTzsJluhFo1CNn1z1aeOdkWy5kc3hA161RpQPipn1QLkXUm0CNir5XRNAAZ4vD1lE
         HsoA==
X-Gm-Message-State: AFqh2kroOga33meUApFHVwE+7zIdoLpwZY/keLCKth6uxHq985I4rFVE
        egj/i7yOx4hFxt719W69IUDw1Q==
X-Google-Smtp-Source: AMrXdXuap7STFlwgIf/xUI3fUSBGXTjHraLQ8dMYhPMnmA2yfkEi9u43IpR8pCb/aNk3jfIetDBl2g==
X-Received: by 2002:a05:6e02:1a2e:b0:30b:1aa9:8663 with SMTP id g14-20020a056e021a2e00b0030b1aa98663mr1187288ile.2.1671495641440;
        Mon, 19 Dec 2022 16:20:41 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id r9-20020a92c5a9000000b003039e7d680fsm3803031ilt.11.2022.12.19.16.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 16:20:40 -0800 (PST)
Message-ID: <a854db66-0a14-e40b-f3f0-369228fcd835@linuxfoundation.org>
Date:   Mon, 19 Dec 2022 17:20:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] tracing/selftests: Add test for event filtering on
 function name
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ross Zwisler <zwisler@google.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221219183106.518341498@goodmis.org>
 <20221219183214.075559302@goodmis.org> <Y6DQTvOrHRZ8gjDz@google.com>
 <5e3e9408-8ddd-3649-ef98-4bd611c528cc@linuxfoundation.org>
 <20221219173507.410915a3@gandalf.local.home>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221219173507.410915a3@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/22 15:35, Steven Rostedt wrote:
> On Mon, 19 Dec 2022 15:11:39 -0700
> Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>> On 12/19/22 13:57, Ross Zwisler wrote:
>>> On Mon, Dec 19, 2022 at 01:31:08PM -0500, Steven Rostedt wrote:
>>>> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>>>>
>>>> With the new filter logic of passing in the name of a function to match an
>>>> instruction pointer (or the address of the function), add a test to make
>>>> sure that it is functional.
>>>>
>>>> This is also the first test to test plain filtering. The filtering has
>>>> been tested via the trigger logic, which uses the same code, but there was
>>>> nothing to test just the event filter, so this test is the first to add
>>>> such a case.
>>>>
>>>> Cc: Shuah Khan <shuah@kernel.org>
>>>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>>>> Cc: linux-kselftest@vger.kernel.org
>>>> Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>>>
>>> Reviewed-by: Ross Zwisler <zwisler@google.com>
>>
>> Thank you both. I will apply this after rc1 comes out.
> 
> It's dependent on the first patch.
> 

In which case,

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah



