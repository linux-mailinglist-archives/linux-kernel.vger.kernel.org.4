Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781DC723377
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 01:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjFEXC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 19:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjFEXC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 19:02:26 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18011BE;
        Mon,  5 Jun 2023 16:02:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QZpyy3LjBz4x2c;
        Tue,  6 Jun 2023 09:02:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686006138;
        bh=rGqFH5lObsBRUmnAIOHlPcxLmVsytkZBhtof8X7gIDs=;
        h=Date:From:To:Cc:Subject:From;
        b=tu+jhc52qou6vWAnN8TpdATKtj88KilBo27B0Ytjn77KqBDJVj8F3YFmHYLVVwEyP
         FQTxKnIOxBifM2gJgOA8mSOOzC8IJWw6JyWVt65yD3d8ISB5aeY1zdW9bT81DlxcbU
         bZm5dZaESXKnaKvgIZJdgMtX3AZuhhntGftjRMwpHm9PsTz7G5TXTbLWQIUbeIKLBZ
         B5t8/9DVZx9SvYqAGLsRIJmJ4Um/ckCqNax1KU1qlQVHeWObimfROrYVUJG9KEnSnm
         Rq1ZYHMi12buXf0gTznmkOv0kXGD8Yai8a4QBVFmr8sE1HEGrL0ZixoCXNNChKpeLN
         zWv7FVWUGEWyQ==
Date:   Tue, 6 Jun 2023 09:02:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the kselftest tree
Message-ID: <20230606090216.731ca640@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kuF8uv+dxG=TC6Wu9RqUmNs";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kuF8uv+dxG=TC6Wu9RqUmNs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  54f389ba0efb ("tracing/selftests: Update synthetic event selftest to use =
common_stacktrace")

This is commit

  f1aab363438c ("tracing/selftests: Update synthetic event selftest to use =
common_stacktrace")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/kuF8uv+dxG=TC6Wu9RqUmNs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR+aXgACgkQAVBC80lX
0Gyn+AgAnb9Hpx5WT84csMfv9DU5ZsaCukCsscF0erfDADcmOdLN4kk2v5RE78w2
swH18UKgsuasEyw7SAkHxL5cHQOWFn5+7l87zNtmb5wJAepXpowS6eY7qu1vwLfS
X82EC6MNMe5VtqfItR87PIQsv+EhqURR538OhHNM+P62wNIYoLv2EI+wvnVkN+v+
azSz4PK8Mp6aaIbsIMGIxgzXI7K68sYpRouW/YUrbIG3SPXYu501MidXUsMbDDP7
RHiqxUv6uetV/M5vLwNmMF99Rv9TQju2K7iMmFKlKAtIXap+PVa4favNZ6sS/ul3
w3iIf5eOlVDs2qS+AFmZbq98BT3dkw==
=ShzM
-----END PGP SIGNATURE-----

--Sig_/kuF8uv+dxG=TC6Wu9RqUmNs--
