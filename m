Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537B762DA78
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240052AbiKQMOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240056AbiKQMOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:14:33 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223986E557;
        Thu, 17 Nov 2022 04:14:32 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id k19so2474138lji.2;
        Thu, 17 Nov 2022 04:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B6zHRQIDfVqY+MN9crSq6m8AIqJBXp1xNp2VI0ETVz4=;
        b=NAtKyRUDSXxY7UulH8aiXUGgsG98vHa12hlu0JqZK0IWSu5lAEPsSIk8/+xr7W7jeO
         nfy3sPrTK/9ZTUSJkKoxn7gd+1ZiabPpcva97RigeTRWY4LvoBOz1WrxaDQQf9vn/CmR
         vipGuVTTXpAqxHATChNaw/vZrCB9efAPByUC8mkNqvDNtswDIM+XAaN7KsKbkxbuU0Ur
         ko3ytcvmjsjLXfS4SaQUrn6TAICv1irAu6tRdlhHOYuoNO6IU3Z76lg+b6/FL7+d9mZ1
         kHKjTIfQorEOpHgpv0lrRc6JojzRxWjDZq4etPN3IVUH+xgozDZM0F4gmoFF3uafZ7Tz
         FvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6zHRQIDfVqY+MN9crSq6m8AIqJBXp1xNp2VI0ETVz4=;
        b=PbizBpMoY3hHFnUbFDymSp+hl6hPMofEOnJe+gp01hNzxms4HziI9x/SC1PJcI517C
         L994yPHOgZt/5Y2Pl2yyPSZDkgPGrGhSoggUXi6N6TFtBqLgOeGzZbSfB7jss+dW7Z4/
         wbTYciXS1wN1M45cfzLhELN3gP79xvWYzJUXGWk0DGRkaDwDwzp25DeL+v1DSlFAjXEh
         8qYto4kvrW6ssck/BKxeyfhYEP8Deg8EcV/blrk3mKL0O0nrfIdiBxp/HBHYJ6rUfzwx
         veWu0A74yp1b6kDiWJeX2IcDP8C5zjSQiXJn2o0+UZqoGPi5xBNY0uDBMru4TN2zgYHX
         PI5Q==
X-Gm-Message-State: ANoB5pkA66w3sUHXRV77o+jo15rfh6BzIhZ+JGrek2oF20lAq1tgr77Y
        XR4jJJ7S2zwF55pDl+393rw=
X-Google-Smtp-Source: AA0mqf69FHMTSFIbdZPgE2n+FGOVyAUXb+/2vN66+CtWjT+DyaI9gTXjrIMDllk1NcrDIlfGEIYkuQ==
X-Received: by 2002:a2e:22c4:0:b0:277:515b:3db6 with SMTP id i187-20020a2e22c4000000b00277515b3db6mr827777lji.497.1668687270460;
        Thu, 17 Nov 2022 04:14:30 -0800 (PST)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id n16-20020a05651203f000b004b1b0f12cb4sm119917lfq.201.2022.11.17.04.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 04:14:29 -0800 (PST)
Date:   Thu, 17 Nov 2022 13:15:53 +0100
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2] HID: hid-sensor-custom: set fixed size for custom
 attributes
Message-ID: <Y3Yl+eJndSuoV0vn@gmail.com>
References: <20221117121326.5621-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3U7giTovVB84HU4S"
Content-Disposition: inline
In-Reply-To: <20221117121326.5621-1-marcus.folkesson@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3U7giTovVB84HU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 17, 2022 at 01:13:26PM +0100, Marcus Folkesson wrote:
> This is no bugfix (so no Fixes: tag is necessary) as it is
> taken care of in hid_sensor_custom_add_attributes().
>=20
> The motivation for this patch is that:
> hid_sensor_custom_field.attr_name and
> hid_sensor_custom_field.attrs
> has the size of HID_CUSTOM_TOTAL_ATTRS and used in same context.
>=20
> We compare against HID_CUSTOM_TOTAL_ATTRS when
> looping through hid_custom_attrs.
>=20
> We will silent the smatch error:
> hid_sensor_custom_add_attributes() error: buffer overflow
> 'hid_custom_attrs' 8 <=3D 10
>=20
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

v2:
    - add acked-by tag

>  drivers/hid/hid-sensor-custom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-cus=
tom.c
> index 32c2306e240d..602465ad2745 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -62,7 +62,7 @@ struct hid_sensor_sample {
>  	u32 raw_len;
>  } __packed;
> =20
> -static struct attribute hid_custom_attrs[] =3D {
> +static struct attribute hid_custom_attrs[HID_CUSTOM_TOTAL_ATTRS] =3D {
>  	{.name =3D "name", .mode =3D S_IRUGO},
>  	{.name =3D "units", .mode =3D S_IRUGO},
>  	{.name =3D "unit-expo", .mode =3D S_IRUGO},
> --=20
> 2.38.1
>=20

--3U7giTovVB84HU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmN2JfQACgkQiIBOb1ld
UjKuQRAAmnGTkNKC0HeF6xWruvf7jiY2S3pBUim6DIfShzjf9Zbi9LHFmTL5LGVL
mkVq8B+c7ppX/zbQePLG4+lsJ2BKElNFBDDv98gJljqEH1QO+o2f4Z7DoASOzk4f
rKRTyE+qi7Qy0jDRMsLgX0GP6lSTyo6uq5mVKSS/TnqnBElv7sye/uaT63xYbL2Z
uvnD0B5xb8Uyk9Xem//9HPRAgCrz1xLX1de1JZVIoFZwOjceBEMBbKFM2dHiftXU
7PMj42ePEX5kcXBPXDMDfCL2iTgbkXvH04M5/xUFT/+QOj/hJhumxfGmUHUWwUFY
6xK00y3CGuVi2KfFkgO6/9KBARL+OScW3Eu/HvhSuY6d4cXnuR6oKTGQEZ24TCYr
ZfuBIrUMC4h72AtR/WR+Z59wh+ev8d8LNr8xOBA01qhM+m/6ALGh5meZEjmLOJAZ
4S8KpvgPZ+gTVvn2dev6WFkgBfFbxu5Pqsyp1XSDL39N63uqeE5z6ABC9JNYaO8M
SeE+ybbCksyDQld0z4JVCMMs5ZFPXeY4Wrdu1zvmLferEPSlCFyq2MAOezUGyDm+
uZJPNE6+EUuTJBg/ZZa35zn1Qqx8rNdaww7VRAD7a/lSdy7zcaSAhB/idJOLmAM5
a6wJa7FLHo8eHepAmBqO2qR2bZ3NbUJSgWlcsX06+0MPx7zobmY=
=9o6A
-----END PGP SIGNATURE-----

--3U7giTovVB84HU4S--
