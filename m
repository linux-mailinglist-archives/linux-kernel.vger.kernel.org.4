Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAE96644CD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239087AbjAJPaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238978AbjAJP3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:29:47 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFDA2600;
        Tue, 10 Jan 2023 07:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1673364557;
  x=1704900557;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ptV5IHOY/La7i4wUvOUdZU50lH93aT6Wu4Eh8tHnM60=;
  b=fMOgR+Qt5xRyR1rQtWrO5MPlpvDqrWv9mUMgAN/imL85lysZ0Dh5bHDz
   9pVsIz3KfExT/P2BLQ0vFf8p2YEAO4Y+Iv0WmM86qOR/HqMfHLImYLQYH
   aEWthqEvTcE90DLWZXMkTfsQd4WiRCLwLfB9ZBeZ/hkbkfIUl+6cHBiIQ
   fhyihl2slJmTUyiJ0YdsXnekodqzjGZ7uoGzyNCh53IP47qDA+GOpT7tS
   +eeHNY71ADtT8YFFjqvwzDMnCZc+19x1f9cVHRHAwAS+BFe81nBsPXNcn
   qQ4Iyw4PPEHhBIYrMat+3Atr+LRxMr47W9x5rj7cHL1ZD9QLbQ0msFC2v
   Q==;
From:   Jiri Valek - 2N <jiriv@axis.com>
To:     <linux-input@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <dmitry.torokhov@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <u.kleine-koenig@pengutronix.de>, <jiriv@axis.com>
Subject: [PATCH v3 1/2] dt-bindings: input: microchip,cap11xx: add cap1203, cap1293 and cap1298
Date:   Tue, 10 Jan 2023 16:28:58 +0100
Message-ID: <20230110152859.295881-2-jiriv@axis.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230110152859.295881-1-jiriv@axis.com>
References: <20230110152859.295881-1-jiriv@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail07w.axis.com (10.20.40.13) To se-mail01w.axis.com
 (10.20.40.7)
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
No changes since v1

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

