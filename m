Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7147B6612F8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 03:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjAHCMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 21:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjAHCML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 21:12:11 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0370615838;
        Sat,  7 Jan 2023 18:12:09 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NqLDk1z0xz4xZj;
        Sun,  8 Jan 2023 13:12:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673143926;
        bh=1oKPFLHqdn30Ox6mUZqixgNSVvy6nl5u8u5zh5Sy5BI=;
        h=Date:From:To:Cc:Subject:From;
        b=hnCOU+8Y8HJGFazSlmrxDgWilVob9GRltOCUDbVA978BpweQ5VZVFywJDuhrdQuwv
         n6VuEkJ8K/xHaLP+W/rbe4fXGAuizP3dkqSKHS+8VvserxmOy7ZDzRT0SRUhiCdN+C
         WzxfHKTwJEZxX8GQCuPtOE3iwoZ1MvtgLAqUcVCaYZpPBh43/rF+82rAPwGLuxvXlm
         NGaQox7nVRN10HxwYfbWGh2Fg+TrKXzLGD2w/AeTIhNTduMZvF3n9S+PtBuXmXPmJ2
         1ll2YitMJKss2kWx9RfwC66k4IavB7J8JjtR+zQ4Ib5JVZFDLoyAG4vh/Wq/qXLvl2
         OqUFMt82WmOcw==
Date:   Sun, 8 Jan 2023 13:12:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the amdgpu tree
Message-ID: <20230108131205.353f96e9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Uo6e7+AAU8ykiSj22Ink=CC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Uo6e7+AAU8ykiSj22Ink=CC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  1f9d1ff1c3c1 ("drm/amdkfd: Fix kernel warning during topology setup")
  878a3c004c0e ("drm/amd/display: Uninitialized variables causing 4k60 UCLK=
 to stay at DPM1 and not DPM0")
  4243c84aa082 ("Revert "drm/amd/display: Enable Freesync Video Mode by def=
ault"")

--=20
Cheers,
Stephen Rothwell

--Sig_/Uo6e7+AAU8ykiSj22Ink=CC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO6JnUACgkQAVBC80lX
0GygZwf/bP2Y6zkRqSJFQ3kgTwW05K+qmI8xs3UhvWA6kn6NQXDwtnX+5eRYgE3Q
QcBLnnjgPvsG+hY3/4ngodYsJWeF5ApaRWPljrHx8dd8zB+1Rinjo1jWfzYehL95
nFvZmHnNQWcCHiWQZvbKmEW2y/x+YttLJeGza3LInyZZTUyXnj93HvfA0Wu5XQrS
Rqzaf1xRe+ZSYPithZi0oxTCb4zmrS9NFkdadz+Rfyh3BHbtQDiSZJc2uprkGLKe
+qOZemOFhCnV+SMUlETO6kZFFhWM3kMDHVPL7HmmwoxQp2hYD5pax0BPjkucgm/T
JkEhxyDwlkQKDZhLdek+8VAZDkrjrQ==
=aSYm
-----END PGP SIGNATURE-----

--Sig_/Uo6e7+AAU8ykiSj22Ink=CC--
