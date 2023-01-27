Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F4E67DD04
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 06:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjA0FJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 00:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjA0FJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 00:09:17 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A13834329;
        Thu, 26 Jan 2023 21:09:16 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P35GL28F9z4xGM;
        Fri, 27 Jan 2023 16:09:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674796155;
        bh=oyvYq/rnPJ6Ikzr/O72Nrz44EJkmyLrzNOYT4oDOEvg=;
        h=Date:From:To:Cc:Subject:From;
        b=aJfHHeaqDcfX7kFX98QqBMcz9VQzq8ppDHdYgRUh23O3HfIYyKEbg+ZAWD2TLVGLV
         eRudjNl03sQ1EecpZyjPVoVhA0DOj/mWwMLaQebFJ5B2A8qS8SHYGnzm/2H4LLy5gN
         aiU6LLiGq7qIfx5rkSqNygA3W6fHk3GErQfMKw/a2+t6UgdroEFlcu0FYVY348tIhh
         5vdZLgmiRvxB8D1iKknA+NL+3phy78BgVQ9gseWluVd2O5d+6cJezhe1Pn75z7vFsx
         8SFutJ5LypamaIWq7EGolyVpLnSuwccLBkSJ9JyizfilFvWe6Zy0Lv5otJK2DPvuJu
         m1J0cNNakS2uA==
Date:   Fri, 27 Jan 2023 16:09:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lee Jones <lee@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the mfd tree
Message-ID: <20230127160913.7deebd22@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lJTMJh6_EIjD0WGjUOa+wOj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lJTMJh6_EIjD0WGjUOa+wOj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the arm-soc tree as a different commit
(but the same patch):

  dd77f5fa97d3 ("mfd: Remove toshiba tmio drivers")

This is commit

  e9b016cfd62d ("mfd: remove toshiba tmio drivers")

in the arm-soc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/lJTMJh6_EIjD0WGjUOa+wOj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPTXHkACgkQAVBC80lX
0GyHlwf/VATY64RaG45l5zcjtbVL99aZaKmo8Gqy7QV9ocuLNfrXdlD/s9/jXf41
wVUBkYC9sAGjlkxVNNTEK6XjKAb1hTpjHhLYPFH3L3nHsKr/tcYLNeIooXXicySV
gJYNOvInwlnNg0mgV53Ah8lBTLGHAfMIqvPATa9wh4XkMJQPzttwyaygrrtcjRdR
wZ8pLQFjZLciZJyUZBnJW52MwkcH9Jqqd8qhz3+j9J7QegcvBDtv7LmlglZ8vPW2
TeALEVBZUjgybcOaVa3O8mwbcq1SpwnrwQe9IGh9IKzosfwqmdvMPxns5rdV9rLT
LRjJ8yC6YxWsiwXgP9onXzhNXd72MA==
=T4pO
-----END PGP SIGNATURE-----

--Sig_/lJTMJh6_EIjD0WGjUOa+wOj--
