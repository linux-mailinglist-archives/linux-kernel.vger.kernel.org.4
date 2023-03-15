Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603026BB3EE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjCONIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjCONIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:08:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C549F7C3EF;
        Wed, 15 Mar 2023 06:08:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 293FE61D5F;
        Wed, 15 Mar 2023 13:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBE2C433D2;
        Wed, 15 Mar 2023 13:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678885686;
        bh=ahnyU6khLIrLfE27kDoS3JLqJu42CyF8cY/A5JRVX6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GjFwpQfazRPGkPim50d40D4kK3O5UHdL8AU2KwkCjsCiZpVFFOjgis4y4KVZ8x7mP
         aoupG/zkCYeJwf6A7oZs2JSTUpOCtEUZ0ciNjFEmzOyg6PWiwU2tsoLqOKFpcz+zqz
         TEPjGHGOpDE1yRN/XedWbzhY6ldaWWq8NJoXS/ez3yqhgCTq2ntD69rEyviqARIxpa
         TCYyXJWbC+wnsXZBXHgoUKTjhlLJTALj6tv3MMcGuar0/29W8c4sN7D8kV67/hvKUn
         AMe99rb1yt3kU7Uxv8py8ytSHgPvOEQc/EmfwGxxYVKkvOKS0gawIhDHbWJ+jtZ1DY
         2MqKBGyAMV6yQ==
Received: by mercury (Postfix, from userid 1000)
        id A1D8B1061C80; Wed, 15 Mar 2023 14:08:03 +0100 (CET)
Date:   Wed, 15 Mar 2023 14:08:03 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCHv2 10/12] power: supply: generic-adc-battery: add
 temperature support
Message-ID: <20230315130803.aold4bo7x27x3hza@mercury.elektranox.org>
References: <20230314225535.1321736-1-sre@kernel.org>
 <20230314225535.1321736-11-sre@kernel.org>
 <CACRpkdZ0j8HQzzXtDbVcxAJkBsdRXUKNJm3BmLB583JfnetAWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hiy7k232xoaf3bj7"
Content-Disposition: inline
In-Reply-To: <CACRpkdZ0j8HQzzXtDbVcxAJkBsdRXUKNJm3BmLB583JfnetAWw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hiy7k232xoaf3bj7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Wed, Mar 15, 2023 at 09:04:15AM +0100, Linus Walleij wrote:
> On Tue, Mar 14, 2023 at 11:55=E2=80=AFPM Sebastian Reichel <sre@kernel.or=
g> wrote:
> > From: Sebastian Reichel <sebastian.reichel@collabora.com>
> > Another typical thing to monitor via an ADC line is
> > the battery temperature.
> >
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> >  static bool gab_charge_finished(struct gab *adc_bat)
> > @@ -115,6 +118,8 @@ static int gab_get_property(struct power_supply *ps=
y,
> >                 return read_channel(adc_bat, GAB_CURRENT, &val->intval);
> >         case POWER_SUPPLY_PROP_POWER_NOW:
> >                 return read_channel(adc_bat, GAB_POWER, &val->intval);
> > +       case POWER_SUPPLY_PROP_TEMP:
> > +               return read_channel(adc_bat, GAB_TEMP, &val->intval);
>=20
> Hm. I wonder if these should rather all use read_channel_processed()?
>=20
> The difference is that you will then support ADCs with internal scaling
> which is beneficial. Most of the time it doesn't matter.

read_channel is a local helper, the driver uses the processed
variant of iio_read_channel:

static int read_channel(struct gab *adc_bat, enum gab_chan_type channel,
                int *result)
{
        int ret;

        ret =3D iio_read_channel_processed(adc_bat->channel[channel], resul=
t);
        if (ret < 0)
                pr_err("read channel error\n");
        else
                *result *=3D 1000;

        return ret;
} =20

-- Sebastian

--hiy7k232xoaf3bj7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQRwygACgkQ2O7X88g7
+posVQ/9EN49adbU7MGa07ofbn9QEThOKKK7sZpl+dk5sebGmmgklHLBifQpAsFV
L54r2G3VeKr7OHlEReVM3hqBWSgLizSoJuA4mc3T3SR8eOlH4MfVHJcw0sGh5dmN
7x+K8xiU0dxPgPXy1YCs3qKRIaGceTWUdO7N/kcGkef2PUNmtPB2+tSREpwtw2A7
zCRZNDwb7mw6OohlK9cueMim1daE2nnDukAXPmgON6Tazm/TB4ugVZHDUrpv3cPM
pVYc71yrO3ZiQ1fW5VI/xsNoY7CJDDWkNeaE7LD3vm6icnhvSQLTD8p1d4uOzjCm
z+fF8IqyuoaiUogE0QcGjeGqd/4nXUJSuxHf5NYplMdOwgQiso4gxqb4AMsu5SeL
Pft2dz8kBcnTetCoNHi0aRJxSRF+V5zrXDGexKs+MIJ6qFw1xNnfs0JsrR7FTpg/
CgfAF8s5CAvoh795kDROwVb+lMNt0dzm5mbP6Ka60ECtLRKpr0odhhW3I50uvO1t
N9IghkXuVOgKDwhd0UFhiJGBLcorpyhLpPE4ZxfrWZq11hZS0au9TuYPZsudx88N
4ZSzK+l3RQrPPhlDgJv3S2WMaVXp1XK9rwj2YQyf0jwu/3aPrtuvIyZ+s3ag76p2
tGnTiVEn+2C4fKcSP68Dlt8AtzCK86lYpuim6fgB/KvdjRY33Lw=
=1aSX
-----END PGP SIGNATURE-----

--hiy7k232xoaf3bj7--
