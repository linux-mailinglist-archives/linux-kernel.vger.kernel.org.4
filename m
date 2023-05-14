Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433B7702087
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 00:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbjENWoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 18:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjENWop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 18:44:45 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2CB10EA;
        Sun, 14 May 2023 15:44:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QKHcg52YQz4x3n;
        Mon, 15 May 2023 08:44:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684104275;
        bh=zCntv/gHs98BvbPwti3K9HEUfLJdbgGjZMzaNHbV8/Q=;
        h=Date:From:To:Cc:Subject:From;
        b=rDdPXverbK5H0EdoE9RauKpDhbONHiAaPm+wOxJLERZpNDgja9R99ct8nVvZ0HrJo
         75JE+BCpvqGgw7OR2BTTRs+x/o5BM0+cH/qG2fmaSjvtSEzlcq4r2IWfYGzjU0sIpR
         HO1ZoTIvfd2rMtvqCEJ/aiojipS00k2UnpHkvkOHwRX3UqcjvrCbwInaALpz8p3toQ
         /y98boYcKNWKC2O0Woy2vDn6POiVXgr1svRs5g+gdB9vcdbsYWZhshMp8LoxllKfjc
         zoJqEJYHn3eBU69AqM4KlEy8z3Wl34IY9qWRSNohDyYTARR31VoS7r7lkJFu1evKBB
         XQIJTxe2vIlNw==
Date:   Mon, 15 May 2023 08:44:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the net tree
Message-ID: <20230515084418.409f81cb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XcdF3AyAd5.hT6=m+vPzRun";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XcdF3AyAd5.hT6=m+vPzRun
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  01e8f6cd108b ("MAINTAINERS: don't CC docs@ for netlink spec changes")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/XcdF3AyAd5.hT6=m+vPzRun
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRhZEIACgkQAVBC80lX
0GyXYQf+N6LHTSUdHJCQe5gbL0o9O3F/u6TW2dzZDK6+1uA03wMT9Y5bjRt1GTwj
5X8Zu24YbgyYTN39nXojrlpc+Y8iBLzL8T56qJXIO3D3oVOAuy/Y5rOq/JsJ/TGM
SGaED+SQ7pskTcwe1XUWkJCKq34Yq+TxpNJsw+J4FUQKDVt44fmZ6v6yahzth4mQ
gtOXM1g44HqrEeV1f9fg00MFUCfjRqyWJlHfNDm+kL12DVuXgBCMv13MpzYnL6oR
pD2hFnVwYB8CbWMaMMzq2iOCa+9/nF7BBHzrC7aKQTErn5qVhhyXULB+5Qny+cLp
Qyp9azIUsE9MV8Z+nTo8hQuTnosJcQ==
=LZ1T
-----END PGP SIGNATURE-----

--Sig_/XcdF3AyAd5.hT6=m+vPzRun--
