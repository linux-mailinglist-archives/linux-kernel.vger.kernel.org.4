Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D897161F66C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbiKGOnQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Nov 2022 09:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiKGOnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:43:09 -0500
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6144B1A3BB;
        Mon,  7 Nov 2022 06:43:02 -0800 (PST)
Received: by mail-qv1-f51.google.com with SMTP id j6so8184969qvn.12;
        Mon, 07 Nov 2022 06:43:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unzujgx2IFO2xv07GVYQlpwOttD9eRvw4Avn0aUkXh0=;
        b=ikEUrvshKQKGXyGHSxNs+XWwWvhkNuKFWYf2rr8sMbaLhf/AK/2B8mi0plcv0DaF8n
         rk0EKBqXt5jPxzGc+GCJCT+C1AkOnmydldvaqh1AhAW1jWdrE7RDJOkdOFlCLyUFxWuh
         je67RAPN8XcczpPn5yr9OKJ0rxzVtVmi2Mc8tpZkTjIGrbJl1lHg3wZnxZjxA+U6QvcX
         Lmt+MquDZrmIPb5RRjUsffsSFXR6UCdz5Xo5uEdkUhQfbgT8i/LMQh98rt4zlEu1fbck
         SCTyebp9D1tI3JtpgUgPj+lUsqJW0mwlGqG9mErg1zAMEOR9NpmPsJG/bOr0ZFdW0mxZ
         56cw==
X-Gm-Message-State: ACrzQf2tc5mFwjagLvnuRPOqa71yTP5vwUzjrS45laddeSKrOnvEA5Tq
        DKCy2YyYfGBKacpFIThe9ONv2D1pz1T3KA==
X-Google-Smtp-Source: AMsMyM4YdpqCnMUIlta2r1PoISSOqxEC2UNRJ7E3az1m+YbJI4n82Lz6v04AWIjTdxhE2+F0YZLPRQ==
X-Received: by 2002:a05:6214:1a48:b0:4bb:604d:fb2c with SMTP id fi8-20020a0562141a4800b004bb604dfb2cmr44477643qvb.93.1667832181400;
        Mon, 07 Nov 2022 06:43:01 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id 69-20020a370c48000000b006eea4b5abcesm6821459qkm.89.2022.11.07.06.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 06:43:01 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id 131so9452079ybl.3;
        Mon, 07 Nov 2022 06:43:01 -0800 (PST)
X-Received: by 2002:a05:6902:503:b0:6cf:c510:6a23 with SMTP id
 x3-20020a056902050300b006cfc5106a23mr30806206ybs.380.1667832180877; Mon, 07
 Nov 2022 06:43:00 -0800 (PST)
MIME-Version: 1.0
References: <20221107135825.583877-1-herve.codina@bootlin.com> <20221107135825.583877-8-herve.codina@bootlin.com>
In-Reply-To: <20221107135825.583877-8-herve.codina@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Nov 2022 15:42:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVip_e7dZ2P7sv1OH+P48dQyjnmsJBoATHLAqzPEcwDdw@mail.gmail.com>
Message-ID: <CAMuHMdVip_e7dZ2P7sv1OH+P48dQyjnmsJBoATHLAqzPEcwDdw@mail.gmail.com>
Subject: Re: [PATCH 7/7] MAINTAINERS: add the Renesas RZ/N1 USBF controller entry
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
> After contributing the driver, add myself as the maintainer
> for Renesas RZ/N1 USBF controller.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Thanks for your patch!

> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17627,6 +17627,14 @@ S:     Maintained
>  F:     Documentation/devicetree/bindings/rtc/renesas,rzn1-rtc.yaml
>  F:     drivers/rtc/rtc-rzn1.c
>
> +RENESAS RZ/N1 USBF CONTROLLER DRIVER
> +M:     Herve Codina <herve.codina@bootlin.com>

Hervé?

> +L:     linux-renesas-soc@vger.kernel.org
> +L:     linux-usb@vger.kernel.org
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/usb/renesas,usbf.yaml
> +F:     drivers/usb/gadget/udc/renesas_usbf.c
> +
>  RENESAS R-CAR GEN3 & RZ/N1 NAND CONTROLLER DRIVER
>  M:     Miquel Raynal <miquel.raynal@bootlin.com>
>  L:     linux-mtd@lists.infradead.org

Up to you, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
