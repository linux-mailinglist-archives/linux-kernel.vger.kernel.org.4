Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7CA647136
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 14:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiLHN6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 08:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiLHN6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 08:58:14 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C539C9950D;
        Thu,  8 Dec 2022 05:57:27 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7BE0540009;
        Thu,  8 Dec 2022 13:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670507845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mr7vzB06ht6izeqsLHAia6JSQyQ1GNVqrccqV8dELgw=;
        b=DCDRHaqHKOtHFvSe0xYDJk3kFFuNCF608DJmF1Ke49OrphC+kEsbFvOFWPlw3VPNrRZI+1
        ZU9aKAaF+ZODnViGtoxXxFmr+L+gXshALTNDSWbF91Jm7sOhqzjS+QlBLAzLi2MDuGXKG+
        nIAl2Ljwd1oSA+IBIU14we++A59VNUDAh5Jw8YcvYy382VRl1GCZi5Flq1tG+5AWai0AGn
        wKE9Z4jjRN+alZWX/vL//ioFfzRY63K6gpOM/llOvgic6mHbINMMauKybI5u+YQbIRfLWc
        cM8MCLMGt25iy+iHwLefsjtMnQu/58Jne5S3MJkPooyesnbI/10NsBr6DXz+PA==
Date:   Thu, 8 Dec 2022 14:57:22 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        llvm@lists.linux.dev
Subject: Re: [PATCH v8 3/6] staging: media: Add support for the Allwinner A31
 ISP
Message-ID: <Y5HtQr6G1Ha8ybeX@aptenodytes>
References: <20221103163717.246217-1-paul.kocialkowski@bootlin.com>
 <20221103163717.246217-4-paul.kocialkowski@bootlin.com>
 <Y4RVzSM4FQ/tYQAV@dev-arch.thelio-3990X>
 <Y5BlisjV8Zi5fGWC@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Eq1pwegXvM8VevdS"
Content-Disposition: inline
In-Reply-To: <Y5BlisjV8Zi5fGWC@spud>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Eq1pwegXvM8VevdS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Conor, Nathan,

On Wed 07 Dec 22, 10:06, Conor Dooley wrote:
> On Sun, Nov 27, 2022 at 11:31:41PM -0700, Nathan Chancellor wrote:
> > Hi Paul,
> >=20
> > On Thu, Nov 03, 2022 at 05:37:14PM +0100, Paul Kocialkowski wrote:
> > > Some Allwinner platforms come with an Image Signal Processor, which
> > > supports various features in order to enhance and transform data
> > > received by image sensors into good-looking pictures. In most cases,
> > > the data is raw bayer, which gets internally converted to RGB and
> > > finally YUV, which is what the hardware produces.
> > >=20
> > > This driver supports ISPs that are similar to the A31 ISP, which was
> > > the first standalone ISP found in Allwinner platforms. Simpler ISP
> > > blocks were found in the A10 and A20, where they are tied to a CSI
> > > controller. Newer generations of Allwinner SoCs (starting with the
> > > H6, H616, etc) come with a new camera subsystem and revised ISP.
> > > Even though these previous and next-generation ISPs are somewhat
> > > similar to the A31 ISP, they have enough significant differences to
> > > be out of the scope of this driver.
> > >=20
> > > While the ISP supports many features, including 3A and many
> > > enhancement blocks, this implementation is limited to the following:
> > > - V3s (V3/S3) platform support;
> > > - Bayer media bus formats as input;
> > > - Semi-planar YUV (NV12/NV21) as output;
> > > - Debayering with per-component gain and offset configuration;
> > > - 2D noise filtering with configurable coefficients.
> > >=20
> > > Since many features are missing from the associated uAPI, the driver
> > > is aimed to integrate staging until all features are properly
> > > described.
> > >=20
> > > On the technical side, it uses the v4l2 and media controller APIs,
> > > with a video node for capture, a processor subdev and a video node
> > > for parameters submission. A specific uAPI structure and associated
> > > v4l2 meta format are used to configure parameters of the supported
> > > modules.
> > >=20
> > > One particular thing about the hardware is that configuration for
> > > module registers needs to be stored in a DMA buffer and gets copied
> > > to actual registers by the hardware at the next vsync, when instructed
> > > by a flag. This is handled by the "state" mechanism in the driver.
> > >=20
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> >=20
> > This patch is now in -next as commit e3185e1d7c14 ("media: staging:
> > media: Add support for the Allwinner A31 ISP"), where it causes the
> > following clang warnings:
>=20
> FWIW, this is (as yet) unfixed & thus breaking allmodconfig w/ clang.
> I had a quick look on lore but could not see a proposed fix other than
> what Nathan has pasted below.

Sorry for the inconvenience. I've just sent a fix series which should resol=
ve
these issues (and other ones too): "Allwinner A31/A83T CSI/ISP/MIPI CSI-2 m=
edia
fixes" (version 2).

Thanks for the report!

Paul

> > > +void sun6i_isp_capture_configure(struct sun6i_isp_device *isp_dev)
> > > +{
> > > +	unsigned int width, height;
> > > +	unsigned int stride_luma, stride_chroma =3D 0;
> > > +	unsigned int stride_luma_div4, stride_chroma_div4;
> > > +	const struct sun6i_isp_capture_format *format;
> > > +	const struct v4l2_format_info *info;
> > > +	u32 pixelformat;
> > > +
> > > +	sun6i_isp_capture_dimensions(isp_dev, &width, &height);
> > > +	sun6i_isp_capture_format(isp_dev, &pixelformat);
> > > +
> > > +	format =3D sun6i_isp_capture_format_find(pixelformat);
> > > +	if (WARN_ON(!format))
> > > +		return;
> > > +
> > > +	sun6i_isp_load_write(isp_dev, SUN6I_ISP_MCH_SIZE_CFG_REG,
> > > +			     SUN6I_ISP_MCH_SIZE_CFG_WIDTH(width) |
> > > +			     SUN6I_ISP_MCH_SIZE_CFG_HEIGHT(height));
> > > +
> > > +	info =3D v4l2_format_info(pixelformat);
> > > +	if (WARN_ON(!info))
> > > +		return;
> > > +
> > > +	stride_luma =3D width * info->bpp[0];
> > > +	stride_luma_div4 =3D DIV_ROUND_UP(stride_luma, 4);
> > > +
> > > +	if (info->comp_planes > 1) {
> > > +		stride_chroma =3D width * info->bpp[1] / info->hdiv;
> > > +		stride_chroma_div4 =3D DIV_ROUND_UP(stride_chroma, 4);
> > > +	}
> > > +
> > > +	sun6i_isp_load_write(isp_dev, SUN6I_ISP_MCH_CFG_REG,
> > > +			     SUN6I_ISP_MCH_CFG_EN |
> > > +			     SUN6I_ISP_MCH_CFG_OUTPUT_FMT(format->output_format) |
> > > +			     SUN6I_ISP_MCH_CFG_STRIDE_Y_DIV4(stride_luma_div4) |
> > > +			     SUN6I_ISP_MCH_CFG_STRIDE_UV_DIV4(stride_chroma_div4));
> > > +}
> >=20
> >=20
> >   drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c:135:6: erro=
r: variable 'stride_chroma_div4' is used uninitialized whenever 'if' condit=
ion is false [-Werror,-Wsometimes-uninitialized]
> >           if (info->comp_planes > 1) {
> >               ^~~~~~~~~~~~~~~~~~~~~
> >   drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c:144:42: not=
e: uninitialized use occurs here
> >                               SUN6I_ISP_MCH_CFG_STRIDE_UV_DIV4(stride_c=
hroma_div4));
> >                                                                 ^~~~~~~=
~~~~~~~~~~~
> >   drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_reg.h:249:48: note: e=
xpanded from macro 'SUN6I_ISP_MCH_CFG_STRIDE_UV_DIV4'
> >   #define SUN6I_ISP_MCH_CFG_STRIDE_UV_DIV4(v)     (((v) << 20) & GENMAS=
K(30, 20))
> >                                                     ^
> >   drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c:135:2: note=
: remove the 'if' if its condition is always true
> >           if (info->comp_planes > 1) {
> >           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c:112:51: not=
e: initialize the variable 'stride_chroma_div4' to silence this warning
> >           unsigned int stride_luma_div4, stride_chroma_div4;
> >                                                           ^
> >                                                             =3D 0
> >=20
> > Does stride_chroma_div4 want to just be initialized to zero?
> >=20
> > > +static int sun6i_isp_proc_notifier_bound(struct v4l2_async_notifier =
*notifier,
> > > +					 struct v4l2_subdev *remote_subdev,
> > > +					 struct v4l2_async_subdev *async_subdev)
> > > +{
> > > +	struct sun6i_isp_device *isp_dev =3D
> > > +		container_of(notifier, struct sun6i_isp_device, proc.notifier);
> > > +	struct sun6i_isp_proc_async_subdev *proc_async_subdev =3D
> > > +		container_of(async_subdev, struct sun6i_isp_proc_async_subdev,
> > > +			     async_subdev);
> > > +	struct sun6i_isp_proc *proc =3D &isp_dev->proc;
> > > +	struct sun6i_isp_proc_source *source =3D proc_async_subdev->source;
> > > +	bool enabled;
> > > +
> > > +	switch (source->endpoint.base.port) {
> > > +	case SUN6I_ISP_PORT_CSI0:
> > > +		source =3D &proc->source_csi0;
> > > +		enabled =3D true;
> > > +		break;
> > > +	case SUN6I_ISP_PORT_CSI1:
> > > +		source =3D &proc->source_csi1;
> > > +		enabled =3D !proc->source_csi0.expected;
> > > +		break;
> > > +	default:
> > > +		break;
> > > +	}
> > > +
> > > +	source->subdev =3D remote_subdev;
> > > +
> > > +	return sun6i_isp_proc_link(isp_dev, SUN6I_ISP_PROC_PAD_SINK_CSI,
> > > +				   remote_subdev, enabled);
> > > +}
> >=20
> >   drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c:418:2: error: =
variable 'enabled' is used uninitialized whenever switch default is taken [=
-Werror,-Wsometimes-uninitialized]
> >           default:
> >           ^~~~~~~
> >   drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c:425:23: note: =
uninitialized use occurs here
> >                                     remote_subdev, enabled);
> >                                                     ^~~~~~~
> >   drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c:407:14: note: =
initialize the variable 'enabled' to silence this warning
> >           bool enabled;
> >                       ^
> >                       =3D 0
> >=20
> > Should there be an early return in the default case?
> >=20
> > I do not mind sending patches if you are unable to, assuming I have the
> > right fixes.
> >=20
> > Cheers,
> > Nathan
> >=20



--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--Eq1pwegXvM8VevdS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmOR7UIACgkQ3cLmz3+f
v9HUhgf+MqWFRHpJteq7pbYqsoMp5NzKApq8Hab85Kt4+jkrdLX2dh6CaKTamgE/
40oyJ2sy5UkWIMNxPsfOdsDPV4d5K5VE430Rqd8EnA7Vu3uPV6Mwbl7YtMcsIIhh
QKFpamExdTcvdL3wUE8pUylLl4ivuwXeJYblWp9JdzzqhBQYE0hcuCdryF0hPm0l
R2h3rc0+jnlq6Lmv38MMTM1WFh8j6Fz9rPz8yEEoKBq4WSRGKn1Tdt6Ksmv7hmKh
uz3RTdIauzhkUziTluMjhmBgWjI843kki2vXNo6X6pUk05zM6qxF7Iiat2jIgRW2
iyAWJvWttMBPhfa1UzYG2Rn8BFiiYw==
=Vl1z
-----END PGP SIGNATURE-----

--Eq1pwegXvM8VevdS--
