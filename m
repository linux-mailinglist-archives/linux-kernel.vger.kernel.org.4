Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA2863BCFD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 10:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbiK2Jcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 04:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiK2Jcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 04:32:50 -0500
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32581E711
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 01:32:48 -0800 (PST)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 2AT9W95h017377
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 18:32:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 2AT9W95h017377
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1669714330;
        bh=q/JmDqY6ZRCZRuLvhYeSw2JChEy0BBcsxyEmrOBAzZM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bHiA/KNIjelohJ3X7qiDzn2Ber+EQubl4XqdW0/2uPKizHNa4BbudrTQQ5CRLBGZs
         kQSz+RWwa5XI4e9wGq40XUn8fnmEWeuTrtEQtlOE/6FUAKaG7gjRuyZuv/Q11fHH3g
         lZNcKKUoO3Q4aBXHVioq67D/0+avAhlR136coUnWRtR3+yHZn32DR4XKcm1GyHw+IG
         zDwBUBkim2Sr4ZcFFn9QITZWHFEqbEzemMUum0g0ZeFbnE5TvlmTvHx/Ik8zYdLyzo
         6k+5anV0Y0y3OmeyyevlnP4SbCs6EBhCEEdct2jyYgL6uRbNcfHXWW1ThqfpzYIAqY
         VaECvm+bNaNig==
X-Nifty-SrcIP: [209.85.167.179]
Received: by mail-oi1-f179.google.com with SMTP id l127so14539743oia.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 01:32:10 -0800 (PST)
X-Gm-Message-State: ANoB5plaJV880Hfw5ETa9Hb7TD033VgLJ5hgR4etvY2912OGO1oelTTb
        8pUWXjMd1EdF18DzWkoZ7OZIPeHYm0y0T1U/Gqk=
X-Google-Smtp-Source: AA0mqf7bodWJFNLDikd/rcLNd4BOT1NRsA02M6/379i66X8ke8jBxU/NKe1nREvGpq0xvy+KFo7vmA+PacSXp5XJnZY=
X-Received: by 2002:aca:1c06:0:b0:354:28ae:23b3 with SMTP id
 c6-20020aca1c06000000b0035428ae23b3mr18092147oic.287.1669714329287; Tue, 29
 Nov 2022 01:32:09 -0800 (PST)
MIME-Version: 1.0
References: <20221126051002.123199-1-linux@weissschuh.net> <6dc8ce0d-6587-5f39-d8cc-e4626ebfaf41@intel.com>
In-Reply-To: <6dc8ce0d-6587-5f39-d8cc-e4626ebfaf41@intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 29 Nov 2022 18:31:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNASzeb5cEkHg8EimFnp02L0Kdcj_=c5GbD12g8JTH+3UqA@mail.gmail.com>
Message-ID: <CAK7LNASzeb5cEkHg8EimFnp02L0Kdcj_=c5GbD12g8JTH+3UqA@mail.gmail.com>
Subject: Re: [PATCH 1/3] firmware_loader: remove #include <generated/utsrelease.h>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 10:18 AM Russ Weight <russell.h.weight@intel.com> w=
rote:
>
>
>
> On 11/25/22 21:09, Thomas Wei=C3=9Fschuh wrote:
> > utsrelease.h is potentially generated on each build.
> > By removing this unused include we can get rid of some spurious
> > recompilations.
> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> > Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> > ---
> >  drivers/base/firmware_loader/firmware.h | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/fir=
mware_loader/firmware.h
> > index fe77e91c38a2..bf549d6500d7 100644
> > --- a/drivers/base/firmware_loader/firmware.h
> > +++ b/drivers/base/firmware_loader/firmware.h
> > @@ -9,8 +9,6 @@
> >  #include <linux/list.h>
> >  #include <linux/completion.h>
> >
> > -#include <generated/utsrelease.h>
> > -
> >  /**
> >   * enum fw_opt - options to control firmware loading behaviour
> >   *
> >
> > base-commit: 0b1dcc2cf55ae6523c6fbd0d741b3ac28c9f4536
>

Applied to linux-kbuild.
Thanks.

--=20
Best Regards
Masahiro Yamada
