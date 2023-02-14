Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8274E695638
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 02:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjBNB5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 20:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjBNB5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 20:57:04 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DF9B473;
        Mon, 13 Feb 2023 17:57:03 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PG48D6g4wz4x5V;
        Tue, 14 Feb 2023 12:57:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676339821;
        bh=rWqbuj7Y1Moo07qnSdhR2iyhOqO49E/rwbnmg5NXI4k=;
        h=Date:From:To:Cc:Subject:From;
        b=dDx8z4wfox9GQZO9mWASOmZz9Evlf4ptOj7Lxbw9QYtOC15r/C9cJZZrTfw6IWV05
         0mnAr3DSiahNi56cefkDbgzjsFu3ImrP25Xn+hK9+phKpQ6EAgQDXLDFqG3hvbrRVz
         Hcmo4kRNSTpTGi5EVF1cNm+mOIpGA4pjeWAKPHfLOo/QdmHsxpJMwKOakUdBvOmMiO
         3yL0V95OCUbi7leaHJW+V0gsXnezxiacXeqQHgYskE+TdvSQkxObUWZhWqAGTSIqLn
         WYhjctjGjqJkhoyyeY3l6fq2e8er8sLWEoaumKkM3y5gJaxFQHq66L2SZir4JXOyHC
         j8tnxVnnG5u/A==
Date:   Tue, 14 Feb 2023 12:57:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the driver-core tree
Message-ID: <20230214125700.606a89d7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//WfFgYhdslwXBWyGKKzpXy9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//WfFgYhdslwXBWyGKKzpXy9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the pm tree as a different commit (but
the same patch):

  a0bc3f78d0ff ("kernel/power/energy_model.c: fix memory leak with using de=
bugfs_lookup()")

This is commit

  a0e8c13ccd6a ("PM: EM: fix memory leak with using debugfs_lookup()")

in the pm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_//WfFgYhdslwXBWyGKKzpXy9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPq6mwACgkQAVBC80lX
0GyocAf/WHwreN81qM51yZB857iWuuGJ6+8AOAYy7EA1pjcuV496ItLrvZaBd2/K
8yuTcSIhVSPPsXn05IoQBXK0VUPx1hS6Rk9miBUwHTyHtc28gYOSGJRcPxxW7Knl
3SWx0490SfBs4R85Boq928tkS31isg/rAKWMugJV2ZEOdkh2tNJLUSANR79e9dVt
7vab5sAsgOoopxg2QhUaNgDwho/6hVqSXY5IF9rwMa3Xv2Frt/CudyH7OcYrZiyp
8ONYjloEaVTR1ZUwAApMplv65noW6LgkIp6EfwVsFE+PCOwlqczGDF4RZR4RVLod
md/auQSjAA78AvNTKaDB5Pmm+iokuA==
=rRD1
-----END PGP SIGNATURE-----

--Sig_//WfFgYhdslwXBWyGKKzpXy9--
