Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88C8670BFE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjAQWq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjAQWnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:43:43 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9C57D657;
        Tue, 17 Jan 2023 14:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=54+laNC9KWV7OlZbMfS8KMwp9ANabRHoFhhivcdROys=; b=vTtbu2duso/J6aniL1mcxVJYWR
        r3R2wIvIvP7bfAvH2uVgbP45HCQBuUyarqNiJk53TdA3I+i3S40U4WGV5qTNVgs8gUdr/O2F0VD5T
        f4HqgzUMVTm1tNlXryg1skLkgannYvLLm/P0pPgCRnfEzp+nmn1bXWUqVA0AqS9w7ic2yTAc8QMop
        o9VOUNf1BA572yiMBblGrZVJpkiHCEiyd8xpsCbdYarZulvujlDKQGlC7zAOyuPbBg/prkptyZomq
        +t1Jj02vW2FQNIxgLlaCxFDQjzoQ/tqBBWXz99zJJrnX9hS4Mc07QxTxQopaH6kWQ1XEBBbyDZNM+
        Cq5jyopQ==;
Received: from p200300ccff136d001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff13:6d00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pHuTt-0006TY-Ne; Tue, 17 Jan 2023 23:31:01 +0100
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1pHuTt-00Awpj-5X; Tue, 17 Jan 2023 23:31:01 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] ARM: dts: omap: gta04a5: cleanup i2c node names
Date:   Tue, 17 Jan 2023 23:30:59 +0100
Message-Id: <20230117223059.2609390-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use generic node names.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/omap3-gta04a5.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-gta04a5.dts b/arch/arm/boot/dts/omap3-gta04a5.dts
index 4f4e402ea3fa..53057d55cbed 100644
--- a/arch/arm/boot/dts/omap3-gta04a5.dts
+++ b/arch/arm/boot/dts/omap3-gta04a5.dts
@@ -120,17 +120,17 @@ &i2c2 {
 	/delete-node/ itg3200@68;
 	/delete-node/ hmc5843@1e;
 
-	bmg160@69 {
+	gyrometer@69 {
 		compatible = "bosch,bmg160";
 		reg = <0x69>;
 	};
 
-	bmc150@10 {
+	accelerometer@10 {
 		compatible = "bosch,bmc150_accel";
 		reg = <0x10>;
 	};
 
-	bmc150@12 {
+	magnetometer@12 {
 		compatible = "bosch,bmc150_magn";
 		reg = <0x12>;
 	};
-- 
2.30.2

