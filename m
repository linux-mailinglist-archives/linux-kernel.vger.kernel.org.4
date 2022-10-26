Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E0B60DBD4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbiJZHGL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Oct 2022 03:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbiJZHGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:06:09 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE59674BAC;
        Wed, 26 Oct 2022 00:06:06 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id l28so9310530qtv.4;
        Wed, 26 Oct 2022 00:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9EmVPQE/ovI/dPmhhr1wEw1SPWZw+nWSc8rrtFBbd34=;
        b=YMHPnSoVVge+rxOzqBa4Myguwk+u6mduuV3p7Gz9ljGgdc0RdNuc6/aQhSz5QR6CRe
         RI6vZ6bxYU9aDGVsGCC9GVYJGzevOIsm5JncZn0dpBPnlasz/T6lcKsRwVHKi35TXlai
         RK2LNLaU5gQIhUWc06vMcLh9gJDoIdVqpTjIJ2lg3Z0oF/3ibnDT4RP8CjG9wJ6LY9H0
         ttwHxiNSQw4UHOroYfLODdm03rR1OVi3fbXxGNjo2Rt2CUZfOvowiTVVCrDFAPYY9q49
         6t47LTAbLFLDe1KcjqPJmWlKQBKisC9LNdmNpCCeslqoD3xRbXterlZI3ui2lz330xgI
         tUYA==
X-Gm-Message-State: ACrzQf0T3ouR+b0MGI8Sv4mmi5hYjKq6i4tHf2cUoNOKlG6IsxiXaDDo
        dr9YC0glIHSc0ycsnECqUlpS0pFglQkH+w==
X-Google-Smtp-Source: AMsMyM5P+foiYncIasrJ6IajVDiZX/dm91ucePDtQONgyhN1+Zf+xjlc00XIstDKG3Umd8ySHeOUHg==
X-Received: by 2002:a05:622a:387:b0:394:7a0a:9584 with SMTP id j7-20020a05622a038700b003947a0a9584mr35549849qtx.60.1666767955116;
        Wed, 26 Oct 2022 00:05:55 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id w5-20020a05620a444500b006e2d087fd63sm3468738qkp.63.2022.10.26.00.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 00:05:54 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id n130so17708952yba.10;
        Wed, 26 Oct 2022 00:05:54 -0700 (PDT)
X-Received: by 2002:a5b:52:0:b0:6cb:7584:1b20 with SMTP id e18-20020a5b0052000000b006cb75841b20mr5924096ybp.380.1666767954181;
 Wed, 26 Oct 2022 00:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <12f2142991690d2b1d6890821f6e7779a4d4bdc0.1666706435.git.geert+renesas@glider.be>
 <20221026001713.kuu5mj6kogosvqnk@pengutronix.de>
In-Reply-To: <20221026001713.kuu5mj6kogosvqnk@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Oct 2022 09:05:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW=h922855yyiiR2Bo+P2Dg7S7r1pVBF56S+Z0ytng3fA@mail.gmail.com>
Message-ID: <CAMuHMdW=h922855yyiiR2Bo+P2Dg7S7r1pVBF56S+Z0ytng3fA@mail.gmail.com>
Subject: Re: [PATCH] pwm: Add missing dummy for devm_pwmchip_add()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

On Wed, Oct 26, 2022 at 2:17 AM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> On Tue, Oct 25, 2022 at 04:03:42PM +0200, Geert Uytterhoeven wrote:
> > The PWM subsystem supports compile-testing if CONFIG_PWM is disabled.
> > However, no dummy is provided for devm_pwmchip_add(), which may lead to
> > build failures.
> >
> > Fixes: bcda91bf86c1ff76 ("pwm: Add a device-managed function to add PWM chips")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Is this a problem that today yields a failure to compile? As of v6.1-rc1
> and also in next all callers are below drivers/pwm/ which isn't included
> in the build without PWM=y.

So none of these support compile-testing with CONFIG_PWM=n...

> Am I missing something or is this just preparing that one of the drivers
> that doesn't live in drivers/pwm might call devm_pwmchip_add in the
> future?

I saw it with the RZ/G2L MTU3 PWM driver[1], which is not yet applied.
After noticing its sibling counter driver lacked a dependency on
CONFIG_COUNTER, I tried disabling CONFIG_PWM...

> In that case I wouldn't add that Fixes: line (and also oppose to
> backporting that commit to stable).

I tend to disagree: more drivers may be converted to devm_pwmchip_add()
in the future, possibly as part of a fix, causing troubles for the
stable team when backporting such fixes.

Thanks!

[1] https://lore.kernel.org/all/CAMuHMdWE+H=aXkt61hZK6mbQairwdk1F522mZRemC0T5LxQtMg@mail.gmail.com

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
