Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A4062BF06
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbiKPNHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239105AbiKPNG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:06:58 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C937740916
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:06:35 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id c25so21746811ljr.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iOBFZUjEPMhwAjsluHyEUpXc+iXpF6wfXywtn4j6o+I=;
        b=K1ZoTLuqbNukVGP/gtemU1AGYfiMmC2Lctpg2eDfGCmpm/Y31rPT8ebVXjztzO1Oyu
         SA7MLG6tUjkdLrGcN0aHOlwSh5v9AWxYPKJg6P4pw24VuS9uu5Q6EOrU8P6VzELBk/dX
         shNnfVNTpkgsD3RHum1Kep36dg6KiBzuYVBa5uokDbLzp/OREK9sO14Jn38qdBUb6m+t
         ng+rr46wgM5uHDxr3MbxQdgWM4SSydxzbarvrotO4YnH0T9p0epNAWU1EGGdHHkzQakH
         vRbH3Xr5HeBFq9ggor0g96aZCdEIa9K8XzWIBfq/HdP7OohuQmBexKzb+ONysh2nzu+8
         ZavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iOBFZUjEPMhwAjsluHyEUpXc+iXpF6wfXywtn4j6o+I=;
        b=1EBnW3zf6hZO9B2kQTuP3OFmVapj3e4U+9YlDDFP5NnjAReJJkQJSAiAJ5v9oBh0K7
         RMR9o0/KR6t2ERh6PTrCVYGEH/C1STkC5yS0EdWGqMsyvpozH6iE4wsC/dS1ToYJuiwM
         IHrQG/Y90i4D4xzB6ICpx9QZO0DWuUwYNvcPemxtSJFmgWOySc95RMiTlNINgUu4HxgW
         TFvguKNM8vp7ivPiBEqJOO/8Wx3dwCLzzH0ja3B4CM/Px4SL8g71DdkCbjQfEpIpNULH
         7nOEpfRbUp3HTzFKle9ypnhmNqTivYMyFPsbXmommP2/6wx+Ls2MlFHQ1GZBPsbin0Js
         DHBA==
X-Gm-Message-State: ANoB5pmH1ZIfvjUnyewTonz2w99dKRVlALSu7A3US3xOg/9n49LM/WVE
        GBupc1S+CKDVQCWp49h22fQmrA==
X-Google-Smtp-Source: AA0mqf5mPSTbEI6fRwb+KHjKKpDE60Gqc2m+0ToDjFPXSRuOADvXEwvx9u0wRXmJaaudC+2n614clA==
X-Received: by 2002:a05:651c:1787:b0:277:8d48:27dd with SMTP id bn7-20020a05651c178700b002778d4827ddmr7995138ljb.192.1668603994185;
        Wed, 16 Nov 2022 05:06:34 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v14-20020a05651203ae00b004b497035243sm1676411lfp.184.2022.11.16.05.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 05:06:33 -0800 (PST)
Message-ID: <19686cfa-a3ec-fce4-04fd-3e047062295f@linaro.org>
Date:   Wed, 16 Nov 2022 14:06:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm SM8550 DT
 bindings
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20221116114526.2679041-1-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221116114526.2679041-1-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2022 12:45, Abel Vesa wrote:
> The Qualcomm SM8550 SoC has several bus fabrics that could be
> controlled and tuned dynamically according to the bandwidth demand
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  .../bindings/interconnect/qcom,rpmh.yaml      |  19 +-
>  .../dt-bindings/interconnect/qcom,sm8550.h    | 190 ++++++++++++++++++
>  2 files changed, 208 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/interconnect/qcom,sm8550.h
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> index a429a1ed1006..667ed6815773 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> @@ -132,12 +132,29 @@ properties:
>        - qcom,sm8450-nsp-noc
>        - qcom,sm8450-pcie-anoc
>        - qcom,sm8450-system-noc
> +      - qcom,sm8550-aggre1-noc
> +      - qcom,sm8550-aggre2-noc
> +      - qcom,sm8550-clk-virt
> +      - qcom,sm8550-config-noc
> +      - qcom,sm8550-cnoc-main

Keep the names sorted alphabetically.

> +      - qcom,sm8550-gem-noc
> +      - qcom,sm8550-lpass-ag-noc
> +      - qcom,sm8550-lpass-lpiaon-noc
> +      - qcom,sm8550-lpass-lpicx-noc
> +      - qcom,sm8550-mc-virt
> +      - qcom,sm8550-mmss-noc
> +      - qcom,sm8550-nsp-noc
> +      - qcom,sm8550-pcie-anoc
> +      - qcom,sm8550-system-noc
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2

Not explained...

>  
>    '#interconnect-cells': true
>  
>  required:
>    - compatible
> -  - reg

Nope. This is undocumented change.

See also:
https://lore.kernel.org/all/20221026190520.4004264-2-quic_molvera@quicinc.com/

>  
>  unevaluatedProperties: false
>  
> diff --git a/include/dt-bindings/interconnect/qcom,sm8550.h b/include/dt-bindings/interconnect/qcom,sm8550.h
> new file mode 100644
> index 000000000000..a066460d5a12
> --- /dev/null
> +++ b/include/dt-bindings/interconnect/qcom,sm8550.h
> @@ -0,0 +1,190 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Linaro Limited
> + */
> +
> +#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SM8550_H
> +#define __DT_BINDINGS_INTERCONNECT_QCOM_SM8550_H
> +
> +#define MASTER_QSPI_0				0
> +#define MASTER_QUP_1				1
> +#define MASTER_SDCC_4				2
> +#define MASTER_UFS_MEM				3
> +#define MASTER_USB3_0				4
> +#define SLAVE_A1NOC_SNOC			5
> +
> +#define	MASTER_QDSS_BAM				0

Drop weird tab/spaces in the middle.

Best regards,
Krzysztof

