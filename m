Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D515E809F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiIWRXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiIWRXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:23:35 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97950147690
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:23:30 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u18so1310000lfo.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=S/eOVwAJObSNguh0+3x3BkIgxOBP5Z+/Ums6rpypzBo=;
        b=PBQIM2dxcEi/RE2tW/4Gnm0hjzn9IppdA7bDjrg0WbFX8h02maVjZrhVUATLKyGypa
         m4OyxHt6Bab60HrXwPF0h2HPjfYaCVBkuCJ3sZa6aYPjrqPC75LQdH8SnSbivjigT9jh
         V5CAI+Ue8FR5Sj3wsumFES+Xv9pFKwSUfdbAmrffKoQLNKDx2TnEVKmmuwR9yCbKopIM
         pKRdCI3r9sQt7TMF6p43Edx/feIVYmdi0gfVV3pc1P5243jUxOKOLAmgW62E7KL18vfZ
         cDQZptJ9WZIOvL3P71vK6+L/qbov2BzBwc0TSV+0CMHPNAgNdhyNeIF5vDxXDj1+4B4L
         GCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=S/eOVwAJObSNguh0+3x3BkIgxOBP5Z+/Ums6rpypzBo=;
        b=MsbH6Jw2uHcXv1U71uR+s0tKKUVyuWB4sAu6n3c0E5uu99eyasaViinvmNcfNUOHSJ
         /YdlJmI//HcQTfVuDR03BQfMiwpFR4C4snW/lJCg7QDsEw0gbCZU5oHe2Ojzcdc92Vqm
         Wi1K0d18wyQcxfaftXnQ6i2eRJyNbAnCvv/DwSRlPAT3uJYlgtIpQw2qOWLi4Dyssr7U
         i+9E+jK/5xB2cXR014QVS2FMqntgh5IjOwKfTeCydNLBctG0FJV0W8QMQ8EE+Mhgwn7O
         oMKxI5kQgwnojXAzWc2iCSUj+Mi9YXa66twzWjvh/XDGkRkA1ps3cS9wUutSF0XSbspm
         A03A==
X-Gm-Message-State: ACrzQf2HbhZONNK7rbPUyhhGovSaF327y/XPcXzLxWHZils4Tu3eZU1E
        oWETOQxNpG0RNqoUjb59E1sAdA==
X-Google-Smtp-Source: AMsMyM5YbjqAB30MDGIa7Gr77pd7Aym9gxou0mLRVx8oDoY/HHKSgpGmIpW8HZlPbFNqrlc1nQQOOQ==
X-Received: by 2002:a05:6512:ac3:b0:498:f076:6281 with SMTP id n3-20020a0565120ac300b00498f0766281mr3556390lfu.68.1663953808782;
        Fri, 23 Sep 2022 10:23:28 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id e2-20020a05651236c200b00494791fbd80sm1520577lfs.307.2022.09.23.10.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 10:23:28 -0700 (PDT)
Message-ID: <7d001153-e1f2-7ae6-2821-4b3547ccf034@linaro.org>
Date:   Fri, 23 Sep 2022 19:23:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v8 1/7] dt-bindings: remoteproc: qcom: Add SC7280 ADSP
 support
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-remoteproc@vger.kernel.org, agross@kernel.org,
        andersson@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, quic_plai@quicinc.com, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, devicetree@vger.kernel.org
References: <1663938340-24345-1-git-send-email-quic_srivasam@quicinc.com>
 <1663938340-24345-2-git-send-email-quic_srivasam@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1663938340-24345-2-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2022 15:05, Srinivasa Rao Mandadapu wrote:
> Add ADSP PIL loading support for SC7280 SoCs.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
> Changes since V7:
> 	-- Remove redundant clocks in dt bindings.
> 	-- Fix dt compilation error in dt bindings.
> Changes since V6:
> 	-- Update glink-edge property.
> 	-- Add qcom,qmp property.
> Changes since V5:
> 	-- Remove qcom,adsp-memory-regions property.
> Changes since V4:
> 	-- Update halt registers description in dt bindings.
> 
>  .../bindings/remoteproc/qcom,sc7280-adsp-pil.yaml  | 207 +++++++++++++++++++++
>  1 file changed, 207 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
> new file mode 100644
> index 0000000..79ef3c0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-adsp-pil.yaml
> @@ -0,0 +1,207 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/qcom,sc7280-adsp-pil.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SC7280 ADSP Peripheral Image Loader
> +
> +maintainers:
> +  - Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> +
> +description:
> +  This document describes the hardware for a component that loads and boots firmware
> +  on the Qualcomm Technology Inc. ADSP.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sc7280-adsp-pil
> +
> +  reg:
> +    minItems: 1
> +    items:
> +      - description: qdsp6ss register
> +      - description: efuse q6ss register

Why second IO address space is optional?

> +
> +  interrupts:
> +    items:
> +      - description: Watchdog interrupt
> +      - description: Fatal interrupt
> +      - description: Ready interrupt
> +      - description: Handover interrupt
> +      - description: Stop acknowledge interrupt
> +      - description: Shutdown acknowledge interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: wdog
> +      - const: fatal
> +      - const: ready
> +      - const: handover
> +      - const: stop-ack
> +      - const: shutdown-ack
> +
> +  clocks:
> +    items:
> +      - description: XO clock
> +      - description: GCC CFG NOC LPASS clock
> +
> +  clock-names:
> +    items:
> +      - const: xo
> +      - const: gcc_cfg_noc_lpass
> +
> +  power-domains:
> +    items:
> +      - description: LCX power domain
> +
> +  resets:
> +    items:
> +      - description: PDC AUDIO SYNC RESET
> +      - description: CC LPASS restart
> +
> +  reset-names:
> +    items:
> +      - const: pdc_sync
> +      - const: cc_lpass
> +
> +  memory-region:
> +    maxItems: 1
> +    description: Reference to the reserved-memory for the Hexagon core
> +
> +  qcom,halt-regs:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      Phandle reference to a syscon representing TCSR followed by the
> +      four offsets within syscon for q6, CE, AXI and qv6 halt registers.
> +    items:
> +      items:

This has to be strictly defined, IOW, the second items must be already
an item of previous list. Look at the other mss-pil.

> +        - description: phandle to TCSR MUTEX
> +        - description: offset to q6 halt registers
> +        - description: offset to CE halt registers
> +        - description: offset to AXI halt registers
> +        - description: offset to qv6 halt registers
> +
> +  qcom,smem-states:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: States used by the AP to signal the Hexagon core
> +    items:
> +      - description: Stop the modem
> +
> +  qcom,smem-state-names:
> +    description: The names of the state bits used for SMP2P output
> +    const: stop
> +
> +  qcom,qmp:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Reference to the AOSS side-channel message RAM.
> +
> +  glink-edge:
> +    type: object

Missing ref to glink-edge and unevaluatedProperties:false. Please take a
look at recent
Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml

> +    description: |
> +      Qualcomm G-Link subnode which represents communication edge, channels
> +      and devices related to the ADSP.
> +
> +    properties:
> +      interrupts:
> +        items:
> +          - description: IRQ from ADSP to GLINK

Skip interrupts and mboxes - both are coming from glink-edge.

> +
> +      mboxes:
> +        items:
> +          - description: Mailbox for communication between APPS and ADSP
> +
> +      label:
> +        description: The names of the state bits used for SMP2P output

Skip description

> +        items:
> +          - const: lpass

No items, just const: lpass

> +
> +      qcom,remote-pid:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: ID of the shared memory used by GLINK for communication with ADSP

This can be dropped.

> +
> +      gpr: true
> +      apr: false
> +      fastrpc: false


BTW, all these three do not make sense without ref to glink-edge. After
adding ref, these seem reasonable.

> +
> +    required:
> +      - interrupts
> +      - mboxes
> +      - label
> +      - qcom,remote-pid
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - resets
> +  - reset-names
> +  - qcom,halt-regs
> +  - memory-region
> +  - qcom,smem-states
> +  - qcom,smem-state-names
> +  - qcom,qmp
> +
> +additionalProperties: false

Best regards,
Krzysztof

