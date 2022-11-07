Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424D761F754
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbiKGPOb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Nov 2022 10:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbiKGPO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:14:26 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BFC192A1;
        Mon,  7 Nov 2022 07:14:24 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id a27so7002648qtw.10;
        Mon, 07 Nov 2022 07:14:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDCQsymOUHkvhEthEH/K4n29eCwFmJOVZ+/AnHagJl4=;
        b=DU3foriAFJt5mulZhMEpVRd6uDmFkdkEPPZukASvH+TaYW+W4eO+J0nr5LEHKxCuIA
         R75TF5agXTXtsqlOXdZzQZMDlIYPjNxKx3/lyZSVhaMF5xiUSewhQ9MC9dge0hfhNLif
         VWb/q0NXAXNEEgYJk/+Xhh3zi+U2OsdC87A4snsjo920MF+0e70c9K9EHhffuYwCWg0x
         ILjBcU71/kMKMftcYX0ssEKu7GfVSNav6wkXygf7Y1kT/e3jSxwoQ6pvAo0vze97i7Qw
         cMxurpTTrXiF/ki86fcD9mRxefGeqztzfvfQ1wkqHIgTZ1WOH5Sm5NkXmZbMtHGmDqHu
         gm3w==
X-Gm-Message-State: ACrzQf0StRh/y8NlNlcp+FVYDSWY88C/Y97RJ5+8asMHFtZQ96ZQibNr
        gPg8MWFW0P2aRym5w7WNufsyYiHA7YjHfg==
X-Google-Smtp-Source: AMsMyM5qRNEtp8x9FpSIX7zE9Y1yy0YoAVnj50pW7h9GllUm25wq/Tbzsxnc0PYjRh6HpX4EsRdXDQ==
X-Received: by 2002:a05:622a:34e:b0:3a5:44b2:d9a3 with SMTP id r14-20020a05622a034e00b003a544b2d9a3mr22251627qtw.452.1667834063503;
        Mon, 07 Nov 2022 07:14:23 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id y7-20020a05620a25c700b006ee7923c187sm7111816qko.42.2022.11.07.07.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 07:14:22 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-3691e040abaso107091127b3.9;
        Mon, 07 Nov 2022 07:14:21 -0800 (PST)
X-Received: by 2002:a81:9c49:0:b0:34a:de:97b8 with SMTP id n9-20020a819c49000000b0034a00de97b8mr47671682ywa.384.1667834061609;
 Mon, 07 Nov 2022 07:14:21 -0800 (PST)
MIME-Version: 1.0
References: <20221107135825.583877-1-herve.codina@bootlin.com> <20221107135825.583877-3-herve.codina@bootlin.com>
In-Reply-To: <20221107135825.583877-3-herve.codina@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Nov 2022 16:14:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXoyE+MP4N=5o6a=u83gcsYD_RijpjrYf15i5MR85gEJg@mail.gmail.com>
Message-ID: <CAMuHMdXoyE+MP4N=5o6a=u83gcsYD_RijpjrYf15i5MR85gEJg@mail.gmail.com>
Subject: Re: [PATCH 2/7] dt-bindings: clock: renesas,r9a06g032-sysctrl: Add
 h2mode property
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hervé,

On Mon, Nov 7, 2022 at 2:59 PM Herve Codina <herve.codina@bootlin.com> wrote:
> Add the h2mode property to force the USBs mode ie:
>  - 2 hosts
> or
>  - 1 host and 1 device
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml
> +++ b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml
> @@ -39,6 +39,16 @@ properties:
>    '#power-domain-cells':
>      const: 0
>
> +  renesas,h2mode:
> +    description: |
> +      Configure the USBs mode.
> +        - <0> : the USBs are in 1 host and 1 device mode.
> +        - <1> : the USBs are in 2 host mode.
> +      If the property is not present, the value used is the one already present
> +      in the CFG_USB register (from reset or set by the bootloader).
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +
>    '#address-cells':
>      const: 1

While the H2MODE register bit is indeed located in the sysctrl's
address space, and handling it here makes it simpler for the drivers
(especially w.r.t. the default handling), this is really a property
of the switchable usbh/f core...
Perhaps it can be moved there? Or not?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
