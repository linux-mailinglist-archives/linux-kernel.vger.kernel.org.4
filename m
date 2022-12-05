Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18F16436FC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbiLEVlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiLEVk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:40:56 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4511425EBC;
        Mon,  5 Dec 2022 13:40:54 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NQxmw4Xb3z4wgv;
        Tue,  6 Dec 2022 08:40:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670276449;
        bh=bj/9YMHqJCCVv195EGHZoWZDT+Qa0ZVxlDMji/X3sUI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n9qgymWgpbPoiDk3AJrp3fBYqJASOzUV54DpZcSbc51MZfRHAvb05OQ2bSj+NrTHV
         sLfIk041B+EWGFvWTV/5yA81M3zDX6u4icfcHdScJfJRwFQSF0RQb2M2TgSDTAj7xT
         xNcq+Cna49QdpRPDv+23782/EVjTuBUIqwL5xeds2Pm2GbbxJGDTjBAItx6J1fp9FP
         /bCczgAgpM926fVXj0b+1RMUfDseMYIHPsX+clldRVF484XSzEITbUTVMHCtLK0EdG
         L5fuNUgZPKou1x3wt+w+8kiuw32aFpA+5XiG3DqoU/GlA+hrLPyH52R1oSfCpDL6QK
         osDrXaUQehf3Q==
Date:   Tue, 6 Dec 2022 08:40:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Ben Levinsky <ben.levinsky@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michal Simek <michal.simek@amd.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: linux-next: manual merge of the rpmsg tree with the spi tree
Message-ID: <20221206084046.020e03ea@canb.auug.org.au>
In-Reply-To: <Y45MpxPpWBSkBsyp@sirena.org.uk>
References: <20221128134120.0afdceb3@canb.auug.org.au>
        <CANLsYkw0Nq38rZzGTTpCL4J3aWJQpX32iOe4zdTT0+CcfhcOmg@mail.gmail.com>
        <Y45MpxPpWBSkBsyp@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/S2lGb1uH3ibi7K8ZXJB/PPE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/S2lGb1uH3ibi7K8ZXJB/PPE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Mon, 5 Dec 2022 19:55:19 +0000 Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Dec 05, 2022 at 10:24:48AM -0700, Mathieu Poirier wrote:
> > On Sun, 27 Nov 2022 at 19:41, Stephen Rothwell <sfr@canb.auug.org.au> w=
rote: =20
>=20
> > >   1e400cb9cff2 ("firmware: xilinx: Add qspi firmware interface") =20
>=20
> > Mark - since this is in the SPI tree, can you send me a pull request
> > for this commit?  I will do the refactoring on my side. =20
>=20
> That would basically be the entire SPI tree up to that point since it's
> all mostly on one branch...

Both sides just need to mention it to Linus when you send your pull
requests - it is not a problematic conflict.

--=20
Cheers,
Stephen Rothwell

--Sig_/S2lGb1uH3ibi7K8ZXJB/PPE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOOZV4ACgkQAVBC80lX
0GzIYQf/SYMRngv9pUYycVE9ytTC7tm0BORJ14YbhSXypSrQsczbkWKYjW61ga3m
685lyMDsH18g+SV/zsTpcbe7F9GdHO0mWBo9eoNHJepmCGDRzz/tnOlZc1W7jJLT
frXyxRQ4nHEvOLykMTAsI0d7LJvByn6AT/4ESVK09hqY5MZQVOoTxUY6tcSzrK53
0rVFjqliVzNwHTSpOPRRutP4y1xVbTvJYBUXEMQ90hYNu/livDG5YkGkq1A4dRWY
b3PTjJ9cgHE6zBCEMQpgWOZEnAVCrmaoCr9jvLp7XHRnOmznV727bOMDWEuS/FN8
EJg8WB4C4wvZAxgKn2MbZivWoaCLyA==
=cRXS
-----END PGP SIGNATURE-----

--Sig_/S2lGb1uH3ibi7K8ZXJB/PPE--
