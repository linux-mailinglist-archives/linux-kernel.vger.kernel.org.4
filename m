Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215C16B048F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjCHKeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjCHKdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:33:44 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A149FBC1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:33:34 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id h34so315358uag.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678271614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGp9kJNOy/MvV2h5EiBDtzsq9fvXJI2E7p7glwCK5Sw=;
        b=ecHe0yUvQ33Yuy+0BQfNqmXadKdL0Ul+YBzElno5oxWkhCeL+XErO6QoIXtJ/XA+Bz
         B3n78yvB4MpSL30XFEf3+y2mmQ5GBiS+0F5q4COvgLi/EnvuQxmmq0QDAPirlGp2X25f
         B2q+TynykJsOmvhcxoUSq8o0ztnQsC2m6muLPwjKGMwUFadD+ZstcvJ/41gp15f8LqXx
         tLgWvRMqHeLAio9hIaNbKYE5rbRUbMzSmmpGbejTiuLlNpD3OsoA6dveBJSFR+hEydt3
         D3ZE6gl6l1lYu6Tgwur9fYs7+uJAI899SjMkf631Y0MONjgflLFlQ1mm63IhomarhJGp
         AU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678271614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGp9kJNOy/MvV2h5EiBDtzsq9fvXJI2E7p7glwCK5Sw=;
        b=6FtHrqdnYxVipJthvb7HaWC24Ubr8oI2Rp9GsducEqQ8MeB02+Adoz5+8mXoyHrFHc
         PojPUVX4Dmyl/u5WG8j/EIJlvOIY3iM7edCx0MO/OcTSAMpRAGgeLcNrDIkxUG6HnYKs
         4yuLL8urbt/FJtM7XAVUHFScRbwJD3ukxUYlaN5Soza3jHi8iamdobkzr02hh5uGuA0h
         HLL4+gbP7frMOvAcTSK5iwO/fdzYpegPu6Cowk77SpJBu0cQKOEqs206OWXVplYvIB2T
         erFVxgWjTBeeETsgxJ42n68zudtPWeQNJujPKjAP+JbbcfBsFXqKEASq8xTWNlfKtqaZ
         1EKA==
X-Gm-Message-State: AO0yUKW0IxVTCApaCJhCCyILUzzuD2fwPCEXZWmYa97mbd78QyCn5K/A
        S+3upde+JhzmG0flfeFCZ2RvWgzP0aHRmrYjFpMAQA==
X-Google-Smtp-Source: AK7set+CI+CtTWvRAiC2RB5n3wOlSww42w/EeijngJLRnV28Hk4FzkQzUfY2lXuLl1M1tgzd9qRz+5Oeb5tBga4tNZw=
X-Received: by 2002:ab0:4a12:0:b0:68b:b624:7b86 with SMTP id
 q18-20020ab04a12000000b0068bb6247b86mr11776983uae.2.1678271613848; Wed, 08
 Mar 2023 02:33:33 -0800 (PST)
MIME-Version: 1.0
References: <20230307165432.25484-1-afd@ti.com> <20230307165432.25484-5-afd@ti.com>
 <CAMRc=Mehx9Xv=xwd966N0LwEND-mxnPyjEAex8TrbycgbGQrag@mail.gmail.com>
In-Reply-To: <CAMRc=Mehx9Xv=xwd966N0LwEND-mxnPyjEAex8TrbycgbGQrag@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 8 Mar 2023 11:33:23 +0100
Message-ID: <CAMRc=Mdo75AcS7zWJRPLJiss34+XZg8cs4OiT=e9EzTt-C8a0Q@mail.gmail.com>
Subject: Re: [PATCH 5/6] gpio: tpic2810: Use devm_gpiochip_add_data() to
 simplify remove path
To:     Andrew Davis <afd@ti.com>
Cc:     Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 11:28=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Tue, Mar 7, 2023 at 5:54=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:
> >
> > Use devm version of gpiochip add function to handle removal for us.
> >
> > While here update copyright and module author.
> >
> > Signed-off-by: Andrew Davis <afd@ti.com>
> > ---
> >  drivers/gpio/gpio-tpic2810.c | 18 ++++--------------
> >  1 file changed, 4 insertions(+), 14 deletions(-)
>
> Applied, thanks!
>
> Bart

Scratch that, please do the same as for patch 6/6.

Bart
