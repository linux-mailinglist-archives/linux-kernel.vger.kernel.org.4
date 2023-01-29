Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFD867FC69
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 03:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjA2ChT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 21:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjA2ChQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 21:37:16 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44C423339;
        Sat, 28 Jan 2023 18:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1674959835;
  x=1706495835;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D2SpbsDvaVPtfn4au1YKj3XBGsxTvU/Y+hYx9Ht8zHA=;
  b=IhB5hWj5wlhkd+gqUAhRh48g0YUdCo2MkMH5BN1d3og7agoR9M86ik3k
   bqDhvW8sKPpNBpCLG91c8fLkUHPF927m7BLtcD9RwGdcv/dUpUDTRNhTd
   wBqFHga8TxqoKpaGaUjY1Ko48NtkYqLtoFrCwnEeNkoP5lWgsYtSiM8L5
   Kwi4TadHgh55xbxjYXGXW/MpZpwg/Wjv7tkDDzu4Z/Ow/uFjClDjn8G6d
   MbMThSMTTYvsVnpJgwaLTQjLO3rlwxW+2DwjoTtockr2/dSZ6zOMsuenG
   kW6akg5Ly9+nuI7LqST4hclJFsG/YSzowdWkIONPnay+OqwtdfHTYrZB2
   A==;
From:   Hermes Zhang <chenhuiz@axis.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <kernel@axis.com>, Hermes Zhang <chenhuiz@axis.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: mmc: Add cap-aggressive-pm property
Date:   Sun, 29 Jan 2023 10:36:30 +0800
Message-ID: <20230129023630.830764-1-chenhuiz@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit add a new property: cap-aggressive-pm to enable the
MMC_CAP_AGGRESSIVE_PM feature for (e)MMC/SD power saving.

Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
---
 Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index 86c73fd825fd..7ca674263dba 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -177,6 +177,11 @@ properties:
     description:
       enable SDIO IRQ signalling on this interface
 
+  cap-aggressive-pm:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      enable MMC_CAP_AGGRESSIVE_PM feature
+
   full-pwr-cycle:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-- 
2.30.2

