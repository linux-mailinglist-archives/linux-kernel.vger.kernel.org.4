Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C0F619B1F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbiKDPMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbiKDPLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:11:51 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643ED1D0CC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 08:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=goF9wc5+Rtu27P
        piBYCeFCpbgEpJxB9otcfihRuwblg=; b=bUxYA7yTSx4MUhzulIiQY89hE0Kppu
        2hCXGkd3JFULswVkFllNvczfQKGCVJEUavdlgJKMPzph4SfMDCB63yAy0TRMcnxH
        5QxMtdi7zIRSquHVvGYwnn9A21wzZiR3zflAVhbftrmaqysRjSHKy/wfakwPAG0d
        eZRHYyx5OYwb4=
Received: (qmail 3148319 invoked from network); 4 Nov 2022 16:11:47 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Nov 2022 16:11:47 +0100
X-UD-Smtp-Session: l3s3148p1@fEwFfqbsoAhZD+8G
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] TEST: arm64: dts: renesas: white-hawk-cpu: Enable CMT
Date:   Fri,  4 Nov 2022 16:11:35 +0100
Message-Id: <20221104151135.4706-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221104151135.4706-1-wsa+renesas@sang-engineering.com>
References: <20221104151135.4706-1-wsa+renesas@sang-engineering.com>
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

This patch enables CMT{0|1|2|3} on the WhiteHawk board.

Only for testing, not for upstream!

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 .../dts/renesas/r8a779g0-white-hawk-cpu.dtsi     | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk-cpu.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk-cpu.dtsi
index c10740aee9f6..7f565e161662 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk-cpu.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779g0-white-hawk-cpu.dtsi
@@ -279,3 +279,19 @@ &rwdt {
 &scif_clk {
 	clock-frequency = <24000000>;
 };
+
+&cmt0 {
+	status = "okay";
+};
+
+&cmt1 {
+	status = "okay";
+};
+
+&cmt2 {
+	status = "okay";
+};
+
+&cmt3 {
+	status = "okay";
+};
-- 
2.35.1

