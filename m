Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0EA65C104
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 14:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbjACNmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 08:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjACNmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 08:42:47 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2315110FF3;
        Tue,  3 Jan 2023 05:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1672753367;
  x=1704289367;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l5bZsXUcGNYMik0vfIYtBBpU340uhdhRP1oUa6rsGbs=;
  b=CUyijV7zsBn2WjZ08Gz6ltr0WBfbK6SKNc0YfwzBp+eIXqFrmlhaiayV
   8ASy3W2LgyJzgV0tmvqJ512yLkBHHZxWOmqqDYNcXeXXmQM6D1EeQIeZD
   cVjRkEVro4075YHqOHtDT5Nn1uxvsaDVMXuhEAvHBgDMWE8D/XJLhr5zV
   eeIuT7/HE39cWV3wArsUsHquAQWMYR6IpbZzD0oMadTEhl2euYZ5zVk9v
   uNiJmLnAOPmdGrEVMChBR/+GAFiQ/8m4dVHhp7xtIRjS+jplz+IZpYauh
   1Qfu0E9eWE+IVZJq9icArguSZhRgIqEC7+8NPDP8GuVeO7LnGB/By65nP
   Q==;
From:   Jiri Valek - 2N <jiriv@axis.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Jiri Valek - 2N <jiriv@axis.com>, Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." 
        <linux-input@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: input: microchip,cap11xx: add cap1203, cap1293 and cap1298
Date:   Tue, 3 Jan 2023 14:41:04 +0100
Message-ID: <20230103134105.736346-2-jiriv@axis.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230103134105.736346-1-jiriv@axis.com>
References: <20230103134105.736346-1-jiriv@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail03w.axis.com
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

