Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC705BA9E6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 12:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiIPKDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 06:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiIPKDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 06:03:10 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E880AB180;
        Fri, 16 Sep 2022 03:03:06 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id cc5so25351198wrb.6;
        Fri, 16 Sep 2022 03:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Nfu4jbyiIWMFkY+HaHxsAx5hZmCA7LP0E6OJ69aVXfM=;
        b=C/Sh2hiT1LT2Gc0Sf6D+PolCRdD3eiDxQZaf9gySo+WrgTH57+9iw/OiHI8sL43LZj
         L3YiSsfOHF+V6G65wLA6ASrTvW9eV9veWQxsb6zBvFu4FsgAKGGQnmRpZScNx/qK089B
         3HudYX2l+tfRKt4o2xc2/CWZt+kHSRER3d28emrqVgqkQVaHgDjz2LodKloEUotm9WO+
         FxuatBVRmpmYpADnPf/bHPdmv4tGn6QckMoFnw/ySiVOE5wQTOUKuB94Cxi/W+qT2rc4
         eVAS0e76IQHQcXXcsq3Srsvt5FvKQydvvJrUl+qBoHMm4GQz4qjZWUfazX3VA4QE5gy9
         OqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Nfu4jbyiIWMFkY+HaHxsAx5hZmCA7LP0E6OJ69aVXfM=;
        b=wF1/frhDauQeUnrQzeEs6qbeKppXN1x+4PnT+H/mQTqRqh9C1XTy7/mdizRTPo0hDt
         E8rh+uT0nWUJFHgaNnVwQBrsDXkK0BXUgbOw/tFttONPHxFTfQVz02xVL2eKB3+fJ/sj
         eHkQee8nMSSI3h1ZC48FkN+h6iX1ZD+J+oWIA+xpXHD83JsuuWH7ngFUMcTyxe4b8Fow
         3eN85RjDuCVANGktmf8b0iXAucIR2J2TtD856FCuocxjKmmCqOZQRSIisr9ccZvLse7J
         PsFy++GjQwMShIg1aXU1A+jDqZyiDLHpeKF29fJRnoDer31Mhjw35rmqoUFy55q3Hobb
         vz3Q==
X-Gm-Message-State: ACrzQf11o6osqh+PHydB2znHIdGAzld9pUAzMFwUszRAovxS0m5jrtXQ
        OCDRm0I/IpqkChdSDGufilKNoZuQ50lsYQ==
X-Google-Smtp-Source: AMsMyM6bKnPSD8sPETVPpx5ETWKeHIlMmO5gxFWnDcpUgM/fPWUhx2LuNiOGcqCe/g7AaoqV/7ROFw==
X-Received: by 2002:adf:fd47:0:b0:228:dbab:8f5d with SMTP id h7-20020adffd47000000b00228dbab8f5dmr2243749wrs.524.1663322584420;
        Fri, 16 Sep 2022 03:03:04 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:453:ec29:bd55:6b15])
        by smtp.gmail.com with ESMTPSA id a8-20020adfe5c8000000b0021db7b0162esm4725069wrn.105.2022.09.16.03.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 03:03:03 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] arm64: dts: renesas: Adjust whitespace around '{'
Date:   Fri, 16 Sep 2022 11:02:51 +0100
Message-Id: <20220916100251.20329-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Drop extra space around the '{' sign. No functional changes (same DTB).

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi | 2 +-
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 2 +-
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index ff6aab388eb7..689aa4ba416b 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -619,7 +619,7 @@ gic: interrupt-controller@11900000 {
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
 		};
 
-		sdhi0: mmc@11c00000  {
+		sdhi0: mmc@11c00000 {
 			compatible = "renesas,sdhi-r9a07g043",
 				     "renesas,rcar-gen3-sdhi";
 			reg = <0x0 0x11c00000 0 0x10000>;
diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 35e7255471b8..2283d4fb8736 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -778,7 +778,7 @@ gic: interrupt-controller@11900000 {
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
 		};
 
-		sdhi0: mmc@11c00000  {
+		sdhi0: mmc@11c00000 {
 			compatible = "renesas,sdhi-r9a07g044",
 				     "renesas,rcar-gen3-sdhi";
 			reg = <0x0 0x11c00000 0 0x10000>;
diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index d27b6c388580..358d4c34465f 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -784,7 +784,7 @@ gic: interrupt-controller@11900000 {
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
 		};
 
-		sdhi0: mmc@11c00000  {
+		sdhi0: mmc@11c00000 {
 			compatible = "renesas,sdhi-r9a07g054",
 				     "renesas,rcar-gen3-sdhi";
 			reg = <0x0 0x11c00000 0 0x10000>;
-- 
2.25.1

