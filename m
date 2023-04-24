Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6277D6ED24C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 18:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjDXQSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 12:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjDXQSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 12:18:06 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711857D8C;
        Mon, 24 Apr 2023 09:18:00 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-38e9dfa543bso1055795b6e.2;
        Mon, 24 Apr 2023 09:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682353079; x=1684945079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ef/nUWAo93ykxRt/lNEQT+96fr8F/oVSX+sFEFLjUo=;
        b=TjYi1DuO87raHq/EkuR7r5/crNC0V2WOTtso+Bghc+U1srzoZZCzGdt8l5KBqDY2cy
         QbRXe1qFFlKa3qisuD5Ga3bVQel2chL8gSgKxyAcL6niqHCOwbPnqsSoEV5F5TL9oocx
         afIGvOzGRaELRkmAktt5s7ZjpVk5EbswnKeoVo9IDWthSV0UJb/kG1G+cTFEZOtw3l+2
         FTjaIFHmeZf9/iwKquPLuBA82ak1t+1rpYIFJ7tOR8gPRula/T8VKXK94nf8gNpeVevZ
         Bk6qadKrsTfXKtZgAj0Jlzr7hESvEgFqjcbnaUwTa0c5zFqTsAcInYU0ulwXwc0In7/L
         fZLg==
X-Gm-Message-State: AAQBX9fi5Lw2ApWItvELqjgZ0QlwaQbspgngrs+9THMDGh0zlo/HuR/0
        /T/YKx8Dk/cFYrwBaW+uFA==
X-Google-Smtp-Source: AKy350bn6N/FuqwHS0N9uitfDp4zpaNUuskHXzrku67V02VC/o8cVZMjd+m40+pv8Qvhp8DC1RToVg==
X-Received: by 2002:a05:6808:d46:b0:38c:ec:8b0f with SMTP id w6-20020a0568080d4600b0038c00ec8b0fmr8454350oik.16.1682353078268;
        Mon, 24 Apr 2023 09:17:58 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z8-20020aca3308000000b0038c35f512a2sm4730805oiz.56.2023.04.24.09.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:17:57 -0700 (PDT)
Received: (nullmailer pid 2768718 invoked by uid 1000);
        Mon, 24 Apr 2023 16:17:56 -0000
Date:   Mon, 24 Apr 2023 11:17:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lukasz Majewski <lukma@denx.de>, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/43] dt-bindings: mtd: add DT bindings for ts7250 nand
Message-ID: <20230424161756.GG2701399-robh@kernel.org>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230424123522.18302-23-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424123522.18302-23-nikita.shubin@maquefel.me>
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

On Mon, Apr 24, 2023 at 03:34:38PM +0300, Nikita Shubin wrote:
> Add YAML bindings for ts7250 NAND.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  .../bindings/mtd/technologic,nand.yaml        | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/technologic,nand.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/technologic,nand.yaml b/Documentation/devicetree/bindings/mtd/technologic,nand.yaml
> new file mode 100644
> index 000000000000..3234d93a1c21
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/technologic,nand.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/technologic,nand.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Technologic Systems NAND controller
> +
> +maintainers:
> +  - Lukasz Majewski <lukma@denx.de>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: technologic,ts7200-nand
> +      - const: gen_nand

Not a useful compatible.

> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells': true
> +  '#size-cells': true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: true

No, 'true' is not allowed here.

> +
> +examples:
> +  - |
> +    nand-parts@0 {
> +      compatible = "technologic,ts7200-nand", "gen_nand";
> +      reg = <0x60000000 0x8000000>;
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +
> +      partition@0 {
> +        label = "TS-BOOTROM";
> +        reg = <0x00000000 0x00020000>;
> +        read-only;
> +      };
> +
> +      partition@20000 {
> +        label = "Linux";
> +        reg = <0x00020000 0x07d00000>;
> +      };
> +
> +      partition@7d20000 {
> +        label = "RedBoot";
> +        reg = <0x07d20000 0x002e0000>;
> +        read-only;
> +      };
> +    };
> +
> +...
> -- 
> 2.39.2
> 
