Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035BF63788A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiKXMHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKXMGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:06:46 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E69A64A09
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:05:21 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id j4so2299421lfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4UD2+BwrM4OIYmxXfGtMiwHH7M/T9FxMPWGUo8Plx2Y=;
        b=VOuR003ZOkZqtUtOjQfaqRbWh1fGzpthkUs9mPEzG+CeS6IetDR+RDBJVqTVW0zttw
         VJ0L4YifpbSC7AFZxSuBzblLjHetdBS+QvacdWj/e1rHe8OOKILmEEQySuqnn9xNrCei
         vYZofeCLig9GHuhZJGUKehoX2eHTYC3R8iFtXlXYx1FHQbiB+BFl8Ql22UHIZOon2L/F
         jdsmlYaqfEMqIePQeqLbpqkWt0ocJAmGN3Cfy0yZCfsA533j1v8Lmo6+IMIBMUCpks0r
         kK6B/NmLA7QFkOaCra0dqNpRZ02vyvJcvqmXvFX+cev6QtaHbXJrH+lyqkxkBMkLbWVS
         XOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4UD2+BwrM4OIYmxXfGtMiwHH7M/T9FxMPWGUo8Plx2Y=;
        b=czV9m77LGHA78zRlE2bd8JMdhktBc3Z5dODqK7XvMOINECSFUpZKHq0Z+VJvt3QdJX
         +iPybfBlG/aDnzoQcVssPQ5mkYEBBk6eJ+bJJZCbd9H23TlQVagOXIpbW5uuWjEdyGtk
         bzYN54eK67Zy6IO5aS9DI59BOTTFbGvWSixe4lHBCtS5ttI4Ecrl9dVCulFpRwp4LDky
         qC5ykw2dUXLHX5htdGrIL+Sdfzoa+m4bedEPpV3bTUmPxx658tENhlT1hoVMP39t3AIQ
         xNpgbZDi0jp4eYilfbiSrx6+yRJaUFp5dExcuVlZ0y15EKIXjccbKpF+ZXi/aqv5NANS
         mkyg==
X-Gm-Message-State: ANoB5pl17Mb9CSwGMHurIiBAAsr2fMR/TRTTxWx+QjicAq22oCDLznAO
        F3FT76/MzX/PNUqpmY6hb4E15w==
X-Google-Smtp-Source: AA0mqf6H5h0Qk3gTJm8eqtQ17NGa3DDlAZJvzsKd6eCbSR2Aj7QnE3MnIEWCQ8MX/Lc4QGAxh1hkPg==
X-Received: by 2002:a19:4f56:0:b0:4af:cd2:f8df with SMTP id a22-20020a194f56000000b004af0cd2f8dfmr10508208lfk.586.1669291518289;
        Thu, 24 Nov 2022 04:05:18 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p22-20020a056512313600b00498f871f33fsm103879lfd.86.2022.11.24.04.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 04:05:17 -0800 (PST)
Message-ID: <80417bba-2ddb-2730-c9fd-6879d38bf126@linaro.org>
Date:   Thu, 24 Nov 2022 13:05:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/3] dt-bindings: interconnect: Add schema for SM8550
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Melody Olvera <quic_molvera@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20221124112232.1704144-1-abel.vesa@linaro.org>
 <20221124112232.1704144-2-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221124112232.1704144-2-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2022 12:22, Abel Vesa wrote:
> Add dedicated schema file for SM8500. This allows better constraining
> of reg property, depending on the type of the NOC node. Also allows
> better constraining of the clocks property. All of the above while
> keeping the file itself comprehensible.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  .../interconnect/qcom,sm8550-rpmh.yaml        | 141 ++++++++++++++++++
>  1 file changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.yaml
> new file mode 100644
> index 000000000000..9627b629d4ce
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.yaml
> @@ -0,0 +1,141 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,sm8550-rpmh.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm RPMh Network-On-Chip Interconnect on SM8550
> +
> +maintainers:
> +  - Georgi Djakov <djakov@kernel.org>
> +  - Odelu Kukatla <okukatla@codeaurora.org>

I think this is not accurate email. Georgi also might not be interested
in SM8550 itself, so I propose add here yourself and Neil.

> +
> +description: |
> +   RPMh interconnect providers support system bandwidth requirements through
> +   RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
> +   able to communicate with the BCM through the Resource State Coordinator (RSC)
> +   associated with each execution environment. Provider nodes must point to at
> +   least one RPMh device child node pertaining to their RSC and each provider
> +   can map to multiple RPMh resources.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sm8550-aggre1-noc
> +      - qcom,sm8550-aggre2-noc
> +      - qcom,sm8550-clk-virt
> +      - qcom,sm8550-cnoc-main
> +      - qcom,sm8550-config-noc
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

reg:
  maxItems: 1

> +allOf:
> +  - $ref: qcom,rpmh-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sm8550-aggre1-noc
> +              - qcom,sm8550-aggre2-noc
> +              - qcom,sm8550-cnoc-main
> +              - qcom,sm8550-config-noc
> +              - qcom,sm8550-gem-noc
> +              - qcom,sm8550-lpass-ag-noc
> +              - qcom,sm8550-lpass-lpiaon-noc
> +              - qcom,sm8550-lpass-lpicx-noc
> +              - qcom,sm8550-mmss-noc
> +              - qcom,sm8550-nsp-noc
> +              - qcom,sm8550-pcie-anoc
> +              - qcom,sm8550-system-noc
> +    then:
> +      properties:
> +        reg:
> +          minItems: 1
> +          maxItems: 1

Instead:

  if:
     ....

     enum:
       - virt interconnects
  then:
    properties:
      reg: false
  else:
    required:
      - reg


> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sm8550-pcie-anoc
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: aggre-NOC PCIe AXI clock
> +            - description: cfg-NOC PCIe a-NOC AHB clock
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sm8550-aggre1-noc
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: aggre UFS PHY AXI clock
> +            - description: aggre USB3 PRIM AXI clock
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sm8550-aggre2-noc
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: RPMH CC IPA clock

This part is in general fine, but I propose to do it differently -
mentioning clocks in top-level properties, because it's defining
properties in allOf:if:then is error prone and easy to miss. Better to
have one definition and customization in if:then:.

Therefore:
1. in top-level properties:
  clocks:
    minItems: 1
    maxItems: 2

2. All your ifs stay the same.

3. One more if: compatible: enum: pcie/aggre1/aggre2

  then:
    required:
      - clocks
  else:
    properties:
      clocks: false


> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +      #include <dt-bindings/clock/qcom,gcc-sm8550.h>
> +      #include <dt-bindings/interconnect/qcom,sm8550.h>
> +      #include <dt-bindings/clock/qcom,rpmh.h>
> +
> +      clk_virt: interconnect-0 {
> +             compatible = "qcom,sm8550-clk-virt";
> +             #interconnect-cells = <2>;
> +             qcom,bcm-voters = <&apps_bcm_voter>;
> +      };
> +
> +      cnoc_main: interconnect@1500000 {
> +             compatible = "qcom,sm8550-cnoc-main";
> +             reg = <0x01500000 0x13080>;
> +             #interconnect-cells = <2>;
> +             qcom,bcm-voters = <&apps_bcm_voter>;
> +      };
> +
> +      aggre1_noc: interconnect@16e0000 {
> +             compatible = "qcom,sm8550-aggre1-noc";
> +             reg = <0x016e0000 0x14400>;
> +             #interconnect-cells = <2>;
> +             clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
> +                      <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>;
> +             qcom,bcm-voters = <&apps_bcm_voter>;
> +      };
> +
> +      aggre2_noc: interconnect@1700000 {
> +             compatible = "qcom,sm8550-aggre2-noc";
> +             reg = <0x01700000 0x1E400>;
> +             #interconnect-cells = <2>;
> +             clocks = <&rpmhcc RPMH_IPA_CLK>;
> +             qcom,bcm-voters = <&apps_bcm_voter>;
> +      };

and keep just two examples (e.g. virt and aggre1) - they differ only by
one or two properties, so it's a bit too much...

Best regards,
Krzysztof

