Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F5E607950
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 16:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiJUONX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 10:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiJUONW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 10:13:22 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6348A27BB24;
        Fri, 21 Oct 2022 07:13:20 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EFFC91BF20E;
        Fri, 21 Oct 2022 14:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666361598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZEVgmhcOASwRPTqqa+Ysjijjd2KWZINz27LTHNIGevU=;
        b=oRlm2t6VIXjcIk8+RU6Wd85aVCSerGOC12WTiaf2H4631ayq1AWO7QVFiEWVFw1uVAuvA6
        cW7WY6yAUh/5PCQkejiZjLsX75m/BqsG1UoUdfHWveWt01DXrEN56iJGf5t7NVc73gA6DR
        kJXol21UIooFPXYu0ylbiODMYSCuqvH0zi/QHgYabH4XbMRY2UMETaa9FyetbV/DxMXJye
        3oiErTpqEHpaXo65pYtCmjnagg2KbcYkrOmlWDF8pyu8nLgx2CcEmOvm6cSb/9GuCY/efR
        bC6WMR54BdzZcu1tq2pNoR4heuiDBeWFnSxmuApv4njC2LC1sJ2VQV64bmChMg==
Date:   Fri, 21 Oct 2022 16:13:14 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 00/43] Allwinner A31/A83T MIPI CSI-2 and A31 ISP / CSI
 Rework
Message-ID: <Y1Ko+rNREvM2QClC@aptenodytes>
References: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YEZTk3/+UzCyjE3t"
Content-Disposition: inline
In-Reply-To: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YEZTk3/+UzCyjE3t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi everyone,

On Fri 26 Aug 22, 20:31, Paul Kocialkowski wrote:
> This part only concerns the rework of the CSI driver to support the MIPI =
CSI-2
> and ISP workflows.
>=20
> Very few patches have not received any review at this point and the whole
> thing looks good to go. Since this multi-part series has been going on fo=
r a
> while, it would be great to see it merged soon!

Could this series be considered for merging soon? It would be great to see =
it
in Linux 6.2.

A few patches are still in need of review but I don't think anything
stands in the way at this point.

Thanks in advance,

Paul

> Changes since v5:
> - Rebased on latest media tree;
> - Switched to using media_pad_remote_pad_first;
> - Switched to using media_pad_remote_pad_unique.
>=20
> Changes since v4:
> - Removed the v4l2 controls handler from the driver;
> - Removed the info message about video device registration;
> - Fixed "literature" typos;
> - Moved patches dependent on the ISP driver to its dedicated series;
> - Rebased on the latest media tree;
> - Added collected tags;
>=20
> Changes since v3:
> - Updated Kconfig to follow the latest media-wide changes;
> - Rebased on latest changes to the driver (JPEG/sRGB colorspaces);
> - Added helper to get a single enabled link for an entity's pad, to repla=
ce
>   source selection at link_validate time and select the remote source at
>   stream on time instead;
> - Kept clock-managed regmap mmio;
> - Added collected review tags;
> - Various cosmetic cleanups;
>=20
> Changes since all-in-one v2:
> - Reworked capture video device registration, which stays in the main pat=
h.
> - Reworked async subdev handling with a dedicated structure holding the
>   corresponding source to avoid matching in the driver;
> - Added mutex for mbus format serialization;
> - Remove useless else in link_validate;
> - Reworked commit logs to include missing information;
> - Cleaned up Kconfig, added PM dependency;
> - Moved platform-specific clock rate to of match data;
> - Added collected Reviewed-by tags;
> - Updated copyright years;
>=20
> Paul Kocialkowski (43):
>   media: sun6i-csi: Define and use driver name and (reworked)
>     description
>   media: sun6i-csi: Refactor main driver data structures
>   media: sun6i-csi: Tidy up platform code
>   media: sun6i-csi: Always set exclusive module clock rate
>   media: sun6i-csi: Define and use variant to get module clock rate
>   media: sun6i-csi: Use runtime pm for clocks and reset
>   media: sun6i-csi: Tidy up Kconfig
>   media: sun6i-csi: Tidy up v4l2 code
>   media: sun6i-csi: Tidy up video code
>   media: sun6i-csi: Pass and store csi device directly in video code
>   media: sun6i-csi: Register the media device after creation
>   media: sun6i-csi: Remove controls handler from the driver
>   media: sun6i-csi: Add media ops with link notify callback
>   media: sun6i-csi: Introduce and use video helper functions
>   media: sun6i-csi: Move csi buffer definition to main header file
>   media: sun6i-csi: Add bridge v4l2 subdev with port management
>   media: sun6i-csi: Rename sun6i_video to sun6i_csi_capture
>   media: sun6i-csi: Add capture state using vsync for page flip
>   media: sun6i-csi: Rework register definitions, invert misleading
>     fields
>   media: sun6i-csi: Add dimensions and format helpers to capture
>   media: sun6i-csi: Implement address configuration without indirection
>   media: sun6i-csi: Split stream sequences and irq code in capture
>   media: sun6i-csi: Move power management to runtime pm in capture
>   media: sun6i-csi: Move register configuration to capture
>   media: sun6i-csi: Rework capture format management with helper
>   media: sun6i-csi: Remove custom format helper and rework configure
>   media: sun6i-csi: Add bridge dimensions and format helpers
>   media: sun6i-csi: Get mbus code from bridge instead of storing it
>   media: sun6i-csi: Tidy capture configure code
>   media: sun6i-csi: Introduce bridge format structure, list and helper
>   media: sun6i-csi: Introduce capture format structure, list and helper
>   media: sun6i-csi: Configure registers from format tables
>   media: sun6i-csi: Introduce format match structure, list and helper
>   media: sun6i-csi: Implement capture link validation with logic
>   media: sun6i-csi: Get bridge subdev directly in capture stream ops
>   media: sun6i-csi: Move hardware control to the bridge
>   media: sun6i-csi: Rename the capture video device to sun6i-csi-capture
>   media: sun6i-csi: Cleanup headers and includes, update copyright lines
>   media: sun6i-csi: Add support for MIPI CSI-2 to the bridge code
>   media: sun6i-csi: Only configure capture when streaming
>   media: sun6i-csi: Add extra checks to the interrupt routine
>   media: sun6i-csi: Request a shared interrupt
>   MAINTAINERS: Add myself as sun6i-csi maintainer and rename/move entry
>=20
>  MAINTAINERS                                   |   17 +-
>  .../media/platform/sunxi/sun6i-csi/Kconfig    |   12 +-
>  .../media/platform/sunxi/sun6i-csi/Makefile   |    2 +-
>  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 1027 ++++------------
>  .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  149 +--
>  .../sunxi/sun6i-csi/sun6i_csi_bridge.c        |  844 +++++++++++++
>  .../sunxi/sun6i-csi/sun6i_csi_bridge.h        |   69 ++
>  .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 1089 +++++++++++++++++
>  .../sunxi/sun6i-csi/sun6i_csi_capture.h       |   88 ++
>  .../platform/sunxi/sun6i-csi/sun6i_csi_reg.h  |  362 +++---
>  .../platform/sunxi/sun6i-csi/sun6i_video.c    |  685 -----------
>  .../platform/sunxi/sun6i-csi/sun6i_video.h    |   38 -
>  12 files changed, 2551 insertions(+), 1831 deletions(-)
>  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_brid=
ge.c
>  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_brid=
ge.h
>  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capt=
ure.c
>  create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capt=
ure.h
>  delete mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
>  delete mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_video.h
>=20
> --=20
> 2.37.1
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--YEZTk3/+UzCyjE3t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmNSqPoACgkQ3cLmz3+f
v9HRpQgAkycMui62qToVqMfPYhxWPx1VXlMmQ7m7tyHhb33ePOEuCEl8tf9/9FKt
OnMlM2/JUi82GWzJlJSdeu2uI31psqeuMRdK5zgwe+u2U+hxG5yGMCBNZ7ONMZ3a
vSIdEQxgr/oqaPk6EYaJ3toMM4vaU1x0Vy8pAr9yhbmB7+tsya/LbJiqzCUSeghD
r6dD4Zrq706UhQIJrH1aGani8EPjnoWs4pwMs59c3RlfaZZs3dUa+WQ5CXcdss5l
nSc2BCP/Yvd4zt8DKeB6vGb0Ush2fzdYRRxvXtvVuwWS32WLFHdfMaGp1tST/JCO
mnzA5q+ga+/Vt/AYUKFwsMzk00gUiQ==
=ApHr
-----END PGP SIGNATURE-----

--YEZTk3/+UzCyjE3t--
