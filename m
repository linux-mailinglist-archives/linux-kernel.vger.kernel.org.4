Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000516143A6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 04:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiKADbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 23:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKADbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 23:31:21 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D3EBCAC;
        Mon, 31 Oct 2022 20:31:20 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N1bCV42jMz4xG6;
        Tue,  1 Nov 2022 14:31:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667273478;
        bh=5sOu7Pp5MIfQEoQ+iRj34Ry88sZkoQpOF7QKNfomrto=;
        h=Date:From:To:Cc:Subject:From;
        b=MgQ5oM3EYnYeWLkXpdSMO8OhRIvW7puDUGpBx+vL1/mHWq0P35a7aimjE8RCn2RXc
         pnx/SB9i6IJ5hBMssDrXpADSOQbbXp9Hcin6NsTuQQgtzUbv/EvGqNYkZ4MR5GhMNK
         sJU/shA7GyfqXiMGVRtU48Cb98uibQG/4rpzTLta2TMSl3laSGrbZG5K2S1nTaqsiX
         2x221oNfkPi15RzLK9483QJS9ScGmsXjxz9SACVlrbf6VJnWiM8ePlei/ATbAaDS6D
         uioGiR/TJsOKKOdmL9rygwNogmftRzAWZLeTLYngkYWaEYPVj1usidKSmR/U1oU8f2
         4UeHfGVby14hw==
Date:   Tue, 1 Nov 2022 14:31:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Carpenter <error27@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "YoungJun.park" <her0gyugyu@gmail.com>
Subject: linux-next: manual merge of the kunit-next tree with the
 kunit-fixes tree
Message-ID: <20221101143117.07829d4d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tQCdwl_qW=k2iiGGtGF40E+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tQCdwl_qW=k2iiGGtGF40E+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kunit-next tree got a conflict in:

  lib/kunit/string-stream.c

between commit:

  618887768bb7 ("kunit: update NULL vs IS_ERR() tests")

from the kunit-fixes tree and commit:

  29ad37f740d3 ("kunit: alloc_string_stream_fragment error handling bug fix=
")

from the kunit-next tree.

I fixed it up (I used the former part of the conflict) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/tQCdwl_qW=k2iiGGtGF40E+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNgkwUACgkQAVBC80lX
0GxREAgAhEGpr1iIBpGLjPa8sLRhB1vYqU+QexlMqoe+dEHhcyxLyWccB3E4HYyF
trOUNIyrVrJrYZ+0Cpy0un3NyR680wrK+QcuACPwh45bcK2hoiWi0s+Pb3OzpFP5
U5no8DGBnuK3s0g4xVt9tQjaud6EBinLxayy8gifDQtxYFXi23xlhOLQwsnkZrMI
SDTYqcQyh+SrxUDoYbmoQBWD4kZfPoZt735vVaKXEBOiqo/pjVwHpyTKc4Pqiwva
NjnvSpArF977Q8c6rlnLnK3Qry6gTsMPP62UQ9jcLUg9Lb/hhjYZjdcMOa2aZ0Yn
+ezTr5bcIWSD7BF5GJi0ZyEB857GwA==
=3fkm
-----END PGP SIGNATURE-----

--Sig_/tQCdwl_qW=k2iiGGtGF40E+--
