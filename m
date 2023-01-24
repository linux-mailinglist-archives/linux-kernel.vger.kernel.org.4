Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFEB67947C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 10:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbjAXJrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 04:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbjAXJrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 04:47:07 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0D7298DE
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 01:47:03 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id mp20so37396807ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 01:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o3C7ldfBLXi3hXV4pFxelnt9/f5/V65vBB6BlKhSBWo=;
        b=vLssLMT4y6tEvIBNnOhKtr/5zWkvVXyRJP+9aaSDN6O2U6fs/2iq2yUgCPeRB+9tI6
         STLILc0aeIUuUz7z+vvieHWuoSdOFuMRo2Zsow6OxemIZVz07/anY4vhscPyCtprpR/z
         P7xKxvMwSAFWEyYVzBE7LQxhu6tYCwHFP+YnV7diYDLT3sRDOihIQcoM7BiivXNCEhMB
         FF7P1hNjuDfI0Q0F2jDATqcspHylbaArM8NlI806wR9FXqmzsUpm0KiXwWrnzGvPzagG
         AqmnlG2Cad0DwURv3hFJyp3WmyKb6mjhI+NSG8eVaWTBgFFoC7wRUTVQsg3zJSXsuGMe
         PiTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o3C7ldfBLXi3hXV4pFxelnt9/f5/V65vBB6BlKhSBWo=;
        b=VdTdtdtrT1ND1FUrl3D0YKtK2ccQfYMpKJEwGyrciPNZTljktVyekUPgbFN2GOBNF+
         +Z0Wu2JiwWhJWKgMRWE/pWGFLffirdCOos1Ns7wIgNnBCauhX6hBhqLVNrhB7cv5BRWj
         5+grlUHC5MBXwYAndmqd4EcZJYC4Udrqrrf7wmw6k7wZW1dB9Oz4zvF2wx1k2T2Zs17r
         WtyXQx+CSBjxhzBVKJnkNSFXwcljwjheozAm9ukYPg/85XcR2g4sr3p+zEmuf7x2lz8Q
         lcpm6t8A4Z6KA+3rnDg/ri+f6ImJzNlyfuVoG5W3mW/oGU0u0RzJ6IQTMDMeJmzGUWsa
         ZH4Q==
X-Gm-Message-State: AFqh2krvjU2BFTjgnaBZmswhQ5B4e6Dl+dEb/0cVoCV/rHeZoukcGAOq
        2qS4ukIw4rqsQhKdhjc9poIeRg==
X-Google-Smtp-Source: AMrXdXvhjbo2HrIxrdYnwU06J+8+ObBkI8rZsJ/LqpLKOO0lnDbsUQqvpp/dJKYckxFL/7ABOmr1YQ==
X-Received: by 2002:a17:906:9f1f:b0:871:d59d:4f54 with SMTP id fy31-20020a1709069f1f00b00871d59d4f54mr29773166ejc.27.1674553621588;
        Tue, 24 Jan 2023 01:47:01 -0800 (PST)
Received: from [192.168.1.101] (abyl109.neoplus.adsl.tpnet.pl. [83.9.31.109])
        by smtp.gmail.com with ESMTPSA id w1-20020a170906480100b0080c433a9eeesm637395ejq.182.2023.01.24.01.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 01:47:01 -0800 (PST)
Message-ID: <675ed9f7-da31-6206-5089-1db22025ef4b@linaro.org>
Date:   Tue, 24 Jan 2023 10:46:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 6/7] arm64: dts: Add ipq9574 SoC and AL02 board support
To:     Devi Priya <quic_devipriy@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, tdas@codeaurora.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
References: <20230110121316.24892-1-quic_devipriy@quicinc.com>
 <20230110121316.24892-7-quic_devipriy@quicinc.com>
 <f6ef1834-b629-b76c-9cde-55af56320665@linaro.org>
 <7f157b73-f856-04d2-1b39-e1f8861d0439@quicinc.com>
 <84aa79c3-b793-0d0e-d6a5-035aff5a17b4@linaro.org>
 <278a2e6e-69e0-81b0-f476-571edea950ff@quicinc.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <278a2e6e-69e0-81b0-f476-571edea950ff@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.01.2023 08:19, Devi Priya wrote:
> 
> 
> On 1/13/2023 7:50 PM, Krzysztof Kozlowski wrote:
>> On 13/01/2023 14:29, Devi Priya wrote:
>>>>> +
>>>>> +    soc: soc@0 {
>>>>> +        #address-cells = <1>;
>>>>> +        #size-cells = <1>;
>>>>> +        ranges = <0 0 0 0xffffffff>;
>>>>> +        compatible = "simple-bus";
>>>>> +
>>>>> +        tlmm: pinctrl@1000000 {
>>>>> +            compatible = "qcom,ipq9574-tlmm";
>>>>> +            reg = <0x01000000 0x300000>;
>>>>> +            interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>>>>> +            gpio-controller;
>>>>> +            #gpio-cells = <2>;
>>>>> +            gpio-ranges = <&tlmm 0 0 65>;
>>>>> +            gpio-reserved-ranges = <59 1>;
>>>>
>>>> Hm, why reserved ranges are in SoC?
>>> As the gpio is forbidden on all ipq9574 boards, we have added it in SoC
>>
>> Why it is forbidden on all boards? I guess it depends on the firmware
>> and this can differ, can't it?
>>
> This GPIO is protected and used by the TZ firmware and is forbidden on all the boards & firmware
If it's protected on *all* boards and *all* firmwares (for any
good reason that you probably have internally), perhaps it
would be better to describe it in the .c driver.. wdyt?

Konrad
>> Best regards,
>> Krzysztof
>>
> Regards,
> Devi Priya
