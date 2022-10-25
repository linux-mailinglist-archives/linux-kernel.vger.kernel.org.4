Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F9060C5AA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbiJYHnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbiJYHmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:42:50 -0400
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A60415B124;
        Tue, 25 Oct 2022 00:42:49 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout4.routing.net (Postfix) with ESMTP id 49E41101A65;
        Tue, 25 Oct 2022 07:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1666683767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rMnfisK/hDmrrndbTYh3V3/FJiHDh0xeFPqPbDK9Zow=;
        b=f1mP4aqjq5wkxMN5gPtEtu1ev81iuwEq2o1/t294TVA5GLsOJfiDpG/+dQdPp5rHqOX4gT
        BbXjpilXS9X9MJqJpN3rHND/g7+LuXmnPVY9gK6Ipgk4lxo6ZxggClrvPwqJ3PeNphnrmE
        NEAtreI1L/FMSRqwN8ybCJWKRuKRNu8=
Received: from frank-G5.. (fttx-pool-217.61.152.57.bambit.de [217.61.152.57])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 5AA4D360678;
        Tue, 25 Oct 2022 07:42:46 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sam Shih <Sam.Shih@mediatek.com>
Subject: [PATCH v4 5/6] arm64: dts: mt7622: drop r_smpl property from mmc node
Date:   Tue, 25 Oct 2022 09:42:37 +0200
Message-Id: <20221025074238.18136-6-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025074238.18136-1-linux@fw-web.de>
References: <20221025074238.18136-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: ca207c87-d84f-4200-b533-1ad5a24f085f
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

This property is not defined in binding and driver.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts | 1 -
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts             | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
index d3f9eab2b784..af3fe61e4093 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -235,7 +235,6 @@ &mmc1 {
 	bus-width = <4>;
 	max-frequency = <50000000>;
 	cap-sd-highspeed;
-	r_smpl = <1>;
 	cd-gpios = <&pio 81 GPIO_ACTIVE_LOW>;
 	vmmc-supply = <&reg_3p3v>;
 	vqmmc-supply = <&reg_3p3v>;
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index 36722cabe626..b74e774c6eba 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -208,7 +208,6 @@ &mmc1 {
 	bus-width = <4>;
 	max-frequency = <50000000>;
 	cap-sd-highspeed;
-	r_smpl = <1>;
 	cd-gpios = <&pio 81 GPIO_ACTIVE_LOW>;
 	vmmc-supply = <&reg_3p3v>;
 	vqmmc-supply = <&reg_3p3v>;
-- 
2.34.1

