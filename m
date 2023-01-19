Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67849673073
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjASEkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjASEjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 23:39:49 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097F76E823;
        Wed, 18 Jan 2023 20:37:40 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ny8w84K42z4xN1;
        Thu, 19 Jan 2023 15:36:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674102985;
        bh=uXiJRrSwOenfyHVojoKNT3dWtAN7By4hWLamYXeB4OU=;
        h=Date:From:To:Cc:Subject:From;
        b=cTjDBfuEFiK8a2nTR549PA/KFUjwioeJdgoFAiz+F/2RgRuz118EJUeaRWIvbZimD
         +PkScaGHoaSBdN0OBCTGZ9bLCWviLih9ArUaqpaR8vbkwfDAKVRzQn1lseknOgTtmq
         UZ7wxFF4jhDz0vijvJrLrY8Vf8+LVvJgugetjf3ROkOPy560uz6sz8N5JOA2EVa56r
         X0dtTxzMUZOkJptUt9XvxN3F4Obdab4KGWKoER/5yzkwZiad8qkTa+cA4ehAvFk71v
         aJTV0/x/2LRiJiDOWWIm5l1DBWAQqUmM1ReohBmXJWpQFtQvEuID93HFaOz7WK8rGT
         xTutHYoQSOvVA==
Date:   Thu, 19 Jan 2023 15:36:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Colin Cross <ccross@android.com>,
        Olof Johansson <olof@lixom.net>,
        Thierry Reding <treding@nvidia.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the phy-next tree
Message-ID: <20230119153623.339d6739@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/q=jRzdn=08Bi_=8oKQBQw4j";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/q=jRzdn=08Bi_=8oKQBQw4j
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the tegra tree as a different commit
(but the same patch):

  fb1ff01307ee ("dt-bindings: phy: tegra-xusb: Convert to json-schema")

this is commit

  56052eee689a ("dt-bindings: phy: tegra-xusb: Convert to json-schema")

in the tegra tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/q=jRzdn=08Bi_=8oKQBQw4j
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPIyMcACgkQAVBC80lX
0GybCwf9E7NVsD+a5Axi7bs/Y52qQG3PLkGtFRh1z0QDu89H0D4kUb2I76mtNFLq
O5Pv99BgHqULUt/Zy6+veq5Opfqz1ktdH5oXUvawiWzvKicCkzRKLT3Rhw0GkU68
W4Z966Li0NozLGy2wsiYe6bskI2ziv++kD+P3TDhA3wnH+DswzSwfKeL1cY1WCsn
9IWS20PoJR8VMt4O4gyc7zL7dHis28OLTXJnYt+QLfhxdb8aXjkadWJXj9jsxW4y
EjSk3sXB4LbMiEaD7Mflms2XjyniPJ8uewixbVC5/x10PwNfPh0D/DgnU4qrPye6
YpQeVmAI3zdFXElb1cgevZxQA3uDKg==
=AVRR
-----END PGP SIGNATURE-----

--Sig_/q=jRzdn=08Bi_=8oKQBQw4j--
