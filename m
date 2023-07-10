Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB8C74D97F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbjGJPER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbjGJPEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:04:14 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD73CE8;
        Mon, 10 Jul 2023 08:04:12 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7835ae70e46so138320439f.3;
        Mon, 10 Jul 2023 08:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689001452; x=1691593452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nyrFjxJo8+g4BJMVmJMgw4xbVv526rn8ok8HJOe1Dk=;
        b=cKE9gPxsnCH4tyNL/yyjLEwi86hbLWg0G8fEke0LA3swaXri5DB7g5bft6gey2IuR3
         GiMum8BUT5Ge0wKAggWTjywltq7hTGg1G6k0LI7QkjETqFOL8/vmD7/JANE5RkeMEZUO
         plpkYy/IRhAlun6nlrGm873WviIeuN/tQKIEtewIGXBAGztThN/4CAk1blAOa41cO8ks
         4EiYLtsMty5cb4fAyPhgEikcxVaVX8by7fDhq/b8qLOoHELq1gZKEvIyBA8iitiVP8dN
         eTemhDjsM+59PUa+LG/FHLj7EZBsmGQCAMxVCW5Jwk9a1N3gsCRGDcyd2lDnvoELznJr
         yLUA==
X-Gm-Message-State: ABy/qLbtq7swbwrL+Iq1eYiKMKOB5AvPuiU05maptdB0wggWUd+Wbdfy
        Gbh5EM7WYzXPUoZGI1izDg==
X-Google-Smtp-Source: APBJJlHILVVVbEy7Z0A3dEGkK4q7KE8RtZL3irR2tEfjkqh/qlzx+dnpggNF1X/hPL3NTTjAH46O9w==
X-Received: by 2002:a92:d5c6:0:b0:345:cdbe:833a with SMTP id d6-20020a92d5c6000000b00345cdbe833amr12468140ilq.15.1689001451880;
        Mon, 10 Jul 2023 08:04:11 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id r17-20020a92d991000000b003459023deaasm3610496iln.30.2023.07.10.08.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 08:04:11 -0700 (PDT)
Received: (nullmailer pid 1975341 invoked by uid 1000);
        Mon, 10 Jul 2023 15:04:09 -0000
Date:   Mon, 10 Jul 2023 09:04:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] dt-bindings: mtd: Add SEAMA partition bindings
Message-ID: <20230710150409.GA1959130-robh@kernel.org>
References: <20230707-seama-partitions-v3-0-6aa9391b46bb@linaro.org>
 <20230707-seama-partitions-v3-1-6aa9391b46bb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707-seama-partitions-v3-1-6aa9391b46bb@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 07:42:40PM +0200, Linus Walleij wrote:
> This types of NAND partitions appear in OpenWrt and
> U-Boot.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Drop reference from partitions.yaml again
> - Drop select: false
> - Use unevaluatedProperties
> ChangeLog v1->v2:
> - Fix up the binding to be childless
> ---
>  .../devicetree/bindings/mtd/partitions/seama.yaml  | 48 ++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/seama.yaml b/Documentation/devicetree/bindings/mtd/partitions/seama.yaml
> new file mode 100644
> index 000000000000..5105d1a6a44c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/partitions/seama.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/partitions/seama.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Seattle Image Partitions
> +
> +description: The SEAttle iMAge (SEAMA) partition is a type of partition
> +  used for NAND flash devices. This type of flash image is found in some
> +  D-Link routers such as DIR-645, DIR-842, DIR-859, DIR-860L, DIR-885L,
> +  DIR890L and DCH-M225, as well as in WD and NEC routers on the ath79
> +  (MIPS), Broadcom BCM53xx, and RAMIPS platforms. This partition type
> +  does not have children defined in the device tree, they need to be
> +  detected by software.
> +
> +allOf:
> +  - $ref: partition.yaml#
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +properties:
> +  compatible:
> +    const: seama
> +
> +  '#address-cells': false
> +
> +  '#size-cells': false

You don't need these 2. You'd only need them if partition.yaml defined 
them and you wanted to disallow them.

Rob
