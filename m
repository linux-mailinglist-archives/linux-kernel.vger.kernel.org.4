Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FD6706E7B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjEQQry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjEQQrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:47:52 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA1840F7
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:47:50 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f41dceb9c9so7717155e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684342069; x=1686934069;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xemdrTLdrPZASEl7ie1XM2zNjPHq2033DBfX2S/R9zs=;
        b=jleW3joMYjt0O0WZ2aUBXAV6frph5/PSVJjZIDZnGIZmbS6JadCF3TNjMEouenlDXo
         oQrA8P+VyRJJexwgyveVymXBplBt8rAwEV+8Mci7ZdoLKnul2J4n/c7D162EF4eqJn2F
         8GUGI3CKx+zqvqHLPCTQkAwy0aJSJirq+1A9Gc4coGwqW5LOzpBKYluAjG+w8MIjVXyF
         S5PNsSePisWSytCGZQOg8N13Q+gD/efBtPglnqULhv66GfZr+NjWyJVJleN0l85Guiqc
         PwGEFuO77h6szGyEnJ5g9OIyWovyuw6cAL/EHtfb/QsldbSy1HepUWJiwpyifd7ScFKs
         dg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684342069; x=1686934069;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xemdrTLdrPZASEl7ie1XM2zNjPHq2033DBfX2S/R9zs=;
        b=WQ1qBlA8Uhb/oAK07xIxOjVSahlpQGmws/+FyaN8EppubKL5omJJ4GJoiqIoAM3sQ8
         CCceYvmMJFRUjsvxQtk24epzeQ4aVWVFFmL0A5JUnwycFY7tcmoe1K0tZDFRFx/8OxiR
         pjryT6SxVBoC2UkIS7uSM1V5RoYslVvuDeSVFnBQ9I6vqiVYg+61VaAY+WaUxs1VlSmw
         VA6aF7jzg9DPGQ8jxagEu1k/fFWaO+d0lsgg4qOyaaWCkAuhQSJAMTbH6p3200yWiSd9
         6V0ZFFLQLI79zp5SeuGeLDyPzPQ0G9W/+yyhlQOS1afKuDzSmyIvntx0ML8Y6gichsTo
         4uZQ==
X-Gm-Message-State: AC+VfDw3v7vyFmmSO9Xv/gxdffppRkNlq+8Puojagwts86j1/rQAFiQm
        QSW2kk3PUC43r834DcXJfOQjCg==
X-Google-Smtp-Source: ACHHUZ7JJraEr8hdS86PhPKsZ4rWwU7b1s/JUe123j1z6YVL7y4EnH1askXJF4Y500r0AAocajgoOA==
X-Received: by 2002:a05:600c:1149:b0:3f5:e7f:5327 with SMTP id z9-20020a05600c114900b003f50e7f5327mr6771248wmz.10.1684342069109;
        Wed, 17 May 2023 09:47:49 -0700 (PDT)
Received: from localhost ([2a01:e0a:28d:66d0:5b2e:1428:59f1:44a4])
        by smtp.gmail.com with ESMTPSA id f6-20020a1c6a06000000b003f427cba193sm2682309wmc.41.2023.05.17.09.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 09:47:48 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 17 May 2023 18:47:47 +0200
Message-Id: <CSOPFJOVLSS1.1XKI60F9TLBMN@burritosblues>
From:   "Esteban Blanc" <eblanc@baylibre.com>
To:     <andy.shevchenko@gmail.com>
Cc:     <linus.walleij@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <jpanis@baylibre.com>, <jneanne@baylibre.com>,
        <aseketeli@baylibre.com>, <sterzik@ti.com>, <u-kumar1@ti.com>
Subject: Re: [PATCH v4 1/3] rtc: tps6594: Add driver for TPS6594 RTC
X-Mailer: aerc 0.14.0
References: <20230512141755.1712358-1-eblanc@baylibre.com>
 <20230512141755.1712358-2-eblanc@baylibre.com>
 <ZF514wvUt_xrU1gG@surfacebook>
In-Reply-To: <ZF514wvUt_xrU1gG@surfacebook>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri May 12, 2023 at 7:22 PM CEST,  wrote:
> Fri, May 12, 2023 at 04:17:53PM +0200, Esteban Blanc kirjoitti:
> > +/* Multiplier for ppb conversions */
> > +#define PPB_MULT (1000000000LL)
>
> We have something in units.h. Can you use generic macro?

I found GIGA, NANO and NANOHZ_PER_HZ that have the same value in
units.h. However I'm not sure any of them have the correct meaning in
this situation.

> > +	/*
> > +	 * Set GET_TIME to 0. This way, next time we set GET_TIME to 1 we are=
 sure to store an
> > +	 * up-to-date timestamp
> > +	 */
>
> Please, check all your multi-line comments for proper punctuation.

Ok. I will do my best.

> > +	/* Check if RTC is running. */
>
> Please, keep a single style for the one-line comments (with or without pe=
riod
> at the end).

Sure.

> > +	return ret;
>
> Why not return 0 explicitly? Or do you return positive value?

I should return 0 here, you are right.

> > +	comp_data[0] =3D (u16)value & 0xFF;
> > +	comp_data[1] =3D ((u16)value >> 8) & 0xFF;
>
> Use proper bitwise type, i.e. __le16.

I was not aware of theses kind of types. Thanks!

> > +	/* Convert from RTC calibration register format to ppb format */
> > +	tmp =3D calibration * (s64)PPB_MULT;
>
> Is casting really needed?

No it's not. Thanks!

> > +	if (tmp < 0)
> > +		tmp -=3D TICKS_PER_HOUR / 2LL;
> > +	else
> > +		tmp +=3D TICKS_PER_HOUR / 2LL;
>
> Is it guaranteed to have no overflow here?

We know from `tps6594_rtc_set_offset` that the loaded value can't be
more than 277774 (register default value is 0), So `tmp` can't exceed
277774000000000 which is lower than 2^63-1. No overflow here.

TICK_PER_HOUR / 2LL =3D 117964800, so at the end of this computation,
`tmp` can have a maximum value of 277774117964800 which is still
inferior to 2^63-1.

> > +	tmp =3D div_s64(tmp, TICKS_PER_HOUR);
> > +
> > +	/*
> > +	 * Offset value operates in negative way, so swap sign.
> > +	 * See 8.3.10.5, (32768 - COMP_REG)
> > +	 */
> > +	*offset =3D (long)-tmp;
> > +
> > +	return ret;
>
> ret?!

That's a mistake. Thanks!

> > +	/* RTC not running */
> > +	if (ret =3D=3D 0) {
> > +		/* Start rtc */
>
> RTC for the sake of consistency.
>
> But I think one of the comment is redundant.

I will remove the second one

> > +		mdelay(100);
>
> Such long delays have to be explicitly elaborated (in the comment on top)=
.

This should just not be there.


Best regards,

--=20
Esteban Blanc
BayLibre
