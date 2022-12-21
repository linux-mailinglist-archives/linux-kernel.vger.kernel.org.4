Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC96652F90
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 11:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbiLUKfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 05:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiLUKe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 05:34:28 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703C5EE1C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 02:33:10 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id s25so15193381lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 02:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tND8dMZ4UYN1tPgLmPx53SiIZZIqD2HEaBgLp/G2TeM=;
        b=UnSlf9Rhd8aRFFkqHiDrBj0ry1RguPMiz9Lv3xMQh2JPGHHvjOoLjolz8OHwK3FJOF
         KH8/9UiOtHq+1xys5RZGTubjWv1XIxq99OC+KdUKw/FNrkRpeYDWdWa8CC7Lj0i44gcr
         enmAnd2tr48Z6TD7P13KK7PovTdF45jYLHtqnwaGReb5SE4wN5DiOMXHO2/7/iKmDze+
         bWLchDN30mwJwnDCwmmTL84x5TPKN+LnOvvlpSsi3rKzTvebFKg4xc+jMFNP5I/ja2K2
         w+p8/skyt1gTlQAG69dXxeZqC5W5remmcRTrPKIjX2yXfZvmigCj8aX/P2ohE9+rEIJk
         Ucaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tND8dMZ4UYN1tPgLmPx53SiIZZIqD2HEaBgLp/G2TeM=;
        b=pEeAH4omhS7FDQCduHCcLfe1gtbXcyTJGXde1yZoLbNsbFeFsFSdA+5UWcXWpVo1Ii
         Hb+yiiiNPLWjbjhumm/RnMlG91VsdHq7U1WdxNQO0jLT9mUvSGXYYMo1XaYaDHTcOcxY
         A1bVh1M06ZoCmgWAtM0WY7PigTdN0ZE+xLFa3ncu5Ioen8GbDDHu5/rJwmXExAymNagT
         3dD9eeTYqtu/u22sRlHeOi0KUg27l69s97XUrIx4X0etVjpYus1l2RQDFZPYPHnz6g6r
         Xyf4SwnD9d335SnwHcMbypZiWauOuIt9yPD6qr+qVb5jHgDDoQ8+Tsi7SWO2ctJaX/H0
         fRGg==
X-Gm-Message-State: AFqh2koDhpq1DSecPHoiKEcc9f6NfRX1PHyRy8mijOCI0ExBf9+AAJy7
        AT6Ck3hO3mnzSXmrIhxiJVtqnw==
X-Google-Smtp-Source: AMrXdXsJHVlkkI/BZHuiAvMoxQ5LOirVOUmT+bS3Zi3OPHcp+nkbM/OQR/hoQziwvFLBBAqVlRnbvQ==
X-Received: by 2002:a2e:8652:0:b0:279:bd34:dcd7 with SMTP id i18-20020a2e8652000000b00279bd34dcd7mr448734ljj.48.1671618788767;
        Wed, 21 Dec 2022 02:33:08 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v15-20020a2ea44f000000b0027f792ed10fsm1046801ljn.134.2022.12.21.02.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 02:33:08 -0800 (PST)
Message-ID: <403b0310-070f-1ecc-2188-95c22859bae1@linaro.org>
Date:   Wed, 21 Dec 2022 11:33:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 5/6] dt-bindings: arm: mediatek: Add missing
 power-domains property
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ikjoon Jang <ikjn@chromium.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>
References: <20221221034407.19605-1-allen-kh.cheng@mediatek.com>
 <20221221034407.19605-6-allen-kh.cheng@mediatek.com>
 <ec927229-cf03-136c-5629-22719110313a@collabora.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ec927229-cf03-136c-5629-22719110313a@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2022 11:22, AngeloGioacchino Del Regno wrote:
> Il 21/12/22 04:44, Allen-KH Cheng ha scritto:
>> The "mediatek,mt8192-scp_adsp" binding requires a power domain to be
>> specified.
>>
>> Fixes: 4a803990aeb1 ("dt-bindings: ARM: Mediatek: Add new document bindings of MT8192 clock")
>> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
>> ---
>>   .../arm/mediatek/mediatek,mt8192-clock.yaml     | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
>> index b57cc2e69efb..ce8dd2bfb533 100644
>> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
>> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
>> @@ -40,6 +40,9 @@ properties:
>>     reg:
>>       maxItems: 1
>>   
>> +  power-domains:
>> +    maxItems: 1
>> +
>>     '#clock-cells':
>>       const: 1
>>   
>> @@ -47,13 +50,27 @@ required:
>>     - compatible
>>     - reg
>>   
>> +allOf:
> 
> allOf is unnecessary here.

If you mean that "if:" can be without it, then it is better to have
allOf. It grows often, so you avoid useless indentation change later.


Best regards,
Krzysztof

