Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179A96DC7A1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 16:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjDJOFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 10:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjDJOF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 10:05:29 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23541999
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 07:05:26 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33AE57Yv104760;
        Mon, 10 Apr 2023 09:05:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681135507;
        bh=XZIofqlOHF0nUaQCtUAqDHMyrRnDGPp7zEadbeCaack=;
        h=Date:From:To:CC:Subject;
        b=ClxEVZ/yBm8BZvzNfSaYqnqXBBeD2WKRz6oL+OnMMyi+4cDO+hDTv8t0HWGR/74M5
         7j6ALoQLze9uWr5eGoLwoM6ICI4COtF9OHusqRO9AnurKvX7vFhFSX7Gb9gM7EPx0G
         2PNCrDz35rkgNzlh0VAiF3Ct6YLQZXm0PkloGlSg=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33AE57cR078297
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Apr 2023 09:05:07 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 10
 Apr 2023 09:05:06 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 10 Apr 2023 09:05:06 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33AE56Ha058556;
        Mon, 10 Apr 2023 09:05:06 -0500
Date:   Mon, 10 Apr 2023 09:05:06 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Arnd <arnd@arndb.de>, Olof <olof@lixom.net>, SoC <soc@kernel.org>
CC:     <arm@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/3] soc: ti: Updates for v6.4
Message-ID: <20230410140506.ucvkwq7vz2h47vyj@stipulate>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="754s2zqlbolxrofk"
Content-Disposition: inline
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--754s2zqlbolxrofk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-driver=
-soc-for-v6.4

for you to fetch changes up to a33bfafd99e0d1e33dfe910f751426f298a218b6:

  soc: ti: Use devm_platform_ioremap_resource() (2023-03-28 06:23:42 -0500)

----------------------------------------------------------------
TI SoC driver updates for v6.4

* Minor fixups for of_property, using devm_platform_ioremap
* Fixups for refcount leaks in pm33xx
* Fixups for k3-ringacc for dmaring_request
* SoCinfo detection for J784S4 SoC.

----------------------------------------------------------------
Miaoqian Lin (1):
      soc: ti: pm33xx: Fix refcount leak in am33xx_pm_probe

Nicolas Frayer (1):
      soc: ti: k3-ringacc: Add try_module_get() to k3_dmaring_request_dual_=
ring()

Rob Herring (2):
      soc: ti: Use of_property_present() for testing DT property presence
      soc: ti: Use of_property_read_bool() for boolean properties

Siddharth Vadapalli (1):
      soc: ti: k3-socinfo: Add entry for J784S4 SOC

Yang Li (1):
      soc: ti: Use devm_platform_ioremap_resource()

 drivers/soc/ti/k3-ringacc.c      | 7 +++++++
 drivers/soc/ti/k3-socinfo.c      | 1 +
 drivers/soc/ti/knav_dma.c        | 4 ++--
 drivers/soc/ti/knav_qmss_acc.c   | 2 +-
 drivers/soc/ti/knav_qmss_queue.c | 4 ++--
 drivers/soc/ti/omap_prm.c        | 2 +-
 drivers/soc/ti/pm33xx.c          | 5 +++--
 drivers/soc/ti/wkup_m3_ipc.c     | 6 ++----
 8 files changed, 19 insertions(+), 12 deletions(-)
--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D

--754s2zqlbolxrofk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAmQ0F4cACgkQ3bWEnRc2
JJ25rBAAkJ6xgfmuuRlLGvelAiNQdMVbClDtTBQZuBSR7mbghEPYvf16gp4Uu6yx
slufP5K3dX32s+RRfiKfswWReSC+4lf3trRhFZMyMt80yq/Sf5fp9Zo+1aczeRIT
VqLI1M37gCzvwqwdQOlJRivMmlPibO6OP11WDg2TZJ677vegSx8rFWOI9faBsLpW
R4PMDHhszJoEECJYPEyDAoLIeWdEgsT2pSs7yMNkEum9CpImU9Tms/KDmEmTSsm7
VPETvaoMRJzwRRKCWs4mGnVjFRZN9J1nsyhgL2M1PN+jBuCGTyhRRAcITK6ukDgD
WfE8ux30tubn4VL6obW5GtV+Jz00A2HyPDNcKmyVaxgVRweLSJb2lohKHeMromnH
MOwCLAngQif5vuIHNwuIf5k0qYHQfB6UQ+GnspeaY2RWItilpEdbxAKK6CdXGBZn
LlLuC2bnyIADvWoA61Ef2x99MaYtQ2q9/jolE3r9aBFLPais2yK44K0slVzEogEk
pL7gKK/4UalzdefBIxkmoAq2dm8VgZTfoHOqzs1Ue5cM0TuLSGdVj9jlzXtqYuBA
1XIuICy+w/lTEg/kngu7WEsByMmWXpHly/TIMRgy9Sg6eY+vbR8aLZuPRVqox5e3
HCvZx1a8S7sfVqdTLPxUdbIf3DJg8dE0cjy26v/3lzLLwin0t20=
=QJZU
-----END PGP SIGNATURE-----

--754s2zqlbolxrofk--
