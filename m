Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBBD62E621
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 21:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbiKQUuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 15:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbiKQUuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 15:50:11 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10CC2727
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 12:50:09 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 7so3315514ybp.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 12:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niF2TfaqiGWEWf+fbzMXTHzb6tNy2XERgzLkPBLvhBc=;
        b=d8gqlCMpqbzH9SXu7HdP1XbTINWPqtkjFdpiOVsCHE2abnDL9MzbcWl7Tp6sEhm22R
         w05RMdqI8/v8B6qaxa5bAwAIJiE0O24PTqf08l0j8yDdHWWij+cn8zdfQXajCgfkbgpW
         kl1pCbLY2BYviFddRE+cxfP/UFoFhGj8G4ZiYM2bj1K53H7S+mGS07hgKgusAuA1Qz4c
         K0wX1SnlPRyO3Lg4ElU/WsDojNMQzuhqzIydhR0pRhd6K1Qu9ghdJNSHeDhr93qBH0Vk
         qE1QUqkEAVdkNTBWGJXlPYQqcYMq3JEOCkRpDi2JGdx7u0vywJHqES649lpWgfKV8zr3
         YEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=niF2TfaqiGWEWf+fbzMXTHzb6tNy2XERgzLkPBLvhBc=;
        b=rKbWxD72R7C31h28NygLvDBHuhrTmqguVkoboVS1Ualk9XrfVrkICvUkRGMd00xSYR
         rqPd1Q+70rEsR60BEODBNkjdqunVjirgvdByNnonGD9AZBIyQOqJ+aLlFqw46ov0hPKW
         DJp4gNqs34YnBCiF+vM97o0fXdJrJ4CBYM50Mr3MpVm9pvlVnb1yn+Z3sPL3SLGrae47
         ZdeTwHntFHXat69pTaC43Hutl3K6/Qx0RQwcoXLxoauaNMLO9szmPO9oBtC4pj1muDma
         p/9+XpmYo9GtQ5KNoVh6bWTYLB8oCuXR1L91/AuN2hCNSfeHVkHB9GM/Y07pJLGwdwJf
         AAQA==
X-Gm-Message-State: ANoB5pkp/kPY/Q+JhR/JJbdUodn2SDoT8FiapPPBvLkLUtFjMCqU2dGd
        8cjr9J4e/lBsBKqr/rnUkeTqG+G/naKU6B5Ini6ROQ==
X-Google-Smtp-Source: AA0mqf7zka4IouqmmsdERQL2C8NaNXIo67ho2D/5Z6cCUq0+wkfec9WZvlCC2Tgqul2V23BCPvtxNZNsDVlc9MeHF7E=
X-Received: by 2002:a25:ce83:0:b0:6dd:edba:c7cb with SMTP id
 x125-20020a25ce83000000b006ddedbac7cbmr3628727ybe.507.1668718209114; Thu, 17
 Nov 2022 12:50:09 -0800 (PST)
MIME-Version: 1.0
References: <20221116185500.40431-1-nfrayer@baylibre.com> <864juypoax.wl-maz@kernel.org>
In-Reply-To: <864juypoax.wl-maz@kernel.org>
From:   Nicolas Frayer <nfrayer@baylibre.com>
Date:   Thu, 17 Nov 2022 21:49:58 +0100
Message-ID: <CANyCTtTfhhORL32EweGN2Gtx9=kpA+PAxTUKE84C5sGmjTfPyw@mail.gmail.com>
Subject: Re: [PATCH 0/2] irqchip: Kconfig: Add module support for TI inta/intr
To:     Marc Zyngier <maz@kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, glaroque@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer. 16 nov. 2022 =C3=A0 22:44, Marc Zyngier <maz@kernel.org> a =C3=A9cr=
it :
>
> On Wed, 16 Nov 2022 18:54:58 +0000,
> Nicolas Frayer <nfrayer@baylibre.com> wrote:
> >
> > Added module support for TI interrupt aggregator and interrupt router
> >
> > Nicolas Frayer (2):
> >   irqchip: Kconfig: module build support for the TI interrupt router
> >     driver
> >   irqchip: Kconfig: Added module build support for the TI interrupt
> >     aggregator
> >
> >  arch/arm64/Kconfig.platforms |  2 --
> >  drivers/irqchip/Kconfig      | 12 +++++++-----
> >  2 files changed, 7 insertions(+), 7 deletions(-)
>
> How did you test that it doesn't introduce any regression due to
> implicit ordering requirements that are now voided?
Hi Marc,
I tested on a TI AM62x SK board.
By default the drivers are set to ARCH_K3 (built-in).
>
> Please Cc the TI folks so that they can at least check this.
I'll resend the series with more description and CC Ti engineers.
Thanks
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
