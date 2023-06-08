Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5355772867D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbjFHRnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjFHRnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:43:31 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC08E2D41;
        Thu,  8 Jun 2023 10:43:29 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-33b22221da6so4112905ab.1;
        Thu, 08 Jun 2023 10:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686246209; x=1688838209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mp0FR39SuxL+WmMJgcXG5sjnksxhUCnzwFMUs+zD8p8=;
        b=euPadxOthIRRRAqqZex4rM9inqIjP4uXP+77YZDZmYMnKdJtotck4j2KOvnUsDvfIh
         ZTmGvuozy8Frp+T8WxP2gA6IrO6UQetyoo3Pdiq/3CeRnUCb5yWEa1GoD0Njtr+TS/4a
         ff6iAQaInl67LgcmGM3NZaE9g1p490WhmDHmD+ERK3hj10qkIeSKMss+2VS3G2j9j+4L
         s+gYQmyhNLN/AZWbrLnKkpTR6UVKLKJGAgcNoWMzsGZHhDr9fQlYGsPm1r9kwqgQrzw5
         yUbdj4W2aRikbFkYLdQQuyZ0n+oSQD0smfwWAKLvunmtXTh39j7kH85XsjdZHfca4L/X
         ncrg==
X-Gm-Message-State: AC+VfDxXknXLBEjYxzAC68ofnsWQmrwcGe3ciEkO1iXObjp529A59186
        9bFBrEHaCU/vGoth1DfzOw==
X-Google-Smtp-Source: ACHHUZ4VYNGXahBKPm+VdOmUurjzJ4VDeftBc37yj7JLHEmGlKd51H8ZcHP+zAWJMGu/l1kBC+jx9g==
X-Received: by 2002:a92:c647:0:b0:33e:7c8d:3de with SMTP id 7-20020a92c647000000b0033e7c8d03demr1724662ill.32.1686246208868;
        Thu, 08 Jun 2023 10:43:28 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id j12-20020a02cb0c000000b0041d859c5721sm410050jap.64.2023.06.08.10.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 10:43:28 -0700 (PDT)
Received: (nullmailer pid 3079477 invoked by uid 1000);
        Thu, 08 Jun 2023 17:43:26 -0000
Date:   Thu, 8 Jun 2023 11:43:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        op-tee@lists.trustedfirmware.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Pascal Paillet <p.paillet@foss.st.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: optee: add interrupt controller
 properties
Message-ID: <20230608174326.GA2791381-robh@kernel.org>
References: <20230506073235.2770292-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230506073235.2770292-1-etienne.carriere@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Sudeep, again...

Sudeep, you may want to look at v2 again.

On Sat, May 06, 2023 at 09:32:34AM +0200, Etienne Carriere wrote:
> Adds an optional interrupt controller property to optee firmware node
> in the DT bindings. Optee driver may embeds an irqchip exposing
> OP-TEE interrupt events notified by the TEE world. Optee registers up

optee, Optee, or OP-TEE?

> to 1 interrupt controller and identifies each line with a line
> number from 0 to UINT16_MAX.
> 
> The identifiers and meaning of the interrupt line number are specific
> to the platform and shall be found in the OP-TEE platform documentation.

Why can't you standardize the interrupt numbering for standard events 
like SCMI?


I think there's still concern as to why this can't all be discoverable. 
The Optee driver should know or discover from Optee that it is an 
interrupt controller and can register itself as such. Likewise, the 
SCMI driver knows for scmi-optee, the interrupt comes from the Optee 
node. It can find that node (by compatible) and then find the 
irqchip/domain provider for that node.

OTOH, SCMI already supports interrupts in the binding, so this isn't 
too big of a deal. I'm more concerned that once you have Optee 
interrupts, then you are going to want a node for every Optee 
sub-function with an interrupt. Then we're back to the very first Optee 
binding with a child node for every sub-function. Using it for gpio-keys 
as you did in the first version for example.

If Sudeep is okay with this from an SCMI perspective and Marc is from an 
irqchip perspective, then I'm okay with it too.

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
