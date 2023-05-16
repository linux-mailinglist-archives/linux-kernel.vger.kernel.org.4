Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1447044F6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 08:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjEPGCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 02:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjEPGCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 02:02:43 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1B11717
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 23:02:41 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-94a342f7c4cso2501861366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 23:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684216960; x=1686808960;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sfjhG+Ne7Y5TLnloHP6begQ4lwb2hq072sAiG6jl4gM=;
        b=OQEsvb8JiGlepasDiNuylV4qnMPpUV8gqo2rMegkqs2o9I8OBWGGVrsnseIxbtrI8X
         YF17D26RCQfBtupjcQ/eh0tP4e38mFDSAcIpI+q10t8DAhjoV1aiV75BBmFSEFIXIJt7
         VtVofM4sLNh5bxUmSZbgJfANJl+qFagdEB5Ziq8Tv5rKNvDk9sDRICbGDdMgDwgphSdX
         wVma5+QLSINTVrqzgiqtZtr0/UhZr1WIXDJecf1AytvmV2pz7NXfbNDjqBpcNNlgRcL2
         ylXrJ+12OeWnxWN+u3s4PJrwmwktCA0NKyJ2ZSjJO3PICjQujVpCKpBKz19R4AYfWgZk
         ICcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684216960; x=1686808960;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sfjhG+Ne7Y5TLnloHP6begQ4lwb2hq072sAiG6jl4gM=;
        b=AhhUdrjjnLxLaTtU5//1KH0miR+97pcDmqaEOOMkwdWhKD2eXrtn04LoRyktJSBr6N
         cn0PFXBdW/dsELLdtmegoP5gEhiQ+A5U4jpi2pcYSqDM74Z5aOLJ7iJjPY4O7F9dbL8O
         G3wXBJaRbCBDoPtb//kswtT4QJqD7ZvjS5jZK+mNXTe86xYef/PQ/pNLHAKqVRStgnTt
         pg0CWPLrdwB1ZvNvxtcFBPE0NuM2gVW1tdod+bFI35ZLQcYINfcfNO16iq0meY6Q67IR
         rPpXue8+uzJF3gmKktWZ0IsheTzWXAaegCqyJ5QnsoZI1x292ByGt7tYxeky2aVy5rNt
         ryUA==
X-Gm-Message-State: AC+VfDyR+q4qavL1dvqi3XrGTMlB8GFSdI2f++vGIwIVyCRImEhIlDkB
        byg/lzP8YUHeL99xRDFf56vbaTRcvMFpSjWe66dmKXzLmCaMsuDH
X-Google-Smtp-Source: ACHHUZ5Q6xDdVHcpyb3P9WZksfe8mkak5mY3QWZFWD2eqsA2nsYV3lw4TEnUErqsWhEAIyAW6mL+ipdtjdYwAjka6QA=
X-Received: by 2002:a17:906:ef0d:b0:94e:e9c1:1932 with SMTP id
 f13-20020a170906ef0d00b0094ee9c11932mr36406209ejs.43.1684216959675; Mon, 15
 May 2023 23:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230506073235.2770292-1-etienne.carriere@linaro.org>
In-Reply-To: <20230506073235.2770292-1-etienne.carriere@linaro.org>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Tue, 16 May 2023 08:02:28 +0200
Message-ID: <CAN5uoS-U1h_Fx1K4PtnK3vHmyfUUS6wqCcSfhoaV=idgEOC04Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: optee: add interrupt controller properties
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Pascal Paillet <p.paillet@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

On Sat, 6 May 2023 at 09:33, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> Adds an optional interrupt controller property to optee firmware node
> in the DT bindings. Optee driver may embeds an irqchip exposing
> OP-TEE interrupt events notified by the TEE world. Optee registers up
> to 1 interrupt controller and identifies each line with a line
> number from 0 to UINT16_MAX.
>
> The identifiers and meaning of the interrupt line number are specific
> to the platform and shall be found in the OP-TEE platform documentation.
>
> In the example shown in optee DT binding documentation, the platform SCMI
> device controlled by Linux scmi driver uses optee interrupt irq 5 as
> signal to trigger processing of an asynchronous incoming SCMI message
> in the scope of a CPU DVFS control. A platform can have several SCMI
> channels driven this way. Optee irqs also permit small embedded devices
> to share e.g. a gpio expander, a group of wakeup sources, etc... between
> OP-TEE world (for sensitive services) and Linux world (for non-sensitive
> services). The physical controller is driven from the TEE which exposes
> some controls to Linux kernel.
>
> Cc: Jens Wiklander <jens.wiklander@linaro.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Co-developed-by: Pascal Paillet <p.paillet@foss.st.com>
> Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---

Any feedback on this change proposal?

Regards,
Etienne

> Changes since v4:
> - Removed empty line between Cc: tags and S-o-b tags.
>
> No changes since v3
>
> Changes since v2:
> - Added a sentence on optee irq line number values and meaning, in
>   DT binding doc and commit message.
> - Updated example in DT binding doc from comment, fixed misplaced
>   interrupt-parent property and removed gic and sram shm nodes.
>
> Changes since v1:
> - Added a description to #interrupt-cells property.
> - Changed of example. Linux wakeup event was subject to discussion and
>   i don't know much about input events in Linux. So move to SCMI.
>   In the example, an SCMI server in OP-TEE world raises optee irq 5
>   so that Linux scmi optee channel &scmi_cpu_dvfs pushed in the incoming
>   SCMI message in the scmi device for liekly later processing in threaded
>   context. The example includes all parties: optee, scmi, sram, gic.
> - Obviously rephrased the commit message.
> ---
>  .../arm/firmware/linaro,optee-tz.yaml         | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> index 5d033570b57b..9d9a797a6b2f 100644
> --- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> +++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> @@ -41,6 +41,16 @@ properties:
>        HVC #0, register assignments
>        register assignments are specified in drivers/tee/optee/optee_smc.h
>
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 1
> +    description: |
> +      OP-TEE exposes irq for irp chip controllers from OP-TEE world. Each
> +      irq is assigned a single line number identifier used as first argument.
> +      Line number identifiers and their meaning shall be found in the OP-TEE
> +      firmware platform documentation.
> +
>  required:
>    - compatible
>    - method
> @@ -65,3 +75,31 @@ examples:
>              method = "hvc";
>          };
>      };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    firmware  {
> +        optee: optee {
> +            compatible = "linaro,optee-tz";
> +            method = "smc";
> +            interrupt-parent = <&gic>;
> +            interrupts = <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>;
> +            interrupt-controller;
> +            #interrupt-cells = <1>;
> +        };
> +
> +        scmi {
> +            compatible = "linaro,scmi-optee";
> +            linaro,optee-channel-id = <0>;
> +            shmem = <&scmi_shm_tx>, <&scmi_shm_rx>;
> +            interrupts-extended = <&optee 5>;
> +            interrupt-names = "a2p";
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            scmi_cpu_dvfs: protocol@13 {
> +                reg = <0x13>;
> +                #clock-cells = <1>;
> +            };
> +        };
> +    };
> --
> 2.25.1
>
