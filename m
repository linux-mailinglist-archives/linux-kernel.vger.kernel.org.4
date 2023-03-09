Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852C96B2151
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjCIKZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjCIKZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:25:18 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBB060400;
        Thu,  9 Mar 2023 02:25:17 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 33C70D5A;
        Thu,  9 Mar 2023 11:25:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1678357515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3qwXV4mx27x93ESJHm5id++7jdpiHR35RpJBIDoswqs=;
        b=Dg3kt+x1C2KfDIZfCUGqtiIrh+FFA1ZcM42TwVXjf2NIR/GDsdZ1u6sK0FneSI5h9796ZW
        QWUi37Fvl4m10lsu7vZxPLXGqRiCPaLEzPIWrG+kNrjnKhDAIfUk6UlPD/Ls9kvY5ik515
        7UOMjFSVJvftdigFXTAA2+O67QgZq+DJ5KASMSKuPcE5SLW88UJclaz0Ee+e6rtwNeDWaA
        XiC5fELGrnjUnmuOigRQlZl+9bbWLAr8bmGFEKd6JqYUqx9FmrRQVy10n0f1rE3wH1pyPE
        qO3L/Jv4oJcryDaRXVREcha/DBSoWwqRFwbsluac5n2S8gxbu/V5lMYi33zmDw==
MIME-Version: 1.0
Date:   Thu, 09 Mar 2023 11:25:15 +0100
From:   Michael Walle <michael@walle.cc>
To:     =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Ra?= =?UTF-8?Q?fa=C5=82_Mi=C5=82ecki?= 
        <rafal@milecki.pl>
Subject: Re: [PATCH] dt-bindings: nvmem: layouts: add fixed-layout
In-Reply-To: <20230309093410.15214-1-zajec5@gmail.com>
References: <20230309093410.15214-1-zajec5@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <09cd56463e726cff0fd6662814466bc6@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2023-03-09 10:34, schrieb Rafał Miłecki:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> With the introduction of NVMEM layouts I believe we should prefer and
> support describing all NVMEM devices content in the "nvmem-layout" 
> node.
> Inluding fixed NVMEM cells (those with hardcoded offset & size).
> 
> This seems to be cleaner design and more explicit.
> 
> Introduce a binding allowing fixed NVMEM cells as a type of layout.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../bindings/nvmem/layouts/fixed-layout.yaml  | 52 +++++++++++++++++++
>  .../bindings/nvmem/layouts/nvmem-layout.yaml  |  1 +
>  2 files changed, 53 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
> 
> diff --git
> a/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
> b/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
> new file mode 100644
> index 000000000000..7eb86c999a5e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/layouts/fixed-layout.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVMEM layout for fixed NVMEM cells
> +
> +description:
> +  Many NVMEM devices have hardcoded cells layout (offset and size of 
> specific
> +  NVMEM content doesn't change).
> +
> +  This binding allows defining such cells using NVMEM layout. It can 
> be used on
> +  top of any NVMEM device.
> +
> +maintainers:
> +  - Rafał Miłecki <rafal@milecki.pl>
> +
> +properties:
> +  compatible:
> +    const: fixed-layout
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +patternProperties:
> +  "@[a-f0-9]+$":
> +    type: object
> +    description: NVMEM cell
> +    properties:
> +      reg:
> +        maxItems: 1

Looking at Documentation/devicetree/bindings/nvmem/nvmem.yaml this
is missing the bits property. Also, can we share that information
between the old style and the new style somehow so we don't
duplicate that here?

-michael

> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    nvmem-layout {
> +        compatible = "fixed-layout";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        calibration@4000 {
> +            reg = <0x4000 0x100>;
> +        };
> +    };
> diff --git
> a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> index 8512ee538c4c..03da7848c713 100644
> --- a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> @@ -18,6 +18,7 @@ description: |
>    perform their parsing. The nvmem-layout container is here to 
> describe these.
> 
>  oneOf:
> +  - $ref: fixed-layout.yaml
>    - $ref: kontron,sl28-vpd.yaml
>    - $ref: onie,tlv-layout.yaml
