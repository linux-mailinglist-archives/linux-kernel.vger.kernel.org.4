Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E45173D059
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 13:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjFYLTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 07:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjFYLTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 07:19:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2C7189;
        Sun, 25 Jun 2023 04:19:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC68E6020F;
        Sun, 25 Jun 2023 11:19:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2E7C433C0;
        Sun, 25 Jun 2023 11:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687691956;
        bh=hEp1OjdaVN0PtEjp+ys81l46h98FvHb8YXuLZMvAFec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B1U/XSSgqdZh3b6hmHBCSzG7eQvXjXQZWn2sKoy913drlrelOsKYlf9/H/SmR/SK9
         VLt/cvKz7KKeZyPj+H5eSXaPjmRqgHawPCZZArVj30ZhkjrL5JZEKDQgwjrd7oVvky
         TIsVXzehcXOMA90m5+G9dAbrJjQrGyJuwIRJMER3N/KJbuPxe6kvohd+rAY0GRuGYV
         PeJuT8Ppf/Ja8WiCpW+1mgVIXEjz5IN52ty1WPUFdwL5BfBPU5Vm6MdpU41MUBbkHz
         4rfS48C9cqXogiiFlzqZ8tKXe0SAeiD0vClfU+T/KipzEEcFejZA5IkE5NNLd+IzDu
         mvnbMoJiX75aQ==
Date:   Sun, 25 Jun 2023 12:19:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     George Stark <stark.georgy@gmail.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        George Stark <gnstark@sberdevices.ru>, lars@metafoo.de,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, andriy.shevchenko@linux.intel.com,
        nuno.sa@analog.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, kernel@sberdevices.ru
Subject: Re: [PATCH v2 6/6] meson saradc: support reading from channel7 mux
 inputs
Message-ID: <20230625121916.32578914@jic23-huawei>
In-Reply-To: <a0d74f3f-4208-d7e3-7eed-481a06b13308@gmail.com>
References: <20230623022334.791026-1-gnstark@sberdevices.ru>
        <20230623022334.791026-7-gnstark@sberdevices.ru>
        <CAFBinCBv993Xv_wk9fE-U0Tw2mzTB1z22Tj6x8Uy1rRw_dztng@mail.gmail.com>
        <a0d74f3f-4208-d7e3-7eed-481a06b13308@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jun 2023 18:59:31 +0300
George Stark <stark.georgy@gmail.com> wrote:

> Hello Martin
>=20
> Thanks for review
>=20
> On 6/23/23 09:16, Martin Blumenstingl wrote:
> > Hi George,
> >
> > On Fri, Jun 23, 2023 at 4:23=E2=80=AFAM George Stark <gnstark@sberdevic=
es.ru> wrote:
> > [...] =20
> >> Meson saradc channel 7 is connected to muxer that can switch channel =
=20
> > I think that this should read: ... is connected to a mux that ...
> >
> > [...] =20
> >>   static const struct iio_chan_spec meson_sar_adc_iio_channels[] =3D {
> >> @@ -245,6 +280,11 @@ static const struct iio_chan_spec meson_sar_adc_i=
io_channels[] =3D {
> >>          MESON_SAR_ADC_CHAN(INDEX_CHAN_6),
> >>          MESON_SAR_ADC_CHAN(INDEX_CHAN_7),
> >>          IIO_CHAN_SOFT_TIMESTAMP(INDEX_CHAN_SOFT_TIMESTAMP),
> >> +       MESON_SAR_ADC_MUX(INDEX_MUX_0_VSS, 0),
> >> +       MESON_SAR_ADC_MUX(INDEX_MUX_1_VDD_DIV4, 1),
> >> +       MESON_SAR_ADC_MUX(INDEX_MUX_2_VDD_DIV2, 2),
> >> +       MESON_SAR_ADC_MUX(INDEX_MUX_3_VDD_MUL3_DIV4, 3),
> >> +       MESON_SAR_ADC_MUX(INDEX_MUX_4_VDD, 4),
> >>          MESON_SAR_ADC_TEMP_CHAN(), /* must be the last item */ =20
> > I haven't had the chance to run these patches yet but: I think they
> > are breaking the temperature sensor readings on Meson8/8b/8m2 boards.
> > See arch/arm/boot/dts/meson.dtsi where the temperature channel is
> > being referenced:
> >    io-channels =3D <&saradc 8>
> >
> > With this series (this patch and I think also patch 3/6 "meson saradc:
> > unite iio channel array definitions") the numbering of the temperature
> > sensor channel changes.
> >
> > To make things worse: in theory we can use meson_saradc to read the
> > SoC temperature sensor on GXBB, GXL and GXM boards (possibly on AXG as
> > well but I can't recall from the top of my head) instead of going
> > through SCPI.
> > I have experimented with this in the past but never got it to work.
> > Doing so in the future could lead to another channel index change,
> > depending on how we decide to go forward now.
> >
> > There's two that I can think of:
> > - update meson.dtsi to use the new channel numbering (I don't expect
> > many 32-bit SoC users out there using new kernel + old .dtbs, but it's
> > impossible to say for sure)
> > - or keep the driver backwards compatible (that involves re-adding the
> > channel tables)

Agreed. Put the table back.  It might make the code slightly more complex
but we need to avoid shifting channel numbers around where possible.

Jonathan


> >
> > What do you think? =20
> Actually we'd have to make 2 patches to meson.dtsi, the first change=20
> 8->9, than 9 ->14.
> And if that index exposed externally (ABI like) I'd not change it=20
> without good reason at all.
> So I think to return to double definition of meson_sar_adc_iio_channels=20
> and keep the driver backwards compatible.
>=20
> I've just realized another moment with channels defined after=20
> MESON_SAR_ADC_TEMP_CHAN in channel array.
> In dts by default channels are referenced by channel array index not=20
> even by channel number.
> So channel e.g MUX_0_VSS will have the same number (due to enum patch)=20
> but different index on meson8 and gxbb.
> As alternative we can implement fwnode_xlate method in meson adc driver=20
> and use channel numbers in dts
> (probably not in the current patchset).
>=20
> Best regards,
> George
>=20
> >
> > Best regards,
> > Martin
> >
> > _______________________________________________
> > linux-amlogic mailing list
> > linux-amlogic@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-amlogic =20
>=20
>=20

