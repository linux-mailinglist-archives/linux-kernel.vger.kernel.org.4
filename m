Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF1474C8D3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 00:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjGIWWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 18:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGIWWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 18:22:53 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB7C120;
        Sun,  9 Jul 2023 15:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1688941366;
        bh=YR0Sz7F3k6DZxSRHEmwOsy/mlOcP3kPpkHC2SgF7wXA=;
        h=Date:From:To:Cc:Subject:From;
        b=I0Q7z3FU8URvmmvsqTwsHMO81bzP6qAqisRCqu+9Qde/Ua7itJ+jub21J0+NMQCPW
         jvr/D3h8t8+N/IlasCsXwT0qWeksh4xMOnoCSIkhSIh3VkMO0SR7js0GsWxLMlWId/
         j4s1cjsf0AJDQzW6QCXuby1ycITqFNxhVUBUOrAOOBD7d1njUR0Rf1r8NsCvgWATfu
         1mQ7NFFiKWPKIFn/EMDW5ieyZ2E3s81Wc+Tt0YGXko6Aq+X8o/iPO75VeR/o/8AVyx
         BtqQiCUhW78R36AvNcN9wGEgcixXgsnvkFlmTK5OVj/brT3Jhy+RFWLH8djo9GUzMF
         qtTv2tO+Uitag==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QzhTf0tj9z4wxN;
        Mon, 10 Jul 2023 08:22:45 +1000 (AEST)
Date:   Mon, 10 Jul 2023 08:22:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the apparmor tree
Message-ID: <20230710082223.7585feb8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jDkSK2=q.25KYPw/sOt+u7c";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jDkSK2=q.25KYPw/sOt+u7c
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  0bb84cff96af ("apparmor: fix missing error check for rhashtable_insert_fa=
st")
  1079ff8963ca ("AppArmor: Fix some kernel-doc comments")
  97a79eea1797 ("apparmor: Fix kernel-doc header for verify_dfa_accept_inde=
x")
  b45be9bd7cf9 ("apparmor: fix policy_compat permission remap with extended=
 permissions")
  c96a8a8c021b ("apparmor: aa_buffer: Convert 1-element array to flexible a=
rray")
  cb60752f0c37 ("apparmor: fix use of strcpy in policy_unpack_test")
  e31dd6e412f7 ("apparmor: fix: kzalloc perms tables for shared dfas")
  fd18ddebace4 ("apparmor: Return directly after a failed kzalloc() in two =
functions")
  ff9b84eade6d ("apparmor: add missing failure check in compute_xmatch_perm=
s")

--=20
Cheers,
Stephen Rothwell

--Sig_/jDkSK2=q.25KYPw/sOt+u7c
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSrMx8ACgkQAVBC80lX
0GwZhQf+Ozf/mDg5qQVAHei5CpQZW6VYF3F1ruw5g/7kVAHLF+GJTUHGprrF8dko
KQAQhLyqovraL9ye7ppIAGU2qAYucinTLKjKsld3GU3TKK1fi6Q8Bsow/HlbjOGe
H06Ffel1jL2XPQP8TUHXhPfmslSTE9uYzIOva4tGo0z4LKwifuPG602Oow8N5kcg
qCE2wzPXt8hVe3vTY4lppi83KBRQKrToXCivNY6l8AM0D5wDLZvc4Z/GDK57Sxb1
brHCDylUP7lv2Kb2LCVMboaCupNGqfom6DIgV2a7F3AjSoneD+s9YBZCfnuRlr8P
7eKT43/+s5G5diV28eKF+zsguOE2Bg==
=6iys
-----END PGP SIGNATURE-----

--Sig_/jDkSK2=q.25KYPw/sOt+u7c--
