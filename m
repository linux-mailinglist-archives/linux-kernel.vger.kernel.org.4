Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97E26868B2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 15:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjBAOnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 09:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjBAOnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:43:10 -0500
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1992E825;
        Wed,  1 Feb 2023 06:43:04 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EA0A2C0330;
        Wed,  1 Feb 2023 15:34:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1675262099; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=hDg1hF2NZG1k6HPgl88QV1xEXYDBSAVmSwJrGIgDnCs=;
        b=K8Sn9kFVdiKRSTQdmAJ99uubjckXX0hJqe5kiWAfiFUx38C+23x7+/xd7E/s7VaL4TU3g+
        96gwIu0hLbSoIRppqatbdaf7J/iSUiZ9xBmhrcScR5VOqV01Kw3+3XcKV0rgCiubust8g8
        CEwO2Xcaej3HLpsncemzwdp90EELfEWsS5gaWRxDlA5UjvaAuXZ+J/4ZugJE5Gk4so8DA/
        MY8KvJNyp+KnDrJ6QUU+szz98Kfb3HVW0wAinePw08w3oi0PdEO7KaliaJNIcZxWdQNxqC
        tPk4us47xOjJmGX/NbARdsWxt3w/fdSvIaaXfg+KFipW0WHsXk8pyAleEvB33A==
From:   Frieder Schrempf <frieder@fris.de>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/7] dt-bindings: rtc: Add backup-switch-mode property
Date:   Wed,  1 Feb 2023 15:34:24 +0100
Message-Id: <20230201143431.863784-3-frieder@fris.de>
In-Reply-To: <20230201143431.863784-1-frieder@fris.de>
References: <20230201143431.863784-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Document the backups-switch-mode property that can be used to set the
BSM via devicetree on devices like the RV3028.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 Documentation/devicetree/bindings/rtc/rtc.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/rtc.yaml b/Documentation/devicetree/bindings/rtc/rtc.yaml
index c6fff5486fe6..76b9605e755b 100644
--- a/Documentation/devicetree/bindings/rtc/rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/rtc.yaml
@@ -26,6 +26,13 @@ properties:
       0: not chargeable
       1: chargeable
 
+  backup-switch-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1, 2, 3 ]
+    description:
+      The backup switch mode the RTC is forced into when registering
+      the device. See include/dt-bindings/rtc/rtc.h for a list of values.
+
   quartz-load-femtofarads:
     description:
       The capacitive load of the quartz(x-tal), expressed in femto
-- 
2.39.1

