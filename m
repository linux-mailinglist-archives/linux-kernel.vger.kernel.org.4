Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5575FC8C7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 17:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiJLP4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 11:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiJLP4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 11:56:48 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C844BB7EE1;
        Wed, 12 Oct 2022 08:56:45 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-12c8312131fso19938096fac.4;
        Wed, 12 Oct 2022 08:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+J5rBH2Ax6+Mtwp/uLP5yn6FuEpFbZJdzQoPclekoRQ=;
        b=ctZPtJRERHVDgPm29Klngd3867Gz83FJae322phIE8kaS13k7k09DpV9rXFbHFicVL
         69FII57uCx9FxvvrCAWiSU5E/575K5EkyoF8tVcjf/YzeGqVzBfT+icQuCHz+DLaaQIl
         UlNoTbQGcuPVcaGsQ9dANS5xYYYYW67L7HNdPnii3h6ScYoSGTNYDZG1GsQT/V3rp2zQ
         QUX3Y1BxX8DITfPD3i1U073XCE3rdNSaSvSi/sgrijpoM4Hk6SU3m1NBZn6F7v8vBCG7
         eqiRHTo0/FnuvwBiHsJU0ssQVgfk9k8kWnP1c7J25XB6P0jQXaxyenQKEJF/zzP8alvZ
         csBg==
X-Gm-Message-State: ACrzQf18S137FVUrEOPCm8zmHsz8A9RIAUQ6OSa4WpXAxW8m9NRyQbx2
        RscQq6RLPGouMk42YCJ0TNUGTSiHmw==
X-Google-Smtp-Source: AMsMyM7eg6DI/M1+ccTCr5c2InEdknfBOftpJQN1uw9+vlHkdneRdNuwICBHaQyeqK5xSUvxtk/P7Q==
X-Received: by 2002:a05:6870:ac2b:b0:132:f761:8f4c with SMTP id kw43-20020a056870ac2b00b00132f7618f4cmr2730690oab.17.1665590205023;
        Wed, 12 Oct 2022 08:56:45 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bi35-20020a05680818a300b00354978180d8sm2981717oib.22.2022.10.12.08.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 08:56:44 -0700 (PDT)
Received: (nullmailer pid 2187963 invoked by uid 1000);
        Wed, 12 Oct 2022 15:56:45 -0000
Date:   Wed, 12 Oct 2022 10:56:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/13] dt-bindings: Add binding for gunyah hypervisor
Message-ID: <20221012155645.GA2173829-robh@kernel.org>
References: <20221011000840.289033-1-quic_eberman@quicinc.com>
 <20221011000840.289033-3-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011000840.289033-3-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 05:08:29PM -0700, Elliot Berman wrote:
> When Linux is booted as a guest under the Gunyah hypervisor, the Gunyah
> Resource Manager applies a devicetree overlay describing the virtual
> platform configuration of the guest VM, such as the message queue
> capability IDs for communicating with the Resource Manager. This
> information is not otherwise discoverable by a VM: the Gunyah hypervisor
> core does not provide a direct interface to discover capability IDs nor
> a way to communicate with RM without having already known the
> corresponding message queue capability ID. Add the DT bindings that
> Gunyah adheres for the hypervisor node and message queues.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  .../bindings/firmware/gunyah-hypervisor.yaml  | 87 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
> 
> diff --git a/Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml b/Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
> new file mode 100644
> index 000000000000..f0a14101e2fd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/gunyah-hypervisor.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Gunyah Hypervisor
> +
> +maintainers:
> +  - Murali Nalajala <quic_mnalajal@quicinc.com>
> +  - Elliot Berman <quic_eberman@quicinc.com>
> +
> +description: |+
> +  On systems which support devicetree, Gunyah generates and overlays a deviceetree overlay which

How you end up with the node (applying an overlay) is not relavent to 
the binding.

> +  describes the basic configuration of the hypervisor. Virtual machines use this information to determine
> +  the capability IDs of the message queues used to communicate with the Gunyah Resource Manager.

Wrap at 80. That is the coding standard still though 100 is deemed 
allowed. And yamllint only complains at 110 because I didn't care to fix 
everyones lines over 100.

> +  See also: https://github.com/quic/gunyah-resource-manager/blob/develop/src/vm_creation/dto_construct.c
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: gunyah-hypervisor-1.0
> +      - const: gunyah-hypervisor

2 compatibles implies a difference between the 2. What's the difference? 
Where does '1.0' come from?

> +
> +  "#address-cells":
> +    description: Number of cells needed to represent 64-bit capability IDs.
> +    const: 2
> +
> +  "#size-cells":
> +    description: must be 0, because capability IDs are not memory address
> +                  ranges and do not have a size.
> +    const: 0
> +
> +patternProperties:
> +  "^gunyah-resource-mgr(@.*)?":
> +    type: object
> +    description:
> +      Resource Manager node which is required to communicate to Resource
> +      Manager VM using Gunyah Message Queues.
> +
> +    properties:
> +      compatible:
> +        items:
> +          - const: gunyah-resource-manager-1-0
> +          - const: gunyah-resource-manager

Same comment here.

> +
> +      reg:
> +        items:
> +          - description: Gunyah capability ID of the TX message queue
> +          - description: Gunyah capability ID of the RX message queue
> +
> +      interrupts:
> +        items:
> +          - description: Interrupt for the TX message queue
> +          - description: Interrupt for the RX message queue
> +
> +    additionalProperties: false
> +
> +    required:
> +      - compatible
> +      - reg
> +      - interrupts
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    hypervisor {
> +        #address-cells = <2>;
> +        #size-cells = <0>;
> +        compatible = "gunyah-hypervisor-1.0", "gunyah-hypervisor";
> +
> +        gunyah-resource-mgr@0 {
> +            compatible = "gunyah-resource-manager-1-0", "gunyah-resource-manager";
> +            interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>, /* TX full IRQ */
> +                         <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>; /* RX empty IRQ */
> +            reg = <0x00000000 0x00000000>, <0x00000000 0x00000001>;
> +                  /* TX, RX cap ids */
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 91d00b00d91c..ef6de7599d98 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8884,6 +8884,7 @@ M:	Elliot Berman <quic_eberman@quicinc.com>
>  M:	Murali Nalajala <quic_mnalajal@quicinc.com>
>  L:	linux-arm-msm@vger.kernel.org
>  S:	Supported
> +F:	Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
>  F:	Documentation/virt/gunyah/
>  
>  HABANALABS PCI DRIVER
> -- 
> 2.25.1
> 
> 
