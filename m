Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B246469540D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 23:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjBMWpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 17:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBMWpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 17:45:45 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95BB1D91C;
        Mon, 13 Feb 2023 14:45:44 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3B7786602154;
        Mon, 13 Feb 2023 22:45:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676328343;
        bh=9ZqLO7u9wSSWylBMnQo4JHT+AC8VOGxAaq9hFglbWFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IzeZKCYvRlFrs4yVkPEm6idXIx3tSARIcMt/ufUhergxwEaz2ZyIWysC+2kLsveaW
         8z9Q/nw6zNKgZAaEViw93IzBdu47AaZ48TETC7JsrqYp9/y+aa4gLz6wMaq0YZKKch
         zw7SO167/TQE86+q2RnXpnQmbxcLbYG3cUHQegJ1nRn/ys2JWHYvxc8Zo3MMCcEQOw
         mHMQXhBnRcpi/DoedRVO+lE3wbahIooUVGAq0H27aChZiR2sd6x9ylNrYpuZ+F8MJd
         YVt7irvYZMy3kkw6ekTuVw0JvpBlAkHVqWeLcr2qUkRfV0iLcYb0a6tl6c7MHFyekg
         lzkzJUmZsxoHA==
Received: by mercury (Postfix, from userid 1000)
        id 8E28F10603FE; Mon, 13 Feb 2023 23:45:40 +0100 (CET)
Date:   Mon, 13 Feb 2023 23:45:40 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        marijn.suijten@somainline.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: power: supply: pm8941-coincell: Don't
 require charging properties
Message-ID: <20230213224540.o4fd554ippzdej7a@mercury.elektranox.org>
References: <20230213204950.2100538-1-konrad.dybcio@linaro.org>
 <20230213204950.2100538-2-konrad.dybcio@linaro.org>
 <20230213212733.rhvuzrshfrvzgo4a@mercury.elektranox.org>
 <83637cc7-21ae-7778-37b3-4522cc0a06c9@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hvdkk6p6no65upka"
Content-Disposition: inline
In-Reply-To: <83637cc7-21ae-7778-37b3-4522cc0a06c9@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hvdkk6p6no65upka
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 13, 2023 at 10:41:10PM +0100, Konrad Dybcio wrote:
> On 13.02.2023 22:27, Sebastian Reichel wrote:
> > On Mon, Feb 13, 2023 at 09:49:49PM +0100, Konrad Dybcio wrote:
> >> It's fine for these properties to be absent, as the driver doesn't fail
> >> without them and functions with settings inherited from the reset/prev=
ious
> >> stage bootloader state.
> >>
> >> Fixes: 6c463222a21d ("dt-bindings: power: supply: pm8941-coincell: Con=
vert to DT schema format")
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> ---
> > Please update the description of these properties to describe the
> > default behaviour.
> Not sure if there's any default behavior other than "go with
> whatever was there previously, no matter how it got there".

I got that from the patch description, but that behaviour should be
described in the binding.

> Is it okay if I just add:
>=20
> "If unspecified, inherit the bootloader configuration"

Technically the bindings are also for bootloaders. I suggest:

If unspecified, inherit the previous configuration (e.g. from
bootloader or hardware default value).

-- Sebastian

--hvdkk6p6no65upka
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPqvZAACgkQ2O7X88g7
+pqK5A/7B+mt+IoHQ+S5V1ix2613TjN9+JjnUr/fmRmVvPNtac+u6oukLqgGngwp
UwtnP34uerWTYzIQAeNXIa287PbBuDpYwSh+CL9QrRtR+7Bp9olslee+dHz4bv+n
rXuxQifQ8FroUZhtXfaNBL3g/y+fQKHN3HXrXLjwpM4ZZ+mW8vVpHc4alejCvDQx
mjAYsRh/TZDgS8bsUoxndVcmO26o3pBV0ockEdj4vTfvwMmTUQncejUyGAJcoWJv
eC92EgWj5+ldaCx1E0Sgc+3LHtlZljU49FNEkXzppXZxBdoYF/TVggvrLdrGjX/8
Oh17YsJ2cE0Lyu1nf37jEGqJDZNGICLOrJ0nnC3UlH3CXfGyEB9h/C4BrbVYdtuh
BWXvZbYTjT5k2PEc8exAyigfGNIZ8plHEyVDP2Ra+yNXGG/3N474iUQV8Z7nQKPu
jotzhZKxFr8ecOr6B6XCBLV0UljIRqTEUqqWSmQs7J1M/hwW1Ad9mOYTdjeRTU7+
SucSyhXRNSlB6D5ASFXk9ggiQvOdtGBCyCRMzuXDq8qRfSc1auPSsInat4O2bKQO
82DdM41izrDX4ZTkxYl7PhZMROl13MKLy1kSOp4YrolXN6pzeLpEvu1gHn3t7XR+
kxGP+ie/ZL4JluGRmLJ8kKDBpU1DVSCECOhQT2RRvsbmmy2Ct2s=
=G77K
-----END PGP SIGNATURE-----

--hvdkk6p6no65upka--
