Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18B4636CD2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 23:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiKWWId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 17:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiKWWIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 17:08:23 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6776A75B;
        Wed, 23 Nov 2022 14:08:18 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NHZy83vgtz4xGK;
        Thu, 24 Nov 2022 09:08:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669241296;
        bh=TMpBUXSd9Z0rWmYiulmoivyeGsHcWDT/PQOGyPih/vs=;
        h=Date:From:To:Cc:Subject:From;
        b=M3Mpiez8Da4i+a8RsxL/44XKb6C++4aEf2x0xHEgnysTqileIwVaWCWw1iVWukmkq
         7cOnVvY0IuaaeXOMY9o8muTfC1ANLcuEghhG7hdJR1M21zUdzJ1uGczH9BlcQ2vfi7
         tjAwAHDfvNkLBDqKC3tfFCDYVMlpb/FKeebEod7s9Exc2dSupP8C3HCDWCd8uvzkqW
         GYYfl8t3fbdbGfZd2TmteGm5w/XHvzeCa9IVvtA7Y+tf5KNMDvYuTuRCS5J9W5J85n
         6p6edVLq36/XI438JT3xiooKzIPAV4YbIsJEslATNobu0pHTKqGx58/lto4rghCeuo
         biKtp/UF7NGtg==
Date:   Thu, 24 Nov 2022 09:08:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mm tree
Message-ID: <20221124090815.7e550d88@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KStk=0KCkmIKHIyJ+g.9YS8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KStk=0KCkmIKHIyJ+g.9YS8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  d5d60d30f574 ("mmu_gather: Use macro arguments more carefully")

Fixes tag

  Fixes: a6d60245d6d9 ("asm-generic/tlb: Track which levels of the page tab=
le=3D

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes
  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

Please do not split Fixes tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/KStk=0KCkmIKHIyJ+g.9YS8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN+mc8ACgkQAVBC80lX
0Gz9Twf9F27hwSCHsLVOj76pGNon7FxsixeppKEE5yPMUiJQtXa0Qwyy12W7X1c8
iMamSMDI7id2XvLMNbpfdQdCyMuy0rzleFhJ146l8fbRNrPy2apPDyMWxkS9B6mx
SksWW/zBpst1FbA4C4j0ggy/6NO8cQbtRjK6U3aLKPieOiNql21ohSj6pyk3CGor
yEIrFQvl55OyEvNdciE/a81X52QlW4/RNc9/jmDaQ94NBMNzrLkIO6WufnJ5iY37
ICsY6LmNwGCZwua9qq//w/FoPRyiA32WM94Txpg9+v3DdN6PHHNhLaVsjZZPub3n
Xga0byx4zRniLYbH3nvISnOd/moL6Q==
=dQm4
-----END PGP SIGNATURE-----

--Sig_/KStk=0KCkmIKHIyJ+g.9YS8--
