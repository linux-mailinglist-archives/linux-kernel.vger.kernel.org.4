Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2395EE30C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbiI1R00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiI1R0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:26:20 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4898B93222
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:26:19 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a2so21390974lfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=iaBM0F0vS4egIo+p/65Wr1pcDzd34fHYDBsYt35zuD8=;
        b=Vm5/O2dA7LM9byhTgJjsTEWiTpq6cbx1A7BcdH2Ae3P/5/939CIAvevcFcAWx2icSy
         6sYCxFBqORGn4L0pgWt9/FPWej0Om7OVd3JvMK5qJ/5+cqwxIi5+TFnstDTJ4hcDaOVA
         8Ufz8DMelf4OICaUFMm010gmSIyEpIT9Yd7R63XTZhZ5arbfvpX3wDLscjse15LeVkzB
         2HDjW7GG9p5boYj4CRRGcBvr3yD6qkKI70Zebvlm8O3wH6rrbfRZ8pwI0ueWhNPJmepx
         X7kCeu7k2CMlj4PxYoPEFKCOHT6E5x1IVEV2/nC+W7hYCSP/oc6EfMLdgXaQ/LN5H+m6
         hBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=iaBM0F0vS4egIo+p/65Wr1pcDzd34fHYDBsYt35zuD8=;
        b=yRc+2YWgFaWdvarZXEUeKHidDQXqiCBOpwwNrMwApAM/EZKAzTZeWgsASksWn5s8kW
         RS25ji6DQS12Zv4B/pi8sbEnjZdTXWEUPxQU0e0PzX2sIyUVbdyERiVIdXBoSySjYeG6
         ABAZ85p2Wqbyk2EamWAgrcGJx2K1F3d0JhCdE0S9Uo6ik1H7F+Vqr93tdrdMdfH+kim/
         DkuaiqFXSDJaE7JqbGjMV68DOA2itokmkX+F4WfonqNpyS81wQ8Zeu/Jl0HFfjpkjHyf
         lM+3Kzi+Y0aGd1SMuS2ohT+9SUyIcuKNNJ/dZzhR23osbEF8cUJFyJWV7BvvjfDLYSxC
         aunA==
X-Gm-Message-State: ACrzQf2dCOgwOnVbdLXTzvJ2zTVHS8Fx3lRgS0JcRSrFfeBzp64JgLEE
        yJB33iee2KHVJW9Ghl5W3QC62Q==
X-Google-Smtp-Source: AMsMyM4DHKDdL4v9sepFSeuj5HbhsSN0dN9rFWUBcOnDLKUvgTtOG5lza4guiF8m6cN/mojNElNGkg==
X-Received: by 2002:ac2:4c50:0:b0:49a:3768:da81 with SMTP id o16-20020ac24c50000000b0049a3768da81mr13102942lfk.247.1664385977386;
        Wed, 28 Sep 2022 10:26:17 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id bg40-20020a05651c0ba800b00261e7e7b698sm494329ljb.123.2022.09.28.10.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 10:26:16 -0700 (PDT)
Message-ID: <186bc17e-56d2-f125-aab9-f47bf3f45b79@linaro.org>
Date:   Wed, 28 Sep 2022 19:26:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2] arm64: dts: mt8192: Add vcodec lat and core nodes
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20220926105047.19419-1-allen-kh.cheng@mediatek.com>
 <4d1e8600-f73d-8d2b-2e7a-1b75be7624bd@collabora.com>
 <d71334b63427df73d01ff1b9fa4d2dec94ad9c95.camel@mediatek.com>
 <05ed341b-2db3-620f-7a70-dcebfaa66f1a@collabora.com>
 <172e10ee-22fd-ccec-1a5a-7bd0a29dbfc4@linaro.org>
 <68e1c8b0-04cf-acf8-b6b6-97d9eb8a7c4a@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <68e1c8b0-04cf-acf8-b6b6-97d9eb8a7c4a@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 09:58, AngeloGioacchino Del Regno wrote:
> Il 28/09/22 09:04, Krzysztof Kozlowski ha scritto:
>> On 27/09/2022 12:17, AngeloGioacchino Del Regno wrote:
>>>>>
>>>>
>>>> Sorry, my bad. I alsways run `make dtbs_check` to confirm dtb with
>>>> bindings. I just think we didn't limit node names in mtk-vodec
>>>> bindings. I will pay attention next time.
>>>>
>>>>
>>>> Since currently the vcodec lat and core nodes are absent from the mtk
>>>> dts, do you think the child node name should be changed to something
>>>> more general (ex: video-codec) in mediatek,vcodec-subdev-decoder
>>>> bindings?
>>>
>>> The video codec is mt8192-vcodec-dec, while the other nodes are describing
>>> the VPU instances (and/or vpu cores)... I'm not sure.
>>>
>>> Krzysztof, please, can you give your opinion on that?
>>>
>>
>> What's the difference between them? I understand parent device is entire
>> block of consisting of multiple processing units? If so, video-codec
>> actually could fit in both places. But feel free to call it a bit
>> different (video-codec-core, video-codec-lat, processing-unit, even
>> something less generic). Sometimes it's tricky to find nice name, so I
>> wouldn't worry too much in that case. Just not "mt8192-vcodec" :)
>>
> 
> The parent device is the entire block consisting of multiple processing units
> and has "global" control registers; children are LAT(s) and processing cores.
> 
>  From my understanding, the processing cores are physical cores of one big VPU
> and, depending on the actual (current gen) SoC, the VPU may have one or two
> cores.
> 
> Right now, the bindings want vcodec-latX@addr, vcodec-coreX@addr (where X is
> a number, like vcodec-core0, vcodec-core1) but, in my opinion, changing that
> to video-codec-lat@addr and video-codec-core@addr would be more descriptive.
> 
> ...Or should we simply leave the bindings as they are and just go with the
> abbreviated "vcodec-(hwtype)" names?

video-codec-lat sounds better, but I am not sure if it is worth the
churn, so I am fine with both.

Best regards,
Krzysztof

