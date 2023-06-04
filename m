Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F6E72173B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 15:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjFDNKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 09:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjFDNKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 09:10:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570C8B1;
        Sun,  4 Jun 2023 06:10:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E061660ED1;
        Sun,  4 Jun 2023 13:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6C0C433EF;
        Sun,  4 Jun 2023 13:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685884206;
        bh=FJ8N66mXobzCN/iyqAQMQ1QLeAmhvde00YQo6poIE9M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZmVHQBvkr16+tfiA4KCdueEm9uc15luGf6lO1V3GBy63BvXqz/5q09ux+Aerkzb2L
         lnuBGSbz5574wXuDDVjx4Uq9O86aFghTwp8E9rNIL1gcQ4ixKaMQTl9ckokInmHwrx
         19f7C8NyAFC4gAlrQev23fvTYtSuW19Y4N3axg3p479fOlBiQ1b+FnSSEOiWuwxBhm
         CInqOsgM08EIow3UsyWKUXurmcL1XwMe0Q4HD3hc5z5euSzWlymf5OfkbahiKvtYYm
         mQVGnWVHgq6uU52NkbksYzcIAkvhMJ8QnT7096LRAIUGLEaMH+S1FgwT7IM8SxykiS
         IBy7pS+AP79hw==
Date:   Sun, 4 Jun 2023 14:10:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Astrid Rost <astridr@axis.com>, Astrid Rost <astrid.rost@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com,
        Uwe =?UTF-8?B?S2xlaW5lLUs=?= =?UTF-8?B?w7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: Re: [PATCH v4 4/7] iio: light: vcnl4000: add illuminance irq
 vcnl4040/4200
Message-ID: <20230604141002.0b055c10@jic23-huawei>
In-Reply-To: <CAHp75VdZAGhrXgYf5EOE6MQ4DiseaxOqkjUs+X9jROB1aonD_g@mail.gmail.com>
References: <20230522142621.1680563-1-astrid.rost@axis.com>
        <20230522142621.1680563-5-astrid.rost@axis.com>
        <ZHPZlA5LM5h4xmp3@surfacebook>
        <ca146ce1-d3d3-e5eb-ac44-3afaec8ca6cc@axis.com>
        <CAHp75VdZAGhrXgYf5EOE6MQ4DiseaxOqkjUs+X9jROB1aonD_g@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2023 12:02:16 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, May 29, 2023 at 10:41=E2=80=AFAM Astrid Rost <astridr@axis.com> w=
rote:
> > Thanks for reviewing.
> > I can change this. But this is how it gets formatted by .clang-format. =
=20
>=20
> I would suggest to report the bug (in case it's not configurable) or
> configure to avoid such a misindentation.

I assume it's trading off line length against aligning with opening bracket=
s.
Maybe made the wrong decision, but it is not totally unreasonable to my eye=
s.
I don't care either way though, so go with whatever you have for next versi=
on!

Jonathan

>=20
> > On 5/29/23 00:45, andy.shevchenko@gmail.com wrote: =20
> > > Mon, May 22, 2023 at 04:26:18PM +0200, Astrid Rost kirjoitti: =20
> > >> Add support to configure ambient light sensor interrupts and thresho=
ld
> > >> limits for vcnl4040 and vcnl4200. If an interrupt is detected an eve=
nt
> > >> will be pushed to the event interface. =20
> > >
> > > ...
> > > =20
> > >> +            case IIO_EV_DIR_RISING:
> > >> +                    ret =3D i2c_smbus_write_word_data(
> > >> +                            data->client, VCNL4040_ALS_THDH_LM, val=
); =20
> > >
> > > Strange indentation.
> > > =20
> > >> +                    break;
> > >> +            case IIO_EV_DIR_FALLING:
> > >> +                    ret =3D i2c_smbus_write_word_data(
> > >> +                            data->client, VCNL4040_ALS_THDL_LM, val=
); =20
> > >
> > > Same.
> > > =20
> > >> +                    break; =20
> > >
> > > ...
> > > =20
> > >> +    case IIO_PROXIMITY:
> > >> +            switch (dir) {
> > >> +            case IIO_EV_DIR_RISING:
> > >> +                    ret =3D i2c_smbus_write_word_data(
> > >> +                            data->client, VCNL4040_PS_THDH_LM, val)=
; =20
> > >
> > > Same.
> > > =20
> > >> +                    break;
> > >> +            case IIO_EV_DIR_FALLING:
> > >> +                    ret =3D i2c_smbus_write_word_data(
> > >> +                            data->client, VCNL4040_PS_THDL_LM, val)=
; =20
> > >
> > > Same. =20
>=20

