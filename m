Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBA16412C8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 01:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbiLCAsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 19:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbiLCArb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 19:47:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6AC10CB5B;
        Fri,  2 Dec 2022 16:41:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3AB6B8231D;
        Sat,  3 Dec 2022 00:41:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B944C433D6;
        Sat,  3 Dec 2022 00:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670028065;
        bh=49uG1ca/rYZYkNnxIPSbQoXH4r/nJnDeGH+iQEpi27A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gjx00cGFpN7XHdpxVSWFergPdjsNbZuqYS042BNQPA92GOJSTdU15jRJ195AzB87T
         r8nqcWP6Pe1zkS4K/30LH4+Nc+RiygTgwg8EdPk1DryIoBjPDdsfWxq5diZjv4MuGo
         SUIINsKzSuuI7Z9aPo5N58OJUMMDk9VzOM/Ta7wtO8iADcxg4782i2HJ1xcqv4K1LU
         X4+Dfeb56IOTCCWFcl3ibd3ywbwLZAnmVSumLQ7EZzu+D2ue3O8FEZ4rjOyQwuKrt8
         uVkNYpCmSW6NLM7TKJqCjUy+Um0pX8VPeHaM35U/6875tMZsYJz6pczA6tbFyDFJ4m
         wV/TZRhS3mruQ==
Received: by mercury (Postfix, from userid 1000)
        id 2167D1060E96; Sat,  3 Dec 2022 01:41:02 +0100 (CET)
Date:   Sat, 3 Dec 2022 01:41:02 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] platform/surface: aggregator: Enforce use of
 target-ID enum in device ID macros
Message-ID: <20221203004102.no3qdyhn2iu7cpvx@mercury.elektranox.org>
References: <20221202223327.690880-1-luzmaximilian@gmail.com>
 <20221202223327.690880-9-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2i3rsjvdvutz645p"
Content-Disposition: inline
In-Reply-To: <20221202223327.690880-9-luzmaximilian@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2i3rsjvdvutz645p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 02, 2022 at 11:33:26PM +0100, Maximilian Luz wrote:
> Similar to the target category (TC), the target ID (TID) can be one
> value out of a small number of choices, given in enum ssam_ssh_tid.
>=20
> In the device ID macros, SSAM_SDEV() and SSAM_VDEV() we already use text
> expansion to, both, remove some textual clutter for the target category
> values and enforce that the value belongs to the known set. Now that we
> know the names for the target IDs, use the same trick for them as well.
>=20
> Also rename the SSAM_ANY_x macros to SSAM_SSH_x_ANY to better fit in.
>=20
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/hid/surface-hid/surface_hid.c         |  2 +-
>  .../platform/surface/surface_aggregator_hub.c |  4 +-
>  .../surface/surface_aggregator_tabletsw.c     |  4 +-
>  drivers/platform/surface/surface_dtx.c        |  2 +-
>  .../surface/surface_platform_profile.c        |  2 +-
>  drivers/power/supply/surface_battery.c        |  4 +-
>  drivers/power/supply/surface_charger.c        |  2 +-
>  include/linux/surface_aggregator/device.h     | 50 +++++++++----------
>  8 files changed, 35 insertions(+), 35 deletions(-)
>=20
> diff --git a/drivers/hid/surface-hid/surface_hid.c b/drivers/hid/surface-=
hid/surface_hid.c
> index d4aa8c81903a..aa80d83a83d1 100644
> --- a/drivers/hid/surface-hid/surface_hid.c
> +++ b/drivers/hid/surface-hid/surface_hid.c
> @@ -230,7 +230,7 @@ static void surface_hid_remove(struct ssam_device *sd=
ev)
>  }
> =20
>  static const struct ssam_device_id surface_hid_match[] =3D {
> -	{ SSAM_SDEV(HID, SSAM_ANY_TID, SSAM_ANY_IID, 0x00) },
> +	{ SSAM_SDEV(HID, ANY, SSAM_SSH_IID_ANY, 0x00) },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(ssam, surface_hid_match);
> diff --git a/drivers/platform/surface/surface_aggregator_hub.c b/drivers/=
platform/surface/surface_aggregator_hub.c
> index 62f27cdb6ca8..6abd1efe2088 100644
> --- a/drivers/platform/surface/surface_aggregator_hub.c
> +++ b/drivers/platform/surface/surface_aggregator_hub.c
> @@ -348,8 +348,8 @@ static const struct ssam_hub_desc kip_hub =3D {
>  /* -- Driver registration. ---------------------------------------------=
----- */
> =20
>  static const struct ssam_device_id ssam_hub_match[] =3D {
> -	{ SSAM_VDEV(HUB, 0x01, SSAM_SSH_TC_KIP, 0x00), (unsigned long)&kip_hub =
 },
> -	{ SSAM_VDEV(HUB, 0x02, SSAM_SSH_TC_BAS, 0x00), (unsigned long)&base_hub=
 },
> +	{ SSAM_VDEV(HUB, SAM, SSAM_SSH_TC_KIP, 0x00), (unsigned long)&kip_hub  =
},
> +	{ SSAM_VDEV(HUB, KIP, SSAM_SSH_TC_BAS, 0x00), (unsigned long)&base_hub =
},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(ssam, ssam_hub_match);
> diff --git a/drivers/platform/surface/surface_aggregator_tabletsw.c b/dri=
vers/platform/surface/surface_aggregator_tabletsw.c
> index bd8cd453c393..6147aa887939 100644
> --- a/drivers/platform/surface/surface_aggregator_tabletsw.c
> +++ b/drivers/platform/surface/surface_aggregator_tabletsw.c
> @@ -510,8 +510,8 @@ static const struct ssam_tablet_sw_desc ssam_pos_sw_d=
esc =3D {
>  /* -- Driver registration. ---------------------------------------------=
----- */
> =20
>  static const struct ssam_device_id ssam_tablet_sw_match[] =3D {
> -	{ SSAM_SDEV(KIP, 0x01, 0x00, 0x01), (unsigned long)&ssam_kip_sw_desc },
> -	{ SSAM_SDEV(POS, 0x01, 0x00, 0x01), (unsigned long)&ssam_pos_sw_desc },
> +	{ SSAM_SDEV(KIP, SAM, 0x00, 0x01), (unsigned long)&ssam_kip_sw_desc },
> +	{ SSAM_SDEV(POS, SAM, 0x00, 0x01), (unsigned long)&ssam_pos_sw_desc },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(ssam, ssam_tablet_sw_match);
> diff --git a/drivers/platform/surface/surface_dtx.c b/drivers/platform/su=
rface/surface_dtx.c
> index 0de76a784a35..30cbde278c59 100644
> --- a/drivers/platform/surface/surface_dtx.c
> +++ b/drivers/platform/surface/surface_dtx.c
> @@ -1214,7 +1214,7 @@ static void surface_dtx_ssam_remove(struct ssam_dev=
ice *sdev)
>  }
> =20
>  static const struct ssam_device_id surface_dtx_ssam_match[] =3D {
> -	{ SSAM_SDEV(BAS, 0x01, 0x00, 0x00) },
> +	{ SSAM_SDEV(BAS, SAM, 0x00, 0x00) },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(ssam, surface_dtx_ssam_match);
> diff --git a/drivers/platform/surface/surface_platform_profile.c b/driver=
s/platform/surface/surface_platform_profile.c
> index fbf2e11fd6ce..f433a13c3689 100644
> --- a/drivers/platform/surface/surface_platform_profile.c
> +++ b/drivers/platform/surface/surface_platform_profile.c
> @@ -169,7 +169,7 @@ static void surface_platform_profile_remove(struct ss=
am_device *sdev)
>  }
> =20
>  static const struct ssam_device_id ssam_platform_profile_match[] =3D {
> -	{ SSAM_SDEV(TMP, 0x01, 0x00, 0x01) },
> +	{ SSAM_SDEV(TMP, SAM, 0x00, 0x01) },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(ssam, ssam_platform_profile_match);
> diff --git a/drivers/power/supply/surface_battery.c b/drivers/power/suppl=
y/surface_battery.c
> index 540707882bb0..19d2f8834e56 100644
> --- a/drivers/power/supply/surface_battery.c
> +++ b/drivers/power/supply/surface_battery.c
> @@ -852,8 +852,8 @@ static const struct spwr_psy_properties spwr_psy_prop=
s_bat2_sb3 =3D {
>  };
> =20
>  static const struct ssam_device_id surface_battery_match[] =3D {
> -	{ SSAM_SDEV(BAT, 0x01, 0x01, 0x00), (unsigned long)&spwr_psy_props_bat1=
     },
> -	{ SSAM_SDEV(BAT, 0x02, 0x01, 0x00), (unsigned long)&spwr_psy_props_bat2=
_sb3 },
> +	{ SSAM_SDEV(BAT, SAM, 0x01, 0x00), (unsigned long)&spwr_psy_props_bat1 =
    },
> +	{ SSAM_SDEV(BAT, KIP, 0x01, 0x00), (unsigned long)&spwr_psy_props_bat2_=
sb3 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(ssam, surface_battery_match);
> diff --git a/drivers/power/supply/surface_charger.c b/drivers/power/suppl=
y/surface_charger.c
> index 59182d55742d..cabdd8da12d0 100644
> --- a/drivers/power/supply/surface_charger.c
> +++ b/drivers/power/supply/surface_charger.c
> @@ -260,7 +260,7 @@ static const struct spwr_psy_properties spwr_psy_prop=
s_adp1 =3D {
>  };
> =20
>  static const struct ssam_device_id surface_ac_match[] =3D {
> -	{ SSAM_SDEV(BAT, 0x01, 0x01, 0x01), (unsigned long)&spwr_psy_props_adp1=
 },
> +	{ SSAM_SDEV(BAT, SAM, 0x01, 0x01), (unsigned long)&spwr_psy_props_adp1 =
},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(ssam, surface_ac_match);
> diff --git a/include/linux/surface_aggregator/device.h b/include/linux/su=
rface_aggregator/device.h
> index 46c45d1b6368..4da20b7a0ee5 100644
> --- a/include/linux/surface_aggregator/device.h
> +++ b/include/linux/surface_aggregator/device.h
> @@ -68,9 +68,9 @@ struct ssam_device_uid {
>   * match_flags member of the device ID structure. Do not use them direct=
ly
>   * with struct ssam_device_id or struct ssam_device_uid.
>   */
> -#define SSAM_ANY_TID		0xffff
> -#define SSAM_ANY_IID		0xffff
> -#define SSAM_ANY_FUN		0xffff
> +#define SSAM_SSH_TID_ANY	0xffff
> +#define SSAM_SSH_IID_ANY	0xffff
> +#define SSAM_SSH_FUN_ANY	0xffff
> =20
>  /**
>   * SSAM_DEVICE() - Initialize a &struct ssam_device_id with the given
> @@ -83,25 +83,25 @@ struct ssam_device_uid {
>   *
>   * Initializes a &struct ssam_device_id with the given parameters. See &=
struct
>   * ssam_device_uid for details regarding the parameters. The special val=
ues
> - * %SSAM_ANY_TID, %SSAM_ANY_IID, and %SSAM_ANY_FUN can be used to specif=
y that
> + * %SSAM_SSH_TID_ANY, %SSAM_SSH_IID_ANY, and %SSAM_SSH_FUN_ANY can be us=
ed to specify that
>   * matching should ignore target ID, instance ID, and/or sub-function,
>   * respectively. This macro initializes the ``match_flags`` field based =
on the
>   * given parameters.
>   *
>   * Note: The parameters @d and @cat must be valid &u8 values, the parame=
ters
> - * @tid, @iid, and @fun must be either valid &u8 values or %SSAM_ANY_TID,
> - * %SSAM_ANY_IID, or %SSAM_ANY_FUN, respectively. Other non-&u8 values a=
re not
> + * @tid, @iid, and @fun must be either valid &u8 values or %SSAM_SSH_TID=
_ANY,
> + * %SSAM_SSH_IID_ANY, or %SSAM_SSH_FUN_ANY, respectively. Other non-&u8 =
values are not
>   * allowed.
>   */
>  #define SSAM_DEVICE(d, cat, tid, iid, fun)					\
> -	.match_flags =3D (((tid) !=3D SSAM_ANY_TID) ? SSAM_MATCH_TARGET : 0)	\
> -		     | (((iid) !=3D SSAM_ANY_IID) ? SSAM_MATCH_INSTANCE : 0)	\
> -		     | (((fun) !=3D SSAM_ANY_FUN) ? SSAM_MATCH_FUNCTION : 0),	\
> +	.match_flags =3D (((tid) !=3D SSAM_SSH_TID_ANY) ? SSAM_MATCH_TARGET : 0=
)	\
> +		     | (((iid) !=3D SSAM_SSH_IID_ANY) ? SSAM_MATCH_INSTANCE : 0)	\
> +		     | (((fun) !=3D SSAM_SSH_FUN_ANY) ? SSAM_MATCH_FUNCTION : 0),	\
>  	.domain   =3D d,								\
>  	.category =3D cat,							\
> -	.target   =3D __builtin_choose_expr((tid) !=3D SSAM_ANY_TID, (tid), 0),=
	\
> -	.instance =3D __builtin_choose_expr((iid) !=3D SSAM_ANY_IID, (iid), 0),=
	\
> -	.function =3D __builtin_choose_expr((fun) !=3D SSAM_ANY_FUN, (fun), 0)
> +	.target   =3D __builtin_choose_expr((tid) !=3D SSAM_SSH_TID_ANY, (tid),=
 0),	\
> +	.instance =3D __builtin_choose_expr((iid) !=3D SSAM_SSH_IID_ANY, (iid),=
 0),	\
> +	.function =3D __builtin_choose_expr((fun) !=3D SSAM_SSH_FUN_ANY, (fun),=
 0)
> =20
>  /**
>   * SSAM_VDEV() - Initialize a &struct ssam_device_id as virtual device w=
ith
> @@ -113,18 +113,18 @@ struct ssam_device_uid {
>   *
>   * Initializes a &struct ssam_device_id with the given parameters in the
>   * virtual domain. See &struct ssam_device_uid for details regarding the
> - * parameters. The special values %SSAM_ANY_TID, %SSAM_ANY_IID, and
> - * %SSAM_ANY_FUN can be used to specify that matching should ignore targ=
et ID,
> + * parameters. The special values %SSAM_SSH_TID_ANY, %SSAM_SSH_IID_ANY, =
and
> + * %SSAM_SSH_FUN_ANY can be used to specify that matching should ignore =
target ID,
>   * instance ID, and/or sub-function, respectively. This macro initialize=
s the
>   * ``match_flags`` field based on the given parameters.
>   *
>   * Note: The parameter @cat must be a valid &u8 value, the parameters @t=
id,
> - * @iid, and @fun must be either valid &u8 values or %SSAM_ANY_TID,
> - * %SSAM_ANY_IID, or %SSAM_ANY_FUN, respectively. Other non-&u8 values a=
re not
> + * @iid, and @fun must be either valid &u8 values or %SSAM_SSH_TID_ANY,
> + * %SSAM_SSH_IID_ANY, or %SSAM_SSH_FUN_ANY, respectively. Other non-&u8 =
values are not
>   * allowed.
>   */
>  #define SSAM_VDEV(cat, tid, iid, fun) \
> -	SSAM_DEVICE(SSAM_DOMAIN_VIRTUAL, SSAM_VIRTUAL_TC_##cat, tid, iid, fun)
> +	SSAM_DEVICE(SSAM_DOMAIN_VIRTUAL, SSAM_VIRTUAL_TC_##cat, SSAM_SSH_TID_##=
tid, iid, fun)
> =20
>  /**
>   * SSAM_SDEV() - Initialize a &struct ssam_device_id as physical SSH dev=
ice
> @@ -136,18 +136,18 @@ struct ssam_device_uid {
>   *
>   * Initializes a &struct ssam_device_id with the given parameters in the=
 SSH
>   * domain. See &struct ssam_device_uid for details regarding the paramet=
ers.
> - * The special values %SSAM_ANY_TID, %SSAM_ANY_IID, and %SSAM_ANY_FUN ca=
n be
> - * used to specify that matching should ignore target ID, instance ID, a=
nd/or
> - * sub-function, respectively. This macro initializes the ``match_flags``
> - * field based on the given parameters.
> + * The special values %SSAM_SSH_TID_ANY, %SSAM_SSH_IID_ANY, and
> + * %SSAM_SSH_FUN_ANY can be used to specify that matching should ignore =
target
> + * ID, instance ID, and/or sub-function, respectively. This macro initia=
lizes
> + * the ``match_flags`` field based on the given parameters.
>   *
>   * Note: The parameter @cat must be a valid &u8 value, the parameters @t=
id,
> - * @iid, and @fun must be either valid &u8 values or %SSAM_ANY_TID,
> - * %SSAM_ANY_IID, or %SSAM_ANY_FUN, respectively. Other non-&u8 values a=
re not
> - * allowed.
> + * @iid, and @fun must be either valid &u8 values or %SSAM_SSH_TID_ANY,
> + * %SSAM_SSH_IID_ANY, or %SSAM_SSH_FUN_ANY, respectively. Other non-&u8 =
values
> + * are not allowed.
>   */
>  #define SSAM_SDEV(cat, tid, iid, fun) \
> -	SSAM_DEVICE(SSAM_DOMAIN_SERIALHUB, SSAM_SSH_TC_##cat, tid, iid, fun)
> +	SSAM_DEVICE(SSAM_DOMAIN_SERIALHUB, SSAM_SSH_TC_##cat, SSAM_SSH_TID_##ti=
d, iid, fun)
> =20
>  /*
>   * enum ssam_device_flags - Flags for SSAM client devices.
> --=20
> 2.38.1
>=20

--2i3rsjvdvutz645p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOKmxoACgkQ2O7X88g7
+pqO3g//djXjuGSaoCgKmKJf2Cq1bQMUqQLJz+1GJsAJipihTwga5pkuaQXWYIDD
/f/G2Fb8GbeZrVhHboGZ+hrj7SZqktylesLWhA8MTr10hDDuqQ4j+XVDg6bwEaxG
NIIrOEWnHmzl8NAblUX5iyZAq1ZqKxxX52tz1EIYieX8ECd9/NLydO1q1x6lBvi8
ssFxoggIiLpTsYs+zYhKgqEzCQydeQzFnVF08Al2neSS4khleLNPO/dB+xFgFRYX
20rjbfKWO93ifX2hI/2lhnDHYUjeuyYZqpv+rZteXeaTIIfRdu9ChhnF9mnaJDjd
4ElCe+Id5uqqrye7jBzWO3sTLP7fUaZProaH9okHDUTvSA40gXlPNXSUoiWmkG2b
7ELBadEDz5Ig1wxHk6jwo2c+23fNk+lh3eEaaGf5gWNyng3YBmCJBgGTQt56HLp2
ZVFSIRY5AYDY7DOK+bIiPkObuYqcetgty9/99xynvbbclqar36S+CRBlw6dyROBC
hnxTVirLtiPfZWN/U/CKH/lJp0cKqF9xr4uHrEwEmz0MPEYwKbXjARRBXCBAO6DW
ET3T4ad+fJqWIgJ4Mfd3tUybjpsYjZBJ6L6scpG5xNQ/PpM1qYByJKHtkriZqz6w
sHaJq2xb7zqwAONGp2IjsihF/amzL5rEIzw3iPCPOzIoHtpOW8E=
=mVy9
-----END PGP SIGNATURE-----

--2i3rsjvdvutz645p--
