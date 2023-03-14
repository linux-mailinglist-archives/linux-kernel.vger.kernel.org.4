Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D726B9C1F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjCNQuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjCNQuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:50:37 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84091A90A8;
        Tue, 14 Mar 2023 09:50:35 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id bm1so928510qkb.13;
        Tue, 14 Mar 2023 09:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678812634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeeMTBeHxd/XKAWq9zMSxWQt+iGsLohYMBPFE0cHKVw=;
        b=TEzl5OOjEfi4ZoGOkYN8gZFJ9gtcaQIqJwed9zRK/We5JdhhaPjWnKyIoazv/xeGma
         jB/RIr1qGrOugUO+eFk1R5B+fT5Zw4TRiYkLR6VgwPWh6pK7kMDSaYY4th2TsTWhl0vR
         mQa/iCgSU/2gX6ZcJ4l3UL8vJqPoK7I8vFJehWeb2gjdcy+1l1LJjEI95rh2AuSVGUwW
         Oqnh82Q0MF621wl4L0Gn5IArlQX7YU7LIYIGG29D+lRj09YL8dDwaZaaodx6urCZZqZr
         B8+oQBBPAPFJu53GBTK5I+7YJjWA0SIs1sNZaA6qkdfXmc3eapYpWYbi88C+IMGVD92v
         bQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678812634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qeeMTBeHxd/XKAWq9zMSxWQt+iGsLohYMBPFE0cHKVw=;
        b=ThBM7SLvRRFXZFMCvzZ2sXoR8+kouJEoEaDQzqUAH8odh/MoJ8RKtKzJlnax9xCx5t
         feDWMqx5IrRiLG9Tt5w006Ae7rarUVmdvW7Dv8qQ7AZdP/3JS7P+OuF35MjzPQsKzbOW
         pi0NfPaRv1XZKQKZGtDBH1wUiXTWfD+jy865sbeQnWwZdXLp0LLXDvgUdo4kIIuJRilL
         /ZP72CrrXJ8h3sWHiJ2TqcaUEkZHO0IhjkNKXyJAZCP7n0UK74D7Na1kVJWA3g70XjBn
         ZcPvuJTg7NU/e4dYjvLuipPHYNTva6Vy6M3OLe9ikZLkEUxr081ohAILrIf+fT4tUpPf
         tF5A==
X-Gm-Message-State: AO0yUKXBDsg0OqCLIPZG66idNtqApPY+OA/M2jOfsvvpQ1mbKqbf6CDr
        20kG5o6bGpxCh3bXvodFLeA4s3DgRLDsRGNmDeGcGNjkvQx1WA==
X-Google-Smtp-Source: AK7set/RFZPS8a3N7ASDY49n0VTB0jswh+PB2qIEhyPfsAQHwJveha5H2uRDx8YRx1h+MqhkRHtiFgb2H3Vv5b1128Q=
X-Received: by 2002:a05:620a:1389:b0:743:9b78:d97e with SMTP id
 k9-20020a05620a138900b007439b78d97emr3365593qki.14.1678812634602; Tue, 14 Mar
 2023 09:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230314120252.48263-1-mmkurbanov@sberdevices.ru>
 <20230314120252.48263-3-mmkurbanov@sberdevices.ru> <3b920b9e-07dc-7bda-4fe1-d15d07e708cc@sberdevices.ru>
 <CAHp75VcWuOEWZn2E8dG=Pb_KuEv06jYt_+nZSL-ceAQRPmgeGw@mail.gmail.com>
In-Reply-To: <CAHp75VcWuOEWZn2E8dG=Pb_KuEv06jYt_+nZSL-ceAQRPmgeGw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Mar 2023 18:49:58 +0200
Message-ID: <CAHp75Vd5goCgubOyaR2FFPi05eCfguh7XqP7MnHd6qP_o7wEmw@mail.gmail.com>
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

On Tue, Mar 14, 2023 at 6:22=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Mar 14, 2023 at 2:12=E2=80=AFPM Martin Kurbanov
> <mmkurbanov@sberdevices.ru> wrote:
> > On 2023-03-01 00:51, Andy Shevchenko wrote:

...

> > >> +static int aw200xx_set_imax(const struct aw200xx *const chip,
> > >> +                           u32 led_imax_microamp)
> > >> +{
> > >> +       struct imax_global {
> > >> +               u32 regval;
> > >> +               u32 microamp;
> > >> +       } imaxs[] =3D {
> > >> +               { 8,  3300 },
> > >> +               { 9,  6700 },
> > >> +               { 0,  10000 },
> > >> +               { 11, 13300 },
> > >> +               { 1,  20000 },
> > >> +               { 13, 26700 },
> > >> +               { 2,  30000 },
> > >> +               { 3,  40000 },
> > >> +               { 15, 53300 },
> > >> +               { 4,  60000 },
> > >> +               { 5,  80000 },
> > >> +               { 6,  120000 },
> > >> +               { 7,  160000 },
> > >
> > > This looks a bit random. Is there any pattern on how value is
> > > connected to the register value?
> >
> > There is no ability to create any pattern here, because this table data
> > doesn=E2=80=99t have any regularity.
>
> There is a clear pattern.
>
> You have two tables, i.e. with multiplier 10000 and second one with
> multiplier 3333 (table in the datasheet seems bad from a math
> perspective). And it's even shown correctly in the datasheet.
>
> With this mix you missed 10.
>
> The coefficient table is 1,2,3,4,6,8,12,16 for both tables.
>
> Hence you need one table and two multipliers.
>
> Please, rewrite accordingly.

JFYI: You may see how I killed a table in one driver due to missing
understanding that there is a pattern.
9df461eca18f ("spi: pxa2xx: replace ugly table by approximation")

--=20
With Best Regards,
Andy Shevchenko
