Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAA66E26D3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjDNPYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjDNPYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:24:37 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B15AD37;
        Fri, 14 Apr 2023 08:24:35 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 211AC5FD26;
        Fri, 14 Apr 2023 18:24:34 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1681485874;
        bh=C6RAhM5A4BPHpRvqPC3ioWTgfct9Luzmkm/GQUTL3y8=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=CkyiC5UmgoUazTCGzdnnbsZ1pUZ0e/fl8OQhoq4l4f4JFm6e1MN3YKe81/0NaZycv
         2yUexAzAxh4o0hqFRzrMT2NFjbqywU3XnzTfdqI5tqKfPVfwKp9dFuCJ8/jsRUE+eM
         qnBVd+4Ddbkwp8StXJqDlSvl1LZHA7bpgU3cAmZ9Q3EJrbOwKknyKA7gHxSkiHHh/N
         eNmROGlk0ILOQNtPQjvGBTq4OvL0C7+R7Rf8DVBBMR/QX1BuKdCIE+CaX06aZZEww6
         xoIy35K14SXnltaFUikrxeX/WTpDaCGhfmTiMfo89BtMWR8+FFqkkdfgoIYYg2t62M
         tDm104Yj+iB4w==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri, 14 Apr 2023 18:24:34 +0300 (MSK)
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <mturquette@baylibre.com>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <hminas@synopsys.com>,
        <Thinh.Nguyen@synopsys.com>
CC:     <yue.wang@amlogic.com>, <hanjie.lin@amlogic.com>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-phy@lists.infradead.org>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v1 3/5] dt-bindings: usb: dwc2: add support for Amlogic A1 SoC USB peripheral
Date:   Fri, 14 Apr 2023 18:24:21 +0300
Message-ID: <20230414152423.19842-4-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230414152423.19842-1-ddrokosov@sberdevices.ru>
References: <20230414152423.19842-1-ddrokosov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/14 08:08:00 #21104846
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide the appropriate compatible string for the DWC2 IP that is found
inside the Amlogic A1 SoC and used in peripheral mode.

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 Documentation/devicetree/bindings/usb/dwc2.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
index 371ba93f3ce5..f70be397dac0 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.yaml
+++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
@@ -53,6 +53,7 @@ properties:
               - amlogic,meson8b-usb
               - amlogic,meson-gxbb-usb
               - amlogic,meson-g12a-usb
+              - amlogic,meson-a1-usb
               - intel,socfpga-agilex-hsotg
           - const: snps,dwc2
       - const: amcc,dwc-otg
-- 
2.36.0

