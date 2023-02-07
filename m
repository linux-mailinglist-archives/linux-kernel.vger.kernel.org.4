Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A3968E043
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjBGSmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjBGSmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:42:37 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E42F1D932;
        Tue,  7 Feb 2023 10:42:32 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id j21so13457203oie.4;
        Tue, 07 Feb 2023 10:42:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2icQ5Fp+IDnNC5zeg6x03sM+CsHzpiEiy2Xw8uOlOmU=;
        b=O2DoERdk1I331FmnDfxCOGuZGNpsOtNSqNlC4Hlfl+NwGlrEfQXiCmnx3l6Aeys0nI
         Z2zPC/2vnvz+T3ufq5Co9mgXB5SfxFEDQKFXXd532mHsiz+wH/Ep+vrl9lknb9ivEdbx
         ueSN7CpNUV1DXiSdMsfBg+hojCAXpyK2/IVaS5LIxa4SxhcXw59Bfc3xdQv4c/kOS6AV
         nCul8YAK9QUge9X4q5QOOVVBY/Y1Qsex3fILk723CAHKKOo4FuAbvaBN5ACFldwTjSg5
         nZ37TPT/iuF9g4omgeNGmnSR1QtvdRIhEsnbAI2dL3evWw/XjtrRxWo1BW72lY8dje+7
         mZSg==
X-Gm-Message-State: AO0yUKWVZSVxfsEBFA3RD1RIIpUHsOfwg39pOzJPtX6g7+3wVLRuUU2Y
        lsXzvLQtyvjnWTmxKTOzxjnHy5vRGw==
X-Google-Smtp-Source: AK7set8uweDyU9yiFlCWli2s3vExdzZcK/6akymchpiN7m38qYdRkTp6u32UfHE9e0YKnvbZljiEtA==
X-Received: by 2002:a05:6808:8c3:b0:37a:daa1:baf8 with SMTP id k3-20020a05680808c300b0037adaa1baf8mr1725944oij.48.1675795351224;
        Tue, 07 Feb 2023 10:42:31 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o8-20020a0568080f8800b003547a3401e6sm5861129oiw.43.2023.02.07.10.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 10:42:30 -0800 (PST)
Received: (nullmailer pid 3953929 invoked by uid 1000);
        Tue, 07 Feb 2023 18:42:30 -0000
Date:   Tue, 7 Feb 2023 12:42:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: remoteproc: qcom,glink-rpm-edge:
 convert to DT schema
Message-ID: <20230207184230.GA3950598-robh@kernel.org>
References: <20230207090852.28421-1-krzysztof.kozlowski@linaro.org>
 <20230207090852.28421-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207090852.28421-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 10:08:51AM +0100, Krzysztof Kozlowski wrote:
> Convert Qualcomm G-Link RPM edge binding to DT schema.  Move it to
> remoteproc as it better suits the purpose - communication channel with
> remote processor.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../remoteproc/qcom,glink-rpm-edge.yaml       | 92 ++++++++++++++++++
>  .../bindings/soc/qcom/qcom,glink.txt          | 94 -------------------
>  2 files changed, 92 insertions(+), 94 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml
>  delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,glink.txt
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml
> new file mode 100644
> index 000000000000..07cd67ec97c1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,glink-rpm-edge.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/qcom,glink-rpm-edge.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm G-Link RPM edge
> +
> +description: |
> +  Qualcomm G-Link edge, a FIFO based mechanism for communication with Resource
> +  Power Manager (RPM) on various Qualcomm platforms.
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +
> +properties:
> +  compatible:
> +    const: qcom,glink-rpm
> +
> +  label:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Name of the edge, used for debugging and identification purposes. The
> +      node name will be used if this is not present.
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  mboxes:
> +    items:
> +      - description: rpm_hlos mailbox in APCS
> +
> +  qcom,remote-pid:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      The identifier for the remote processor as known by the rest of the
> +      system.
> +
> +  qcom,rpm-msg-ram:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: |
> +      RPM message memory resource (compatible:: qcom,rpm-msg-ram).

'::' is not a thing in YAML.

> +
> +  rpm-requests:
> +    type: object
> +    $ref: /schemas/soc/qcom/qcom,smd-rpm.yaml#
> +    unevaluatedProperties: false
> +    description:
> +      Qualcomm Resource Power Manager (RPM) over G-Link
> +
> +    properties:
> +      qcom,intents:
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        description:
> +          List of (size, amount) pairs describing what intents should be

pairs? Sounds like a matrix then.

> +          preallocated for this virtual channel. This can be used to tweak the
> +          default intents available for the channel to meet expectations of the
> +          remote.
> +
> +    required:
> +      - qcom,glink-channels
> +
> +required:
> +  - compatible
> +  - interrupts
> +  - mboxes
> +
> +anyOf:
> +  - required:
> +      - qcom,remote-pid
> +  - required:
> +      - qcom,rpm-msg-ram
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    rpm-glink {
> +        compatible = "qcom,glink-rpm";
> +        interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> +        mboxes = <&apcs_glb 0>;
> +        qcom,rpm-msg-ram = <&rpm_msg_ram>;
> +
> +        rpm-requests {
> +            compatible = "qcom,rpm-msm8996";
> +            qcom,glink-channels = "rpm_requests";
> +
> +            /* ... */
> +        };
> +    };
