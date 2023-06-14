Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD13727340
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 01:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjFGXnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 19:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjFGXnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 19:43:20 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820022115;
        Wed,  7 Jun 2023 16:43:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qc3nJ2qDQz4x3g;
        Thu,  8 Jun 2023 09:43:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686181396;
        bh=SMUEbHWeYQz9dIEex2FUYLwlIvtuoZphg4ADR9BPAyg=;
        h=Date:From:To:Cc:Subject:From;
        b=OKh6OLYxBdQHfRJCEo5QvmjBIlTwLs/pNmryyYeeah1Y82vZEtQ3Oa/zn99CmVXf0
         l45Enkrq9wXEmGQM4Kp+nXEMqh6nExiqyvs86PHvhODLDQ3l/37k65WZjM5Yr923/l
         pVxzfXLYjcrsiDsO/ZPOBF2ricSKT2xNzyC55KidKaShtWeLRogPW0wzOMLw2Y3ZsI
         5LAFGcBQxuHkcu1LXkfsbcII+BT/9Q1Ca29b2joyR0TpgpDDbUu7Pgic//hsevvAga
         HZ/2a+p024HJAm3kVQBPNgbM539tlw/5c8N93qdS8v5QEpEBwugc8FQ4J1N529f9ki
         3uyLsIl//nhyA==
Date:   Thu, 8 Jun 2023 09:43:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the slab tree
Message-ID: <20230608094315.386e44cd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AY3m4nXAs_is4wEcvrSYUU/";
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

--Sig_/AY3m4nXAs_is4wEcvrSYUU/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  373c9fd4ba4e ("mm/slab: break up RCU readers on SLAB_TYPESAFE_BY_RCU exam=
ple code")
  f25140926cb5 ("mm/slab: add a missing semicolon on SLAB_TYPESAFE_BY_RCU e=
xample code")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/AY3m4nXAs_is4wEcvrSYUU/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSBFhMACgkQAVBC80lX
0Gxr+Af+MDBGTA1bHemGnRCXBrH5zBCB9cvDYzeM4JZVucwpHSWas3E322s4eR/o
5R06SNcKZAttOgAk/lU/lt0Q7p+FuTnzJE96OXKwuzgjHYOeGmVNsCeYvacr4/kz
z+zwsYA8CgSwceBEi/IYwrJhH7OX1NEiM0ZNFgtZM9rcBCodkUqkaDAtKJoLfbI+
aUvEgBlVmiaTAU6+g29lI+qLdzW2EqVR/UxOOD+cKOOdIBIibYmzoEDXudD8DLsZ
Ti+zf/QY9sKyYAxC0wSbz4HWQhvI76yoot/Kv90FCMGKmBAQKke8OP3tBbAE+guH
Dl1ve9XSykposPl3IYYnOAabNIuXnQ==
=er2u
-----END PGP SIGNATURE-----

--Sig_/AY3m4nXAs_is4wEcvrSYUU/--
