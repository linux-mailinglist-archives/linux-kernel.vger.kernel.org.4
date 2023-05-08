Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7776D6FB549
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbjEHQhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbjEHQhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:37:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494E36E8F;
        Mon,  8 May 2023 09:37:35 -0700 (PDT)
Received: from mercury (195-23-45-170.net.novis.pt [195.23.45.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 68ECB66034CF;
        Mon,  8 May 2023 17:37:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683563852;
        bh=uZCfI6nSerksNmlPugy693GyFz8gqLCBRGAQ3defUSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WPuBeeslpqeyX/tYiivm5tjgQrfSuZl+GX5bEtLYBGwLFC0lCi8Z6P3MTH564TMb3
         2q1N6gWhV1FS1xBH+pWruRt2R+zz9oQjNJGc2TyUqiJR4s1SDNVxmnZqrEi52RGlgt
         RIjCRZBxJaXY01kvORkC6czbvyNE9fNYOI39gPq6NIAiE42Z38oHpVE0BDGnb9H4PT
         VVqVgsk/eTK3dQCsXNhBVaMkCVvi4N6ueG2R/cHaYpWJ5kOgCG7nhb4f1+U7GzA9nO
         crONdNx+dWudnZlqMaavNEQrcspKTdFeqZTW8shmB36/giDwhpKdzBih+IFhsYX9+e
         SXIpkEtkKP3jw==
Received: by mercury (Postfix, from userid 1000)
        id F26281066FA2; Mon,  8 May 2023 13:43:23 +0200 (CEST)
Date:   Mon, 8 May 2023 13:43:23 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Grimler <henrik@grimler.se>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v4 6/8] power: supply: rt5033_charger: Add cable
 detection and USB OTG supply
Message-ID: <20230508114323.rzqbp2isvczzg3wx@mercury.elektranox.org>
References: <20230506155435.3005-1-jahau@rocketmail.com>
 <20230506155435.3005-7-jahau@rocketmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="is77izww4ugbdpkq"
Content-Disposition: inline
In-Reply-To: <20230506155435.3005-7-jahau@rocketmail.com>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--is77izww4ugbdpkq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, May 06, 2023 at 05:54:33PM +0200, Jakob Hauser wrote:
> Implement cable detection by extcon and handle the driver according to the
> connector type.
>=20
> There are basically three types of action: "set_charging", "set_otg" and
> "set_disconnect".
>=20
> A forth helper function to "unset_otg" was added because this is used in =
both
> "set_charging" and "set_disconnect". In the first case it covers the rath=
er
> rare event that someone changes from OTG to charging without disconnect. =
In
> the second case, when disconnecting, the values are set back to the ones =
=66rom
> initialization to return into a defined state.
>=20
> Additionally, there is "set_mivr". When connecting to e.g. a laptop/PC, t=
he
> minimum input voltage regulation (MIVR) shall prevent a voltage drop if t=
he
> cable or the supply is weak. The MIVR value is set to 4600MV, same as in =
the
> Android driver [1]. When disconnecting, MIVR is set back to DISABLED.
>=20
> In the function rt5033_get_charger_state(): When in OTG mode, the chip
> reports status "charging". Change this to "discharging" because there is
> no charging going on in OTG mode [2].
>=20
> [1] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/d=
rivers/battery/rt5033_charger.c#L499
> [2] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/d=
rivers/battery/rt5033_charger.c#L686-L687
>=20
> Tested-by: Raymond Hackley <raymondhackley@protonmail.com>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---
> [...]
> diff --git a/include/linux/mfd/rt5033.h b/include/linux/mfd/rt5033.h
> index e99e2ab0c1c1..d2c613764756 100644
> --- a/include/linux/mfd/rt5033.h
> +++ b/include/linux/mfd/rt5033.h
> @@ -53,6 +53,14 @@ struct rt5033_charger {
>  	struct rt5033_dev		*rt5033;
>  	struct power_supply		*psy;
>  	struct rt5033_charger_data	*chg;
> +	struct extcon_dev		*edev;
> +	struct notifier_block		extcon_nb;
> +	struct work_struct		extcon_work;
> +	struct mutex			lock;
> +	bool online;
> +	bool otg;
> +	bool mivr_enabled;
> +	u8 cv_regval;
>  };

Please move 'struct rt5033_charger' and 'struct rt5033_charger_data'
to drivers/power/supply/rt5033_charger.c; they are not supposed to
be used directly by others. Making it private helps to avoid
cross-subsystem series for future maintanence patches.

Otherwise LGTM.

-- Sebastian

--is77izww4ugbdpkq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRY4FsACgkQ2O7X88g7
+ppgzhAAiuyrMlrlL+A6FWUNH5NALnLtlzgNOlXErWC5EzseHFk7cDfSIgzoM+eR
Fu6YN08pmniDN2okXmr4L+JRyu/8ALmtrgZRYG9t2juQwLyoyjGj+ZEOMtb1UQPz
Lz9tuAEsCRKv2mwBKl5P3wNewgKS/aqe0xrndg+86Qesb3bLyO5pPhG2UesBU3yv
DE/NdbG5+0aXGrEYnpN58XT4S+ZK717sfFlLTBePHUnA1ANpRXrdgPrv3p4xvp1/
X7EA1FQ4jnZL7AlhGCartvygqrPUpUF0387jPervjYeAbs7emA+Y3ZOYQvyhTCez
fXnLi9ETD9Dhd6/XMmd0Vp3p5aR4EyojAXkIP5kS1iOHni6R9aUuFQi7Kobfy2na
zLKsfKIOpVOlYADWRWB4oEMPAVmdZLZUeMHY1Tl3abJuvwK/yhGDIbPspk/t1UKS
sz41mNz9y16MVPPNEsxRrO/D3G3e2IhNrfuGxRZ0YmzLlRFsULNvSKKhTP2FZ6vT
2z8+hiukyH45uf758funq9mvm2Y0/DPkMLtyEUfnWJk3EJWTRmCUJvGoGMG+wjH9
ChYUNYz2jbKgSXUZkPfxnoxDACUlF2L+YkEdxbtgRKxERqxVQoH6KfcHb46ZbtD6
EggsiR0izVGdq1TE5hIRU/9OhLxb9z4QpeZZ51T+3I4VHYQM6bQ=
=NU/1
-----END PGP SIGNATURE-----

--is77izww4ugbdpkq--
