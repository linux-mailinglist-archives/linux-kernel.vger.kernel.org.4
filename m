Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429BA6C6A53
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjCWOAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjCWOAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:00:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40692D69;
        Thu, 23 Mar 2023 06:59:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EAEA626D8;
        Thu, 23 Mar 2023 13:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DA7C433D2;
        Thu, 23 Mar 2023 13:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679579967;
        bh=Xx6aCo/KDs7Wn5LTuwfnYkfEn/pZE0mmK2yroXA82DE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kOu0OMCKTfmegNRaADT8nLtHPXaJEZF6CN+xiipR4gNzge+APePvjXTBMtCNsNj1j
         iW/aEvOcQugIfybquBJS5jVv2R1cSU/zpGvfRW6AnA7AGCzxxDA9Xnt01B/5HXbv0e
         q0dVwkAPRuvLhmuJFG6lTXtQVnvsoBdEpYroQ+hGncqE4z/A4OhYgNB1JOd02HCD14
         9Vp65wHFkjeMuIgitZMPt3KAfETRrrpUrtkfKhuUKa/fpRG85EmHXYslCBd+EE7eYw
         b31fhTQujwndov5Y2oplP7WVRKh1iVd9OtHMXNliLxv88pv8xcS5YknW58lBZtipcU
         1hyxXdfxWo1Pg==
Date:   Thu, 23 Mar 2023 13:59:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     zhuyinbo <zhuyinbo@loongson.cn>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v2 2/2] spi: loongson: add bus driver for the loongson
 spi controller
Message-ID: <75a40be0-8eaa-4c9b-87dc-382c2a2af439@sirena.org.uk>
References: <20230317082950.12738-1-zhuyinbo@loongson.cn>
 <20230317082950.12738-3-zhuyinbo@loongson.cn>
 <68b6034f-8305-4854-a4c9-962be988ade7@sirena.org.uk>
 <9b7aff76-eff4-3b82-d7af-a723fbf21a32@loongson.cn>
 <9917d619-1104-4040-bb6f-c564fcf72806@sirena.org.uk>
 <5c281b1a-b6a7-c62e-6247-5d82ebd5e0d6@loongson.cn>
 <f7811b40-80a3-4985-b92d-1df3e28a0935@sirena.org.uk>
 <2337f45f-c513-1b10-ccfc-766363c5fd02@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hopd+e5dk7Smme6h"
Content-Disposition: inline
In-Reply-To: <2337f45f-c513-1b10-ccfc-766363c5fd02@loongson.cn>
X-Cookie: A lie in time saves nine.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hopd+e5dk7Smme6h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2023 at 08:46:19PM +0800, zhuyinbo wrote:

> I think add following change and that issue what you said will can be
> fixed,=A0=A0 in addition, the spin_lock

> was also not needed. =A0 Do you think so?

> @@ -101,8 +101,10 @@ static int loongson_spi_setup(struct spi_device *spi)
> =A0=A0=A0=A0=A0=A0=A0 if (spi->chip_select >=3D spi->master->num_chipsele=
ct)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
>=20
> +=A0=A0=A0=A0=A0=A0 loongson_spi->hz =3D 0;
> +=A0=A0=A0=A0=A0=A0 loongson_spi->mode &=3D SPI_NO_CS;
> +
> =A0=A0=A0=A0=A0=A0=A0 spin_lock(&loongson_spi->lock);
> -=A0=A0=A0=A0=A0=A0 loongson_spi_update_state(loongson_spi, spi, NULL);

Looks plausible, yes - I'd need to see the full thing to verify.

--hopd+e5dk7Smme6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQcWzkACgkQJNaLcl1U
h9Bw+wf/XNyR7ESc8fPT04EUVUWhp/ceY3nyKOZEaDOUZIOWhVq3cNo2U88/r1XL
/GtgW9HLC0nWRKJZkJCe7zaRNpeyYtOVuBeZWNRvOFmnIVhHg9xYbtsXw9/TGm/n
g92V+3dAEhc1xhgkKrSJ3qGIRrjfTW/kXvf8o6YAzqJxcYWzyVZDixMMUbOWyH4z
Es3GRqWbyuHG7VmBdPkh9wwh8nc18a3VPHgWSsCm/5FVUkIYIDqdxHVghWnjbyt6
vqbXBgKv1mO68rkp1EXukKLsQu4/4LNgbvOscQCqyvPkQmb5L+gua196bmkFX4yf
DddW3tcJqKkzttDsx6GSiM7fJh7pEQ==
=s27+
-----END PGP SIGNATURE-----

--hopd+e5dk7Smme6h--
