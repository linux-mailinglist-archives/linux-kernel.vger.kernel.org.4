Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0588D67DA2B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 01:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjA0AEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 19:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjA0AEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 19:04:38 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E00BCA11;
        Thu, 26 Jan 2023 16:04:37 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P2yVj6B2jz4x1N;
        Fri, 27 Jan 2023 11:04:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674777871;
        bh=oA/QyuVeN3Q6DEQTHlGETtxjfLNOOf29n+5xQlBorAo=;
        h=Date:From:To:Cc:Subject:From;
        b=TOIV5bzGszk5WpT6Up4FojaOgOW60VDGdBDkw1SFawUVJKlSLPjZUgDeqaqXVfVvW
         895BlRHj0ygf8BUtDHhWDqCge72Xtcxj3KOoQDhSjMiSCpv3IsX9Tble1+SVgGhCx3
         ce9gdVsCz/gsDZqDExwHUS6ekR9sOxvxVdRobm158saWpMyTEC8sAKAZHOvZJoDBMM
         5n35D4kDzFgoCHkKTSX8WPVQupHpZVm3Ztj3A+q7MbpjDWtzv8FwMDu3cukPOtHAQq
         5YgwqRSJHYGlfn8kLW0qPbpNPvcExDk2knim3wzNawxcxQJzyr6BHeoJ+XguEUIybi
         5EHhKHnuQHstg==
Date:   Fri, 27 Jan 2023 11:04:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joel Stanley <joel@jms.id.au>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Eddie James <eajames@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the aspeed tree
Message-ID: <20230127110428.34c159b4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DqIBJzxdsoEaplcGkJI5HS/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DqIBJzxdsoEaplcGkJI5HS/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the arm-soc-fixes tree as a different
commit (but the same patch):

  fc8529f0609d ("ARM: dts: aspeed: Fix pca9849 compatible")

This is commit

  d9b6c322fd33 ("ARM: dts: aspeed: Fix pca9849 compatible")

in the arm-soc-fixes tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/DqIBJzxdsoEaplcGkJI5HS/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPTFQwACgkQAVBC80lX
0GzPEgf/dMWQTioS6mGH6qxE/GAFdoXux5XoToiELTWb44A/kdIfnQdWmPtMZpq3
0BUaGR8t9DpfEx1B0u/REd4CN1j/i78ay4kSHBv5h1/qU1Dty+Z/SBd/+sc8Qb4O
0/6l9LMItfHIt7ZjCq8nNVUZa29Wkk3o+wK+ZE2Rz/yfwrMP4ynq31Rv8xGqX1+/
Rj32q+xpvJK/b8L+L1pY9SkOVzHLPGB0eYDbUIFzLm9NaYEHgo1YuNX3872kOxSz
5RBI1QWmEKP4fqCy36X2CEg7FVV7DiiByGNAP5S49LNoiFWr39n98Lfrjy5ucR1s
teJHKpYj5Gv2GRnQbwpxBjaHdUUP9w==
=OROh
-----END PGP SIGNATURE-----

--Sig_/DqIBJzxdsoEaplcGkJI5HS/--
