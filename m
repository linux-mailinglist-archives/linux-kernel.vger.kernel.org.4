Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143F769D746
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 00:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbjBTXnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 18:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjBTXni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 18:43:38 -0500
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41F7113CD;
        Mon, 20 Feb 2023 15:43:37 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1720f9792bbso2862743fac.4;
        Mon, 20 Feb 2023 15:43:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeJOLdeEl+yXgjAhl7LhKSHnNfddVQHGyrv16jc4d6s=;
        b=g6mylpS1U12rhuE3D31pavWYUd477J/tWxwmuTCjt/Eb0Z5Oe7mwpnV7n+/37S0XOI
         WhIRy/PrVQD9MmBab6f3IE6lYiIwKVY8ew1TBs9fGBs172YqjUQFCtQIgl2cHFpk59at
         16QX8xs0iIBRJj+PaCLrh7KOzmTpr1bfr3F056P3/WDrp9c92SDEbP1QtouotfnRZh15
         MkYtfMfomBSDsEOP8kU1w4ALVyDgHoE6DJtGLG4bHfs6obZjo2pOSwH7G+K3Rpn/Mb1k
         ez/HzP5cu+7+yXyPkZZUOvBp3gbTiPVuayWMY8SoE39mbO11MtnA29TaTJrCe2yaK0Lq
         kO+A==
X-Gm-Message-State: AO0yUKVlrhPvcXZ6FtgY+JzqUbTtORd39Gp+ktK2oOgay45pDSVZ/ENH
        8cdW61WBSJPq2zzvD7un4w==
X-Google-Smtp-Source: AK7set+oaLlcAaz3GBVoEx9R0WvBFgQQNyYAjjorvsvo0n6o3lXE+kwePpv8yWNjSObzdDBTXU3vNg==
X-Received: by 2002:a05:6870:17a3:b0:16d:f8aa:9fa8 with SMTP id r35-20020a05687017a300b0016df8aa9fa8mr5591332oae.12.1676936616888;
        Mon, 20 Feb 2023 15:43:36 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dt22-20020a0568705a9600b001722d0e365fsm2359oab.20.2023.02.20.15.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 15:43:36 -0800 (PST)
Received: (nullmailer pid 618228 invoked by uid 1000);
        Mon, 20 Feb 2023 23:43:35 -0000
Date:   Mon, 20 Feb 2023 17:43:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] dt-bindings: syscon: Add StarFive syscon doc
Message-ID: <20230220234335.GA615198-robh@kernel.org>
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <20230215113249.47727-5-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215113249.47727-5-william.qiu@starfivetech.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 07:32:49PM +0800, William Qiu wrote:
> Add documentation to describe StarFive System Controller Registers.
> 
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  .../bindings/soc/starfive/jh7110-syscon.yaml  | 51 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml b/Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
> new file mode 100644
> index 000000000000..fa4d8522a454
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/starfive/jh7110-syscon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 SoC system controller
> +
> +maintainers:
> +  - William Qiu <william.qiu@starfivetech.com>
> +
> +description: |
> +  The StarFive JH7110 SoC system controller provides register information such
> +  as offset, mask and shift to configure related modules such as MMC and PCIe.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - starfive,jh7110-stg-syscon
> +          - starfive,jh7110-sys-syscon
> +          - starfive,jh7110-aon-syscon

Is 'syscon' really part of what the blocks are called? Is just 'stg', 
'sys' and 'aon' not unique enough?

Rob
