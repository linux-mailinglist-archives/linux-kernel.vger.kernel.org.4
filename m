Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6787D65E116
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 00:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbjADXqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 18:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjADXqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 18:46:37 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1268BE0C;
        Wed,  4 Jan 2023 15:46:36 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NnR8C2R0Vz4xyY;
        Thu,  5 Jan 2023 10:46:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1672875995;
        bh=0x6e9WwnpoE+BTH7UbITtZWjuTWzb7rqA/AMN6J+S7g=;
        h=Date:From:To:Cc:Subject:From;
        b=RS+dQNuighHndYiIqsehd3oJgXSearli8TYKTA49ZvuuvwdoOVyKUBmyQQeBL6nwT
         pRIqRONWGEXTM1qD87frMn7V33egezZ0xDxHuFkiA9m99I33xm8s0xpdOzIXuChUQO
         EvksSI6w+FHriHjXl5Ec35Y7sLMJLzVg4MZz/7sJHbuJR78m9/gzsuAgGF4tBX4Y97
         Nx4+oOSBvR9q5/u2+x12HNQ8rzzrlGMfrC0tFkRQnlM/GEqijK3xTXDqAC5QlTDK+F
         KymCKl5gOKmXlFlKIv57AkE0wvwARpVKz7Abfn/ss5ct0uV05v6k5rpiXIabXscEBp
         hNONnuZiLGC2w==
Date:   Thu, 5 Jan 2023 10:46:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Daniel Lezcano <daniel.lezcano@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the thermal tree
Message-ID: <20230105104634.54cd6cd4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/j8JrkqAxU_CsLaPa6H1Ub8q";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/j8JrkqAxU_CsLaPa6H1Ub8q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the thermal tree, today's linux-next build (x86_64
allmodconfig) failed like this:

make[4]: *** No rule to make target 'drivers/thermal/thermal_acpi.o', neede=
d by 'drivers/thermal/built-in.a'.  Stop.

Caused by commit

  cc54ca385577 ("thermal/acpi: Add ACPI trip point routines")

Forgot to "git add" a new file?

I have used the thermal tree from next-20221226 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/j8JrkqAxU_CsLaPa6H1Ub8q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO2D9oACgkQAVBC80lX
0GzX6Af+Nz/NF3vBGTdqqR64mMu53BCH/O90yKPRFpjS/fkDNfDu5XEgMudZsH86
vD6Scb47Y/8rY1Zw/YhX+5vC9DBcuyhUfJQhsvkQ1xakxtBzabje5a44kQr1J/HU
sBQbhk2LJdhmQeJO36EfLAJ0fz07+dfPs9qBL5qlevFYUPrprltR9eA6jXWXqmWH
E+0GEnKaSirCzTsfREkdjWHv8Y6hfg6p1DPh2QJaOrPmWDMd7fcuKlF3Pjzn+/mw
boZhluz2fXNgKzopVhoFrPeSCGUZur9zjdhxZl6BC/3keW3gVIrwJZkjSuyi7uR9
c2brABQxnAUkuYW4pnyFjW/mives/A==
=4zIZ
-----END PGP SIGNATURE-----

--Sig_/j8JrkqAxU_CsLaPa6H1Ub8q--
