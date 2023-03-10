Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575046B4664
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjCJOms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjCJOmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:42:35 -0500
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BE81220B1;
        Fri, 10 Mar 2023 06:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1678459040;
        bh=OfRq4RsjFmFjVbXxoteCcZ+CskP3emYj476+qItt3ZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=geHRgdeWEUWgC4Mt1YUk2R7/0LfeUCfM73w/GwQ8G06aVR/UcO6mb+D2XHFeQOuTa
         +A2dnCZ3OQJ5UYUBxIjdQvjA96BR6NTB7LmdkGTtgcHwRD3sUU3oMEPkZ9RW9BNijz
         ojKrarmUwCGPkrzl/+VptoadD61Tf6ytmP3oychU=
Received: from DESKTOP-ZMX.localdomain ([115.156.143.0])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id 8A61225E; Fri, 10 Mar 2023 22:34:38 +0800
X-QQ-mid: xmsmtpt1678458899t5mn9caiy
Message-ID: <tencent_27DD0718C3FD9C5F7D6E2FBA225CAA760405@qq.com>
X-QQ-XMAILINFO: N01B81DxkqnprkTzGWFG4fKDVG1Fe4WRIhp70ERlCuCKVw1hHjAwrqMnQdl5e8
         NdgW28oHtGkAPms5je69zlTX45CrP9nR6StYUnPGrwEtsviDgrOR67w57LBlChakUKkCSSUy42/d
         cQIM57R3RJjgEQ+epwrwdy5s7LfjEcvfeRhIbtdvdHJOSFT34IC0eM7OuxffWcU6/yGXnfTGxv8T
         TOt+aC1X1uPUb6JghMeye6Xf5SFCAhTl8shgG501nDz4ubR9jF+lkvPGi9d5jRrh1qGyKzBMILmW
         LWUxXOYKYMvjxHaah2QseiszGFlyLVJdRSa8g718hI4Ryb8hWAQKoQfWVzprLKBkiIXB6Q0FtaJU
         aXRZqgTj5p8PGUD/btPkcmQgDp74MhwJfDfDj1m8ZpnfqYQFFaMbMoOvbPD5uPBVeKgyFg2ZdWek
         YHAXvCvtE5oMW3Vw0mC9qGPSSIQuYpemn6qzlS//EEEDV6wSXe141jD7hUJP5Sd7iXeKVGvO0nRU
         KFb4Z0qofHhMUeo+gmOffGqN/WV3uo0SgV5wHvC2ecC1tlNZyUBRSgUYm0ogGRePw1/rduc+osTe
         zjf+wHp+Tvz+lK6KsInWu1jEdtM2HqqqfMKaqR1rplXG0pSJyE3uCHefeKUHGHIkuiQnipEciaOc
         QYq3nR6Alvp+ecffLnYIbKHNJSyo/P4gCpt5Y29RFXkGFzhhkEkKFcp0oqcGIeRhpC7WTF0fks2Z
         E+reguygacWZLj/kNirzDIZvk0vp1NLWbs6/NAIGjkjGRenIt/asOzrAAm1zWuQCuxLY5C7FyULr
         YPpV4kbSe2pMG5rR2aLo6e0TRn/BLnRm420xrC1F5cMX0LmVSZG+xD5nnttxlR4VyEOn85WeLNWJ
         QvikSoDrq6hITqkLKN/YhuBRBYCWZYxXHgXROlPPBopqoOAG3tTFlHvSN65IJk3udRmKEaaSRINM
         DW47b+JiIdy4hO19yCJ+zU9/QFWRvwZIfUGVwr5xdBTMXSr60MUaGPwvsDvsYyKMek2LDIXY9sw+
         cJriHndfJDUB+NPi/4PFdwO6AafE+1Xw+oCI0Y8ZiqhS2gVbAR
From:   Yang Xiwen <forbidden405@foxmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        Yang Xiwen <forbidden405@foxmail.com>
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Henan Yiming Technology Co., Ltd.
Date:   Fri, 10 Mar 2023 22:33:28 +0800
X-OQ-MSGID: <20230310143330.9485-2-forbidden405@foxmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230310143330.9485-1-forbidden405@foxmail.com>
References: <20230310143330.9485-1-forbidden405@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Henan Yiming Technology Co., Ltd. was established in 2021. The business
scope of the company includes: communication equipment (excluding radio
control equipment).

Link: https://gw.yimingkeji.net
Signed-off-by: Yang Xiwen <forbidden405@foxmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ed64e06ecca49..d6ec61904d6b8 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1528,6 +1528,8 @@ patternProperties:
     description: Yes Optoelectronics Co.,Ltd.
   "^yic,.*":
     description: YIC System Co., Ltd.
+  "^yiming,.*":
+    description: Henan Yiming Technology Co., Ltd.
   "^ylm,.*":
     description: Shenzhen Yangliming Electronic Technology Co., Ltd.
   "^yna,.*":
-- 
2.39.1

