Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF6E72D4A8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjFLWpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 18:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235766AbjFLWpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:45:39 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FAC11B;
        Mon, 12 Jun 2023 15:45:37 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qg6GN1T8Mz4xFn;
        Tue, 13 Jun 2023 08:45:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686609932;
        bh=Q9gUMGKZiF/GmkEjStXgBf+odj1jwLyhIMrBLGi7+QY=;
        h=Date:From:To:Cc:Subject:From;
        b=GEUMAPwAVftsI046YzsO00i3BMHHe6YkXSZrmwD1IxdWI9o0mBTpzRauo0tDluetr
         UgIv5w+iZrAwE4jRN/7XFsuMpo0tCp98bOR+iHF/s69LtltmwPfQNARPBBCHszStJe
         XwP3CAT00qeAgvxXRaMzf3Lny8XtdIwxObj7n1I/T8PLuYzGEyPIati2rPy+wQWCkb
         866qoYC7AmCAcdwG5lAhMI3cHg2zJ+g6Ge1sOvpUgVBuwhH5HUYlnwZt3pMfXV8ZO8
         Mrj2XkF0pu5QowT1TjZ84T9Bn3UKC+hOqyHsL1C8T4SbjaSefsmRipM8jJwTT7nwAG
         bCHcIN2KUUHIw==
Date:   Tue, 13 Jun 2023 08:45:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>
Cc:     Max Tottenham <mtottenh@akamai.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the net tree
Message-ID: <20230613084529.6b655b51@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/n1tbFaLxDzRBxDKlwFO.cVA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/n1tbFaLxDzRBxDKlwFO.cVA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  6c02568fd1ae ("net/sched: act_pedit: Parse L3 Header for L4 offset")

Fixes tag

  Fixes: 71d0ed7079df ("net/act_pedit: Support using offset relative to

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/n1tbFaLxDzRBxDKlwFO.cVA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSHoAkACgkQAVBC80lX
0GxyeAf+IT+eLTPi5kMIrzQI/aDkDPe/OCoGjVzZsSEUa5gYrvz64LjGzsBqJscY
HQifo/jv3qw7uOeLq29VxE87yOYjEKRJvrYZcyOvbvwnCFl5ykcx9Xo6QgMVDSJD
QHNbfNibkiWYQfQGAIwvVph2Cl7stm4UogRxyhIU4OcKoPVCXUzEuow0UNJk2jch
Bx0bXTqh9mapawtn4kw4B8ndMSyEt+ZGHp5kcpa/jl87tfw0mgZLtEsC4E3sjf2a
ZRtLC7Aqrgs7kdeqoN5hp4rnwidgrOQDQeNCNTr4uzuTxWWt8iZNMMNHP0WEz2ux
i2iQLK0dE30L8xCVCGzFryTppGwf4A==
=pHEh
-----END PGP SIGNATURE-----

--Sig_/n1tbFaLxDzRBxDKlwFO.cVA--
