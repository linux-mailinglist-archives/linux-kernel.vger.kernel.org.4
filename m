Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4996D3AC5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 00:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjDBWKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 18:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDBWKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 18:10:45 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D77993C9;
        Sun,  2 Apr 2023 15:10:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PqSry2kXFz4x91;
        Mon,  3 Apr 2023 08:10:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680473443;
        bh=mzxcJ0/baq0dUtpPkZS4O0jo8WqG3+QJvSynd0Zzq/k=;
        h=Date:From:To:Cc:Subject:From;
        b=iY2U6he1uBHo67Tk//Fgy2f3pG+z7YT/xq9HPI2VTJvrxp/q2fOUrAcQX+2tgELld
         yMEhsVCzUsCHhBfl+3VDVNUS6FmRExBoImfDm461UwQWdeIR5EjgaEt4/O+fURALTL
         s4GkAOqD7zuxUbh9H86eazeKrRl65MoU7EH053V/SyBgNzXonlJe/9YOe0JvF/gaRL
         cf6Z+0nZzfdM9iXDe7cOYiK4XyI1MzyCMcMTAxK1LSll9YccCS3mc33ow+wtfjCHQ2
         UtieRGEczin7zuNQmOJDuH0wFqMIgcfPVC01LBb+Dw7C5xVJybh30nm9S6w532/QWR
         DjBWoMA7IuL/w==
Date:   Mon, 3 Apr 2023 08:10:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the v4l-dvb-fixes tree
Message-ID: <20230403081040.62825e48@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ovdCQKEET/791YzHk8iDRdK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ovdCQKEET/791YzHk8iDRdK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  b0d944bc47ce ("media: Revert "venus: firmware: Correct non-pix start and =
end addresses"")
  b928db940448 ("media: i2c: imx290: fix conditional function definitions")

These are commits

  f95b8ea79c47 ("Revert "venus: firmware: Correct non-pix start and end add=
resses"")
  7b50567bdcad ("media: i2c: imx290: fix conditional function defintions")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/ovdCQKEET/791YzHk8iDRdK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQp/WAACgkQAVBC80lX
0GzCEwf/e8JJn7nc5xAzM48Vk/pkW8RMEJJQeJqi1Xg6osochUUdZfzaIu8ufoAC
3ITUhfInwJg+wVLOZ7XJ9DC3TCxdwafJFXaIsfVckUL9drt59uKB/XDhbmHqjsuw
Mlotomk+AsphkCKxNsugnnzrFnwA6mY685o2LayM+qKubYxDBUEi8uvrkaXNUG1N
PLQ69B53TzOX/P6YeJu8U2HxG6eK0gh5D1/r1per+e4gdChlZ+djM2OqIj5mSoZd
o5oKWY6+Kz0juPKsudqr64E08KLaXu2GA/x5LLchSvtmyDOFypGI4R8pTdkAjmrv
vZOQXA+47WJ8GSYVXFG93BqJQRE/4w==
=6xfK
-----END PGP SIGNATURE-----

--Sig_/ovdCQKEET/791YzHk8iDRdK--
