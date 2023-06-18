Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83463734919
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 00:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjFRWW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 18:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRWWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 18:22:54 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C85197;
        Sun, 18 Jun 2023 15:22:53 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QknTR4Skmz4x08;
        Mon, 19 Jun 2023 08:22:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687126972;
        bh=1+temdkhm4L1SXh+dn0fzM+0GP6G8F3HJsDnZeHnikw=;
        h=Date:From:To:Cc:Subject:From;
        b=bpB9buPB/p7H/cam9pttLHkDadUY2mIJ43g/lEAWBd4BhPERWFhi9hElpwFp72Pcf
         8fJlmL7bb/AeBMMF6yti8sE1Thnk+SAj65pogPKXUww5bMctCEBtelKGAqTyRcHZ5J
         d1YRHwLesBLSw/KyI9BrjzEcWkTRymxr85Nw6QYdqNaAm+HGsL2dXIv5ZQwypw26Kb
         nm/kgAp0GsmFCbK6iSf0cLdPp3dRu969VCUONeVtIp0QbXVzbOQNfp0+hzDMyKj/R9
         74XuLIh6Ogs9zmTF2yAUBEpMKo2UtE0ThzoE9SxlghQh2GwXdinKkEbSD5J/WlAEWk
         U9BAn6R8yaLnw==
Date:   Mon, 19 Jun 2023 08:22:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch <kbusch@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the block tree
Message-ID: <20230619082249.0e577baa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jsI=X/A1tkdTIDnlUapa_YW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jsI=X/A1tkdTIDnlUapa_YW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

[Also in the device-mapper tree]

In commit

  900095bfbbf6 ("nvme-fabrics: error out to unlock the mutex")

Fixes tag

  Fixes: f0cebf82004d ("nvme-fabrics: prevent overriding of existing host")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: ae8bd606e09b ("nvme-fabrics: prevent overriding of existing host")

--=20
Cheers,
Stephen Rothwell

--Sig_/jsI=X/A1tkdTIDnlUapa_YW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSPg7oACgkQAVBC80lX
0Gxk8wgAoxen5L7TPRhV5XYc6hq0tnzm/meicMwRlLrNT4TZuPkCuWqpVKTjKNHq
a3UOkBeaXHZAG4fCi04Mz7yrelSh5gaDOJ5jiHN1yLDdj0BkTB+sdo+dNxd4Sbs5
5Rz3m3WAbZmbIyiNJlYMJtluWKnjjPTMIgWPSx/zq+o2TBvPkn8xkIKwfOr4Mwyb
Uept4XUhr9gCjFt3RKbR5S/BcGVybBjH+W8r389AC/1gZqi8ZmjXCBtHEwJnJmxx
0/wXh2h41IxOqJJ4UJSP6tPyouNrEGCYwnvkjdfYhEugoTJ2FIGTCRETjNv+ZCF1
1qVnecQguEjP7j8+F3f6LB4bWHnHeA==
=wUO7
-----END PGP SIGNATURE-----

--Sig_/jsI=X/A1tkdTIDnlUapa_YW--
