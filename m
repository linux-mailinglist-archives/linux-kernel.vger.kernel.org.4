Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23526A88E0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjCBTC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjCBTCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:02:50 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8012455043;
        Thu,  2 Mar 2023 11:02:45 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id ne1so187693qvb.9;
        Thu, 02 Mar 2023 11:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgZLhcylDGqT1DTv86aGHQyWy2f7m4PatAYISBhTMus=;
        b=lJv26ZaiE8s/Qo+UoeSNSZlH1LUB2Jd7TJeP3hyTd84KlfERut3Z47c3f2daYiUOiE
         PecNDeGE9Tb0A5AIHrz+ibTahBRSBJC3c74BRCaFFJ/08pmpCoE9AdDK04rMy39dlOZB
         2x0UZnwuQ/IrBk/I3DGEZH02hEkMJDt8TX6YC/nR/rSYWTepfbd88fRwb3rjCjugdeDU
         7pwr4zquEQDMFfYgFmndMhOFX2oacaSuEC/MoG0FQ+pNzHXH/PHhbvR7AOgCiJV9A6fr
         hCrJbt5WhHlKbrAeWxpxyvzY8ZVvhrMdxaP6cg/fhGaIC1K9sBFaI4al4xOsZfadxND8
         lPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgZLhcylDGqT1DTv86aGHQyWy2f7m4PatAYISBhTMus=;
        b=poBDbi+OCaGC+RorH3CEpckUDb1CvGypxDSZWL3aj+02fFqDuF8V1DFo5FtgpTojvG
         XV1V4nHW0l+JnWf5zfBAAVICmROhTQPsByzW8S7UO6CrKzSHd+em8jC+FP24wgli1TLB
         wZ77O4SfBHeRBkptCsUW0kvD2WvVbelC1/DGDpnUB0W/Y/zWcQaz6zShJKkCPOvwWLrb
         j89yWtk49gRAyC6RqSjisLRCpKXF6FNTG/0ClNc7ttdyuR2UBBOP6uvIvYLJdqnfQNdx
         hzyIvXQ4kZJjuc4OjelJpuax67nld6jAZcsEEUK8jYJ57W0VlGsA8VvyNd35/BsLQoiU
         1vUA==
X-Gm-Message-State: AO0yUKW2jqsnDqS/4EveRWe5VrcquWuqK5ehyjtgxRoCzjih6Ze9lAjO
        KKS9hixNXiKxkXPB2xn1K/uuCywCcquGzOIRoZs=
X-Google-Smtp-Source: AK7set+7k2lBWRyijszGFNhZnO21X6A9GVE6GeQOqqBiWhKjlnee70nQIPXvhTL+IDXUircQ7ZqgxtF9hPVs9QGcSak=
X-Received: by 2002:ad4:4b6f:0:b0:56f:fe44:f257 with SMTP id
 m15-20020ad44b6f000000b0056ffe44f257mr3100124qvx.1.1677783764401; Thu, 02 Mar
 2023 11:02:44 -0800 (PST)
MIME-Version: 1.0
References: <20230222111213.2241633-1-keguang.zhang@gmail.com>
 <20230222111213.2241633-2-keguang.zhang@gmail.com> <Y/YH20aKp+u+QEwA@surfacebook>
 <CAJhJPsVqPAC_GP0JE98nrpmvDTwXdt4m0z3SZQPX3GFCijT09w@mail.gmail.com>
 <5cc00c00-7dd3-4b7f-71e6-397f76acaed0@linaro.org> <CAJhJPsXFU5DqU1HUw402EKtU3Y7WJNP3UBE3_CQuCdAqg81UQQ@mail.gmail.com>
In-Reply-To: <CAJhJPsXFU5DqU1HUw402EKtU3Y7WJNP3UBE3_CQuCdAqg81UQQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 2 Mar 2023 21:02:08 +0200
Message-ID: <CAHp75Vc18wamJzNHQigs3XaJty5pJbuHCbSEHnpZKDG9wH7tsA@mail.gmail.com>
Subject: Re: [PATCH 1/4] gpio: loongson1: Update copyright
To:     Kelvin Cheung <keguang.zhang@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
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

On Thu, Mar 2, 2023 at 2:16 PM Kelvin Cheung <keguang.zhang@gmail.com> wrot=
e:
> On Thu, Mar 2, 2023 at 7:40=E2=80=AFPM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> > On 02/03/2023 12:09, Kelvin Cheung wrote:
> > > On Wed, Feb 22, 2023 at 8:18=E2=80=AFPM <andy.shevchenko@gmail.com> w=
rote:
> > >> Wed, Feb 22, 2023 at 07:12:10PM +0800, Keguang Zhang kirjoitti:
> > >>> This patch updates copyright and author information.
> > >>
> > >> ...
> > >>
> > >>> +// SPDX-License-Identifier: GPL-2.0-or-later
> > >>
> > >> Have you talked to your lawyers? This is an inequivalent to what was=
 written
> > >> below.
> > >>
> > > Yes.
> >
> > Yes to what? You now change the license... and commit msg does not
> > explain it and does not justify it. What is even weirder that your
> > lawyers agreed on GPLv3! With GPLv3 you need to open a lot from your
> > products... Not mentioning that they agreed on future GPLv4 and GPLv5,
> > that's even weirder because GPLv4 might be saying you need to buy me
> > flowers...
> >
> If so, I choose to leave the license as is.
> Is "GPL-2.0-only" right?

We do not know.
It depends on what your company lawyers told you.

--=20
With Best Regards,
Andy Shevchenko
