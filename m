Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCB067A61E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbjAXWpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjAXWpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:45:07 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA285E387;
        Tue, 24 Jan 2023 14:45:05 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P1hr00yZ4z4xN4;
        Wed, 25 Jan 2023 09:45:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674600304;
        bh=Atn3eWRDI66HflQCMZ+O4q/A4r+2SexvGb0jCedP+Oo=;
        h=Date:From:To:Cc:Subject:From;
        b=PEyYI5EapkxVzosUPa6INcV4ljBUZQMusbYTsblZhW+ecCY2XYnQIeGucK/3aoA2P
         m1Xu5lKyke2B+6/0hVriITcFylMCy3XAiZP9WXY8XFMj7A/PU65zrp1tbpMmmn0+5y
         5J86pHJq7dytVvSyRBpUtqtAxQaEm/Q2Spzhvs7LBf1zQWqEKXBLVL2U0fkmqNYIEi
         cRrb880eHwwzKC29fb4JAffPij71vnUZlEb684mouHFAD/shLkcNaMS5NIMWXMT/fH
         SZkpuqM7bJvPI/gRnrmypzAS1tlEWu8R84xJjfZ5WTJ1kHXSXBZvl9Ebhs6OfZPh2E
         vriJli1V92bcw==
Date:   Wed, 25 Jan 2023 09:45:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: linux-next: manual merge of the thermal tree with the pm tree
Message-ID: <20230125094503.5066c70f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/V2wz9pOaNEWU0rtx.esSwwv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/V2wz9pOaNEWU0rtx.esSwwv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the thermal tree got a conflict in:

  drivers/thermal/thermal_acpi.c

between commit:

  7a0e39748861 ("thermal: ACPI: Add ACPI trip point routines")

from the pm tree and commit:

  4bb6439371e9 ("thermal/acpi: Add ACPI trip point routines")

from the thermal tree.

These commits are very similar, and I just used the former (as it
is newer).

I fixed it up (see above) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/V2wz9pOaNEWU0rtx.esSwwv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPQX28ACgkQAVBC80lX
0GyjGQf/YnyTvsBSJ/qKNWJVMi0P5e+aPUQGSO6yXhXVHp9EX4VGR2vLDl17PnGv
CcRa+P4I0KVCO50iy/cTdyra/6Q/v62+tcARPxKt2n8vYAjvT2xvPlNsI06DiMn3
Kn6UV1hihSeMnwYrjomhp/Ux8vViUslRGdw6ANZumcgZIR9dPwIdef9CYjmb4WdM
fu2m3a0JEda4KXokZPA81apd/hMeaCBrWvuP7VutfMTbuUjQ+9k8/YoyxHu8SYPN
GwbIyYxooWZrSeZxBTEe53cq2hSoOxwA+jp81tlWrnQHgfG6nK/W03hFgSzDfxdQ
DoARJv4rq8RQucBIP5XQkUhemoDxlA==
=+aIw
-----END PGP SIGNATURE-----

--Sig_/V2wz9pOaNEWU0rtx.esSwwv--
