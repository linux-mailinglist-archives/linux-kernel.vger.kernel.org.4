Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0FA74768B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjGDQ11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjGDQ1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:27:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BBE1709;
        Tue,  4 Jul 2023 09:27:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A714612FC;
        Tue,  4 Jul 2023 16:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C45EC433C7;
        Tue,  4 Jul 2023 16:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688488036;
        bh=RCmzxehzebrqRgx9G9jdNhWmK0+1CXN/OnL9vYnuNzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QTFTfSfxbp6l2PYD/GBq+4AYTMmWuQ5TLEgcmHsrG5hay+Ra+OvbLtgQ+IYoe9LK1
         rcRRskOA/JDkbDNEIOkkdEMWfI9F2HXuFu0VZj9X3GLBqBIzhDDg5mo+A1VZDBdiz1
         mTTZcVeV2fhu9Po8qvMk2XC39JGYicAdynM9Bn/RUjB2pcGYJVL1ANdpPxdd0pz/d7
         KZM1VsP8lYY+vSsG/nK+USSi9w1tcWXq/dXge1rwAItpYWC6K+vhmoybaIIFfj2b2r
         qsZOSm0gy2Nlk9ScxFPMUq+pyFhorTrEROledeBwzQ81AXIjqej+4st1qZRUJq3bxR
         CnUgyaeoB7Y0g==
Date:   Tue, 4 Jul 2023 17:27:11 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     =?utf-8?B?UGF3ZcWC?= Anikiel <pan@semihalf.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dinguyen@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, mchehab@kernel.org, upstream@semihalf.com,
        amstan@chromium.org, ribalda@chromium.org
Subject: Re: [RFC PATCH 3/3] ARM: dts: Add Chameleon v3 video node
Message-ID: <20230704-denture-pleat-dec490f218d4@spud>
References: <20230630144006.1513270-1-pan@semihalf.com>
 <20230630144006.1513270-4-pan@semihalf.com>
 <20230630-scrimmage-antelope-7d1f82d491fc@spud>
 <CAF9_jYT1Fz4hBQrNtgkM6mU-JVH=ZxsJnkaLDsa5uoEV_hTLVA@mail.gmail.com>
 <df7440e2-58b0-9f12-8f37-4f0d9050f934@linaro.org>
 <CAF9_jYSwDdyE6mj8+1bA23MWmFHdm16jTSYaRQiF1kzpUtkMNQ@mail.gmail.com>
 <e9fe352a-92fc-023b-8ce2-9a82cbeaada9@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5WLOzH29bRZqVRPT"
Content-Disposition: inline
In-Reply-To: <e9fe352a-92fc-023b-8ce2-9a82cbeaada9@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5WLOzH29bRZqVRPT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2023 at 06:23:10PM +0200, Krzysztof Kozlowski wrote:
> On 04/07/2023 18:16, Pawe=C5=82 Anikiel wrote:
> >>>>> +     soc {
> >>>>> +             video@c0060500 {
> >>>>> +                     compatible =3D "google,chv3-video";
> >>>>
> >>>> This compatible does not seem to be documented & I did not see a com=
ment
> >>>> about the lack of a binding in the cover letter. What am I missing?
> >>>
> >>> Yes, the compatible is not documented for now (I'll do that in a later
> >>> patchset), sorry for not mentioning that in the cover letter.
> >>
> >> You cannot add undocumented compatible. This cannot be fixed in "a lat=
er
> >> patchset".
> >=20
> > I meant later revision, I'm certainly not expecting this one to land
> > (I sent is as an RFC).
>=20
> That's not clear. RFC is interpreted differently by different people.
> Some just ignore it entirely, some still review.
>=20
> > Is it really necessary to document the
> > compatible to get any form of feedback on the overall structure of the
> > driver?
>=20
> Depends on the person. Anyway no problem for me - I will just ignore the
> patchset.

FWIW, I was asking about it in case you weren't aware Pawe=C5=82 that you
would need to document the properties, since it wasn't mentioned
anywhere.

--5WLOzH29bRZqVRPT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKRIXwAKCRB4tDGHoIJi
0jGZAQDWQB4jPolKqW8X5dQ9ioDGdBhLx+zbPGKZ4XL1su+RKwD/ZK/JRwBZsIW/
HvRU+5FmDR5N084z2Q3cA8a0IV0YdAE=
=AD9h
-----END PGP SIGNATURE-----

--5WLOzH29bRZqVRPT--
