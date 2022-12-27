Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47CE656860
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 09:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiL0IV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 03:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiL0IVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 03:21:54 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BE221A8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 00:21:52 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id bp15so18650713lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 00:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uoVHCl3unE9x2Jn5slc8bNEN4YZ+jWXSChdKV0ixQj0=;
        b=ZI8OJfIc905Yn+MWE5wMmwIpiFn7IeAP2mnnBjX5uBdSCQsNf/fqewspwLYOryhbDl
         Rx8hVU2uLTw+roEmTbtM5IvP0zkd3xYp/nFfJF9D+wUGLrAZhY9ibXDU1AH786SCePjK
         vzFJUaU/CBsdDTseBDk/DPoCWku5A7m3c0iZEnOrloUYWAn2ARmjNZK+etc7FAH9QdeQ
         /+Miv5mF4RRus/5ljCuPRH8hYWjxlhegGB2OXEBl8PzUpr0svVf7/ExEXdZMqI3exMiC
         ENyx1Y7MxMPFV5Ho+VfOsHcYXE0pi9omLVggP4wPkGhssQBb2m9djEeqed+XMxnxx33q
         E+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uoVHCl3unE9x2Jn5slc8bNEN4YZ+jWXSChdKV0ixQj0=;
        b=KG+p7JgvFclXjOBy0TeK/av7sxJqYzKrWKnn0x0FGpjKqRhPGXB6RZXAs1oTYoskKd
         uaRbG1mH/Pw9PiZWVlkr1HWVNwZqfbobwq1KNiJ5H9NgieosXPZozK21qPVYiSZtr4/G
         AmcodWN6klYf0LB4UGZ3O4Dd0X3yPkJuMtY0IElayvx9CKqdz5Dd5wXgtf8Ny3OXBdR8
         U0dNxSBp1PM6Y4PO6i9yzZLsKVAHZ+I7oW0CSPcMkY7sRxmDANkmO/GcqGDMgYO/F6RC
         yS2QNbpQW7Zvn63lrDRYatbiHhJsDFvelox/c6Q68A4oSpns6FdRS+OPcwqwQdg414J7
         HHTw==
X-Gm-Message-State: AFqh2ko30kILw0g3Fmih9+rGyI5O0ZPAnuNH16po5UEl03j1SfiREMRu
        e2/RZYWHo1JLrmVLJGgIVgp9KA==
X-Google-Smtp-Source: AMrXdXtoddcMkOLR+6nt/68Thn2viOa1im3IPX1dUrStspBW0W9iMq1f1LNYBvUNgMruK3SG2/zyMA==
X-Received: by 2002:a05:6512:539:b0:4c5:64ed:df06 with SMTP id o25-20020a056512053900b004c564eddf06mr5883556lfc.27.1672129310889;
        Tue, 27 Dec 2022 00:21:50 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c19-20020a056512075300b004cafa01ebbfsm1697985lfs.101.2022.12.27.00.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 00:21:50 -0800 (PST)
Message-ID: <38352fbb-663f-71f7-b7ef-d539b98fc423@linaro.org>
Date:   Tue, 27 Dec 2022 09:21:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V20 1/7] dt-bindings: Added the yaml bindings for DCC
Content-Language: en-US
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, vkoul@kernel.org
References: <cover.1672068481.git.quic_schowdhu@quicinc.com>
 <fd3b99b07bd40612a76313429635026471d273ef.1672068481.git.quic_schowdhu@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <fd3b99b07bd40612a76313429635026471d273ef.1672068481.git.quic_schowdhu@quicinc.com>
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

On 26/12/2022 17:52, Souradeep Chowdhury wrote:
> Documentation for Data Capture and Compare(DCC) device tree bindings
> in yaml format.

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

Subject: drop second, redundant "bindings". Drop "yaml" (also unrelated).

Use proper imperative mode.
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> 
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,dcc.yaml     | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,dcc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,dcc.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,dcc.yaml
> new file mode 100644
> index 0000000..ac3b51b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,dcc.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/qcom/qcom,dcc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Data Capture and Compare
> +
> +maintainers:
> +  - Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> +
> +description: |
> +    DCC (Data Capture and Compare) is a DMA engine which is used to save
> +    configuration data or system memory contents during catastrophic failure
> +    or SW trigger. DCC is used to capture and store data for debugging purpose
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,sm8150-dcc
> +          - qcom,sc7280-dcc
> +          - qcom,sc7180-dcc
> +          - qcom,sdm845-dcc
> +      - const: qcom,dcc
> +
> +  reg:
> +    items:
> +      - description: DCC base
> +      - description: DCC RAM base
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dma@10a2000{
> +        compatible = "qcom,sm8150-dcc","qcom,dcc";

Missing space between compatibles.

Best regards,
Krzysztof

