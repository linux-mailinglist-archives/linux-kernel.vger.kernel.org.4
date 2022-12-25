Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8477655D25
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 13:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiLYMGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 07:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiLYMGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 07:06:10 -0500
X-Greylist: delayed 943 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 25 Dec 2022 04:06:08 PST
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E4273BD;
        Sun, 25 Dec 2022 04:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=EccN8
        6IDfO6djKRdgtxcfxYIaCVZPDoY9AK/hFvC7Yk=; b=m5YjKSwlRZkh5YLRzlB1q
        Gt5U45ZKMvjEMBJs0IkIWI7ziqJNqD182pMLV588NgHRTXV6vd/xfdu9COBUE6yH
        VO7tLPTWi4ppHvQ0VIvcfdwQJ1mEZYXGJHf5WscontUYsWlGbMbdkcPnPdZBAW1g
        P2ElN6XXX6q3FrQ86SWKXw=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g4-2 (Coremail) with SMTP id _____wCXAyHUOKhjYcd0AA--.37735S2;
        Sun, 25 Dec 2022 19:49:44 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        piotr.oniszczuk@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc:     Andy Yan <andyshrk@163.com>
Subject: [PATCH 1/2] arm64: dts: rockchip: rk3566-box-demo: add io domain setting
Date:   Sun, 25 Dec 2022 19:49:39 +0800
Message-Id: <20221225114939.3518552-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221225114915.3518502-1-andyshrk@163.com>
References: <20221225114915.3518502-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCXAyHUOKhjYcd0AA--.37735S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruF47Ar4kuF48ZryfGw47twb_yoWDXrg_ta
        4xWryrJFs7Crn8tr1rt3y5G340g3yDXay7Ja15uFWDJFZIga1kZ3y3J3y7ur9rJrW29rs7
        Xa1UZFy8JwnxCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREbAwDUUUUU==
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMxriXlXmDTu3pAAAsD
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
2.25.1

