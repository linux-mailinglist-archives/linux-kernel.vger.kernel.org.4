Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A082C6F8251
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 13:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjEELwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 07:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjEELwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 07:52:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB231387D;
        Fri,  5 May 2023 04:52:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B6B263D81;
        Fri,  5 May 2023 11:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09619C433D2;
        Fri,  5 May 2023 11:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683287557;
        bh=hWgrq4PVk1KU2XGCVuo0Pah6GURPLB+1toh9U5Jz2mk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O3egb8XlhjEu9CRfQwi00mB60WzQTyxTyEu8vq8WOf+pbBDXg802b+0pvI6Xe6gC5
         bv6OnCoP6f3qcpZFVxqLfrRVXbffgbtpPklT61WP/Xos8zcJQqMvqvpiInEHwUtu21
         p20SUovVPVAS4WEwrNdS/XWwAr6lAOGOUUZRdoFnWMRndZEBkKCHJ6cu/b9JWG10Jp
         CpLHtp3MYpSfBXORmxw9LhRoaYd+c9HLtm7g0Yr2Rh3ARj37yyGcWwLEoPFBFZ1MDA
         9fcFAYdOKsCBkXmPQTflvJrtRmragVakFDl0BDO+NsfGbZvUGZmFXr0eBDWd4l/vbD
         5PkwfEeJH6SFA==
Date:   Fri, 5 May 2023 20:52:33 +0900
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?M=E5rten?= Lindahl <martenli@axis.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@axis.com
Subject: Re: [PATCH v2 2/2] regulator: Add support for TI TPS6287x regulators
Message-ID: <ZFTuAZvnvY2sSXrm@finisterre.sirena.org.uk>
References: <20230502-tps6287x-driver-v2-0-fb5419d46c49@axis.com>
 <20230502-tps6287x-driver-v2-2-fb5419d46c49@axis.com>
 <ZFOfX+PTsmA35TsC@finisterre.sirena.org.uk>
 <e02589b8-118d-0feb-d32a-bdf39d1b88f6@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EhXQxqQUrxVHaHKj"
Content-Disposition: inline
In-Reply-To: <e02589b8-118d-0feb-d32a-bdf39d1b88f6@axis.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EhXQxqQUrxVHaHKj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2023 at 08:46:06AM +0200, M=E5rten Lindahl wrote:

> 2. Dynamically set the range when a new voltage is set. This way any
>    voltage from
>    0.4V to 3.35V could be set if the DT node has:
>    regulator-min-microvolt =3D <400000>;
>    regulator-max-microvolt =3D <3350000>;

You can probably use one of the linear range mappings with a custom
set/get which munges the range selection and voltage selection into a
single value.

--EhXQxqQUrxVHaHKj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRU7f4ACgkQJNaLcl1U
h9CwRgf/dLKlR6BbmRLBx9RkkjxLLVQsUb/7LgmfuG5a3WXf1nTeYUm//FhETl2F
D4b28YC0p6VDKaeJmdrCAEzlHIIAFuRocUmy35a7LTGWXYVdL+QNCPxjVWWQp/FM
T41gzibx3OUFHeApwf82Sqte4yXCFN48cMtaO5R8chBS4oK94IeedoT6fsoYvbrq
oSoif1Ar+YxLN5PLbNRaUwOsapZPbb71NMtMPDW/f7mYLRe/zC3luSgfykTsGPfx
QfzU4RuYcSDQP4uPCkgZG/X6IdB+DQ5O4XONRkuG5qJqP3rlbt/2yYaWNMKGzrVf
qI7tRrSPNwYOESI9roSrjW96K0BmPg==
=qybo
-----END PGP SIGNATURE-----

--EhXQxqQUrxVHaHKj--
