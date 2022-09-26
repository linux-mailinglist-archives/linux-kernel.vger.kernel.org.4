Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3B45EB026
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiIZSiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiIZShr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:37:47 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7AE6AEBB;
        Mon, 26 Sep 2022 11:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=aXxuht31ENiCKS8lMo5oW78O/VnDrXq1XV/X5vPEVVk=; b=oLXEz85Y75QEKbttjK259qMj/2
        5N2ZDFKtkpKG1xnva9VgKjd/iQh9inAvkqtgLyhQgzWE+0zNlYtxZ4vkeazZ4CIRr4ULUUATsySSY
        7+VVZ+7f/zEp9DVneMwWVoZJWJRBFo49d87zmT39S6DcvAFJVtRd7yU3N1qka18OaMMdDEh6r/ckx
        4gNABwsEcMlX8H88WmL33khvz9bbK2tnLJzUzJnaAik5Jh3ocnwOO/wdqDQlCAafb2SVoaxkep0ek
        reMLboBbG0gj0ITR1qZzKc4UNGY07oHMqZOlcr9xhiPHZb4pkNq96xFLAMl1AZmIplSO2ih1bflbA
        7Udz6t+w==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1ocsz3-00B9PY-DD; Mon, 26 Sep 2022 20:37:37 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1ocsz1-007wcD-1o;
        Mon, 26 Sep 2022 20:37:35 +0200
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
        Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 07/13] arm64: dts: rockchip: Enable HDMI audio on ODROID-M1.
Date:   Mon, 26 Sep 2022 20:37:21 +0200
Message-Id: <20220926183727.1893566-8-aurelien@aurel32.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220926183727.1893566-1-aurelien@aurel32.net>
References: <20220926183727.1893566-1-aurelien@aurel32.net>
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

This enables the i2s0 controller and the hdmi-sound node on the
ODROID-M1.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
index a7077d159099..8748dbf9a772 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
@@ -161,6 +161,10 @@ hdmi_out_con: endpoint {
 	};
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -400,6 +404,10 @@ regulator-state-mem {
 	};
 };
 
+&i2s0_8ch {
+	status = "okay";
+};
+
 &i2s1_8ch {
 	rockchip,trcm-sync-tx-only;
 	status = "okay";
-- 
2.35.1

