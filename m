Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD1A618A06
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiKCU4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiKCUz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:55:57 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D113020F7A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 13:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=CiKT0ywaHu2HO7
        FbV7S4AwMwEyA49BBUMacykFfoyPM=; b=W31qJy04SHtTgx7i/F28BGNUYjerLj
        MfFydYpBWrUv/JeLYmNWn1UmSULQCQKjVeLs7Ng7Mjsavgww7x0fL1pnO3tHFbEN
        wREorCYevco0Fof4Stho+PE/zJBRUmLt0dyf7L4hlTePj+ohItU8bnxiUjXErGEd
        ODaU+jQ+owwJM=
Received: (qmail 2787789 invoked from network); 3 Nov 2022 21:55:53 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Nov 2022 21:55:53 +0100
X-UD-Smtp-Session: l3s3148p1@S9DPLpfs0uUujns0
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm64: dts: renesas: white-hawk-cpu: sort RWDT entry correctly
Date:   Thu,  3 Nov 2022 21:55:44 +0100
Message-Id: <20221103205546.24836-4-wsa+renesas@sang-engineering.com>
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

Fixes: 495e36c3a313 ("arm64: dts: renesas: white-hawk-cpu: Enable watchdog timer")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm64/boot/dts/renesas/r8a779g0-white-hawk-cpu.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk-cpu.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk-cpu.dtsi
index bb4dd08781ca..c10740aee9f6 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk-cpu.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk-cpu.dtsi
@@ -271,11 +271,11 @@ user@1200000 {
 	};
 };
 
-&scif_clk {
-	clock-frequency = <24000000>;
-};
-
 &rwdt {
 	timeout-sec = <60>;
 	status = "okay";
 };
+
+&scif_clk {
+	clock-frequency = <24000000>;
+};
-- 
2.35.1

