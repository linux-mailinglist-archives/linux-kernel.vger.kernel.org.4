Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E795F0430
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 07:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiI3FNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 01:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiI3FNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 01:13:12 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CAF1664A7;
        Thu, 29 Sep 2022 22:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=1SQ7lNpSiCQMCl0mv1Tz12guO+YBNRrBVs+sLNxQgeY=; b=VzHRPby4+VJ/9bxGJKzTGeMo74
        usqo6VSSv+D9Vy5IwNK0g4nt0Yhsv2mSqaFDW9arfPdQ5RWtnx3ZMrLaLM/GEoFEjMcpxu1Kt3jU2
        rJoljoeMqvsITqDHjdttU+7dFBoNPknCyQ36u5/9dA7JXgkILt6wabFwRKNw7y68Q+qe8RpwhYLD0
        QmgRS2ZdlxNbY3r9ewNl8ada+rnzJ+2lCOx285oMGmtQby0Vbf7BAU7Iviljhd8CICFBc+1EVbFNJ
        OLwn/MNq4f584Kj8CzkdSDkVD68JXpXnAgEEF5xM6l/ktCMfQX5NIs0Yf3CiusZu2X84Zh+TxNEmQ
        s9JqVyGQ==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1oe8Kg-00Djfm-0h; Fri, 30 Sep 2022 07:13:06 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1oe8Kf-001dw5-0y;
        Fri, 30 Sep 2022 07:13:05 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
        linux-kernel@vger.kernel.org (open list)
Cc:     Dongjin Kim <tobetter@gmail.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Dan Johansen <strit@manjaro.org>
Subject: [PATCH v3 11/13] arm64: dts: rockchip: Add SATA support to ODROID-M1
Date:   Fri, 30 Sep 2022 07:12:44 +0200
Message-Id: <20220930051246.391614-12-aurelien@aurel32.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220930051246.391614-1-aurelien@aurel32.net>
References: <20220930051246.391614-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the Combo PHY and SATA nodes in ODROID-M1.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Tested-by: Dan Johansen <strit@manjaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
index 9a84a7e76d7a..bd24ccf94e76 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
@@ -153,6 +153,11 @@ &combphy1 {
 	status = "okay";
 };
 
+&combphy2 {
+	/* used for SATA */
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&vdd_cpu>;
 };
@@ -538,6 +543,10 @@ &saradc {
 	status = "okay";
 };
 
+&sata2 {
+	status = "okay";
+};
+
 &sdhci {
 	bus-width = <8>;
 	max-frequency = <200000000>;
-- 
2.35.1

