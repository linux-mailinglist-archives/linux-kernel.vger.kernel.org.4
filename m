Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9503868EA01
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 09:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjBHIic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 03:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjBHIi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 03:38:27 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239012202E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 00:38:24 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h3so8094813wrp.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 00:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eS63Or4T8CRl6Rlda5XYU0bXBqkeJzCyi7egT8CHhq4=;
        b=BU1JzxJ1RWZVEXAI1ICJzziP6g940qYfIArARwAQ0Eb3VF0Yc58ZLbs8GegqFkcyTL
         CGHC3I/9zLa5sVnlAMDk2ZnyDOPmR4CyKEzUHfSr3sLs+NbR2e3caTrZHXzNtMB+O2YG
         tYr9PLFsSZ6uQfBu6qdY0dakiW9yeb0/tMhktrJj4fYFQgtA7HbSm2wYtuI006xf/Krn
         XAgHMSqf+7Wx5gRjmbl9Dsh+z4z3h9pbTe08STMhDLIO0sKwIoFxBwUBdMgPiuywBuWg
         PpET4M+8c6xTMxFX3APh3ftwOOljLHBj2IYMCzIK9SqTS9HEV3etOice6rl4xBECbDeB
         iB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eS63Or4T8CRl6Rlda5XYU0bXBqkeJzCyi7egT8CHhq4=;
        b=OvsKQZ2qlOGn5xEHB3thOqrqYe07inRPuPiI7otaeawZaMFiDLB2aXJJqP6ysn33Vn
         zseXY+hPz1PdOP+pRGcDQsp3UD18qhHZipFLrswTeEZyHfghhAlRLRlQ/Hv37b0nr+gL
         ePD5qdzq9zEZ8BhEVuxiTRMnYR6+Bx8S/X2vuXRd4PxrSPHArEDED1ysuoP2tE9egpGt
         5wQv6L2Gw7QDQxrFE2QbqhNectdWNlCCW1rSY9ASbTnFhZ+0otbbWDDt5AZX811Stduz
         lNz49IjpHhMD8bCFS/TpegSqvFCVkCUW7bNk5FSpCbO/yWq1P+D14jZvU1j5ryOCVCuY
         Quag==
X-Gm-Message-State: AO0yUKXiGYmSJ2MwDPJpEV5PeGU0K/acXp0G2bYBi/PKjIamkGu5Tgyh
        do2/XEgODs6MFGogjlryeol2Xg==
X-Google-Smtp-Source: AK7set8WsUaHtpqa2gNKSdTElnh5D1DLqGHg9t1gWbdIdG1ugmh/M0bcyR96fE/SUyPXXsToJiQrrA==
X-Received: by 2002:adf:dd12:0:b0:2c3:f26f:8cca with SMTP id a18-20020adfdd12000000b002c3f26f8ccamr5153425wrm.67.1675845502699;
        Wed, 08 Feb 2023 00:38:22 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h7-20020adffa87000000b002c3e698d7a4sm7634366wrr.24.2023.02.08.00.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 00:38:22 -0800 (PST)
Message-ID: <c2e71430-64f5-4f6f-dab7-2ec9f97c85fb@linaro.org>
Date:   Wed, 8 Feb 2023 09:38:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 1/7] dt-bindings: phy: Add qcom,snps-eusb2-repeater
 schema file
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230207135551.1418637-1-abel.vesa@linaro.org>
 <20230207135551.1418637-2-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230207135551.1418637-2-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2023 14:55, Abel Vesa wrote:
> The SM8550 SoC uses Synopsis eUSB2 repeater found in PM8550b.
> Add a dt-binding schema for the new driver.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> The v3 (rfc) is here:
> https://lore.kernel.org/all/20230202133816.4026990-3-abel.vesa@linaro.org/
> 
> Changes since v3:
>  * made this patch the first one in the series to fix the binding check
>    for the 2nd patch.
>  * dropped the compatible for pmic in the example. This is due to the
>    dependency between this patch and the next one.
> 
>  .../phy/qcom,snps-eusb2-repeater.yaml         | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
> new file mode 100644
> index 000000000000..54afab7e21fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/qcom,snps-eusb2-repeater.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Synopsis eUSB2 to USB 2.0 repeater
> +
> +maintainers:
> +  - Abel Vesa <abel.vesa@linaro.org>
> +

It would be really nice to have here "description:" with few words what
this repeater is and what it does.

Anyway:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

