Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CE15BA25B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 23:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiIOVep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 17:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiIOVeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 17:34:37 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51D760EC;
        Thu, 15 Sep 2022 14:34:33 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MT9Sz6VVrz4xD1;
        Fri, 16 Sep 2022 07:34:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663277668;
        bh=LSmaAmh9KrhbKRY1s1jz/z4n8M0Db/WSfWLH1jkQcxI=;
        h=Date:From:To:Cc:Subject:From;
        b=j+nmB/qEHJfv5eTHeBgN7y/rohXX7BiOfdn5mTMuTgaJC63cU+ggl+GoZc8nQXUaW
         BrTH0UZ9TTLjHhzf3vMxuKV1zBe5mMP8pXYjFak8ohHATyKdkybmUKPN7X2Kyhl+XX
         9K1mqCMhwd/kIAX60/KDFkf+0ouFWOjegM4BLp3MInFknp+CWnfSdpELHUsNapGXTb
         FP7/yjWp9Oh2Vnvt9r4bI23X9bt3MmVtZQpm1QCjFyY6fzvRob3LgJK5g3JOB739ga
         c7XlSNgZpKsjUjh6YVsD3tX0Tu5+GNAihYncJLHz0yElOMogHBtKPOsAGOoxDs+ecH
         rMVYUocY/sJ9Q==
Date:   Fri, 16 Sep 2022 07:34:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>,
        Thierry Reding <treding@nvidia.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the tegra tree
Message-ID: <20220916073410.3fda3f0d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ik/u0Pwws54a0Y9FX6fpUYd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ik/u0Pwws54a0Y9FX6fpUYd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  2254182807fc ("soc/tegra: fuse: Drop Kconfig dependency on TEGRA20_APB_DM=
A")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/ik/u0Pwws54a0Y9FX6fpUYd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMjmlMACgkQAVBC80lX
0GxO3wgAl2JLfW2MQXPUgliK3Vxl5fHCXF1has6udSVDBGDmJ7K8q6U7s3OOcAy9
126ZVzjqYECPhSoyKwapDTZKaQR1B9s/QDPPxjXwXf1s/AHUtBFPdVjgQmudrsv4
KYC0doHDSYjZ0k1bXkRtYm05dppqoAy/opSvpmLUpr8TsGjs1TjV8Hp/6VugCNR1
xZ7QDthTlWdmi9STx56Tvj9vgJk3nlsa9mcsrv8ym9ShLGjZ3A0WeSvcZGuAybV4
djuCZ3L7qyf85LsHhLi3DHUm+7nAufTl4GzD+tbD8hE5lecVYC8Cck1leGOmzmlN
pG9o1Gkfbyc8xhffqQGZueT+0EsdUQ==
=bpnw
-----END PGP SIGNATURE-----

--Sig_/ik/u0Pwws54a0Y9FX6fpUYd--
