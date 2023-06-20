Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666EB736C42
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 14:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjFTMsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 08:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjFTMsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:48:13 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B083B173B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 05:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=UGG2NOVdwL2dCFaLTao2cwbPwKAX
        UHAHYKv4jN1vaT4=; b=LzxWT1KSl7eNQ+h8Fzuw25bFWPu43DnJv8C5LmL6ro3F
        nqo9pMlKwySt1MemIximHZ70zBmDDlsOxMqMtPNrR0UZmCc9UD+P3YY1E0p+luJU
        nUq3esACKw83GVl6HiDUotRCsgEsiGKnj2BQlED2r1somnyHsL+RQXEEiYIxDcI=
Received: (qmail 640741 invoked from network); 20 Jun 2023 14:48:01 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Jun 2023 14:48:01 +0200
X-UD-Smtp-Session: l3s3148p1@u5N4D4/+lM8qAjA1AANuEAx0Qv/+XrFS
Date:   Tue, 20 Jun 2023 14:47:56 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-renesas-soc@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/3] arm64: dts: renesas: ulcb-kf: add node for GPS
Message-ID: <ZJGf/N8NKYpiT63P@sai>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-renesas-soc@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230620103909.37582-1-wsa+renesas@sang-engineering.com>
 <20230620103909.37582-4-wsa+renesas@sang-engineering.com>
 <CAMuHMdXbpBeKNL6QC_vYTrocf7xPcvUBQmoV9vboqVt_ciio+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4Lvn83wzYSq2Aj45"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXbpBeKNL6QC_vYTrocf7xPcvUBQmoV9vboqVt_ciio+g@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Lvn83wzYSq2Aj45
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > @Geert: Not sure if we need so many fixed 3v3 regulators. Most of the
> > other ones more or less directly derive from d_3v3. Or do you prefer it
> > this way?
>=20
> Probably all of them should refer to &reg_3p3v instead...

Yes, I like this. I will refactor it into a seperate series.


--4Lvn83wzYSq2Aj45
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmSRn/gACgkQFA3kzBSg
KbZUcQ//VvO1U0KyZNgKxH+Rnd+zJrEFLy0pIx8eUf2v+dx7bG0H9bWcMSSjp8vm
m8lxcaWUMymUpo40jFrihe1is4PHAV8Jn7tmvp2N2VBQ7mQlOSaJGJ6W8Tw0Vvp0
69+885E0fn8bAwtsMUQ1WAqGy4l4WoSR5KwEc4r+jHHgQMl+TxQ8Xmt/+ZiZzI9X
CZl656GPnQdPhukZHLSgA995ucaV48kw6u74sp3ksymfOA5dqtIqrdtg6J5BoCAt
6zWWCdRq3L8v6qTkEodIckJ3EvOAdUtr3zcmlNmYcri3r9UgggddQ6ubWMrJk4+u
A6hiXfdJ45ZBt43QbxvGEk7JP6Ko+clztIl9ZR+fve7Yw+vASLoc/OSx6Uf8WoU1
EeAgE1nr8b837y2GDAlfuS/WPgkc7S2o48nd+nZZ7FLW5D3HZ6JXrQqNsGEX8QTz
gUuqLRUsPOvUL3HU7IHJ/72KTPA5QqdRlijP2HKyNyb1Dp4bzk1BBo2QyErULWCT
rBSIG17mU5g8yjpfjdhvW5hGUBD2p5ctLbPWqcZKKDowP+ft0ZHOvA8LsMMMD1GV
JyEkTnr/HXfnYBtH+rqv/ZEAc+kqZ8dMsvr8WkiA2QThfutUPWp3XjF2haubN9U8
cpoO/fD4mt3s8SNE9uq6nvCWqstbaOQkVh/tsqMW/4xe0WvyTko=
=Zobi
-----END PGP SIGNATURE-----

--4Lvn83wzYSq2Aj45--
