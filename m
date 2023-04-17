Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650286E49E2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjDQN1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjDQN1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:27:51 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA67CF5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:27:49 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33HDRInE101679;
        Mon, 17 Apr 2023 08:27:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681738038;
        bh=tjQx4OnwT0WZGl61dt1OrT4RuDJjc0JnzyTMhotwyuk=;
        h=From:To:CC:Subject:Date;
        b=LVmvdi4ZfG5W1IEu9KaXU22T44aqlp3EB/9bVDJPF/qbm/TWpRJVgJ2d8kz0jwxEt
         +HtP7dykdidBbK+vRiXCvsReFvroBTSLwdQWfD6k+Hx8Z+ncreDhxju5MLY3lHjy1K
         CVNafbmQ7CoFNKAZg5INWGvE3nMydMBXLTe43qzo=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33HDRIT1038406
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Apr 2023 08:27:18 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 17
 Apr 2023 08:27:18 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 17 Apr 2023 08:27:18 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33HDRHpV007836;
        Mon, 17 Apr 2023 08:27:18 -0500
From:   <kamlesh@ti.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <quic_bjorande@quicinc.com>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <krzysztof.kozlowski@linaro.org>,
        <treding@nvidia.com>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <rafal@milecki.pl>, <vigneshr@ti.com>,
        <afd@ti.com>, <j-choudhary@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <praneeth@ti.com>,
        Kamlesh Gurudasani <kamlesh@ti.com>
Subject: [PATCH] arm64: defconfig: Enable crypto test module
Date:   Mon, 17 Apr 2023 18:57:16 +0530
Message-ID: <20230417132717.1990023-1-kamlesh@ti.com>
X-Mailer: git-send-email 2.34.1
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

From: Kamlesh Gurudasani <kamlesh@ti.com>

Enable crypto test module, used for testing crypto engine performance.

Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b6342b40c600..e4ef0cc35235 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1452,6 +1452,7 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_USER=y
+CONFIG_CRYPTO_TEST=m
 CONFIG_CRYPTO_ECHAINIV=y
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_ANSI_CPRNG=y
-- 
2.34.1

