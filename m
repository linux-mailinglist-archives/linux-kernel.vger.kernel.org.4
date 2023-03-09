Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0046B2484
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 13:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjCIMvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 07:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCIMvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:51:33 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A970DCF44;
        Thu,  9 Mar 2023 04:51:32 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id ff4so1306763qvb.2;
        Thu, 09 Mar 2023 04:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678366291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QekU0YNn3mbD6AYvI5YHqh8x/DBqYjtkxe4katytWw8=;
        b=Ttrq5gJ0pglRqY95IS+HHss9Ze7FHYvXM57hNMlu6iX/Ma0QE/UCTWrTlGJbpjavVq
         CUPKZ+B6OliOV4e0RO8rt/vUWOTFAM7DM3XGw+5LAApMzFE4uB0B3E0h0C3dY4FVKs/v
         rW6cqobsUoeaXd24s178j4NQWzcxsA7RbHwvV1sPcNYrjlLRe+3Pm6DUjv8Od2O1NAYg
         hvDW7r44hLfnZojCXYtOn9nPzWfNpd1k3eXd2nYnalG0Zi/U4flK8VG1rePXqXzhK5a6
         DumaWz/77q+b/hIt6sxVzqveIWDh2v6oMICSUx1YXra4G7sDdlOZygmlTq+BqudQPLnC
         GHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678366291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QekU0YNn3mbD6AYvI5YHqh8x/DBqYjtkxe4katytWw8=;
        b=oLx8hNJB2xYvoLt2XtznliKE8+BILdhQk7dzuK4YZ2n6iLmISQtNxNyUWYzwqHPCsO
         AtqL2t13VaDAgYXmhFXQvO5HtVp9OYerZJih9MA58BotZYg//Jr8pbFDB3z6G7Ec9CU3
         BfYBcHmBIEkO3W7y0O5MsANhl8k6BflAZ5LBVo8rUHP3X04b/T+hNb3HAUEc/AfTzBrL
         EMCGI34o9yL3dRO63alW2raxtfCtk+TENP1K0ZFU7X/X89VL2Z9S52UhhiJVPZC/Ani5
         gs8KTgB2M6QK29rxKuUt7bdIi2I0othFIhtEMbPcs/JQSFh5vgmc5JbH1qiDLpzUmlvG
         8lNA==
X-Gm-Message-State: AO0yUKXY3OlSbl1RAgzQ5IERxYEJSUXEFMqxsgqYvw961ELCyxYxVQnt
        y07dN3fPkg8kvAOrapvx2LYtzQ4Q5/1IZ5Oz1kE=
X-Google-Smtp-Source: AK7set8lIME8MtjxCRJAM3zkPXe0oqBE18AAL1pXcYmVbWrVZreeDsgmvR7uvvlOaOCbtyyqUcsCjT9zjyVlVcy1wqA=
X-Received: by 2002:ad4:5585:0:b0:570:f9b6:dac6 with SMTP id
 f5-20020ad45585000000b00570f9b6dac6mr5569553qvx.1.1678366291641; Thu, 09 Mar
 2023 04:51:31 -0800 (PST)
MIME-Version: 1.0
References: <20230220023320.3499-1-clin@suse.com> <20230220023320.3499-3-clin@suse.com>
 <ZAZ3CeYiZxR5zlRu@surfacebook> <ZAgXCi/BzyEQul9B@linux-8mug>
 <CAHp75VfxffTvAPSB4D2Oc3-vbiYM4DVpZf5=jRYGsCdFgAyxJA@mail.gmail.com>
 <ZAi7CPXX0z80mKfQ@linux-8mug> <ZAjAN4mO8U1Dh86P@linux-8mug>
In-Reply-To: <ZAjAN4mO8U1Dh86P@linux-8mug>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 Mar 2023 14:50:55 +0200
Message-ID: <CAHp75VeFcCyso4_qaDFccZEfG=3NtyfmFtvZKRR--LdqLryRtw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] pinctrl: add NXP S32 SoC family support
To:     Chester Lin <clin@suse.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, s32@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Matthew Nunez <matthew.nunez@nxp.com>,
        Phu Luu An <phu.luuan@nxp.com>,
        Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 7:05=E2=80=AFPM Chester Lin <clin@suse.com> wrote:
> On Thu, Mar 09, 2023 at 12:43:35AM +0800, Chester Lin wrote:
> > On Wed, Mar 08, 2023 at 03:21:00PM +0200, Andy Shevchenko wrote:
> > > On Wed, Mar 8, 2023 at 7:03 AM Chester Lin <clin@suse.com> wrote:
> > > > On Tue, Mar 07, 2023 at 01:28:09AM +0200, andy.shevchenko@gmail.com=
 wrote:
> > > > > Mon, Feb 20, 2023 at 10:33:19AM +0800, Chester Lin kirjoitti:

...

> > > > > > +   depends on ARCH_S32 && OF
> > > > >
> > > > > Is OF necessary? Can it be
> > > >
> > > > I think it's required since the driver file refers to of_* APIs.
> > >
> > > And? Is it functional or compilation dependency? If the latter is the
> > > case, what API exactly isn't providing a stub?
> >
> > I was wrong. Looks like the ARM64 arch Kconfig always select OF so it's=
 not
> > really necessary to have OF here.
> >
> > > > >       depends OF || COMPILE_TEST
> > > > >
> > > > > ?
> > >
> > > So?
> >
> > Since the OF dependency is not really necessary here, to fulfill the co=
mpile test
> > purpose, the possible dependency might be (ARCH_S32 || COMPILE_TEST), b=
ut it
> > could meet a compiling failure on the reference of pinconf_generic_pars=
e_dt_config()
> > for those architectures which do not select OF by default since there's=
 no stub
> > for this function. [pinconf_generic_parse_dt_config() is called in pinc=
trl-s32cc.c]

So. your driver needs to select the proper module and since there is
no stub it probably needs to be added.

Linus, why do we have no stubs in the first place?

...

> > > > > > +   depends on ARCH_S32 && OF
> > >
> > > Ditto.
> >
> > Based on the previous assumption [OF is not needed and PINCTRL_S32CC do=
esn't
> > depend on COMPILE_TEST], selecting PINCTRL_S32G2 wouldn't work if it si=
mply
> > depends on (ARCH_S32 || COMPILE_TEST), for example:
> >
> >   WARNING: unmet direct dependencies detected for PINCTRL_S32CC
> >     Depends on [n]: PINCTRL [=3Dy] && ARCH_S32
> >       Selected by [y]:
> >         - PINCTRL_S32G2 [=3Dy] && PINCTRL [=3Dy] && (ARCH_S32 || COMPIL=
E_TEST [=3Dy])
> >
> > So the better solutions is to still have OF in PINCTRL_S32CC, such as:
> >
> > config PINCTRL_S32CC
> >       bool
> >       depends on ARCH_S32 || (OF && COMPILE_TEST)
> >       .....
> >
> > config PINCTRL_S32G2
> >       depends on ARCH_S32 || COMPILE_TEST
>
> Fix the dependency here, it should be:

Nope, this is definitely wrong.

> config PINCTRL_S32G2
>         depends on ARCH_S32 || (OF && COMPILE_TEST)
>         .....
>
> Just in case if OF is not set but COMPILE_TEST is set.

--=20
With Best Regards,
Andy Shevchenko
