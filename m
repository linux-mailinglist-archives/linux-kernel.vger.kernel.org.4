Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8EB6D8396
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjDEQXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDEQX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:23:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96515FE4
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 09:23:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7724D62342
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 16:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C20CC433D2;
        Wed,  5 Apr 2023 16:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680711790;
        bh=6Q7pGHxMzjCLRVHDYtbXVIvn5MoQAh0S7nQOHbo/tXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WZ9OyO4BWc32SsQSII0HxnLgkra2KJ07Y6PwrpUCt8vle+BYJA7esSuIY5vNm6eRN
         MfyThUgU8sQlTrtam6PVK1DS5yvirJCgg56FaisaPG9tiFvwm4t2OKZSyVFC/VTMjW
         jqmb0dNF3NAO6EOI3ph/L+0wEOyJCeKP9e84sWOa516a5gzKgBMWHlEVTuO3Z2+5ms
         6ZyxuNf21A+hd7eQxPVPKwqRs5eojRcghY4Y1BfxXtOWzjpX9lVLVuZ0ArsqsqIe7g
         aolsRNrhmdRHckjMvl9O5JT2snA7rs5+4SifuW4rPp5Ix9h6/NDg3wtGbHJA1Ape4C
         KD4nufWB1Z4fA==
Received: by mercury (Postfix, from userid 1000)
        id D0699106125E; Wed,  5 Apr 2023 18:23:07 +0200 (CEST)
Date:   Wed, 5 Apr 2023 18:23:07 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Wolfram Sang <wsa@kernel.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 08/40] of: Rename of_modalias_node()
Message-ID: <20230405162307.s3fifzndgexifml6@mercury.elektranox.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
 <20230404172148.82422-9-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ytn4euqe7tt6ivbg"
Content-Disposition: inline
In-Reply-To: <20230404172148.82422-9-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ytn4euqe7tt6ivbg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 04, 2023 at 06:21:16PM +0100, Srinivas Kandagatla wrote:
> From: Miquel Raynal <miquel.raynal@bootlin.com>
>=20
> This helper does not produce a real modalias, but tries to get the
> "product" compatible part of the "vendor,product" compatibles only. It
> is far from creating a purely useful modalias string and does not seem
> to be used like that directly anyway, so let's try to give this helper a
> more meaningful name before moving there a real modalias helper (already
> existing under of/device.c).
>=20
> Also update the various documentations to refer to the strings as
> "aliases" rather than "modaliases" which has a real meaning in the Linux
> kernel.
>=20
> There is no functional change.
>=20
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Wolfram Sang <wsa@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Mark Brown <broonie@kernel.org>

Acked-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/acpi/bus.c                |  7 ++++---
>  drivers/gpu/drm/drm_mipi_dsi.c    |  2 +-
>  drivers/hsi/hsi_core.c            |  2 +-
>  drivers/i2c/busses/i2c-powermac.c |  2 +-
>  drivers/i2c/i2c-core-of.c         |  2 +-
>  drivers/of/base.c                 | 18 +++++++++++-------
>  drivers/spi/spi.c                 |  4 ++--
>  include/linux/of.h                |  3 ++-
>  8 files changed, 23 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 9531dd0fef50..fc74c786a867 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -817,9 +817,10 @@ static bool acpi_of_modalias(struct acpi_device *ade=
v,
>   * @modalias:   Pointer to buffer that modalias value will be copied into
>   * @len:	Length of modalias buffer
>   *
> - * This is a counterpart of of_modalias_node() for struct acpi_device ob=
jects.
> - * If there is a compatible string for @adev, it will be copied to @moda=
lias
> - * with the vendor prefix stripped; otherwise, @default_id will be used.
> + * This is a counterpart of of_alias_from_compatible() for struct acpi_d=
evice
> + * objects. If there is a compatible string for @adev, it will be copied=
 to
> + * @modalias with the vendor prefix stripped; otherwise, @default_id wil=
l be
> + * used.
>   */
>  void acpi_set_modalias(struct acpi_device *adev, const char *default_id,
>  		       char *modalias, size_t len)
> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_ds=
i.c
> index b41aaf2bb9f1..b62f5e4425f4 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> @@ -160,7 +160,7 @@ of_mipi_dsi_device_add(struct mipi_dsi_host *host, st=
ruct device_node *node)
>  	int ret;
>  	u32 reg;
> =20
> -	if (of_modalias_node(node, info.type, sizeof(info.type)) < 0) {
> +	if (of_alias_from_compatible(node, info.type, sizeof(info.type)) < 0) {
>  		drm_err(host, "modalias failure on %pOF\n", node);
>  		return ERR_PTR(-EINVAL);
>  	}
> diff --git a/drivers/hsi/hsi_core.c b/drivers/hsi/hsi_core.c
> index 8fda8f1d064d..acbf82f755a8 100644
> --- a/drivers/hsi/hsi_core.c
> +++ b/drivers/hsi/hsi_core.c
> @@ -207,7 +207,7 @@ static void hsi_add_client_from_dt(struct hsi_port *p=
ort,
>  	if (!cl)
>  		return;
> =20
> -	err =3D of_modalias_node(client, name, sizeof(name));
> +	err =3D of_alias_from_compatible(client, name, sizeof(name));
>  	if (err)
>  		goto err;
> =20
> diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-p=
owermac.c
> index 2e74747eec9c..ec706a3aba26 100644
> --- a/drivers/i2c/busses/i2c-powermac.c
> +++ b/drivers/i2c/busses/i2c-powermac.c
> @@ -284,7 +284,7 @@ static bool i2c_powermac_get_type(struct i2c_adapter =
*adap,
>  	 */
> =20
>  	/* First try proper modalias */
> -	if (of_modalias_node(node, tmp, sizeof(tmp)) >=3D 0) {
> +	if (of_alias_from_compatible(node, tmp, sizeof(tmp)) >=3D 0) {
>  		snprintf(type, type_size, "MAC,%s", tmp);
>  		return true;
>  	}
> diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
> index bce6b796e04c..8941a30574e3 100644
> --- a/drivers/i2c/i2c-core-of.c
> +++ b/drivers/i2c/i2c-core-of.c
> @@ -27,7 +27,7 @@ int of_i2c_get_board_info(struct device *dev, struct de=
vice_node *node,
> =20
>  	memset(info, 0, sizeof(*info));
> =20
> -	if (of_modalias_node(node, info->type, sizeof(info->type)) < 0) {
> +	if (of_alias_from_compatible(node, info->type, sizeof(info->type)) < 0)=
 {
>  		dev_err(dev, "of_i2c: modalias failure on %pOF\n", node);
>  		return -EINVAL;
>  	}
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index ac6fde53342f..161fe3192c46 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -1208,19 +1208,23 @@ struct device_node *of_find_matching_node_and_mat=
ch(struct device_node *from,
>  EXPORT_SYMBOL(of_find_matching_node_and_match);
> =20
>  /**
> - * of_modalias_node - Lookup appropriate modalias for a device node
> + * of_alias_from_compatible - Lookup appropriate alias for a device node
> + *			      depending on compatible
>   * @node:	pointer to a device tree node
> - * @modalias:	Pointer to buffer that modalias value will be copied into
> - * @len:	Length of modalias value
> + * @alias:	Pointer to buffer that alias value will be copied into
> + * @len:	Length of alias value
>   *
>   * Based on the value of the compatible property, this routine will atte=
mpt
> - * to choose an appropriate modalias value for a particular device tree =
node.
> + * to choose an appropriate alias value for a particular device tree nod=
e.
>   * It does this by stripping the manufacturer prefix (as delimited by a =
',')
>   * from the first entry in the compatible list property.
>   *
> + * Note: The matching on just the "product" side of the compatible is a =
relic
> + * from I2C and SPI. Please do not add any new user.
> + *
>   * Return: This routine returns 0 on success, <0 on failure.
>   */
> -int of_modalias_node(struct device_node *node, char *modalias, int len)
> +int of_alias_from_compatible(const struct device_node *node, char *alias=
, int len)
>  {
>  	const char *compatible, *p;
>  	int cplen;
> @@ -1229,10 +1233,10 @@ int of_modalias_node(struct device_node *node, ch=
ar *modalias, int len)
>  	if (!compatible || strlen(compatible) > cplen)
>  		return -ENODEV;
>  	p =3D strchr(compatible, ',');
> -	strscpy(modalias, p ? p + 1 : compatible, len);
> +	strscpy(alias, p ? p + 1 : compatible, len);
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(of_modalias_node);
> +EXPORT_SYMBOL_GPL(of_alias_from_compatible);
> =20
>  /**
>   * of_find_node_by_phandle - Find a node given a phandle
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 44b85a8d47f1..3bbdc5fe3b99 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2354,8 +2354,8 @@ of_register_spi_device(struct spi_controller *ctlr,=
 struct device_node *nc)
>  	}
> =20
>  	/* Select device driver */
> -	rc =3D of_modalias_node(nc, spi->modalias,
> -				sizeof(spi->modalias));
> +	rc =3D of_alias_from_compatible(nc, spi->modalias,
> +				      sizeof(spi->modalias));
>  	if (rc < 0) {
>  		dev_err(&ctlr->dev, "cannot find modalias for %pOF\n", nc);
>  		goto err_out;
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 0af611307db2..b1eea8569043 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -373,7 +373,8 @@ extern int of_n_addr_cells(struct device_node *np);
>  extern int of_n_size_cells(struct device_node *np);
>  extern const struct of_device_id *of_match_node(
>  	const struct of_device_id *matches, const struct device_node *node);
> -extern int of_modalias_node(struct device_node *node, char *modalias, in=
t len);
> +extern int of_alias_from_compatible(const struct device_node *node, char=
 *alias,
> +				    int len);
>  extern void of_print_phandle_args(const char *msg, const struct of_phand=
le_args *args);
>  extern int __of_parse_phandle_with_args(const struct device_node *np,
>  	const char *list_name, const char *cells_name, int cell_count,
> --=20
> 2.25.1
>=20

--ytn4euqe7tt6ivbg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQtoF8ACgkQ2O7X88g7
+poj2xAAh2lKLW3nwfpi4KI0TQviuUo5pkoavm2f8EiZN/snu+wdqdIU1/KVphFQ
rbl5lgTyYL1LXMLktNgD/YiopQnSk79D+Ez3iz8+VjnvG7WNtv49c1NFXDRCi8md
4Oyv97hQBr/Sp1p6/ZJy7UcrylR9XIvDN91tifnJwvFDub846Or/iCLOh4l+CCcD
faS4cYk6ffjWAmtPIi1YtPwcXGRGeWRRJWGUUORpP31LRpW/DLWuhUWJdkeztZXo
lsUegQAFjZ5wIxGc0oaj8qhevRdXktqQBEyZRY21xeRNVnA1tKQ2E4UyOaYd0he5
PQXjjNMqwSBBMs9Mc7Cqrz41qAe8CYZJ4gRauP5Btzalnrpi7LqJexWSkNIBAH5i
n1QNuBExEWAN4+OHPYRgkVzpbMKjtqrCRKPsLjZY/Qcs+K6TBdyYwWVNnZe9LCfT
KNF/RZ3kOr1cNwa/SPidzWSNrpdHhGBF2GkvDKZuCm3N+MKceFnhEXIRXOZ9L7Mg
YimU+9OXxYAmBbnINrVOTP9A8emSsuxZ2x69d9C5re8uAVPXk77RKzwXGzYlKiCt
mhmLyvmZ0gqozPnNeajYZ6BTpuqaxOQ+Wn80w63bMsaIhSGCzozQgyweSygKC+zU
61K3cvJg5oO3Y3OnX8Z3G/y1CBw20P4uREWnk0Ih/HYhPiLWONc=
=mch6
-----END PGP SIGNATURE-----

--ytn4euqe7tt6ivbg--
