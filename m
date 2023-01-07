Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8EB660F0B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 14:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjAGNXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 08:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjAGNXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 08:23:14 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F0D57932
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 05:23:13 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id m7so3622606wrn.10
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 05:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K4D1FN6eoWh6/baEX5q5IhUe1DAOLv2u6UT+9a6+KXo=;
        b=HgVvj6Lvf1kT1S13QgbEY1hX2YQIt4Tg9f9o4ln/tSbFzVvqrgAL5tc5bGWpL/MQ0S
         rEUEVMJm1tuGubqk6C4J3rM45jhvhgA4OwhmTSmryJPzK0S1v966jXX12NVUfCA0OguR
         l9EhZElZa2ofhVzsxP/tokGHCBF76PuLWmVENy2nBmp465JyPZsxZ7kF9OmKiCqfxM5s
         utv7fWq6azCoC2Uy5BnP89PM18Cq4HF/E3EUa5Z7f/IcVnx4AF4uJ1T1E/1jFbnI0JOf
         uVwdfaylqR+BRIylcqDHxFA9+IK8qOZe8fir4opy9T9JbMMmrqF+DF2IfDCKd+ldYFJ4
         A74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4D1FN6eoWh6/baEX5q5IhUe1DAOLv2u6UT+9a6+KXo=;
        b=USFrtBikFMWy6l4n5L4BZXW/5eIv9RbBohlKEpyIrV0PutYwc1AE5HxJ1CiDliuBhl
         sCjdFT+bguiPKN7+MBk4c05sqdEn4uZZtS4NCcuxd3gbvIwpVO1z2mWg0VZyRX3c4nTM
         ol/CKRbPCK56lFpIHXOIjmyxBXvO7llRMw6TWTw2VA0DGMgDM4gVM9n0mtvj4S0n5tB/
         alMEabIgi80nIhEPz7/5vSNLV86sCkWYAkE4BbnPb+sSgcZGFFMo43ygGkCyzxKzXwM2
         8AazMZ6dfhUAODDDSVScrRxmheUoHsddCPiTyHxCmcDP8ptBvlJYCfDyLZyppPDTQsOR
         9aHw==
X-Gm-Message-State: AFqh2koimh/42w3qZONlcahgtTeRwc82oVunXARmZ5QfNUvKMNinbHf3
        soWMtNzXAWsd5LsIjgqK83VSZA==
X-Google-Smtp-Source: AMrXdXt8rJ+gmrzzwuVyvcafa8P6rsX9w8GvR+yJ3ia+IO6yFnBWk/w5pE1qGkuFyw8Ftqd6qRyj7w==
X-Received: by 2002:a05:6000:1566:b0:242:2b3c:c7e with SMTP id 6-20020a056000156600b002422b3c0c7emr53021473wrz.17.1673097791738;
        Sat, 07 Jan 2023 05:23:11 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s1-20020a5d4ec1000000b002882600e8a0sm3973599wrv.12.2023.01.07.05.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jan 2023 05:23:10 -0800 (PST)
Message-ID: <967cc7b7-f0bb-de37-52b9-7bfab05eadd7@linaro.org>
Date:   Sat, 7 Jan 2023 14:23:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: allow more compatible
 combinations
Content-Language: en-US
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230105213856.1828360-1-andreas@kemnade.info>
 <d7c407dc-0a6c-97d5-a06f-b432a923d74d@linaro.org>
 <20230106203358.14878660@aktux>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230106203358.14878660@aktux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2023 20:33, Andreas Kemnade wrote:
> On Fri, 6 Jan 2023 09:41:01 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 05/01/2023 22:38, Andreas Kemnade wrote:
>>> Currently make dtbs_check shows lots of errors because imx*.dtsi does
>>> not use single compatibles but combinations of them.
>>> Allow all the combinations used there.
>>>
>>> Patches fixing the dtsi files according to binding documentation were
>>> submitted multiple times and are commonly rejected, so relax the rules.
>>> Example:
>>> https://lore.kernel.org/linux-devicetree/72e1194e10ccb4f87aed96265114f0963e805092.camel@pengutronix.de/
>>>
>>> Reason: compatibility of new dtbs with old kernels or bootloaders.
>>>
>>> This will significantly reduce noise on make dtbs_check.
>>>
>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>>> ---
>>>  .../bindings/mmc/fsl-imx-esdhc.yaml           | 24 +++++++++++++++++++
>>>  1 file changed, 24 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
>>> index dc6256f04b42..118ebb75f136 100644
>>> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
>>> @@ -37,6 +37,30 @@ properties:
>>>            - fsl,imx8mm-usdhc
>>>            - fsl,imxrt1050-usdhc
>>>            - nxp,s32g2-usdhc  
>>
>> You must drop the items from enum above. Binding saying:
>> compatible="A"
>> or:
>> compatible="A", "B"
>>
>> is not correct. Either A is or is not compatible with B.
>>
> hmm, here we have A = B + some additional features
> or
> A = B + some additional features and additional quirks required.

So why do you allow A alone?

> 
> For the latter we have e.g.
> A=
> static const struct esdhc_soc_data usdhc_imx6sx_data = {
>         .flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>                         | ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>                         | ESDHC_FLAG_STATE_LOST_IN_LPMODE
>                         | ESDHC_FLAG_BROKEN_AUTO_CMD23,
> };
> B=
> static const struct esdhc_soc_data usdhc_imx6sl_data = {
>         .flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>                         | ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_ERR004536
>                         | ESDHC_FLAG_HS200
>                         | ESDHC_FLAG_BROKEN_AUTO_CMD23,
> };
> 
> so there is the difference in ESDHC_FLAG_STATE_LOST_IN_LPMODE.
> That might make no difference in some usage scenario (e.g. some bootloader
> not doing any LPMODE), but I wonder why
> we need to *enforce* specifying such half-compatible things.

I asked to remove half-compatible. Not to enforce.

Best regards,
Krzysztof

