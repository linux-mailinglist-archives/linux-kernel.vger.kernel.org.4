Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB583607956
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 16:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiJUOOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 10:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiJUOOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 10:14:40 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C42321243;
        Fri, 21 Oct 2022 07:14:32 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id AAD0F40005;
        Fri, 21 Oct 2022 14:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666361671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D1ajsY8pZfc8bFaZEztL4M52XOdc6x7Su0C40vNEpBE=;
        b=UVBc+7G3S1Tm8p4Wf2nV81f4SM/fxgXOgdidSTOBMaH2p/nym5CJKGuXj3Kqp8xUoxd2wd
        kgMhdSK1aCxY5EI8/3zb4u/4pUgwZ3LdZCKSTF1tIF4imEQkJq/M57IhqCpqG9SEkFlf9N
        cApfPDGZgUqLQLtZE4k3S9g49wbPk1L3T9pw6VfwH88I+LCWfKpkXMLVm1vdFxhvuwjc5i
        uDFF4m3UMVmamB0p/MJvgXK9YsDyJgeViWO4NyQ1bc384yG91CwjsslQcs6qWist2loLpq
        n1aX574lsLOhjZ+rnAKVXNJ6Ea+JTrLYQ0+VgR7a8GromJ+BIwfaDfNfV35E+A==
Date:   Fri, 21 Oct 2022 16:14:26 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v7 0/6] Allwinner A31/A83T MIPI CSI-2 and A31 ISP / ISP
 Driver
Message-ID: <Y1KpQl5Nlhd0kKId@aptenodytes>
References: <20220924153304.77598-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+76NLuqt2Dz00PeX"
Content-Disposition: inline
In-Reply-To: <20220924153304.77598-1-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+76NLuqt2Dz00PeX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat 24 Sep 22, 17:32, Paul Kocialkowski wrote:
> This part only concerns the introduction of the new ISP driver and related
> adaptation of the CSI driver.

I don't think there is any significant issue preventing this series from
being merged in Linux 6.2 at this point.

Could we move forward on it? It's been around for quite some time now.

Thanks!

Paul

> Most non-dt patches still need reviewing but should be pretty straightfor=
ward.=20
> Since this multi-part series has been going on for a while, it would be g=
reat
> to see it merged soon!
>=20
> Changes since v6:
> - Added a per-compatible check for the required port in dt binding;
> - Reworded ISP output port description in dt binding;
> - Reversed ISP detection order to have fwnode first;
> - Removed info print when ISP link is detected;
> - Added warn print when ISP is linked but not enabled in config;
> - Fixed sun6i_csi_isp_detect return type;
> - Removed useless initialization in sun6i_csi_isp_detect;
> - Fixed typo in sun6i_csi_isp_detect;
> - Added collected tags;
>=20
> Changes since v5:
> - Rebased on latest media tree;
> - Added collected tag;
> - Switched to using media_pad_remote_pad_first;
> - Switched to using media_pad_remote_pad_unique.
>=20
> Changes since v4:
> - Fixed device-tree binding indent-align;
> - Added collected tag;
> - Rebased on latest media tree;
>=20
> Changes since v3:
> - Removed the v4l2 controls handler from the driver;
> - Added variant structure for table sizes;
> - Removed the info message about video device registration;
> - Removed comments in uAPI header;
> - Used '/schemas/graph.yaml#/properties/port' whenever possible in bindin=
gs;
> - Added CSI patches dependent on the ISP driver;
> - Rebased on the latest media tree;
>=20
> Changes since all-in-one v2:
> - Updated Kconfig to follow the latest media-wide changes;
> - Reworked async subdev handling with a dedicated structure holding the
>   corresponding source to avoid matching in the driver;
> - Switched to clock-managed regmap mmio;
> - Used helper to get a single enabled link for an entity's pad, to replace
>   source selection at link_validate time and select the remote source at
>   stream on time instead;
> - Added mutex for mbus format serialization;
> - Used endpoint-base instead of video-interface for "internal" endpoints
>   in device-tree schema;
> - Added TODO with unstaging requirements;
> - Various cosmetic cleanups;
> - Updated copyright years;
>=20
> Paul Kocialkowski (6):
>   dt-bindings: media: Add Allwinner A31 ISP bindings documentation
>   dt-bindings: media: sun6i-a31-csi: Add internal output port to the ISP
>   staging: media: Add support for the Allwinner A31 ISP
>   MAINTAINERS: Add entry for the Allwinner A31 ISP driver
>   media: sun6i-csi: Detect the availability of the ISP
>   media: sun6i-csi: Add support for hooking to the isp devices
>=20
>  .../media/allwinner,sun6i-a31-csi.yaml        |   4 +
>  .../media/allwinner,sun6i-a31-isp.yaml        | 101 +++
>  MAINTAINERS                                   |   9 +
>  .../platform/sunxi/sun6i-csi/sun6i_csi.c      |  75 +-
>  .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  10 +
>  .../sunxi/sun6i-csi/sun6i_csi_bridge.c        |  32 +-
>  .../sunxi/sun6i-csi/sun6i_csi_capture.c       |  19 +-
>  .../sunxi/sun6i-csi/sun6i_csi_capture.h       |   1 +
>  drivers/staging/media/sunxi/Kconfig           |   1 +
>  drivers/staging/media/sunxi/Makefile          |   1 +
>  drivers/staging/media/sunxi/sun6i-isp/Kconfig |  15 +
>  .../staging/media/sunxi/sun6i-isp/Makefile    |   4 +
>  .../staging/media/sunxi/sun6i-isp/TODO.txt    |   6 +
>  .../staging/media/sunxi/sun6i-isp/sun6i_isp.c | 555 +++++++++++++
>  .../staging/media/sunxi/sun6i-isp/sun6i_isp.h |  90 +++
>  .../media/sunxi/sun6i-isp/sun6i_isp_capture.c | 742 ++++++++++++++++++
>  .../media/sunxi/sun6i-isp/sun6i_isp_capture.h |  78 ++
>  .../media/sunxi/sun6i-isp/sun6i_isp_params.c  | 566 +++++++++++++
>  .../media/sunxi/sun6i-isp/sun6i_isp_params.h  |  52 ++
>  .../media/sunxi/sun6i-isp/sun6i_isp_proc.c    | 577 ++++++++++++++
>  .../media/sunxi/sun6i-isp/sun6i_isp_proc.h    |  66 ++
>  .../media/sunxi/sun6i-isp/sun6i_isp_reg.h     | 275 +++++++
>  .../sunxi/sun6i-isp/uapi/sun6i-isp-config.h   |  43 +
>  23 files changed, 3309 insertions(+), 13 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun=
6i-a31-isp.yaml
>  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/Kconfig
>  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/Makefile
>  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/TODO.txt
>  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c
>  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.h
>  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_captu=
re.c
>  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_captu=
re.h
>  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_param=
s.c
>  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_param=
s.h
>  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c
>  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.h
>  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_reg.h
>  create mode 100644 drivers/staging/media/sunxi/sun6i-isp/uapi/sun6i-isp-=
config.h
>=20
> --=20
> 2.37.3
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--+76NLuqt2Dz00PeX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmNSqUIACgkQ3cLmz3+f
v9E9qQf/e6CZP3vspGNFsSTlpYbKP0gLTcBx4CWwJ810BzPsvBiAFWWPLDsbeNXG
SDdtAoTfjFF0g2wR/xzgL4NdH0uxBTQk+XoPTHwguJKJTzSXtCdAkyr0M6ilGlpe
Bz/95TZ2Za4SswSPhHtcd23lixzrpG3xg7It/7itWeARX/vd1U/AZgiIIc6yyPix
bjEJHJWg0y77fmhtZ4lds9er4kesL7xirmDGyLIBOU1hlWl2q+lKNC4BE09j43pJ
ofrRUmhgI6cjr0T6NDcrlArFndpj6IyAVSLX0MWa4HHyDtjrPpBHWN8X5mQDlHo8
7MvX1B2sht4qKu1E69ZG9yI2yPDCGw==
=BoRq
-----END PGP SIGNATURE-----

--+76NLuqt2Dz00PeX--
