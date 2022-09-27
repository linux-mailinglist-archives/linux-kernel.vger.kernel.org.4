Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8001D5EC629
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbiI0Oci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiI0OcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:32:08 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7352F5C9ED
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:31:49 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j16so16043099lfg.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=NUfI4SCRisddpR+Mrk1Ab5N6zdnsa7HpNGyqDE8S3Ak=;
        b=N5H3PvxU0f/K1m+Ie5ZB11BDUfHM5/7rmKTWERCI16RPnFP93poTMnQCJcmimNQyb+
         iM26D7OsLJcsmOZU/xMHANBiDKZIn9q2gs+chOxXtKyJdRoM3jcDS5xdhCqh3NMrfRvl
         d4IWDb/pXsaeTkuCa9br1kfnKDF0YN9oUcBRFQWU75t855LH3pbtJP9ynWm4chBxGG+z
         6dailbrZEc3YIZTVHATQ5QYGCP/Jr9uNtyCEmGyO7YdW7A+jIrhldXH2mH7IJvdPcHDI
         n9XprOk48xR/fUdkCmm9j3V13OUbMExg0fBRQ2uf4Tl6H1UI5g9KWgvQc3JkKwQP3qBL
         L0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=NUfI4SCRisddpR+Mrk1Ab5N6zdnsa7HpNGyqDE8S3Ak=;
        b=ZxFKFCPj9YBIl8BB+un60FKjT7XIkFiMgpq2FJzNcYy0GpLDEokeEjggOZKkaBDlJH
         HLDWqQ2dQMPqC0247PUMvjsdje6vDVZ7txWMfQOOe4i19QxTzMlYwuS5ZS8LglsJzDa6
         r2VHXjtEuwrzo0iL23w9TCHBBhXuCkIwyW7HJOE3XldPte0LXQ0f56vyunpW6lDwP3ou
         MhNTEg+iBS+wr5hjsVxr9P+73HENxyJ+ob+eHFVeQkW/50yWVuC/LhOrvk/C5wC0AsNz
         baTaPJJl8Nrvlun9NAqNL0JuqeXbB2rz5Q1C9xIDj9cjauPOCkUuumi6/USPcDUZULZH
         AcEQ==
X-Gm-Message-State: ACrzQf3JS1cGdRlFegwEYmu+CEuEIa0sdQbjE1gYGzvEl2EygpOTJ87f
        LwvApBry7rmOTp1/G7Uhs2V6UQ==
X-Google-Smtp-Source: AMsMyM45aqxVkdxZ0HAqRVzU94fLrEHMjS4h00CZmLSIcK6DvgMURloYNRLEY0p/VovPPWPqX6uRGg==
X-Received: by 2002:a05:6512:39ca:b0:497:a0b6:449c with SMTP id k10-20020a05651239ca00b00497a0b6449cmr10908608lfu.308.1664289107724;
        Tue, 27 Sep 2022 07:31:47 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z40-20020a2ebe28000000b0026c2fec2f8esm176975ljq.84.2022.09.27.07.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 07:31:39 -0700 (PDT)
Message-ID: <db8ec605-7038-4cd1-9e70-bbe40404fa06@linaro.org>
Date:   Tue, 27 Sep 2022 16:31:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 04/17] dt-bindings: display: mediatek: add MT8195 hdmi
 bindings
Content-Language: en-US
To:     Guillaume Ranquet <granquet@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Pablo Sun <pablo.sun@mediatek.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org
References: <20220919-v1-0-4844816c9808@baylibre.com>
 <20220919-v1-4-4844816c9808@baylibre.com>
 <260bb17f-efc8-1287-3e03-f9b8e79a6e31@linaro.org>
 <CABnWg9vifOaAgwr7tkELUqbQA_1f-FfMFZ9o7sjZCaneo_FUmw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CABnWg9vifOaAgwr7tkELUqbQA_1f-FfMFZ9o7sjZCaneo_FUmw@mail.gmail.com>
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

On 27/09/2022 15:54, Guillaume Ranquet wrote:
> On Thu, 22 Sep 2022 09:18, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> On 19/09/2022 18:56, Guillaume Ranquet wrote:
>>> Add mt8195 SoC bindings for hdmi and hdmi-ddc
>>>
>>> Make port1 optional for mt8195 as it only supports HDMI tx for now.
>>> Requires a ddc-i2c-bus phandle.
>>> Requires a power-domains phandle.
>>>
>>> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml
>>> index bdaf0b51e68c..abb231a0694b 100644
>>> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml
>>> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml
>>> @@ -21,6 +21,10 @@ properties:
>>>        - mediatek,mt7623-hdmi
>>>        - mediatek,mt8167-hdmi
>>>        - mediatek,mt8173-hdmi
>>> +      - mediatek,mt8195-hdmi
>>> +
>>> +  clocks: true
>>> +  clock-names: true
>>
>> ????
>> Why is this moved?
>>
>>>
>>>    reg:
>>>      maxItems: 1
>>> @@ -28,20 +32,6 @@ properties:
>>>    interrupts:
>>>      maxItems: 1
>>>
>>> -  clocks:
>>> -    items:
>>> -      - description: Pixel Clock
>>> -      - description: HDMI PLL
>>> -      - description: Bit Clock
>>> -      - description: S/PDIF Clock
>>> -
>>> -  clock-names:
>>> -    items:
>>> -      - const: pixel
>>> -      - const: pll
>>> -      - const: bclk
>>> -      - const: spdif
>>
>> Clock definition with constraints should stay here. You just customize
>> it per variant.
>>
> Clocks are different between the two hardwares, so I've tried moving everything
> inside the if/else block.
> 
> Is there a better way to express this?

https://elixir.bootlin.com/linux/v5.19-rc6/source/Documentation/devicetree/bindings/clock/samsung,exynos7-clock.yaml#L38

Best regards,
Krzysztof

