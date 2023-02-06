Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978AD68BC79
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 13:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjBFMKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 07:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjBFMKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 07:10:06 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF7623311;
        Mon,  6 Feb 2023 04:09:44 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso10592525wmp.3;
        Mon, 06 Feb 2023 04:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mkieBVXyuXtLN/bc1QTPATR4LutqZUxw3h7MQHIHbPk=;
        b=adA8eZz/Xrx0Dkw8S9MB+CNZ5VfZRzasAKUKRfQOguaPKXZSonbMSQd2rcgEo8Ziny
         OKz/OqM/A676KGCq90cDQ9sqk3+VndF5pRfJb+dOz8718DTFbHuLI7plxQeEsMxS+iYd
         deNNIj5h95c+wAU4/YQBru9rd4+wij+wQ4U/zh3JlED1HLakJdM8Na/YpJBfCAimV3v9
         E/o4wimujXrkvailZVZA7CMrNsNEyzkYoSr0V/SFRWRzI0T8BB8n1EgUR8RUPacCq5ie
         miM0lTfLeXabIlViX9Zz85UBTvofpqadJl427/Wh0Vj76vOBSbyE4SqstKYT8K2QwMtC
         emRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mkieBVXyuXtLN/bc1QTPATR4LutqZUxw3h7MQHIHbPk=;
        b=GN4f4Bi35/1h4AGDPnToGANQTADUHfEyJ/tr+1dO/dVNnzZMxg+OizxgnKaOo+jCbo
         0srL6Qzc67HHbwtomrIW8g3lBgtoVffOjfPKUSXKqv/FtkmNXnQ5XTF4IXsOV9jgFKqP
         gK2ZVJg9M5NE0hrHuGigoXU7z453YVsc8XPWONgOvHnVCnpXpRvGd7xoshmIeMqXKPRH
         Ujg+pTvVAaxEnp4SS/3lTtTg3zqYgco7WGNpva0j1EiRH8lTMp6ZRZrmsJRO9pu0mHCs
         G21903djk4IdEMmtcn1bH7gimR+oiUnTf59HzEM1fD21Q1cEB8a2Cvr1b2SzaK88FmMf
         Fz8Q==
X-Gm-Message-State: AO0yUKVR5qNBtUl3sMar5iVEDug7rZgx/UppiyqxlO4sLrvJg6x+z+ba
        Uq2yiXu1oC5/3LTjesahmV4=
X-Google-Smtp-Source: AK7set8ZIAil8Uoylc99zUisniEdX1rFJ73LAoIdLWa8BQwPv68vycHlfZd0QGwZ1x8sHVRK3M0wYw==
X-Received: by 2002:a05:600c:1e8d:b0:3df:7948:886b with SMTP id be13-20020a05600c1e8d00b003df7948886bmr16260602wmb.31.1675685383123;
        Mon, 06 Feb 2023 04:09:43 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600c198600b003dc492e4430sm11238024wmq.28.2023.02.06.04.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 04:09:42 -0800 (PST)
Message-ID: <f49ad56c-a5fd-5e51-f812-a2941b5681d6@gmail.com>
Date:   Mon, 6 Feb 2023 13:09:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To:     =?UTF-8?B?Um9nZXIgTHUgKOmZuOeRnuWCkSk=?= <Roger.Lu@mediatek.com>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "khilman@kernel.org" <khilman@kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "drinkcat@google.com" <drinkcat@google.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?SmlhLXdlaSBDaGFuZyAo5by15L2z5YGJKQ==?= 
        <Jia-wei.Chang@mediatek.com>,
        =?UTF-8?B?RmFuIENoZW4gKOmZs+WHoSk=?= <fan.chen@mediatek.com>
References: <20230111074528.29354-1-roger.lu@mediatek.com>
 <20230111074528.29354-6-roger.lu@mediatek.com>
 <5192bc94-12c7-dce4-c2e6-fa4b8c1ced9d@gmail.com>
 <546d7f2b3607310f0ebe11b3d4e0aac40ac44c7a.camel@mediatek.com>
 <68d19d2b-0613-f1b4-08ff-9d86f5021f9f@gmail.com>
 <615b406692504bb68bd781030023c0fa7b2bd11e.camel@mediatek.com>
Content-Language: en-US
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 05/14] soc: mediatek: mtk-svs: use svs clk control APIs
In-Reply-To: <615b406692504bb68bd781030023c0fa7b2bd11e.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/02/2023 03:01, Roger Lu (陸瑞傑) wrote:
> Hi Matthias Sir,
> 
> 
> On Thu, 2023-02-02 at 11:29 +0100, Matthias Brugger wrote:
>> 你好，
> 
> I got shock and thought someone used your name to reply. However,
> your email account helps me clear my mind. Haha.. Nice and warm to see mandarin
> on patchwork. It's so fresh and exciting :-).
> 

谢谢。 I'm learning mainland Chinese for a few month now, I also learned that you 
use different symbols in Taiwan, which I don't know. 对不起。

>>
>> On 01/02/2023 13:28, Roger Lu (陸瑞傑) wrote:
>>> Hi Matthias Sir,
>>>
>>> On Tue, 2023-01-31 at 14:19 +0100, Matthias Brugger wrote:
>>>>
>>>> On 11/01/2023 08:45, Roger Lu wrote:
>>>>> In MediaTek HW design, svs and thermal both use the same clk source.
>>>>> It means that svs clk reference count from CCF includes thermal control
>>>>> counts. That makes svs driver confuse whether it disabled svs's main clk
>>>>> or not from CCF's perspective and lead to turn off their shared clk
>>>>> unexpectedly. Therefore, we add svs clk control APIs to make sure svs's
>>>>> main clk is controlled well by svs driver itself.
>>>>>
>>>>> Here is a NG example. Rely on CCF's reference count and cause problem.
>>>>>
>>>>> thermal probe (clk ref = 1)
>>>>> -> svs probe (clk ref = 2)
>>>>>       -> svs suspend (clk ref = 1)
>>>>>          -> thermal suspend (clk ref = 0)
>>>>>          -> thermal resume (clk ref = 1)
>>>>>       -> svs resume (encounter error, clk ref = 1)
>>>>>       -> svs suspend (clk ref = 0)
>>>>>          -> thermal suspend (Fail here, thermal HW control w/o clk)
>>>>>
>>>>> Fixes: a825d72f74a3 ("soc: mediatek: fix missing clk_disable_unprepare()
>>>>> on
>>>>> err in svs_resume()")
>>>>> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
>>>>
>>>> That looks wrong. Although I don't out of my mind, there should be a way
>>>> to
>>>> tell
>>>> the clock framework that this clock is shared between several devices.
>>>>
>>>> I wonder if using clk_enable and clk_disable in svs_resume/suspend
>>>> wouldn't
>>>> be
>>>> enough.
>>>
>>> Oh yes, Common Clock Framework (CCF) knows the clock shared between several
>>> devices and maintains clock "on/off" by reference count.
>>>
>>
>> The thing is if you use clk_prepare_enable then the clock framework check's
>> if
>> the clock is already prepared, which could happen like you described in the
>> svs_resume (encount error) case in the commit message. The question is, can't
>> we
>> just use clk_enable and clk_disable in resume/suspend and only prepare the
>> clock
>> in the probe function?
> 
> We'll think if this can fix the problem. Thanks for the advice very much.
> 
>>
>>> We concern how to stop running svs_suspend() when svs clk is already
>>> disabled by
>>> svs_resume(). Take an example as below, if we refers to __clk_is_enabled()
>>> result for knowing svs clk status, it will return "true" all the time
>>> because
>>> thermal clk is still on. This causes the problem mentioned in commit
>>> message.
>>>
>>
>> I would expect that the kernel takes care that we can't enter a resume path
>> for
>> a device before the suspend path has finished. Honestly I don't really
>> understand the problem here. It seems something different then what you
>> described in the commit message.
>>
>> Please help me understand better.
> 
> I see. This patch title needs to be changed to "avoid turning off svs clk twice
> unexpectedly" for pointing out the problem precisely. We saw a loophole that svs
> clk might be turned off in svs_resume() first and in svs_suspend() again without
> enabling svs clk during these the process. Therefore, we try to fix it by this
> patch. Below is our thinking process to explain how we got here.
> 
> 1. (abandoned) We add __clk_is_enabled() check in svs_suspend() to prevent svs
> clk from being turned off twice when svs_resume() turned off svs clk in the
> error-handling process. Nonetheless, we met the NG case in the commit message.
> 2. (current patch) We add svs clk control hint to understand if we need to run
> svs_suspend() or not if svs_resume() turned off svs clk before.
> 

Did you had a look on the dev_pm_ops？ Maybe we can use suspend_late, 
resume_early to make sure there is no race condition. I wonder also if we can't 
make sure that this does not happen using device links. Sorry, I can't give 
better guidance on how to use this technologies, but I have the feeling we can 
fix this with existing infrastructure.

再见。

Matthias

>>
>> 谢谢，再见
> 
> :-)
> 
> 
> Sincerely,
> Roger Lu
