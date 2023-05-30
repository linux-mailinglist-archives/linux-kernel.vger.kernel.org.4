Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E73715C60
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjE3K6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjE3K6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:58:17 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050E0196
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:58:12 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-96fe2a1db26so770747466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685444290; x=1688036290;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R5pWU4QsV9gBARzJEPls+6cr2Fd5OnRMlIjkCmxuQh8=;
        b=W0NAk2JVJy/G74q4kpqOkA0pHtjVVKSKn2nq/kPWUmEAjR9mXtgY36AGQUBhLAHzko
         7Sj7GAqhILsZ4qrHuiAMJPtTNcHUIeuAB0It2u0ky02Io1lifZ+ZprjiAW+jaBNYWP68
         +4/GBdY9LqLFZNydW8B6Ck6zwn9y+BpWtdXxRCan4emLsGxJv0Oasa/xB5FiSwPqjeKu
         tG8r4ohWlrg0XRULYGclmpZsfuZXKeo//xSABk8hsUJELxCh5FaQgxxcr9VjW0gJ04X0
         1CcsdvoiKoNjVZhYJutdrwiSRt85SnEIz6tg0weYtQNl8v3ZxyajGLVPfyLI+Im/kN7m
         gOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685444290; x=1688036290;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R5pWU4QsV9gBARzJEPls+6cr2Fd5OnRMlIjkCmxuQh8=;
        b=dtxYYKch3ve4yHPV0B/HJsxPLRWqxq1SlDYeunG4dHhyCtGlWs1oMRncaS9RGov//n
         ShcFXaVE5zIDBc7RhrfVzme8rlxMU1NoYJySeufYGMk08icBjyxkknP+YieZTlAt/91d
         +5ZeHYYZe3WTogCTofeb+DKV6OoTbSXV5p5t8/QtEw+pgTiExwiG3KuMF3e1a3G6av9Z
         HaUTA5taXqtuqBNdeSynI+ffrniGBNQQAi09KxpXsWiiIVJFsX7JvIUe22G4NZEsx7Q+
         SmNHo09Ma42s86ogzjL27ws7v6RqsEVMxB9oLyKj+Yj5VQbar6M9x7hGAvq9uUtRrPNC
         T7xQ==
X-Gm-Message-State: AC+VfDw8RqS2Drc2BMEeyu+Fji7tnNL8p/+I/AT7VtfIO+/bzdbEYzgK
        kqBTr25cUrAGQH4gxInCabYJEg==
X-Google-Smtp-Source: ACHHUZ7jDIiifvdOVGY3NcEyNLrj1sgOTWNjiSIsxMPiuolxBidlIlNWp76Me3UfghtGTD7RsxCafg==
X-Received: by 2002:a17:907:1c14:b0:968:2bb1:f39d with SMTP id nc20-20020a1709071c1400b009682bb1f39dmr2466438ejc.36.1685444290363;
        Tue, 30 May 2023 03:58:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id a9-20020a170906244900b0096629607bb2sm7212134ejb.98.2023.05.30.03.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 03:58:09 -0700 (PDT)
Message-ID: <7940c743-815f-f864-d015-43d7e916ecfa@linaro.org>
Date:   Tue, 30 May 2023 12:58:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 01/13] dt-bindings: remoteproc: qcom: Add support for
 multipd model
Content-Language: en-US
To:     Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jassisinghbrar@gmail.com,
        mathieu.poirier@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, quic_eberman@quicinc.com, quic_mojha@quicinc.com,
        kvalo@kernel.org, loic.poulain@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com, quic_varada@quicinc.com,
        quic_devipriy@quicinc.com
References: <20230521222852.5740-1-quic_mmanikan@quicinc.com>
 <20230521222852.5740-2-quic_mmanikan@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230521222852.5740-2-quic_mmanikan@quicinc.com>
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

On 22/05/2023 00:28, Manikanta Mylavarapu wrote:
> Add new binding document for multipd model remoteproc.
> IPQ5018, IPQ9574 follows multipd model.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
> Changes in V2:
> 	- Fixed all comments and rebased for TOT.
> 	- Changed to BSD-3-Clause based on internal open source team
>           suggestion.
> 	- Added firmware-name.
> 
>  .../bindings/remoteproc/qcom,multipd-pil.yaml | 265 ++++++++++++++++++
>  1 file changed, 265 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml
> new file mode 100644
> index 000000000000..3257f27dc569
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,multipd-pil.yaml
> @@ -0,0 +1,265 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
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

... boots Q6 Protection Domain (PD), WCSS PD ...

> +  remoteproc's on the Qualcomm IPQ5018, IPQ9574 SoC.

> Pd means protection
> +  domain. 

so you can skip this sentence as it is explained already.

> It's similar to process in Linux. Here QDSP6 processor runs each
> +  wifi radio functionality on a separate process. One process can't access
> +  other process resources, so this is termed as PD i.e protection domain.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,ipq5018-q6-mpd
> +      - qcom,ipq9574-q6-mpd
> +
> +  reg:
> +    maxItems: 1
> +
> +  firmware-name:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description: Firmware name of the Hexagon core

No need for ref and description. Instead maxItems.

> +
> +  interrupts-extended:
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
> +  qcom,smem-states:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: States used by the AP to signal the remote processor
> +    items:
> +      - description: Shutdown Q6
> +      - description: Stop Q6
> +
> +  qcom,smem-state-names:
> +    description:
> +      Names of the states used by the AP to signal the remote processor
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
> +  "^pd-1|pd-2|pd-3":
> +    type: object
> +    description:
> +      In Multipd model, WCSS pd depends on Q6 pd i.e Q6 pd should be up before
> +      WCSS. It can be achieved by keeping wcss pd node as subnode of Q6
> +      device node.

That's not enough. Your description does not say what is this, why you
have two protection domains for same compatible. What's more, it a bit
deviates from hardware description.

> +
> +    properties:
> +      compatible:
> +        enum:
> +          - qcom,ipq5018-wcss-ahb-mpd
> +          - qcom,ipq9574-wcss-ahb-mpd
> +          - qcom,ipq5018-wcss-pcie-mpd

Keep rather alphabetical order (so both 5018 together).

I also do not understand these at all. Why adding bus type to
compatible? This rarely is allowed (unless it is PCIe controller within
soc).

> +
> +      firmware-name:
> +        $ref: /schemas/types.yaml#/definitions/string-array
> +        items:
> +          - description: Firmware name of the Hexagon core

same comments

> +
> +      interrupts-extended:
> +        items:
> +          - description: Fatal interrupt
> +          - description: Ready interrupt
> +          - description: Spawn acknowledge interrupt
> +          - description: Stop acknowledge interrupt

ditto

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
> +        description: States used by the AP to signal the remote processor
> +        items:
> +          - description: Shutdown WCSS pd
> +          - description: Stop WCSS pd
> +          - description: Spawn WCSS pd
> +
> +      qcom,smem-state-names:
> +        description:
> +          Names of the states used by the AP to signal the remote processor
> +        items:
> +          - const: shutdown
> +          - const: stop
> +          - const: spawn
> +
> +    required:
> +      - compatible
> +      - firmware-name
> +      - interrupts-extended
> +      - interrupt-names
> +      - qcom,smem-states
> +      - qcom,smem-state-names
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - firmware-name
> +  - reg
> +  - interrupts-extended
> +  - interrupt-names
> +  - qcom,smem-states
> +  - qcom,smem-state-names
> +  - memory-region
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,ipq5018-q6-mpd
> +    then:
> +      properties:
> +        firmware-name:
> +          items:
> +            - const: IPQ5018/q6_fw.mdt
> +            - const: IPQ5018/m3_fw.mdt
> +            - const: qcn6122/m3_fw.mdt

No, names are not part of bindings. Also paths do not look correct. Open
linux-firmware package and verify these are good...

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,ipq9574-q6-mpd
> +    then:
> +      properties:
> +        firmware-name:
> +          items:
> +            - const: IPQ9574/q6_fw.mdt
> +            - const: IPQ9574/m3_fw.mdt

Drop.

> +
> +unevaluatedProperties: false

This changed... why?


Best regards,
Krzysztof

