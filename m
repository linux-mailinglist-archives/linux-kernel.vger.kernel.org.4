Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843E9634431
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 20:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbiKVTBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 14:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbiKVTB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 14:01:26 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4430985A22
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:01:25 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AMJ17V9115963;
        Tue, 22 Nov 2022 13:01:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1669143668;
        bh=/ZJ6T2ahRQhBVE5COvKTmRQ6z48VdpgiNuqOeVcBpDE=;
        h=Date:From:To:CC:Subject;
        b=P6Ibj/6UKA/+JwieOFYyFhzK2wh3qiCXLOQVfI/hmc5mwViDaYM4mvoJOgSLB7rYu
         8kMBYnj/WARgk1z0HXUaT+Yuc62aLAwq1ROi8TmKfnIjCL5cvt56EAY4i/3K+sYVsx
         MXuyMOYIo18xlVx9GH2OX51Myr/HX30ERYib4psE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AMJ17OP049318
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Nov 2022 13:01:07 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 22
 Nov 2022 13:01:07 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 22 Nov 2022 13:01:07 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AMJ17i4121996;
        Tue, 22 Nov 2022 13:01:07 -0600
Date:   Tue, 22 Nov 2022 13:01:07 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
Subject: [GIT PULL 1/4] ARM: keystone: TI Updates for v6.2
Message-ID: <20221122185650.nrh7s2g5obndj5vj@dental>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x6koo7lvvytqnm4n"
Content-Disposition: inline
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--x6koo7lvvytqnm4n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please find the keystone2 related changes for v6.2-rc1 below.

---
The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-keysto=
ne-soc-for-v6.2

for you to fetch changes up to 7e8edf55cf729367afdb5e9a8b182f1d47897800:

  ARM: keystone: Replace platform SMP with PSCI (2022-10-27 20:12:27 -0500)

----------------------------------------------------------------
ARM: keystone: TI Updates for v6.2

Updates:
* Switch over to standard PSCI for keystone2 platforms.

----------------------------------------------------------------
Andrew Davis (1):
      ARM: keystone: Replace platform SMP with PSCI

 arch/arm/mach-keystone/Makefile   |  4 +---
 arch/arm/mach-keystone/keystone.c |  2 --
 arch/arm/mach-keystone/keystone.h |  5 -----
 arch/arm/mach-keystone/platsmp.c  | 41 -----------------------------------=
----
 arch/arm/mach-keystone/smc.S      | 26 -------------------------
 5 files changed, 1 insertion(+), 77 deletions(-)
 delete mode 100644 arch/arm/mach-keystone/platsmp.c
 delete mode 100644 arch/arm/mach-keystone/smc.S

--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D

--x6koo7lvvytqnm4n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAmN9HGwACgkQ3bWEnRc2
JJ1NexAAq5hDhDGxOtm04tSNKG8fDsxWxYxmVmd9QeSC4YO9s4GnoCpoENcLTSL4
JqeBtkvejLCwEu6Jq7CXeoHM7aBKVMyanAUZnJpIptYWsXRN731ZHg7M9Vrg6AOG
cl05IkchJZ5p7Fd7woAjaukLBZ0GyYFQnOQ3vKuSU02DdpOYpLmHTqV4FZEhS+B4
6xHOujE78wIaDvHM9zitAfodYoMeU+5XE+55lOR9YmXG6efYtNOg0A8HLZuFQXua
F2lmmDuaJzmZ8UMpNLPnccJAJkreU/3QSF+fxbd2VA5OR71W/m4LGyeQcfzw+cmU
HFEflc9NVm+ausoAmstunv9HZjrf7B5rob9eM+41U9cR5OuhXvZxy2/ToQnwN9MA
y25OucpCXEIa5XsjTLaFUGyNAEj8dNKxTwwU8w13GcX1CKc4diLigi9XEyTz4z+D
L7vDgELFk2gKlQfJz4Nglz89FS4FH2kMeCtbkncsTV4ohAfMT+SI2XLxzI1C52Dt
+xNnFRSqAkDvsT4A2VOCAsP4cXWeTG9gyr3hNFDugDWrlE/YeiKULXk3PGFVSE41
jxobTeqSXZwro01xZ85HBCLx5jRvAK/mTZ9UQRETQtoV3NbGhmfj5XesuD8hvHqt
AnovNiiUdv6lpRYBVCv7ttMV5/mpvFyrR2n3lDE05wyOiJd4VEY=
=R+Vx
-----END PGP SIGNATURE-----

--x6koo7lvvytqnm4n--
