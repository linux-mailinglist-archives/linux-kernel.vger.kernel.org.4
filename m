Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED63C67BC76
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236336AbjAYUWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbjAYUWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:22:18 -0500
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7842F5925D;
        Wed, 25 Jan 2023 12:22:17 -0800 (PST)
Received: by mail-oo1-f47.google.com with SMTP id h3-20020a4ac443000000b004fb2954e7c3so3335947ooq.10;
        Wed, 25 Jan 2023 12:22:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QV5aYju94H6dkD3L7A3nPcZMzwhL2uI6SZmpxqkGgo=;
        b=C6KLFuwIPCOembF3+mdJhyQAJETsR4y5ePnDj31LPVbaRx1PRB2TpPTcFQ40dh7mMy
         3RX2QsVfcW4rqKKRB5H2npES0rTkw1sspp2V0d1MwH+fNAqEQPaOV0Ktg9DlhcCtTqo9
         T38fjJyVV7YBbRhFlxnOeN3wZM4DYqQfoej92gPKK+ChBbJGsDd1F2YYlZUt5JTBMhGC
         Xypl3ZwS7rANH/zTmgujj4MX1jfUi/ir89ToyMpB9GaxWQf36tinqG0b3LNJwdF0p4gZ
         N7SvjIN4d3chmTA4LcBBB1cF964pLhNEIsP3wMT59OWn5eN8EaAv/z4W2cuc2Ij7hqre
         CUcg==
X-Gm-Message-State: AFqh2kpb+TckfN4kpcplNT0HtUSLWUhuETEW8qDOBa0A+WIvmX91Qnjw
        5wtiXDDkqoth3eMZq4DFnQ==
X-Google-Smtp-Source: AMrXdXv14UQ8CWf0xNn+17CDaLJFAafwyepDkS+ifEDVW5JhBsWhaBfEZyAJnJopDhDR6AXvEOmb2Q==
X-Received: by 2002:a4a:498d:0:b0:4f2:6b72:6f75 with SMTP id z135-20020a4a498d000000b004f26b726f75mr15582770ooa.7.1674678136672;
        Wed, 25 Jan 2023 12:22:16 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r141-20020a4a3793000000b0050dc3c2f77asm2201809oor.8.2023.01.25.12.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 12:22:16 -0800 (PST)
Received: (nullmailer pid 2846936 invoked by uid 1000);
        Wed, 25 Jan 2023 20:22:15 -0000
Date:   Wed, 25 Jan 2023 14:22:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Etienne Carriere <etienne.carriere@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Pascal Paillet <p.paillet@foss.st.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: optee: add interrupt controller
 properties
Message-ID: <20230125202215.GA2811928-robh@kernel.org>
References: <20230124105643.1737250-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124105643.1737250-1-etienne.carriere@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Sudeep

On Tue, Jan 24, 2023 at 11:56:41AM +0100, Etienne Carriere wrote:
> Adds an optional interrupt controller property to optee firmware node
> in the DT bindings. Optee driver may embeds an irqchip exposing
> interrupts notified by the TEE world. Optee registers up to 1 interrupt
> controller and identifies each line with a line number from 0 to
> UINT16_MAX.
> 
> In the example, the platform SCMI device uses optee interrupt irq 5
> as async signal to trigger processing of an async incoming SCMI message,
> in the scope of a CPU DVFS control. A platform can have several SCMI
> channels driven this way. Optee irqs also permits small embedded devices
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
> 
> Co-developed-by: Pascal Paillet <p.paillet@foss.st.com>
> Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
> Changes since v1:
> - Added a description to #interrupt-cells property.
> - Changed of example. Linux wakeup event was subject to discussion and
>   i don't know much about input events in Linux. So move to SCMI.
>   In the example, an SCMI server in OP-TEE world raises optee irq 5
>   so that Linux scmi optee channel &scmi_cpu_dvfs pushed in the incoming
>   SCMI message in the scmi device for liekly later processing in threaded
>   context. The example includes all parties: optee, scmi, sram, gic.
> - Obviously rephrased the commit message.
> - Added Cc: tags
> ---
>  .../arm/firmware/linaro,optee-tz.yaml         | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> index d4dc0749f9fd..9c00c27f8b2c 100644
> --- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> +++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> @@ -40,6 +40,14 @@ properties:
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
> +
>  required:
>    - compatible
>    - method
> @@ -64,3 +72,62 @@ examples:
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
> +            interrupts = <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>;
> +            interrupt-controller;
> +            #interrupt-cells = <1>;
> +        };
> +
> +        scmi {
> +            compatible = "linaro,scmi-optee";
> +            linaro,optee-channel-id = <0>;
> +            interrupt-parent = <&gic>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            scmi_cpu_dvfs: protocol@13 {
> +                reg = <0x13>;
> +                linaro,optee-channel-id = <1>;
> +                shmem = <&scmi_shm_tx>, <&scmi_shm_rx>;
> +                interrupts-extended = <&optee 5>;
> +                interrupt-names = "a2p";

These properties aren't documented. Soon there will be a warning[1]. 

> +                #clock-cells = <1>;
> +            };
> +        };
> +    };
> +
> +    gic: interrupt-controller@a0021000 {
> +        compatible = "arm,cortex-a7-gic";
> +        reg = <0xa0021000 0x1000>, <0xa0022000 0x2000>;
> +        interrupt-controller;
> +        #interrupt-cells = <3>;
> +    };
> +
> +    soc {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        sram@2ffff000 {
> +            compatible = "mmio-sram";
> +            reg = <0x2ffff000 0x1000>;
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +            ranges = <0 0x2ffff000 0x1000>;
> +
> +            scmi_shm_tx: scmi-sram@0 {
> +                compatible = "arm,scmi-shmem";
> +                reg = <0 0x80>;
> +            };
> +
> +            scmi_shm_rx: scmi-sram@100 {
> +                compatible = "arm,scmi-shmem";
> +                reg = <0x100 0x80>;
> +            };

There's no need to show providers in examples (unless the example is for 
the provider).

Rob
