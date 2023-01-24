Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3980678E1E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 03:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjAXCRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 21:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjAXCRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 21:17:21 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267C79006;
        Mon, 23 Jan 2023 18:17:20 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P19bJ1ldHz4wgq;
        Tue, 24 Jan 2023 13:17:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674526637;
        bh=ZYdQy9awba+AoWMxwubbOkX7mlA5QbxZlGvKzilD2/o=;
        h=Date:From:To:Cc:Subject:From;
        b=QJzH3rCNofD4ROPDmzq5N0kgTTAl0C2E+euXzyaHq9l1knqOu5GlY/m9Ybwsbr1tc
         6aZgrt5LVeSTLq6HW86BpgZZ5ApS3mipnRO3P0uhDjj9ub2P4ZyKuYhIGUBkpmE5B/
         cRo1I1iqSQijyMmY0J3wTbIoNbgu0rnVE9n3DcaiJtJ61slBt6OHpezObMlhC4q6kp
         n7imhiSO1declhNJ2Wi4E+Dria3wAmx4v77LQO8NHopWJgVWYoJrpcTkIh5pEOsnLS
         wXja1mBRRTjNu8Bp8iTusYhvYv2zSxCtMoVoCW32KBpR+ZOnh1/pLk/ZmfFnX7Jxzk
         s1aL+Ldvh+nxw==
Date:   Tue, 24 Jan 2023 13:17:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Herve Codina <herve.codina@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the usb tree
Message-ID: <20230124131714.152afa57@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/A+qAozbK8XMUOf1BUpIf4ZT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/A+qAozbK8XMUOf1BUpIf4ZT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in other trees as different commits
(but the same patches):

  e12069043418 ("ARM: dts: r9a06g032: Add the USBF controller node")
  e9fee814b054 ("soc: renesas: r9a06g032-sysctrl: Handle h2mode setting bas=
ed on USBF presence")

The first is also commit

  ecc9ce6cbf36 ("ARM: dts: r9a06g032: Add the USBF controller node")

in the renesas tree, whil the second is commit

  d4638642aa0a ("clk: renesas: r9a06g032: Handle h2mode setting based on US=
BF presence")

in the clk-renesas tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/A+qAozbK8XMUOf1BUpIf4ZT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPPP6oACgkQAVBC80lX
0GzFxQf9F+W/6PXCQN3Qayuzlq7jcLsFU4JSHwbddxX52oZxVH+aQmXXs4sDX0Fu
w5Ju5V1Z2VRuIzAp57i7GHeZystca8nFbsK1Ti8p3j9MjawEnBwo5WobVHAj1tnr
y/TcWKnS2hqHcguOW/Q0W3HSAfRH0zsx2EJFAE2wql0AISc+QdzzIICQJn1wQTCk
5tL0AOoj/cMYv2P9kJfePyeaBqsbYRbBjRbkIUqYxVqdVS0wMdZD3jqXAFJ7ObR2
c4Y+bTsjpm/IkLdqDd12OIurrSWkrSnMs4OIp+AzvmHutGRCmZ/8hFm6IJhwsHlJ
jAnrQKcXSngPheOyN9o927yJsO1+Xw==
=L7uz
-----END PGP SIGNATURE-----

--Sig_/A+qAozbK8XMUOf1BUpIf4ZT--
