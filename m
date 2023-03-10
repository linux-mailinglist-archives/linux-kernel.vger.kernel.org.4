Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D435B6B33F2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 03:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCJCG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 21:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCJCG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 21:06:57 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505B8F98C2;
        Thu,  9 Mar 2023 18:06:56 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PXqDb0B1Kz4x5Y;
        Fri, 10 Mar 2023 13:06:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678414015;
        bh=e0YOamjRCXnMpETobe4+hcATpUdljgdYX9zmdcDYZwU=;
        h=Date:From:To:Cc:Subject:From;
        b=uFDnFRK1PVMc4/VjskHl72NgqBgoX4oxOGflwS3MXVFJRSedgTwDytavVsjbHrm43
         cd1iGacz56Dl+mJh06XH9eH8e0fyE36pPDJ7Jss4yH0wj+l2oJj0x3PNH5Rvz36MIl
         kteODV+zrSBdbnMMazIzEVfMDsWxf5AUd9P9wOVDSRK9Pkrl7tBbDN7L25zGJTRR34
         SjYsI/Q8C6uJzzg5fYixJ159IDgwWkrVMRsZYkmC3lyZ1NXjlmxD6qyKqPbWkzwLQF
         dFQFNYvzLXISIbmkeP8LsSKmL77yYb53HlL7g8wVJ4Xgcme0jQBU/0S+VFFt2wYmNH
         LmhvPt7wWOIpA==
Date:   Fri, 10 Mar 2023 13:06:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the aspeed tree
Message-ID: <20230310130653.38c908de@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+Rz5Kuvbh1LNRGm1CDHhROV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+Rz5Kuvbh1LNRGm1CDHhROV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  68ed3289c72a ("ARM: dts: aspeed: everest: Add reserved memory for TPM eve=
nt log")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/+Rz5Kuvbh1LNRGm1CDHhROV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQKkL4ACgkQAVBC80lX
0Gz3Pgf+KkoSaJGcegiN2ZJPh/0EKZHl9BxKErtm/H7YMzoAqAm9MjEFFIqVIDMF
xERmLqcs8jk27qoy4YQYDDUnZFAKrEab4uNwglzn2u/OIUP+5B6LvHfPNI+72agE
4n4gLPiJdITRi/BLOIOcdDj6CM2NiXz+JxbKIVB2XJkI5CyT2i1xX0CJdFr14bXa
72XfTSROOUkTVhmNM0U13Ien/cOgOT998SEDillMNPoLe9dkE4Hoaj2YkFOtwwWu
uayXBOWEV62ludeOFjtYOUkv+XR+Lvlt1KF9RjWbjbfnbjvHRfvNABACrO7vcy6v
W87gLCyNc5i2fx9fl7LlK6Ocf4ebrA==
=ZQEQ
-----END PGP SIGNATURE-----

--Sig_/+Rz5Kuvbh1LNRGm1CDHhROV--
