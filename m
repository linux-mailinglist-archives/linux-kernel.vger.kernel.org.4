Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985AC6909AE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjBINQO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Feb 2023 08:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjBINQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:16:12 -0500
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04695A9C4;
        Thu,  9 Feb 2023 05:15:48 -0800 (PST)
Received: by mail-qv1-f52.google.com with SMTP id k28so1284134qve.5;
        Thu, 09 Feb 2023 05:15:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=weP3SIHvRUQVnBg/cDFazZD9lkCoaJixRzFAmta4Hlc=;
        b=Q9iDZAk2d2NGIbX0Gx9Ay/J1/tlH8e4Xk0em/sQDjBvGqCDcXahw9Jk54hj+V7kfcm
         GWLzKJThqu7ew1bscxSX09Qs/vKaUshCSUWDs/7x7MqpFOIRDLoJ9avEYzdw2GtchHON
         UQlqOnyF5pM3G68iyGJBZSy29dSi+cZp0LMxU7APJUq926I+Jq0XnBMR+wtbOMY2brGu
         LfVqmAIINvE16UkCEHH9tzGCEjY43h+jxCRGF9tme1dvDrQYszgseSiGV/8RIoc062Gs
         oi8v1H7MLyByyR6RgCZXoOYKZS9EHUukMim9qwzws4LLFokKw2P7kS9kFVvbLYe40Vkj
         Yrow==
X-Gm-Message-State: AO0yUKUi/vPm7SATusgy7tYk1NcEj6PrzzOcmchwQM17R9Yckp8MBOdO
        EtI8XF9ugRhZW5nLPyrRhZU1rSk1+nN9wQ==
X-Google-Smtp-Source: AK7set87M5BqYpVU5KG15Dcjd5Jsd90yVBmGE6dyO0JdwThOk9HsRlnVs1qnOxxnAynlUr0/ovTmWA==
X-Received: by 2002:a0c:cd85:0:b0:56b:fe23:13ac with SMTP id v5-20020a0ccd85000000b0056bfe2313acmr6714063qvm.26.1675948524848;
        Thu, 09 Feb 2023 05:15:24 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id e2-20020a37b502000000b00720f61af739sm1281691qkf.115.2023.02.09.05.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 05:15:24 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id q9so2292880ybk.2;
        Thu, 09 Feb 2023 05:15:24 -0800 (PST)
X-Received: by 2002:a5b:508:0:b0:8a3:59a4:340e with SMTP id
 o8-20020a5b0508000000b008a359a4340emr1169830ybp.604.1675948523828; Thu, 09
 Feb 2023 05:15:23 -0800 (PST)
MIME-Version: 1.0
References: <20230207145444.166950-1-clement.leger@bootlin.com>
 <20230207145444.166950-2-clement.leger@bootlin.com> <CAMuHMdVL1YGnX4X2R_O1tMhRt07R8XUD2eWeFFgTcm7ShZrdcg@mail.gmail.com>
 <20230209141610.31146ea9@fixe.home>
In-Reply-To: <20230209141610.31146ea9@fixe.home>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 9 Feb 2023 14:15:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVs95HXi=sJOE9jyn=jkBtzJTwkqsY+-1hmLEbaV=JWuA@mail.gmail.com>
Message-ID: <CAMuHMdVs95HXi=sJOE9jyn=jkBtzJTwkqsY+-1hmLEbaV=JWuA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clément,

On Thu, Feb 9, 2023 at 2:13 PM Clément Léger <clement.leger@bootlin.com> wrote:
> Le Thu, 9 Feb 2023 09:48:09 +0100,
> Geert Uytterhoeven <geert@linux-m68k.org> a écrit :
> > On Tue, Feb 7, 2023 at 3:52 PM Clément Léger <clement.leger@bootlin.com> wrote:
> > > Add "renesas,rzn1d400-eb" which target the RZ/N1 EB board when a RZ/N1D-DB
> > > daughter board is plugged on it.
> > >
> > > Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> >
> > Thanks for your patch!
> >
> > > --- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> > > +++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> > > @@ -431,6 +431,12 @@ properties:
> > >                - renesas,rzn1d400-db # RZN1D-DB (RZ/N1D Demo Board for the RZ/N1D 400 pins package)
> > >            - const: renesas,r9a06g032
> > >
> > > +      - description: RZ/N1{D,S} EB
> > > +        items:
> > > +          - enum:
> > > +              - renesas,rzn1d400-eb # RZN1D-EB (Expansion Board when using a RZN1D-DB)
> > > +          - const: renesas,r9a06g032
> >
> > Don't you want to have "renesas,rzn1d400-db", too, in between the two
> > other values?
>
> Do you mean like that ?
>
>  - enum:
>     - renesas,rzn1d400-eb # RZN1D-EB (Expansion Board when using a
>    RZN1D-DB)
>  - const: renesas,rzn1d400-db
>  - const: renesas,r9a06g032
>
> And thus using compatible = "renesas,rzn1d400-eb",
> "renesas,rzn1d400-db", "renesas,r9a06g032" in the EB dt I guess.

Exactly!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
