Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00D0706ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjEQQxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEQQxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:53:08 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE901A255;
        Wed, 17 May 2023 09:52:43 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-61b19406102so1327656d6.1;
        Wed, 17 May 2023 09:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684342362; x=1686934362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pvyuk45qAwIZHtrdAvIYk8lq6oEJbOWM7TWmUfxEmXc=;
        b=diNUrRiIcfwrHfCYK8S3a5dVoAnso/EVGvDEvCsURN9COJxCKfROWRtDZ1J3o2A5Tc
         3n+TPqwKRH541c3ZdXz0vCsjAr7c52VCsHAMsmeMO3iI5On37wN2JqiLu2lJZtlI3bw2
         pPjYyv91nCohYATMb0dbJEdbwAEZmGD42aDWAUIKRhwQiiEyFLXlcA1tH+42UWt8Srlr
         3KSmJepx8fAyyibOdJEgQ3Qf92ql8Yg/+fZxVSa2QDemYChfoJDgWv7n2IvypaCuE7Np
         trrkHqPtOG77pgt9pSarG81U80WzB5xjG+6+s8tuLTNSNQ7vwcRSc3Y8lP+HcemDg6Yq
         Ta7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684342362; x=1686934362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pvyuk45qAwIZHtrdAvIYk8lq6oEJbOWM7TWmUfxEmXc=;
        b=JpRey+pq9QKA743v++Sqn7ybc5n9dsG8kdkeSsColrTSzDr2WYJF18Pyg1Gy94bQDK
         pHNl9lZF8qR/uVDoRhPP55AevUmMihUmCm3xg5nSb1eKSM25XOodMWNKdWwisx2Vp32c
         mAH3rT4Sqq/WDHvqrAreksC1s9lJZSC/gA9puucXVAaprqFOgcx4LmUxw/gisLywIKqN
         34g5S8K6Yjioi1UmB+WyJoTIR9FFejGRpNdlY6DthRLTj2QCa98QN7eXb4v4BVSLL5Xq
         1UMhkvo/wrIY5TinHlE/YcWnGq2n/TFGl2+INH5gibiwMLdh77slvrjikOLeOG6x8uqb
         vAGA==
X-Gm-Message-State: AC+VfDyr5/dxiEYqPBUJrwNNSdnzD2mwAp0CSn5EiQxQ1bE5guauCWAe
        P9e9W8riz8BtQ1bqAxWWrOGL1gnhGllbJ62e27TNfL3TY+nXhA==
X-Google-Smtp-Source: ACHHUZ6GfNaGFm2xtZWG1blndv3Mz+ujglmZyG7jXWpyaCYi94a28PlelYGaw4Sf1EYfzFhCXHUMrVih5wefdxhfzI8=
X-Received: by 2002:a05:6214:1944:b0:5ef:4f83:f454 with SMTP id
 q4-20020a056214194400b005ef4f83f454mr112213qvk.24.1684342362617; Wed, 17 May
 2023 09:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230512141755.1712358-1-eblanc@baylibre.com> <20230512141755.1712358-2-eblanc@baylibre.com>
 <ZF514wvUt_xrU1gG@surfacebook> <CSOPFJOVLSS1.1XKI60F9TLBMN@burritosblues>
In-Reply-To: <CSOPFJOVLSS1.1XKI60F9TLBMN@burritosblues>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 17 May 2023 19:52:06 +0300
Message-ID: <CAHp75Vfg+yAhJ58qt76GHqxWHD48hF-6ZnT=xEUh+1rzr7UvVg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] rtc: tps6594: Add driver for TPS6594 RTC
To:     Esteban Blanc <eblanc@baylibre.com>
Cc:     linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com, sterzik@ti.com,
        u-kumar1@ti.com
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

On Wed, May 17, 2023 at 7:47=E2=80=AFPM Esteban Blanc <eblanc@baylibre.com>=
 wrote:
> On Fri May 12, 2023 at 7:22 PM CEST,  wrote:
> > Fri, May 12, 2023 at 04:17:53PM +0200, Esteban Blanc kirjoitti:

...

> > > +/* Multiplier for ppb conversions */
> > > +#define PPB_MULT (1000000000LL)
> >
> > We have something in units.h. Can you use generic macro?
>
> I found GIGA, NANO and NANOHZ_PER_HZ that have the same value in
> units.h. However I'm not sure any of them have the correct meaning in
> this situation.

MULT[IPLIER] has no units AFAIU, so SI macro can be used, no? NANO or
GIGA depends on what the actual sign of the exponent of the multiplier
is. Write it on paper and check the exponent in the equation(s) and
hence decide which one to use.

...

> > > +   if (tmp < 0)
> > > +           tmp -=3D TICKS_PER_HOUR / 2LL;
> > > +   else
> > > +           tmp +=3D TICKS_PER_HOUR / 2LL;
> >
> > Is it guaranteed to have no overflow here?
>
> We know from `tps6594_rtc_set_offset` that the loaded value can't be
> more than 277774 (register default value is 0), So `tmp` can't exceed
> 277774000000000 which is lower than 2^63-1. No overflow here.
>
> TICK_PER_HOUR / 2LL =3D 117964800, so at the end of this computation,
> `tmp` can have a maximum value of 277774117964800 which is still
> inferior to 2^63-1.

Please add a respective comment.
--=20
With Best Regards,
Andy Shevchenko
