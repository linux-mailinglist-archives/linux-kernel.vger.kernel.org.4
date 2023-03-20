Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273E26C0AB1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 07:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjCTGdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 02:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCTGdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 02:33:50 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A977FEC78
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 23:33:47 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32K6XanB013678;
        Mon, 20 Mar 2023 01:33:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679294016;
        bh=PpWfLDL8EN47urhltItaJFJ868B98/oY43mUbJWqm+s=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=JtMH+Ws+mniuKEgVVyrumnMv6I0GLuutPy4AKdIMkgxUV+SRyMVo6cjAvYqO2oG16
         fXU4hbP4OY+aHyZKP8TqAAfyZQ9DaJ5zcmEHQiOktrC6yhct6HSs2PqwBCIuWAe7SK
         IIYUWJYNRSKFt8oRJKVGc3os1yWPBIoylWL/OJrs=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32K6XaBK030290
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Mar 2023 01:33:36 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 20
 Mar 2023 01:33:36 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 20 Mar 2023 01:33:36 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32K6XZHH116601;
        Mon, 20 Mar 2023 01:33:36 -0500
Date:   Mon, 20 Mar 2023 12:03:37 +0530
From:   Jai Luthra <j-luthra@ti.com>
To:     Vaishnav Achath <vaishnav.a@ti.com>
CC:     <linux-phy@lists.infradead.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devarsht@ti.com>, <tomi.valkeinen@ideasonboard.com>,
        <praneeth@ti.com>, <u-kumar1@ti.com>, <vigneshr@ti.com>,
        <nm@ti.com>, <sinthu.raja@ti.com>
Subject: Re: [PATCH] phy: cadence: cdns-dphy-rx: Add common module reset
 support
Message-ID: <20230320063337.oeta63lyes72pfxb@uda0497096>
References: <20230314073137.2153-1-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zu4fbieikuth2lrl"
Content-Disposition: inline
In-Reply-To: <20230314073137.2153-1-vaishnav.a@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--zu4fbieikuth2lrl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mar 14, 2023 at 13:01:37 +0530, Vaishnav Achath wrote:
> From: Sinthu Raja <sinthu.raja@ti.com>
>=20
> DPHY RX module has a common module reset (RSTB_CMN) which is expected
> to be released during configuration. In J721E SR1.0 the RSTB_CMN is
> internally tied to CSI_RX_RST and is hardware controlled, for all
> other newer platforms the common module reset is software controlled.
> Add support to control common module reset during configuration and
> also skip common module reset based on soc_device_match() for J721E SR1.0.
>=20
> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> Co-developed-by: Vaishnav Achath <vaishnav.a@ti.com>
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>

Reviewed-by: Jai Luthra <j-luthra@ti.com>

> ---
>=20
> Tested on J721E SR1.0 and SR 1.1 by CSI2RX streaming,
> without this changes CSI2RX streaming fails on J721E SR1.1
> and all other newer TI platforms (J721S2, J784S4, AM62X).
>=20
> Logs: https://gist.github.com/vaishnavachath/3ecda7de0e63b13c6f765ae2c4f9=
c5ff
>=20
>  drivers/phy/cadence/cdns-dphy-rx.c | 32 ++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>=20
> diff --git a/drivers/phy/cadence/cdns-dphy-rx.c b/drivers/phy/cadence/cdn=
s-dphy-rx.c
> index 572c70089a94..c05b043893a9 100644
> --- a/drivers/phy/cadence/cdns-dphy-rx.c
> +++ b/drivers/phy/cadence/cdns-dphy-rx.c
> @@ -11,10 +11,12 @@
>  #include <linux/phy/phy.h>
>  #include <linux/phy/phy-mipi-dphy.h>
>  #include <linux/platform_device.h>
> +#include <linux/sys_soc.h>
> =20
>  #define DPHY_PMA_CMN(reg)		(reg)
>  #define DPHY_PCS(reg)			(0xb00 + (reg))
>  #define DPHY_ISO(reg)			(0xc00 + (reg))
> +#define DPHY_WRAP(reg)			(0x1000 + (reg))
> =20
>  #define DPHY_CMN_SSM			DPHY_PMA_CMN(0x20)
>  #define DPHY_CMN_RX_MODE_EN		BIT(10)
> @@ -33,6 +35,9 @@
>  #define DPHY_POWER_ISLAND_EN_CLK	DPHY_PCS(0xc)
>  #define DPHY_POWER_ISLAND_EN_CLK_VAL	0xaa
> =20
> +#define DPHY_LANE			DPHY_WRAP(0x0)
> +#define DPHY_LANE_RESET_CMN_EN		BIT(23)
> +
>  #define DPHY_ISO_CL_CTRL_L		DPHY_ISO(0x10)
>  #define DPHY_ISO_DL_CTRL_L0		DPHY_ISO(0x14)
>  #define DPHY_ISO_DL_CTRL_L1		DPHY_ISO(0x20)
> @@ -57,6 +62,10 @@ struct cdns_dphy_rx_band {
>  	unsigned int max_rate;
>  };
> =20
> +struct cdns_dphy_soc_data {
> +	bool has_hw_cmn_rstb;
> +};
> +
>  /* Order of bands is important since the index is the band number. */
>  static const struct cdns_dphy_rx_band bands[] =3D {
>  	{ 80, 100 }, { 100, 120 }, { 120, 160 }, { 160, 200 }, { 200, 240 },
> @@ -142,13 +151,36 @@ static int cdns_dphy_rx_wait_lane_ready(struct cdns=
_dphy_rx *dphy,
>  	return 0;
>  }
> =20
> +static struct cdns_dphy_soc_data j721e_soc_data =3D {
> +	.has_hw_cmn_rstb =3D true,
> +};
> +
> +static const struct soc_device_attribute cdns_dphy_socinfo[] =3D {
> +	{
> +		.family =3D "J721E",
> +		.revision =3D "SR1.0",
> +		.data =3D &j721e_soc_data,
> +	},
> +	{/* sentinel */}
> +};
> +
>  static int cdns_dphy_rx_configure(struct phy *phy,
>  				  union phy_configure_opts *opts)
>  {
>  	struct cdns_dphy_rx *dphy =3D phy_get_drvdata(phy);
>  	unsigned int reg, lanes =3D opts->mipi_dphy.lanes;
> +	const struct cdns_dphy_soc_data *soc_data =3D NULL;
> +	const struct soc_device_attribute *soc;
>  	int band_ctrl, ret;
> =20
> +	soc =3D soc_device_match(cdns_dphy_socinfo);
> +	if (soc && soc->data)
> +		soc_data =3D soc->data;
> +	if (!soc || (soc_data && !soc_data->has_hw_cmn_rstb)) {
> +		reg =3D DPHY_LANE_RESET_CMN_EN;
> +		writel(reg, dphy->regs + DPHY_LANE);
> +	}
> +
>  	/* Data lanes. Minimum one lane is mandatory. */
>  	if (lanes < DPHY_LANES_MIN || lanes > DPHY_LANES_MAX)
>  		return -EINVAL;
> --=20
> 2.17.1
>=20

--zu4fbieikuth2lrl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmQX/j0ACgkQQ96R+SSa
cUV8DQ//TQSS+B32sjEFR5WtQKDvogX+qctvjlzUGW9tQlmhoiA/jGbppC7lzd+e
AG+urSCcw2+VG/kfaI4K4DDAvTeRdpGJiQT4VtYczN2pQab7sg1Did69UOIUDaSL
UKZVbalrwofC/VBgimirF3/SpRQrVT3LspUydB3FFmxGRwswAcTNsx/yZ7/Q/wlY
r+LkC4l0iasKre5y1rVGYMIdpOYoXi+tIKjF/T/3QflyRk44DtUBQYALcPPK/Qpn
4w1WY4eUz/XRrFk3bgGR8moAxaZjSrDv6mK1g+8BuOeyJ+k2Tw1E4LAmht2nIOwh
kqrxBVukkfWqxgxZI24YQZGb15tcMgb58DatFjPOQzOezMt+FkDZx/yYGt4lyQcQ
7TGrXIyM0u5OauTD8UPUpa6FYUTf0vwyARxeT8XmuX0tIWNEtmTM6zacLXnx+Zzm
8eVeVlpdq0rzZvgGEsTOLJzlc94ylVzgl8WeN8XU4ldkWFKPaEY3KwCKbg8GI+7J
r2HXza9YX6g7sJpiMyONAzZ4ZK4aIchmsQtSh4a56ZxbQb6NEfmpBXj3d4JC1n6M
8FNMR+Wcz7FQmDBxqULNyRgb6YLa3ZVVGVsVRFjiaR/j34IYO8BYIZCWvw0DnsjX
/2JXWom922THeEszn/ZqQDPx8e/MlWa5QMCYeB/qs6Bhidj370Q=
=2ZlC
-----END PGP SIGNATURE-----

--zu4fbieikuth2lrl--
