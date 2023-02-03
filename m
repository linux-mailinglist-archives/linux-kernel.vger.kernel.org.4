Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FA46898C2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjBCMaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjBCMat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:30:49 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A5A539AC;
        Fri,  3 Feb 2023 04:30:47 -0800 (PST)
Received: from mercury (unknown [37.81.13.16])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2BD306602F10;
        Fri,  3 Feb 2023 12:30:46 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675427446;
        bh=tRnEHWrdiPGpL3WlWyqkJA5AZ7qhPuuzCU1KxAH0LDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jRE9B+AfwgMk8w/vQT8GJOGGTcADYUqCxK+SxN6lGLzr82bYUd5tnbc3hh+HdROtj
         vR/EkwNgKLVC5qjv2yD3A3Q+1tZgq2yj7dniDvN7Nsyxcbwms7D+9lQBl1qL90NS7E
         jgFABpCrxH7mYyMlGRvaFjOYGhMxqNDzSEWcv2CfOhgZkuj7StXDGEX6aIu1C74MsQ
         7qF1UAxWtumoGXK7p1wILU48tanR1+S+zmIkvC2x5Fo+KzXRwNz+EsGaxy8ZglSFFF
         B4vR1exmnUBuhXfbwm7Q+aQP8eTHDlF/9cocJvqDu57ivsMZcE+IZ8v/rOpjLyc/+n
         ThonJrSMXY8zg==
Received: by mercury (Postfix, from userid 1000)
        id 1E7A71060930; Fri,  3 Feb 2023 13:30:43 +0100 (CET)
Date:   Fri, 3 Feb 2023 13:30:43 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] power: supply: collie_battery: Convert to GPIO
 descriptors (part 2)
Message-ID: <20230203123043.34vekmsil33zjjrw@mercury.elektranox.org>
References: <20230112140209.61228-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdZLAOfJ4YHWhK2qfcfC7unex0fHRHdxsCRWhgHmkhacAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nrlfkec655zbocdu"
Content-Disposition: inline
In-Reply-To: <CACRpkdZLAOfJ4YHWhK2qfcfC7unex0fHRHdxsCRWhgHmkhacAw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nrlfkec655zbocdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 16, 2023 at 11:33:51AM +0100, Linus Walleij wrote:
> On Thu, Jan 12, 2023 at 3:02 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>=20
> > Finish the job started by the commit ba940ed83218 ("power: supply:
> > collie_battery: Convert to GPIO descriptors"), i.e. convert the use
> > of gpio_to_irq() to gpiod_to_irq(). No functional changes intended.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks, queued.

-- Sebastian

--nrlfkec655zbocdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPc/nIACgkQ2O7X88g7
+ppqahAAqDLkj0OHLxUeQ/juP6aZle2S1TJiYvvS+g5X5CoaQef+E6WWfJFlTVgg
T5XrobIXbfW0JMqPH+fybRySbwrKI5E9Dm21rygG3XDUEaP0VBODGiwih6xV0bQJ
nDBoheMJ6nWfMVqlneeWZTFUkbzr/OquVJddT8aeQob+xvfftnu4fY2K2g+zC/bp
ucAyn9fD4rxaQ+Z4pGnRR+/6+IKnAeTcdnx9ZLAMdp+6iNH3ex7CAkhLqmeD97K+
d0oi/YaaXPMQgchi2JTptVU7siCZmYxDp2iB4AEMnA2f+gAlwqyrYK8hC4F4fIME
UzrSKtdfjq4Xi4h+83StJqKt4XJs5qsstnNMco2FtzLVP93VeFzdwwvq2ToF6QYg
r6sONUKO6ExF0hNNROkF99uHyNUsxrgAMWejWdbi+rUPkpYebDgGk4W6JqWtTDSs
pmk8raVeg6xL/8xt1VLspt0dFT77E/2VZ/9dx0K9CweBFDqQHPmWCOls7cAzptBR
W83tHLBb7osUHQCmlxnit3tbGUpsyiSm0IDUC7B2LkD9vjdlkeCrnlSTBuNkmrYz
kcMrjiob7JnmSPrl50rU1MR2xxqwiMgL5HP0RPM4i3k7WbIjmXocP/n8rpfkpoWU
gISu4Hg39ssXn9KzrjH+Ki+enxnnCu9b8DlrQ4Fa24gi9/aUTC4=
=e4xd
-----END PGP SIGNATURE-----

--nrlfkec655zbocdu--
