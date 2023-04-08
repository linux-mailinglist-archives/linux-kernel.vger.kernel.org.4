Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BE56DBA6D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 13:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjDHLbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 07:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjDHLbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 07:31:44 -0400
Received: from pio-pvt-msa1.bahnhof.se (pio-pvt-msa1.bahnhof.se [79.136.2.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F3D198B;
        Sat,  8 Apr 2023 04:31:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id BCB013F5C5;
        Sat,  8 Apr 2023 13:31:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Authentication-Results: pio-pvt-msa1.bahnhof.se (amavisd-new);
        dkim=pass (2048-bit key) header.d=dalakolonin.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2MrnrnoUKJcY; Sat,  8 Apr 2023 13:31:40 +0200 (CEST)
Received: by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 994033F586;
        Sat,  8 Apr 2023 13:31:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 239EE95EF7;
        Sat,  8 Apr 2023 11:31:37 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id PfJ5tS0tqNww; Sat,  8 Apr 2023 11:31:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 7CF3A95EF4;
        Sat,  8 Apr 2023 11:31:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.dalakolonin.se 7CF3A95EF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dalakolonin.se;
        s=D374B428-D0A7-11ED-A657-75977B426508; t=1680953495;
        bh=nzinbPsxZsjmmQZmRkWjiOVMxkYgWhKZIWK6cHxPeCw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=jOoa3qlxyMIKWLHZqzxNX1RCBQtkP7E5ikrfhlaiFJPoYWUK/1iZWngzOvrKYTa5R
         gwOSsgA9TDQJ+zakZsnQFOrfFesQwyief7+bcLmu2yXkHEH2cE0Wm4AyP7tQxCdTJ7
         azb5IEAc3cIKuW9d4Tt6dH9W2hN7iTf3pJhg11NatAH/HLPvqefoJLCM1i3SEWGVjl
         vhV7iEIsjtTsqFZzzQaLVHA8gIkNlqNC9UTtTHzNekZsCc981kxH4cV9Qt9jqVsJ7T
         PVBExrGwFFr0BR/f0GWh1SbnUktYkWZQdzfk/IfoW2aDE1IrA0OYvrf52noace9zHv
         3Ooy2ywz2RnfA==
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RqTDVPugRcYL; Sat,  8 Apr 2023 11:31:35 +0000 (UTC)
Received: from dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id C527995EEF;
        Sat,  8 Apr 2023 11:31:34 +0000 (UTC)
Date:   Sat, 8 Apr 2023 13:31:33 +0200
From:   Patrik =?iso-8859-1?Q?Dahlstr=F6m?= <risca@dalakolonin.se>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        pgoudagunta@nvidia.com, hns@goldelico.com, lars@metafoo.de,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v3 6/7] iio: adc: palmas: add support for iio threshold
 events
Message-ID: <20230408113133.GB141200@dalakolonin.se>
References: <20230405212233.4167986-1-risca@dalakolonin.se>
 <20230405212233.4167986-7-risca@dalakolonin.se>
 <20230407181947.667614ed@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20230407181947.667614ed@jic23-huawei>
Content-Transfer-Encoding: quoted-printable
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 06:19:47PM +0100, Jonathan Cameron wrote:
> On Wed,  5 Apr 2023 23:22:32 +0200
> Patrik Dahlstr=F6m <risca@dalakolonin.se> wrote:
>=20
> > The palmas gpadc block has support for monitoring up to 2 ADC channel=
s
> > and issue an interrupt if they reach past a set threshold. This chang=
e
> > hooks into the IIO events system and exposes to userspace the ability=
 to
> > configure these threshold values for each channel, but only allow up =
to
> > 2 such thresholds to be enabled at any given time. Trying to enable a
> > third channel will result in an error.
> >=20
> > Userspace is expected to input calibrated, as opposed to raw, values =
as
> > threshold. However, it is not enough to do the opposite of what is do=
ne
> > when converting the other way around. To account for tolerances in th=
e
> > ADC, the calculated raw threshold should be adjusted based on the ADC
> > specifications for the device. These specifications include the integ=
ral
> > nonlinearity (INL), offset, and gain error. To adjust the high
> > threshold, use the following equation:
> >=20
> >   (calibrated value + INL) * Gain error + offset =3D maximum value  [=
1]
> >=20
> > Likewise, use the following equation for the low threshold:
> >=20
> >   (calibrated value - INL) * Gain error - offset =3D minimum value
> >=20
> > The gain error is a combination of gain error, as listed in the
> > datasheet, and gain error drift due to temperature and supply. The ex=
act
> > values for these specifications vary between palmas devices. This pat=
ch
> > sets the values found in TWL6035, TWL6037 datasheet.
> >=20
> > [1] TI Application Report, SLIA087A, Guide to Using the GPADC in
> >     TPS65903x, TPS65917-Q1, TPS65919-Q1, and TPS65916 Devices.
> >=20
> > Signed-off-by: Patrik Dahlstr=F6m <risca@dalakolonin.se>
> Hi Patrik,
>=20
> A few really trivial formatting things inline. If we don't end up
> with a v4 for other reasons I can tidy this stuff up whilst applying.

I'll send in a v4 later today :)

>=20
> Jonathan
>=20
>=20
