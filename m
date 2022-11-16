Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF38562BEF9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238434AbiKPNFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiKPNEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:04:53 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D097270C;
        Wed, 16 Nov 2022 05:04:52 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AGD4epG075531;
        Wed, 16 Nov 2022 07:04:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668603880;
        bh=7lTAi+eJbFQyMeeKRRb322Yt1U5PQopOfqwnXQpIsGI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=eX4NBDbxxMtJjMv6BLGke2W5qSEC3SORph9RsHZAY6NU2ICi76PMjlZAzwOs107o+
         2ooPueWQmrCW7Z+DAxHow4/NHrxz3c1wBQezoZGi1Iq1dxD37DP2DOJjZwgPNz6GJb
         cJ5ezA2WmymbLverbTojoIzO6qwOJQOCqYAzy/fg=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AGD4e52043585
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Nov 2022 07:04:40 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 16
 Nov 2022 07:04:40 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 16 Nov 2022 07:04:40 -0600
Received: from LT5CD112GSQZ.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AGD4Tbb121231;
        Wed, 16 Nov 2022 07:04:36 -0600
From:   Apurva Nandan <a-nandan@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
CC:     Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>
Subject: [PATCH v3 2/4] dt-bindings: pinctrl: k3: Introduce pinmux definitions for J784s4
Date:   Wed, 16 Nov 2022 18:34:26 +0530
Message-ID: <20221116130428.161329-3-a-nandan@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221116130428.161329-1-a-nandan@ti.com>
References: <20221116130428.161329-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl macros for J784s4 SoC. These macro definitions are
similar to that of J721s2, but adding new definitions to avoid
any naming confusions in the soc dts files.

checkpatch insists the following error exists:
ERROR: Macros with complex values should be enclosed in parentheses

However, we do not need parentheses enclosing the values for this
macro as we do intend it to generate two separate values as has been
done for other similar platforms.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/dt-bindings/pinctrl/k3.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/pinctrl/k3.h b/include/dt-bindings/pinctrl/k3.h
index 54df633f9bfe..6bb9df1a264d 100644
--- a/include/dt-bindings/pinctrl/k3.h
+++ b/include/dt-bindings/pinctrl/k3.h
@@ -47,4 +47,7 @@
 #define J721S2_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
 #define J721S2_WKUP_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
 
+#define J784S4_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
+#define J784S4_WKUP_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
+
 #endif
-- 
2.17.1

