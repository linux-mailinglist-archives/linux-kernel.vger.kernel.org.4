Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8BE67DD1C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 06:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjA0F0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 00:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjA0F0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 00:26:51 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9219370D54;
        Thu, 26 Jan 2023 21:26:50 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P35fb6QkQz4xG5;
        Fri, 27 Jan 2023 16:26:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674797208;
        bh=iuzXs3CnvmBOkhjeUXPJdPwW36jojbtktUym4uSLjR0=;
        h=Date:From:To:Cc:Subject:From;
        b=l38X6vZ0hzt2Dr6z0tJyBDm+2e0QFU4XPdM4OCERAfOd5uhkFi5qNP1uM2s3jIQcG
         ursSl9kKCOH36/sAn4n8vuMCX431HJZX0kb2HDzgng0BuG01RZSmGKatpCIM9ZyaoF
         sAZxshA44EsW5kACwF6s+sgYhtm57hTsMW6KZi09+8kHVpY8nc2HmnpLTG7TzbsmT3
         dLHFk9Bg/jmwPHwDwg/tbxqxDKUKn52Jmu1PvjaTAAYns6+yC5GCqmtlMCWHrYW/o7
         0IFX0u/Q64P/nlYpde79BZkityOQiXJZU1P22Cjw86GGjxjgtY9BsB4o99gzmYgG/k
         Qd5jKr3xxqJIQ==
Date:   Fri, 27 Jan 2023 16:26:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: linux-next: manual merge of the mm tree with the v4l-dvb-next tree
Message-ID: <20230127162647.037701db@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+40cqDYbX=uP7.ql=CadBHf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+40cqDYbX=uP7.ql=CadBHf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got a conflict in:

  drivers/staging/media/deprecated/meye/meye.c

between commit:

  ba47652ba655 ("media: meye: remove this deprecated driver")

from the v4l-dvb-next tree and commit:

  6fe0afd07701 ("mm: replace vma->vm_flags direct modifications with modifi=
er calls")

from the mm tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/+40cqDYbX=uP7.ql=CadBHf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPTYJcACgkQAVBC80lX
0Gw81Qf/cKI0x2DMxbH6D1U5FRQWqjzkqWs+rPsHBluMJnibWJUqokjtqJvQg/xF
7mQrhYI+uQ6Sgr7P1PzXymHCDqrtDx2b41yOP9M2jl3YrEw+yGWSO/IVtp48CjRR
S3FHMeJ8KSSnbCCbn06Qxg07QPfjIOeDw0uZMxrjscuzy4Jpy87oCfqny8Y8uxOJ
q8Nl6cPdrX+bmn+6a3YUFylL8hAPw63s4u88YtwiPRhp+rrDi6GvGluzC1aDGDQ/
+dwCM1eCoos6BEQ+LvxNi65iTbN/N8PzhwF61tNNF+sGVQbw+H0wQEuNk7E7+BOv
lPd/+6mldjoFvUSTdzk7L3PZFlzCfg==
=ILDF
-----END PGP SIGNATURE-----

--Sig_/+40cqDYbX=uP7.ql=CadBHf--
