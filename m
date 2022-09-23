Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0485E757B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 10:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiIWIMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 04:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiIWIMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:12:49 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160AE12C1C4;
        Fri, 23 Sep 2022 01:12:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MYlJG2f2Jz4x1G;
        Fri, 23 Sep 2022 18:12:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663920766;
        bh=kh5TlF4MAHTZwTzDhpqacRgTA6WyR1Tmi5UyomtmvlU=;
        h=Date:From:To:Cc:Subject:From;
        b=B5Upxx89KlqTKm9cM2GxDEFA5h+ZxtjdpOVr/cQMurpvZSrJap40uBIf+NK4gMGta
         P+gNOwoUju1tQ4GixRxnJzIg6tuYYiieh8ANW0Zj9cjfWv2/oqgEHZRAyS7WANVAzk
         5IoWhHE/u89Ei4zjYMr3oLLug3Vsob6PkMWsEHGBPmFHMUhRMBI4ruDr5xjNmDRLEz
         KjVPMqGxFeui7YKbtvfQIK6ZaE7MWn+wKABjFY/SgSS1RUxMBQjYHAsQze3kxl9HeZ
         2TRlCcSf61hWugnWuuwe7d39h9hS+h81X453780li8Mgoq0i8NoAq3VlXtrLofXN6O
         akYMIjUVqsfIw==
Date:   Fri, 23 Sep 2022 18:12:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20220923181245.004d9278@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7t_DhNrcT9AWWAxiVj96OEF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7t_DhNrcT9AWWAxiVj96OEF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (htmldocs) failed
like this:

Sphinx parallel build error:
docutils.utils.SystemMessage: /home/sfr/next/next/Documentation/process/cod=
ing-style.rst:1213: (SEVERE/4) Title level inconsistent:

Use WARN_ON_ONCE() rather than WARN() or WARN_ON()
**************************************************

Caused by commit

  13ea678a035b ("coding-style.rst: document BUG() and WARN() rules ("do not=
 crash the kernel")")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/7t_DhNrcT9AWWAxiVj96OEF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMtan0ACgkQAVBC80lX
0GzomQf/b6zvQowSjtyNt+/goBMUCPR1GDPyqKDlLQTK66dpQDULGxU3upMFVrH1
4vPjxVHiaeO3uMA86pji8UYf/7wysJLNbSHyY7YqaUlP4lyq2xQRR52gP6PbtJtE
3z1xH200br2KsvTWwcAZFKReZJwBHu3dDH4yVtoRT+aGbxuBhjZyaUIlt1zSQbVN
1NGRzWgg/4Lv/R15DR0Ekmv+YCVPlyowKxKzPpmRP1p728WN4egsIpA29/x4fhJI
39QE6v7nr0ErbzW0ukdfcMyhSTamtAShqXts9VfGbfeJrE0NhOuM8859emS9gnKJ
rLwxb8Llh2tpVEk0XVa9cmTThMAtiQ==
=Z06K
-----END PGP SIGNATURE-----

--Sig_/7t_DhNrcT9AWWAxiVj96OEF--
