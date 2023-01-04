Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1381065DF57
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 22:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbjADVw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 16:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjADVwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:52:54 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE96DBB7;
        Wed,  4 Jan 2023 13:52:53 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NnNcz6mGpz4xyP;
        Thu,  5 Jan 2023 08:52:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1672869172;
        bh=dEPWsdpV9aAX3GVDLZp86dY/Kb8XpuOjI1C2ckFD/70=;
        h=Date:From:To:Cc:Subject:From;
        b=EQ/UJyILs1QGz8y0E4kUG7yOnFs65KDoyMaqQbpwvvWuYxyJLzxu/FVAb1KtmxdRj
         uCGzKNMAaKygO9b2tx2NvCn5hhDI3hc3hUcdCGdY4zyYkr/7Ayg5iVl1YoEh/LvuwY
         NbxgjZedfd1T6Pu3tk8p21kPKzvaTEcbjpdbKd4bYoBqL5vjjbWj7sNSCGFllzUCJi
         BFeLQMCx+V/Wye+fcgvgAU6aNH4ettCKBtgMM20PhAzuUo5jFZ9naHfZpNhExj1azG
         EsjDr1whOCXpByX/m/bA8S577mGlpGlvObZXfWSvDQ0lctAJeu+UHkFlomJcFzd4u6
         pK9wcAUiy0/yw==
Date:   Thu, 5 Jan 2023 08:52:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the kspp-gustavo tree
Message-ID: <20230105085250.03cb9321@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3CkbBtnJWV5TlA8W26SpHke";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3CkbBtnJWV5TlA8W26SpHke
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit already exists in Linus Torvald's tree as a different
commit (but the same patch):

  7626d500ecca ("can: etas_es58x: Replace zero-length array with DECLARE_FL=
EX_ARRAY() helper")

--=20
Cheers,
Stephen Rothwell

--Sig_/3CkbBtnJWV5TlA8W26SpHke
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO19TIACgkQAVBC80lX
0GytLAf/fD7xzgylO2Z1B2qW5pf0mfN3lw2xRoxqb8nu/wwrtywnGeRIbtKEhVKk
GyMFbJnUG5QUrf2aMnpKPibBF1O1zykTSeI1rovVbdUfJKOO6eiC2ZMSvomov2CK
FC4gwUwtxsrCSZ9fEGZvJ8DAJ2sQ4myCgr7+hKWdVeBb7STjM8Eq4TU3ULZStK7x
rEd9SqFmH6nLuA+dK8khO12N0jo6BJcc6CP43iA3G5o2ngc0tHVruF6Oc/4Obqm4
mFXOCtGAaG7E/7utuTaD0BL9BEpV9y7Qb0a0BxCiX8bWG4G1Z98Gb+LvvyVE9hlz
zdSucGjbg/ZYBDQrEY9pu7KhooGCvA==
=XxMS
-----END PGP SIGNATURE-----

--Sig_/3CkbBtnJWV5TlA8W26SpHke--
