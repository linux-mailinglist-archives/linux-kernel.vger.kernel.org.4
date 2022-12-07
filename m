Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27DB645716
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiLGKGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLGKGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:06:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948C93FB80;
        Wed,  7 Dec 2022 02:06:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 783F3CE1CDD;
        Wed,  7 Dec 2022 10:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD319C433D6;
        Wed,  7 Dec 2022 10:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670407568;
        bh=I1gY2mIrXBgBXY/HorosOyog/+TjHFV37SN8mdEb6AQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZHYW6WylODu27JffiDxYYocM7Zuqx2Rjexyagh8CmR9wvxZmqPZeU7fhXH24LOPwH
         sd3sizABtD/uj9smJYPAX2eAupGF3ZtsGrfG9A60k/6TAGfG091sQ/omlGKoYr+38X
         sJU/Y9/3VyLhpRWAtkmdsX0LDiT02+ckOJBH8aPnl6ZKuNmvaZ2BcFxB5SxqLbdRBF
         Sib514Cf/tJYMhItNXx2yoLA0VXP6s6VyZaJkv4LZhw7DvhXZQr9K1ksqPnHaI2fDp
         SBapGPlNCRInJuNM8KrzynMNfy632vkWNUoWoYqXDAbBPMFRC+CM9PlolUNyr5r9WZ
         vjK5En/nK4zbw==
Date:   Wed, 7 Dec 2022 10:06:02 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
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
Message-ID: <Y5BlisjV8Zi5fGWC@spud>
References: <20221103163717.246217-1-paul.kocialkowski@bootlin.com>
 <20221103163717.246217-4-paul.kocialkowski@bootlin.com>
 <Y4RVzSM4FQ/tYQAV@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r9hFmAG5+uobH36S"
Content-Disposition: inline
In-Reply-To: <Y4RVzSM4FQ/tYQAV@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r9hFmAG5+uobH36S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 27, 2022 at 11:31:41PM -0700, Nathan Chancellor wrote:
> Hi Paul,
>=20
> On Thu, Nov 03, 2022 at 05:37:14PM +0100, Paul Kocialkowski wrote:
> > Some Allwinner platforms come with an Image Signal Processor, which
> > supports various features in order to enhance and transform data
> > received by image sensors into good-looking pictures. In most cases,
> > the data is raw bayer, which gets internally converted to RGB and
> > finally YUV, which is what the hardware produces.
> >=20
> > This driver supports ISPs that are similar to the A31 ISP, which was
> > the first standalone ISP found in Allwinner platforms. Simpler ISP
> > blocks were found in the A10 and A20, where they are tied to a CSI
> > controller. Newer generations of Allwinner SoCs (starting with the
> > H6, H616, etc) come with a new camera subsystem and revised ISP.
> > Even though these previous and next-generation ISPs are somewhat
> > similar to the A31 ISP, they have enough significant differences to
> > be out of the scope of this driver.
> >=20
> > While the ISP supports many features, including 3A and many
> > enhancement blocks, this implementation is limited to the following:
> > - V3s (V3/S3) platform support;
> > - Bayer media bus formats as input;
> > - Semi-planar YUV (NV12/NV21) as output;
> > - Debayering with per-component gain and offset configuration;
> > - 2D noise filtering with configurable coefficients.
> >=20
> > Since many features are missing from the associated uAPI, the driver
> > is aimed to integrate staging until all features are properly
> > described.
> >=20
> > On the technical side, it uses the v4l2 and media controller APIs,
> > with a video node for capture, a processor subdev and a video node
> > for parameters submission. A specific uAPI structure and associated
> > v4l2 meta format are used to configure parameters of the supported
> > modules.
> >=20
> > One particular thing about the hardware is that configuration for
> > module registers needs to be stored in a DMA buffer and gets copied
> > to actual registers by the hardware at the next vsync, when instructed
> > by a flag. This is handled by the "state" mechanism in the driver.
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>=20
> This patch is now in -next as commit e3185e1d7c14 ("media: staging:
> media: Add support for the Allwinner A31 ISP"), where it causes the
> following clang warnings:

FWIW, this is (as yet) unfixed & thus breaking allmodconfig w/ clang.
I had a quick look on lore but could not see a proposed fix other than
what Nathan has pasted below.

> > +void sun6i_isp_capture_configure(struct sun6i_isp_device *isp_dev)
> > +{
> > +	unsigned int width, height;
> > +	unsigned int stride_luma, stride_chroma =3D 0;
> > +	unsigned int stride_luma_div4, stride_chroma_div4;
> > +	const struct sun6i_isp_capture_format *format;
> > +	const struct v4l2_format_info *info;
> > +	u32 pixelformat;
> > +
> > +	sun6i_isp_capture_dimensions(isp_dev, &width, &height);
> > +	sun6i_isp_capture_format(isp_dev, &pixelformat);
> > +
> > +	format =3D sun6i_isp_capture_format_find(pixelformat);
> > +	if (WARN_ON(!format))
> > +		return;
> > +
> > +	sun6i_isp_load_write(isp_dev, SUN6I_ISP_MCH_SIZE_CFG_REG,
> > +			     SUN6I_ISP_MCH_SIZE_CFG_WIDTH(width) |
> > +			     SUN6I_ISP_MCH_SIZE_CFG_HEIGHT(height));
> > +
> > +	info =3D v4l2_format_info(pixelformat);
> > +	if (WARN_ON(!info))
> > +		return;
> > +
> > +	stride_luma =3D width * info->bpp[0];
> > +	stride_luma_div4 =3D DIV_ROUND_UP(stride_luma, 4);
> > +
> > +	if (info->comp_planes > 1) {
> > +		stride_chroma =3D width * info->bpp[1] / info->hdiv;
> > +		stride_chroma_div4 =3D DIV_ROUND_UP(stride_chroma, 4);
> > +	}
> > +
> > +	sun6i_isp_load_write(isp_dev, SUN6I_ISP_MCH_CFG_REG,
> > +			     SUN6I_ISP_MCH_CFG_EN |
> > +			     SUN6I_ISP_MCH_CFG_OUTPUT_FMT(format->output_format) |
> > +			     SUN6I_ISP_MCH_CFG_STRIDE_Y_DIV4(stride_luma_div4) |
> > +			     SUN6I_ISP_MCH_CFG_STRIDE_UV_DIV4(stride_chroma_div4));
> > +}
>=20
>=20
>   drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c:135:6: error:=
 variable 'stride_chroma_div4' is used uninitialized whenever 'if' conditio=
n is false [-Werror,-Wsometimes-uninitialized]
>           if (info->comp_planes > 1) {
>               ^~~~~~~~~~~~~~~~~~~~~
>   drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c:144:42: note:=
 uninitialized use occurs here
>                               SUN6I_ISP_MCH_CFG_STRIDE_UV_DIV4(stride_chr=
oma_div4));
>                                                                 ^~~~~~~~~=
~~~~~~~~~
>   drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_reg.h:249:48: note: exp=
anded from macro 'SUN6I_ISP_MCH_CFG_STRIDE_UV_DIV4'
>   #define SUN6I_ISP_MCH_CFG_STRIDE_UV_DIV4(v)     (((v) << 20) & GENMASK(=
30, 20))
>                                                     ^
>   drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c:135:2: note: =
remove the 'if' if its condition is always true
>           if (info->comp_planes > 1) {
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>   drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c:112:51: note:=
 initialize the variable 'stride_chroma_div4' to silence this warning
>           unsigned int stride_luma_div4, stride_chroma_div4;
>                                                           ^
>                                                             =3D 0
>=20
> Does stride_chroma_div4 want to just be initialized to zero?
>=20
> > +static int sun6i_isp_proc_notifier_bound(struct v4l2_async_notifier *n=
otifier,
> > +					 struct v4l2_subdev *remote_subdev,
> > +					 struct v4l2_async_subdev *async_subdev)
> > +{
> > +	struct sun6i_isp_device *isp_dev =3D
> > +		container_of(notifier, struct sun6i_isp_device, proc.notifier);
> > +	struct sun6i_isp_proc_async_subdev *proc_async_subdev =3D
> > +		container_of(async_subdev, struct sun6i_isp_proc_async_subdev,
> > +			     async_subdev);
> > +	struct sun6i_isp_proc *proc =3D &isp_dev->proc;
> > +	struct sun6i_isp_proc_source *source =3D proc_async_subdev->source;
> > +	bool enabled;
> > +
> > +	switch (source->endpoint.base.port) {
> > +	case SUN6I_ISP_PORT_CSI0:
> > +		source =3D &proc->source_csi0;
> > +		enabled =3D true;
> > +		break;
> > +	case SUN6I_ISP_PORT_CSI1:
> > +		source =3D &proc->source_csi1;
> > +		enabled =3D !proc->source_csi0.expected;
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	source->subdev =3D remote_subdev;
> > +
> > +	return sun6i_isp_proc_link(isp_dev, SUN6I_ISP_PROC_PAD_SINK_CSI,
> > +				   remote_subdev, enabled);
> > +}
>=20
>   drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c:418:2: error: va=
riable 'enabled' is used uninitialized whenever switch default is taken [-W=
error,-Wsometimes-uninitialized]
>           default:
>           ^~~~~~~
>   drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c:425:23: note: un=
initialized use occurs here
>                                     remote_subdev, enabled);
>                                                     ^~~~~~~
>   drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c:407:14: note: in=
itialize the variable 'enabled' to silence this warning
>           bool enabled;
>                       ^
>                       =3D 0
>=20
> Should there be an early return in the default case?
>=20
> I do not mind sending patches if you are unable to, assuming I have the
> right fixes.
>=20
> Cheers,
> Nathan
>=20

--r9hFmAG5+uobH36S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY5BligAKCRB4tDGHoIJi
0ukmAQDmVsJKCPxo8VajrEq7HOquWhxFMxVYfhmTx0e4zTVg9AD+JpfzzwtmPBQi
W7meOLACGLzrk3LhZoDhDll39zPj9wg=
=hRIk
-----END PGP SIGNATURE-----

--r9hFmAG5+uobH36S--
