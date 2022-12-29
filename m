Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA2C65881D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 01:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiL2AeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 19:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiL2AeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 19:34:00 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE42E6305;
        Wed, 28 Dec 2022 16:33:59 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 9CF405C0112;
        Wed, 28 Dec 2022 19:33:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 28 Dec 2022 19:33:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1672274036; x=
        1672360436; bh=HKzN5hcxwK00PMUjeR7lAQ3Jmh4Ntcdoe9XK/6l4nS8=; b=K
        uU2DTEC6dJVU/MTafBwiK90FTSOJgl5tSpZht1i4BXNKq9Yq6aJ2Zjh1FYrc2BiW
        RZr1FMhXUePHWVF1CNPB8LE401eo/6hswf04ImGu0NXbA0Xlqk9XNkUmUJWXENgt
        4fg7VvKTnjwyaAgILvhdZlC3dHR0bZWrfBM6PEp3EeH5UIaD8qNafAuimzAluyps
        PNOeG3PNSr/s21Nh19NEJ96Y1TRAwSpk3wSPdEokqieBw8blw0IITdm4ATfh0ZnG
        axYyisfZbGx088yiIo6IkOFzTkm4yD+WTn+gyEEJkrlpLRvOKxtcB/SRFR/srDwm
        PgItKVhemVSwBnajDS1VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672274036; x=1672360436; bh=HKzN5hcxwK00PMUjeR7lAQ3Jmh4N
        tcdoe9XK/6l4nS8=; b=nbBTGCxuJluFHfLQbvuyn26CJAZlADphWbP3fAKmB5cm
        OlNAS3ejYqXupSip4nrph5f50FpRZIlrRX+Dbt9NuqLYv6171upXdK4KOgRZYnkZ
        PHqjnSxNkz5o8TxpmK2sEyHAp+FXX9BkDtPZbsVjDDUdRj5J5lzXzaN3Hq0pCMk7
        xvcdlW/47kPEFaHwXTdK7wE+l6trX/7SCED8FzlPwfviNgsCESH+d2lbVNeCAWbA
        kjmulbVB+S7+iPWN0m5H/6P2CLIRcankUPF2HxqVRn1C5nMhqxGJq2yOEb1YopZR
        qzWeruXTCS4TfJFwHncLTqh1RsBjvu4O9fEYC5S++w==
X-ME-Sender: <xms:c-CsY-Jpa1cefYBF3gLbbVyD444BEkW7CHQJrDRAuDE2ch3OBB9B7Q>
    <xme:c-CsY2I9K5pZG9dgbi1zR5EthzVlVuPNlc6ZELo4qSQLW-SK69vKWOdPvwKHd25wX
    QDhAx93iIFhSD8>
X-ME-Received: <xmr:c-CsY-uGRwdunNh1jImKb3EIEaHkicuBqOHwvTZFRoaZxqAgOdPH_IsTno5D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieefgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtjeenucfhrhhomhepffgvmhhiucforghrihgvucfqsggvnhhouhhruceouggvmhhi
    sehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnh
    epvdejteegkefhteduhffgteffgeffgfduvdfghfffieefieekkedtheegteehffelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuggvmhhise
    hinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:dOCsYzYAM8wSDLQ6NQiOpdC-nywvJzLmC59JIpOLnQiH2Y1DCKvfpw>
    <xmx:dOCsY1Zf8wV8efGGSHlL6Xf0FD-Sh9JWcqgGwSmPmLVP17KZw3Mj_Q>
    <xmx:dOCsY_B3dShw-NkJGVnf4s3JPPI6XDfDNZ-K4MS8Vu5QxIon2D6gIA>
    <xmx:dOCsY5Hr-nfY6YIDIvcr2GGDCXgMrkoE0aqRimOJ_-t7RrTyL1LY3A>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Dec 2022 19:33:55 -0500 (EST)
Date:   Wed, 28 Dec 2022 19:33:50 -0500
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     oss-security@lists.openwall.com,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [oss-security] [patch] proc.5: tell how to parse /proc/*/stat
 correctly
Message-ID: <Y6zgcTndt4Ss6/6/@itl-email>
References: <Y6SJDbKBk471KE4k@p183>
 <Y6TUJcr/IHrsTE0W@codewreck.org>
 <1a1963aa1036ba07@orthanc.ca>
 <20221228152458.6xyksrxunukjrtzx@mutt-hbsd>
 <Y6xzIR9P+a6uaaEx@itl-email>
 <20221228172517.l7h3m7wjfpxr3dzw@mutt-hbsd>
 <Y6yEv+6iYQQNaqi9@itl-email>
 <Y6y/0uzFlTpkw/VT@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U1zMNkwBbrv0FFj2"
Content-Disposition: inline
In-Reply-To: <Y6y/0uzFlTpkw/VT@mit.edu>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U1zMNkwBbrv0FFj2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Dec 2022 19:33:50 -0500
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: oss-security@lists.openwall.com,
	Alejandro Colomar <alx.manpages@gmail.com>,
	Michael Kerrisk <mtk.manpages@gmail.com>,
	linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [oss-security] [patch] proc.5: tell how to parse /proc/*/stat
 correctly

On Wed, Dec 28, 2022 at 05:14:42PM -0500, Theodore Ts'o wrote:
> On Wed, Dec 28, 2022 at 01:02:35PM -0500, Demi Marie Obenour wrote:
> > > I think the argument I'm trying to make is to be flexible in
> > > implementation, allowing for future needs and wants--that is "future
> > > proofing".
> >=20
> > Linux should not have an XML, JSON, or YAML serializer.  Linux already
> > does way too much; let=E2=80=99s not add one more thing to the list.
>=20
> There's always Protobufs[1]!  :-)  And all of these are better than
> ASN.1, for which Google already has a limited parser (for x.509
> certificates).   :-)   :-)   :-)
>=20
> 						- Ted

Cap=E2=80=99n Proto is better than Protobufs :-)
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--U1zMNkwBbrv0FFj2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmOs4HEACgkQsoi1X/+c
IsEIgQ/+Pco7jrnuvj7VgymwTpedg/FPOwiYyFGufCerhIOsAEicXgmVmAJL8nV9
yzex5oy5B/e7gyykxdwOC9MCQU2rbP1VIlIfQ8oT3CzD+aHHheLOCh2AuX2xI5bX
kpIj7ZMJNb2cvvCLN7ADgg3Z2vUQZWVYTzIkdfBus5S+AVBl5uOm6OihfmJu51OJ
WQcCT79Z2bb41xFHTJdE2UZQ56Xg/nOwxPDO9xqt396dJGeweMd/WRM15eMJS/d5
LmTvHuER0etr3UYr+GmRwO4btSnbhT1+WHZVdyOIK9Nm8oT3eDgMfJG7yEdgekId
7/pGXZTwuBdil2fnojBu3VLC9YEbu1GGhKDQ14Ai9hPjia1S3yalpKTiqEyJg5oe
H/RIEJMUZY5Km5DSypejrkyP8MOuUd5m6Jn2lnd+TsHAG/5+9iLXqCEKGqV457VL
zdwOA8GjJmzXFX75bcefA98qpdcQ9b6DHn2MTJy/2YaRkI6bJdUmzyfSP3o854Mi
o9uiR+MjXi8oEc3FclNyCfUtgvUywqXlgPe6kI1k4HoDdTvabXZdUZ2skLBrL96K
Yfawnff9C2dBE5MQNSjSVtGhfoo8Mt07YYwCPUSB0s9rDyN8+IwNxYizQMYaf7yj
Z+wN6R3ZpXBudktJ43W0NVYR2zpp3DEuNiyJt3fyZS3CFdmVjo8=
=Hb8y
-----END PGP SIGNATURE-----

--U1zMNkwBbrv0FFj2--
