Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54974688911
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjBBVfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbjBBVfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:35:00 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECE47BE55;
        Thu,  2 Feb 2023 13:34:58 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P7Brw3X2kz4xwq;
        Fri,  3 Feb 2023 08:34:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675373696;
        bh=wxZX8maEIe56nAItaLqHpHl3AzMD3hXkKL9Q4EGEX1c=;
        h=Date:From:To:Cc:Subject:From;
        b=huwGbspw5YqUm21h5Oug2aiIDBMTs7JsZy9SqQ8zTxBLUi5H8jTIVqQc4UIILrisE
         6cPd8W2PcTxNAzAviIoBNwNNqpBWauyrlbd2QHuhtjWIOGusNdUS1gQhPWTXr/UgGA
         TgENrZR2SUQBIVkAenwsaAan4UKMyrjTgyniOOPh7NaZIEG8/9PNLA73FivZw4izDB
         VYOW/Q3k/YRDtjdZgvL49qBvbvNTkC2QeLtPBBUXKXNudNhP4qZxnnU+6pz+cSQvnR
         1rqXimNVKSV5fa1il7ujWSCWXKF4Z/0AeR6hzeOBwvsXwGmgyTMgIJY5WpEuMlKEED
         GoFu88Vr0Jycw==
Date:   Fri, 3 Feb 2023 08:34:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the drivers-x86 tree
Message-ID: <20230203083455.7a8cdee0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GWhJbf/LNsgeWTlFiL+3c2D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GWhJbf/LNsgeWTlFiL+3c2D
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  037d07aeef02 ("platform/x86/amd/pmf: Fix to update SPS default pprof ther=
mals")
  5cca42fb5578 ("platform/x86/amd/pmf: Fix to update SPS thermals when powe=
r supply change")
  66dc77b5c2a7 ("platform/x86/amd: pmc: add CONFIG_SERIO dependency")
  8b6ad2361561 ("platform/x86: thinkpad_acpi: Fix thinklight LED brightness=
 returning 255")
  9f093aff1dda ("platform/x86: touchscreen_dmi: Add Chuwi Vi8 (CWI501) DMI =
match")
  a63149e5d662 ("platform/x86/amd/pmf: update to auto-mode limits only afte=
r AMT event")
  b3c37edce7dc ("platform/x86/amd/pmf: Add helper routine to update SPS the=
rmals")
  c02576762825 ("platform/x86/amd/pmf: Add helper routine to check pprof is=
 balanced")
  f1db3f08b51d ("platform/x86/amd/pmf: Ensure mutexes are initialized befor=
e use")

--=20
Cheers,
Stephen Rothwell

--Sig_/GWhJbf/LNsgeWTlFiL+3c2D
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPcLH8ACgkQAVBC80lX
0Gxzdwf/UpoBjrgtfhViwUuC51FXzykZ1U+erBsTD1/GvK3TYO8GXLVV3qoT0j75
UXZ6vFWrP3E+xOWYEqtzB139tnCtfErc6WklWI5BUxyjlIMvmEX/CMyYGVO3YTz5
GgVtUxfPdW4by5/7jCm9sgwzRbb1fHU5Xkxj23UFaikPIyAnipORIsFvohESSJ6L
RW2j1cCoKj6gR0KeC9Xze6D+EebbLMQvU6ay5qIDCZgIvK0OJ4XYngAiSJp94oaJ
7ELocn7mYMbkai9WtlKH7Nu4W3uhdyTGeu2Isv/y+eMDT29bxm4A1zb6azpd9VFW
1nZHzYV0EuJA8v7xFFGDTptjAHMsOQ==
=WKE+
-----END PGP SIGNATURE-----

--Sig_/GWhJbf/LNsgeWTlFiL+3c2D--
