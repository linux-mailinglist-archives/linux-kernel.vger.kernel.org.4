Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3B569DAA1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 07:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjBUG1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 01:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbjBUG1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 01:27:51 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3281BF0;
        Mon, 20 Feb 2023 22:27:50 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PLTqS5RqYz4x5c;
        Tue, 21 Feb 2023 17:27:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676960868;
        bh=z5JUuzgolO0JnZdKJPjwTey83ElaqwANPfDAGhsttok=;
        h=Date:From:To:Cc:Subject:From;
        b=smX0s7eWvQhFVYEjxYyxk2HfJmho0yRBQ3QZ1L5EW2zbYwcYVRbqqKE6V/tIDWl1N
         YELX4mqYSr2Y8eLgrlBA7s/OCmFkv5/Z8w+YB2CtO0GLrVXI4pVLNm31h/+Ap0mCz9
         IXWjhVvNqhyzcR2FS1PVDdP/fy7TG7bi/unh+LZAuLk57lsEe+/ECO7pW1NedmfNVU
         EShRQYKQNT+gWWC1Ro78eN9BEsvcWE3qZuOumXWqdM8v8HWWxlldN05NmYzLrxNVVI
         PkDA/H4w+sbldQ0c9YjDqYtHju/TWy54mMy05Tq4h1UG0HcKlloqjelOi3sjGHAHrR
         q31//QfRpAgTw==
Date:   Tue, 21 Feb 2023 17:27:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lee Jones <lee@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the mfd tree
Message-ID: <20230221172747.1f221ba6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/j74s1Xw+iaH.qC036NnaJzI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/j74s1Xw+iaH.qC036NnaJzI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  c79f9e7253bb ("mfd: Remove toshiba tmio drivers")

This is commit

  8971bb812e3c ("mfd: remove toshiba tmio drivers")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/j74s1Xw+iaH.qC036NnaJzI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP0ZGQACgkQAVBC80lX
0Gz1nggAlWyzH9Y2griqgCjvs5lMR1/1EftwrmJlz2O6qaFV+LSnSWVIGrxNA8bF
ccF+aKnSmKjWWK/fOsCMjDQqWdfdVIA+DyoL0Lrgs0tG7uzUsbs6z2cazFAAZIYR
S08l8vF109VFevYRDTei0TJhVs+UB+oIOirY/pB5tHV08eBDSHdgipC2+ytqQig/
kWYbNLwXoW0029SdS5E3O4utIFPW9YFi36bxcHu5DHKcI825vh1gM7EZunN/tT+n
RTk6r/RlD37MVOVxwCmt2YD3QYNUpXvgqQU9hYNfbhrlCMybBjcNc/4CqcCTGw1m
2RIZx/gypWnIHntmdIS7pecd3QUBEA==
=3A4I
-----END PGP SIGNATURE-----

--Sig_/j74s1Xw+iaH.qC036NnaJzI--
