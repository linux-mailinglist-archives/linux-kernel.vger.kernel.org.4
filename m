Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810B56B0B70
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjCHOiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjCHOir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:38:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7469E5DEC7;
        Wed,  8 Mar 2023 06:38:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01375B81D0C;
        Wed,  8 Mar 2023 14:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D93C4339B;
        Wed,  8 Mar 2023 14:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678286320;
        bh=3X4ySPWsoyAsUgf2qhOiAzwci57Co7yc+Y4wqI6s2sQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cENv+SBuRPtyAejRhqhvY49Uk3OlvbS8pKt47PCsr0YCvZyYuSdUfSJjI9O7/Sc6Y
         iXv/4zsDPY25jyta7lBQYmHhSQr+lB5BGXN2/VKw5dpBVSMbzhtTjPAz4By0j4jKlh
         xi5SenYirDjH+4Pht+2WDtj6w3Su3o/DntpI0mAqyHQ6shElrm/1Xna0kYEuBgc0kK
         YyhMBQCSlXw8ZJMjDxwwQrJqNlWhZA5ENrhd3eh9/Nsbl4cBjovDKeAchfl8//H0zH
         cdfCycIkX9/5Wcu2kusSf2A0UWONhUPbL6j2xs7XEIeHHf8f6DjOCGomj7O0s7P169
         qDTsVwawcYxQg==
Date:   Wed, 8 Mar 2023 14:38:35 +0000
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
Message-ID: <f6f02138-8ef9-4a33-9b51-0b7cd371230f@sirena.org.uk>
References: <20230308094024.14115-1-clamor95@gmail.com>
 <20230308094024.14115-2-clamor95@gmail.com>
 <31ca0ede-012c-4849-bf25-d0492b116681@sirena.org.uk>
 <6DBD0F5A-4625-4FCD-8D64-23293D734A82@gmail.com>
 <5cd6764c-9b04-42ea-932d-9f14aa465605@sirena.org.uk>
 <135993BF-B4AC-42C1-AD36-94F66EE1620D@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iMP8I05b9K9jEnlX"
Content-Disposition: inline
In-Reply-To: <135993BF-B4AC-42C1-AD36-94F66EE1620D@gmail.com>
X-Cookie: Minnie Mouse is a slow maze learner.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iMP8I05b9K9jEnlX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 08, 2023 at 04:01:44PM +0200, Svyatoslav Ryhel wrote:
> 8 =D0=B1=D0=B5=D1=80=D0=B5=D0=B7=D0=BD=D1=8F 2023 =D1=80. 15:46:52 GMT+02=
:00, Mark Brown <broonie@kernel.org> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=B2(-=D0=BB=D0=B0):

> >If there are devices that work without any source of power at all that
> >would be very surprising.  It doesn't matter if a particular system has
> >a non-controllable regulator, the binding should still make it mandatory
> >to describe that.

> Then question is WHY and WHO passed driver without power supply system im=
plemented? Why it pops only now?

You are defining a supply property.  When you define a supply property
that supply property should be mandatory if it's physically mandatory
for the device.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--iMP8I05b9K9jEnlX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQIneoACgkQJNaLcl1U
h9Bndgf/XmqeNtC1+eoQRHwNXd1SSMmtD0nB7GqQSiUq0mOP9Gl7Rvks3PywXWgO
ng1krSAq7woA3kfPOQZliJm4M7uRwZNjdqkQs3D3Oas2gMKfAodUuFxCjJtM4S+T
9HNslwe8p7b1IjG2JrsL39jogZsrXfrFMRud7JaBYudEAF2WAVFWCaP8oyzY45cZ
1FBOhNPxFYQ1sdyNprVj908/c/x6y68gqSHIadO6BXt7Tl4sGfnr613+DGf1mu0A
EeMkWnM2alW79dBseTgqcL0W/JZ0EvA4yyr36MF/nRviaegMnTRBwQ+lOlKn+5VO
/LnuaM0R5S1srMHaOIYc8nI3LVmckQ==
=fbRd
-----END PGP SIGNATURE-----

--iMP8I05b9K9jEnlX--
