Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EED6B83EC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjCMVZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjCMVY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:24:56 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A16974A;
        Mon, 13 Mar 2023 14:24:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pb8nD4Drmz4whh;
        Tue, 14 Mar 2023 08:24:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678742689;
        bh=49Z5LbfURM2NX8MgA5xOiZWhh50qxatzeNYv5gJoiO8=;
        h=Date:From:To:Cc:Subject:From;
        b=qfQP12JNXjv8gFWi4QuTV/xoXFJ18hvgH61BIxEeoBP4RzS4D2EU67mqtHA7dFqZc
         NO2YeQ9WCCF/jE6lVuuzdvAPzc0N9GBbHJPz0/9CE+gTJxOIfgBImI97On0XCUaR1j
         Ar5dXujo+fqaxNRJAB0trQzdUYBzGM5vkYQCTLeEQCyBr0rcrEs8v19i0tNqlOfGXX
         Yxwxzj6PjpXAzIw7Cjv2IqDLUwILelbC5JueTYYUG/v6WRyEPR0yN7Pb47GlAdgdAL
         Re7U1A2wSbHg6lNt5PUCw42YSCPxlodIF5mbA1HK2zqzJbXSfOfyfetyo9r3bUG7gK
         uYDV9Rxlc08Zw==
Date:   Tue, 14 Mar 2023 08:24:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Joey Gouly <joey.gouly@arm.com>, Peter Xu <peterx@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the mm-hotfixes tree
Message-ID: <20230314082447.46640d77@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZGMy3pmbY7eQtdgqTehFmZS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZGMy3pmbY7eQtdgqTehFmZS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  a1713ab0740f ("tools headers UAPI: Sync linux/prctl.h with the kernel sou=
rces")

This is commit

  df4b933e0e51 ("tools headers UAPI: Sync linux/prctl.h with the kernel sou=
rces")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/ZGMy3pmbY7eQtdgqTehFmZS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQPlJ8ACgkQAVBC80lX
0GzRIQgApHVpXSDMGUIN32MgY+3weEP+OR7eS7BTGdLj9OJiakOHedhKUNqMy62k
4ZYuUkNSegwOdmxG15m/lTjKcnlfIRbraAoe4LkUDikUJpxb3RDpZzJ6n9BV49il
5SHxXO04s1yukUG16/pGonW7LriDCgLF5fE0avEGMniQxtBpLhn0YSfrfF9EYrNH
yWFekYhps7c8rqXOJLEwxGCp+LnYDAKUxDwRo+9varwcCkpm/vZUuAC4LTVBwHo0
QgOA+Up/kW1qZhwcqQxXJGkuFA9ikByUMdOpdRstA0JnhbVz9+y+g5H6bf1O56Lg
9mUIyxEbPxBzvgxVw/ayoCnFnrm7lw==
=9w2B
-----END PGP SIGNATURE-----

--Sig_/ZGMy3pmbY7eQtdgqTehFmZS--
