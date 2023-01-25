Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8E767AABE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 08:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbjAYHQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 02:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbjAYHQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 02:16:08 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5204747ED2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 23:16:03 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id n7so16056407wrx.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 23:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KqVnz5dHE+H8EBqWuT4m2bnfmcW1edtMXQTUn/uHibA=;
        b=iI1Q+Ner3x7gfdxiAzK3mur3wDEWCKn9dxfIlWuEpFSxsQzxWuRG7X2pLeQN1I5xel
         +/v3dUdnrUtxdcuwqtWLOkUW+eJngWmIT+MPRIQXRgW175yJpTmLSxcFB0w7vsu7ZRG6
         5KWHHkNWIilYMfDYT4uI/vwyF3PIBy/TuwDWygtGcvDeeaDbaOZU09haKxYnGMYAGkn3
         c5FIebWU0ol3EqoHLIYnxGUiaxfdB2ltNWnOxNiia87ULZoB9CL5bp+F1isWrpWsfGLO
         FZbcb2brECcbs+PkKYu6x+NgahwJrTM0Bux310+vKUbOiZGSFuj7v5f1d0IaU4Ane4lx
         JJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KqVnz5dHE+H8EBqWuT4m2bnfmcW1edtMXQTUn/uHibA=;
        b=dLA2fO5G+cGIaJZXvSJwePF4krt9OkForREgpYIW/b+lSncXOr4pYFqeFcv659sb6z
         aYO3XuzxXYoWfwaY5hQO3DfGNYohgD/B+ngd1lBlpwPe6ZPqTnfNjXnbrjt5h4T8JOMu
         YGvfoQIy53JqmmRaDmnmlpbFIOFw3IwCTuzAwwGl+MPuJj0RQV90NeWxDP/OudO8lQO0
         MOZnwNlWQWN3NLxKzrKFDB0XtSEuAVttt/5JMei3MJdtAIUsTAzp46RlpF1d9XSj+4KC
         EXF23yLp/3CjqVsL7DX4bgWmRIgT1tXKMO+rOzC6qp/+sq2Pr1hboOjvGXCE0KmE24Fw
         EGBQ==
X-Gm-Message-State: AFqh2krL9vneUPu6ZSE+cGec+LdWU6+ZDzK+MrdJUsmqt0hPGogbH6kq
        nO7IEFSXlCqapO6sxKdPDJ15Qw==
X-Google-Smtp-Source: AMrXdXsQTc3tcSZ5O/Y+CPqj3BvK3F17J/9RhcE/qU182Xl1ciIA3AMHZDscUVB9vIS8xkIVoWcA6Q==
X-Received: by 2002:a05:6000:1816:b0:2bd:fe5a:b579 with SMTP id m22-20020a056000181600b002bdfe5ab579mr24770799wrh.70.1674630961690;
        Tue, 24 Jan 2023 23:16:01 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id x6-20020a5d4906000000b002bc6c180738sm4135881wrq.90.2023.01.24.23.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 23:16:01 -0800 (PST)
Message-ID: <c1e206f2-7e86-a7ad-c6fa-c80cc1c3f77d@linaro.org>
Date:   Wed, 25 Jan 2023 08:15:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v4 5/6] arm64: dts: qcom: Add Square apq8039-t2 board
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org,
        stephan@gerhold.net, Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>
References: <20230123023127.1186619-1-bryan.odonoghue@linaro.org>
 <20230123023127.1186619-6-bryan.odonoghue@linaro.org>
 <e80b98bc-54e8-f7ab-b9a9-dd888108a0cd@linaro.org>
 <8dd1ce3c-82ea-cfc3-a84c-c022cbaec8a0@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8dd1ce3c-82ea-cfc3-a84c-c022cbaec8a0@linaro.org>
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

On 25/01/2023 02:21, Bryan O'Donoghue wrote:
> On 23/01/2023 16:29, Krzysztof Kozlowski wrote:
>> On 23/01/2023 03:31, Bryan O'Donoghue wrote:
>>> The apq8039-t2 is an apq8039 based board paired with a wcn3680b WiFi
>>> chipset.
>>>
>>> Co-developed-by: Shawn Guo <shawn.guo@linaro.org>
>>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>>> Co-developed-by: Jun Nie <jun.nie@linaro.org>
>>> Signed-off-by: Jun Nie <jun.nie@linaro.org>
>>> Co-developed-by: Benjamin Li <benl@squareup.com>
>>> Signed-off-by: Benjamin Li <benl@squareup.com>
>>> Co-developed-by: James Willcox <jwillcox@squareup.com>
>>> Signed-off-by: James Willcox <jwillcox@squareup.com>
>>> Co-developed-by: Leo Yan <leo.yan@linaro.org>
>>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>>> Co-developed-by: Joseph Gates <jgates@squareup.com>
>>> Signed-off-by: Joseph Gates <jgates@squareup.com>
>>> Co-developed-by: Max Chen <mchen@squareup.com>
>>> Signed-off-by: Max Chen <mchen@squareup.com>
>>> Co-developed-by: Zac Crosby <zac@squareup.com>
>>> Signed-off-by: Zac Crosby <zac@squareup.com>
>>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>> ---
>>>   arch/arm64/boot/dts/qcom/Makefile       |   1 +
>>>   arch/arm64/boot/dts/qcom/apq8039-t2.dts | 545 ++++++++++++++++++++++++
>>>   2 files changed, 546 insertions(+)
>>>   create mode 100644 arch/arm64/boot/dts/qcom/apq8039-t2.dts
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>>> index b0423ca3e79fd..73ff8d3213d99 100644
>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>> @@ -1,5 +1,6 @@
>>>   # SPDX-License-Identifier: GPL-2.0
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
>>> +dtb-$(CONFIG_ARCH_QCOM)	+= apq8039-t2.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
>>> diff --git a/arch/arm64/boot/dts/qcom/apq8039-t2.dts b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
>>> new file mode 100644
>>> index 0000000000000..734b4d6054132
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
>>> @@ -0,0 +1,545 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
>>> + * Copyright (c) 2020-2023, Linaro Ltd.
>>> + *
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "msm8939.dtsi"
>>> +#include "msm8939-pm8916.dtsi"
>>> +#include <dt-bindings/arm/qcom,ids.h>
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>>> +#include <dt-bindings/sound/apq8016-lpass.h>
>>> +
>>> +/ {
>>> +	model = "Square, Inc. T2 Devkit";
>>> +	compatible = "square,apq8039-t2", "qcom,msm8939";
>>
>> There is no square vendor prefix.
> 
> commit d3e2262cd0d1105bb3a71012693876d01e8de203
> Author: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Date:   Tue Jan 17 02:48:39 2023 +0000
> 
>      dt-bindings: arm: qcom: Document MSM8939 SoC binding
> 
> +      - items:
> +          - enum:
> +              - sony,kanuti-tulip
> +              - square,apq8039-t2
> +          - const: qcom,msm8939

This is board compatible. You still missing vendor prefix in
vendor-prefixes.

Best regards,
Krzysztof

