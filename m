Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC566B1E49
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjCIIfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjCIIfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:35:23 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA8BCA2D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:33:35 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id g3so3941760eda.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 00:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678350813;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/tLHBgVsDTPb9wu0tIc2f2P44AK0lbnBC0FyxkTVNDc=;
        b=bwBj4q+LjBVk+tENjBVu5m5qB4YgfN+WFaWqB83FffU77Z08jWF0F8ay3pdEjI/Wie
         GpQOqaddCjhkqnSpjSnc4PIH+VavwC2PO99lNT0qbk7qMeHT8RoeV3JJFSesU1wz1OEn
         ox1xcbAx0Fui55oMxbYVeVDWbP11lfqWVfYDvbTqbUomfzKqf+0kLFpEOfPVAwTcQ0u7
         2P1EvP+x03oKC5qEv5R+/CmxWfukfBQzdMehHgb66gUPDCELBTsyYuVhRm93mpmU8Np8
         Na4azAEQV5NgSleORhbG2FhpajW9umowLiDCa8evYwCjnBVNnBNKnzy25Qwh39APgZqw
         BzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678350813;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/tLHBgVsDTPb9wu0tIc2f2P44AK0lbnBC0FyxkTVNDc=;
        b=GdzCWVAzon30ebDrKmWpogyErhVRvSmYUKr4Ix4j/T+0V7M5AWmX3Yzsff9E7TkaCg
         xiUipU5bc3VUG8D4aZgseT3AfH2SfBykkeu+Aip5zUuifJh69WdnTsUnNBJgyygwprg0
         UA+SowwP/Spo1cq4aVOdDssa/uYpnGtJRcN41IKeI00iNJIlvKPf5X43kO/K1hzcm4SO
         znR243LdP8XKrv0YCufc6QaaPDClAwjTSxBY/R36RlZx2df/VV7z7buaX+nErpSfPSep
         HrjApfdDbtolXNTu9+t+3z93T823cg7BV0pwonZ53TV5TyQZcuAgKWPNPQwNjLW6sCGj
         1bbw==
X-Gm-Message-State: AO0yUKXJXWg7gxo9b+GZIZextbcS4aGgj122xZeugnUI6t7tW2tnClQq
        n73r6wkKF82/Vn39IuQ//Lv7SdNl3Lo5FDtnQ6c=
X-Google-Smtp-Source: AK7set86MFCaUzuDTjr1QJ2arv7zXxACNqdbrqdAKvBaY8TJ0qzW9KiIoEm5Et2Gz8bfJGZnSoBpZQ==
X-Received: by 2002:a17:906:ee9:b0:8af:2bb3:80d7 with SMTP id x9-20020a1709060ee900b008af2bb380d7mr25149145eji.31.1678350813458;
        Thu, 09 Mar 2023 00:33:33 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:7ee2:e73e:802e:45c1? ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id a8-20020a17090680c800b008cd1f773754sm8441331ejx.5.2023.03.09.00.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 00:33:32 -0800 (PST)
Message-ID: <ea1c0579-1b37-77de-3c47-e5b9772cff70@linaro.org>
Date:   Thu, 9 Mar 2023 09:33:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 3/7] dt-bindings: remoteproc: mpss: Document
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
References: <20230306231202.12223-1-quic_molvera@quicinc.com>
 <20230306231202.12223-4-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230306231202.12223-4-quic_molvera@quicinc.com>
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

On 07/03/2023 00:11, Melody Olvera wrote:
> This documents the compatible for the component used to boot the

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> MPSS on the QDU1000 and QRU1000 SoCs.
> 
> The QDU1000 and QRU1000 mpss boot process now requires the specification
> of an RMB register space to complete the handshake needed to start or
> attach the mpss.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  .../remoteproc/qcom,qdu1000-mpss-pas.yaml     | 130 ++++++++++++++++++
>  1 file changed, 130 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,qdu1000-mpss-pas.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,qdu1000-mpss-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,qdu1000-mpss-pas.yaml
> new file mode 100644
> index 000000000000..9cb4296c1fa6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,qdu1000-mpss-pas.yaml
> @@ -0,0 +1,130 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/qcom,qdu1000-mpss-pas.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm QDU1000 Modem Peripheral Authentication Service
> +
> +maintainers:
> +  - Melody Olvera <quic_molvera@quicinc.com>
> +
> +description:
> +  Qualcomm QDU1000 SoC Peripheral Authentication Service loads and boots firmware
> +  on the Qualcomm DSP Hexagon core.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,qdu1000-mpss-pas
> +
> +  reg:
> +    maxItems: 2

You need to list the items instead (just like for clocks).

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

You can now drop the $ref.

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

maxItems instead

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

memory-region

(I fixed other bindings)

> +
> +allOf:
> +  - $ref: /schemas/remoteproc/qcom,pas-common.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,rpmh.h>
> +    #include <dt-bindings/interconnect/qcom,qdu1000-rpmh.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/mailbox/qcom-ipcc.h>
> +    #include <dt-bindings/power/qcom-rpmpd.h>
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
> +                              <&smp2p_modem_in 3 IRQ_TYPE_EDGE_RISING>,
> +                              <&smp2p_modem_in 7 IRQ_TYPE_EDGE_RISING>;
> +        interrupt-names = "wdog", "fatal", "ready", "handover",
> +                          "stop-ack", "shutdown-ack";
> +
> +        memory-region = <&mpss_mem>, <&dtb_mpss_mem>, <&mpss_dsm_mem>;
> +
> +        firmware-name = "qcom/qdu1000/modem.mbn",
> +                        "qcom/qdu1000/modem_dtb.mbn";
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

Drop stray blank line

> +        };
> +    };

Best regards,
Krzysztof

