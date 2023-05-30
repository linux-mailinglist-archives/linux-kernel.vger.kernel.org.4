Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCB271673D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjE3Piv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjE3Pis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:38:48 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEF0C7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:38:46 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-514953b3aa6so4281916a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685461125; x=1688053125;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IaHu9TtkLLNOstMNSPpKZct2v0hP2E2NmFd4zYNUP+k=;
        b=EX00xAh9t4XvFcWZc3FWQE5sqik+kGjm9qDbvY0NT14alFvhwB5nWacvT9u0CkeRY0
         tUwtFCrMAE4XUbqi3oiibp2Ko6+p/vJOwuM+n0D4PImbPiPzG8nQOcy/bdOsICr20W9a
         7CW9XcE6Y9dBT9kX2rsu+Gj04cHoxgbvOX2YtgfOpxwxOxKUGukZHknX8NGXLSVdHxlL
         W5IG1NZ9rzoE3YdUqZwCJ2AKU8l+BmIvzVYih+d9R9qbiowemlATsTRfHUf4zsoabqqy
         JlDZSTNLHnyodPieIHqgsmWq0LD7wCjZlAOmZkHecK4tHr04G8aOkA1JVDwTpgJ55lIl
         WiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685461125; x=1688053125;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IaHu9TtkLLNOstMNSPpKZct2v0hP2E2NmFd4zYNUP+k=;
        b=HGsOcqsjBYPSwR+4Jr7Eqw0N6LZxXk1QNhF3GoV48YduWOQUpnMiqAY/EkLYb2depf
         7gTDQ6KNDdnkiUuxikl7JEBTpMFBccLbhLF+h+O9VYLbvaNcSoHcETi7HOwqdkSdN0Xx
         nes4Aloy2oVHABk35Po0ZDUHscWwU3iitt4VmIHMjvoV04cTM40i4DlBg73mVocoKNbG
         0orUocPKxyrDyTxnxzYq0SfGVUoz1Gxj/reJgnmOtQgJX7acWj3uBb2SBdhT0rKiN7BF
         wCSDBCeR4iiviWCtGd7lXyOEdgcF7uCNDpJP5jc1vsn7zcLcNM+wdEHxbcuEqxzCgugL
         yG7w==
X-Gm-Message-State: AC+VfDzv2TsQnajNkVGKfN/SlkxYcsVNMr5qyTNR5qD31jkEzxyMW5cN
        5LZpu9hu9VRISFjSnyOOss1u1Q==
X-Google-Smtp-Source: ACHHUZ5mgEz2+fqyMWH4zaqwvf603rvdfg9ARinMvvN/pAOkAoTqh0y3Kum6bFZI5/DHOaPc0F3iAA==
X-Received: by 2002:a17:907:3e1e:b0:94e:ed5d:c864 with SMTP id hp30-20020a1709073e1e00b0094eed5dc864mr3324947ejc.19.1685461125225;
        Tue, 30 May 2023 08:38:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id kq12-20020a170906abcc00b009596e7e0dbasm7479658ejb.162.2023.05.30.08.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 08:38:44 -0700 (PDT)
Message-ID: <80ec15f5-0c68-9076-020a-854720d84c8a@linaro.org>
Date:   Tue, 30 May 2023 17:38:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 3/3] dt-bindings: arm: Adds CoreSight CSR hardware
 definitions
Content-Language: en-US
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
References: <20230526153508.6208-1-quic_jinlmao@quicinc.com>
 <20230526153508.6208-4-quic_jinlmao@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230526153508.6208-4-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2023 17:35, Mao Jinlong wrote:
> Adds new coresight-csr.yaml file describing the bindings required
> to define csr in the device trees.
> 
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  .../bindings/arm/qcom,coresight-csr.yaml      | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-csr.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-csr.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-csr.yaml
> new file mode 100644
> index 000000000000..a79b4f6a8bdf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/qcom,coresight-csr.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +# Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/qcom,coresight-csr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: CoreSight Slave Register - TPDA
> +
> +description: |
> +  CoreSight Slave Register block hosts miscellaneous configuration registers.
> +  Those configuration registers can be used to control, various coresight
> +  configurations.
> +
> +maintainers:
> +  - Mao Jinlong <quic_jinlmao@quicinc.com>
> +  - Hao Zhang <quic_hazha@quicinc.com>
> +
> +properties:
> +  $nodename:
> +    pattern: "^csr(@[0-9a-f]+)$"

Drop nodename, we do not enforce it for device schemas.

> +  compatible:
> +    items:
> +      - const: qcom,coresight-csr

Why qcom, not arm? Description and title suggests it is generic.

If it is SoC specific, then what is it exactly? IP block of SoC? Then it
would miss SoC specific compatibles.


> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2

You need to describe the items

> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: apb_pclk
> +
> +  qcom,set-byte-cntr-support:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      If set, indicates that CSR supports to set ETR_IRQ_CTRL register.

Why this cannot be deducted from SoC-specific compatible?

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  # minimum CSR definition.

Drop comment

> +  - |
> +    csr@10001000 {


Best regards,
Krzysztof

