Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119D75F96B1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 03:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiJJB4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 21:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiJJB42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 21:56:28 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B4F53015;
        Sun,  9 Oct 2022 18:56:27 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mm28B1wwBz4wgv;
        Mon, 10 Oct 2022 12:56:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665366986;
        bh=9Sj4AJOvCoxdZlWbAoaJjtKkOrplNPUXAYihZ6f1HbA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ngEIDF0c2jkb70mC8LwAxNRH8Hi73Scdw9LBtoaleCBgS7DJvsYDo1KE/cxgQWEUG
         KTfNpF+KO7rCYUlsvAwL0rCcZJjGjvRyaIhhLQJrke4zA3AHo6b25jxxDjxW/+onoh
         hmSsACPB07uVQ2y95jgy1hEsNT7FN27GhAlnqkUjMs48msCB9DxqEVv056JbqRbZ9u
         fI+WkPWE8fvU/rerhodMa5KerEmbUmiKmKIxOrRuH4g3QgWKFueCG3fdCYm7MFg20t
         PPXvB6EG/iFg5Mo61PQc74JFzsUmJ8dNj1lju0Iah8H7t0V2h0e5HOv/c5h8hz5Rke
         VATQB+4UnXpSg==
Date:   Mon, 10 Oct 2022 12:56:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the mm-stable tree
Message-ID: <20221010125624.7030e208@canb.auug.org.au>
In-Reply-To: <Y0N3/wtn3dR2h6TT@monkey>
References: <20221009193544.27055db5@canb.auug.org.au>
        <Y0N3/wtn3dR2h6TT@monkey>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Rm.eE64/6Ha4GBIO7rLK0pv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Rm.eE64/6Ha4GBIO7rLK0pv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mike,

On Sun, 9 Oct 2022 18:40:15 -0700 Mike Kravetz <mike.kravetz@oracle.com> wr=
ote:
>
> For all of these, I was under the impression that the SHA1 of commits in
> Andrew's trees were not stable and could change.  That is why I purposely
> did not try to add SHA1s to the tags.  Perhaps that is no longer the case
> since Andrew is using git to manage patches?

I assume that once a commit is in the mm-stable branch of Andrew's tree
that the SHA1 will be fixed (except in exceptional circumstances).
Andrew?

> I see that a pull request including these commits was already sent to
> Linus.  Not sure where these are in the process, or if it may be too
> late to update.  Let me know if there is anything I can do.

Yeah, I saw that, and as you say, we must just have to live with these.

--=20
Cheers,
Stephen Rothwell

--Sig_/Rm.eE64/6Ha4GBIO7rLK0pv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNDe8gACgkQAVBC80lX
0GyFrQf/fLFjSeIbY2KJtUtfKIUdPnubF4wV4yxhZSgeIBgq3iry2WV9qPsuiOmj
BiWtgRAEvKOCTbX7bdBFswbOFQ4hnT5gpGupMOLg4pXs3H690RNfUYC5Z4Bxbdcu
mcDSeIoQk3JF/0jgg/98JAAiXLPn3ESeeIRkLuea64KhZIGDk8XVP2DZABc8D14+
/zBJNS4JA1Wu0/5QuVT4NTYDvGZu3D2Nn70Lqg8pKYvNKxHny3OCxHTjxGjfFZ+V
y5YIYu5NjDia2GtDrSeskYNhxtcXdX+4JmWGTGuyyh/a18NQVjSEXp2M/NKan4zJ
efCDJh6Qow/ur6ltBoXP3MzEIx6ddw==
=vBZW
-----END PGP SIGNATURE-----

--Sig_/Rm.eE64/6Ha4GBIO7rLK0pv--
