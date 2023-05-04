Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E086F6D01
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 15:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjEDNjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 09:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjEDNjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 09:39:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316706E95
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 06:39:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C11B5633D0
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 13:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDB6C433EF;
        Thu,  4 May 2023 13:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683207547;
        bh=EBCeEkKBKZh7TzZoU15KoO4iQvBZ3RDH7HkzJ/gpjuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C0hrSeXBWPbpxIfnIVlhJFqbN7odAPY/ldY/Ly8L0RiLUEszWgTjNkB/fJKZNJr3O
         AhA4TbzapWLDYNpIjBa6eqgODB4CEqkMBRJF+ik9bHAGCE5yKmauxlIeK8xdFS7bHp
         yVgJBLbmyGV9uH1iObYbCj8X4L2cg5CFRq9RdIh1yilRbfQ9ZunX/6IHFniHneewea
         eNJx7Tj9V25rczVEwz0nzqdv/x36ZmZptWkKLZBbYMWa3ATlm2QDaU7hVnCs7IpixW
         XAzf0gyc9vQonWJRL7XG6PnzBMsUiyBD011fDXPUW4DufRQeVLDtL//JLOgd6Qw/ii
         lvPfoYvPgXlOg==
Date:   Thu, 4 May 2023 22:39:04 +0900
From:   Mark Brown <broonie@kernel.org>
To:     David Rau <David.Rau.opensource@dm.renesas.com>
Cc:     support.opensource@diasemi.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: da7219: Add Jack insertion detection polarity
 selection
Message-ID: <ZFO1eLaz11iLo1Td@finisterre.sirena.org.uk>
References: <20230504082218.24059-1-David.Rau.opensource@dm.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RTvU0e3/Lk+teMVd"
Content-Disposition: inline
In-Reply-To: <20230504082218.24059-1-David.Rau.opensource@dm.renesas.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RTvU0e3/Lk+teMVd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2023 at 08:22:18AM +0000, David Rau wrote:

> +choice
> +	bool "DA7219 Jack insertion detection polarity selection"
> +	default DA7219_DEFAULT_JACK_INSERTION_POLARITY if (SND_SOC_DA7219)
> +
> +config DA7219_DEFAULT_JACK_INSERTION_POLARITY
> +    bool "Default polarity"
> +	depends on SND_SOC_DA7219
> +    help
> +	  Select this option if your DA7219 codec with default Jack insertion d=
etection polarity (Low).
> +
> +config DA7219_INVERTED_JACK_INSERTION_POLARITY
> +    bool "Inverted polarity"
> +	depends on SND_SOC_DA7219
> +    help
> +	  Select this option if your DA7219 codec with inverted Jack insertion =
detection polarity (High).

I would expect these things to be fixed for a given board and therefore
configured with a DT property rather than a kernel config.  It should be
possible to use the same kernel on multiple boards.

> +
> +endchoice
> +
> +endif # SND_SOC_DA7219
> +
>  config SND_SOC_DA732X
>  	tristate
>  	depends on I2C
> diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
> index 993a0d00bc48..9d16112cff6b 100644
> --- a/sound/soc/codecs/da7219-aad.c
> +++ b/sound/soc/codecs/da7219-aad.c
> @@ -879,6 +879,18 @@ static void da7219_aad_handle_gnd_switch_time(struct=
 snd_soc_component *componen
>  	}
>  }
> =20
> +static void da7219_aad_handle_polarity(struct snd_soc_component *compone=
nt)
> +{
> +	snd_soc_component_write(component, 0xF0, 0x8B);
> +
> +	if (IS_ENABLED(CONFIG_DA7219_DEFAULT_JACK_INSERTION_POLARITY))
> +		snd_soc_component_write(component, 0x75, 0x80);
> +	else if (IS_ENABLED(CONFIG_DA7219_INVERTED_JACK_INSERTION_POLARITY))
> +		snd_soc_component_write(component, 0x75, 0x00);
> +
> +	snd_soc_component_write(component, 0xF0, 0x00);
> +}
> +
>  /*
>   * Suspend/Resume
>   */
> @@ -955,8 +967,12 @@ int da7219_aad_init(struct snd_soc_component *compon=
ent)
>  	snd_soc_component_update_bits(component, DA7219_ACCDET_CONFIG_1,
>  			    DA7219_BUTTON_CONFIG_MASK, 0);
> =20
> +	/* Handle the default ground switch delay time */
>  	da7219_aad_handle_gnd_switch_time(component);
> =20
> +	/* Handle the Jack insertion detection polarity */
> +	da7219_aad_handle_polarity(component);
> +
>  	da7219_aad->aad_wq =3D create_singlethread_workqueue("da7219-aad");
>  	if (!da7219_aad->aad_wq) {
>  		dev_err(component->dev, "Failed to create aad workqueue\n");
> --=20
> 2.17.1
>=20

--RTvU0e3/Lk+teMVd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRTtXcACgkQJNaLcl1U
h9BROAf/R5bC3tWhqt5LiZEGi6Yfu2H9vpKtyvR4cgFX3QyBZJ7HM12S8ZQpU+KJ
6LsYk5SKJnC5IzYu8CjM9ueep1VaCPy8iyMvF9CvtHPs4qVXUI8pcRRv9lbUX5kT
MfvoxcDtfgd4JaYKDQOTj0c9us1Hf0Bhn6M7g7quEMmRB8N9lUMNyeiRK9gg6L8S
kJrOAY8Wr343zHW72bTDZRNs6RQepytulq50yHmGYkRht62Er2Nrl30w6OQ7ubFo
q0WccPcGOND0E2aMUM2/Ci2XEP31S6QXKHHFLDF58BDW8BaYjrfSig6Y+oRLiXhH
0WZArGUQB7GdDW/KQVEIuA6m18KQ5g==
=9rld
-----END PGP SIGNATURE-----

--RTvU0e3/Lk+teMVd--
