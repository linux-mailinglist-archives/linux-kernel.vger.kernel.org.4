Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEF7703D80
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 21:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244871AbjEOTOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 15:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243603AbjEOTN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 15:13:57 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4045915631;
        Mon, 15 May 2023 12:13:48 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34FJDYIP044566;
        Mon, 15 May 2023 14:13:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684178014;
        bh=FPDiOLulB6xt1ka3uTrtGpykP3pJBjv+PR6PqtoztJ8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Q9O6A7kCI4EC2X7FUZurBkL6f7m+/lSJ5zxLX3D/KABTjj42WdYl9aJP1S5U6EXOI
         DFwBDcLCi0m8+haSoV9hQ+CL/iH++mhT3Q+16ERQR4UOb6/exQv3ZMZjcVTWQISF3S
         3mataOc534Dzw5MYmsrj8kJcP4SU/bvY5dSNAu0g=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34FJDYBA017849
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 May 2023 14:13:34 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 May 2023 14:13:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 May 2023 14:13:33 -0500
Received: from lelv0327.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34FJDSKB005699;
        Mon, 15 May 2023 14:13:33 -0500
From:   Andrew Davis <afd@ti.com>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>,
        Fabian Vogt <fabian@ritter-vogt.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v7 7/9] ARM: dts: nspire: Remove file name from the files themselves
Date:   Mon, 15 May 2023 14:13:24 -0500
Message-ID: <20230515191326.608638-8-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515191326.608638-1-afd@ti.com>
References: <20230515191326.608638-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File names inside the file does not add much and just makes it
difficult to move the files, often the file name is not updated
and becomes wrong. Remove them.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/boot/dts/nspire-classic.dtsi | 2 --
 arch/arm/boot/dts/nspire-clp.dts      | 3 +--
 arch/arm/boot/dts/nspire-cx.dts       | 3 +--
 arch/arm/boot/dts/nspire-tp.dts       | 3 +--
 arch/arm/boot/dts/nspire.dtsi         | 2 --
 5 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/nspire-classic.dtsi b/arch/arm/boot/dts/nspire-classic.dtsi
index 01e1bb7c3c6c..a6e9cbf51524 100644
--- a/arch/arm/boot/dts/nspire-classic.dtsi
+++ b/arch/arm/boot/dts/nspire-classic.dtsi
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *  linux/arch/arm/boot/nspire-classic.dts
- *
  *  Copyright (C) 2013 Daniel Tang <tangrs@tangrs.id.au>
  */
 
diff --git a/arch/arm/boot/dts/nspire-clp.dts b/arch/arm/boot/dts/nspire-clp.dts
index 916ede0c2499..c5773f770fd4 100644
--- a/arch/arm/boot/dts/nspire-clp.dts
+++ b/arch/arm/boot/dts/nspire-clp.dts
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *  linux/arch/arm/boot/nspire-clp.dts
- *
  *  Copyright (C) 2013 Daniel Tang <tangrs@tangrs.id.au>
  */
+
 /dts-v1/;
 
 #include <dt-bindings/input/input.h>
diff --git a/arch/arm/boot/dts/nspire-cx.dts b/arch/arm/boot/dts/nspire-cx.dts
index 96c48fc52203..29f0181e5b38 100644
--- a/arch/arm/boot/dts/nspire-cx.dts
+++ b/arch/arm/boot/dts/nspire-cx.dts
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *  linux/arch/arm/boot/nspire-cx.dts
- *
  *  Copyright (C) 2013 Daniel Tang <tangrs@tangrs.id.au>
  */
+
 /dts-v1/;
 
 #include <dt-bindings/input/input.h>
diff --git a/arch/arm/boot/dts/nspire-tp.dts b/arch/arm/boot/dts/nspire-tp.dts
index 235cd4264da7..3f0107f1c2c7 100644
--- a/arch/arm/boot/dts/nspire-tp.dts
+++ b/arch/arm/boot/dts/nspire-tp.dts
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *  linux/arch/arm/boot/nspire-tp.dts
- *
  *  Copyright (C) 2013 Daniel Tang <tangrs@tangrs.id.au>
  */
+
 /dts-v1/;
 
 #include <dt-bindings/input/input.h>
diff --git a/arch/arm/boot/dts/nspire.dtsi b/arch/arm/boot/dts/nspire.dtsi
index 9587e1ebeb93..aecaca5ee1eb 100644
--- a/arch/arm/boot/dts/nspire.dtsi
+++ b/arch/arm/boot/dts/nspire.dtsi
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *  linux/arch/arm/boot/nspire.dtsi
- *
  *  Copyright (C) 2013 Daniel Tang <tangrs@tangrs.id.au>
  */
 
-- 
2.39.2

