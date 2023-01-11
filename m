Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA35665C36
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjAKNNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbjAKNNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:13:45 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB77C5FC7;
        Wed, 11 Jan 2023 05:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1673442824;
  x=1704978824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SWS9cwOFl8/W5+mGAybOlPrBLB2NvX4Cz+JU+4vBEu4=;
  b=cBdmE5NxUQqgfJaZO7bpCw0/edYt2SsoNLzDf61eIg9lHuVk7EkJM3kw
   9y8zYfZXnmpka1MwshXGuY1PaZYGX/v6AwqCvCdfGNCvHkVk8sBeaQIzH
   90PT8eV55j7cB/r7hl2GLQqf18zKd5+/cJcpk1NRsdNqX6gRUXUrQs0Xx
   DPWUUAok992fiJn/9y6+1KFXSPLmKS+MdFX/18gDUTDRhDiT23lwLDFkp
   JSS4/wmlopfbWv2MtZG/Yuk3FVJv0Z2YfiUX/b+dB8gQIPEfPyOHPwtSA
   VVsoGI0xr9Z5m26e1dhBsLvWNI19vEN4f1vY2SzYC9CefSkuNQQhXVBcd
   Q==;
From:   Jiri Valek - 2N <jiriv@axis.com>
To:     <linux-input@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <dmitry.torokhov@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <u.kleine-koenig@pengutronix.de>, <jiriv@axis.com>
Subject: [PATCH v4 1/2] dt-bindings: input: microchip,cap11xx: add cap1203, cap1293 and cap1298
Date:   Wed, 11 Jan 2023 14:11:10 +0100
Message-ID: <20230111131111.475270-2-jiriv@axis.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230111131111.475270-1-jiriv@axis.com>
References: <20230111131111.475270-1-jiriv@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail08w.axis.com (10.20.40.14) To se-mail01w.axis.com
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
Changes in v2:
  - No changes.
  
Changes in v3:
  - No changes.
  
Changes in v4
  - Model names sorted alphabetically.

 Documentation/devicetree/bindings/input/microchip,cap11xx.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
index 67d4d8f86a2d..5fa625b5c5fb 100644
--- a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
+++ b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
@@ -19,7 +19,10 @@ properties:
       - microchip,cap1106
       - microchip,cap1126
       - microchip,cap1188
+      - microchip,cap1203
       - microchip,cap1206
+      - microchip,cap1293
+      - microchip,cap1298
 
   reg:
     maxItems: 1
-- 
2.25.1

