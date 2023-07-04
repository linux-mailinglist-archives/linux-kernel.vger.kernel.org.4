Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9223C746C96
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjGDJAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjGDJAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:00:06 -0400
X-Greylist: delayed 3349 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Jul 2023 02:00:03 PDT
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F752127;
        Tue,  4 Jul 2023 02:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=jM+TtMP9aKuqji/7LgTWiurmTk0GfsL2Jv2TGbk6/bU=; b=PZNwwdZO7AB9Wp+MmHl7kWIWmW
        9fvQRGFrIzF2mRupJNfp4ag+TIBZqrZ/bcf1WqBURdEmK7GBfkwXLQ/d1cT5UWohTC2wcSmWSUs9w
        3PV5fSBnUOPj5ZejUYMHUhvwZT2gS+vu680ICVZbPcgbJATB4Wgy3aGQ5P9IVMhgK4OHiBVvKxY6E
        JtSvdA7F8howtiuUwm4nlYzqUjZvtQBQ1679UFznfZfvSUPd2Br2yXv4hE/EFtoa1U1/nqKGUQ3es
        RGChHez9ofgNhh5Ze4Ud6lkHl3eZ8++l8lb1q2Tr9LrjlMCkgLMrkH/KHpSE9PNNK53kMSt0oN8rb
        WPK1m9YQ==;
Received: from [89.212.21.243] (port=50488 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <andrej.picej@norik.com>)
        id 1qGb1A-009KMj-01;
        Tue, 04 Jul 2023 10:04:12 +0200
From:   Andrej Picej <andrej.picej@norik.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, upstream@phytec.de
Subject: [PATCH 2/2] ARM: dts: imx6: pfla02: Fix SD card reboot problem
Date:   Tue,  4 Jul 2023 10:03:04 +0200
Message-Id: <20230704080304.816942-3-andrej.picej@norik.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230704080304.816942-1-andrej.picej@norik.com>
References: <20230704080304.816942-1-andrej.picej@norik.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If regulator is not marked as always-on the regulator gets disabled on
reboot breaking the next boot.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index 80adb2a02cc9..25d6a036d5b8 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -192,6 +192,7 @@ vdd_3v3_pmic_io_reg: ldo6 {
 			vdd_sd0_reg: ldo9 {
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
 			};
 
 			vdd_sd1_reg: ldo10 {
-- 
2.25.1

