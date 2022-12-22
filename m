Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDB5654614
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 19:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbiLVSjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 13:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbiLVSir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 13:38:47 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8D9C1D329;
        Thu, 22 Dec 2022 10:38:46 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B253F16A3;
        Thu, 22 Dec 2022 10:39:27 -0800 (PST)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B075F3FAFB;
        Thu, 22 Dec 2022 10:38:45 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 4/5] dt-bindings: firmware: arm,scmi: Add support for syspower protocol
Date:   Thu, 22 Dec 2022 18:38:22 +0000
Message-Id: <20221222183823.518856-5-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221222183823.518856-1-cristian.marussi@arm.com>
References: <20221222183823.518856-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new SCMI Syspower protocol bindings definitions and example.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Got lost in translation probably...from txt to yaml
---
 .../devicetree/bindings/firmware/arm,scmi.yaml         | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 1c0388da6721..f3dd77a470dd 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -111,6 +111,12 @@ properties:
     required:
       - '#power-domain-cells'
 
+  protocol@12:
+    type: object
+    properties:
+      reg:
+        const: 0x12
+
   protocol@13:
     type: object
     properties:
@@ -285,6 +291,10 @@ examples:
                 #power-domain-cells = <1>;
             };
 
+            scmi_syspower: protocol@12 {
+                reg = <0x12>;
+            };
+
             scmi_dvfs: protocol@13 {
                 reg = <0x13>;
                 #clock-cells = <1>;
-- 
2.34.1

