Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0078D67BB7F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 20:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbjAYT5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 14:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbjAYT5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 14:57:22 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1915CE73;
        Wed, 25 Jan 2023 11:57:03 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id r205so17233353oib.9;
        Wed, 25 Jan 2023 11:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vhbyqf+hKaYLy7rx+ITC5uZbCekwC8EyC3gvS3cW19E=;
        b=RUrlTAQTtC+z+C/CTYQCR1Q1U1s+w4uugHOBfA8pRrOVNf6koD5JU1wUHIHS3dcNPE
         BYz/nP7nIW4Xp4GZeXpPHs3V9jKPRSa7eL+UaTKjFjzp6GSqDJEAHYabflw875DeZuim
         nd/yddjE9JE3seRAAclZCT4TYygsEWobXZhenzMfZGDCRM8hpLjSjBZlPcVps7GKDE3m
         ZFH9kS096E1znAkOkc0+U0e+H3wLOqvj6SItSvYhCMKQBjOygUt8pbi/hj4q0gfGmP4x
         yusRR6uVgsu9g0LUQBX33BKlRHC6pdVDN5zfWqMBzZAyaglGh86bdM5u+B7vGq+Ip+k9
         HHPg==
X-Gm-Message-State: AFqh2kq11aZozh85AcBwXmxXG5aNgpvGoHbbVRSG4mySpjvrQlEzSKjL
        zZTjUkIjwh2oyGZGtetkOw==
X-Google-Smtp-Source: AMrXdXsrjDDOyTJPRcwXbpvMj1q1wpvkSl04SNiPfclCp0ZVsH0qzLNNT5ozZfskACFeDZU7NnlAYg==
X-Received: by 2002:a05:6808:b0a:b0:363:b22:6553 with SMTP id s10-20020a0568080b0a00b003630b226553mr15943086oij.14.1674676590563;
        Wed, 25 Jan 2023 11:56:30 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c22-20020a9d6856000000b006863ad4f435sm2523208oto.52.2023.01.25.11.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 11:56:30 -0800 (PST)
Received: (nullmailer pid 2752652 invoked by uid 1000);
        Wed, 25 Jan 2023 19:56:29 -0000
Date:   Wed, 25 Jan 2023 13:56:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andrew Davis <afd@ti.com>
Cc:     Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>,
        Fabian Vogt <fabian@ritter-vogt.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/9] dt-bindings: mfd: Add TI-Nspire misc registers
Message-ID: <20230125195629.GA2717320-robh@kernel.org>
References: <20230123214924.27476-1-afd@ti.com>
 <20230123214924.27476-2-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123214924.27476-2-afd@ti.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 03:49:16PM -0600, Andrew Davis wrote:
> The TI Nspire devices contain a set of registers with a seemingly
> miscellaneous set of functionality. This area is known simply as the
> "misc" region.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  .../bindings/mfd/ti,nspire-misc.yaml          | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,nspire-misc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,nspire-misc.yaml b/Documentation/devicetree/bindings/mfd/ti,nspire-misc.yaml
> new file mode 100644
> index 000000000000..316c4b3dcd87
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ti,nspire-misc.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/ti,nspire-misc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI Nspire MISC hardware block
> +
> +maintainers:
> +  - Andrew Davis <afd@ti.com>
> +
> +description: |

Drop '|'

> +  System controller node represents a register region containing a set
> +  of miscellaneous registers. The registers are not cohesive enough to
> +  represent as any specific type of device. Currently there is a reset
> +  controller.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - ti,nspire-misc
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  reboot:
> +    $ref: "../power/reset/syscon-reboot.yaml"

$ref: /schemas/power/reset/syscon-reboot.yaml#

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
