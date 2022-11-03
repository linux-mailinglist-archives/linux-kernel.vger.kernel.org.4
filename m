Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7365618A08
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiKCU4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiKCUz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:55:58 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E91320BE8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 13:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=URqIf3QgMum3iU
        DS/tShDMnRSXC+8dEdK//RHXmsfwA=; b=rX/0hWWfvsbSvBWAvOu01nN826F/Nf
        CTJ4z10HimKEj0UdbcNZIdjKtqoIpMr4m1THXFt3efaeTtw9jGbLU3Bm/PV/bLN/
        fq9LqKgpYI72G+MnXgqrCjNxyIMWa34cPIuaXeAZsAxRDAFeRv9RwH5qZL+V2ujw
        oknSuK02U7ghQ=
Received: (qmail 2787830 invoked from network); 3 Nov 2022 21:55:54 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Nov 2022 21:55:54 +0100
X-UD-Smtp-Session: l3s3148p1@+NTZLpfs2OUujns0
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] TEST: arm64: dts: renesas: white-hawk-cpu: Enable TMU
Date:   Thu,  3 Nov 2022 21:55:45 +0100
Message-Id: <20221103205546.24836-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221103205546.24836-1-wsa+renesas@sang-engineering.com>
References: <20221103205546.24836-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables TMU{0|1|2|3|4} on the WhiteHawk board.

Only for testing, not for upstream!

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 .../dts/renesas/r8a779g0-white-hawk-cpu.dtsi  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk-cpu.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk-cpu.dtsi
index c10740aee9f6..976e37ea0d7b 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk-cpu.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk-cpu.dtsi
@@ -279,3 +279,23 @@ &rwdt {
 &scif_clk {
 	clock-frequency = <24000000>;
 };
+
+&tmu0 {
+	status = "okay";
+};
+
+&tmu1 {
+	status = "okay";
+};
+
+&tmu2 {
+	status = "okay";
+};
+
+&tmu3 {
+	status = "okay";
+};
+
+&tmu4 {
+	status = "okay";
+};
-- 
2.35.1

