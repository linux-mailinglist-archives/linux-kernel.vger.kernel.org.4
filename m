Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D82174D718
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjGJNLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGJNL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:11:27 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58B7A8;
        Mon, 10 Jul 2023 06:11:26 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-992dcae74e0so590220566b.3;
        Mon, 10 Jul 2023 06:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688994685; x=1691586685;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+Sj+CwJeYIb9YiBPuGCzCzTBVYAtf6z/Ku6fc72G2E=;
        b=FS46eo5yjS6DqXLbArty/6G2Q/3VjDmv9tgGS3BEb/KgL1glnMzOS7VcrOhzhUo13U
         Pe9s5zG6Nqdt9sfeBKWZH5BnuRCiVvIHkKZqQOxZhKTdt5xT0kGQ62MPL/rCdrgkFkov
         tJz0roaWL5/c9t8+qTOYZLJjMb2fUhvqLFyrECikyUVj1RltOq1FAZ0NdD3YVKDxTGga
         A8CavPcYyjYAro3umKDprZp0uquDnZKhayLJVLtBoG+G90+hkLwuFecdF2P37632e/Tz
         5MTD4yZNdFbbGjr77GhIf2omgHCVAdglPvw0eoYiYUwtXxBnuzBHp8e1bP4Ljc8+M7Ak
         pBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688994685; x=1691586685;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+Sj+CwJeYIb9YiBPuGCzCzTBVYAtf6z/Ku6fc72G2E=;
        b=Tde6/dpPKFHxo3YiKaVuA6DA+583LuV2hgyz4/U8SwFgxWff5Ursu9EXxiaMQt1/kP
         qfCwnotrYhaGenD5ZbcKbGCiNIEJ/lLrJc1ui6Zosa31kqlOexJW84+ixoo1EqYb2DYN
         +O71Vg3h41eetO9reRdkpCM+QRxMf2QhwP3XuYYuvgWY1IUBn+A5Hb+LJwuUk69Q8rWa
         xGhHsS0PlUZhd9V2A9kkTaYCd/5lihMd78U3TvVK0b3HPjdwB8TjzknJvv3GcoWMIZc9
         I2cNjZh3vWOELhmosNMH7i5eacKZLgRHzc39kDwr9pFHEVscCBDOh/fXCaghizK5BEuT
         u6LA==
X-Gm-Message-State: ABy/qLaFRoGhaMKlUZGc4aYz/lEU8RAlwuw38l/mBcE4aIUq1TVTqNW4
        3UyuMezcb1OOlVDb/E5GnJ79lrtvvus=
X-Google-Smtp-Source: APBJJlF1kaMLPpu8IWN45q9maOQ/+xLzkln+KHH7qgAVhCq/HJqmld6n7/tnKAoQDNfgm229y8lJsQ==
X-Received: by 2002:a17:906:728a:b0:993:d54b:3e4a with SMTP id b10-20020a170906728a00b00993d54b3e4amr10626237ejl.15.1688994685133;
        Mon, 10 Jul 2023 06:11:25 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id h13-20020a17090634cd00b0099316c56db9sm6056440ejb.127.2023.07.10.06.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 06:11:24 -0700 (PDT)
Date:   Mon, 10 Jul 2023 15:11:23 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-input@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: tegra-kbc - use devm_platform_ioremap_resource
Message-ID: <ZKwDe77yPmaaNoiE@orome>
References: <20230709134109.182418-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o7S8PluLd+rG5rXR"
Content-Disposition: inline
In-Reply-To: <20230709134109.182418-1-martin@kaiser.cx>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o7S8PluLd+rG5rXR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 09, 2023 at 03:41:08PM +0200, Martin Kaiser wrote:
> devm_platform_get_and_ioremap_resource maps a resource and returns its
> physical address. If we don't need the physical address, we should call
> devm_platform_ioremap_resource instead.
>=20
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/input/keyboard/tegra-kbc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Different variations of these have been going around for a while now. I
don't really see much use in these tiny conversions.

But the patch also isn't wrong, so while I'm at it:

Acked-by: Thierry Reding <treding@nvidia.com>


>=20
> diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/=
tegra-kbc.c
> index d5a6c7d8eb25..c9a823ea45d0 100644
> --- a/drivers/input/keyboard/tegra-kbc.c
> +++ b/drivers/input/keyboard/tegra-kbc.c
> @@ -640,7 +640,7 @@ static int tegra_kbc_probe(struct platform_device *pd=
ev)
> =20
>  	timer_setup(&kbc->timer, tegra_kbc_keypress_timer, 0);
> =20
> -	kbc->mmio =3D devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
> +	kbc->mmio =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(kbc->mmio))
>  		return PTR_ERR(kbc->mmio);
> =20
> --=20
> 2.30.2
>=20

--o7S8PluLd+rG5rXR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSsA3oACgkQ3SOs138+
s6F5cw//YZueXXDV1NfMlou+p4d28iz0CUuuGL06TRczgNlcyG4RS67X93IejGAP
mmEMgX4CN0chNM/rdwTIXg9+jJ05ri5SuM+PPtzLstDWmoJ+S3ySLU89m0Tj8P81
Xrk/JAEXxMTbVPvQPoG1MlQssNrA80Kis+ZLvQNAavkTIidBBeUnvojhsoMTbCkK
eG06ldA0XvUNhFfdyQk1cNM2BpnEQEKgH7s4LMmHkc6HbHFUDpCZNzL3OCpluPi+
uEWE3BCs2uMuhdYTvjd2gCMhQDrkTx+DLDM4Xvz+J0n1UbFWwGz7u/NPMwwnzEbZ
UtN4NjqhWTKW/dF2m9mtiVahMXBLjGRumgwgupxK80fPdpVWQkwLCQklb/1mwqe3
1ARD145VNSe0Qi7mvsXpO8gz9ZdpUyqZZ2muNBWfDSkRVm9qDRsbtfkwG/smw8rv
vb/tN+rwnDu75QnGeGzifk9VldnODoATkAiOClLwmE3oBU6MXd7x59qmSZb8JguJ
bMlE/zL+Z5wzjdGxn63aCFaz4QEuZ/JBe1JUeDzUE5a8V9U9T6m000oXnRTnB0pC
hf1yd39lw7BPssSNFUhrCxOZqB8DM7HzEw3GbXitBFJcVVQHf0LGUYGAM7mvgIX/
c5a7YgodKGCa8kHBwC9ATGKQ3gxvv6ZdvdbZGcnEmWd8gQOOgCI=
=AfGr
-----END PGP SIGNATURE-----

--o7S8PluLd+rG5rXR--
