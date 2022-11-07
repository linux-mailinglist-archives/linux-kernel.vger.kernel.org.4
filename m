Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2BA61EE07
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiKGJCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiKGJCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:02:02 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D092A12AFA;
        Mon,  7 Nov 2022 01:02:00 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id f5so28245514ejc.5;
        Mon, 07 Nov 2022 01:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cW5LkWgcRlMNKLV3GazkMSxbvLqyy3R2vB1Tb2XIh4k=;
        b=FJtmWIUmERN0XZT6R7B0ZeZ/AZdoSIRjpHX24tLtPg4vmwpC7n0lbmli9A4ArzUdwN
         RjvCoyOzDdt4RlQBTatgdGY6PzoivWqC2mialFJUMEZR5NSiTdXsoazK+js3Gj1H6WDw
         +k/F/62Kt/i1N06Fb8X298f0xqPxepzkyVPnSDqC8u2C94jZP3EA1AkhgwaxmvQa5YCs
         7ArUDSo/AL6n+Wk4itecHmVXWtIuqGgl4fSrDqITk6kj9cDjkyYYFx2tQtmrMXsfCRK/
         5qIp548tPhscmU8YVqrmMb44IcmIzZmNfkrNwM+U3g5Q5N654YFd/xB3sMlL8kt+CAmu
         I0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cW5LkWgcRlMNKLV3GazkMSxbvLqyy3R2vB1Tb2XIh4k=;
        b=GuTeWnFzX2hdN6ji+zMF30NBNQeLpkMe07pzlRsA828hGplEUb7vS7BjuRI35wonUQ
         3H9Ix8pe+TFvvrT+R17wPpnNdwzclZu799XH2IGVBfzFoAnPS6gl0VUCJ+dZxe8GRcw2
         IdC+L2hA2rOpLwoAYOvVYZ4cBfeLn9RVLxaroaTA3ftsKT8bXf2g7JX9c3ACUkP2W706
         U1UVMfElEJieZhmDv4aaxG7w0tIe8UyItaAWyLIz5fTJ9+vI1FfS7/X2g/arz2NR/uVj
         ktBgt5elTks8BZbhnAb+ZyNWLGPRu7hNUMz3xnEKb1648iembeb009pMtyxAlVRu+KfI
         VPqA==
X-Gm-Message-State: ACrzQf1EYeMklbzs6PcmFZvdYRoKjUqnTprdZPVUUU7h6jm6n7ClzYqm
        YG80+9EP5iJFojo36I0OXRA=
X-Google-Smtp-Source: AMsMyM5EN3f0b4ueU4DZk3y/oY0gnVreX+TZQctLnAwmzjUlOuqffd20LFevB1oZ2YD5YFmR7WPWIA==
X-Received: by 2002:a17:907:3f19:b0:7a3:2317:4221 with SMTP id hq25-20020a1709073f1900b007a323174221mr46310466ejc.562.1667811719295;
        Mon, 07 Nov 2022 01:01:59 -0800 (PST)
Received: from [192.168.74.101] ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id k18-20020a05640212d200b0044ef2ac2650sm3793355edx.90.2022.11.07.01.01.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 01:01:58 -0800 (PST)
Message-ID: <fa8450f5-13c5-17b7-a239-768554b150e5@gmail.com>
Date:   Mon, 7 Nov 2022 11:01:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5 8/8] arm64: dts: qcom: sm4250: Add support for
 oneplus-billie2
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20221030094258.486428-1-iskren.chernev@gmail.com>
 <20221030094258.486428-9-iskren.chernev@gmail.com>
 <1880c054-08d9-3901-f44e-290d1fd27ed4@linaro.org>
From:   Iskren Chernev <iskren.chernev@gmail.com>
In-Reply-To: <1880c054-08d9-3901-f44e-290d1fd27ed4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/4/22 21:17, Krzysztof Kozlowski wrote:
> On 30/10/2022 05:42, Iskren Chernev wrote:
>> Add initial support for OnePlus Nord N100, based on SM4250. Currently
>> working:
>> - boots
>> - usb
>> - built-in flash storage (UFS)
>> - SD card reader
>>
>> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
>> ---
>>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>>  .../boot/dts/qcom/sm4250-oneplus-billie2.dts  | 241 ++++++++++++++++++
>>  2 files changed, 242 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index b0558d3389e5..eb2a58b8af5f 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -142,6 +142,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-polaris.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sm6350-sony-xperia-lena-pdx213.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= sm7225-fairphone-fp4.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
>> new file mode 100644
>> index 000000000000..a3f1c7c41fd7
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
>> @@ -0,0 +1,241 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
>> +/*
>> + * Copyright (c) 2021, Iskren Chernev <iskren.chernev@gmail.com>
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "sm4250.dtsi"
>> +
>> +/ {
>> +	model = "OnePlus Nord N100";
>> +	compatible = "oneplus,billie2", "qcom,sm4250";
>> +
>> +	/* required for bootloader to select correct board */
>> +	qcom,msm-id = <0x1a1 0x10000 0x1bc 0x10000>;
>> +	qcom,board-id = <0x1000b 0x00>;
>
> These are currently not allowed for SM4250. If there are really needed,
> please justify it and update
> Documentation/devicetree/bindings/arm/qcom.yaml. Then also update
> include/dt-bindings/arm/qcom,ids.h and socinfo driver.

I'm having some trouble with testing this ATM. If this is the only patch
with remaining complaints, the rest can be merged (because there is other
work prepped for 4250/6115 that depends on it), and once billie2 is figured
out it could be merged separately.

> Best regards,
> Krzysztof

Regards,
Iskren
