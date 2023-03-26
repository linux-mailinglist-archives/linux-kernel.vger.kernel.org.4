Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FD06C97E2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 22:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjCZUqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 16:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjCZUqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 16:46:16 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3484D61AF;
        Sun, 26 Mar 2023 13:45:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pl7JG3ZNPz4xDh;
        Mon, 27 Mar 2023 07:45:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679863550;
        bh=MBiYj0bRGns5gjBtv2r4tggCzuPLZu+E2ctr4HdtD4I=;
        h=Date:From:To:Cc:Subject:From;
        b=AOI2hZhB2AY0kIMUNl8y51U3LXHQNz4Sh2Z+vAOz0gYTfL+O0HfTm6htfVzhA5Hlx
         Cu41djZ39zHx1H1CE3itsr+F28iqNSpryXOH4PRVbWUxzYGMjAucbqYzsaNwpJwXim
         uLAJklaWZRXvPud4PNx97lnD8uZOWWJAz1KozOHkl3xwI9HXs2up1wArMU9Ij1K+DO
         ubN+fp3Vjlx2eAUtk/A4npGXWjQnujbyi2r4A/9cojELiPDX0uZ23lCSGVnB675LDN
         HUhq5QwA6AFhLhNvcomrRO3JcjvGdn86gUYZSBoRCOTATOKANl9tBiAac3T8OMmVQn
         dsvgdy/fnBrGQ==
Date:   Mon, 27 Mar 2023 07:45:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Aymeric Wibo <obiwac@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the pm tree
Message-ID: <20230327074547.5c418918@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/j6KsuxawF7a+nPLB0dJsF6e";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/j6KsuxawF7a+nPLB0dJsF6e
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  bb796d5112d2 ("ACPI: resource: Add Medion S17413 to IRQ override quirk")

This is commit

  2d0ab14634a2 ("ACPI: resource: Add Medion S17413 to IRQ override quirk")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/j6KsuxawF7a+nPLB0dJsF6e
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQgrvsACgkQAVBC80lX
0GxSzAf8CDKlR0XJodCjXP09R/8llGS7L5Uo0Z7u31vGT2IFu87vAX3vc7LNkKsb
AsD7PZAnVd/jxm8Bzt9AN7ePxLpDHO0vHC3v23HYQHrHYa+tmVZlEddUuxxRWqyN
veZqUVrnzWmDkD/H7uPLIfWeTrtojYqSEndfYLVTLMsM2AyNPdFK2+IK5O8PvTdX
J+l1TyZ0a18CinoHaROp1/AaWDpd6vLnikgkffy1+s8AGSAkzsbPIsAewgWQj60S
HkmbdwTq2QQkvCRQtUrMyGHei5DTZz98S8zoWsyeS//2ONCEu9GBc/Nw8FExwqXU
LarO+GyQylFRU2KT60BoRw3PjTQ/Gg==
=I8y1
-----END PGP SIGNATURE-----

--Sig_/j6KsuxawF7a+nPLB0dJsF6e--
