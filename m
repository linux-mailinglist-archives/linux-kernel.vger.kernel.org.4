Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183296CFFD9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 11:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjC3Jbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 05:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjC3Jbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:31:46 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329BB7ABA;
        Thu, 30 Mar 2023 02:31:45 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so13036231wmq.4;
        Thu, 30 Mar 2023 02:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680168703;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2wlyXiuObJJjktYiyreCZzL3rjA4zKtmBixPoT6R+F0=;
        b=Y4OoQAhVGOqI+uv0pxKJRu4ZsIvPkStPkTUbv/2I6V3iDEot8HwhvO6dInlCxKYWBc
         bad03C5wA4wX8bLnfeOGwydUjNhDacl6qyErhJ2XmtoyJipMNSIuJ1eD0afSmtPlZgv4
         3VuwgNhG0xmkrhPVS/AXsIONapDnDoANbq/0JoqJeAPqulZOOfuZrfaZBgRa0YZ0KX0u
         61yL6jG5GqP/yUlIdvtrRqUjOZF0scdaKVObg3LqAyb5EKJ4mfh/IaXPNwt82a0C2uVA
         p1cSHvykOG99d3Br0z5fqhMb+1v5wFHN0KyfDnZosrZ35uNnKUJeCCd1mdcAp3mYgcH/
         YFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680168703;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wlyXiuObJJjktYiyreCZzL3rjA4zKtmBixPoT6R+F0=;
        b=SjpmeYc0ydaYmQd4AQLrQncp7jGv27FrvtutQHKIZsLPNM7ajWh+GgVbHC+ENOuolu
         eEHkHGaySLvuUKB+2hnJiBVbfZJNJCHW3iOOwYUdbOYT2fTmLr8GCOgr/0Pf7JsR7S+p
         33nvRt8IbA+qlLteYYIf/swvT+1pTgeYKXl6RPL9zhhnA9V29kCc5dwST9qbmi8FBWLp
         +MamhNz9n6fMLCLPhg0Vk04eIagZ/4pqwNoD91GCmk8AjF3wBd0pPZOb/d9P2gCMlyh8
         XW+UIL1CkG+z9iNOb1gJaQy6+euQhzZdj729YlutDEa2290TBHg6LRpvT/J0e17QHL6s
         TTsQ==
X-Gm-Message-State: AO0yUKWy8/yb9COKHg4eXA+Ye5fXmM26sglMXRfJVs8Ainuc0xVNlarD
        QkiwnCHOlxKji5FMYIepJPVdwjsjdapSfMFG
X-Google-Smtp-Source: AK7set8MoRoP1u28J2KlqIRCUvbhxPNq5qX8D5y1gRGG9mTbXEF5Z82DXD5g1HsNB5h8AJgc4McNiQ==
X-Received: by 2002:a7b:ca4a:0:b0:3ea:e582:48dd with SMTP id m10-20020a7bca4a000000b003eae58248ddmr17293179wml.34.1680168703616;
        Thu, 30 Mar 2023 02:31:43 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id m18-20020a7bcb92000000b003ee58e8c971sm5107057wmi.14.2023.03.30.02.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 02:31:42 -0700 (PDT)
Message-ID: <5a1b22cb-4597-8137-e802-ca81ceb99c7c@gmail.com>
Date:   Thu, 30 Mar 2023 11:31:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 3/3] soc: mediatek: mtk-svs: add thermal voltage
 compensation if needed
Content-Language: en-US
To:     =?UTF-8?B?Um9nZXIgTHUgKOmZuOeRnuWCkSk=?= <Roger.Lu@mediatek.com>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>,
        "khilman@kernel.org" <khilman@kernel.org>,
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
References: <20230202124104.16504-1-roger.lu@mediatek.com>
 <20230202124104.16504-4-roger.lu@mediatek.com>
 <26837308-4837-f252-d162-f8af4859b63e@gmail.com>
 <fd62705e1abf8124706da6520fde5b77846bfd2c.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <fd62705e1abf8124706da6520fde5b77846bfd2c.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/02/2023 12:12, Roger Lu (陸瑞傑) wrote:
> Hi Matthias Sir,
> 
> Sorry for the late reply.
> 
> ... [snip] ...
> 
>>> @@ -2127,6 +2123,7 @@ static struct svs_bank svs_mt8192_banks[] = {
>>>    		.type			= SVSB_LOW,
>>>    		.set_freq_pct		= svs_set_bank_freq_pct_v3,
>>>    		.get_volts		= svs_get_bank_volts_v3,
>>> +		.tzone_name		= "gpu1",
>>>    		.volt_flags		= SVSB_REMOVE_DVTFIXED_VOLT,
>>>    		.mode_support		= SVSB_MODE_INIT02,
>>>    		.opp_count		= MAX_OPP_ENTRIES,
>>> @@ -2144,6 +2141,10 @@ static struct svs_bank svs_mt8192_banks[] = {
>>>    		.core_sel		= 0x0fff0100,
>>>    		.int_st			= BIT(0),
>>>    		.ctl0			= 0x00540003,
>>> +		.tzone_htemp		= 85000,
>>> +		.tzone_htemp_voffset	= 0,
>>> +		.tzone_ltemp		= 25000,
>>> +		.tzone_ltemp_voffset	= 7,
>>
>> Which is the exact same tzone then in the other bank. Which brings me to a
>> good
>> point:
>> Is the tzone bank specific or the same for all banks?
> 
> Thermal zone (tzone) isn't for all SVS banks. In other words, tzone is specific
> for corresponding DVFS domain like SVS GPU tzone is for GPU DVFS domain. Let's
> take MT8183 SVS and MT8192 SVS as examples.
> 
> MT8192 SVS applies 2-line HW design (High/low 2 banks optimize the same DVFS
> domain). So, SVS GPU High/low bank uses the same GPU tzone.
> 
> MT8183 SVS applies 1-line HW design (1 bank optimizes 1 DVFS domain)
> Therefore, SVS CPU/GPU/CCI bank use different tzone because they are different
> DVFS domain.
> 
>> At least for mt8192 they are not. I suppose with this change to the code
>> mt8183
>> could take advantage of this on all it's banks as well.
>> In that case, can we
>> start to restructure the struct svs_bank to only have the tzone values
>> declared
>> once?
> 
> Since tzone isn't for all banks, we cannot declare it once for all IC supports
> from this point of view.
> 

Thanks for clarification, applied now.

>>
>> Background is that I'm very unhappy with the svs_bank data strucutre. It
>> seems
>> like a "throw it all in here". It should be structured for functional parts
>> of
>> the banks. Maybe using structs, maybe unions where possible. In any case
>> having
>> a flat struct of over 50 members isn't really what we want.
> 
> My apology. We'll structure svs_bank for functional parts of them.
> 
>>
>> Regards,
>> Matthias
