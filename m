Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206385F6B01
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 17:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiJFPs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 11:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiJFPsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 11:48:54 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31CFFD23
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 08:48:52 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bk15so3308288wrb.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 08:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=+3zPXnpnurVqkyWfh7imcEmKL4InpVj2u33K45eRBbc=;
        b=IoWihUEwnpnTLnpHQHHxLiTKyV5QPuNS6PCBEKsl6ZrLL3RofTtoyfmOlSYH9ok1TD
         L+ADNRSC2g7EfFev6QLgV2hFhbPHPqfCLFjivFtejVfszLS5rCZiMCAfVa+SPtYYgimV
         ezvCd+rBuhbwsoRzz5b9HahwwEfr7lMFepXdK+l+30H2E8Ervyh811Ls18ET+Jy4gu4n
         mpAq+tDaJ91UL1xwXentpVhNtRnL5RriVsyLlXxdtwc8+Ls0Qr0f96+iQDo4hpSt5wgm
         CC63L8xRZfBdsZQZbo5HtpirZG/1jdcu/qfQcx4Fq14mJNuQLaqblzmVQUgTJLD2oOiZ
         Jvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=+3zPXnpnurVqkyWfh7imcEmKL4InpVj2u33K45eRBbc=;
        b=oWDpVK8LuU3e3XAJNGPK3cQ0zUvkQSfydW2XwcahCcn5aEaBwYvjYVez9T2EuNjbj1
         QsSEtxjGNN4wr5DHN4hzmcfVDoKLzjOhXtzG0WRR53hj5dlDTGco6XmOwTn9HWJq+I7/
         N6f5YI4jM0rpDuagq2UTI8WJ2Y93zJR09w0Q230DFjmK2WijbOiIVCCrXtPNww1COw40
         3Q9zG/wR5XuCXAQttkRmrqkZBih9WoxhFU/GRe/vAshFedR0LAnC6Segtg2qdpnRGjiX
         kHgzVJg2jd7mUKTw/jWC9egHBnIJ/z+wnT24tbV7SYNTbeUUc9BYz090pxdiaW57oifm
         uQEA==
X-Gm-Message-State: ACrzQf3x1Qaz5AM5kIKaDmGvH9W9aJ1SAxpSLdenwvMmuqm3CmYC8fzv
        fUI7m7byq1fPDOy/SVi23LWLBQ==
X-Google-Smtp-Source: AMsMyM5l/VXA+U+pVwucM15R2+ysEwIQb1CUvCAdfzFaI6nIzUDdNI8kxERgz563HumDXD6XBsebmw==
X-Received: by 2002:a5d:6d07:0:b0:22a:3f21:3b56 with SMTP id e7-20020a5d6d07000000b0022a3f213b56mr383272wrq.679.1665071331331;
        Thu, 06 Oct 2022 08:48:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e032:72ae:542:774? ([2a01:e0a:982:cbb0:e032:72ae:542:774])
        by smtp.gmail.com with ESMTPSA id bh9-20020a05600005c900b0022ccbc7efb5sm18696153wrb.73.2022.10.06.08.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 08:48:50 -0700 (PDT)
Message-ID: <2c22e3b9-3da4-78c4-e068-78b84e24b2c3@linaro.org>
Date:   Thu, 6 Oct 2022 17:48:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/2] spi: dt-bindings: amlogic, meson-gx-spicc: Add
 pinctrl names for SPI signal states
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Da Xue <da@libre.computer>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221004-up-aml-fix-spi-v2-0-3e8ae91a1925@baylibre.com>
 <20221004-up-aml-fix-spi-v2-1-3e8ae91a1925@baylibre.com>
 <d2ce98d7-1025-9c6e-e207-00e91942077a@linaro.org>
 <fb2706e3-f758-a0b0-d595-75ef362a853e@baylibre.com>
 <7bcb9ef1-6b56-2f5f-3ac9-acc9ed9370df@linaro.org>
Content-Language: en-US
Organization: Linaro Developer Services
In-Reply-To: <7bcb9ef1-6b56-2f5f-3ac9-acc9ed9370df@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2022 16:11, Krzysztof Kozlowski wrote:
> On 06/10/2022 12:57, Amjad Ouled-Ameur wrote:
>> Hi Krzysztof,
>>
>> Thank you for the review.
>>
>> On 10/5/22 10:14, Krzysztof Kozlowski wrote:
>>> On 04/10/2022 13:10, Amjad Ouled-Ameur wrote:
>>>> SPI pins of the SPICC Controller in Meson-GX needs to be controlled by
>>>> pin biais when idle. Therefore define three pinctrl names:
>>>> - default: SPI pins are controlled by spi function.
>>>> - idle-high: SCLK pin is pulled-up, but MOSI/MISO are still controlled
>>>> by spi function.
>>>> - idle-low: SCLK pin is pulled-down, but MOSI/MISO are still controlled
>>>> by spi function.
>>>>
>>>> Reported-by: Da Xue <da@libre.computer>
>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
>>>> ---
>>>>    .../devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml   | 15 +++++++++++++++
>>>>    1 file changed, 15 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
>>>> index 0c10f7678178..53013e27f507 100644
>>>> --- a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
>>>> +++ b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
>>>> @@ -43,6 +43,14 @@ properties:
>>>>        minItems: 1
>>>>        maxItems: 2
>>>>    
>>>> +  pinctrl-0:
>>>> +    minItems: 1
>>> maxItems?
>>>
>> Will fill it in next version.
>>>> +
>>>> +  pinctrl-1:
>>>> +    maxItems: 1
>>>> +
>>>> +  pinctrl-names: true
>>> Why do you need all these in the bindings?
>>
>> SPI clock bias needs to change at runtime depending on SPI mode, here is an example of
>>
>> how this is supposed to be used ("spi_idle_low_pins" and "spi_idle_low_pins" are defined
>>
>> in the second patch of this series):
> 
> I know what it the point in general of pinctrl configuration... But the
> question is why do you need to specify them in the bindings? Core
> handles that. IOW, do you require them and missing/incomplete pinctrl
> should be reported?

Looking at other bindings, when specific pinctrl state names were requires, they were
documented.

There's some bindings with pinctrl-names for specific states like rockchip/rockchip,dw-hdmi.yaml,
mediatek/mediatek,dpi.yaml, mmc/mtk-sd.yaml or mmc/fsl-imx-esdhc.yaml

Neil


> 
> Best regards,
> Krzysztof
> 

