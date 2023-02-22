Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B308F69FDB8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 22:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjBVV3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 16:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjBVV3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 16:29:09 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125E8457D3;
        Wed, 22 Feb 2023 13:29:07 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PMTms3M9Fz4x1h;
        Thu, 23 Feb 2023 08:29:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677101342;
        bh=bC9GcwwFX20EGJTE/Y7UGQTEX+Sd3Nu8RIMhF8sQRZ8=;
        h=Date:From:To:Cc:Subject:From;
        b=SXkAGNd8VKofJ1ytrWc4SmbNgwXpZQe0QrEkff2RXQ3orgbbnV0+pvS2BaQLblbm3
         +LwOuteRw28OTNr02uP+f0ROLA/N3XYIAjzlOJu2MK52w1huhWy7TK5NYm34EO7obz
         gi0WGHp7/qJ08cG+wUuMPMSiFslFWH1yJBaMzgkCteA40DrT0flyp2PGavz+WO+Th9
         lYNQLIQmy7+bM2QEYjrpWxGHklMKLFttoy1xX4LAPWOLQEL3WiX5RozFTVnOBCMdpC
         41QUDo/Vg73QiSKSAuUWJa0uGYk5JYfm/QkCshRIgfaaOzHVbCDTABJcJ15bKZdEn0
         FmLF2RY+jrVJA==
Date:   Thu, 23 Feb 2023 08:28:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Wim Van Sebroeck <wim@iguana.be>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the watchdog tree
Message-ID: <20230223082859.721291a8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iXoT5YR5Ojy2E6Eh=7Xte48";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iXoT5YR5Ojy2E6Eh=7Xte48
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  d3c8d1acb808 ("Documentation/watchdog/hpwdt: Fix Reference")
  ac91a6bfe419 ("Documentation/watchdog/hpwdt: Fix Format")

These are commits

  5e3be09f3fb2 ("Documentation/watchdog/hpwdt: Fix Reference")
  cc29eadef921 ("Documentation/watchdog/hpwdt: Fix Format")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/iXoT5YR5Ojy2E6Eh=7Xte48
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP2iRsACgkQAVBC80lX
0GxhkQf7BZ2tk7beVvmpGsR1JFidbv/4QnR3QWzzCEkeAXsD0KrUWnUn2jsE+pJg
RbRlZyOsBgFVa9YjVFh8LabJeRi7u1aCEuM7rqbwq7xFyx4o2KTIS4x7BXndnfRX
523B5bx/CW6da9jtf5GPm/95J+/xWyLFbi6DKPYT2MHNzAxojiTjav9ZPOF8zELO
4opM3lwDM1UXiXztTMb/On6/uswFCLs2N3aF02v26plPh4U11qmodqr5Z9AWoAmB
ru8f1/Of7r2rIX/4JSZyTGxZQKESyR+QGWfw8/3nzIVUVukBDVkhAQIpuVbU7vTk
XhzVlZKACSxlO0TLg+XN4ukRQ3nX3Q==
=+lt8
-----END PGP SIGNATURE-----

--Sig_/iXoT5YR5Ojy2E6Eh=7Xte48--
