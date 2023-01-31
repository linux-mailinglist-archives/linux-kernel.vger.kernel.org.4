Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC18682261
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 03:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjAaCxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 21:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjAaCxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 21:53:21 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134AC8A5D;
        Mon, 30 Jan 2023 18:53:19 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P5V3c4KZJz4x1d;
        Tue, 31 Jan 2023 13:53:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675133597;
        bh=09jW2tvc8pZY2j9cfBuPWS9KOrpAa6KgScWfS9szkK4=;
        h=Date:From:To:Cc:Subject:From;
        b=e7LMQiOrH61qDTdRlHMlopNk6ET3y7ruynPtEDHYAa3SAB0DgGXzIv0HBt9Z1pq6y
         m8ZBklOUWS1qa6lbYz3yUrtPKfLG6Sulm+7wd2T1h2wmrcCpdJaS+DQ/lDqJZhiSc/
         MTWjpVSDnK+BwfII2pLVh9wTpeo7M7bsnILWuKbonBJb3U7bMxyEzxqhivWbHIhVlj
         UyLazyokr7VIqmr3vAsnm8j+ujVRzo6T1zRZa0ZZkHotcl7mAkIfZd0P0dpxQRaT7+
         raOQ1wDp2LfabnsZpghQUvMJTVb6r+ywardO1MFc99CfcGzDPUz1bXK1tk4QYiOACW
         jqClF+axhxLeQ==
Date:   Tue, 31 Jan 2023 13:53:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the mm tree
Message-ID: <20230131135315.7d0544da@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RowAaNrbXg=hPkYgIfpf3XW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RowAaNrbXg=hPkYgIfpf3XW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  72082700a92e ("Revert "mm/compaction: fix set skip in fast_find_migratebl=
ock"")

It is commit

  95e7a450b819 ("Revert "mm/compaction: fix set skip in fast_find_migratebl=
ock"")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/RowAaNrbXg=hPkYgIfpf3XW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPYgpsACgkQAVBC80lX
0GxH5ggAliGdexnz0oBKm/shUs832p0G9JDtTaufd3elP1sysAEYeWbmh6/kCLRN
1CQtjbzS4A1biIXv9Jtf3SQ6dZGNS5Wl4wBWKxOl9p0lKBJVroHyhn0VxHCmsC4Q
o4imF3CmpG1Pwr5o9cqduGNiE7LBshSaZjWDqEvzy3ZMw4bJzEOnF6JUo74iukQ9
/DQjtokN7SCXSfQvNTyyh7drr+Yrl2AgcsbMkIBQzXVAUxHIvB7XFTw+bGu9rXTM
l9VzscTxnQwTsjp+L7PFbfqeueo5uxaxcf9F5E8JQ8RMLyS2Z0EPfyZDLa9GgoHt
ES1MoxsMu+yJPJeGcQUJgghG7FlMFg==
=LXlc
-----END PGP SIGNATURE-----

--Sig_/RowAaNrbXg=hPkYgIfpf3XW--
