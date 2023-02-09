Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF98690272
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 09:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjBIIs1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Feb 2023 03:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBIIsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 03:48:25 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D2D47436;
        Thu,  9 Feb 2023 00:48:23 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id w3so1145552qts.7;
        Thu, 09 Feb 2023 00:48:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRakTzAhZgdoRP04VGp/CF8zi2ym1rVkoURybx362LI=;
        b=K89vUrlk8n3XLJHbZzwvoDX2m4Y635vA0qXgrNk4KvA0Bm85LpaAOEp6GD3AkVsWTK
         j90KjWPVHWjDCsBaOZiGpFAMoJpMa6qiXYVfeifStJ3pWrIrLMes0/fxOy+iQHxH1jb9
         lZkayRySfaJuCRFLchMmgFSGw9hfawzdtY7YzWgBtDPIezeLo0nOipK+4ZJeg/8o661t
         kNU7Z94jr9wtNrEYbcgqBwpwmHXjL8T7XTe3YVTlsllN6Eml5ia+u5dPsJ1BUS8bDCus
         QZDD+tyaQ82ERMY8UpEMD01MkRBfZbg0Teo/cuKYX2B/LwNsQzy8zKAxCC/5EHpM6nrY
         qZeQ==
X-Gm-Message-State: AO0yUKU3K5/t7A2XdghyIKgwXZ7xQSQt4VTKZchM1QQiIPhCSpBxe1nY
        HQ6o5GeC16iyQKKGVa15aHt36zgofZVLBQ==
X-Google-Smtp-Source: AK7set9dHhWZn0eA+TCM2kNsefSZOGTM50enzjkapGNVc/T8PrmmDUx4DvUAFi/W1o1ir27Q4jL8pg==
X-Received: by 2002:ac8:5cce:0:b0:3b9:a777:3d9a with SMTP id s14-20020ac85cce000000b003b9a7773d9amr18616575qta.44.1675932502689;
        Thu, 09 Feb 2023 00:48:22 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id m3-20020ac807c3000000b003b848759ed8sm854371qth.47.2023.02.09.00.48.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 00:48:22 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id 184so1499146ybw.5;
        Thu, 09 Feb 2023 00:48:22 -0800 (PST)
X-Received: by 2002:a05:6902:1c2:b0:89c:b633:73a6 with SMTP id
 u2-20020a05690201c200b0089cb63373a6mr1044164ybh.365.1675932501823; Thu, 09
 Feb 2023 00:48:21 -0800 (PST)
MIME-Version: 1.0
References: <20230207145444.166950-1-clement.leger@bootlin.com> <20230207145444.166950-2-clement.leger@bootlin.com>
In-Reply-To: <20230207145444.166950-2-clement.leger@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 9 Feb 2023 09:48:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVL1YGnX4X2R_O1tMhRt07R8XUD2eWeFFgTcm7ShZrdcg@mail.gmail.com>
Message-ID: <CAMuHMdVL1YGnX4X2R_O1tMhRt07R8XUD2eWeFFgTcm7ShZrdcg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: soc: renesas: renesas.yaml: add
 renesas,rzn1d400-eb compatible
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Hi Clément,

On Tue, Feb 7, 2023 at 3:52 PM Clément Léger <clement.leger@bootlin.com> wrote:
> Add "renesas,rzn1d400-eb" which target the RZ/N1 EB board when a RZ/N1D-DB
> daughter board is plugged on it.
>
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> +++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> @@ -431,6 +431,12 @@ properties:
>                - renesas,rzn1d400-db # RZN1D-DB (RZ/N1D Demo Board for the RZ/N1D 400 pins package)
>            - const: renesas,r9a06g032
>
> +      - description: RZ/N1{D,S} EB
> +        items:
> +          - enum:
> +              - renesas,rzn1d400-eb # RZN1D-EB (Expansion Board when using a RZN1D-DB)
> +          - const: renesas,r9a06g032

Don't you want to have "renesas,rzn1d400-db", too, in between the two
other values?

> +
>        - description: RZ/Five and RZ/G2UL (R9A07G043)
>          items:
>            - enum:

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
