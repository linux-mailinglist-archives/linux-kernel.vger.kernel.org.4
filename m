Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC0F666557
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 22:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjAKVMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 16:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjAKVMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 16:12:14 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91A034D69;
        Wed, 11 Jan 2023 13:12:12 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NsgNp68p0z4xFv;
        Thu, 12 Jan 2023 08:12:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673471531;
        bh=3ON9YVj26srq6P7zxiFSg8mBRhqnqMDXMboc3jA/IJ4=;
        h=Date:From:To:Cc:Subject:From;
        b=jZypvcUOS00nUzLSOVhbA4x4d//3EQ/gSdGOmew7yisUareWjCjrFXE5huaa70Dvv
         W90XnGD++lZ+kN0G1LApmTUWa2CuvZOxGuSoWWKkCfYsNry1pv7ya/a2KuLDXgLq5q
         rRjghToQDWLXxY9yOivabSiNYCJbi/BVTtpDIpGna5yEP+nkQ9B9X5ksVlvTaUAWER
         lHDoQfkm8eWPOd6/0Ak541K7oGCGzsQPiPE6wU2zWUc/rKBefONBwFzaG1jKE87fQl
         zgDF/QEa9ZsBlA9M/nokRY6dgH5ENNjto3aU+bUJUrWDvrmJlqrR8aYYw2VgkIwv+l
         obWkYmx/5EnMQ==
Date:   Thu, 12 Jan 2023 08:12:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the qcom tree
Message-ID: <20230112081209.1dcd2635@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/JmpCruP16A__=dwDkz=GbSM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JmpCruP16A__=dwDkz=GbSM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  4df6e8fbe6e4 ("Revert "dt-bindings: arm: qcom: Add SM6115(P) and Lenovo T=
ab P11"")

is missing a Signed-off-by from its author and comitter.

Reverts are commits as well ...

--=20
Cheers,
Stephen Rothwell

--Sig_/JmpCruP16A__=dwDkz=GbSM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO/JioACgkQAVBC80lX
0Gx8WQgAgJswpLDcJ155Rfp3hd4To1oTxqs/D6O0bBciQO6ycMDFh//3OZ4+pVAc
+RHq3/q5ZndMYoLaAs1U2AW0eJ8MfKluoQxDGZXbJhQ0QhLaMML9OIWjXKePPg1e
clmkX7uQfJT1O3r0heAZoyaDaB1SmbNArKbwNDVEn/GO/XUFBZC/meQlxEdPDSmW
Lv035xK/asSKJFo2o35nfowMFW9NUa4AfihsJoRnG/P9e5hihWWuSeaffko00TBe
1QPvvoS3+YhlRB9j/+9/EUhC7TKoJKXSBJaOWoVqO/x8Iarl8VVo200SoNiB9Muf
t52S5eTMU8EY4hClhz+rpNDPVRtYGA==
=Bu5c
-----END PGP SIGNATURE-----

--Sig_/JmpCruP16A__=dwDkz=GbSM--
