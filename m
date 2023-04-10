Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89CB6DCCC8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 23:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjDJVYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 17:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjDJVYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 17:24:11 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05D41BDB;
        Mon, 10 Apr 2023 14:24:05 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PwMRL37njz4x91;
        Tue, 11 Apr 2023 07:23:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1681161839;
        bh=8mu45hCvsPNgleh4/Zd9OzeOq/bs6A0Rwudj3MSwIJs=;
        h=Date:From:To:Cc:Subject:From;
        b=oeKmL2ad2q2gOly68v8KHt0ilOMEjsTjFnX8pq+RpzO0QnexyfaSVhj1Q6m+6Hog1
         7DSAHh0/hj8iF3KhjIi2En9xKehi2A2xMbB6pDFlRmPwSNVEOMtS90mItT5KzLxjk0
         wf4SNWWj8hZILL4a9mOO5tlPkONHri47ZGzUeLBr5Lgw41eT/XZF+oBxtYcsR6JtVK
         wDrYex7Kc0ABYBKHUrP1yU75kQR99PM+/brt0t3qfHr+GGWviwo+115fH3aZOexDPn
         VKoKUOLY4dJeW4ZE9ZOJsnvNFU5Bcu64FCl71yCvlnzH0j/p2yK2skWmyfjmchmTf5
         nxsMA2u/i7dWg==
Date:   Tue, 11 Apr 2023 07:23:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Bob Moore <robert.moore@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the pm tree
Message-ID: <20230411072344.00662a51@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WuHvGT95dnSuek4eARS2Q8r";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WuHvGT95dnSuek4eARS2Q8r
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

  ae5a0eccc85f ("ACPICA: ACPICA: check null return of ACPI_ALLOCATE_ZEROED =
in ac
pi_db_display_objects")
  376b0fb3ad62 ("ACPICA: acpi_resource_irq: Replace 1-element arrays with f=
lexib
le array")
  2a85fc562679 ("ACPICA: acpi_madt_oem_data: Fix flexible array member defi=
nitio
n")
  3a287932da6a ("ACPICA: acpi_pci_routing_table: Replace fixed-size array w=
ith f
lex array member")
  6671709c6ee5 ("ACPICA: struct acpi_resource_dma: Replace 1-element array =
with
flexible array")
  11132ad0176e ("ACPICA: Introduce ACPI_FLEX_ARRAY")
  2a5ab99847bd ("ACPICA: struct acpi_nfit_interleave: Replace 1-element arr=
ay with flexible array")
  74522fea27f8 ("ACPICA: actbl2: Replace 1-element arrays with flexible arr=
ays")
  48ff467c338b ("ACPICA: actbl1: Replace 1-element arrays with flexible arr=
ays")
  94bf7c8a626d ("ACPICA: struct acpi_resource_vendor: Replace 1-element arr=
ay with flexible array")
  d0a874cb4519 ("ACPICA: Avoid undefined behavior: load of misaligned addre=
ss")
  bf44c56a9977 ("ACPICA: Avoid undefined behavior: member access within mis=
aligned address")
  5bd2315bd2e4 ("ACPICA: Avoid undefined behavior: member access within mis=
aligned address")
  218387e6cf49 ("ACPICA: Avoid undefined behavior: member access within mis=
aligned address")
  24d9609b3cd2 ("ACPICA: Avoid undefined behavior: member access within mis=
aligned address")
  4cf8a60602f7 ("ACPICA: Avoid undefined behavior: member access within nul=
l pointer")
  05bb0167c80b ("ACPICA: Avoid undefined behavior: applying zero offset to =
null pointer")
  d56ba92b0ce6 ("ACPICA: Avoid undefined behavior: load of misaligned addre=
ss")
  520d4a0ee5b6 ("ACPICA: add support for ClockInput resource (v6.5)")
  f5325cb10414 ("ACPICA: Add support for ASPT table in disassembler")
  86f240a2f7e9 ("ACPICA: Headers: Delete bogus node_array array of pointers=
 from AEST table")

are missing a Signed-off-by from their authors.
--=20
Cheers,
Stephen Rothwell

--Sig_/WuHvGT95dnSuek4eARS2Q8r
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQ0fmEACgkQAVBC80lX
0Gxi/wf/Sumk+arcltpwO4OtCx8wTU62tg568t1f5ayqwzRBuwY4btSrxsH23a5J
S0ejIC6Rq7sn8hbckEGYbX8Ag6K9o2riFYMQiD0mSzB2KZJMNwwWoJgKdFPPcvpq
cCdiAGyHPydyNXBcGg9Hie6q4nKIleyssXCm9Tazc0mWRmHSwkrmgxiRwF0g8fJ7
9uF9BEafUek1E10wZQ6xrN/sft/VtaZs0ShJ/a6UDRmCrDQVEFuIyOA1ehf/Q9y+
pBiYGCojdIP8W987ePFO0Ry9FO7nJAhZwcI1byl/Tn/atES5Lrdn2eB3Nyj86z7u
xbfCws57riXpWTf7BvwOeDeXJ0wDWQ==
=5DWq
-----END PGP SIGNATURE-----

--Sig_/WuHvGT95dnSuek4eARS2Q8r--
