Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0F66D8146
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238847AbjDEPNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238815AbjDEPMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:12:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FE0CA;
        Wed,  5 Apr 2023 08:10:53 -0700 (PDT)
Received: from mercury (dyndsl-091-248-212-122.ewe-ip-backbone.de [91.248.212.122])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 77EFE6603193;
        Wed,  5 Apr 2023 16:10:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680707451;
        bh=jRgDSO3v+VKl5PXcXNslYAslMAv3VPkQGjzS7XPnMAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=osaLU4v0nFMMIg4IDSyBdT3qBWT4X2O8k3ZrjGFMI34Qldf+cjvbHjMxFoTgz7Bvk
         w97swc1hCobTNouVTULuzJzMgyztKpUTHLucjF3uiHjTaf5KoEZjeiX0LQT9FZB49R
         OyB0xMBsbOxjKCqG6Pi11HTbRtuyCkZXbXT7mv7CeKgZ7tQ/hT4DGy1i8GeKbB5HEG
         v8rZxZVwV06Tb9DTN7CXXJUIx5Yxw3NKo1YsIyHILsO754gI91j1Q8e2ckF7XNzUki
         iILfoWhnlG04i2rRfuAPTXxlwdCtsK2URf+5j34B88VED3fByRqlgvFUnNh3WQ2oIf
         jHbnHWu6mceKw==
Received: by mercury (Postfix, from userid 1000)
        id 203631065C70; Wed,  5 Apr 2023 17:10:49 +0200 (CEST)
Date:   Wed, 5 Apr 2023 17:10:49 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv1 0/3] generic-ohci/ehci: add RK3588 support
Message-ID: <20230405151049.qksjk6e3za7fwuz6@mercury.elektranox.org>
References: <20230404145350.45388-1-sebastian.reichel@collabora.com>
 <2023040524-hazelnut-landfall-7d26@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rspdxdya3ht4irto"
Content-Disposition: inline
In-Reply-To: <2023040524-hazelnut-landfall-7d26@gregkh>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rspdxdya3ht4irto
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Wed, Apr 05, 2023 at 04:49:37PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Apr 04, 2023 at 04:53:47PM +0200, Sebastian Reichel wrote:
> > Hi,
> >=20
> > This increases the max. allowed clocks for generic-ohci from 3 to 4.
> > On RK3588 a total of 4 clocks is required to access the OHCI registers.
> > EHCI already supports 4 clocks.
> >=20
> > Changes since PATCHv1:
> >  * https://lore.kernel.org/all/20230331163148.5863-1-sebastian.reichel@=
collabora.com/
> >  * Add Alan's Acked-by to the driver patch increasing the clock count
> >  * Update bindings, adding rockchip,rk3588-ohci and rockchip,rk3588-ehc=
i compatibles
>=20
> This is "v1" according to the subject line, right?

Well the previous version was also about adding RK3588 support.
I did not see anything RK3588 specific and thus used "increase
allowed clocks" as subject for the cover letter. Rob's review
effectively asked for RK3588 specific compatibles to be added,
so this is a v2 of the series with that change included.

Since increasing the maximum number of clocks is no longer the
dominant content of the series I changed the cover letter's
subject. Sorry that this confused you.

Greetings,

-- Sebastian

--rspdxdya3ht4irto
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQtj3UACgkQ2O7X88g7
+pqcFA//anAG2suOvroCaC8qsNmoHOqpuRSWuMaS+dC1mr39LGBBpnUMqUl0Kx4T
UvthCvr6jtqBwAuianN+qU0rMTbGdCTvYgmVWXDyO8BkxmI8S3VxmhWbYEuJ3KCF
BxIaeUde9b08ED00pibR1VeAGqvCoSJZIL7OBfX6ZeRT75P5P+PdWn4hGi622MGX
zh/Wa3ukrzktinNn8TfjabKqDDrDxwvaKL8eMgLsZ2BqBsEnBc7Y8hN2Wp5JBOTL
w4ySz+Co/oUSZJurNfflVFZxdw/EPTC8mHKph4ilr6VgyLJEpv/9aqqegIqtUWet
Y+xZSHaxhBG21VECJ+HcEXCu0sWDNQ3lGdiYR3UCXck3tw8gg5Ego9YerFddHlt+
TuvA28IsfIIMCE9SHyeRZr6upIyI+pMUYCjkvrB+n0GnMYylL44myeOz5lhqSRDc
1IBU3aC6W6ukZra8MgO0lqeqU1CUd78Row+SSxCXkSrLwymEQC1ar3BokAFw36K4
EnjGXq3HqY1ZHrRo2x/j6oekOyQu+9aB/CCyAacplJhtadPF41ETk0u+/SvrICGr
nzCqkNiSedsV0YL6w4UpWW8WoJrKGgoSRM1EI8JoS3X0FEywdKu2BLyyq8oPz0mS
lGKOAh9Wivyfct38wMcODDxIOLZrTB7RvJpiUoCO3xuDtHksBmM=
=i930
-----END PGP SIGNATURE-----

--rspdxdya3ht4irto--
