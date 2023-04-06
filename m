Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC936DA408
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjDFUtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240147AbjDFUtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:49:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72A876BF;
        Thu,  6 Apr 2023 13:48:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4186F64BAE;
        Thu,  6 Apr 2023 20:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A930C433EF;
        Thu,  6 Apr 2023 20:48:01 +0000 (UTC)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] MAINTAINERS: hwmon: drop Agathe Porte
Date:   Thu,  6 Apr 2023 22:47:50 +0200
Message-Id: <20230406204750.3017850-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mails to Agathe Porte bounce ("550 5.4.1 Recipient address rejected:
Access denied. AS(201806281)").

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Update also bindings.
---
 Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml | 2 +-
 MAINTAINERS                                            | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml
index e7493e25a7d2..f9c00cbb2806 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: TMP464 and TMP468 temperature sensors
 
 maintainers:
-  - Agathe Porte <agathe.porte@nokia.com>
+  - Guenter Roeck <linux@roeck-us.net>
 
 description: |
   ±0.0625°C Remote and Local temperature sensor
diff --git a/MAINTAINERS b/MAINTAINERS
index 99b665e85f0a..7f0b8076f144 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21173,7 +21173,6 @@ F:	Documentation/hwmon/tmp401.rst
 F:	drivers/hwmon/tmp401.c
 
 TMP464 HARDWARE MONITOR DRIVER
-M:	Agathe Porte <agathe.porte@nokia.com>
 M:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-hwmon@vger.kernel.org
 S:	Maintained
-- 
2.34.1

