Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B6475026A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjGLJFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbjGLJFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:05:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB51F26A1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 02:03:49 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qJVl1-0003ZK-Hv; Wed, 12 Jul 2023 11:03:35 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id D6AF41EE5D7;
        Wed, 12 Jul 2023 09:03:32 +0000 (UTC)
Date:   Wed, 12 Jul 2023 11:03:32 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] can: xilinx_can: Add support for controller reset
Message-ID: <20230712-recliner-subtly-196dece73001-mkl@pengutronix.de>
References: <cover.1689084227.git.michal.simek@amd.com>
 <a913de6c4099a1d3408a3973f637446b50c5dee4.1689084227.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t5miqgvjtmuko355"
Content-Disposition: inline
In-Reply-To: <a913de6c4099a1d3408a3973f637446b50c5dee4.1689084227.git.michal.simek@amd.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t5miqgvjtmuko355
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11.07.2023 16:03:55, Michal Simek wrote:
> From: Srinivas Neeli <srinivas.neeli@amd.com>
>=20
> Add support for an optional reset for the CAN controller using the reset
> driver. If the CAN node contains the "resets" property, then this logic
> will perform CAN controller reset.
>=20
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>=20
>  drivers/net/can/xilinx_can.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
> index 4d3283db3a13..929e00061898 100644
> --- a/drivers/net/can/xilinx_can.c
> +++ b/drivers/net/can/xilinx_can.c
> @@ -30,6 +30,7 @@
>  #include <linux/can/error.h>
>  #include <linux/phy/phy.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/reset.h>
> =20
>  #define DRIVER_NAME	"xilinx_can"
> =20
> @@ -200,6 +201,7 @@ struct xcan_devtype_data {
>   * @can_clk:			Pointer to struct clk
>   * @devtype:			Device type specific constants
>   * @transceiver:		Optional pointer to associated CAN transceiver
> + * @rstc:			Pointer to reset control
>   */
>  struct xcan_priv {
>  	struct can_priv can;
> @@ -218,6 +220,7 @@ struct xcan_priv {
>  	struct clk *can_clk;
>  	struct xcan_devtype_data devtype;
>  	struct phy *transceiver;
> +	struct reset_control *rstc;
>  };
> =20
>  /* CAN Bittiming constants as per Xilinx CAN specs */
> @@ -1799,6 +1802,16 @@ static int xcan_probe(struct platform_device *pdev)
>  	priv->can.do_get_berr_counter =3D xcan_get_berr_counter;
>  	priv->can.ctrlmode_supported =3D CAN_CTRLMODE_LOOPBACK |
>  					CAN_CTRLMODE_BERR_REPORTING;
> +	priv->rstc =3D devm_reset_control_get_optional_exclusive(&pdev->dev, NU=
LL);
> +	if (IS_ERR(priv->rstc)) {
> +		dev_err(&pdev->dev, "Cannot get CAN reset.\n");
> +		ret =3D PTR_ERR(priv->rstc);
> +		goto err_free;
> +	}
> +
> +	ret =3D reset_control_reset(priv->rstc);
> +	if (ret)
> +		goto err_free;
> =20
>  	if (devtype->cantype =3D=3D XAXI_CANFD) {
>  		priv->can.data_bittiming_const =3D
> @@ -1827,7 +1840,7 @@ static int xcan_probe(struct platform_device *pdev)
>  	/* Get IRQ for the device */
>  	ret =3D platform_get_irq(pdev, 0);
>  	if (ret < 0)
> -		goto err_free;
> +		goto err_reset;
> =20
>  	ndev->irq =3D ret;
> =20
> @@ -1843,21 +1856,21 @@ static int xcan_probe(struct platform_device *pde=
v)
>  	if (IS_ERR(priv->can_clk)) {
>  		ret =3D dev_err_probe(&pdev->dev, PTR_ERR(priv->can_clk),
>  				    "device clock not found\n");
> -		goto err_free;
> +		goto err_reset;
>  	}
> =20
>  	priv->bus_clk =3D devm_clk_get(&pdev->dev, devtype->bus_clk_name);
>  	if (IS_ERR(priv->bus_clk)) {
>  		ret =3D dev_err_probe(&pdev->dev, PTR_ERR(priv->bus_clk),
>  				    "bus clock not found\n");
> -		goto err_free;
> +		goto err_reset;
>  	}
> =20
>  	transceiver =3D devm_phy_optional_get(&pdev->dev, NULL);
>  	if (IS_ERR(transceiver)) {
>  		ret =3D PTR_ERR(transceiver);
>  		dev_err_probe(&pdev->dev, ret, "failed to get phy\n");
> -		goto err_free;
> +		goto err_reset;
>  	}
>  	priv->transceiver =3D transceiver;
> =20
> @@ -1904,6 +1917,8 @@ static int xcan_probe(struct platform_device *pdev)
>  err_disableclks:
>  	pm_runtime_put(priv->dev);
>  	pm_runtime_disable(&pdev->dev);
> +err_reset:
> +	reset_control_assert(priv->rstc);
>  err_free:
>  	free_candev(ndev);
>  err:
> @@ -1920,10 +1935,12 @@ static int xcan_probe(struct platform_device *pde=
v)
>  static void xcan_remove(struct platform_device *pdev)
>  {
>  	struct net_device *ndev =3D platform_get_drvdata(pdev);
> +	struct xcan_priv *priv =3D netdev_priv(ndev);
> =20
>  	unregister_candev(ndev);
>  	pm_runtime_disable(&pdev->dev);
>  	free_candev(ndev);
> +	reset_control_assert(priv->rstc);

Nitpick: Can you make this symmetric with respect to the error handling
in xcan_probe()?

Oh - that's not a cosmetic issue, it's a use-after-free. free_candev()
frees your priv.

>  }
> =20
>  static struct platform_driver xcan_driver =3D {
> --=20
> 2.36.1
>=20
>

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--t5miqgvjtmuko355
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmSubF8ACgkQvlAcSiqK
BOhacAf+PxVDSySlZHv7eQtQBdt1l/9E2XzOP6qMS2eQpLWrbNO26uizX8nO1rPT
fwAa0Gw7UoAO89GcLlh+kr4t24o6S6Cz4nY6X0eBi8EIpEyMcOyiVvi9zNt3mA/S
RqnsymO5L+LieNQ2Bemo/yD+vxSFWnWOa2CYXFTR0ABzu2iceLKGe15SBobaoyEv
138O+oyhWv6rYbgsx/K+a1woCXKiM9ByY0AV579xemEksdDBEAxq1DOKEd2gOjg3
Az9/wTg68sFWfJoyh07+2kK/+i6WO42qsJRk4EKVKqBqD9dnKsNHF/MZmxHkDUSn
X8zg50vZ2Zz5R7qAlcGjDeSuglyZ/w==
=I9WH
-----END PGP SIGNATURE-----

--t5miqgvjtmuko355--
