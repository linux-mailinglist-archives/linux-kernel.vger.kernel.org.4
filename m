Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB51634A28
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 23:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbiKVWjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 17:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiKVWjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 17:39:15 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342FEB94A1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 14:39:14 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AMMcubt113983;
        Tue, 22 Nov 2022 16:38:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1669156736;
        bh=UXbhaZoccdRbP2WZd8DUVcuv2a0nDFxrEq8xOaUyXpE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=gWzKHCZOKn+S362M2JkpPKEBnPCMJLeAzvt+bTjW+aId5ewDEFhl4SRrZMayw3yI5
         ewz9JvrkuAbZX37XeDX5roG1/Vv3wsOkvWPFqAyR074eJQazAbGOo1iVPkT3mFGwYt
         68oGMDuHQyBoI36xVXyuCn3pb0rA8VYmcgJA3h9I=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AMMcuPG040995
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Nov 2022 16:38:56 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 22
 Nov 2022 16:38:56 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 22 Nov 2022 16:38:56 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AMMcufG042355;
        Tue, 22 Nov 2022 16:38:56 -0600
Date:   Tue, 22 Nov 2022 16:38:56 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL V2 2/4] soc: ti: TI updates for v6.2
Message-ID: <20221122223856.fwackjg7fbd5jcz7@wannabe>
References: <20221122190136.avoej5i6zccbcds3@ammonia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qt5npn4oiupvc7uv"
Content-Disposition: inline
In-Reply-To: <20221122190136.avoej5i6zccbcds3@ammonia>
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

--qt5npn4oiupvc7uv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please find the updated v2 pull request for TI SoC driver changes for v6.2-=
rc1
below.

Main change since the first pull request[1] was to drop the regression
patches as requested in [2]. Apologies on the last min update of the PR.

[1] https://lore.kernel.org/all/20221122213202.gtrqwc5vsrecdklm@canteen/
[2] https://lore.kernel.org/all/7ha64iaf6t.fsf@baylibre.com/

---
The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-driver=
-soc-for-v6.2-v2

for you to fetch changes up to c11b537e417723d1279bc267b1089f11e8ec1ca5:

  soc: ti: k3-socinfo: Add AM62Ax JTAG ID (2022-11-22 16:08:34 -0600)

----------------------------------------------------------------
TI SoC driver updates for v6.2 v2

* Minor bugfixes for knav_qmss_queue, smartreflex drivers
* API optimizations including using devm, bitmap apis to
  ti-sci, soc-info drivers
* k3-ringacc can now be built as modules for certain
  distros that mandate such usage.
* k3-socinfo can now detect AM62A SoCs.

----------------------------------------------------------------
Chen Jiahao (1):
      drivers: soc: ti: knav_qmss_queue: Mark knav_acc_firmwares as static

Christophe JAILLET (3):
      firmware: ti_sci: Use the bitmap API to allocate bitmaps
      firmware: ti_sci: Use the non-atomic bitmap API when applicable
      firmware: ti_sci: Use devm_bitmap_zalloc when applicable

Georgi Vlaev (1):
      firmware: ti_sci: Fix polled mode during system suspend

Peter Ujfalusi (1):
      soc: ti: k3-ringacc: Allow the driver to be built as module

Vignesh Raghavendra (1):
      soc: ti: k3-socinfo: Add AM62Ax JTAG ID

Zhang Qilong (2):
      soc: ti: knav_qmss_queue: Fix PM disable depth imbalance in knav_queu=
e_probe
      soc: ti: smartreflex: Fix PM disable depth imbalance in omap_sr_probe

 drivers/firmware/ti_sci.c        | 24 ++++++++++--------------
 drivers/soc/ti/Kconfig           |  2 +-
 drivers/soc/ti/k3-ringacc.c      | 28 ++++++++++++++++++++++++++--
 drivers/soc/ti/k3-socinfo.c      |  1 +
 drivers/soc/ti/knav_qmss_queue.c |  3 ++-
 drivers/soc/ti/smartreflex.c     |  1 +
 6 files changed, 41 insertions(+), 18 deletions(-)
--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D

--qt5npn4oiupvc7uv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAmN9T3UACgkQ3bWEnRc2
JJ1omBAApqNkdrDky9r+nhq+LWiEnqK1rvriIKkjUx81OcMPSAdy/kc2bvUasIu8
zUhhITK7bKH24UWvvCAhWpyagTuNg202HrBHztmq4ep1zAGVIkezTtRKuA7QHKOf
a8LRqxh4VvRXEAJ5i5xPrgSkisvT10aZex8bWA4fH3K1WWE2KG6k7IUMKCX6aKdI
mU0woZtDXSnv33JTjS0PWXOrz5T9coUwmvHH+WveiEhqdryaUxZ/e+KGHLUjRebt
mMpUlGYij6F5Y8CDzCr6Bn+LgRSllHyybEALa5z4zVnWD/Re2GUmM7lrgYyxten1
T1zVL0XeP7bjNn9Kf2lVytkxTtOhB1m9AOoY0T6eelS0eKFCNCxmilHcEIAIMKX/
JiNGeBjAhpoXx1orzE1kJwwbVddSIav5fTHzWntMEtVSSepa0+vVMcCej9kfETP1
Cv4Y+sxkcuCC7gID0dal0hBJsh6GX4dKLFR0jGQQA8gkyrse0mutcUN9kTm6RvwU
t07vrphvCc8cv7/20D3FmmZGxxU+XPuJBzLli1K3l1XpaWPBD0sgBfgPDtfl5CVk
aMF5lLqfcxC6rPJM54q57gitZVQ9AKnHv/NY+qXq4Wp8pHwgMgPJXAVcQudBC59Q
AU6CGjQkgt2gMeqynXrkcNwcBteS9G4Py38v6zPRGE3XJEBysnQ=
=SI5P
-----END PGP SIGNATURE-----

--qt5npn4oiupvc7uv--
