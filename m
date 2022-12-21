Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64803653856
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 23:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbiLUWB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 17:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbiLUWBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 17:01:55 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FED8248EA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 14:01:54 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1p879W-0007O0-Gd; Wed, 21 Dec 2022 23:01:30 +0100
Received: from mgr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1p879T-0000tt-JL; Wed, 21 Dec 2022 23:01:27 +0100
Date:   Wed, 21 Dec 2022 23:01:27 +0100
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        p.zabel@pengutronix.de, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v1 0/9] AV1 stateless decoder for RK3588
Message-ID: <20221221220127.GE26315@pengutronix.de>
References: <20221219155616.848690-1-benjamin.gaignard@collabora.com>
 <CAAEAJfBP_D65kjHbwYP+LWfWKfzFtHtWo+3bDcbdO8tPtBurUA@mail.gmail.com>
 <20221219215431.GB26315@pengutronix.de>
 <939ce9a0f7f73c0b9f0cf5590f2d8b02e0825fa5.camel@ndufresne.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="idY8LE8SD6/8DnRI"
Content-Disposition: inline
In-Reply-To: <939ce9a0f7f73c0b9f0cf5590f2d8b02e0825fa5.camel@ndufresne.ca>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--idY8LE8SD6/8DnRI
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 20, 2022 at 12:00:01PM -0500, Nicolas Dufresne wrote:
>Le lundi 19 d=E9cembre 2022 =E0 22:54 +0100, Michael Grzeschik a =E9crit=
=A0:
>> Hi Benjamin,
>> Hi Ezequiel,
>>
>> On Mon, Dec 19, 2022 at 06:07:38PM -0300, Ezequiel Garcia wrote:
>> > On Mon, Dec 19, 2022 at 12:56 PM Benjamin Gaignard
>> > <benjamin.gaignard@collabora.com> wrote:
>> > >
>> > > This series implement AV1 stateless decoder for RK3588 SoC.
>> > > The harware support 8 and 10 bits bitstreams up to 7680x4320.
>> > > AV1 feature like film grain or scaling are done by the postprocessor.
>> > > The driver can produce NV12_4L4 and NV12 pixel formats.
>> > > A native 10bits NV12_4L4 format is possible but need more investigat=
ion
>> > > to be completly documented and enabled.
>> > >
>> > > It is based on Daniel's "[RFC,v3] media: Add AV1 uAPI" [1] patches a=
nd
>> > > Sebastian's device-tree patches for RK3588.
>> > >
>> >
>> > I thought the AV1 decoder in RK3588 was really a separate hardware
>> > from the Hantro G1/G2.
>> >
>> > Shouldn't this need a new driver for this new hardware?
>>
>> Just jumping into this discussion as I am currently working on the rkven=
c driver.
>>
>> In my case I am extending the rkvdec driver to become more generic for
>> other rockchip specific enc/decoders.
>>
>> My first change looks like this:
>> ---
>>  drivers/staging/media/rkvdec/Makefile              |   4 +-
>>  drivers/staging/media/rkvdec/rkvdec-h264.c         | 100 ++++-----
>>  drivers/staging/media/rkvdec/rkvdec-vp9.c          | 142 ++++++-------
>>  drivers/staging/media/rkvdec/{rkvdec.c =3D> rkvpu.c} | 510 ++++++++++++=
+++++++++++-----------------------
>>  drivers/staging/media/rkvdec/{rkvdec.h =3D> rkvpu.h} |  66 +++---
>> ---
>>
>> While working on other parts of the encoder I found many places in the
>> rkvdec driver (e.g. v4l2 and vb2 callbacks) that looked familiar to the =
hantro
>> functions but where limited to the decoder case.
>>
>> I think there are two options for the av1 codec.
>>
>> 1) If the vpu981 is a driver that has nothing to do with verisilicon but
>> works with this driver framework, then we should integrate vepu981 into =
it
>> but consider rename the verisilicon unrelated parts to something generic.
>
>I've raised in my review the the naming is sub-optimal. This is an unmodif=
ied
>VC9000D AV1 decoder. No other codecs have been included in the package, ev=
en
>though VC9000D cores can support more.
>
>Stating this driver have no place here seems a bit strange to me, but with
>proper arguments, maybe we can make a case and start a VC9000D dedicated d=
river
>(that will be a lot of copy paste, VC9000D post processor notably is ident=
ical
>to VC8000 post processor, but one could argue we should make a VCX000 driv=
er ?
>
>>
>> 2) Move the vepu981 av1 driver into the rkvdec instead.
>
>That make no sense, its not a Rockchip HW design, and will likely start
>appearing on non-RK SoC in the future.

Sure. I did not know that it actually is an VC9000.

>> If 1) is the way to go, we can even think of moving the staging code par=
ts from
>> rkvdec to the verisilicon code. Likewise to the vepu981-av1.
>
>Again, I think using RK naming is unfortunate choice. This AV1 decoder is =
just
>like the G1/H1 combo you will find on RK3288. And that same combo is found=
 on
>many older SoC (actually even newer SoC un the VC8000Nano brand).
>
>Like all generation of Hantro chips, there is an optional dependency that =
can
>exist between encoder and decoders. The question is if this requires a sin=
gle
>driver to maintain a valid state or not. So far, it seems devs have assume=
 that
>is it needed.
>
>p.s. fun fact, on most HW, the decoder rate is cut in half with running
>concurrently with the encoder
>
>>
>> I could also keep on integrating the rkvenc on that base instead.
>
>Do you know if there is any interaction between the encoder and decoder ? =
Shared
>registers, shared internal cache ? That's basically what differentiate Han=
tro
>here. Also, be aware that some folks are considering starting on RKVDEC2 d=
river,
>are you looking at RK32/33 series ? or more RK35 ?

I don't know of any limitations or interactions between the encoder and
decoder. I know that the rkvdec is implementing the register space of
the mpp called vdpu34x. My work would adress the vepu54x encoder
registers. Which can be found on rk3588 (vepu541) and rk3568/r3566
(vepu540).

AFAIK the vepu541 and vepu540 are very similar. The vepu540 is limited
by 4k and vepu541 can handle 8k h264.

However how the vepu541 is interacting with the vdpu34x needs to be
found out. Also I did not find any common parts in the mpp
implementation yet.

>> > > The full branch can be found here:
>> > > https://gitlab.collabora.com/linux/for-upstream/-/commits/rk3588_av1=
_decoder_v1
>> > >
>> > > Fluster score is: 151/239 while testing AV1-TEST-VECTORS with GStrea=
mer-AV1-V4L2SL-Gst1.0.
>> > > The failing tests are:
>> > > - 10bits bitstream because 10bits output formats aren't yet implemen=
ted.
>> > > - the 2 tests with 2 spatial layers: few errors in luma/chroma values
>> > > - tests with resolution < hardware limit (64x64)
>> > >
>> > > Benjamin
>> > >
>> > > Benjamin Gaignard (9):
>> > >   dt-bindings: media: rockchip-vpu: Add rk3588 vpu compatible
>> > >   media: verisilicon: Add AV1 decoder mode and controls
>> > >   media: verisilicon: Save bit depth for AV1 decoder
>> > >   media: verisilicon: Check AV1 bitstreams bit depth
>> > >   media: verisilicon: Compute motion vectors size for AV1 frames
>> > >   media: verisilicon: Add AV1 entropy helpers
>> > >   media: verisilicon: Add Rockchip AV1 decoder
>> > >   media: verisilicon: Add film grain feature to AV1 driver
>> > >   media: verisilicon: Enable AV1 decoder on rk3588
>> > >
>> > >  .../bindings/media/rockchip-vpu.yaml          |    1 +
>> > >  drivers/media/platform/verisilicon/Makefile   |    3 +
>> > >  drivers/media/platform/verisilicon/hantro.h   |    5 +
>> > >  .../media/platform/verisilicon/hantro_drv.c   |   54 +
>> > >  .../media/platform/verisilicon/hantro_hw.h    |  102 +
>> > >  .../platform/verisilicon/hantro_postproc.c    |    3 +
>> > >  .../media/platform/verisilicon/hantro_v4l2.c  |    5 +
>> > >  .../verisilicon/rockchip_av1_entropymode.c    | 4536 ++++++++++++++=
+++
>> > >  .../verisilicon/rockchip_av1_entropymode.h    |  272 +
>> > >  .../verisilicon/rockchip_av1_filmgrain.c      |  401 ++
>> > >  .../verisilicon/rockchip_av1_filmgrain.h      |   36 +
>> > >  .../verisilicon/rockchip_vpu981_hw_av1_dec.c  | 2280 +++++++++
>> > >  .../verisilicon/rockchip_vpu981_regs.h        |  477 ++
>> > >  .../platform/verisilicon/rockchip_vpu_hw.c    |  116 +
>> > >  14 files changed, 8291 insertions(+)
>> > >  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_=
entropymode.c
>> > >  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_=
entropymode.h
>> > >  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_=
filmgrain.c
>> > >  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_=
filmgrain.h
>> > >  create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu9=
81_hw_av1_dec.c
>> > >  create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu9=
81_regs.h
>> > >
>> > > --
>> > > 2.34.1
>> > >
>> >
>> > _______________________________________________
>> > linux-arm-kernel mailing list
>> > linux-arm-kernel@lists.infradead.org
>> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>> >
>>
>
>

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--idY8LE8SD6/8DnRI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmOjgjQACgkQC+njFXoe
LGTK7BAAt3FUR0RWx0YAUVvBDf1l8hsMXoWe2MJySuvNOrWtk1PSSQqzLHwnqgyy
08fdR4TrXPP2t3yFi9JBNniMSB2CJLDyFlZWAaZJe/j1IuZtTUevd+D4o3IT7efm
pMsiCsu5jOfdjJluuypoa9QWjUiXWL3yztt3apY5KY5oBc3+GZtSnMyoYqOBJY9s
mTaPSIQGf3yo6bU0qMQqIOxzlpdOa9V9+3QVW4NIoJFPKMuOQsHEx7A7inYIHLFQ
+8p0UXwZIUBcV+UmTWvYmF11mKJbFkvts8PcP2Wk98YYimnrpRoxTKw2rKo9R8PB
X3loylKkhYijbFHxMYdq63D6agf1AfpCzOQziiQqWAeqksby2z+AcTKfedTliZzU
cLc8mETmdM+CK131FcOI9n8GNUPX97JkvuNYt1K01XWaZv413yGyzG67lhidu8DL
4p2aAdJeIBdMDNZZcny3TTgfQfRKgvBDNQOa2zyf2vQDLZbz4nYptq+/ijycyg9+
C89UNi8EqgiCjReOIyxXCE9dLJ0V+XV1dx+Cp7XuhUCJtE1hvaXPSZ0PXY/ie6rg
Sxpmx8s2Od6qK6jplvhoGd37fEXjS/nLMUUdMZOc0wEZR9YKpQqK+eklQbGv0HgE
muFjgT4hvhWjn0JoIMni1sEkOh+A9hoooQ0nM32BjTHzDmhD7/I=
=/6GU
-----END PGP SIGNATURE-----

--idY8LE8SD6/8DnRI--
