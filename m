Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F15633AF5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 12:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbiKVLOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 06:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbiKVLNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:13:24 -0500
Received: from mx2.securetransport.de (mx2.securetransport.de [IPv6:2a03:4000:13:6c7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BAEA15A05;
        Tue, 22 Nov 2022 03:13:19 -0800 (PST)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.securetransport.de (Postfix) with ESMTPSA id E08B95E973;
        Tue, 22 Nov 2022 12:12:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1669115561;
        bh=E5rcQ8i8Nv0jd3ZCKpMwbFuP+IDytTQYVBhmzFtWaMo=;
        h=From:To:CC:Subject:Date:From;
        b=QgzcDV+jhGdEKBJ+Xm1I24Sb4f0CDkg8wKWAWtmOsgC89sUPqeCAvDhHGZXwoz+3h
         Xy1BkMWuxAwP8Sn0hPfjoHN3KKCbORThlzwfxgaCLMBZ4d7aUlqdGBVbsgmE90Mthl
         IDsC2RJuaWdCJfW5sjrO3DcDVk6nTiQVRbuRBmLad9m7x9OjOwM+U+uyICCgNBzTuM
         Aw0kNIR2pYzdouo0OBGZYXbyYBVky5VKhrK6aIO7DrDVqCtsnlBaSoGMUrxSMoyx/s
         4jdhPBsHcznV2LYNYKDkzH3ZX2NDNOm7EPijsV8kQK5n+6KTPHmSkHyK8osBJXyJKu
         fi290OvnmWaHg==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Tue, 22 Nov 2022 12:12:34 +0100
Received: from localhost.localdomain (172.16.51.2) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20 via Frontend Transport; Tue, 22 Nov 2022 12:12:33 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Marek Vasut <marex@denx.de>, <kernel@dh-electronics.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH] dt-bindings: leds: Mark label property as deprecated
Date:   Tue, 22 Nov 2022 12:11:22 +0100
Message-ID: <20221122111124.6828-1-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark the label property as deprecated as it is mentioned
in the description.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Marek Vasut <marex@denx.de>
Cc: kernel@dh-electronics.com
Cc: linux-leds@vger.kernel.org
Cc: devicetree@vger.kernel.org
To: linux-kernel@vger.kernel.org
---
 Documentation/devicetree/bindings/leds/common.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documentation/devicetree/bindings/leds/common.yaml
index f5c57a580078..c1ce846f7676 100644
--- a/Documentation/devicetree/bindings/leds/common.yaml
+++ b/Documentation/devicetree/bindings/leds/common.yaml
@@ -52,6 +52,7 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
 
   label:
+    deprecated: true
     description:
       The label for this LED. If omitted, the label is taken from the node name
       (excluding the unit address). It has to uniquely identify a device, i.e.
-- 
2.11.0

