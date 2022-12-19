Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3155651125
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 18:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiLSRTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 12:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbiLSRTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 12:19:18 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC79013EB6;
        Mon, 19 Dec 2022 09:19:14 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id 6so4605760vkz.0;
        Mon, 19 Dec 2022 09:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aZRGUJIQAa5KK6Y33xr4h/ZDNiIwMoPJ3eE77a0n7hg=;
        b=auj81D1GJXAgJiqie/fXN9atmWN/0DCcWtL6GTUXu2nR7Nbelgq4p2I3MJFiETa8WQ
         2+pbBS3lri7AHoZLt+aqvo3LSRB9ZEZ4nikQPnfFr9yh75THj/A9bZsUXDkgTx3PMgAx
         jZDGTdXV7RpjU98zLx1QKUi9pgLy0IAHRGFLISuKoHM+23T8Dfslcl6CPap5/J85GjxT
         MhC7KljFly2JdMLEGbXEeaLnfeOzHRcWMa3fl5TrMaLuqyjlqEv+gN3PyiSLsVbbqb3W
         7ByQKOMg0pSXAaWfIkD5U07eDro2jYJnuGBPYVaq1aEOj5QZKk91f9sgh/g4mcR9kNrS
         NXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aZRGUJIQAa5KK6Y33xr4h/ZDNiIwMoPJ3eE77a0n7hg=;
        b=aek7wmSS3KOAHfClzkMvP6YsduIVapPGucwRduBfzP9Pw0v25Y2vb1Wr8R+8XUu0bo
         2XJLTI/+C84ldmgPOtlbciXySMEoFczzOjsAU4on8m+3sYZI28N+yE/O4eGDj7+CuS3y
         P21KYTEo748+xvv+tgnr0bgh24AEIBAxFuYn1oZrN8BiQouPQ/A/OLnMx5wT+ffLOEFH
         Jh+8QXmWDRfqpYvviMB9GEtgHrfQqfzKpSlSyuQnZQtemsyU3EotT/sPIkWnUIYE8Bk/
         FTphmWD+Lghbq8gX694VKsfzL603+pQqBLxZEyEGEkBRsOHgDUnh0buvv8GE53kQBeOf
         WUwA==
X-Gm-Message-State: ANoB5pnFsyrP0JM/Czzeb7/lBB/9zgktU6lQxkeG7BErqjl6IolJ+RdS
        R/7r6nQMAzLGKKrZ8cd5p3MLy9bJ07FfGyAIQ9r873tmogE=
X-Google-Smtp-Source: AA0mqf6axTdy5vFx6gaiz7Pe6RB12fD2A5bZU42tZeMrqi50Qtg3hg3u8VI1oUtUABh5JcVdVjD4VDyDPMLuHTE/Pgo=
X-Received: by 2002:a1f:58c1:0:b0:3b7:bd26:9251 with SMTP id
 m184-20020a1f58c1000000b003b7bd269251mr48290118vkb.25.1671470354004; Mon, 19
 Dec 2022 09:19:14 -0800 (PST)
MIME-Version: 1.0
References: <20221215150214.1109074-1-hugo@hugovil.com> <20221215150214.1109074-15-hugo@hugovil.com>
 <CAH+2xPAWo=nycQMLrjye8i3a3textJdyYJcWRG3Jq-tbN0a9RA@mail.gmail.com> <20221219112542.fb30929b8b91255dcba5a289@hugovil.com>
In-Reply-To: <20221219112542.fb30929b8b91255dcba5a289@hugovil.com>
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
Date:   Mon, 19 Dec 2022 18:18:58 +0100
Message-ID: <CAH+2xPA0uc8wCtaR7Z48G9SkHWQG=Gb9XtxBCPKUgKfq5EDVQA@mail.gmail.com>
Subject: Re: [PATCH v3 14/14] dt-bindings: rtc: pcf2127: add PCF2131
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den man. 19. dec. 2022 kl. 17.25 skrev Hugo Villeneuve <hugo@hugovil.com>:
>
> On Mon, 19 Dec 2022 10:14:10 +0100
> Bruno Thomsen <bruno.thomsen@gmail.com> wrote:
>
> > Den tor. 15. dec. 2022 kl. 16.19 skrev Hugo Villeneuve <hugo@hugovil.com>:
> > >
> > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > >
> > > Add support for new NXP RTC PCF2131.
> > >
> > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > ---
> > >  Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> > > index cde7b1675ead..a8f8c23da4d8 100644
> > > --- a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> > > +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> > > @@ -14,7 +14,9 @@ maintainers:
> > >
> > >  properties:
> > >    compatible:
> > > -    const: nxp,pcf2127
> > > +    enum:
> > > +      - nxp,pcf2127
> > > +      - nxp,pcf2131
> >
> > The enum is incomplete as pcf2127_of_match struct also contains:
> > nxp,pcf2129
> > ncp,pca2129
> >
> > /Bruno
>
> Hi,
> if I understand correctly, this means that the pca2129 and pcf2129 entries are already missing and should be added in a fix or a patch outside the scope of my new driver...
>

Correct, I just noticed while doing review.

> Hugo.
>
>
> > >    reg:
> > >      maxItems: 1
> > > --
> > > 2.30.2
> > >
> >
>
>
> --
> Hugo Villeneuve <hugo@hugovil.com>
