Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C259A658C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 12:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiL2Lvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 06:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbiL2Lvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 06:51:51 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F23013E01;
        Thu, 29 Dec 2022 03:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=e72xy
        e98vJi65A6YWv7o8YldGpV2X80Pi4fU31n4lrg=; b=lVvjxQY/+loC6dajLumrL
        gmrgw2Aq7SnMaAwO2XCiq4gz/lfdPbNw7sogrS3yJPKbl0r5uFLv0cW/xxaJwNXX
        HxUw6C+8FJC70e4L+P8mDaeJd8B2OxpOpQZIzsOYGtS45tjcXpIm+AyCZrtXK86x
        c4MRaiWmNAu+VI9Qsb9Ty0=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g4-2 (Coremail) with SMTP id _____wBXQrgUf61jl6RhAA--.33791S2;
        Thu, 29 Dec 2022 19:50:48 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        piotr.oniszczuk@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc:     Andy Yan <andyshrk@163.com>
Subject: [PATCH v2 1/2] arm64: dts: rockchip: rk3566-box-demo: add io domain setting
Date:   Thu, 29 Dec 2022 19:50:43 +0800
Message-Id: <20221229115043.3899733-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBXQrgUf61jl6RhAA--.33791S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruF47Ar4kuF48ZryfGw47twb_yoWDArb_ta
        4xWryrJFs7Crn8tw1rt3y5G340g3yDXay7J3W5XFWDJFZIga18ZFW3J3y7ur9rJrW29rs7
        Xa1UXFy8JwnrCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREco7tUUUUU==
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbCfgbmXmDcMjBFogAAsZ
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing pmu_io_domains setting, the gmac can't work well
without this.

Fixes: 2e0537b16b25 ("arm64: dts: rockchip: Add dts for rockchip rk3566 box demo board")
Signed-off-by: Andy Yan <andyshrk@163.com>

---

(no changes since v1)

 arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts b/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts
index 4c7f9abd594f..d956496d5221 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts
@@ -353,6 +353,17 @@ led_work_en: led_work_en {
 	};
 };
 
+&pmu_io_domains {
+	pmuio2-supply = <&vcc_3v3>;
+	vccio1-supply = <&vcc_3v3>;
+	vccio3-supply = <&vcc_3v3>;
+	vccio4-supply = <&vcca_1v8>;
+	vccio5-supply = <&vcc_3v3>;
+	vccio6-supply = <&vcca_1v8>;
+	vccio7-supply = <&vcc_3v3>;
+	status = "okay";
+};
+
 &pwm0 {
 	status = "okay";
 };
-- 
2.34.1

