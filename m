Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB2969DA97
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 07:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjBUGUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 01:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBUGUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 01:20:08 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34FF23C57;
        Mon, 20 Feb 2023 22:20:07 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PLTfX6XYgz4x7y;
        Tue, 21 Feb 2023 17:20:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676960406;
        bh=ka8JU/ADA3agwMls3mflfPcVbMGFPh05KWlqsh2ICsA=;
        h=Date:From:To:Cc:Subject:From;
        b=FfezH19diVt8FqgwEeoomVXLRPg7td7pEB3ocCtCEywJ7VQb59oOV976azlt/QrKe
         sMt7A/UUTNh07lx5gh+WNd17OzZ3nJHtg8lLWGnuXe1LGZYxawjlxWwRG26qb9DBS4
         Vp7Ja4zUvcjqg1md029utfUBhx30mY0CQ+SMgElHGuTmT0xl0e32g87i7gbqAws9MY
         VQihVtz9qNVwAev3AMVY2V1X6UvSKsdG2YXuiQwVcbqkZsnoqbnYAc22HkQrTtlDhf
         rlpNU1MgqsA7R+7ZAUn7NH/UjPpu4xQViJz6SVjrc7R2cWgmyvW8BRFo+5A53OVRy+
         izZ/MMEtxI7ow==
Date:   Tue, 21 Feb 2023 17:20:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the aspeed tree
Message-ID: <20230221172003.2d530d1b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_VI71vwock95ES2=Z4gs3Sx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_VI71vwock95ES2=Z4gs3Sx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  af06aa236dd7 ("ARM: Add wpcm450_defconfig for Nuvoton WPCM450")

This is commit

  8012094e2925 ("ARM: Add wpcm450_defconfig for Nuvoton WPCM450")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/_VI71vwock95ES2=Z4gs3Sx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP0YpQACgkQAVBC80lX
0GwXfwf8Dha7cXJIgWNrOe8vlOYqld/5szkncEydWhAwAwIwYdBZCYH94R4tmNQB
YbV0Cz/TCN6Qr3HBTH/PHy8CIpNF4RI59kEF/L1mIApz2bP09VCl6Dly5mnZoeW/
4GCshOfmMPo9qDRHX3CaKYTd2bvpDSeK1Y8U0jcez3Acs/FBnaplrD0RL7CrXxEO
GMil2/+UEeo+rr8Ah7G7/kyK1UiedOePxPD2IXas8SgXtgYSobE/zUPc9QedsXdH
WkXTzzQMcK4OS37NBWpoXdFwZe0GET+w5aMHnxfSPoclJycD0liYYAGVFXGejh4Y
MvhOmTu7+lccpio1LgnDOUHUHcdD9g==
=7a7O
-----END PGP SIGNATURE-----

--Sig_/_VI71vwock95ES2=Z4gs3Sx--
