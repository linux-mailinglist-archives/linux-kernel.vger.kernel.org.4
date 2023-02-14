Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E2A695CF0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjBNI2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjBNI2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:28:41 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A990F6A70
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:28:38 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id az4-20020a05600c600400b003dff767a1f1so10920913wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J4OTbvAyDNRuQNPpEdEO/ch9kURlca8zCvaPs3Ht8yY=;
        b=regc07LLlR85Obo2IjGB3+meMxxtgoUllAqj+sEICOZyRttPY0h7P89DTb2Sweosi5
         hKUTEv35w3u+OQ4OLRDbfNAJtR5pq76Mj8wmlaoRxZmtFLmXcmk3jTmFNWZjcMKTL62m
         c2dPGkg1oED/zjQUWvN1WDgP6GDl2G+l++PisckTBEoL/pXAPyDIm+6Omka4ujh14EBg
         skJFgD89pOURxOP/Ry2aehXmlCkxus4NW8bmDEr5uiabfqXv3UgDhYJriHCYNvgE09lr
         e43H1Sd5EoWkHRBCfs1n6C2IlpFj53Z91wuoztI8tgo6OYOlUaH178/FKwpK6krh3uKg
         kVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J4OTbvAyDNRuQNPpEdEO/ch9kURlca8zCvaPs3Ht8yY=;
        b=aQ5ZVy0i8k7y5bDzVEJcyLsY7eOgZUUbXuMGAkaGTtPzTCN4DtAixa+70ouTv5YAoN
         mWPIh4ZrDMW/cT4BhfrYyTR7JkWj9SC2cVTM7sXvlPhBf6hVsm3O0sWQgRxvXdk0gHjW
         zqnAA8JHmymEvAPhCviJ4KAar6U+SJ+qZzIn1dviTgI3tFFUjRp+84o7HgUvuQ5sUNwj
         uzmc65KvBgf+KfSlS1yY2VXGxep5k5qHzm2WQedzoZuFgG6eQMC2Nqfh9aevTiamfWTt
         czqVRilGEEq3adXXoRD+eETTIjh6eL1aM1tCqzNUKlO/M7H8kZNf1/WbaIsLGVMwfuFT
         8qYw==
X-Gm-Message-State: AO0yUKV35XNYVgQVsEwD2I8DIfZRvekFsX2djbcdSo0kkFrkc6bxnKy5
        s601Cp3FlFWhdw5U3+Z8EHq4uA==
X-Google-Smtp-Source: AK7set/+0Q9mSK4x5OCo4ro65AiB0eTqg69bnbvds4LDkrWCfEonZr+/Syx4ot9MC8pY52xE99sgMA==
X-Received: by 2002:a05:600c:3acd:b0:3d3:4f99:bb32 with SMTP id d13-20020a05600c3acd00b003d34f99bb32mr1209415wms.36.1676363317183;
        Tue, 14 Feb 2023 00:28:37 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bg30-20020a05600c3c9e00b003db012d49b7sm2232707wmb.2.2023.02.14.00.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 00:28:36 -0800 (PST)
Message-ID: <aba45ae9-8558-50c1-e5ad-dd910dacdbb3@linaro.org>
Date:   Tue, 14 Feb 2023 09:28:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 5/9] dt-bindings: remoteproc: mpss: Document
 QDU1000/QRU1000 mpss devices
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20230213185218.166520-1-quic_molvera@quicinc.com>
 <20230213185218.166520-6-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230213185218.166520-6-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 19:52, Melody Olvera wrote:
> This documents the compatible for the component used to boot the
> MPSS on the QDU1000 and QRU1000 SoCs.
> 
> The QDU1000 and QRU1000 mpss boot process now requires the specification
> of an RMB register space to complete the handshake needed to start or
> attach the mpss.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  .../bindings/remoteproc/qcom,qdu1000-pas.yaml | 127 ++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,qdu1000-pas.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,qdu1000-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,qdu1000-pas.yaml
> new file mode 100644
> index 000000000000..eb6ade984778
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,qdu1000-pas.yaml
> @@ -0,0 +1,127 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/qcom,qdu1000-pas.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm QDU1000 Peripheral Authentication Service
> +
> +maintainers:
> +  - Melody Olvera <quic_molvera@quicinc.com>
> +
> +description:
> +  Qualcomm QDU1000 SoC Peripheral Authentication Service loads and boots firmware
> +  on the Qualcomm DSP Hexagon cores.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,qdu1000-mpss-pas

What about other remote processors? The subject prefix suggests it is
only for mpss, but filename is different.

> +
> +  reg:
> +    maxItems: 2
> +
> +  clocks:
> +    items:
> +      - description: XO clock
> +
> +  clock-names:
> +    items:
> +      - const: xo
> +
> +  qcom,qmp:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Reference to the AOSS side-channel message RAM.
> +
> +  smd-edge: false
> +
> +  firmware-name:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    items:
> +      - description: Firmware name of the Hexagon core
> +      - description: Firmware name of the Hexagon Devicetree
> +
> +  memory-region:
> +    items:
> +      - description: Memory region for main Firmware authentication
> +      - description: Memory region for Devicetree Firmware authentication
> +      - description: DSM Memory region
> +
> +  interrupts:
> +    minItems: 6
> +
> +  interrupt-names:
> +    minItems: 6
> +
> +  interconnects:
> +    minItems: 1

You can drop the property. It's coming from qcom,pas-common.yaml

> +
> +  power-domains:
> +    items:
> +      - description: CX power domain
> +      - description: MSS power domain
> +
> +  power-domain-names:
> +    items:
> +      - const: cx
> +      - const: mss
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: /schemas/remoteproc/qcom,pas-common.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,rpmh.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/mailbox/qcom-ipcc.h>
> +
> +    remoteproc@4080000 {
> +        compatible = "qcom,qdu1000-mpss-pas";
> +        reg = <0x4080000 0x4040>,
> +              <0x4180000 0x1000>;
> +
> +        clocks = <&rpmhcc RPMH_CXO_CLK>;
> +        clock-names = "xo";
> +
> +        interrupts-extended = <&intc GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
> +                              <&smp2p_modem_in 0 IRQ_TYPE_EDGE_RISING>,
> +                              <&smp2p_modem_in 1 IRQ_TYPE_EDGE_RISING>,
> +                              <&smp2p_modem_in 2 IRQ_TYPE_EDGE_RISING>,
> +                              <&smp2p_modem_in 3 IRQ_TYPE_EDGE_RISING>
> +                              <&smp2p_modem_in 7 IRQ_TYPE_EDGE_RISING>;
> +        interrupt-names = "wdog", "fatal", "ready", "handover",
> +                          "stop-ack", "shutdown-ack";
> +
> +        memory-region = <&mpss_mem>, <&dtb_mpss_mem>, <&mpss_dsm_mem>;
> +
> +        firmware-name = "modem.mdt",
> +                        "modem_dtb.mdt";
> +
> +        power-domains = <&rpmhpd QDU1000_CX>,
> +                        <&rpmhpd QDU1000_MSS>;
> +        power-domain-names = "cx", "mss";
> +
> +        interconnects = <&mc_virt MASTER_LLCC &mc_virt SLAVE_EBI1>;
> +
> +        qcom,qmp = <&aoss_qmp>;
> +
> +        qcom,smem-states = <&smp2p_adsp_out 0>;
> +        qcom,smem-state-names = "stop";
> +
> +        glink-edge {
> +            interrupts-extended = <&ipcc IPCC_CLIENT_MPSS
> +                                         IPCC_MPROC_SIGNAL_GLINK_QMP
> +                                         IRQ_TYPE_EDGE_RISING>;
> +            mboxes = <&ipcc IPCC_CLIENT_MPSS IPCC_MPROC_SIGNAL_GLINK_QMP>;
> +
> +            label = "modem";
> +            qcom,remote-pid = <2>;
> +

Drop blank line

> +        };
> +    };

Best regards,
Krzysztof

