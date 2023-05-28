Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6D5713BCF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 20:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjE1SpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 14:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE1SpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 14:45:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE8DB1;
        Sun, 28 May 2023 11:45:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB0126133B;
        Sun, 28 May 2023 18:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF95C433EF;
        Sun, 28 May 2023 18:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685299521;
        bh=pyZ98nlMappaPtL49VU7/CIkHy8xhwh4N50ViQx94vE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rILx0T4s5kA9ldEKvbeNmuLV+Q9nnOhLuYDVfP6rHWle1sFmBHZC74DjpUFb5HEwF
         XRfN6RshG6ExHvIv+rXDM17jpNsLrqskPO1CZWvWZzLz8uHNaODU1xV4H2LKBCO/Ej
         UEsFF792dW7EFSX32jsqz2QhNx3zH9OJerquW0yqaEpYAAknS6a7/C96/YUhrREngf
         IsIsq2Et8DpHnQkk8yjREJfjTQEra8xMDiPgWC+JOGOjGJXa4oerFoCgsGo1gIudew
         7l31YiOUmrcwV7qUItDId7TH4ziACiRbglRhaBLnQcEPfB9fOJQPQufmZSMC1dKfOa
         U0z4qnsMZvlwQ==
Date:   Sun, 28 May 2023 20:01:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Uwe =?UTF-8?B?S2xlaW5l?= =?UTF-8?B?LUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: Re: [PATCH v4 0/7] iio: light: vcnl4000: Add features for
 vncl4040/4200
Message-ID: <20230528200140.7ccaf6e0@jic23-huawei>
In-Reply-To: <20230522142621.1680563-1-astrid.rost@axis.com>
References: <20230522142621.1680563-1-astrid.rost@axis.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023 16:26:14 +0200
Astrid Rost <astrid.rost@axis.com> wrote:

> Add a more complete support for vncl4040 and vcnl4200, which allows to
> change the distance of proximity detection and interrupt support for the
> illuminance sensor.

Something odd going on (superficially looks like a rebase mistake in patch =
6)

 CHECK   drivers/iio/amplifiers/ad8366.c                                   =
                                                                     =20
In file included from ./include/linux/bits.h:6,                            =
                                                                      =20
                 from ./include/linux/bitops.h:6,                          =
                                                                      =20
                 from ./include/linux/kernel.h:22,                         =
                                                                      =20
                 from ./arch/x86/include/asm/percpu.h:27,                  =
                                                                      =20
                 from ./arch/x86/include/asm/current.h:10,                 =
                                                                      =20
                 from ./arch/x86/include/asm/processor.h:17,               =
                                                                      =20
                 from ./arch/x86/include/asm/timex.h:5,                    =
                                                                      =20
                 from ./include/linux/timex.h:67,                          =
                                                                      =20
                 from ./include/linux/time32.h:13,                         =
                                                                      =20
                 from ./include/linux/time.h:60,                           =
                                                                      =20
                 from ./include/linux/stat.h:19,                   =20
                 from ./include/linux/module.h:13,            =20
                 from drivers/iio/light/vcnl4000.c:21:            =20
./include/vdso/bits.h:7:33: warning: initialized field overwritten [-Woverr=
ide-init]
    7 | #define BIT(nr)                 (UL(1) << (nr))                    =
                                                                      =20
      |                                 ^               =20
drivers/iio/light/vcnl4000.c:1824:49: note: in expansion of macro =E2=80=98=
BIT=E2=80=99                                                               =
           =20
 1824 |                 .info_mask_separate_available =3D BIT(IIO_CHAN_INFO=
_INT_TIME) |
      |                                                 ^~~
./include/vdso/bits.h:7:33: note: (near initialization for =E2=80=98vcnl404=
0_channels[1].info_mask_separate_available=E2=80=99)
    7 | #define BIT(nr)                 (UL(1) << (nr))       =20
      |                                 ^        =20
drivers/iio/light/vcnl4000.c:1824:49: note: in expansion of macro =E2=80=98=
BIT=E2=80=99
 1824 |                 .info_mask_separate_available =3D BIT(IIO_CHAN_INFO=
_INT_TIME) |         =20
      |                                                 ^~~         =20


>=20
> Proximity functionality:
>   - Interrupt support (new on vcnl4200).
>=20
> Proximity reduce the amount of interrupts:
>   - Adaptable integration time (new on vcnl4200) - the sampling rate
>     changes according to this value.
>   - Period - interrupt is asserted if the value is above or
>     below a certain threshold.
>=20
> Proximity change the activity distance:
>   - Oversampling ratio - Amount of LED pulses per measured raw value.
>   - Calibration bias - LED current calibration of the sensor.
>=20
> Illuminance functionality:
>   - Interrupt support.
>=20
> Illuminance reduce the amount of interrupts:
>   - Adaptable integration time - the sampling rate and scale changes
>     according to this value.
>   - Period =E2=80=93 interrupt is asserted if the value is above or
>     below a certain threshold.
>=20
> changes v2:
> - [PATCH v2 3/7] Fixed calculation of al_scale.
>   Fix the value of vcnl4040 according to the data-sheet.
>   Use div_u64 for the division.
> scription for the branch
>=20
> changes v3:
> - [PATCH v3 1-3/7] Add differences between the chips as variables in
>   chip-spec.
> - [PATCH v3 4/7] Changed commit message.
> - [PATCH v3 5/7] Use period instead of debounce time. This causes some
>   calculations as the period is a time and the chip allows to set a certa=
in
>   amount of measurements above/below the threshold, before throwing an
>   interrupt.
> - [PATCH v3 6/7] Changed commit message.
>=20
> changes v4:
> - [PATCH v3 1-3/7] Fix setting correct als_it for vcnl4040.
> - [PATCH v3 5/7] Use MICRO macro.
>   Fix values greater than 1 s for the proximity period.
>=20
> Astrid Rost (7):
>   [PATCH v4 1/7] iio: light: vcnl4000: Add proximity irq for vcnl4200
>   [PATCH v4 2/7] iio: light: vcnl4000: Add proximity ps_it for vcnl4200
>   [PATCH v4 3/7] iio: light: vcnl4000: Add als_it for vcnl4040/4200
>   [PATCH v4 4/7] iio: light: vcnl4000: add illuminance irq vcnl4040/4200
>   [PATCH v4 5/7] iio: light: vcnl4000: Add period for vcnl4040/4200
>   [PATCH v4 6/7] iio: light: vcnl4000: Add oversampling_ratio for 4040/42=
00
>   [PATCH v4 7/7] iio: light: vcnl4000: Add calibration bias for 4040/4200
>=20
>  drivers/iio/light/vcnl4000.c | 721 +++++++++++++++++++++++++++++++----
>  1 file changed, 653 insertions(+), 68 deletions(-)
>=20

