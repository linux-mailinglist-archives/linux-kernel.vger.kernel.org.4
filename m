Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF2169DA9E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 07:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjBUGXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 01:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBUGXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 01:23:14 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50D56A55;
        Mon, 20 Feb 2023 22:23:01 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PLTjw09nKz4x7y;
        Tue, 21 Feb 2023 17:22:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676960580;
        bh=R6wcrrpsS2hiBEwlIoFVjn2unZzWqDGdV8RAC9bzgmU=;
        h=Date:From:To:Cc:Subject:From;
        b=AHIF0oZfQILPQVxIE5qbY4++pyo8pCSSwe5+G1Eh4eNg0Uz2BO682Fl7rH4VQvK/u
         NF0fOwrA8HpaYxfKEj6jMayvmxBPV1x2BUmlHSMs7kzqKw1jbGK91eYQM2fpf/ESvG
         u6Ivhy602BGRSsBqqUJW/0LXyESiFlFKkm26ztMURquWxr9HHiKRY5ODgjpK9s5cMW
         zGLyCaMmylybY5y8bz87vfyDpbd5battPH/KUPRFVL3GHS4zyP3afvG9c0yoI79Qlb
         EyyLjDx53Flhnnn+hHQ6TRTes+kibCCo78asijbBk05DxhL0zXE6cGhW/rPB72zrd8
         ETPV8Lf0jDKjg==
Date:   Tue, 21 Feb 2023 17:22:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the stm32 tree
Message-ID: <20230221172259.594fe42c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UyRMKnTGkPVPk+Rp=n5_yj_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UyRMKnTGkPVPk+Rp=n5_yj_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  4e74ad9f3af6 ("ARM: configs: multi_v7: enable NVMEM driver for STM32")

This is commit

  f46bbb7f9eff ("ARM: configs: multi_v7: enable NVMEM driver for STM32")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/UyRMKnTGkPVPk+Rp=n5_yj_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP0Y0MACgkQAVBC80lX
0GyNDAf9HZ9GKb5Lu6zcN+X6UhdTaK3/i2fP0+ic8eXFyHmV3BEVq3YnHPU+5EwD
LDpVf8ewId4UfJIZ76cltqsS0xV6WL2FtF4x72xNwSYXmOElg4U37a+gPCaMKF16
reODnzh6ONhr0HCV34r/tlHqC1xpn7dFYYKO8dmp9LRSSVzXlauqn5HKRa+lbKqJ
/VUqE4+/h4siPBgocOvctdf0L+EnZ8X4CnN91PlG6Q878gq8IFtHCdwucwdMi8RR
iYF+4kD9PPFCDyIdQnJn+EEAFo2pPxWQSO1Lmu+RhlxyHnsTd4FEWVFRc8aDS4c2
QTHzMzOap3JWheSuXIu5NcnYgoB3FA==
=q07i
-----END PGP SIGNATURE-----

--Sig_/UyRMKnTGkPVPk+Rp=n5_yj_--
