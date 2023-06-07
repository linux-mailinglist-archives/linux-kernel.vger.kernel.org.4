Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D6D7271F9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjFGWrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjFGWrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:47:13 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66B21BE8;
        Wed,  7 Jun 2023 15:47:10 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qc2XS5xM2z4x2c;
        Thu,  8 Jun 2023 08:47:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686178024;
        bh=mBeZxdg3EbjmdcdpeM+axfD6lbMxgDeoaq3Vl97VWsw=;
        h=Date:From:To:Cc:Subject:From;
        b=qmGqXLQ+12Ez9E3LU58TFmagvesmx4k6pj9G6rv1HOvHimqHF34hAiNIC4izNIVzs
         w4m33LzmnnJSl0XORlMCg6x0xeWcxaXgXc2Yp951NWgJ1n3xN/lKpgoE25SHSEpGaN
         e1cEpiLvJS6izgTgnjcpbTnvGH8h56MJbuqJQV88J5+EKkw9DvtHJ7Pwr6Bhihe69C
         sihFXxH1eHbnWf0b9qTZDhhOCl07cHtG09lYmVhHYY8735ZkE018DbraMtJPXX+rK+
         nKoFFiLJ8rkIgdUxh4P890I6H9O2YDygDtLYgoIWshJ6Myj1Q1zNJ/AB79nTOHi1dT
         pl/QjZhie6Zkw==
Date:   Thu, 8 Jun 2023 08:47:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the mm-hotfixes tree
Message-ID: <20230608084703.2e97ce20@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wP2yuNpyv2Uxk5nI5qbh=me";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wP2yuNpyv2Uxk5nI5qbh=me
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  d2f04aea9be5 ("MAINTAINERS: add entry for debug objects")

This is commit

  25bda386c3d5 ("MAINTAINERS: Add entry for debug objects")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/wP2yuNpyv2Uxk5nI5qbh=me
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSBCOcACgkQAVBC80lX
0GxVbAf+NLPQHboAGEgWnm3lqR3kTQNkhYAk5ap41XeWxhLkUW0zbQihIbDxOwpu
jKCZ4EHlSsRdcVdgzCpVOUkPJbn97Ap0qapTiEq07WR4usQ8JgrU5FwtHsnevLih
U2WzcCqP9Aatt0A6u6rbEvpctiXS5uK2XANfdLFskZmfDGMaZnKMCf2q8h4Os8o4
cFCDmkiGNzMsUwdpNkxgEIPbkGvhXa4p7hiDeQ9c1vrU+TdZP1uAUr7Qome6v/IE
5EaDEM2xg8CpeYnOi5pq8V0v90eNGO6jsE7SVSjVImXw3A7AiViuZq5w/OGwYHj8
zfx/e1G2HLBcjw/dImR9soZifCttSg==
=Rpbc
-----END PGP SIGNATURE-----

--Sig_/wP2yuNpyv2Uxk5nI5qbh=me--
