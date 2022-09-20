Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FFB5BE0CC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiITIx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiITIx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:53:56 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9B563F34;
        Tue, 20 Sep 2022 01:53:55 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id EC9B01C0014; Tue, 20 Sep 2022 10:53:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1663664033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9+0lxj3NKSAFfXCMyFBgO9m2yXNCwFpYQWCCNeJFixM=;
        b=ppFmz965Jt1MKTLqFB8yqhBiVocW9ij6FOEu/YrijWYXzV0sSCVb6PLEtv2wHAWkAsfcuv
        OxcXMRFzyR6Ishz77m8Gxn8NWJzSqjmnPhuF8PngRQuEBToOIUmd3NhDdW63gOzVCPEI08
        T7Rx6GRpKZ8Et/XFsb6Pd1CM2kTWMM4=
Date:   Tue, 20 Sep 2022 10:53:53 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: LED Maintainership
Message-ID: <20220920085353.GB17087@duo.ucw.cz>
References: <Ys/kruf8DE4ISo8M@google.com>
 <20220714112326.GA16407@duo.ucw.cz>
 <YtAIm+X2XchcSkFX@google.com>
 <20220714222541.232eadfb@thinkpad>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline
In-Reply-To: <20220714222541.232eadfb@thinkpad>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > No problem.  The offer still stands.
> >=20
> > I guess Marek and I aren't mutually exclusive either.
> >=20
> > Any harm in us both helping out (if Marek is also interested that is)?
>=20
> Hello Lee, Pavel,
>=20
> I am interested, but unfortunately I won't have much time for reviewing
> patches until september.
>=20
> From september, I would be open to co-maintaining.

Ok, lets do it? Do you want to submit line into MAINTAINERS file? :-).

Best regards,
									Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYyl/oQAKCRAw5/Bqldv6
8nfXAJ0ewY50W8i0N+j3a5s+/EP+oti/SwCgmKQlLdCPs8MdwwQXGQxuOV6Bp2k=
=66FO
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
