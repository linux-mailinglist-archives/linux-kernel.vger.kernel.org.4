Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E266254FD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbiKKIKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbiKKIKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:10:41 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D4BD65877;
        Fri, 11 Nov 2022 00:10:40 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 11 Nov 2022 17:10:38 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id D0A5520584CE;
        Fri, 11 Nov 2022 17:10:38 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 11 Nov 2022 17:10:38 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 63E7AB62A4;
        Fri, 11 Nov 2022 17:10:38 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 3/6] dt-bindings: sdhci-fujitsu: Add compatible string for F_SDH30_E51
Date:   Fri, 11 Nov 2022 17:10:30 +0900
Message-Id: <20221111081033.3813-4-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221111081033.3813-1-hayashi.kunihiko@socionext.com>
References: <20221111081033.3813-1-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string for F_SDH30_E51 IP to the documentation.
Since this IP is transferred to Socionext, so append it as vendor name.

Cc: devicetree@vger.kernel.org
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../devicetree/bindings/mmc/fujitsu,sdhci-fujitsu.yaml      | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/fujitsu,sdhci-fujitsu.yaml b/Documentation/devicetree/bindings/mmc/fujitsu,sdhci-fujitsu.yaml
index 85bfaadb0479..73d747e917f3 100644
--- a/Documentation/devicetree/bindings/mmc/fujitsu,sdhci-fujitsu.yaml
+++ b/Documentation/devicetree/bindings/mmc/fujitsu,sdhci-fujitsu.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/mmc/fujitsu,sdhci-fujitsu.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Fujitsu SDHCI controller (F_SDH30)
+title: Fujitsu/Socionext SDHCI controller (F_SDH30)
 
 maintainers:
   - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
@@ -14,7 +14,9 @@ allOf:
 
 properties:
   compatible:
-    const: fujitsu,mb86s70-sdhci-3.0
+    enum:
+      - fujitsu,mb86s70-sdhci-3.0
+      - socionext,f-sdh30-e51-mmc
 
   reg:
     maxItems: 1
-- 
2.25.1

