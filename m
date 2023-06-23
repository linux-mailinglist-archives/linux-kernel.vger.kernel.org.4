Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E4873BCAC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjFWQgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjFWQgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:36:42 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B780271F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:36:38 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-98d25cbbb43so102348366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687538197; x=1690130197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=82HY4/N7H6ucguobBtwBPDTijk8Xv1cE56l9sSPsxZk=;
        b=gXumuoABzaqNQrTAPADk7TpH996PxPqGimC1fk5TwHSX1NxCP+vPpm87M0RBn0g5g5
         uQf0LItR4JYmJvq7kLg7RSngoZ5yebX7B/riec3E5Jup9770bo1bJleknLvmNcTPiwJQ
         oIgPz0QPnPZ8IdIzsq+8YNyS2bbEq+WaGGu5wkVGRLVc+Ww59kE5mdCnMzNrR4pdePLX
         M2V3g2rrsuU2TlhCW8PQWgaK2VxUB34/kkgrg8+qizDiPppCyyNx556iOO+x7JzLvj62
         n0YPT8PfBKfF7qBDllOv0gAR4fW09Tya1z55nAunUkxTkn1ORUJzT2wN6KHsdQrzrUrj
         MJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687538197; x=1690130197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82HY4/N7H6ucguobBtwBPDTijk8Xv1cE56l9sSPsxZk=;
        b=SXNA1NNIk5GI1+C6ZExmCsAXTXSAcP2dNJzgnWt7xEJURnj1U14KuVwIqX6cAzFWbO
         QjN1CDWbyHkVyWjh/uCNZH6Ii6jz+bcfj3wykYCRvK/Ktld+tca8LWxXYbC2Vew8aqRJ
         TDZSgmVEaapSx2QK3PdbkTU6EZhLejwVMeq9zQPSOxosSReEPzKUqfslgkvQSDo4fBKA
         dosgoEHL8pFR2BX0+ZrNgSBbLovBTYtV95BPHNUzMR/9SPKPeJ898V03Wzs/L7aVB9V7
         2y24Gd3ZHqTmpec5luns86Z4K26qISp07j8U9Srdjg2VzFUBdmvcanPSoWCLSgwtQE5K
         ficQ==
X-Gm-Message-State: AC+VfDyQ1NEUF2PT1YlDcLkkLvBvcDdlFbM/pwkwrcvGHix5k707LDrX
        t9HaColBHlQgnmcSbT+jKF3uAw==
X-Google-Smtp-Source: ACHHUZ6M6Rf3wT3cyji8AXUD2VmxjBtLQA6pE2h/h8k7r53MMuLZmgKmdzpknKGLRiTihchDqPMk2w==
X-Received: by 2002:a17:907:7e8b:b0:988:fafd:d93a with SMTP id qb11-20020a1709077e8b00b00988fafdd93amr12564350ejc.70.1687538196987;
        Fri, 23 Jun 2023 09:36:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id f3-20020a1709062c4300b009887bb956e0sm6175075ejh.103.2023.06.23.09.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 09:36:36 -0700 (PDT)
Message-ID: <cea67754-6bc0-f8ee-3cba-8713b10b0c69@linaro.org>
Date:   Fri, 23 Jun 2023 18:36:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 1/6] dt-bindings: nvmem: sec-qfprom: Add bindings for
 secure qfprom
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230623141806.13388-1-quic_kbajaj@quicinc.com>
 <20230623141806.13388-2-quic_kbajaj@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230623141806.13388-2-quic_kbajaj@quicinc.com>
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

On 23/06/2023 16:18, Komal Bajaj wrote:
> This patch adds bindings for secure qfprom found in QCOM SOCs.
> SECURE QFPROM driver is based on simple nvmem framework.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  .../bindings/nvmem/qcom,sec-qfprom.yaml       | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml
> new file mode 100644
> index 000000000000..675e27918c7b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/qcom,sec-qfprom.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies Inc, SECURE QFPROM Efuse

SECURE is not acronym, so "Secure".

> +
> +maintainers:
> +  - Komal Bajaj <quic_kbajaj@quicinc.com>

Add description: with explanation what is this.  Specifically it should
be quite clear what is here different than regular QFPROM

> +
> +allOf:
> +  - $ref: nvmem.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,qdu1000-sec-qfprom
> +      - const: qcom,sec-qfprom
> +
> +  reg:
> +    items:
> +      - description: The secure qfprom corrected region.
> +
> +  # Needed if any child nodes are present.
> +  "#address-cells":
> +    const: 1
> +  "#size-cells":
> +    const: 1

Drop both, they are not needed.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-sc7180.h>
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      efuse@221c8000 {
> +        compatible = "qcom,qdu1000-sec-qfprom", "qcom,sec-qfprom";
> +        reg = <0 0x221c8000 0 0x1000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        multi_chan_ddr: multi_chan_ddr@12b {

No underscores in node names.


Best regards,
Krzysztof

