Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB286B9B43
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjCNQXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjCNQX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:23:29 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFF87D0B6;
        Tue, 14 Mar 2023 09:23:03 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id bm1so894347qkb.13;
        Tue, 14 Mar 2023 09:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678810983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8kZtwuGxIk12yKqz/wl+JhxCEqDQP8QUZ0wTg/xOB8=;
        b=RLc5cEUPpWTb8Xn21aXCkShp9V6a0C4qteMpi68fvyCjdv75/IWci58U/n3VoEhHNl
         T87CijZgbTsv6u3C3skEG4rHhd4mnauJEss8ASvB/wZTldEqCSZldsPzWSk/9aeJAaPB
         PHztWtP8eRI21gawlopFOuDWZAEa1tP1ceLz7Lbl7C2ADVPAUNFo/wLS0ioRSYblp8iV
         9k8EQ0AQXsW5dzpQLZNe5A/qoVR7v4zsUKhZCrfWU7KZlsgzoKvzPaY3bBXhD45tQnaz
         yM9xllPbOg6Wu5EYFzk1FNtFKHvhTRhqrMYetODL9kDYkULK8askrWTPfLlCs+PtpNs/
         8Adw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678810983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8kZtwuGxIk12yKqz/wl+JhxCEqDQP8QUZ0wTg/xOB8=;
        b=lDHVxltRT/mwm3EN5tU3ly9q3ifDRaqNe98j1w2pvUUbJfQzAKAcHR7Qsxii6h9o4b
         yaM/x7SIXJNnnNv8QngvSlIY5Nfih5vQPf8kloVhh8m+BUWhyakqJnUdUQ1WyM2KN1Dz
         OWhN9JgTtnQIuLJ9Cq9SOlTZIERcXxYjKAKiufJHMpfkFmaTzKPxAaFHbVq+M1feyAgQ
         C6ijHXAwWSenwKaiWvaIikmv5I1osuQ5BAmvqkQ2C7OHZx5LlMBCPMQzbEayt8qhMx3j
         fLNRugUuxQxzVZ6k4ljrcytu45G23wXdNdookKC590S/Y/uByEC6dm4ZKHWlKkJFB3NY
         w74Q==
X-Gm-Message-State: AO0yUKVM9THiTK8peYtcc3sIRt7EyZyiB/tX4GXzQ+WNcXyNRibSrQGA
        1CAOM/PCR8K7jQtnHpgMzNpDBUoWQkQyXWV30tM=
X-Google-Smtp-Source: AK7set+sCHzPHmJfAJF8JrpFLeIpfnP0JByW7FjEzgXTN/F0v7b5NGwF5GweRVs2bR77cSJR6GT/1LzFWEcCDpAPAUY=
X-Received: by 2002:ae9:f00d:0:b0:745:6afc:9bb2 with SMTP id
 l13-20020ae9f00d000000b007456afc9bb2mr2130644qkg.14.1678810982681; Tue, 14
 Mar 2023 09:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230314120252.48263-1-mmkurbanov@sberdevices.ru>
 <20230314120252.48263-3-mmkurbanov@sberdevices.ru> <3b920b9e-07dc-7bda-4fe1-d15d07e708cc@sberdevices.ru>
In-Reply-To: <3b920b9e-07dc-7bda-4fe1-d15d07e708cc@sberdevices.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Mar 2023 18:22:25 +0200
Message-ID: <CAHp75VcWuOEWZn2E8dG=Pb_KuEv06jYt_+nZSL-ceAQRPmgeGw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] leds: add aw20xx driver
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, devicetree@vger.kernel.org
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

On Tue, Mar 14, 2023 at 2:12=E2=80=AFPM Martin Kurbanov
<mmkurbanov@sberdevices.ru> wrote:
>
> Hello Andy. Thank you for review.
> I have fixed most of your comments. Please take a look below.

Good, but you can postpone issuing a new version before letting me answer.

> On 2023-03-01 00:51, Andy Shevchenko wrote:
> >> +       /* The output current of each LED (see p.14 of datasheet for f=
ormula) */
> >> +       return (duty * global_imax_microamp) / 1000U;
> >
> > units.h ?
>
> These constants are needed to improve the accuracy of calculations.
> units.h doesn=E2=80=99t have any helpful definitions to use here.

Okay, let me look at v3 and I will comment there.

...

> >> +static int aw200xx_set_imax(const struct aw200xx *const chip,
> >> +                           u32 led_imax_microamp)
> >> +{
> >> +       struct imax_global {
> >> +               u32 regval;
> >> +               u32 microamp;
> >> +       } imaxs[] =3D {
> >> +               { 8,  3300 },
> >> +               { 9,  6700 },
> >> +               { 0,  10000 },
> >> +               { 11, 13300 },
> >> +               { 1,  20000 },
> >> +               { 13, 26700 },
> >> +               { 2,  30000 },
> >> +               { 3,  40000 },
> >> +               { 15, 53300 },
> >> +               { 4,  60000 },
> >> +               { 5,  80000 },
> >> +               { 6,  120000 },
> >> +               { 7,  160000 },
> >
> > This looks a bit random. Is there any pattern on how value is
> > connected to the register value?
>
> There is no ability to create any pattern here, because this table data
> doesn=E2=80=99t have any regularity.

There is a clear pattern.

You have two tables, i.e. with multiplier 10000 and second one with
multiplier 3333 (table in the datasheet seems bad from a math
perspective). And it's even shown correctly in the datasheet.

With this mix you missed 10.

The coefficient table is 1,2,3,4,6,8,12,16 for both tables.

Hence you need one table and two multipliers.

Please, rewrite accordingly.

--=20
With Best Regards,
Andy Shevchenko
