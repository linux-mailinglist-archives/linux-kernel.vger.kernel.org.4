Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C4F6F681E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjEDJPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEDJPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:15:46 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADB54205;
        Thu,  4 May 2023 02:15:05 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-94f3cd32799so41330466b.0;
        Thu, 04 May 2023 02:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683191704; x=1685783704;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wjpkeqWA8qYkH/PiK7uN0tzwP/v0iiItnDke/o/lc0=;
        b=RkjTlxcCgLCrvnMQ3Fft+HOe6jICiNy9KuA9Q//Xj5CWoU4WUjbkoqqTVuZuISgct0
         WHvPd+1GujTO88D28NFvhFzw/dKEHL5S5kyaTN3UXRVKUrjErLueJCKPad0VSfkiHDkK
         AZdtMIqTXHpAxFnUMyaNW0dFSJXuq/IJ9MJXIQgh3d9Brd5u6PYuyE9WDVVyu1e9bqBz
         xA2rwHY7oHnF25y/pkP2SjY9kTCsLZRZbYNKntpDDJeoqmsf6TGLySC4HPrCIZ6muukZ
         eM6uPwSSb5i+RllMYtTsMbK74wB61vEd+J+I/e1h4pkbkly6Pl/qsqRQxPULPStCZsn9
         gBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683191704; x=1685783704;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wjpkeqWA8qYkH/PiK7uN0tzwP/v0iiItnDke/o/lc0=;
        b=andZPfhH/sOOgxykdnhADjf1JqOlPtH6aL2ehUSssBVlNvJxdKp7XvXIp7mpyN5hzJ
         z8807pii/4eTNa0xj0dfz41lj9pvipbJ76VJgd52GuHOb6xrbopUI1Ctc/dOYjPldYgm
         oWqieOINSoO4QVeeO1cCbStopBHN7ACGFZTAbtU0+8ayqjA5xMCTv79wAg5sjXu/FRLr
         2rtvCAm6VXpwjOd+CviEokgpiQGRQ85jfej6yC5vPtCwYpR5g21aDluOuqHWBF4Bk9Zd
         0wDLpCGZ7M1guDhyImkCeMl4Xcp2g5q2tY/d84vMU8h2pYg8F/Z8D/PziadvuhrUcKpe
         11Wg==
X-Gm-Message-State: AC+VfDyjYTl6PmXFZE8f8jHpU0LSF/O4igOxiBBbyNPbAhuhs+2b+LPc
        Is4QnUZMTYelCy4UdCbIPDQ=
X-Google-Smtp-Source: ACHHUZ5o55IayVtrIHn8dSW7K3bSDwy0IWuVh6ib7LF1yUwMiZCjhVrRS3CCIkllKSErOzD4pjP0dA==
X-Received: by 2002:a17:906:eec7:b0:93e:fa12:aa1a with SMTP id wu7-20020a170906eec700b0093efa12aa1amr5473971ejb.1.1683191704054;
        Thu, 04 May 2023 02:15:04 -0700 (PDT)
Received: from orome (p200300e41f053a00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f05:3a00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id g10-20020a170906594a00b008cecb8f374asm18338172ejr.0.2023.05.04.02.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 02:15:03 -0700 (PDT)
Date:   Thu, 4 May 2023 11:15:02 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Haotien Hsu <haotienh@nvidia.com>
Cc:     JC Kuo <jckuo@nvidia.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wayne Chang <waynec@nvidia.com>,
        EJ Hsu <ejh@nvidia.com>
Subject: Re: [PATCH] phy: tegra: xusb: Fix use-after-free issue
Message-ID: <ZFN3lvjjn9Xu-vRl@orome>
References: <20230504055446.2039372-1-haotienh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5P7ThJ8lckK4aSHF"
Content-Disposition: inline
In-Reply-To: <20230504055446.2039372-1-haotienh@nvidia.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5P7ThJ8lckK4aSHF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2023 at 01:54:46PM +0800, Haotien Hsu wrote:
> From: EJ Hsu <ejh@nvidia.com>
>=20
> For the dual-role port, it will assign the phy dev to usb-phy dev and
> use the port dev driver as the dev driver of usb-phy.
>=20
> When we try to destroy the port dev, it will destroy its dev driver
> as well. But we did not remove the reference from usb-phy dev. This
> might cause the use-after-free issue in KASAN.
>=20
> Fixes: e8f7d2f409a1 ("phy: tegra: xusb: Add usb-phy support")
> Cc: stable@vger.kernel.org
>=20
> Signed-off-by: EJ Hsu <ejh@nvidia.com>
> Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
> ---
>  drivers/phy/tegra/xusb.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> index 78045bd6c214..515298a9a433 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -563,13 +563,6 @@ static int tegra_xusb_port_init(struct tegra_xusb_po=
rt *port,
> =20
>  static void tegra_xusb_port_unregister(struct tegra_xusb_port *port)
>  {
> -	if (!IS_ERR_OR_NULL(port->usb_role_sw)) {
> -		of_platform_depopulate(&port->dev);
> -		usb_role_switch_unregister(port->usb_role_sw);
> -		cancel_work_sync(&port->usb_phy_work);
> -		usb_remove_phy(&port->usb_phy);
> -	}
> -
>  	if (port->ops->remove)
>  		port->ops->remove(port);
> =20
> @@ -832,6 +825,14 @@ void tegra_xusb_usb2_port_remove(struct tegra_xusb_p=
ort *port)
>  {
>  	struct tegra_xusb_usb2_port *usb2 =3D to_usb2_port(port);
> =20
> +	if (!IS_ERR_OR_NULL(port->usb_role_sw)) {
> +		of_platform_depopulate(&port->dev);
> +		usb_role_switch_unregister(port->usb_role_sw);
> +		cancel_work_sync(&port->usb_phy_work);
> +		usb_remove_phy(&port->usb_phy);
> +		port->usb_phy.dev->driver =3D NULL;
> +	}
> +

It's a bit difficult to tell what exactly changed because of the
additional move. The move looks correct because this is only valid for
USB2 ports, but I think it'd be easier to review if the move was done
prior to the addition of the ->driver clearing. Or perhaps a mention in
the commit message would be nice.

It's obviously up to Vinod and Kishon if they want to see this
clarified. Either way is fine with me, so:

Acked-by: Thierry Reding <treding@nvidia.com>

--5P7ThJ8lckK4aSHF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmRTd5UACgkQ3SOs138+
s6Gt1Q/9EXhGAYP6JtZG9p/vcDxGeCROBCWGKFaLA5L1NvL+nJbZT9DmodB45UDH
cEUZPd6fdH6CYvZuM3B+khQvS2yOIvLtBt2WaGs8fp6yINmR0fKsKbWqjqglbrOH
jZJcpzzz8xjkZ3XvNAXB+qpkBEEzGqTeMz35GRMeDhI6xczHG3k6anhaecI+Gys4
H8gg7mjVMbiSDSXigfSw080yL7Y+42s8U8YHh9Q20Gszfk/hcI6qs0fUrZXpBy5K
1wHdrqtoPU7jWn6PF7L/LrFcbcomlPiKiSiB5hhmAj+l7EbQnmXXrtO9A84inZuE
+V8ylo/jEpxgnTtNYOaQuB5t/BhoZl7MARgJ4C1lMrRODlJtEK9JWqU4sBtz2K3o
RwnMaGeXq+3GB5kK5wK2+/H6jVLCoyKogm9csmcxpcptIO6EIWlM0EaqztwZNP8V
lD3UcG7bzrW7DyOJETnw04AjteQ7gsgzm2kNWcrQORCLmfM13yKsTHvsUTfOW6ie
mY+vFqnjlbslAJnrYEgRMG7KfJAWjVuqWN5NsBCaGChh/9+FiHU2joIZTt/n3SOw
GtXzPIe7gMJnkicq5VvwRvUskHrztivJEN5nDmx0Zm2sZrUX5gdgQhZ78uyOgM5t
FgPndVJbPSW8Mgj4R/maEpnK40UH+7hegbbQBT38l9X1NFucPss=
=1FBR
-----END PGP SIGNATURE-----

--5P7ThJ8lckK4aSHF--
