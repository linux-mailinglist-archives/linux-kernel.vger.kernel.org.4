Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9A861F614
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbiKGObI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Nov 2022 09:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbiKGOaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:30:52 -0500
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8261E3D9;
        Mon,  7 Nov 2022 06:26:56 -0800 (PST)
Received: by mail-qk1-f180.google.com with SMTP id g10so7205843qkl.6;
        Mon, 07 Nov 2022 06:26:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ft1r9aPFGJF0+nCT//rpLeqH0WDImyUG+eP+SvMdOUM=;
        b=aQyZyVWsvpNpO/mxf/icp5EiRCg6lZ5KxIh3CaOEExqJiKWvJ0Uwsqza4zBgLK0zje
         XEPuquZgemOHm8UoeuETaoYRyfvW202c8bDjNWSRGb3AcQZHh336vndZx1gcNOMndzmk
         jDFIEwn4gikfQINXXX8Al0z8v57Z1mL/lnaYvVb4Xs2PgXvIMR+rDJAIwHjK0fw5unnw
         7n81mGLlCSwl2m9vOOanZORGNEthVLBiqttuZPQ8z2vhGGPRB44GCntu+5SaLiugz2Nx
         HqvGhdRyXEeoOYfbfacO4uBYz9xDgOxQw1vYLjwYJB7ignoSoG9uZn3GJXoQ8bt12LIn
         x6sQ==
X-Gm-Message-State: ACrzQf08b0yeD6gkp5YT2E7TinyczM9FZ+ao38B5FxcmXo2++8QEV3FI
        Aq7HZNW1jHRGDjWoxUaeYPe8A8tBSHOocw==
X-Google-Smtp-Source: AMsMyM6Jpv0EgHEXEmn+VZEsX8fU0eJLbwDLeD2piUtkylPTDhDBomQ0VQSOPxjzO4jkMEVQv5l5mg==
X-Received: by 2002:a37:65c9:0:b0:6fa:1ef8:fa10 with SMTP id z192-20020a3765c9000000b006fa1ef8fa10mr32177855qkb.648.1667831215541;
        Mon, 07 Nov 2022 06:26:55 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id u17-20020a05622a011100b003a598fcddefsm664637qtw.87.2022.11.07.06.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 06:26:54 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id o70so13760513yba.7;
        Mon, 07 Nov 2022 06:26:54 -0800 (PST)
X-Received: by 2002:a05:6902:503:b0:6cf:c510:6a23 with SMTP id
 x3-20020a056902050300b006cfc5106a23mr30733838ybs.380.1667831214389; Mon, 07
 Nov 2022 06:26:54 -0800 (PST)
MIME-Version: 1.0
References: <20221107135825.583877-1-herve.codina@bootlin.com> <20221107135825.583877-5-herve.codina@bootlin.com>
In-Reply-To: <20221107135825.583877-5-herve.codina@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Nov 2022 15:26:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX9WBxkrQRV6yEXmJdj3qQ9Ne4W0xmiGDEC6j=R_ARgsQ@mail.gmail.com>
Message-ID: <CAMuHMdX9WBxkrQRV6yEXmJdj3qQ9Ne4W0xmiGDEC6j=R_ARgsQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] dt-bindings: usb: add the Renesas USBF controller binding
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hervé,

On Mon, Nov 7, 2022 at 3:00 PM Herve Codina <herve.codina@bootlin.com> wrote:
> The Renesas USBF controller is an USB2.0 device controller
> (UDC) available in Renesas r9a06g032 SoC (RZ/N1 family).
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/renesas,usbf.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/renesas,usbf.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas USBF (USB Function) controller binding
> +
> +description: |
> +   The Renesas USBF controller is an USB2.0 device
> +   controller (UDC).
> +
> +maintainers:
> +  - Herve Codina <herve.codina@bootlin.com>

Hervé? ;-)

> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - renesas,r9a06g032-usbf
> +          - const: renesas,rzn1-usbf
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Internal bus clock (AHB) for Function
> +      - description: Internal bus clock (AHB) for Power Management
> +  clock-names:
> +    items:
> +      - const: hclkf
> +      - const: hclkpm

power-domains?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
