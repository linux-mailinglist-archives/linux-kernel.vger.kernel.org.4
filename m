Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B2F71F66B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 01:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjFAXM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 19:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjFAXMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 19:12:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB17194;
        Thu,  1 Jun 2023 16:12:53 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QXMNw1gWTz4wgv;
        Fri,  2 Jun 2023 09:12:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685661168;
        bh=vriIntrz7IhgdfHCVAuxCHQOwtyTOMp6zaQPJ+GsNBE=;
        h=Date:From:To:Cc:Subject:From;
        b=VF8Sqtm2QBgABkkAx8SEI9BROv5eWelj9sDQDIxF7lpyRUvsY6JXAOUh42Y2iGWdt
         UwreBxL9q+M40wg3IUXv1sz8xbi+ggS97pZskRx9WiMthy3Rn3X2C62ijYbzpSdMGy
         gwWXV+rhIx9WgU78p9ztuzFNkfKn9KqlayAUW/j6Jk9iiSIvPQ6BkUB8LNiU1uHhc7
         jpD8EOgU7QFYvkK7vC7xQcEgKZ/FJLtPGQ7sV2AGLhyCl4gEkSjjCcCN92Kok8PEPf
         cfGEyT4trTMqtVwgM2P1D93dadSi1ZRj/KVwixHYMU00S48lDgIkJWZe95JZpM/wlS
         6L6EG1OzSATjg==
Date:   Fri, 2 Jun 2023 09:12:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: linux-next: Fixes tag needs some work in the risc-v-fixes tree
Message-ID: <20230602091245.30a4d4b4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/d2AiQ0_F86gjY7pA.UwcW3m";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/d2AiQ0_F86gjY7pA.UwcW3m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  073b51fedd87 ("riscv: Implement missing huge_ptep_get")

Fixes tag

  Fixes: f2aeb0118ddd ("riscv: mm: support Svnapot in hugetlb page")

has these problem(s):

  - Target SHA1 does not exist

In commit

  3e1989a048ec ("riscv: Fix huge_ptep_set_wrprotect when PTE is a NAPOT")

Fixes tag

  Fixes: f2aeb0118ddd ("riscv: mm: support Svnapot in hugetlb page")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 82a1a1f3bfb6 ("riscv: mm: support Svnapot in hugetlb page")

--=20
Cheers,
Stephen Rothwell

--Sig_/d2AiQ0_F86gjY7pA.UwcW3m
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR5Je0ACgkQAVBC80lX
0Gyi0gf/duMpCJ29cGQEDqOaqL172Y50ccNNDFkcwODLqn5QlXU5zycPqNyI1jRP
g7HBAXtAtdM5IjoYnmzs83h1Ce+t0tK2P4oqyMn67L19D7eKhMNWbK+zrBgbMJQA
zEx1QvbqQAG0E3xePiYKOKJBO32AN+TtXOKHfifIqNRnnG7whCf0a7TTvVwQf/hp
6IdYy0AcOMy/ilNKa04XLL9gmqKc2WhpyPkBIu6gFRbM1jvu9I8HEk3Uzt8CG3RV
1XhPD9oHzvAAOqjKFYY1aAuu46J3Iginla53kfcnIzDaSvOJ6ZxeE5pkjmqgjAeG
AK/MGgvtCkcyeBcE3Jay6g1le1stMw==
=Fzah
-----END PGP SIGNATURE-----

--Sig_/d2AiQ0_F86gjY7pA.UwcW3m--
