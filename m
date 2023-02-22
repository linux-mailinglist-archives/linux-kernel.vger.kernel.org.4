Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B933169F3AD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 12:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjBVLuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 06:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjBVLuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 06:50:35 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE1E32CEA;
        Wed, 22 Feb 2023 03:50:33 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 98DE75FD62;
        Wed, 22 Feb 2023 14:50:31 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1677066631;
        bh=UdeT4IMQpdav5+UNKBr3En6Ud+lKewoeO2W5d6ugRCo=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=FNCs88+vv+SiOwI4RlYHySChJ3BxeI8mHNaz9tgquViBGRiAI8JAPsdvoI1LPtqqW
         c1kDr1Mw9Z+uhALbCEz/ohwZVGYcrfhsAId1aoy/r77VjTYTUuQMD7wrf9d5M4RZyO
         ksWb5vZYH+HbwIognMi7c+XCZs3G7ggCpeFPiHqTBk97LaJh46S5ecl4chKOw/jGBp
         91ArVHxG38OUkBsbMP1dNpdSbQTCZ6jrcNg8sha6JJxIUt1dpBcKW1n9aS/6KNLFe4
         39L44IRMlcfTXuJKuz5PQmTbi62pOwlSwyy6mLF/di7SrhZnR92qQ7H7C1H5IRpAQn
         t9dAo488t7eKA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 22 Feb 2023 14:50:31 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <linus.walleij@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>,
        Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v1 1/3] meson: pinctrl: use CONFIG_PINCTRL_A1 with CONFIG_ARM
Date:   Wed, 22 Feb 2023 14:50:18 +0300
Message-ID: <20230222115020.55867-2-avromanov@sberdevices.ru>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230222115020.55867-1-avromanov@sberdevices.ru>
References: <20230222115020.55867-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/02/22 06:32:00 #20888384
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested A1 pinctrl support for ARM and it works.

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 drivers/pinctrl/meson/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/meson/Kconfig b/drivers/pinctrl/meson/Kconfig
index 64fb9e074ac6..fad688cabd05 100644
--- a/drivers/pinctrl/meson/Kconfig
+++ b/drivers/pinctrl/meson/Kconfig
@@ -57,7 +57,7 @@ config PINCTRL_MESON_G12A
 
 config PINCTRL_MESON_A1
 	tristate "Meson a1 Soc pinctrl driver"
-	depends on ARM64
+	depends on ARM || ARM64
 	select PINCTRL_MESON_AXG_PMX
 	default y
 
-- 
2.38.1

