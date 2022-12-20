Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150466521A1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 14:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbiLTNk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 08:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbiLTNkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 08:40:23 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3988518E33
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 05:40:22 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1p7cqk-00074A-6D; Tue, 20 Dec 2022 14:40:06 +0100
Received: from mgr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1p7cqh-0005jm-Qg; Tue, 20 Dec 2022 14:40:03 +0100
Date:   Tue, 20 Dec 2022 14:40:03 +0100
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        p.zabel@pengutronix.de, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v1 0/9] AV1 stateless decoder for RK3588
Message-ID: <20221220134003.GC26315@pengutronix.de>
References: <20221219155616.848690-1-benjamin.gaignard@collabora.com>
 <CAAEAJfBP_D65kjHbwYP+LWfWKfzFtHtWo+3bDcbdO8tPtBurUA@mail.gmail.com>
 <20221219215431.GB26315@pengutronix.de>
 <CAAEAJfBzZWHu9YE38HzRUQ2xRZohYa19JaK7EOaQDqz5K1sz_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline
In-Reply-To: <CAAEAJfBzZWHu9YE38HzRUQ2xRZohYa19JaK7EOaQDqz5K1sz_g@mail.gmail.com>
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


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ezequiel,

On Mon, Dec 19, 2022 at 10:52:02PM -0300, Ezequiel Garcia wrote:
>On Mon, Dec 19, 2022 at 6:54 PM Michael Grzeschik <mgr@pengutronix.de> wro=
te:
>> On Mon, Dec 19, 2022 at 06:07:38PM -0300, Ezequiel Garcia wrote:
>> >On Mon, Dec 19, 2022 at 12:56 PM Benjamin Gaignard
>> ><benjamin.gaignard@collabora.com> wrote:
>> >>
>> >> This series implement AV1 stateless decoder for RK3588 SoC.
>> >> The harware support 8 and 10 bits bitstreams up to 7680x4320.
>> >> AV1 feature like film grain or scaling are done by the postprocessor.
>> >> The driver can produce NV12_4L4 and NV12 pixel formats.
>> >> A native 10bits NV12_4L4 format is possible but need more investigati=
on
>> >> to be completly documented and enabled.
>> >>
>> >> It is based on Daniel's "[RFC,v3] media: Add AV1 uAPI" [1] patches and
>> >> Sebastian's device-tree patches for RK3588.
>> >>
>> >
>> >I thought the AV1 decoder in RK3588 was really a separate hardware
>> >from the Hantro G1/G2.
>> >
>> >Shouldn't this need a new driver for this new hardware?
>>
>> Just jumping into this discussion as I am currently working on the rkven=
c driver.
>>
>
>The more the merrier, there's always room for developers :-)
>
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
>
>Because stateless decoders devices are very similar in their general behav=
ior,
>their drivers could be very similar.
>
>Hantro and Rkvdec could look similar because the same humans worked on the=
m.
>
>Most boilerplate code, as well as V4L2 format negotiation, VB2 buffer hand=
ling
>could be shared among all stateless decoder drivers. I think even at one p=
oint
>we experimented with having a shared/common code base for all stateless co=
decs.
>
>In other words, it's entirely possible to support Hantro devices in
>the Cedrus driver
>and vice-versa, you would only have to write the hardware-specific bits.
>
>However, there is consensus to have a separate driver for each
>different hardware,
>even when the hardware is a bit similar. This may lead to some code duplic=
ation,
>but it's less fragile / more flexible. Maintaining drivers this way allows
>developers to evolve, testing on a small family of devices, without
>breaking support
>for other devices.
>
>This is important as sometimes it's hard to get the hardware,
>but we still don't want to break the support!
>
>> I think there are two options for the av1 codec.
>>
>> 1) If the vpu981 is a driver that has nothing to do with verisilicon but
>> works with this driver framework, then we should integrate vepu981 into =
it
>> but consider rename the verisilicon unrelated parts to something generic.
>>
>> 2) Move the vepu981 av1 driver into the rkvdec instead.
>>
>> If 1) is the way to go, we can even think of moving the staging code par=
ts from
>> rkvdec to the verisilicon code. Likewise to the vepu981-av1.
>>
>
>The Hantro driver should only support G1, G2, and VC8000D;
>which can be said to belong to the same family.
>
>The RKVDEC driver supports Rockchip vdpu34x core. I have to admit
>I'm not exactly sure if we support anything else than vdpu34x.

Currently the rkvdec is only supporting vdpu34x. My work would integrate
vepu54x into the rkvdec boilerplate and so it would support encode as decod=
e.

>I'm not familiar with the AV1 support provided by this patch,
>but looking at the mpp code:
>
>...
>        "rk3588",
>        ROCKCHIP_SOC_RK3588,
>        HAVE_VDPU2 | HAVE_VDPU2_PP | HAVE_VEPU2 | HAVE_RKVDEC | HAVE_RKVEN=
C |
>        HAVE_JPEG_DEC | HAVE_AV1DEC | HAVE_AVSDEC | HAVE_VEPU2_JPEG,
>        {   &vdpu38x, &rkjpegd, &vdpu2, &vdpu2_jpeg_pp, &av1d, &avspd},
>        {   &vepu58x, &vepu2, &vepu2_jpeg, NULL, },
>
>Seems RK3588 supports a Hantro core (VDPU2), a vdpu38x core and this AV1 c=
ore,
>which according to this patchset is vdpu981 (?)
>
>If the vdpu38x device interface, configuration, buffer handling and
>registers are
>similar enough with vdpu34x, adding vdpu38x to the Rkvdec driver
>should be straightforward.
>If the vdpu38x core differs, it may be reason enough to consider a new dri=
ver.
>
>As for vdpu981 (AV1), I'm inclined to think it deserves its own driver.
>
>Again, I'm far less worried for a little code duplication in the
>boilerplate (which can be solved
>with helpers, etc.) and more worried about making sure we can evolve
>drivers easily,
>while minimizing regressions.

Thanks for the explanation.

As I agree that not breaking current drivers is a strong argument. Also
rkvdec is still in staging, which makes it less harmful for the
integration of the encoder path.

Since we can not ensure that the rkvenc/rkvdec is not another unknown
verisilicon core, going the way of working on a common rkvpu driver is
probably the best for now.

Also, since I have already done some work into that direction, it sounds
good for me. :)


>> I could also keep on integrating the rkvenc on that base instead.
>>
>> Regards,
>> Michael
>>
>> >> The full branch can be found here:
>> >> https://gitlab.collabora.com/linux/for-upstream/-/commits/rk3588_av1_=
decoder_v1
>> >>
>> >> Fluster score is: 151/239 while testing AV1-TEST-VECTORS with GStream=
er-AV1-V4L2SL-Gst1.0.
>> >> The failing tests are:
>> >> - 10bits bitstream because 10bits output formats aren't yet implement=
ed.
>> >> - the 2 tests with 2 spatial layers: few errors in luma/chroma values
>> >> - tests with resolution < hardware limit (64x64)
>> >>
>> >> Benjamin
>> >>
>> >> Benjamin Gaignard (9):
>> >>   dt-bindings: media: rockchip-vpu: Add rk3588 vpu compatible
>> >>   media: verisilicon: Add AV1 decoder mode and controls
>> >>   media: verisilicon: Save bit depth for AV1 decoder
>> >>   media: verisilicon: Check AV1 bitstreams bit depth
>> >>   media: verisilicon: Compute motion vectors size for AV1 frames
>> >>   media: verisilicon: Add AV1 entropy helpers
>> >>   media: verisilicon: Add Rockchip AV1 decoder
>> >>   media: verisilicon: Add film grain feature to AV1 driver
>> >>   media: verisilicon: Enable AV1 decoder on rk3588
>> >>
>> >>  .../bindings/media/rockchip-vpu.yaml          |    1 +
>> >>  drivers/media/platform/verisilicon/Makefile   |    3 +
>> >>  drivers/media/platform/verisilicon/hantro.h   |    5 +
>> >>  .../media/platform/verisilicon/hantro_drv.c   |   54 +
>> >>  .../media/platform/verisilicon/hantro_hw.h    |  102 +
>> >>  .../platform/verisilicon/hantro_postproc.c    |    3 +
>> >>  .../media/platform/verisilicon/hantro_v4l2.c  |    5 +
>> >>  .../verisilicon/rockchip_av1_entropymode.c    | 4536 +++++++++++++++=
++
>> >>  .../verisilicon/rockchip_av1_entropymode.h    |  272 +
>> >>  .../verisilicon/rockchip_av1_filmgrain.c      |  401 ++
>> >>  .../verisilicon/rockchip_av1_filmgrain.h      |   36 +
>> >>  .../verisilicon/rockchip_vpu981_hw_av1_dec.c  | 2280 +++++++++
>> >>  .../verisilicon/rockchip_vpu981_regs.h        |  477 ++
>> >>  .../platform/verisilicon/rockchip_vpu_hw.c    |  116 +
>> >>  14 files changed, 8291 insertions(+)
>> >>  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_e=
ntropymode.c
>> >>  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_e=
ntropymode.h
>> >>  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_f=
ilmgrain.c
>> >>  create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_f=
ilmgrain.h
>> >>  create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu98=
1_hw_av1_dec.c
>> >>  create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu98=
1_regs.h
>> >>
>> >> --
>> >> 2.34.1
>> >>
>> >
>> >_______________________________________________
>> >linux-arm-kernel mailing list
>> >linux-arm-kernel@lists.infradead.org
>> >http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>> >
>>
>> --
>> Pengutronix e.K.                           |                            =
 |
>> Steuerwalder Str. 21                       | http://www.pengutronix.de/ =
 |
>> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0   =
 |
>> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555=
 |
>

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmOhuzEACgkQC+njFXoe
LGQkNBAAodpx1wtHCvWZ8qXy5GQhh7jyT4QhcQiQuBgXjFTokznsI0gWqZBbS2cI
Ye2mIZNmDO5i6+pq81k1PQbuPJPIiPpZmV6vJSBSOm5pWQ3vDKpl+58uhQ4GHPcj
VBw7HQsGdnxDfcA4YGcY2uXmOukgr1ScJeuHEJOtwS1y/cyJds5s9np7IbVYn3Qe
z0jhzKKQi+Ga+Z2GdMXw1jjaxDQW93aEQjFe2HPzFJ8OF3VvAAX9DgEuHCpb2uLY
o/euN8ECdzrpSq8tCCnIFpiNHLjqx4uKFdI4rvhc3CTMDvKx/gaaiuvNRKgzYbsA
4j9f0IiwayT2C9s3vtrB0QtwRH1QWrej43cKNeGldkKmNvXMVoT0vRNpp4jWi+IH
ecPfoqFo/EkAHgea3AL9YX59OuSnmcvdD2cZxabTnW/OSv2+cjML4FORL7eQaiUe
xSC7jgFwBgKGEn3wmPXTtIZpHjF/aiD2uSlxn0E7A0uEWtd3VP/b25GAWhcaaOB3
hCmPTei/jh3HRnrW1ABf1M+XwRs3+YTY4elqkd3PoxF2q8tZWXEvMQexZtspk3s5
PrKp7I0ZUJg2YSGdQVIlvkA+2GqPBqsY7TiOMzMbgW0VKLWOp/a68lTwdhu7dn0F
HGDuS0nB+yADJeQ1Kknufew1iE2+Bgu/vcAcR0r5ey8mh0L5JKY=
=unC0
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--
