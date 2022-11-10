Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DB6624D20
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 22:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbiKJVgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 16:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbiKJVgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 16:36:32 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3DD1C10C;
        Thu, 10 Nov 2022 13:36:30 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N7ZsT0Wwhz4xTg;
        Fri, 11 Nov 2022 08:36:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668116189;
        bh=jx/En31Snb28kf0GbnvsZxQJ6aGex74O0O1yzoJBkK8=;
        h=Date:From:To:Cc:Subject:From;
        b=h8Oh2hC243in0sXJ40CHeaOZLJhr+YYHDJhhh0lY3XKn9bH6HUsU6qc9soDApjLpD
         vWlr8C91s2xysrEKlbK6rDL3Zc38vmOI2ON4cYjIh7W9FspvY9GPgAIAX8TtXKBEeK
         8+0YqR3VihqaTk2ywfZFnZeWT97+KvChttKLPm9NZgxtsRWcWgit+HQDNjYRBhnD4n
         dPMHrgAEMTM0E94Phu6GmoX/b9KR/JEVQ7uPoaGO0dLQaQCUR9OTovcR6jkhUSsJDg
         /7OlFYuMKtw0yMZtN+KugP0pOaXLW9uDaF4sGlDLNYsEbMpVVLeKuRtWdCrB5QdpMQ
         G7Ps20SE3LwCw==
Date:   Fri, 11 Nov 2022 08:36:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the drm-tegra tree
Message-ID: <20221111083627.2c86992c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Nh3CcbRKXg85heLg_BrmuGf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Nh3CcbRKXg85heLg_BrmuGf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  ce071fc9ceaf ("gpu: host1x: Avoid trying to use GART on Tegra20")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/Nh3CcbRKXg85heLg_BrmuGf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNtbtsACgkQAVBC80lX
0GwhWQf9GTQvZXH5wnoUHTbzp0TZrv6P1nLnnDe0e1KMLtw4tOuwWbOgsM5Ra9jR
NeafIkIWw3K21RdJ0xOLGQuz3Rf6YBuRV7NR/XccdISTEXupguQ2RUpYfumups7h
meqneOC21Ori8+DRSo3O0qotCUG3UdEaVlslwvdHN/DnWk6pRI2d5Ehzdq53Lxh7
vxao19sC9YepbmuQG9fT73tg6nqMNsenwwA/F1FLwK0ZbjMMzUkqQW0iBI/Ouq5k
HmtKohrXmFUuEfPgZDMlJ5uf0e8iXlHtITHJautik72RRlv/71zcKvYlW9/S+83b
hoDhcqlzlRUz5RmQaxu4RpfDACv5Rw==
=05Sx
-----END PGP SIGNATURE-----

--Sig_/Nh3CcbRKXg85heLg_BrmuGf--
