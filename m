Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F4D6E78C0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbjDSLkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjDSLkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:40:41 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F6E13C17
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:40:40 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33JBdxZF071733;
        Wed, 19 Apr 2023 06:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681904399;
        bh=UvrtLqJPlmWGbxrQkC6jApN4L9aB4ZwY4WVDQfaqP2I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VvwMJFKQQmsu9ljzyuIhGdjqw39240QbxaPmkDWUpxvs2YvK/MdsTM//FBRZDAvcB
         3Ugo1/Es+BvnyaeDmPJDawX4yrMLv1jWxI4XSroEyyhFRIYx5jXu78HPdikVjmmk1J
         Ij1e/H7UTxOy6h+IKv1cVlKoKQGgVKtvPQN8L6Ik=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33JBdxVm106936
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Apr 2023 06:39:59 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 19
 Apr 2023 06:39:58 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 19 Apr 2023 06:39:58 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33JBdwgh022297;
        Wed, 19 Apr 2023 06:39:58 -0500
From:   Hari Nagalla <hnagalla@ti.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <quic_bjorande@quicinc.com>, <arnd@arndb.de>,
        <krzysztof.kozlowski@linaro.org>, <treding@nvidia.com>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <rafal@milecki.pl>
Subject: [PATCH 1/2] arm64: defconfig; enable TI OMAP2 mailbox driver
Date:   Wed, 19 Apr 2023 06:39:57 -0500
Message-ID: <20230419113958.17141-2-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230419113958.17141-1-hnagalla@ti.com>
References: <20230419113958.17141-1-hnagalla@ti.com>
MIME-Version: 1.0
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

Enable TI OMAP2 mailbox driver. This driver is used in TI K3 platforms
as well for communications with remote processors.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7790ee42c68a..52da7bad8ef9 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1161,6 +1161,7 @@ CONFIG_TEGRA186_TIMER=y
 CONFIG_RENESAS_OSTM=y
 CONFIG_ARM_MHU=y
 CONFIG_IMX_MBOX=y
+CONFIG_OMAP2PLUS_MBOX=m
 CONFIG_PLATFORM_MHU=y
 CONFIG_BCM2835_MBOX=y
 CONFIG_QCOM_APCS_IPC=y
-- 
2.34.1

