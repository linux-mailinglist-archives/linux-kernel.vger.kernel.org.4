Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D5A7101A7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 01:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbjEXXWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 19:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEXXWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 19:22:11 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD09683;
        Wed, 24 May 2023 16:22:09 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QRRzJ0fDNz4x4P;
        Thu, 25 May 2023 09:22:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684970524;
        bh=NjOHn+cSMgAwzSUUYsOUVH2SrdLRWdOOwP+R2Kl3LSA=;
        h=Date:From:To:Cc:Subject:From;
        b=ThfHBZ6LnuYBKqrfxcc8KjdcC2yqRXQhYZNsGkwl+7qkQDaW61nTuaZLrnJCYikFX
         av1bkalEWyqZZW0HdiXb6hBEO1TlPgXj8Ezjm/d+ahDv1EwWWLHp1N0r9evOMgOFRo
         Dki+nKHTRf4plcN3DC85xWoQJhC250BFpUu6jmy5GDbqTXN/C03Qls6I3BwKr90ebH
         XpiWYvsBDSSrcoDPbjl8J2e9G252tSOe0Z4mHPi/EapCVme5nj33aq/NLDnaxt2JtH
         XwLAUhbhgNnFJtrzot9WvkWQTa1RojVaSYltdkXgcd/KKcxU8lyigF0NKuatkGoJCn
         LElbJy4MHf//Q==
Date:   Thu, 25 May 2023 09:22:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the asm-generic tree
Message-ID: <20230525092202.78a1fb01@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yw8vSiwwirXhcwhsrent5ro";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yw8vSiwwirXhcwhsrent5ro
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  b1e7601203a8 ("arm64: vdso: Pass (void *) to virt_to_page()")

This is commit

  b0abde80620f ("arm64: vdso: Pass (void *) to virt_to_page()")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/yw8vSiwwirXhcwhsrent5ro
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRunBoACgkQAVBC80lX
0GwWmwf9FgSyU+vOoXYq5k/mJfH8dsOu8efIiKziFqFK9+OPSxPJkNwMTimpiUH6
4xVwpq1ME6b+Duh/6AmDG2OSeG/W22PwoRdOaKzNdMGsn1sE/UyDEepF4JXwmcAr
r5ZuM1JZvMzDzP0oTnwUoCuVYnqi7EOmT6yryeg83uZkV+UtXrm7Q9lEr95thruF
ld4G/mYi0CBdvSG+ePKyL5cywBOd3fIhV7xz+SgO4R12eyTDmGYBDbf2YvWcRR59
HjqC6djVs45k1wjQnPvtfuZ9uIw9pbygmbY5Vxc2joD6dC42NpxTlXP8nE/mTzIA
S79p09YFi3pq1M5HKpUhz2po+DHdjw==
=gKDy
-----END PGP SIGNATURE-----

--Sig_/yw8vSiwwirXhcwhsrent5ro--
