Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB85674004
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjASRdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjASRdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:33:40 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDDC4742E;
        Thu, 19 Jan 2023 09:33:36 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so1821645wms.2;
        Thu, 19 Jan 2023 09:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HRkHxltOADy9ynfqvAg9dqzLPh81gN0Pd9b3KEsiRcI=;
        b=pGwcN8w2cNHtPOjLhb/xHdlexc8kF1Umz+hd6UPmihuPQ4CJlyjDxot5gJT6uZoL15
         EXEIikiO4T4xVDbPMpcFMFqGtxm9/cSYmGC3iSSKzwpRwTwQb4NuvpRYy4uAjUrrhT8E
         CZDi5r6xOu+KgIT/93EGOtrNFI7jCDGZEyH+1ZxmfuR2Har04fhiXFfcfo9FP0ni18zs
         AABofBkOysQnILml+tMmEneuD6doMu2yZAOrj3H0J3lTMImIUVivnuYInSLiZfoPxmg4
         3Dbw8D1rzxRIjbQuX9495G8tmsmbnADmD1tk5wRRIXnbFWvC3PDAuiq5JCLpFlh79+8q
         3PUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HRkHxltOADy9ynfqvAg9dqzLPh81gN0Pd9b3KEsiRcI=;
        b=oGgyBbyLGRk1yT4riubUIqzatZdqh3Q0TzC0NIh/qQmRHZDBrZZraqFwQf3W5Ags8W
         yQ6drDetYcaTbzA936iyyN5ePJseGJNiSey0H5S5HEGSqVzLRN/DODjALmkEtlRXRcB0
         XIIjQhNwNW5ZE2ya35Pb7qWSO8tMdBKc5+3V5ifUpjOvdjeU5AEuUmExZwHT5vC7XRQw
         u8F9AbtKFqxEvDKF7fg/aLZbCcXy+KKgSAMjvna/ho/JYvVIoq5L4za0BB7SgqU9v4fU
         UTJgiJXdb+n+WMv34ViaQd0RYvpXiI3QK9F0ldGW0SKxee+5LtxHSlVlFWnVaVPecxcv
         TBrQ==
X-Gm-Message-State: AFqh2kprSBJZq3D2qkbKbxLU6U/c72zSc+dsZQXsJDlzcxPX1wg+mCZS
        LqoLfx+mgx2lueAgJXMtHMfVLhrw5U9OQg==
X-Google-Smtp-Source: AMrXdXv2+4MHflMXeHtA9NOmShcNOhoq7h9Pm3HghF12eXjmubTmiKbdJIrzRJazNaZnB8yCo/n5tg==
X-Received: by 2002:a05:600c:198c:b0:3db:392:ecee with SMTP id t12-20020a05600c198c00b003db0392eceemr7141224wmq.31.1674149614566;
        Thu, 19 Jan 2023 09:33:34 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id f24-20020a05600c491800b003db0ad636d1sm4995466wmp.28.2023.01.19.09.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 09:33:34 -0800 (PST)
Message-ID: <fe2e5a9c-2505-5a95-d65a-bac387f4ea71@gmail.com>
Date:   Thu, 19 Jan 2023 18:33:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 1/2] arm64: dts: mediatek: mt7622: Add missing
 pwm-cells to pwm node
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        thierry.reding@gmail.com, krzysztof.kozlowski+dt@linaro.org
Cc:     robh+dt@kernel.org, john@phrozen.org, sean.wang@mediatek.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20221128112028.58021-1-angelogioacchino.delregno@collabora.com>
 <20221128112028.58021-2-angelogioacchino.delregno@collabora.com>
 <20221202180932.5k3vymrwds5ssivq@pengutronix.de>
 <20230117213919.56cl74ffxzdpdcgp@pengutronix.de>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230117213919.56cl74ffxzdpdcgp@pengutronix.de>
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



On 17/01/2023 22:39, Uwe Kleine-König wrote:
> Hello,
> 
> On Fri, Dec 02, 2022 at 07:09:32PM +0100, Uwe Kleine-König wrote:
>> On Mon, Nov 28, 2022 at 12:20:27PM +0100, AngeloGioacchino Del Regno wrote:
>>> Specify #pwm-cells on pwm@11006000 to make it actually usable.
>>>
>>> Fixes: ae457b7679c4 ("arm64: dts: mt7622: add SoC and peripheral related device nodes")
>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>> ---
>>>   arch/arm64/boot/dts/mediatek/mt7622.dtsi | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
>>> index 146e18b5b1f4..f321c6d0fd7c 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
>>> @@ -435,6 +435,7 @@ uart3: serial@11005000 {
>>>   	pwm: pwm@11006000 {
>>>   		compatible = "mediatek,mt7622-pwm";
>>>   		reg = <0 0x11006000 0 0x1000>;
>>> +		#pwm-cells = <2>;
>>
>> 3 should be possible, too. The driver does only support one
>> polarity, so it's not really needed, but would be nice for consistency?
>>
>> Thierry, what's your take here?
>>
>> Other than that: Who would pick this up, I assume it to go via an ARM
>> tree together with the 2nd patch in this series?

The DT patch should go through my tree once all questions are answered and the 
dt-binding patch got accpeted by PWM maintainer.

Regards,
Matthias

> 
> The questions here are still open and both patches unapplied. :-\
> 
> Best regards
> Uwe
> 
