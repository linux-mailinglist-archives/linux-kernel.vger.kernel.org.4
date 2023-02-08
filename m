Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CCF68F91F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 21:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjBHU4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 15:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjBHU4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 15:56:47 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977B9233EF;
        Wed,  8 Feb 2023 12:56:43 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PBsjy1h1fz4wgv;
        Thu,  9 Feb 2023 07:56:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675889798;
        bh=XNTGNkowDJ6fVg5HNo3QXQ++ahxAzp+geEpR6OrIaRw=;
        h=Date:From:To:Cc:Subject:From;
        b=edk52gA5uATabERRxe1VTVPATpBb7bcc5fWOtCPwJNlwl4wyWkicb8Uc5bGr9d1XM
         sXcCOwLa0dX5v0Hs7KBFhjuszhL2p75516Y+Vlxt041uJ8wMsRRH87H2arsUj7l32a
         /tlO+H8MJ0ask1b4E+c3SkE9kfypPxDI+4SlsKLsI3j9D7b82hqdc0cmVwxEojkHOo
         jfZDKu21j/ccx9AVnkhQlIlTXdXqN7sRorxxW7Yfi6nPhqGXMM+4oDJ1bS/aEk/8gb
         v0XAaKuiAGIzqBHMxHFyA1cGVdIEWx2O0bss1lDzrpsr6s55eR/lmQ9ldYZ+kO6Y/E
         0g6J8meQ9xjMg==
Date:   Thu, 9 Feb 2023 07:56:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the v4l-dvb-next
 tree
Message-ID: <20230209075636.313e54e0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/in_pKqgR7o+sxv5am=.=ZnA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/in_pKqgR7o+sxv5am=.=ZnA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  fd24c6974a3a ("media: Revert "media: saa7146: deprecate hexium_gemini/ori=
on, mxb and ttpci"")
  a4ff09f5a690 ("media: Revert "media: av7110: move to staging/media/deprec=
ated/saa7146"")

are missing a Signed-off-by from their author.

--=20
Cheers,
Stephen Rothwell

--Sig_/in_pKqgR7o+sxv5am=.=ZnA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPkDIQACgkQAVBC80lX
0GyG5gf/SndsW0F/sscVJZEuMYuxKxDC5AOS3tbHepag2RGGIIudhxw9XISUbTVo
L8zPm4qfxLUUrV36gOjLbnZyqlPX0mZbwkU8LIYUf+0sxIJU782Nbd+NSNtVd24v
hlHCibpzP3g1ELvWrxQTnRPt4NomDoi6mFA6Mow15wkFN5srg2qXLL4NKHYtyKBV
wgPcXkF1a/2NILZvIIW2A7VYScDVXqDq4dhxKNLA7O//TKXFYUdviyUXsggCU1Ji
v5UUmJXLuPuOD+Pb286sfJSqDUkcY0GfqQuagM1Q1WYNmH9Sxs3xThQJ5B5DZYBg
kv47xQUI7/TfQwvj/aji0VkozyRWTQ==
=RWF1
-----END PGP SIGNATURE-----

--Sig_/in_pKqgR7o+sxv5am=.=ZnA--
