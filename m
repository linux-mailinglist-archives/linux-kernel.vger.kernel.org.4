Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F91C70D489
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbjEWHHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235326AbjEWHHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:07:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CFA11A;
        Tue, 23 May 2023 00:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684825632; x=1716361632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TcBeQK6Tf98c5uXQUFLhT2ji2xx5syQauzWLk80skvc=;
  b=RjCtvac2d9oJWxVm45oCWpGMvJBfQDaB3qppn+xHiRTYB5BvyA22vlF9
   suHQOkRraBhMDV4dZ7wOkIx0nr0YqHZBT+NhNZzBjHnH1Fy0MI7We9yDD
   JPBFFKLwvGTYoufYX1zk9GgR4C4vzioUI85xADmLwwEQOepppoISIHp9I
   7yf9SGWzbL60WJVW85he1ChsBkeqe/+5xWUXXYDivCaw3uCnZWLEsHEb7
   dKhJoPNTrx37+9iMZYJ3kuABovkJ+b4F5fvS7eXYpUUlQsBz2FRnJPqMq
   TV6jQkEnRnXHh+d3NzeZg9svZvCKqztZx7vFLotTPx9SRIGusPQEJYIFr
   g==;
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="153442787"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 May 2023 00:07:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 23 May 2023 00:07:11 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 23 May 2023 00:07:08 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/2] dt-bindings: interrupt-controller: microchip,sama7g5-eic: use proper naming syntax
Date:   Tue, 23 May 2023 10:06:36 +0300
Message-ID: <20230523070637.224476-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523070637.224476-1-claudiu.beznea@microchip.com>
References: <20230523070637.224476-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the following syntax for Microchip EIC YAML file: vendor,device.yaml.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 .../{microchip,eic.yaml => microchip,sama7g5-eic.yaml}          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/interrupt-controller/{microchip,eic.yaml => microchip,sama7g5-eic.yaml} (98%)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/microchip,eic.yaml b/Documentation/devicetree/bindings/interrupt-controller/microchip,sama7g5-eic.yaml
similarity index 98%
rename from Documentation/devicetree/bindings/interrupt-controller/microchip,eic.yaml
rename to Documentation/devicetree/bindings/interrupt-controller/microchip,sama7g5-eic.yaml
index 50003880ee6f..d56ba65b17d1 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/microchip,eic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/microchip,sama7g5-eic.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/interrupt-controller/microchip,eic.yaml#
+$id: http://devicetree.org/schemas/interrupt-controller/microchip,sama7g5-eic.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Microchip External Interrupt Controller
-- 
2.34.1

