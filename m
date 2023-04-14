Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BD86E20CA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDNKbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjDNKbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:31:32 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0908CE57
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:31:31 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-504efe702d5so2047795a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681468289; x=1684060289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7A3jIFNX+D4elFTnhiKETmy1MLNeTbEEPtotnHqMGuQ=;
        b=ef8OHhmk/2tUpsrGW9BAs7ADG0qRkLcn6YKfX7e8PuFF8mPfZpawfAzggGfU432iXb
         CELESl9USoOKfAs7NQZKaf94BEN9o75rea8wrdalwVcBzwCVMxS4kko1MSgWw1yLfGhl
         UgW1E3kQAzdKOOUH8hSIwoZbk4iZO3+xbtQo8+gLc0she+IgxiyseuFCePqqBtwyhsh2
         Nl9lpxH3b73x8blbg5KJkcBBOS82RXTqHNgGG988oaRjZBjEVZZSINXDqTYbRDfNMSFq
         0M0nBwdhl3O3dApDGXn2EW+zEC5rg2vr4k6dGFkmCb5qNEipvzeEdzkbcDfTMU4fxN4W
         FChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681468289; x=1684060289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7A3jIFNX+D4elFTnhiKETmy1MLNeTbEEPtotnHqMGuQ=;
        b=XhJDxKPrfYDb7KtLb5Cs9T8FvZJ4bjoOndvB9JEx1W8hdZyKWGSxdRbE9xq3o1dIQc
         JGG5NFO8l/g1IFoOYlKpiNwy/WvpoqJMgKTpRXaj0cajk9dzVso5nFqdxjIQ8T/AjMLo
         fZvShPsnyMzlh13lvK4SEh4qpbXkgtc3svgUTfyXVasrGD8m91YH58s4exnIRZ6/HL5p
         C1qDtBSUZfBRSBZz4PKeiYvQPRbub7FpdsRZVZ1v5O0sU9y5u8Z+knNyBcmuXbwvIU4I
         bRuVEURe8l0PW/1J6rji4w/Lnfu/DVsN2F85MV2leXak2KJtiyXC4zZcaPBUNYj7cZVJ
         Glrg==
X-Gm-Message-State: AAQBX9cbx3gQtPuWiAK+ulRIkvBJRrl+7BPkvtsmI17uxi11olfvXMrc
        +LQSGMGWDJelA57XnvwGcXhn1g==
X-Google-Smtp-Source: AKy350Y077+BdBXdq1CcDQ8qonO9EVH5kYn/JqjMAYJj03p/5Gq3PVCVakbTgw4OSubyrs08ItiJ+A==
X-Received: by 2002:aa7:df0d:0:b0:4fd:29e4:ccfe with SMTP id c13-20020aa7df0d000000b004fd29e4ccfemr5082786edy.18.1681468289362;
        Fri, 14 Apr 2023 03:31:29 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:40b9:8c57:b112:651d? ([2a02:810d:15c0:828:40b9:8c57:b112:651d])
        by smtp.gmail.com with ESMTPSA id x9-20020aa7d6c9000000b004fa19f5ba99sm1957986edr.79.2023.04.14.03.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 03:31:28 -0700 (PDT)
Message-ID: <e7db1133-b23c-f196-547c-9deea94f0bfe@linaro.org>
Date:   Fri, 14 Apr 2023 12:31:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 01/27] dt-bindings: pwm: Add compatible for MediaTek
 MT6795
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     matthias.bgg@gmail.com, p.zabel@pengutronix.de, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        chunfeng.yun@mediatek.com, vkoul@kernel.org, kishon@kernel.org,
        thierry.reding@gmail.com, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, jitao.shi@mediatek.com,
        xinlei.lee@mediatek.com, houlong.wei@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@collabora.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-2-angelogioacchino.delregno@collabora.com>
 <aaeeb18d-f8e8-d6c1-1272-e5b797554b9e@linaro.org>
 <20230414083019.cpomx37tax4ibe5u@pengutronix.de>
 <f8a4fd52-52b6-dded-c8b7-864be549e2ad@linaro.org>
 <13fe3e54-caa5-098c-0a86-3d2f8475c23f@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <13fe3e54-caa5-098c-0a86-3d2f8475c23f@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 12:25, AngeloGioacchino Del Regno wrote:
> Il 14/04/23 10:34, Krzysztof Kozlowski ha scritto:
>> On 14/04/2023 10:30, Uwe Kleine-König wrote:
>>> On Fri, Apr 14, 2023 at 10:21:05AM +0200, Krzysztof Kozlowski wrote:
>>>> On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
>>>>> Add a compatible string for MediaTek Helio X10 MT6795's display PWM
>>>>> block: this is the same as MT8173.
>>>>>
>>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>>> ---
>>>>>   Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 4 +++-
>>>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
>>>>> index 0088bc8e7c54..153e146df7d4 100644
>>>>> --- a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
>>>>> +++ b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
>>>>> @@ -22,7 +22,9 @@ properties:
>>>>>             - mediatek,mt8173-disp-pwm
>>>>>             - mediatek,mt8183-disp-pwm
>>>>>         - items:
>>>>> -          - const: mediatek,mt8167-disp-pwm
>>>>> +          - enum:
>>>>> +              - mediatek,mt6795-disp-pwm
>>>>> +              - mediatek,mt8167-disp-pwm
>>>>
>>>> This does not look correct. You do not add compatible, you replace
>>>> breaking all mt8167-disp-pwm. At least it looks like this from context.
>>>
>>> I thought the old semantic to be:
>>>
>>> 	"mediatek,mt8167-disp-pwm"
>>>
>>> and the new
>>>
>>> 	"mediatek,mt6795-disp-pwm" or "mediatek,mt8167-disp-pwm"
>>>
>>> . What am I missing?
>>
>> The new is ok for mt6795 but it is not valid for mt8167.
>>
> 
> Sorry, why is it not valid for MT8167?

Eh, above example did not help me, because it missed mt8173, but I see
now the context I missed. It's already a list of two compatibles, so the
patch is fine.

Best regards,
Krzysztof

