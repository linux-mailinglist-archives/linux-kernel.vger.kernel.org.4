Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2296871F679
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 01:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjFAXTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 19:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbjFAXTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 19:19:07 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E4AE2;
        Thu,  1 Jun 2023 16:19:05 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QXMX75Zhsz4x3g;
        Fri,  2 Jun 2023 09:19:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685661543;
        bh=YfUNQPQU6xY0T8WHIxn29KjtUFufkzwEa5i9H/VKgQA=;
        h=Date:From:To:Cc:Subject:From;
        b=mt0ptTFHhZv/sg+O3n6Q+CxZcGPd3NUuJdFHfZ9bLB9flIJ6IIxnSdO+8Gt9yDBG5
         9z8/LQHwrYEfuVdqXNOB5lW4z1FCpfgNJBCOFqeCxViMn48OLnD6y0tPvKBY0EbLub
         xSJXa7V9LRodkOjz5+KfGG479kQLtKRNPL8zde2o7smUWr7gfAT/Bu0G7Y3i1BmWoy
         sKvGDhq0DA6hXfMPjRK0vgMyGzqoIHgQIF9Sf3EiM3JiaFBv4xIrMoD1aixMW2TNEB
         LhyOkSMcA1L1ZIpgz9YpLaIwYqw4HU+oxMeGwK+uj7meMlDeLPk3sUGaOJAJLKnlX1
         RVX80TCQIP8Dw==
Date:   Fri, 2 Jun 2023 09:19:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Wim Van Sebroeck <wim@iguana.be>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: error when fetching the watchdog tree
Message-ID: <20230602091902.5d191348@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/J4Z6Eqd_9XdH9yrTI72NLE2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/J4Z6Eqd_9XdH9yrTI72NLE2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Fetching the watchdog tree
(git://www.linux-watchdog.org/linux-watchdog-next.git#master) for the
past few days produces this error:

fatal: read error: Connection reset by peer

--=20
Cheers,
Stephen Rothwell

--Sig_/J4Z6Eqd_9XdH9yrTI72NLE2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR5J2YACgkQAVBC80lX
0Gx/OAf+O5LpMtGB/YIuUnNV5T2j8bfr36+thx/xYPofExZH9My9Bx2L5YvEKvvP
xvDK7UObaNzihR+iM4hpAzmRizTprGMTjhOXzLysYO0ZJSMdWzQkwysMC+G1FgUK
QGjiM4epGpYeRptXX+YflS41fcShodwqKpPfOcPHX4RZToVjQng37NyqChOnLm5O
A02FBGo9hnuQesqRdpX+Z9WwfEQEhzaKxwuskuktYQp0xXKpHTGGVz/lVDXYH3HL
0URMnLbPoRKeBZQKbPhyaazjbDaMJXmssUh9XrGcIcp1zDp3BZt/hMvuPPvb7T91
vOc1puLcb1Dpx/N9lRwh2TJXyVVLFQ==
=KBoJ
-----END PGP SIGNATURE-----

--Sig_/J4Z6Eqd_9XdH9yrTI72NLE2--
