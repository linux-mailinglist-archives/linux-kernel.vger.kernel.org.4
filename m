Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBFF6F5812
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 14:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjECMl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 08:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjECMl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 08:41:58 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F903C3C
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 05:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=X3tUlSz3dSAffugcIZ+Uj1/P+oIS
        afwL3g0TfB3tmJ0=; b=P78bqAhjFK1GzEX/vJABw5XQWwFshnU0YTd3nh1+APGq
        gsHKT0N9IO2qEbIeAaa/r4Ul412NJAyyMg33WlECLl8OAKh+Bo5LF3SJrMDlFfGL
        SfJMmjWU4FMje782IGWzv5RmMZm7eJd8P1OLt1ygkXnkYdyR9Z3Stu0QuDiBOJM=
Received: (qmail 85230 invoked from network); 3 May 2023 14:41:52 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 May 2023 14:41:52 +0200
X-UD-Smtp-Session: l3s3148p1@CTlcYcn6gMMujnsI
Date:   Wed, 3 May 2023 14:41:52 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] clk: renesas: r8a779a0: Add PWM clock
Message-ID: <ZFJWkOzqqLXWReSk@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230502170618.55967-1-wsa+renesas@sang-engineering.com>
 <20230502170618.55967-2-wsa+renesas@sang-engineering.com>
 <CAMuHMdW9OP-C2iN97ntNJ7hjgmtY+=NQ=Hi38kPrd8ZUoafFjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZEp4B0SCCdKcvuth"
Content-Disposition: inline
In-Reply-To: <CAMuHMdW9OP-C2iN97ntNJ7hjgmtY+=NQ=Hi38kPrd8ZUoafFjw@mail.gmail.com>
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


--ZEp4B0SCCdKcvuth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +       DEF_MOD("pwm",          628,    R8A779A0_CLK_S1D8),
>=20
> Do you mind if I rename this to "pwm0" while applying, to match the docs?

No, feel free. I think it is a bit misleading because the clock is used
up to pwm4. But if the docs have it that way...


--ZEp4B0SCCdKcvuth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmRSVowACgkQFA3kzBSg
KbZwMQ/8Da+knJJl+Iwb9eg/Y64IwbqrMa+2VzsXUxeRY5sC+MWuwEQ2diC66wmZ
LJyzSyeix0zb0nr3/J6u0kK/oqaK4vtyw4psLul/9hAOq1v16FhDIxSJSkRcVPrI
yE4/5EzRqbH+cat8lGrixdItNwwmyedwgMJdiVrsedYbX407NOJlxbDPtzfGHF0B
80KrrihPwqqSH7IYiHR2278W48VjB2ysJcCAItSXl/Y8qUgIUNXY2pUS0J/9e0zq
pbgFPtk8DgkBFlcDq+oN/SFr+LY9krWtJ/ebNUy1zJkwwz4F0MgMc1KdnRkiiiJw
UvQnSCS6zkFfkZKThH9cvuHXXREvfflZVfFdGp1mPMDu59Cy20MX8O6GAztn5A7R
LR1UoDcPuGSGL5bSmw9KIb4FB2c8kwclZWWYy9C4axmrEQnb/zoowOwk66d1dEi5
LTnBqda+7o79Epdq4qdjSl6ebADlVniiSXfndJoDt2LwI11/gMOT8EQGprMWbj0M
JtI04BUdLKXG0G2fMomS1/Scv1BjxZkdr+avvExcirohxXSPmhJn4lhJwmAOJ2KG
hsCID+uirmeRGwp631mUbZ3gECTNAAed2lE6z4Fgnibc23Cz4M4VNYai+sILkb1z
dWzTtKtBbgt9KFLCGMHSF0KjoDlJx/Alkl8lUtl6gXvlzRuIFG8=
=0dPt
-----END PGP SIGNATURE-----

--ZEp4B0SCCdKcvuth--
