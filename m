Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8063F69526F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 21:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjBMU5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 15:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjBMU5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 15:57:41 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA0020061;
        Mon, 13 Feb 2023 12:57:40 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PFxVp0SD0z4x5Z;
        Tue, 14 Feb 2023 07:57:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676321858;
        bh=C3RNZcFiDvSw2/ayVHel/Pib4DfjS8AsnovyQ6/wILA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cjG6NAkpj0Iwqr2AoTwfmUIkOsN8glKWKZcTLjyBbA0W/dlgO+b11+IDHk1kWs7fG
         UWm6lRT0rFkqLaepqy9RwU6weV77QvZ+go1IEP4mtGmqb0I7N8byG+69jsxv1ASIgN
         xfKmcLkWSOmor452yOHJEweNPCgajswklXslt+WxXBSQzb2h9ESFvKzLge+tRWHERq
         JsAw63Bb549H8UXaG9lZQ9+QPGnQbVQEY2x9ThpF9d8+l60iKhnEAwua4JzDPlNhOI
         yfkxtBsDbdpYHFCQfzyK3O6ypCMKnGtYGbrnMD1ewWhi7ge3Bee9b7k91qXacLpFpv
         2fVdF8wACGLOw==
Date:   Tue, 14 Feb 2023 07:57:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Olof Johansson <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the arm-soc
 tree
Message-ID: <20230214075737.3de2f333@canb.auug.org.au>
In-Reply-To: <20230214075542.0cf88eba@canb.auug.org.au>
References: <20230214075542.0cf88eba@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/R6rIFBMq4x/jzOTIS/MiXxJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/R6rIFBMq4x/jzOTIS/MiXxJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 14 Feb 2023 07:55:42 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Commits
>=20
>   51d0bdb1f7f9 ("char/agp: introduce asm-generic/agp.h")
>   690422657cbf ("char/agp: consolidate {alloc,free}_gatt_pages()")
>=20
> are missing a Signed-off-by from their committer.

That is in the asm-generic tree, sorry.

--=20
Cheers,
Stephen Rothwell

--Sig_/R6rIFBMq4x/jzOTIS/MiXxJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPqpEEACgkQAVBC80lX
0GzaHgf8CfR8ZADqhNwP5dBDXG6jK9b9KS2T0J1oleRpyaK8K1jQ1YsP+azthb2s
6gbswOxGecMNsDwWcQ3mQVSQUYbS5VIYrCsyyI9Z6u8JIp/BBBu9DZDg10zSbFN/
WDWpibwW9Oefh/u+UMMu8wPY34qb/ADHWLoppm4YAz+FsZ7z6v14aY2J9G3YfgZH
FOiStZNgkfsX1wT2saoKAgWBTxkAcqBSBut1h5Rdv80sdmN95w7eId+XikeZUVkH
BtjJtedTHfUPY7GRnd8CBq8TANnYQu5VGGE4TTfsV9EYHwlmZ5pT8kj8nrFjmB5z
BP1mDHCnzUSYQ1cSaASNEqDYrp7ttA==
=q0ns
-----END PGP SIGNATURE-----

--Sig_/R6rIFBMq4x/jzOTIS/MiXxJ--
