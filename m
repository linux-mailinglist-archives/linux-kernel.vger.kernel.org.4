Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5D265D4D8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbjADOAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjADOAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:00:32 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BB219C07;
        Wed,  4 Jan 2023 06:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1672840832;
  x=1704376832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l5bZsXUcGNYMik0vfIYtBBpU340uhdhRP1oUa6rsGbs=;
  b=pF6/1z7g7K1kILyM64KqAxd03lkLuaTVmPT8DulAymksN0b9dHzmfdIB
   S6KAVu9DYqt8jkH9Ms6mW1FFkmDG8yipggDTXOKwPaIAN3mkTbqwQLaqR
   SsoTIRUByLz/ZO6XM2sXo8aU6jtrHPa0nWeEaSAEOme5sDt9zHznJQiDw
   FKmNjCm1yWmrSMvB0kUvr4CoF5XXfh+152qvQSpmx3Kp5JeWdLSxm8x5Y
   ooHSrO0dM4M7jIaCdQ2RNBLItu+Frnc0GXQEdiusmEQalMak8sNPY6agU
   VgbdLq30MwWD416wfMkCtuF7a/oo9Qy0hzPg0Ld8iEeYXUS2jm1t4nJ1f
   g==;
From:   Jiri Valek - 2N <jiriv@axis.com>
To:     <jiriv@axis.com>
CC:     <devicetree@vger.kernel.org>, <dmitry.torokhov@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 1/2] dt-bindings: input: microchip,cap11xx: add cap1203, cap1293 and cap1298
Date:   Wed, 4 Jan 2023 14:59:50 +0100
Message-ID: <20230104135951.930783-2-jiriv@axis.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230104135951.930783-1-jiriv@axis.com>
References: <20230103134105.736346-3-jiriv@axis.com>
 <20230104135951.930783-1-jiriv@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail05w.axis.com (10.20.40.11) To se-mail03w.axis.com
 (10.20.40.9)
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for cap1203, cap1293 and cap1298.

Signed-off-by: Jiri Valek - 2N <jiriv@axis.com>
---
 Documentation/devicetree/bindings/input/microchip,cap11xx.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
index 67d4d8f86a2d..08ca993b94c4 100644
--- a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
+++ b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
@@ -20,6 +20,9 @@ properties:
       - microchip,cap1126
       - microchip,cap1188
       - microchip,cap1206
+      - microchip,cap1203
+      - microchip,cap1293
+      - microchip,cap1298
 
   reg:
     maxItems: 1
-- 
2.25.1

