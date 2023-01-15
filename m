Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BF466B416
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 22:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjAOVOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 16:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjAOVOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 16:14:33 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659A71448B;
        Sun, 15 Jan 2023 13:14:28 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Nw7FZ5qjTz4xFv;
        Mon, 16 Jan 2023 08:14:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673817267;
        bh=vnBQ2svkKTnl5W4G/80uHiJWOU5tHFqL9Zs4h0QyLL8=;
        h=Date:From:To:Cc:Subject:From;
        b=kPd2nyui7rN92t7ay1qV9RtrDyQWYuyFZAvHHdUrGlrJen6wjGuhV4xulOwpV9WvE
         qQNO5tPPemWaTBxrxpkgVv7Dm8oKYt1R9gv24LuVkQjohoZwDYFDJOf+qgrWzsU7Wc
         mqqdHVstGVyNL5H1f/z4KaHLD1UuKBL7W4/f32IMF/HYoqHyPurdrtlx9R1YmDrQRS
         zWYTH+FB6N0ROGrbVGoaZtnPB2OvVRLPKMy6D7AnjbNeJeeXxWA1ReZsk44bm7Mofq
         I9rJqpangSaqz6bpFpPG6S7JeZoQf863q5kxru1Mvutkox/DvBiL2U/Z9aC4jcrLic
         oyhCbetXep6zA==
Date:   Mon, 16 Jan 2023 08:14:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Alexey V. Vissarionov" <gremlin@altlinux.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the pci tree
Message-ID: <20230116081425.43ff9e39@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/V0UOcS0f155x=2TrPwrKp95";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/V0UOcS0f155x=2TrPwrKp95
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  58d4c63d0a27 ("PCI/IOV: Enlarge virtfn sysfs name buffer")

Fixes tag

  Fixes: dd7cc44d0 ("PCI: add SR-IOV API for Physical Function driver")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/V0UOcS0f155x=2TrPwrKp95
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPEbLEACgkQAVBC80lX
0GwrBgf9ES+ocISONWYAB7bQQP68fxx6YKY0z4p3GT0bWNZ2doleidOmO46uNCkZ
UHpmEVJ3KY5IicSbwL5xuUPMH0ePAHv9nTFk7W/Y3JUKWptEfI1gVrXZFkVDYa9D
jqcfXUnI+6/mMRp6Azd7DSpiD/PW89ELKGfgWzjdJn38i+xhBHGCZGbxc5okq5Oi
er7bm695Lu0TrzuBqT2slf2CI1CBtC4CYbOS25FJm8dKWDrUMvnhDoMLI4L8xomG
ESZxltPVWPj32akXzV6TmGZdCrdGCTty26GHInL/XrjaFGWMaeQW2tL7v5QTI0lM
NpQdhCE6WvswwJX8TBicmfcuhGF/sw==
=hAU1
-----END PGP SIGNATURE-----

--Sig_/V0UOcS0f155x=2TrPwrKp95--
