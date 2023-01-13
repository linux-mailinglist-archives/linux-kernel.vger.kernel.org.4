Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA87668947
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 02:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240651AbjAMBx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 20:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240329AbjAMBxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 20:53:25 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B989C61446;
        Thu, 12 Jan 2023 17:53:23 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NtPZn6tFBz4xFv;
        Fri, 13 Jan 2023 12:53:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673574802;
        bh=S9U8oytHB3dSaeyje5uwZ/YSmowUo1Oik8gExE+pJVg=;
        h=Date:From:To:Cc:Subject:From;
        b=oloNKr4x/+89rlAXowpA8x3aBQDGsP27sTZARZ0CY56OXu9n8JXkCpcnaZD9gMg18
         xn97MDi6n9k9qAOvHZKFmbswuf1g9/MS4WaGtb0QMnrOH5v+xFEoqoYxRXNd2yoEU9
         BIFQs26Bwdznr52FGrDeshipzzAvVZYpf2oGLAcICO2piUDHroDf2q+X6PvMmw73bO
         GrYiXcqr9nkaLmcLANyhHQCdMrjxDW7A49DPs1WnctcpbH1Gq3acsNAZl1qsdNBqhe
         t68AgCZhfobUBZW1bYdaD2v+fZPEYCUG0a/gErA10hpWJ9LT2K4fId5ugiTwrdDcuW
         Vl1tOE5jfvntQ==
Date:   Fri, 13 Jan 2023 12:53:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Xin Li <xin3.li@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the tip tree
Message-ID: <20230113125321.4c60d02f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Pfl4L1.H0m+xYyyaz6oVNfM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Pfl4L1.H0m+xYyyaz6oVNfM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
produced this warning:

WARNING: modpost: EXPORT symbol "asm_load_gs_index" [vmlinux] version gener=
ation failed, symbol will not be versioned.
Is "asm_load_gs_index" prototyped in <asm/asm-prototypes.h>?

Introduced by commit

  ae53fa187030 ("x86/gsseg: Move load_gs_index() to its own new header file=
")

--=20
Cheers,
Stephen Rothwell

--Sig_/Pfl4L1.H0m+xYyyaz6oVNfM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPAuZEACgkQAVBC80lX
0GyrAAf/brIIZNRyAKAierbKmEcI5zwCbtEP8h/+pt1wN4EapxN+fx4NBY508iwp
so5yy6pOu23LrQNIK8xubI/mMXonXFo2rdByWWzw7it0FRERKx6ofintqu2ef4Bj
dgjKnfS7pCYcCrQIoAeDm42lD2KfF6WruPa1huJZS3+xl1l18xx0GDl52MocDRME
gj54yRRIj8ESwd4QODK8lykehmZSeB7++U6nlSNSPRiSJf8+VJHGMy8R0ukMlEed
v+QvCHD+6DRp5hnGrNOaEITZwaNsTPFFK7/Itd+AQAw46KqANaEqX2GAOxVsjDSM
x1Eh5HCSqWIXagz75pJhYH83OUaKYQ==
=tzyc
-----END PGP SIGNATURE-----

--Sig_/Pfl4L1.H0m+xYyyaz6oVNfM--
