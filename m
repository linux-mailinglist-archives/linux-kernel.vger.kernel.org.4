Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A213E5EB02C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiIZSih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiIZShr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:37:47 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA5E6B144;
        Mon, 26 Sep 2022 11:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=X/Xqb9iReTmBYL1vyNLyfo977MT6MBoIhiCyEd781tQ=; b=xV0Bw6Vvfqr5oL++BD7b8hPkrg
        X43nvESt/P4dkG8/bhrlZm8uJGuJdCpk0jQhsCFUFOcFn0ZuBH6kCowOhGeIHynkLDG5LvVKoO6l9
        2BiQx24OLtMeLXPgB09KSuSReNcfp8+n/Eu9q/cqD6ONAs81vfUW+BIz7NAAr/qMR1vkozmugwx0c
        kv44fUcqv1NVe2yqsPUo1lPzG1g0m+hZtyrLmCiL5MvTkUHN1vYD1q+dco4b5SdD5aGEEi8b8f++W
        51BB09eLzoNx+JRI3JHS856m/gX98sXxlhaoCJnGNnafkRJtK/ETzlokkj+DCtdEGULKpEQbUuO8B
        +SQruS6w==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1ocsz3-00B9PU-3a; Mon, 26 Sep 2022 20:37:37 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1ocsz1-007wby-1T;
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
Subject: [PATCH v2 03/13] arm64: dts: rockchip: add thermal support to ODROID-M1
Date:   Mon, 26 Sep 2022 20:37:17 +0200
Message-Id: <20220926183727.1893566-4-aurelien@aurel32.net>
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

Add the thermal nodes for the ODROID-M1.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
index b3016437640b..112c65af3f55 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts
@@ -409,6 +409,12 @@ &sdmmc0 {
 	status = "okay";
 };
 
+&tsadc {
+	rockchip,hw-tshut-mode = <1>;
+	rockchip,hw-tshut-polarity = <0>;
+	status = "okay";
+};
+
 &uart2 {
 	status = "okay";
 };
-- 
2.35.1

