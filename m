Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530AB6B1946
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 03:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCICkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 21:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCICkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 21:40:11 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBA06189A;
        Wed,  8 Mar 2023 18:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1678329610;
  x=1709865610;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/pduviUxdUwppzlaYefZ3H3U2LUt8NqAXlb8XAKtnSM=;
  b=oIs1gv6tv/vOeJlJmcP1h2lxfWfKv22DuHi+KgvJqGgYp+DoR9eqNMXM
   AhqQQUKNFPsrIJMmGnk4yguur1J4DjkfWo3lFLlBRDwFqCekmQhtJ7r+K
   orrmFM9aBZgk62uBuI9hD65bM78BNXEwZF9widY2iiiUKzonDGLpm5Wx9
   uT6EgVY1uN+R5q8YlSkeN5LDWmSxf07rBvawxQTnNokOT+dXhgzPwyWhi
   6OZY/qTletCiFuIjt7RNN48ekjYlggIR3qNsbTnhyFHDftgBAXst6OiqR
   bfhXNnxDuQpStkf16K+hvXSA0Z2tdbgg3duJw4VFNoOyeBk/HqqOhQ+Kw
   g==;
From:   Hermes Zhang <chenhuiz@axis.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Davis <afd@ti.com>
CC:     <kernel@axis.com>, Hermes Zhang <chenhuiz@axis.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: power: supply: bq256xx: Add ts-ignore property
Date:   Thu, 9 Mar 2023 10:39:26 +0800
Message-ID: <20230309023926.38682-1-chenhuiz@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new property: ts-ignore to allow user to enable the TS_IGNORE flag
in chip. Ignore TS pin will allow user to control the charging
parameters instead of the default JEITA profile in chip.

Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
---
 Documentation/devicetree/bindings/power/supply/bq256xx.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq256xx.yaml b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
index 82f382a7ffb3..74fd48f4bec5 100644
--- a/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
@@ -68,6 +68,12 @@ properties:
       Interrupt sends an active low, 256 μs pulse to host to report the charger
       device status and faults.
 
+  ts-ignore:
+    type: boolean
+    description: |
+      If this property is set, the TS_IGNORE flag will be set to 1 which means
+      will not apply JEITA profile during the charging.
+
 required:
   - compatible
   - reg
-- 
2.30.2

