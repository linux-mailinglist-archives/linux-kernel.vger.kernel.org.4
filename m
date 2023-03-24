Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2795E6C78C7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjCXH0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjCXH0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:26:11 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD1D2684E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:25:39 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32O7Oi7p107140;
        Fri, 24 Mar 2023 02:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679642684;
        bh=rF9gqCX1E1b9HvvQFT1lQokYiQ1TG/jF+TfJcLSPlao=;
        h=From:To:CC:Subject:Date;
        b=uRLPHuW840L/+jZ1iJmpMtfIZPxY2yaOezszB+RoW4OsRfZcFXM87PEaZ56MKQEGi
         AoZZrdBx45EcyUxHyu6DLa9OFJvN2KgtdZ0nz9zPZYDxklpKzCZ/k0ikd56abR4PEa
         E5lobq/2RbPd+6UU+86z39bRoei8T8PWs67PYneo=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32O7Oi0r001558
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Mar 2023 02:24:44 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 24
 Mar 2023 02:24:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 24 Mar 2023 02:24:44 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32O7OhxD095717;
        Fri, 24 Mar 2023 02:24:43 -0500
From:   Bhavya Kapoor <b-kapoor@ti.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <b-kapoor@ti.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <quic_bjorande@quicinc.com>, <dmitry.baryshkov@linaro.org>,
        <arnd@arndb.de>, <krzysztof.kozlowski@linaro.org>,
        <geert+renesas@glider.be>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <rafal@milecki.pl>
Subject: [PATCH v3] arm64: defconfig: Enable CAN PHY transceiver driver
Date:   Fri, 24 Mar 2023 12:54:43 +0530
Message-ID: <20230324072443.395080-1-b-kapoor@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CAN PHY transceiver driver to be built as a module which will
add support for generic CAN transceivers used by TI K3 specific SoCs.

Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

Changelog v2->v3:
 - Modified Commit message to be more descriptive

Link to V2 : https://lore.kernel.org/all/20230323113324.361991-1-b-kapoor@ti.com/

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7790ee42c68a..6e123de3a9cf 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1292,6 +1292,7 @@ CONFIG_RESET_QCOM_PDC=m
 CONFIG_RESET_RZG2L_USBPHY_CTRL=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_PHY_XGENE=y
+CONFIG_PHY_CAN_TRANSCEIVER=m
 CONFIG_PHY_SUN4I_USB=y
 CONFIG_PHY_CADENCE_TORRENT=m
 CONFIG_PHY_CADENCE_SIERRA=m
-- 
2.34.1

