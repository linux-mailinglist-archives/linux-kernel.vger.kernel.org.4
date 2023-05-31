Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4091F7179F1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbjEaIWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbjEaIWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:22:45 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE80C5
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:22:43 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-514953b3aa6so5455123a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685521362; x=1688113362;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pOPIHFPeoZm1SHuLb6csoeVTgdHyefcQkMoNigozzN8=;
        b=JAihcfs2MO9yplHrNsezyN7/h08pjwHwVJtCock7qeleu9jKO+ZKUeZOxRt0vzdKho
         4SvHmcW7tAbINr6vtbDFK7AEaoeV87JQwkMNqQDcB7Cc6ZEpj9U8S2irG1wiFvChg7Dn
         ZXSGP56/NVauqW5kd391TwetSg6XN5AwA7RM1yiGGXUAim5wv/IjrwL3BK78WBI2xZ4L
         7eqhU4OAEoKFkpzuAMa61tF3aODSYU77hvQL6TUDuJ7O/iIj4D5bPBsQGoKrYPx1L7PR
         OTG2fFHFt4KmdnuVJexaAY736pleKDO5wzwZBa62eqH4oMPLmJ4A8L6fHtjsukbBAWVh
         yfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685521362; x=1688113362;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pOPIHFPeoZm1SHuLb6csoeVTgdHyefcQkMoNigozzN8=;
        b=O3ppPJZmd2E3FL499Th/fJE0eDXAXm1mSPuZeYn8qY0Nw6ZzxHNQHf/SkmMGbXlSsr
         o9z9X11nl/b0526rv/tJCrJZQgz7EJKHAAOTGV03p0F6L/lPOTShz4lQl84suVP+IPl1
         XZbq4iCNdamgcFWkHztZ8agfkS9nCki8QIGd6vM4ryIUc0ZpYUY70+mbqtPeOYwJXJva
         NAp++UOwDJqa/eBBuefMeG/MfLcRsXLeqXYAzyfeJ/rjncS0jIsc5US9zPJD1Hi1DS3+
         bOiVRqaHgLg1z1UyedBZ0FqPuwrfhTeq3nrzHAFeNSAIoUv4vfZl1Otcrhb+TUeNxTF1
         CJUQ==
X-Gm-Message-State: AC+VfDxY1/Y8OaME7V9uxMPpgLcNlyhyGxoNYtzZAN/rv7Olc/4H6ggi
        eQIgsHPkvqucg+PNqY3nTsX3BA==
X-Google-Smtp-Source: ACHHUZ5Wk3l5CAgQaZYEzeLVhzAc4NvsiwKflcjb6jHYnk4P12fD8YntptsueSI367nTvfoDbv1d9A==
X-Received: by 2002:a17:907:7f0d:b0:973:d71f:4029 with SMTP id qf13-20020a1709077f0d00b00973d71f4029mr5522344ejc.2.1685521362364;
        Wed, 31 May 2023 01:22:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id lf4-20020a170907174400b0096f7500502csm8609718ejc.199.2023.05.31.01.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 01:22:41 -0700 (PDT)
Message-ID: <25e3ed2f-d691-1a80-e2ba-6c7413b7261a@linaro.org>
Date:   Wed, 31 May 2023 10:22:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 03/15] dt-bindings: interconnect: split SC8180x to own
 schema
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230530162454.51708-1-vkoul@kernel.org>
 <20230530162454.51708-4-vkoul@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230530162454.51708-4-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 18:24, Vinod Koul wrote:
> SC8180x comes with interconnects with missing IO address space and
> variable number of clocks, so split it from common file for easier
> maintenance and to fix warnings like:
> 
> sc8180x-lenovo-flex-5g.dtb: interconnect-0: 'reg' is a required property
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  .../bindings/interconnect/qcom,rpmh.yaml      | 11 -----
>  .../interconnect/qcom,sc8180x-rpmh.yaml       | 49 +++++++++++++++++++
>  2 files changed, 49 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sc8180x-rpmh.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> index 4d93ad415e0b..5cbc3be49e99 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> @@ -39,17 +39,6 @@ properties:
>        - qcom,sc7180-npu-noc
>        - qcom,sc7180-qup-virt
>        - qcom,sc7180-system-noc
> -      - qcom,sc8180x-aggre1-noc
> -      - qcom,sc8180x-aggre2-noc
> -      - qcom,sc8180x-camnoc-virt
> -      - qcom,sc8180x-compute-noc
> -      - qcom,sc8180x-config-noc
> -      - qcom,sc8180x-dc-noc
> -      - qcom,sc8180x-gem-noc
> -      - qcom,sc8180x-mc-virt
> -      - qcom,sc8180x-mmss-noc
> -      - qcom,sc8180x-qup-virt
> -      - qcom,sc8180x-system-noc
>        - qcom,sdm670-aggre1-noc
>        - qcom,sdm670-aggre2-noc
>        - qcom,sdm670-config-noc
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sc8180x-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sc8180x-rpmh.yaml
> new file mode 100644
> index 000000000000..b182c2c5addc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sc8180x-rpmh.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,sc8180x-rpmh.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm RPMh Network-On-Chip Interconnect on SC8180X
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +  - Konrad Dybcio <konrad.dybcio@linaro.org>
> +
> +description: |
> +  RPMh interconnect providers support system bandwidth requirements through
> +  RPMh hardware accelerators known as Bus Clock Manager (BCM).
> +
> +  See also:: include/dt-bindings/interconnect/qcom,sc8180x.h
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sc8180x-aggre1-noc
> +      - qcom,sc8180x-aggre2-noc
> +      - qcom,sc8180x-camnoc-virt
> +      - qcom,sc8180x-compute-noc
> +      - qcom,sc8180x-config-noc
> +      - qcom,sc8180x-dc-noc
> +      - qcom,sc8180x-gem-noc
> +      - qcom,sc8180x-ipa-virt
> +      - qcom,sc8180x-mc-virt
> +      - qcom,sc8180x-mmss-noc
> +      - qcom,sc8180x-qup-virt
> +      - qcom,sc8180x-system-noc
> +
> +required:
> +  - compatible
> +
> +allOf:
> +  - $ref: qcom,rpmh-common.yaml#

This should be based on sc7280. You need reg for some of the entries.

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    interconnect-0 {

Just "interconnect"


> +        compatible = "qcom,sc8180x-camnoc-virt";
> +        #interconnect-cells = <2>;
> +        qcom,bcm-voters = <&apps_bcm_voter>;
> +    };

Best regards,
Krzysztof

