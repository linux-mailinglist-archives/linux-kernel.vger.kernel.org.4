Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0430674E356
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjGKBSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjGKBRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:17:50 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E87E59;
        Mon, 10 Jul 2023 18:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689038111;
        bh=lFgOjEa9Emw1WCRXFqAtgM5rkiGGOun1BwIhbt+4dfM=;
        h=Date:From:To:Cc:Subject:From;
        b=Om1kYYy7wwLzpHfjfjhLA5DDeYovo82uobvbVz6DFIf5k//OJ4yPWZYGE7ru4Uvtp
         HLugBcE4HMnMGioBydGIV1cVJNSKe30nCLnAx1V8SxUe8kV5Ts7Zm2LJBO2cJAasKI
         Wj0HjDQpGFV2Ofx+iKFTDDpElBZcvp8MiiRVq2nuNF9BDs1t3Xu36XMCp62h3s4q+j
         N5kcYFSRqw3yQOkOfIIbBEwLtQDcjkMepxrFJx7zIkdpRG0aMuVBDQIxv8c3H28H0V
         G9lNTHZBX67FmMhnm0SkLPS13c6e8SaOySP62Q0p3ZVAtY6kK7KWNaiiEK61qzR3+W
         BUpdw7n9FQ+OQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R0NG63MWzz4wxx;
        Tue, 11 Jul 2023 11:15:10 +1000 (AEST)
Date:   Tue, 11 Jul 2023 11:15:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tejun Heo <tj@kernel.org>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the cgroup tree
Message-ID: <20230711111509.1045f32e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Y0itks14p_6MUgz7kx140FZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Y0itks14p_6MUgz7kx140FZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the cgroup tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

kernel/cgroup/cgroup.c:503:36: warning: 'cgroup_tryget_css' defined but not=
 used [-Wunused-function]
  503 | static struct cgroup_subsys_state *cgroup_tryget_css(struct cgroup =
*cgrp,
      |                                    ^~~~~~~~~~~~~~~~~

Introduced by commit

  1299eb2b0ad5 ("cgroup: minor cleanup for cgroup_extra_stat_show()")

--=20
Cheers,
Stephen Rothwell

--Sig_/Y0itks14p_6MUgz7kx140FZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSsrR0ACgkQAVBC80lX
0Gz8mQgAl5KwqeeiFqr2zm31MdItGnYxR32Mhl9PfpMSUlakATwITzFlni4rc4AZ
ihaZcFD/dIz/3j6Zg6Roez+o27f73C6jMmY9WiNFeeHzAmzLjBay+c7INTHemO41
79yVXZ9X5YU4zlsy79n/YgDHjMdxBOL0aRZDrJwojrixLb+YGSC+PaVZ9ctFicbn
6b2H8hI86FxyXMQhKahqNreCGanSqMo1cCXRTc9aQnsMnrUuDhUqd5o9QlDQ+ytL
jEpxvJb7PTzSeXneiIa/gm2lNfZOhfv70wrkLorW+G+8rTA6Rw7dZ2IXxpG2lX4T
PMImo0y7N9Wfnc5MK+ubqBK21kzWJQ==
=YIg4
-----END PGP SIGNATURE-----

--Sig_/Y0itks14p_6MUgz7kx140FZ--
