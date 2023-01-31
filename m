Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FD6683AD7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 00:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjAaX7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 18:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjAaX7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 18:59:44 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB36883FD;
        Tue, 31 Jan 2023 15:59:38 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P628m68NBz4wgv;
        Wed,  1 Feb 2023 10:59:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675209577;
        bh=dSpxuirEUSIDKHlfTGHnWOqEHbW/u5UzBT1E4zx3kXQ=;
        h=Date:From:To:Cc:Subject:From;
        b=UWWhCAqJrXFOqB3iTjihU7NQL9yeAbLKBhs7OAs/RN4cts9QrBXgfAj4/Qx/ou6sy
         ZUTQlv8Hrn02XYv08YKp0THoti37wUmLsPlYMwb7LWbwe3xBGsOWa5TGzQKpgOxFqx
         Vl0HJmVivVFOJJ9ROLT5vnm5IDdCRONmbWto7Hyw7at01Uazj1nHlMGmNg8daYo8vb
         3h23Hnl6Yfqs5egzL1duMSKHsZZLjxrrqdy4KvCgJtj3NpRta/gBEz2v1YDjn7pOYk
         LKQpEVoN20KwMXR32A4XAY3yepXQB3Rz93hOL6cEmWhMjsg31p4H5Ik0WdqWsiQMP2
         0jPL7Rst3Fm8A==
Date:   Wed, 1 Feb 2023 10:59:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the sound-asoc tree with the arm-soc
 tree
Message-ID: <20230201105936.5df92b26@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iC5JR_MrhobD4AelcJE0jRE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iC5JR_MrhobD4AelcJE0jRE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the sound-asoc tree got a conflict in:

  sound/soc/ti/davinci-vcif.c

between commit:

  efe81e9a9273 ("ASoC: remove unused davinci support")

from the arm-soc tree and commit:

  2abde57fb82b ("ASoC: ti: use helper function")

from the sound-asoc tree.

I fixed it up (I removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/iC5JR_MrhobD4AelcJE0jRE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPZq2gACgkQAVBC80lX
0GxPhQf+Ia7Cj5eDPZ/SvjzuFZQ3soUypnfco3VPT8hjd5AqnKyWbvBG/q+b/rA1
EyeORa8ZadPzv6vzBOKgV2EDxa6s4ZZ15s+1UOkPdFq1K88EO/You7Dwjvbxgkai
mexRS/Ww4mJpzYcGa/oOl3Fr4KbMYad22IcaVfyeqxsKliDNHC/xHDxGxrpoGpJF
s8eBGA/NKX011nitivqFJwG48JuE/eWCGBHC4uAONBoO6mSYfb6jPxzA/1CwpvSA
tzbecH0DYDrcvVHrKz1f3sQaCCeV/uK9IIgjVkBvJ6QloWEfqKY8ZewydxVWWQ7d
d0RrRM920Cj7ezImiPv7691g8CSmeA==
=aRJv
-----END PGP SIGNATURE-----

--Sig_/iC5JR_MrhobD4AelcJE0jRE--
