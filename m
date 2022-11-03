Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B5D617A91
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 11:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiKCKEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 06:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiKCKE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 06:04:28 -0400
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E31B1F0;
        Thu,  3 Nov 2022 03:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=HL/7H+fZFpuFCnct+yiKKIoU0SNeD7m+YyJFOGqoENc=; b=CcrPiQK4f5PZRgeY78c3T/U/WR
        ElZnDHm8q36yYziBlYFuYjhH1soN7aL5DLt2ydiqk+Y0vpdQd5/ekKV2eCHdmNz/ysffIGUQ+P2TM
        R6vfLLa/D82RQlB+f+u1qo7O5adHCf0tHCO3BYrlDcqdfHKOFfcGaB2udsCs6M0DqIdwrVVQQqh87
        Iko4e3JaqbyRr4PipF0Um+KYNE/UVQu6QR/krNk8HCTq0hVPqbNrIlonq3yQdUe7IEXLX1aAt1lf9
        CKcYncV2XZdThWpvSOMYlGKSLmeGhSb4TpJ7rla7Ld56xrgSopGyzrDFw9lllK+StO2cgZ1/QlKA7
        ztmtG5Iw==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:37996 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <andrej.picej@norik.com>)
        id 1oqX52-008HsM-LI;
        Thu, 03 Nov 2022 11:04:20 +0100
From:   Andrej Picej <andrej.picej@norik.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] ARM: dts: imx6ul/ull: suspend i.MX6UL watchdog in wait mode
Date:   Thu,  3 Nov 2022 11:03:58 +0100
Message-Id: <20221103100358.176099-4-andrej.picej@norik.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221103100358.176099-1-andrej.picej@norik.com>
References: <20221103100358.176099-1-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was discovered that the watchdog triggers when the device is put into
"Suspend-To-Idle"/"freeze" low-power mode. Setting WDW bit disables
watchdog when the device is put into WAIT mode.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
Changes in v3:
 - no changes

Changes in v2:
 - no changes
---
 arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
index 3cddc68917a0..5168ed0ffec3 100644
--- a/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
@@ -102,6 +102,10 @@ &usdhc2 {
 	status = "disabled";
 };
 
+&wdog1 {
+	fsl,suspend-in-wait;
+};
+
 &iomuxc {
 	pinctrl_enet1: enet1grp {
 		fsl,pins = <
-- 
2.25.1

