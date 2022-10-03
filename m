Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0472D5F36F7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 22:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJCUXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 16:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiJCUXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 16:23:06 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17044A818;
        Mon,  3 Oct 2022 13:23:05 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MhC2H2fz6z4x1D;
        Tue,  4 Oct 2022 07:23:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664828584;
        bh=0P9IdNNlZvd3U+QfZ7RUHL4K2h6J5v6pvXJXrgfhq2E=;
        h=Date:From:To:Cc:Subject:From;
        b=E2cZRwF8N+nfJsKO+T8fCxwW18bWkJKpl5tCnW6wSHK9HP3J6uvpVVCHaeqnNFwID
         x9z8nunecMf+dDrSLJB7f5xmU0QSOs0rhyf4F3q7H/n1LMFj14633NbmBqkSnofJtf
         ibF2t0uIYe9WjxW9n0aKK6NFOSK7LLrZ79ql79BGd8IqmWPR3tD2T7wflpkP8WW0zo
         vTwODo8W7u1O65nla+IuOWUe+c2ZWrZWuwDKFBd2X1THepQ6IC9b4FSlwjN+3taMGO
         p9Hmmb3B1JihORLCdK8iNh9y7XSz0ItN5XFm31uuc84Ej/KgdGrg8JvonmBtEAHjX5
         XQU75uBVd/jUQ==
Date:   Tue, 4 Oct 2022 07:23:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        David Chinner <david@fromorbit.com>,
        <linux-xfs@vger.kernel.org>
Cc:     Stephen Zhang <starzhangzsd@gmail.com>,
        Shida Zhang <zhangshida@kylinos.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the xfs tree
Message-ID: <20221004072302.345bfd4a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nY0U.JnHr_q0BTuMvfLwuGs";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nY0U.JnHr_q0BTuMvfLwuGs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  ece9d1c54c23 ("xfs: rearrange the logic and remove the broken comment for=
 xfs_dir2_isxx")
  7ee7a280ea9d ("xfs: trim the mapp array accordingly in xfs_da_grow_inode_=
int")

are missing a Signed-off-by from their author.

--=20
Cheers,
Stephen Rothwell

--Sig_/nY0U.JnHr_q0BTuMvfLwuGs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM7RKYACgkQAVBC80lX
0GzVVAgAkW87nbgxRviUKZnfSp/pCwCSsQ7BkpAFNQoLahVh5kPMqMnlkmeyT3Ni
insIvsES4OmxWGSYGxEMBnL4Ho6K5j9k7CblAkFiSvLtGDf42GkiwCS1X9ZNBT0y
6wp0zFN9IUPXOtfeGKL7qlAQumUzPWGoIFg+R7hYINlvNVO3p+pmKUVrwoCQneTA
F7nW8rP98TzAIQE+O2DuuC63jQxZC/rRtqZJwPbeOd/J5oivSgCgKrqZEQkgR9EZ
IVZS6VI9ypJ2wy0nj3VsnJLm3C4lu3q+NAtjQEF/b58VYZFxrQmIfFRCuL/C7NTH
VgFnFRAxmokr6eafV0vj/N/Dva4Vjg==
=fya/
-----END PGP SIGNATURE-----

--Sig_/nY0U.JnHr_q0BTuMvfLwuGs--
