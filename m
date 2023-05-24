Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E65F70EA02
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 02:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238935AbjEXAGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 20:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238937AbjEXAGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 20:06:38 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF35135;
        Tue, 23 May 2023 17:06:36 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QQs160gylz4x2k;
        Wed, 24 May 2023 10:06:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684886794;
        bh=DDaWs+DOiKeOYB2EZ302nVs8682iKofQYavZstdYi9k=;
        h=Date:From:To:Cc:Subject:From;
        b=EZgJujH/dqxahAoxt1xfWOt+Q/2OvhdvutFf6DSt2ndH0dgMY47tryDJ6t0RcaZSE
         911Fskfe6ES26QCje5Vks5m16aifxuepUSjjAxARlx5z0rb1bY92ClMQvr5rJ9bgvk
         QAtV2kmtE5R93IxiVZl5Vbbr3RawkP++V04DBli+1N1jOqK94Sf8KsYURby+X2z9Ja
         AN074ujMAKuOV9d+2b5yjy0J6UzBJarGuKO7sGtHNX4yB8BUEnrMJVM8I1LJxrUL44
         eONeiv99BlrnaavI/FHP4sbjtLEeLBUhm/+C0LIYM/IMUmCLAyrfshoJYTAt3jmFxY
         FKPgPYeJ1N0aw==
Date:   Wed, 24 May 2023 10:06:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Danila Chernetsov <listdansp@mail.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfs-brauner tree with the mm tree
Message-ID: <20230524100633.0d2148b5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UK.RlxxSvAaRLATgs2SD+ZO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UK.RlxxSvAaRLATgs2SD+ZO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  fs/ntfs/mft.c

between commit:

  e7c5ef2adfdf ("ntfs: do not dereference a null ctx on error")

from the mm tree and commit:

  ee3b4556cee8 ("ntfs: do not dereference a null ctx on error")

from the vfs-brauner tree.

I fixed it up (the latter seems to be a newer version, so I just used
that) and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be mentioned
to your upstream maintainer when your tree is submitted for merging.
You may also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/UK.RlxxSvAaRLATgs2SD+ZO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRtVQkACgkQAVBC80lX
0Gyp0Qf+Juu6VaxfPnG73d9TU2VLJ0r0LT1Tr5p2Ne5FLKJ/66CmCfNb8V9IXKcb
xF1FIJ7lbmBTntKpRwuptDNIyh31bwGI04vHhEp3YJv6/AjT6sp0ayfrOB0aoLNB
HYJNFN1HMhoOoAPYS/WxwUtOLr77xXh4b8E6Ek3bFQH/1pvkGf1gkjL/c/I9zuLf
o/hmo54nGZ9qd3Pc8Ydkkp7tNxrWVIxuY6CRAMEnybydRnbXa3OWzt31KnARR8Kv
OrnDM7uAeWp0zND6od2cf2wn/zevQg6D5p664IyVToUuZXknF2MP6yLy9oknT0F8
IVYsMZtCYa9+iQqWbJO1pUnGqklUIg==
=kOwa
-----END PGP SIGNATURE-----

--Sig_/UK.RlxxSvAaRLATgs2SD+ZO--
