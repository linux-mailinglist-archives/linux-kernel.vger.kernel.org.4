Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1706CA8E0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjC0P1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjC0P1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:27:20 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39752120
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:27:19 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso5597615wmo.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679930837;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VtoOLUcx0RtI++il9gKXOiFlcs2YJzPL6aI9QEiwN7M=;
        b=rto0BBdHjfDWk46+Hc5b3f7tvwon9q4CRFKAhVaM7edNB2tPiEk28qkrbKJXsmqvlb
         7XH74pzMNlrCbD9Pf0J1fNxCFalbQV1ENjLc/2SekzpAwE2DdC7f0/srzwslGfxN4fvN
         wBEM0TWsNeucBhaVmPwHOqutx9HV70JjSprmyoxCeTuavqSmpr14oYOa/L78HK+nyL22
         k9XCOHNPzOtuXMUOHk8u2rPlJwZZmnoDHYZBXklvNd1rhao+C8DnWq5921E1b48qX8wd
         yejizkSmjyiyk41JjwfsJbwFKYnjLJSiqH59m3r3+f37im4gTRHAGM4VMyUAslR2H0z6
         cpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679930837;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VtoOLUcx0RtI++il9gKXOiFlcs2YJzPL6aI9QEiwN7M=;
        b=ZViXSC4VHDPLbOptvQn0QvqhO//6T9AShA7z8gxR/JxjRkkth7rwYOFUHlMF2QnrJW
         60A8uf8K5nzXGPsc0IMsBAZ2TnJvWGUy3tO/2DbzKS0kzthBTx9gp+7JkcKxJ7hUAAS5
         OXcHZwTWsPTdjPz9YM0o9QTO0p9DkB1jlSkNnQIgoZII9oxt5+DupJSOdoPKGecSVq8l
         tKdmC68w/u4R3BQv5YiwRdJStWwL9EYLz68ZvBpkAzifFb9I56O7TTC6qBUl8uMqHnvB
         21XfcP0NiBw1WllOXFDGyoo6r8ZgAv6bY97cchminGkeLLQSnogCB8BexYeM45cROqaW
         E9WA==
X-Gm-Message-State: AO0yUKWaucono3hK8Yn0l7DZ1ie3JNTv5UiJh/ZrZ4h11UkUOBFbr8TH
        84qsgm/nXGjPm2jgMU3H8emINg==
X-Google-Smtp-Source: AK7set9XtuFTk2GMZHZ2rkL2ed780yDEDnCBR2s3+/9B2p7B1cn2Vq5mV+q3vrL+yjMl0ZJZP672Uw==
X-Received: by 2002:a7b:c448:0:b0:3ef:294c:de50 with SMTP id l8-20020a7bc448000000b003ef294cde50mr9639626wmi.29.1679930837686;
        Mon, 27 Mar 2023 08:27:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ef3b:2a41:93d:75f2? ([2a01:e0a:982:cbb0:ef3b:2a41:93d:75f2])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c4f1200b003ef67848a21sm7337200wmq.13.2023.03.27.08.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 08:27:17 -0700 (PDT)
Message-ID: <c728df98-82f6-0f2c-e4d9-416f3bb358d0@linaro.org>
Date:   Mon, 27 Mar 2023 17:27:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 3/3] perf/amlogic: adjust register offsets
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     Marc Gonzalez <mgonzalez@freebox.fr>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Jiucheng Xu <jiucheng.xu@amlogic.com>,
        Pierre-Hugues Husson <phh@phh.me>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <20230327120932.2158389-1-mgonzalez@freebox.fr>
 <20230327120932.2158389-4-mgonzalez@freebox.fr>
 <f0432ff5-7e73-1e7e-1745-6f3b679153fe@linaro.org>
 <20230327151216.GA32275@willie-the-truck>
Organization: Linaro Developer Services
In-Reply-To: <20230327151216.GA32275@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2023 17:12, Will Deacon wrote:
> On Mon, Mar 27, 2023 at 04:17:29PM +0200, Neil Armstrong wrote:
>> On 27/03/2023 14:09, Marc Gonzalez wrote:
>>> Commit "perf/amlogic: resolve conflict between canvas & pmu"
>>> changed the base address.
>>>
>>> Fixes: 2016e2113d35 ("perf/amlogic: Add support for Amlogic meson G12 SoC DDR PMU driver")
>>> Signed-off-by: Marc Gonzalez <mgonzalez@freebox.fr>
>>> ---
>>>    drivers/perf/amlogic/meson_g12_ddr_pmu.c | 34 +++++++++++++++++-----------------
>>>    1 file changed, 17 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/perf/amlogic/meson_g12_ddr_pmu.c b/drivers/perf/amlogic/meson_g12_ddr_pmu.c
>>> index a78fdb15e26c2..8b643888d5036 100644
>>> --- a/drivers/perf/amlogic/meson_g12_ddr_pmu.c
>>> +++ b/drivers/perf/amlogic/meson_g12_ddr_pmu.c
>>> @@ -21,23 +21,23 @@
>>>    #define DMC_QOS_IRQ		BIT(30)
>>>    /* DMC bandwidth monitor register address offset */
>>> -#define DMC_MON_G12_CTRL0		(0x20  << 2)
>>> -#define DMC_MON_G12_CTRL1		(0x21  << 2)
>>> -#define DMC_MON_G12_CTRL2		(0x22  << 2)
>>> -#define DMC_MON_G12_CTRL3		(0x23  << 2)
>>> -#define DMC_MON_G12_CTRL4		(0x24  << 2)
>>> -#define DMC_MON_G12_CTRL5		(0x25  << 2)
>>> -#define DMC_MON_G12_CTRL6		(0x26  << 2)
>>> -#define DMC_MON_G12_CTRL7		(0x27  << 2)
>>> -#define DMC_MON_G12_CTRL8		(0x28  << 2)
>>> -
>>> -#define DMC_MON_G12_ALL_REQ_CNT		(0x29  << 2)
>>> -#define DMC_MON_G12_ALL_GRANT_CNT	(0x2a  << 2)
>>> -#define DMC_MON_G12_ONE_GRANT_CNT	(0x2b  << 2)
>>> -#define DMC_MON_G12_SEC_GRANT_CNT	(0x2c  << 2)
>>> -#define DMC_MON_G12_THD_GRANT_CNT	(0x2d  << 2)
>>> -#define DMC_MON_G12_FOR_GRANT_CNT	(0x2e  << 2)
>>> -#define DMC_MON_G12_TIMER		(0x2f  << 2)
>>> +#define DMC_MON_G12_CTRL0		(0x0  << 2)
>>> +#define DMC_MON_G12_CTRL1		(0x1  << 2)
>>> +#define DMC_MON_G12_CTRL2		(0x2  << 2)
>>> +#define DMC_MON_G12_CTRL3		(0x3  << 2)
>>> +#define DMC_MON_G12_CTRL4		(0x4  << 2)
>>> +#define DMC_MON_G12_CTRL5		(0x5  << 2)
>>> +#define DMC_MON_G12_CTRL6		(0x6  << 2)
>>> +#define DMC_MON_G12_CTRL7		(0x7  << 2)
>>> +#define DMC_MON_G12_CTRL8		(0x8  << 2)
>>> +
>>> +#define DMC_MON_G12_ALL_REQ_CNT		(0x9  << 2)
>>> +#define DMC_MON_G12_ALL_GRANT_CNT	(0xa  << 2)
>>> +#define DMC_MON_G12_ONE_GRANT_CNT	(0xb  << 2)
>>> +#define DMC_MON_G12_SEC_GRANT_CNT	(0xc  << 2)
>>> +#define DMC_MON_G12_THD_GRANT_CNT	(0xd  << 2)
>>> +#define DMC_MON_G12_FOR_GRANT_CNT	(0xe  << 2)
>>> +#define DMC_MON_G12_TIMER		(0xf  << 2)
>>>    /* Each bit represent a axi line */
>>>    PMU_FORMAT_ATTR(event, "config:0-7");
>>
>>
>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>>
>> Will, I've applied DT patches 1 & 2, can you apply this one via your fixes tree for v6.3 ?
> 
> If you're sending the DT patches as fixes, you may as well just take this
> driver change at the same time with my ack:
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> Does that work for you?

Perfect ! Thx I'll pick it with the DT patches.

Thanks,
Neil

> 
> Will

