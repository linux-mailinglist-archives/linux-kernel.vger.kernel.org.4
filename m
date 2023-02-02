Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272CB687A34
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjBBK3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 05:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjBBK3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:29:20 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB3A2C66E;
        Thu,  2 Feb 2023 02:29:19 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ud5so4627798ejc.4;
        Thu, 02 Feb 2023 02:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDczMK6QGEx7AYRb10cj/ES1Fdkv4zSuiKYZ9KoSqzc=;
        b=oP3VnnlVakoXFC9lbChPggPB9j9in358xpuyk+vcZBZb0NTWI7uVQV6KbF8KJpDRON
         wLMVr1Cy4Zz7uAOqv0gKvGSs1VLJ0KCYgsNsycLnoo3XNlxE2kJ3YANyJhR24E+1zZH8
         oOWYZQWjjV1hg08sOGZqLLGDH5m9w5QUhBA1fMdtzPoQpKmR3R2VI9ZvsiFkVp/jjtw1
         KzQk92qeACoWACloKIe+kmukTTBgu7XA7Cjve+fwDYT1HqaNJRR3XG4EyODFVUNVm04Y
         mOoBuz5EBw6HKJtI+oioBLPZTfU/eLUjwtCwhhwD0loUri9XqtS42zo3I6b5l6T/rqSY
         FYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PDczMK6QGEx7AYRb10cj/ES1Fdkv4zSuiKYZ9KoSqzc=;
        b=yR7/3L4yFuw1r8nJSvM1gQYUGQGqAqZUGznsfta+yjaerJ25XCG0bRJc0gBTFDyBAV
         q8WVK8ZL7y4mB0oDvMDeVFq9Xb5Kz1PwrHtQwpRH4QTQ42N3wyyq6e4TR6pHUlQjkIwS
         hNHP6Ny/k5x1fp2K4+PumkFToGGwC/h8fNN7J1+2IO8oENt49Kbgt348FVvRW7a4/1jj
         s+i6hrvLtW0fDVDpGLo/gb3rNgvKKaTvkMjXnK25lPDMUIcPYaR3VT3q3OC4xgfgalVi
         bt4ln0pbiNb0qNvHYv6Xj2OJHqN/CAJkjrI3i8if0QJXl6YpID2dR5/SYaR/8FbHnvD3
         +rzw==
X-Gm-Message-State: AO0yUKVw0sfbHVKpYhATsA1YIKB5at1LG6ow7O2fSaRvYl54yPTla5zO
        iAWRpS4TM9Ve8Yr8mdOMPCE=
X-Google-Smtp-Source: AK7set8z0SSifew38k/iqNDwEMvNSGdYPJ1KAUjZU2aBmDo8a+C3AQh/Oj8czl6jgs5LGPJXmyEGVA==
X-Received: by 2002:a17:906:885:b0:87b:d3fa:79f2 with SMTP id n5-20020a170906088500b0087bd3fa79f2mr6259755eje.19.1675333757590;
        Thu, 02 Feb 2023 02:29:17 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id t15-20020a170906268f00b008888f4120d4sm6114171ejc.129.2023.02.02.02.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 02:29:16 -0800 (PST)
Message-ID: <68d19d2b-0613-f1b4-08ff-9d86f5021f9f@gmail.com>
Date:   Thu, 2 Feb 2023 11:29:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
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
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 05/14] soc: mediatek: mtk-svs: use svs clk control APIs
In-Reply-To: <546d7f2b3607310f0ebe11b3d4e0aac40ac44c7a.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

你好，

On 01/02/2023 13:28, Roger Lu (陸瑞傑) wrote:
> Hi Matthias Sir,
> 
> On Tue, 2023-01-31 at 14:19 +0100, Matthias Brugger wrote:
>>
>> On 11/01/2023 08:45, Roger Lu wrote:
>>> In MediaTek HW design, svs and thermal both use the same clk source.
>>> It means that svs clk reference count from CCF includes thermal control
>>> counts. That makes svs driver confuse whether it disabled svs's main clk
>>> or not from CCF's perspective and lead to turn off their shared clk
>>> unexpectedly. Therefore, we add svs clk control APIs to make sure svs's
>>> main clk is controlled well by svs driver itself.
>>>
>>> Here is a NG example. Rely on CCF's reference count and cause problem.
>>>
>>> thermal probe (clk ref = 1)
>>> -> svs probe (clk ref = 2)
>>>      -> svs suspend (clk ref = 1)
>>>         -> thermal suspend (clk ref = 0)
>>>         -> thermal resume (clk ref = 1)
>>>      -> svs resume (encounter error, clk ref = 1)
>>>      -> svs suspend (clk ref = 0)
>>>         -> thermal suspend (Fail here, thermal HW control w/o clk)
>>>
>>> Fixes: a825d72f74a3 ("soc: mediatek: fix missing clk_disable_unprepare() on
>>> err in svs_resume()")
>>> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
>>
>> That looks wrong. Although I don't out of my mind, there should be a way to
>> tell
>> the clock framework that this clock is shared between several devices.
>>
>> I wonder if using clk_enable and clk_disable in svs_resume/suspend wouldn't
>> be
>> enough.
> 
> Oh yes, Common Clock Framework (CCF) knows the clock shared between several
> devices and maintains clock "on/off" by reference count.
> 

The thing is if you use clk_prepare_enable then the clock framework check's if 
the clock is already prepared, which could happen like you described in the 
svs_resume (encount error) case in the commit message. The question is, can't we 
just use clk_enable and clk_disable in resume/suspend and only prepare the clock 
in the probe function?

> We concern how to stop running svs_suspend() when svs clk is already disabled by
> svs_resume(). Take an example as below, if we refers to __clk_is_enabled()
> result for knowing svs clk status, it will return "true" all the time because
> thermal clk is still on. This causes the problem mentioned in commit message.
> 

I would expect that the kernel takes care that we can't enter a resume path for 
a device before the suspend path has finished. Honestly I don't really 
understand the problem here. It seems something different then what you 
described in the commit message.

Please help me understand better.

谢谢，再见

Matthias

> static int svs_suspend(struct device *dev)
> {
> ...
> 	if (!__clk_is_enabled(svsp->main_clk)) //always get `true`
> 		return 0;
> ...
> }
> 
>>
>> Regards,
>> Matthias
> 
> ... [snip] ...
