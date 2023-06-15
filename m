Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4037312C2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245193AbjFOIxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242925AbjFOIwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:52:41 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A612119;
        Thu, 15 Jun 2023 01:52:40 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-62fe192f7d3so13698726d6.3;
        Thu, 15 Jun 2023 01:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686819159; x=1689411159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfjnL8iZVG6Mx/ONtM8yW/3rhlvTFehEBpTE84Y2bxw=;
        b=qGGeYP2EqA9thoMoTqi4Q2aR73Z9Dik9sLkQa+TzARg+7tVn/JOoDu0V8/33lJPPZF
         Xcjwrqcf3ETJ6Ld6b4ms4Hq+QU1QkHdXX6SCUKy3rOLgQu8dCofOr47h15QXZ5HypUKW
         V/X1P1CMbARCXq0esUYeMVPKvUaayQoDk9mG5JEz54wO1JP23T3CcIrUs0aLD6Tz/Jgv
         Z8uoaHOU90lQOhk/z9k72LaRxWq5j1328uBLIwVT1SHeUZ8cwH5Q52ZspDgvhKQGMygh
         UstTcx4BWEloyE/ijfsXwMiF4gnryCgUJNYpgJgFthNBxt697ZwxThsFgh0KCXXylWep
         6X0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686819159; x=1689411159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfjnL8iZVG6Mx/ONtM8yW/3rhlvTFehEBpTE84Y2bxw=;
        b=jCPlvAlLgkg36xRE/qH9GFk0DnqN7XspEwHz5XmKktolwZTsN7bfx6CW0T4K/MGgW1
         wxym8GrFYY4C1m/GEAFQm0zV6aXyFQcA7UM8CFLwqQJJJK3fzZbhe84S94y54mFDNzuq
         uz0Mk7RuPz46tz57KxqhZXyInl32UlVEscPOlK9VeM/Bn1jWECp7QcmZ/Mg74StXnfN4
         dM7bjyaNAwn0ohdvPcn/PXrpL9a3NoJj8jiPC7xOiMtxCa9+2TgiOZU++gdOSOJ59zmM
         V2kAF6rE0pifJmer6iCvs41VF5yZbQ3+vffsgE5H0o/G2hDXjcc21b7mH2vxyaLFI/MC
         CDhA==
X-Gm-Message-State: AC+VfDz3EpAI5zj6cAm42h+EsJOWFWoSj1LJlgOPgcyRzzYhcVxVCpW3
        ImfBcWljrKDYqwM+fFrUq86TkV1N6eAps8b5rYw=
X-Google-Smtp-Source: ACHHUZ6IcYdulXvN18UCcZg+7iapzcqX0Q5SI+J6hOPF0kIcL4+i2Bk+Nq3p0q7rgnUWz0P881kOqrrUqQX10SKQvDI=
X-Received: by 2002:a05:6214:d8a:b0:62d:fa7c:6b8c with SMTP id
 e10-20020a0562140d8a00b0062dfa7c6b8cmr7305635qve.37.1686819159644; Thu, 15
 Jun 2023 01:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230614231446.3687-1-andriy.shevchenko@linux.intel.com>
 <20230614231446.3687-4-andriy.shevchenko@linux.intel.com> <CACRpkdbv=9YX145=oH88bLS4d=J1xYWc_NGEN=KW0duJ38tUVg@mail.gmail.com>
In-Reply-To: <CACRpkdbv=9YX145=oH88bLS4d=J1xYWc_NGEN=KW0duJ38tUVg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 15 Jun 2023 11:52:03 +0300
Message-ID: <CAHp75Vc9Ra4_rRhtScDrNqV0SJPNf-MDF_yksbKoYnTDuYeAxg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] gpio: aggregator: Set up a parser of delay line parameters
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 9:37=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:
> On Thu, Jun 15, 2023 at 1:14=E2=80=AFAM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>
> > The aggregator mode can also handle properties of the platform,
> > that do not belong to the GPIO controller itself. One of such
> > a property is a signal delay line. Set up a parser to support it.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> I guess this is one of those instances where we actually need some OF-spe=
cific
> code for parsing the special case, and other HW descriptions will need
> other special code. It's fine for non-trivial stuff I think.

Actually if you look into IIO, the xlate there is fwnode specific
nowadays and theoretically the specifics of OF can be parsed in ACPI
as well. I would like to get rid of OF_GPIO completely, but let's
see...

> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thank you!

--=20
With Best Regards,
Andy Shevchenko
