Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C686E76C3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjDSJvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjDSJvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:51:23 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911444C19;
        Wed, 19 Apr 2023 02:51:22 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33J9osN8042875;
        Wed, 19 Apr 2023 04:50:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681897854;
        bh=mljfsvL/pHsCnWc7Sj/aslhGS6YKsV/O4C4RsaipU8E=;
        h=From:To:CC:Subject:Date;
        b=fdw2yxT2YR2VVW9fG1zO6Uxutx3LsbE/qVN/aZbcmi/S2biFNzgze0kmGi40WYYf4
         1QZfIpNJVq6e+PEUDbnb6b0WdkqIewuOnMp+GxcMhgwmjd7TGtppkBMKv1Akh/ZphI
         oWL64bC0pePUT3jsqK9CrMy6ESRsniw0O0aRsjGw=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33J9osID128470
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Apr 2023 04:50:54 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 19
 Apr 2023 04:50:53 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 19 Apr 2023 04:50:53 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33J9orj3112149;
        Wed, 19 Apr 2023 04:50:53 -0500
Received: from localhost (uda0501179.dhcp.ti.com [10.24.69.114])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 33J9oqpE019027;
        Wed, 19 Apr 2023 04:50:53 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     <rafal@milecki.pl>, Mark Brown <broonie@kernel.org>,
        <nfraprado@collabora.com>, Thierry Reding <treding@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, <nm@ti.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, <vigneshr@ti.com>,
        <danishanwar@ti.com>
Subject: [PATCH] arm64: defconfig: Enable PRUSS as module
Date:   Wed, 19 Apr 2023 15:20:51 +0530
Message-ID: <20230419095051.3269777-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enables PRUSS as kernel module for TI SoCs.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a24609e14d50..2a362a902526 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1277,6 +1277,7 @@ CONFIG_ARCH_TEGRA_186_SOC=y
 CONFIG_ARCH_TEGRA_194_SOC=y
 CONFIG_ARCH_TEGRA_234_SOC=y
 CONFIG_TI_SCI_PM_DOMAINS=y
+CONFIG_TI_PRUSS=m
 CONFIG_ARM_IMX_BUS_DEVFREQ=y
 CONFIG_ARM_IMX8M_DDRC_DEVFREQ=m
 CONFIG_ARM_MEDIATEK_CCI_DEVFREQ=m
-- 
2.34.1

