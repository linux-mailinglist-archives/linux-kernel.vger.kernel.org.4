Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD046AEF0F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjCGSTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbjCGSTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:19:18 -0500
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898739E67C;
        Tue,  7 Mar 2023 10:13:40 -0800 (PST)
Received: by mail-oo1-f50.google.com with SMTP id o19-20020a056820041300b005259de79accso2160817oou.9;
        Tue, 07 Mar 2023 10:13:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678212819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVYR7iCf0Df+fEXPePrJvbhIP5bkr3lqWWb+w4AwRWk=;
        b=IZfad8LvQwb8QHz6s8Hjs/vnZz8N0+8QkinO+X0iRaMYywru6SEs6bdQ8+u31xHCRp
         YMWavxAonOR16PdwRLTohkXWRGbT2610fjHLYgxSVKOaHxxgku6QQD3LWQI96SvKicyk
         LR4sztSHHeECdZJR6+mRkls03oj+t30zWtjuBlwY6/oR2ocqwmxTyd2J8lPdzZ4ppArh
         b0u6XoItQ7TFSYAbitnaJ1py5Ak+drJ5yNNaJOJyIc0QaRIoRWZuh+gFckN6dakJnhFM
         PGBReRAGQXyfBWcPI/Z8k0bzC1t/HtgpvTTMn4aDi/DPq0x0HCJGIWFlt2AWc4z3Ut5x
         72VQ==
X-Gm-Message-State: AO0yUKXemqGFqURFZMk/51NwkNKaMc2pJfbmgt0j2kUTsXWPoHtV8fI6
        J10feE8HzBjJ5yxpEmLxTw==
X-Google-Smtp-Source: AK7set8eLT156rIwA09j47KeETEgRAy4QOXPej01e007ZSnYi5Kuz2t5OdgI72EGvup7N2c453icNw==
X-Received: by 2002:a4a:d1b1:0:b0:525:a9ad:e2b9 with SMTP id z17-20020a4ad1b1000000b00525a9ade2b9mr7501603oor.6.1678212819442;
        Tue, 07 Mar 2023 10:13:39 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j15-20020a4adf4f000000b0051fce47fd1bsm608094oou.25.2023.03.07.10.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 10:13:38 -0800 (PST)
Received: (nullmailer pid 2797 invoked by uid 1000);
        Tue, 07 Mar 2023 14:26:14 -0000
Date:   Tue, 7 Mar 2023 08:26:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        mathieu.poirier@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, quic_gurus@quicinc.com, loic.poulain@linaro.org,
        quic_eberman@quicinc.com, robimarko@gmail.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-clk@vger.kernel.org, quic_srichara@quicinc.com,
        quic_gokulsri@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com, quic_poovendh@quicinc.com
Subject: Re: [PATCH 01/11] dt-bindings: remoteproc: qcom: Add support for
 multipd model
Message-ID: <20230307142614.GA2742-robh@kernel.org>
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
 <1678164097-13247-2-git-send-email-quic_mmanikan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1678164097-13247-2-git-send-email-quic_mmanikan@quicinc.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 10:11:27AM +0530, Manikanta Mylavarapu wrote:
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

What is PD? I don't see it defined anywhere.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,ipq5018-q6-mpd
> +      - qcom,ipq9574-q6-mpd
> +
> +  '#address-cells': true

Need to define the size.

> +
> +  '#size-cells': true

ditto

> +
> +  'ranges': true

Don't need quotes

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts-extended:

Just 'interrupts'. Both forms are always supported.

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

You need to list out what the clocks are.

> +
> +  clock-names:
> +    minItems: 25
> +    maxItems: 25
> +
> +  assigned-clocks:

You can drop this. Implicitly supported.

> +    minItems: 13
> +    maxItems: 13
> +
> +  assigned-clock-rates:
> +    minItems: 13
> +    maxItems: 13
> +
> +  qcom,smem-states:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array

I believe this already has a type. It should be defined in a common 
schema if not already and then included in this schema.

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
> +    description:
> +      Qualcomm G-Link subnode which represents communication edge, channels
> +      and devices related to the Modem.
> +
> +patternProperties:
> +  "^remoteproc_pd1|remoteproc_pd2|remoteproc_pd3":
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

Don't need quotes.

> +          - "qcom,ipq9574-wcss-ahb-mpd"
> +          - "qcom,ipq5018-wcss-pcie-mpd"
> +
> +      interrupts-extended:

Just interrupts

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
> +        items:
> +          - const: shutdown
> +          - const: stop
> +          - const: spawn
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

Don't need to define assigned-clocks

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
> +
> +examples:
> +  - |
> +        #include <dt-bindings/interrupt-controller/arm-gic.h>
> +        #include <dt-bindings/clock/qcom,gcc-ipq5018.h>
> +        #include <dt-bindings/reset/qcom,gcc-ipq5018.h>
> +
> +        q6v5_wcss: remoteproc@cd00000 {
> +                compatible = "qcom,ipq5018-q6-mpd";
> +                #address-cells = <1>;
> +                #size-cells = <1>;
> +                ranges;
> +                reg = <0x0cd00000 0x4040>;
> +                interrupts-extended = <&intc GIC_SPI 291 IRQ_TYPE_EDGE_RISING>,
> +                                <&wcss_smp2p_in 0 0>,
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

Don't need status in examples.

> +                };
> +
> +                q6_wcss_pd3: remoteproc_pd3 {
> +                        compatible = "qcom,ipq5018-wcss-pcie-mpd";
> +                        interrupts-extended = <&wcss_smp2p_in 24 0>,
> +                                        <&wcss_smp2p_in 25 0>,
> +                                        <&wcss_smp2p_in 28 0>,
> +                                        <&wcss_smp2p_in 27 0>;
> +                        interrupt-names = "fatal",
> +                                          "ready",
> +                                          "spawn-ack",
> +                                          "stop-ack";
> +
> +                        qcom,smem-states = <&wcss_smp2p_out 24>,
> +                                           <&wcss_smp2p_out 25>,
> +                                           <&wcss_smp2p_out 26>;
> +                        qcom,smem-state-names = "shutdown",
> +                                                "stop",
> +                                                "spawn";
> +                        status = "okay";
> +                };
> +        };
> -- 
> 2.34.1
> 
