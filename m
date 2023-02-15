Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227AE697553
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 05:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjBOEVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 23:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbjBOEUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 23:20:42 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB423433A;
        Tue, 14 Feb 2023 20:20:30 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PGlHH4m0mz4x5V;
        Wed, 15 Feb 2023 15:20:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676434828;
        bh=GfiPsfvThIDr+PFMX0Ky8iugsK3oSFmPz2QVPNqMyJ8=;
        h=Date:From:To:Cc:Subject:From;
        b=WUFh66ZYdBeUVOUXmwnA0kVbNoaVZZ5zrs4Uu265MwgS6BplrMuI5kfIPrtnTz9ol
         BaFHuUWS1qHV6Vc2gHCE3db5u9HtUOrMAlhS3YEOAGTyo48rrHjOlBq+MlKb6+ZPps
         PgOBCiD64VOhwm5o7ytttYCKVBx/XZY4UejJpyN4Iiesqomy8O70XKcxpAjE5iogMG
         WZYYElgt0tGEknbs6ZhU3DqaCpVZo7/XNKFEXg38nuxtgNshZ1sg3Pm0sdTBkuXnyu
         fqZ4YKsIhwN1RdwOKZUSrVrvhC/GOW2KAAhePBEEY5u39OHU7lfNhd0x6qqY/LM1zA
         OacCDGYYQjdgg==
Date:   Wed, 15 Feb 2023 15:20:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the wireless-next tree
Message-ID: <20230215152026.7fcd88e3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AFC3lzUnigufcAib.+eoaX6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AFC3lzUnigufcAib.+eoaX6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the wireless-next tree, today's linux-next build (htmldocs)
produced this warning:

net/mac80211/sta_info.h:722: warning: Function parameter or member 'amsdu_m=
esh_control' not described in 'sta_info'

Introduced by commit

  6e4c0d0460bd ("wifi: mac80211: add a workaround for receiving non-standar=
d mesh A-MSDU")

--=20
Cheers,
Stephen Rothwell

--Sig_/AFC3lzUnigufcAib.+eoaX6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPsXYoACgkQAVBC80lX
0Gxbogf/d6ZjXeSNPvtZ/8PFU5ujTjkNOJcqWeYtVAQ2X3MHqdKJsDETsxe0bBKE
n1cMGF6eOPmldtkLajTMxAfNZSHjE3iY3YNefFVSSg5LLHCRCQBipwmwCIZ61YNT
mh7GSUB/5wwJAFtteFr741OlqJy4zihCvgZXWGRb17/lN4Dmd562/6dH9ejokojt
zX1Iwttdx0KGzBL1s910WtLDHToChja5HNnekmG1oUHEd4YKgY0pDxLBGd6JGWqI
npbej9yf9xNkuiuscaLQt5x3EyMSyYCzT6rFhcv0ZXpepo1oSqM4O8jcpUtH9LwE
8nPCl4uo16TZD0UQ7Vy7H6dH7UFaTw==
=Qmzd
-----END PGP SIGNATURE-----

--Sig_/AFC3lzUnigufcAib.+eoaX6--
