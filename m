Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AF2731DFE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbjFOQls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbjFOQlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:41:46 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24B126B6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 09:41:44 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35FGfYel080039;
        Thu, 15 Jun 2023 11:41:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686847294;
        bh=ianglHDxe5jloeOMRzLdWXGjzu+mp3Ylx+3FhmVfw2c=;
        h=Date:From:To:CC:Subject;
        b=Psi1PILMpCgYMOVXb3pL1qlCBb0CVZnrJp+WD3HrHC8Wb2mRG8KCBX8naMjjehofh
         Ym71Z1Qh7FllTIk0zEDv6Fmqu/6RgcfsgrWRUCYarbcowBUJYt9bQa2ZYuXEOufng4
         ysVNeOR8WWJkHeWpgzU777gLhPEfHFMlrJhVdZns=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35FGfY4m122102
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jun 2023 11:41:34 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Jun 2023 11:41:34 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Jun 2023 11:41:34 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35FGfYq9010559;
        Thu, 15 Jun 2023 11:41:34 -0500
Date:   Thu, 15 Jun 2023 11:41:34 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Arnd <arnd@arndb.de>, Olof <olof@lixom.net>, SoC <soc@kernel.org>,
        <arm@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/2] soc: ti: Updates for v6.5
Message-ID: <20230615164134.6sd5hudyadq3fvk4@garage>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q6bznmqywaltgfx7"
Content-Disposition: inline
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--q6bznmqywaltgfx7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi ARM SoC maintainers,

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-driv=
er-soc-for-v6.5

for you to fetch changes up to b11403c93b7cddc8916b132a395b1524c02447a3:

  wkup_m3_ipc.c: Fix error checking for debugfs_create_dir (2023-06-06 13:5=
0:52 -0500)

----------------------------------------------------------------
TI SoC driver updates for v6.5

* pruss: Add helper functions for ethernet client driver usage, add compile=
-testing, fixup function pointer casts
* smartreflex: Cosmetic optimization for using devm_ioremap_resource
* wkup_m3_ipc: Fix error checking around debugfs_create_dir

----------------------------------------------------------------
Andrew F. Davis (1):
      soc: ti: pruss: Add pruss_{request,release}_mem_region() API

Osama Muhammad (1):
      wkup_m3_ipc.c: Fix error checking for debugfs_create_dir

Simon Horman (2):
      soc: ti: pruss: Avoid cast to incompatible function type
      soc: ti: pruss: Allow compile-testing

Suman Anna (2):
      soc: ti: pruss: Add pruss_cfg_read()/update(), pruss_cfg_get_gpmux()/=
set_gpmux() APIs
      soc: ti: pruss: Add helper functions to set GPI mode, MII_RT_event an=
d XFR

Tero Kristo (1):
      soc: ti: pruss: Add pruss_get()/put() API

Yang Li (1):
      soc: ti: smartreflex: Use devm_platform_ioremap_resource()

 drivers/remoteproc/pru_rproc.c |  15 ---
 drivers/soc/ti/Kconfig         |   2 +-
 drivers/soc/ti/pruss.c         | 263 +++++++++++++++++++++++++++++++++++++=
+++-
 drivers/soc/ti/pruss.h         |  88 ++++++++++++++
 drivers/soc/ti/smartreflex.c   |   4 +-
 drivers/soc/ti/wkup_m3_ipc.c   |   2 +-
 include/linux/pruss_driver.h   | 123 +++++++++++++++++++
 7 files changed, 475 insertions(+), 22 deletions(-)
 create mode 100644 drivers/soc/ti/pruss.h

--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D

--q6bznmqywaltgfx7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAmSLPy0ACgkQ3bWEnRc2
JJ0LMg/9Ga4nSexUH9Gp5hJZ3Gmw/tEw7NAyko++pr3ja2HT0fNUfvUyepDJQ/ro
EO/HQAHFlk5wm19To7bbdaofb7V03qf3koHRWPsUNqzfrdeZsw2RsFegeghD4GpT
W7Qud5A1cptoAoruQ72rHiu73VmP+y3WfSKpeN9L8yPhdc3Q7r5m4jia1UCSqo84
UI8bntDJimOIoYEOgIrpaUqDlmvn3scKba41I7QGbfcZNHt1rj6UBsC6tbiZJBAk
DJiqziAcA2ePr7A5u74poBt1tWAoJDkKiSm4hMut86zFdViEpt+npEBxsH3NtQ/s
2sf3fu5DiVATgsU4WPDr+XgskO8rpGeQHBnmgsotxRF/5CUkT9Tuk7AQzY7RysPX
Nq9z9Z49y2yD3z7xf8JapC7+P3rwLS59EjjVc4cR7dYOrTjecJOcFs2T4oM8865g
w1PtuDSc8Wj/y7m7baD6i5Sy+WQ5oqROjJ9y3ql6Vq17LvtiuhFRU0CFLb3K0IiN
xJdFGsU2mYe9QniehtBSHtI2D4C7BSYDHdVFdGy0xlyj/w6SlqHFPtyQ86T91TCq
xEo+nkLYS+6kIghzm47uJfmNlyA8NN/Dyme5PtU34RUNPJJCSgTMurVsx0IeCCXk
A2KceC1zafR3keb2fj8wmjY9tfIwuZLabCnfMix5Xq+YZUP3iMc=
=XTPm
-----END PGP SIGNATURE-----

--q6bznmqywaltgfx7--
