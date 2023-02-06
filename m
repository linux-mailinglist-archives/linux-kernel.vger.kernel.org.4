Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645C968B32D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 01:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjBFARe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 19:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBFARa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 19:17:30 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C4A18177;
        Sun,  5 Feb 2023 16:17:28 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P96Jy2rMwz4xN4;
        Mon,  6 Feb 2023 11:17:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675642644;
        bh=thd0k+KOJmz5QA2CBM6ENADwCGJnyT9yH3eN29TIr30=;
        h=Date:From:To:Cc:Subject:From;
        b=h6B/hzbQjLljSGry/HuSsD1Gj1MHc+e5UBPVqaIP26Pz/+CTXAtrrGZkKy5TTX0GD
         jdeh5vin/vJpKMKIJJdyXM7RQTdIeFLk57LTiJMzWQ4vqMaWPxXkgpv34hxeJj4UQZ
         gb7Kx95GiuiY82/y0j/tbp2u1T9VorDKa+TrzPEBtZwnefhscP1IkZ0Z+qOaERU4wC
         L0OHiE3119avMZU/wtpw9dHDXuV3AscZrYR0nwoAtI1ZkKL0dpWwfToB1uZ27urF6L
         De+AR93aBnuP++q864Xa12wYNUjp371RAixGEVLnF/GIP2dueusfj4poTrHdXeBuTe
         mPcYNJXdQJfYQ==
Date:   Mon, 6 Feb 2023 11:17:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the stm32 tree
Message-ID: <20230206111721.034f57e6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gC9tCr.uC=8k1ggQelnWFPT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gC9tCr.uC=8k1ggQelnWFPT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the arm-soc tree as a different commit
(but the same patch):

  4e74ad9f3af6 ("ARM: configs: multi_v7: enable NVMEM driver for STM32")

This is commit

  f46bbb7f9eff ("ARM: configs: multi_v7: enable NVMEM driver for STM32")

in the arm-soc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/gC9tCr.uC=8k1ggQelnWFPT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPgRxEACgkQAVBC80lX
0Gw8Bgf+N0SlS5P9uqf51MzXJoaaD3Hw+SKoLMn5CXCkIdrh3uW5mXH4XYS00423
Z9hVRCvzDRAQxmqfoKb1LQN/2WP+W7ZJtu1jEfyHwg6VQoHulAmz5T7qjr9cLCiq
stxOXy2CfKveEvf5fwQQurXeAu0GALRiAITtePDU+iLq+fY67nzvkjjq4gY/gVv0
ilClAq6zfK/ZY3YWi/Q9Su7ujwbPPRc20TgmjS55SdU0pz8LMK52/cs0B6sPNXiE
wESQ55DkZWgswXhpENBw+AcUG5fLWwFftE70/0beSoSgS6hQCwqJpKb2vFDoPHLn
lAJEPfmlNX5px/yRJ0U4MWIFGFlBLg==
=vO3s
-----END PGP SIGNATURE-----

--Sig_/gC9tCr.uC=8k1ggQelnWFPT--
