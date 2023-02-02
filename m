Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FEF68890D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjBBVdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjBBVdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:33:23 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E58B6AC95;
        Thu,  2 Feb 2023 13:33:20 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P7Bpz3tNbz4xP9;
        Fri,  3 Feb 2023 08:33:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675373595;
        bh=PVkCOqJEmLoorNvOoknf+VBHsSx74+DbNElrc683SXY=;
        h=Date:From:To:Cc:Subject:From;
        b=Ihb5ef+8nXllIUa65ccBq/iW1GoWCOQLQZ33tRl8/xPECj/3TgEd3vx9TBkXOncGm
         KsAqr4e0KK/cjtsGQxL91bNJ1tBvKZzY04G9yxopSJKFN0W/mxjJhWnnZ5mMNcnjmk
         rwYHP5CiTqnzKrAh75PtKGEjsmSZF2HOhZk8FoN1VY3oPaUjWHruZsoERj2bjo0F+N
         SG8I8VdZp1rvklDeA3eiUeFirHSVaKGZNnU24vWp2/U/NfJ1/7yZp9cHmw2sFQk0Yg
         8nNN/RkFk3rpkJYh6u1xXEpmZV9CmpEte0M6jSFKdzkoAjnAo0g+9vVUynTyBhai0H
         4ZdC9UCKlf0GA==
Date:   Fri, 3 Feb 2023 08:33:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the drivers-x86
 tree
Message-ID: <20230203083313.53745bdd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FPjOj=HwxLIpjEdiLEFr+tB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FPjOj=HwxLIpjEdiLEFr+tB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  95a579b5c89f ("tools/power/x86/intel-speed-select: v1.14 release")
  19aceabd7a26 ("tools/power/x86/intel-speed-select: Adjust uncore max/min =
frequency")
  75ade1b46b8b ("tools/power/x86/intel-speed-select: Add Emerald Rapid quir=
k")
  a06644c7dc9b ("tools/power intel-speed-select: Fix display of uncore min =
frequency")
  113943d71f54 ("tools/power/x86/intel-speed-select: turbo-freq auto mode w=
ith SMT off")
  9bd3f4d5ca2e ("tools/power/x86/intel-speed-select: cpufreq reads on offli=
ne CPUs")
  61246ca53e17 ("tools/power/x86/intel-speed-select: Use null-terminated st=
ring")
  e5bf2623cf49 ("tools/power/x86/intel-speed-select: Remove duplicate dup()=
")
  1bf2637725f8 ("tools/power/x86/intel-speed-select: Handle open() failure =
case")
  1fd93ae6e2b0 ("tools/power/x86/intel-speed-select: Remove unused non_bloc=
k flag")
  74ea37879c89 ("tools/power/x86/intel-speed-select: Remove wrong check in =
set_isst_id()")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/FPjOj=HwxLIpjEdiLEFr+tB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPcLBoACgkQAVBC80lX
0GwoHAf+LHJjhscxi2OZZxBwdEjWUDEku5tVu9/6yoTsV45lHaexaw5epV2QTvqD
WVrzZjyH/N/4OPETE0Mb/DSqYtFmq/959SUrBIROJ13NIxfID9dYkyu9GRlniWtx
QrZnMOvmIILsaslbcIJceiLGou0k4NT8u1G9OdAqV+FSyEYo3rLxrQW+Z2JA8Ysk
kzgrfAFs3UaZx+bxjqNP/zz12rXtuTELnAULLfBEcG6MfVNikqWQqcJDQhlYy2cL
JF4+HBVSgy+PIOOogzP8GMsVW1ol/Lfh2p0W7PTcFTsm+nNlHAFWKxCjnBIfudVw
nwEFnF/nFKkWzEEi/js3Q7eBoKVkyQ==
=XQO1
-----END PGP SIGNATURE-----

--Sig_/FPjOj=HwxLIpjEdiLEFr+tB--
