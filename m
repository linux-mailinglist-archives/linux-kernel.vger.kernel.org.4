Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C935B6AE46F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjCGPUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjCGPTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:19:25 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12E0B459
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 07:17:30 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cw28so53654951edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 07:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678202249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OuDrqTSCL2R3I+U9XcJAemdCTVBVc1LECPbO3KJHMls=;
        b=OHwMobApvqjP2wXPCvYZbeHnpMT03cBKGaVGCmUDk/9YYjsrNPppfPRBdgftnMgKzb
         iDMWGQKBT3gcdCgdU50xVHTD61S5ci1cLXfAzsb31sLdt+AhRC0fI6FKDQdVgyPNJxvk
         cBpD2J9r3DdagzAPK7NaMJ1cXZOKWrD3rV3ubI3zateVP2oREz0QEBm6rj3Jy1N1xmP2
         JoGUnwHhcu7GRzEAgoftQh+IYCY2cFMLqpyM5XmtRrBgfhM076SOJtUoGnFH1KpXMfMa
         vLJZ77ApBT+72HHevSIF3a9Y4JZH3m7hImHHcJjgR3szMttWEtm3/K4zILmQzSt7YJCj
         L8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678202249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OuDrqTSCL2R3I+U9XcJAemdCTVBVc1LECPbO3KJHMls=;
        b=Xm/jcJGfBfNY3CFvJoxgzkCXpLQm72t27L7ZLghPPFCcCpu/zft0K/ARrkm0jebKgM
         w95xk5nvkHmzlXMBD3FkTJgUJ6SU8GpaxphHIvtwaLVH5ac5oQNcn1eLrhyLyKr+plT3
         MzUO/VkOrQ8WNM73+JTL2Yo2GWdNtrAzvV7mssW9xRh7lj1WbaBXj0ENGvfk1drm4H/a
         DbFWRg8fqkNmfourDnPK/21I9sY5vFodGOt852cHA6vaTHXyrq6H+h2GQBy64vIMEqO8
         KPnC73BJ4zgAnDzAZY6IPxjFVckbIJQxmvv8TWh8nY5E22fQHQHA8AsMXJkBFoIiQRDT
         iQVA==
X-Gm-Message-State: AO0yUKU/WEIUBn9QUSdfgFPTSUCfFs9zTEMPgXdiNoOEBrk4K2m2XIIT
        Glbvj6hULZ31wHYb4whou/PB0g==
X-Google-Smtp-Source: AK7set+4M704iTtRD8cAZX4hQzfah6EPB3z66wdzQFq1gqpvtlGuS+147XQihTBpr+pd8E3QjKfdbQ==
X-Received: by 2002:a17:906:5656:b0:8dd:76b6:7b14 with SMTP id v22-20020a170906565600b008dd76b67b14mr17516721ejr.14.1678202249043;
        Tue, 07 Mar 2023 07:17:29 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:a60f:e604:c252:1f3d? ([2a02:810d:15c0:828:a60f:e604:c252:1f3d])
        by smtp.gmail.com with ESMTPSA id z19-20020a50cd13000000b004bd1fe2cc02sm6789814edi.16.2023.03.07.07.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 07:17:28 -0800 (PST)
Message-ID: <38a5a268-7d8a-6e61-4272-8e9155df0034@linaro.org>
Date:   Tue, 7 Mar 2023 16:17:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/11] dt-bindings: remoteproc: qcom: Add support for
 multipd model
Content-Language: en-US
To:     Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, mathieu.poirier@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_gurus@quicinc.com,
        loic.poulain@linaro.org, quic_eberman@quicinc.com,
        robimarko@gmail.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
 <1678164097-13247-2-git-send-email-quic_mmanikan@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1678164097-13247-2-git-send-email-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2023 05:41, Manikanta Mylavarapu wrote:
> Add new binding document for multipd model remoteproc.
> IPQ5018, IPQ9574 follows multipd model.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
>  .../bindings/remoteproc/qcom,multipd-pil.yaml | 282 ++++++++++++++++++
>  1 file changed, 282 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml
> new file mode 100644
> index 000000000000..b788607f5abd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml
> @@ -0,0 +1,282 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/qcom,multipd-pil.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Multipd Secure Peripheral Image Loader
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +  - Mathieu Poirier <mathieu.poirier@linaro.org>
> +
> +description:
> +  Multipd Peripheral Image Loader loads firmware and boots Q6 pd, WCSS pd
> +  remoteproc's on the Qualcomm IPQ5018, IPQ9574 SoC.

What is a "pd"?

> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,ipq5018-q6-mpd
> +      - qcom,ipq9574-q6-mpd
> +
> +  '#address-cells': true
> +
> +  '#size-cells': true

Why do you need both?

If really needed, these should be const.

> +
> +  'ranges': true
> +

Same question - why do you need it?

> +  reg:
> +    maxItems: 1
> +
> +  interrupts-extended:

Instead interrupts

> +    items:
> +      - description: Watchdog interrupt
> +      - description: Fatal interrupt
> +      - description: Ready interrupt
> +      - description: Handover interrupt
> +      - description: Stop acknowledge interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: wdog
> +      - const: fatal
> +      - const: ready
> +      - const: handover
> +      - const: stop-ack
> +
> +  clocks:
> +    minItems: 25
> +    maxItems: 25

Drop both and instead describe the items. Anyway minItems are not needed
here.

> +
> +  clock-names:
> +    minItems: 25
> +    maxItems: 25

Drop both and instead list the names.

> +
> +  assigned-clocks:
> +    minItems: 13
> +    maxItems: 13

Drop, they do not have to be mentioned in the binding. If you think they
need to, then why?

> +
> +  assigned-clock-rates:
> +    minItems: 13
> +    maxItems: 13

Ditto

> +
> +  qcom,smem-states:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: States used by the AP to signal the remoteprocessor
> +    items:
> +      - description: Shutdown Q6
> +      - description: Stop Q6
> +
> +  qcom,smem-state-names:
> +    description:
> +      Names of the states used by the AP to signal the remoteprocessor
> +    items:
> +      - const: shutdown
> +      - const: stop
> +
> +  memory-region:
> +    items:
> +      - description: Q6 pd reserved region
> +
> +  glink-edge:
> +    $ref: /schemas/remoteproc/qcom,glink-edge.yaml#

unevaluatedProperties: false

> +    description:
> +      Qualcomm G-Link subnode which represents communication edge, channels
> +      and devices related to the Modem.
> +
> +patternProperties:
> +  "^remoteproc_pd1|remoteproc_pd2|remoteproc_pd3":

No, underscores are not allowed. Also, what is pd?

> +    type: object
> +    description:
> +      In Multipd model, WCSS pd depends on Q6 pd i.e Q6 pd should be up before
> +      WCSS. It can be achieved by keeping wcss pd node as subnode of Q6
> +      device node.
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - "qcom,ipq5018-wcss-ahb-mpd"
> +          - "qcom,ipq9574-wcss-ahb-mpd"
> +          - "qcom,ipq5018-wcss-pcie-mpd"

Drop quotes

> +
> +      interrupts-extended:

Same as before

> +        items:
> +          - description: Fatal interrupt
> +          - description: Ready interrupt
> +          - description: Spawn acknowledge interrupt
> +          - description: Stop acknowledge interrupt
> +
> +      interrupt-names:
> +        items:
> +          - const: fatal
> +          - const: ready
> +          - const: spawn-ack
> +          - const: stop-ack
> +
> +      qcom,smem-states:
> +        $ref: /schemas/types.yaml#/definitions/phandle-array
> +        description: States used by the AP to signal the remoteprocessor
> +        items:
> +          - description: Shutdown WCSS pd
> +          - description: Stop WCSS pd
> +          - description: Spawn WCSS pd
> +
> +      qcom,smem-state-names:
> +        description:
> +          Names of the states used by the AP to signal the remoteprocessor

remote processor

> +        items:
> +          - const: shutdown
> +          - const: stop
> +          - const: spawn

This is confusing. Why your children have the same properties as parent?

> +
> +    required:
> +      - compatible
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts-extended

interrupts

> +  - interrupt-names
> +  - qcom,smem-states
> +  - qcom,smem-state-names
> +  - memory-region
> +
> +additionalProperties: false
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - qcom,ipq9574-q6-mpd
> +    then:
> +      properties:
> +        assigned-clocks:
> +          items:
> +            - description: Phandle, clock specifier of GCC_ANOC_WCSS_AXI_M_CLK
> +            - description: Phandle, clock specifier of GCC_WCSS_AHB_S_CLK
> +            - description: Phandle, clock specifier of GCC_WCSS_ECAHB_CLK
> +            - description: Phandle, clock specifier of GCC_WCSS_ACMT_CLK
> +            - description: Phandle, clock specifier of GCC_WCSS_AXI_M_CLK
> +            - description: Phandle, clock specifier of GCC_Q6_AXIM_CLK
> +            - description: Phandle, clock specifier of GCC_Q6_AXIM2_CLK
> +            - description: Phandle, clock specifier of GCC_Q6_AHB_CLK
> +            - description: Phandle, clock specifier of GCC_Q6_AHB_S_CLK
> +            - description: Phandle, clock specifier of GCC_Q6SS_BOOT_CLK
> +            - description: Phandle, clock specifier of GCC_MEM_NOC_Q6_AXI_CLK
> +            - description: Phandle, clock specifier of GCC_WCSS_Q6_TBU_CLK
> +            - description: Phandle, clock specifier of GCC_SYS_NOC_WCSS_AHB_CLK

Eh, so here they are. But Why? Do you expect different clocks for
others? If so, where are they?

Anyway, drop useless "Phandle, clock specifier of". Clocks cannot be
anything else than phandle and a clock specifier. Instead of using some
cryptic ACRONYM_OR_SOME_CLK, describe them. Just like we do for other
bindings. You have plenty of good examples, so please start from them.


> +        assigned-clock-rates:
> +          items:
> +            - description: Must be 266666667 HZ
> +            - description: Must be 133333333 HZ
> +            - description: Must be 133333333 HZ
> +            - description: Must be 133333333 HZ
> +            - description: Must be 266666667 HZ
> +            - description: Must be 533000000 HZ
> +            - description: Must be 342857143 HZ
> +            - description: Must be 133333333 HZ
> +            - description: Must be 133333333 HZ
> +            - description: Must be 342857143 HZ
> +            - description: Must be 533000000 HZ
> +            - description: Must be 533000000 HZ
> +            - description: Must be 133333333 HZ

???

If these are fixed, why this is in DT? DT is for variable and
non-discoverable pieces and you do not have here anything variable, but
fixed.

> +
> +examples:
> +  - |
> +        #include <dt-bindings/interrupt-controller/arm-gic.h>
> +        #include <dt-bindings/clock/qcom,gcc-ipq5018.h>
> +        #include <dt-bindings/reset/qcom,gcc-ipq5018.h>

Use 4 spaces for example indentation.

> +
> +        q6v5_wcss: remoteproc@cd00000 {
> +                compatible = "qcom,ipq5018-q6-mpd";
> +                #address-cells = <1>;
> +                #size-cells = <1>;
> +                ranges;
> +                reg = <0x0cd00000 0x4040>;
> +                interrupts-extended = <&intc GIC_SPI 291 IRQ_TYPE_EDGE_RISING>,
> +                                <&wcss_smp2p_in 0 0>,

Wrong alignment of indentation

> +                                <&wcss_smp2p_in 1 0>,
> +                                <&wcss_smp2p_in 2 0>,
> +                                <&wcss_smp2p_in 3 0>;
> +                interrupt-names = "wdog",
> +                                  "fatal",
> +                                  "ready",
> +                                  "handover",
> +                                  "stop-ack";
> +
> +                qcom,smem-states = <&wcss_smp2p_out 0>,
> +                                   <&wcss_smp2p_out 1>;
> +                qcom,smem-state-names = "shutdown",
> +                                        "stop";
> +
> +                memory-region = <&q6_region>;
> +
> +                glink-edge {
> +                        interrupts = <GIC_SPI 179 IRQ_TYPE_EDGE_RISING>;
> +                        label = "rtr";
> +                        qcom,remote-pid = <1>;
> +                        mboxes = <&apcs_glb 8>;
> +                };
> +
> +                q6_wcss_pd1: remoteproc_pd1 {
> +                        compatible = "qcom,ipq5018-wcss-ahb-mpd";
> +                        interrupts-extended = <&wcss_smp2p_in 8 0>,
> +                                        <&wcss_smp2p_in 9 0>,
> +                                        <&wcss_smp2p_in 12 0>,
> +                                        <&wcss_smp2p_in 11 0>;
> +                        interrupt-names = "fatal",
> +                                          "ready",
> +                                          "spawn-ack",
> +                                          "stop-ack";
> +                        qcom,smem-states = <&wcss_smp2p_out 8>,
> +                                           <&wcss_smp2p_out 9>,
> +                                           <&wcss_smp2p_out 10>;
> +                        qcom,smem-state-names = "shutdown",
> +                                                "stop",
> +                                                "spawn";
> +                };
> +
> +                q6_wcss_pd2: remoteproc_pd2 {
> +                        compatible = "qcom,ipq5018-wcss-pcie-mpd";
> +                        interrupts-extended = <&wcss_smp2p_in 16 0>,
> +                                        <&wcss_smp2p_in 17 0>,
> +                                        <&wcss_smp2p_in 20 0>,
> +                                        <&wcss_smp2p_in 19 0>;
> +                        interrupt-names = "fatal",
> +                                          "ready",
> +                                          "spawn-ack",
> +                                          "stop-ack";
> +
> +                        qcom,smem-states = <&wcss_smp2p_out 16>,
> +                                           <&wcss_smp2p_out 17>,
> +                                           <&wcss_smp2p_out 18>;
> +                        qcom,smem-state-names = "shutdown",
> +                                                "stop",
> +                                                "spawn";
> +                        status = "okay";

Drop statuses from the example.


Best regards,
Krzysztof

