Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F7C6B7734
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjCMMKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjCMMKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:10:44 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5753432E7C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 05:10:41 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l12so2805430wrm.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 05:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678709440;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GQdHiuhV8qcwtZCrgLpmIG7i8TQyBjFWs+jLg6cK9I=;
        b=YjN+/sfQrVtEHFnNa7CD1R+ohcYIxX4rAYXHTfbDoDlUUsxElUHtD7b8qdRIgYvvjF
         TpydeuG8YcAxvysqENM+ZLs2VovI4itwmvOdGeazAgB67lp4/CZ0sJ1vmnRaING9xiQd
         vbxttPNvNn9ilAgJcDV8ZGZoHnrhRnrSqg3s1I1BKEdUhG0dEN/64r5DPoj0XBZIDBcJ
         16eCrTx/n+hOUky+fS5BuyuI3EZMTeyzvAUgUPIBQXYL1IN81EeV7+ncTC8lr1U1pIA+
         qJa2sQ6BUoLysZVtG638AiykkV1hkJfKEQNQj9qQom0a9skUvs5Wn7H2MJ7Wunl6XXpA
         oJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678709440;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3GQdHiuhV8qcwtZCrgLpmIG7i8TQyBjFWs+jLg6cK9I=;
        b=Yi/HpYy+TSgtZoN9eBBO+1q4Vf1hU/G3cBe4mJrq1BcwRHbqLkLSJfG3LkpY1M2brN
         qzfI8uBud5AUtsHKDDH9asXBEC9QPxu7ERui9awjdKRxpUvq48KzyX8vgGVs9CFEsEqo
         BvEAfsZLH1zB5dYsTxzs3ZfO3uCt9FQNJTpXc8B2hdWs/fq7gAeeTVO/8jv/UTDO0UxW
         Mr7Lwfgv+laDOcFRaaJGDA6rWBwqQovWhobvk4EbQuCsxyGOpZZUayAF9MxKXr+6CXKI
         GaL2Em2nuow3bGVcKkcMSmJcWBNvrlrI9oHt1jqItkVH8yuFxbj4TGQ1VY5sisWniCEv
         Kx3g==
X-Gm-Message-State: AO0yUKU7gF29dHYJKLWX59Hb5fd/QQcPdAb8mN+Xiqyz1qjHWCSy31p1
        yPzJQHmHz5TTVDoh0NRrMw95iA==
X-Google-Smtp-Source: AK7set9GdQPxf5ICUKtYJ/RP6unuyLgdOzr7MbGdghf6aL//AXX4x/y08dJdSndDoJN7h27+hzwYeA==
X-Received: by 2002:adf:ef90:0:b0:2c5:a38f:ca31 with SMTP id d16-20020adfef90000000b002c5a38fca31mr8003174wro.7.1678709439797;
        Mon, 13 Mar 2023 05:10:39 -0700 (PDT)
Received: from localhost (91-170-53-155.subs.proxad.net. [91.170.53.155])
        by smtp.gmail.com with ESMTPSA id e29-20020a5d595d000000b002c5706f7c6dsm7714376wri.94.2023.03.13.05.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 05:10:39 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 13 Mar 2023 13:10:37 +0100
Message-Id: <CR58TXDRGAUA.3CSML8HXRI97S@burritosblues>
Cc:     <linus.walleij@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <a.zummo@towertech.it>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>, <jpanis@baylibre.com>,
        <jneanne@baylibre.com>
Subject: Re: [PATCH INTERNAL v1 1/3] rtc: tps6594: add driver for TPS6594
 PMIC RTC
From:   "Esteban Blanc" <eblanc@baylibre.com>
To:     "Alexandre Belloni" <alexandre.belloni@bootlin.com>
X-Mailer: aerc 0.14.0
References: <20230224133129.887203-1-eblanc@baylibre.com>
 <20230224133129.887203-2-eblanc@baylibre.com> <ZAcbJxrNtWTTTSjR@mail.local>
 <CR556BV2M4I4.2L3LLJ8V1I352@burritosblues>
 <20230313110158f5c27b63@mail.local>
In-Reply-To: <20230313110158f5c27b63@mail.local>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Mar 13, 2023 at 12:01 PM CET, Alexandre Belloni wrote:
> On 13/03/2023 10:18:45+0100, Esteban Blanc wrote:
> > On Tue Mar 7, 2023 at 12:08 PM CET, Alexandre Belloni wrote:
> > > On 24/02/2023 14:31:27+0100, Esteban Blanc wrote:
> > > > +/*
> > > > + * Gets current tps6594 RTC time and date parameters.
> > > > + *
> > > > + * The RTC's time/alarm representation is not what gmtime(3) requi=
res
> > > > + * Linux to use:
> > > > + *
> > > > + *  - Months are 1..12 vs Linux 0-11
> > > > + *  - Years are 0..99 vs Linux 1900..N (we assume 21st century)
> > > > + */
> > >
> > > I don't find this comment to be particularly useful.
> >=20
> > Ok. I propose that I add 2 constants for the -1 and +100 in the month a=
nd year
> > calculation. This way, without the comment the computation would be a
> > bit more self explanatory.
> > What do you think?
>
> I don't think this is necessary, keep -1 for the month and +100 for the
> year, those are very common operations in the subsystem and don't really
> need any explanation

Ok. I will just remove the comment then.

> > > > +static int tps6594_rtc_probe(struct platform_device *pdev)
> > > > +{
> > > > +   struct tps6594 *tps6594;
> > > > +   struct tps6594_rtc *tps_rtc;
> > > > +   int irq;
> > > > +   int ret;
> > > > +
> > > > +   tps6594 =3D dev_get_drvdata(pdev->dev.parent);
> > > > +
> > > > +   tps_rtc =3D devm_kzalloc(&pdev->dev, sizeof(struct tps6594_rtc)=
,
> > > > +                          GFP_KERNEL);
> > > > +   if (!tps_rtc)
> > > > +           return -ENOMEM;
> > > > +
> > > > +   tps_rtc->rtc =3D devm_rtc_allocate_device(&pdev->dev);
> > > > +   if (IS_ERR(tps_rtc->rtc))
> > > > +           return PTR_ERR(tps_rtc->rtc);
> > > > +
> > > > +   /* Enable crystal oscillator */
> > > > +   ret =3D regmap_set_bits(tps6594->regmap, TPS6594_REG_RTC_CTRL_2=
,
> > > > +                         TPS6594_BIT_XTAL_EN);
> > > > +   if (ret < 0)
> > > > +           return ret;
> > > > +
> > > > +   /* Start rtc */
> > > > +   ret =3D regmap_set_bits(tps6594->regmap, TPS6594_REG_RTC_CTRL_1=
,
> > > > +                         TPS6594_BIT_STOP_RTC);
> > > > +   if (ret < 0)
> > > > +           return ret;
> > >
> > > Do that (XTAL_EN and clearing STOP) only once the time is known to be
> > > set to a correct value so read_time doesn't have a chance to return a
> > > bogus value.
> > >
> >=20
> > (...)
> >=20
> > I understand your point, however I'm not sure of the canonical way to d=
o
> > this. Simply calling `tps6594_rtc_set_time` is enough?
>
> Yeah, let userspace set the time and start the rtc at that point.

The problem with that is we might have some RTCs that will just not be
usable. We have boards with multiple TP6594 PMICs where only one of them
has a crystal oscillator. The way to detect this is to start the RTC
then checked if the STOP_RTC bit is still 0. By doing this in the probe,
I'm able to not register an RTC device that doesn't work.

If I just start the RTC on the first call to `tps6594_rtc_set_time`, it
will work for the RTC with the crystal and fails for all the others=20

I can stop the RTC at the end of the probe, after the check to rule out
unusable devices. If I add the check you proposed in
`tps6594_rtc_read_time` it will fail until a successful call to
`tps6594_rtc_set_time`. Would that be a suitable solution?

Best regards,
--=20
Esteban Blanc
BayLibre

