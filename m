Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34547728A75
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 23:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbjFHVyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 17:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbjFHVyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 17:54:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F9D2D56;
        Thu,  8 Jun 2023 14:54:08 -0700 (PDT)
Received: from mercury (unknown [185.254.75.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BDF4F6606F20;
        Thu,  8 Jun 2023 22:54:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686261247;
        bh=Wszifdf7HuRIPKRMgIdm6D0LY7Ej+ODbMyZF6avenLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JgwpYBZ7xHNmhkrdmhq+rh8ZZLrJpIL0osF8+noxtXwFPf+W1teh8z+iqN2w0UJaB
         C8orH0FRMba1El56OOjXRsONutwE55o4FQs3D68rOvvtNrHGhKyPxPnjFeaCjG/FTS
         zk6YcwewiKzjl0Q7timPY5sjheGyWnck5lohPf7rO+vLTj5IGDEX2S1W+/0x0kUTmD
         RvhHGcW31w8ClMVN7uVfRv4telPtxmAPMUfqlG6b+Bq8LWiL2VAthucLFM0zpSwnPZ
         vRxVjlIg1tTscZPnhYpvMMpK2Oc3tomEUDm8X0REGMpCKC7a76KXQNTcl1luxfMOrj
         gkkVwvf9rgcUA==
Received: by mercury (Postfix, from userid 1000)
        id 071531060A24; Thu,  8 Jun 2023 23:54:04 +0200 (CEST)
Date:   Thu, 8 Jun 2023 23:54:04 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     cy_huang@richtek.com, krzysztof.kozlowski+dt@linaro.org,
        chiaen_wu@richtek.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: rt9467: Make charger-enable control as
 logic level
Message-ID: <20230608215404.oiklnbbsbykv72zc@mercury.elektranox.org>
References: <1685600676-25124-1-git-send-email-cy_huang@richtek.com>
 <3843deaf-2913-d850-0422-d411031947b4@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ssk5gaztslys2g72"
Content-Disposition: inline
In-Reply-To: <3843deaf-2913-d850-0422-d411031947b4@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ssk5gaztslys2g72
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 01, 2023 at 08:31:28AM +0200, Krzysztof Kozlowski wrote:
> On 01/06/2023 08:24, cy_huang@richtek.com wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >=20
> > The current coding make 'charger-enable-gpio' control as real hardware
> > level. This conflicts with the default binding example. For driver
> > behavior, no need to use real hardware level, just logic level is
> > enough. This change can make this flexibility keep in dts gpio active
> > level about this pin.
> >=20
> > Fixes: 6f7f70e3a8dd ("power: supply: rt9467: Add Richtek RT9467 charger=
 driver")
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> > Hi,
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks, queued.

-- Sebastian

--ssk5gaztslys2g72
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSCTfwACgkQ2O7X88g7
+poB0hAAip4G5Lih7H91h4epC0Egs53vOzTSTzwFkjpn+V88Vhysu/aoAjYFQBwi
OPMMPziKE5Lv9BeYAkEwrBFLov478+VCAvQBL8/E40JLhaaGM1+rrZHgYw96Gv8i
CaJmdpkRdRHJ/HGFIwJir+p72pjfZW3i/eLxY4IIeFTXVxA7Rw2JFEqX48YV5hh7
F9XbAinkESmmnzWF/6v4jaIunW2NRVRguSK+FQ9IfTvVgWHnOcuceLIcQ719LT/y
TdwqCvoXkz0TbXxW0/jXOQ+fChCeeqzVK0Tv+JOMf+A+FP4m3QJ1nOEeKbrUivhH
UvCxFroyer7nPsFqabM3QV/UPEvKgMbvfy48yPwnkWjIMVzF4fDSRvsnbC59PEM/
8Qd7yeYfdCqYbRMextW+08DQ3RkgvrD7Okajpx50s09h2igyc9JxU3JHEBqfVkZR
Vpcuz3PQQrASd3syJkN0lChVIrh0/IajDczxPM8P9rlCyFKE7/n3jvr7bayU4f4a
F4pmnDtGm6DoIRMiSZTpxIGc6UwrgPrUTtmTuuZgX84YM0X+f9nbkkaAkwjccZRj
+BYLoIX2PjU/M1gQZXDLMYZ2xOxpKASiZIMA36nBRatH99iw7LrEzXM2P3sS6Xyq
UKMAndUmTKB1osIG51LKlvM34mGSck1BBDG4xWpfk0w58xsbtEM=
=xZYs
-----END PGP SIGNATURE-----

--ssk5gaztslys2g72--
