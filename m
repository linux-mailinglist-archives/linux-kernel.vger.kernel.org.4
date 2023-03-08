Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0823A6B09BF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjCHNrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjCHNrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:47:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B0C8734F;
        Wed,  8 Mar 2023 05:47:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8992FB81CC2;
        Wed,  8 Mar 2023 13:47:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B09C433EF;
        Wed,  8 Mar 2023 13:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678283219;
        bh=Dzgnpfbs+yKJWVDVrz+SM2ZC2bUbXHfqK4bikVA/M18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CHGYRzxYhAAVcNVUPcbyyBQ4jgkn4MFQo6OvvzVpkJGBqgTrQg0Dm6sJe61ewYZrH
         bkhBN0NpteamYmOYwAEEaB5kdEGZxB1G7lxQh+QwhkIp//+PsaFBIMNx/uCIYjZICh
         BImANFNNazfOSrK7cFYD4f09XNR7JyGt07+J0GvLw+zIKR+iTXHnoEgb19O3SpHXBP
         wNrJeRgqh8uajmUdqqn7+yGXCMUug+oDk8+3fPIQ11y6ehWJ/OjiOc9n3qra8SAM7V
         LIgj3FoV6nBlp0hFz/GS1lHwhDqUBv3rxMiP4aPeMhx7azX44+jwH4ZbYHF6DaIBfX
         ie6Zj+gDUWiag==
Date:   Wed, 8 Mar 2023 13:46:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: hwmon: ina2xx: add supply property
Message-ID: <5cd6764c-9b04-42ea-932d-9f14aa465605@sirena.org.uk>
References: <20230308094024.14115-1-clamor95@gmail.com>
 <20230308094024.14115-2-clamor95@gmail.com>
 <31ca0ede-012c-4849-bf25-d0492b116681@sirena.org.uk>
 <6DBD0F5A-4625-4FCD-8D64-23293D734A82@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="emhiT6n8SP5ckuD4"
Content-Disposition: inline
In-Reply-To: <6DBD0F5A-4625-4FCD-8D64-23293D734A82@gmail.com>
X-Cookie: Minnie Mouse is a slow maze learner.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--emhiT6n8SP5ckuD4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 08, 2023 at 02:58:20PM +0200, Svyatoslav Ryhel wrote:
> 8 =D0=B1=D0=B5=D1=80=D0=B5=D0=B7=D0=BD=D1=8F 2023 =D1=80. 14:54:34 GMT+02=
:00, Mark Brown <broonie@kernel.org> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=B2(-=D0=BB=D0=B0):
> >On Wed, Mar 08, 2023 at 11:40:23AM +0200, Svyatoslav Ryhel wrote:
> >> Add supply property.

> >> +  vdd-supply: true
> >> +
> >>  required:
> >>    - compatible
> >>    - reg

> >Unless the device can work without power the supply should be required.

> Device can work without supply defined on most devices, but in my case po=
wer is gated with gpio and devices will not work without fixed regulator.

If there are devices that work without any source of power at all that
would be very surprising.  It doesn't matter if a particular system has
a non-controllable regulator, the binding should still make it mandatory
to describe that.

--emhiT6n8SP5ckuD4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQIkcsACgkQJNaLcl1U
h9DLjgf+JwLFER7NTybJIWpDUEcwfYmI40mRfAH7UE8En493f/0pMebcBBHNFa6J
KVUCJkGtFM3EPf3u0uX/kKfgqyIqHQ6NFwz0mBs3tA2jvWTCTlwqgjIrIMtqnyJl
pboxy1NkaLnKWZr7qSmEf5OVgJU5vCv1WIR3FXzBoe3M6HXof3Sxet1xCoJr1yGj
rPIM5Zb+9cwwEC7flYl5VAt8IIDEPbV1u6uFxdNpEuT2439csNp0iOnJpel0Hrlp
EttKtNc23ASQ40l5CTv459qRUOfU+1/wizGfc7LneTI8n/oU8E/hT9R3bpGAaFB5
VCzUnH64yOc+QSGT1cbe7BqGVePF0A==
=iM/u
-----END PGP SIGNATURE-----

--emhiT6n8SP5ckuD4--
