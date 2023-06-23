Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFB073BF50
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 22:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjFWUP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 16:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjFWUPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 16:15:48 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA332965;
        Fri, 23 Jun 2023 13:15:29 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35NKFLmQ049624;
        Fri, 23 Jun 2023 15:15:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1687551321;
        bh=modFvE2h1DtwfgwB1z6fh3ME+v61moS7YUn47wZZlUs=;
        h=From:To:CC:Subject:Date;
        b=Ox+UfwfBfvz2jcb9S0LtkdlHNiSftanMGWlvkxMcss+U9Olcp07cjjOJJ1SECdK5e
         QxTZ1+Me/YKlRATKF+frtFR54GrTVsfb5cfbDb7HjNSMARqmlfOY5i0fnbqmr6/695
         8+tNpazlL4gkJYylZHVJ8G+58GXmwMCeATPWERjE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35NKFLiK031898
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Jun 2023 15:15:21 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 Jun 2023 15:15:20 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 Jun 2023 15:15:20 -0500
Received: from fllv0040.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35NKFKrX016024;
        Fri, 23 Jun 2023 15:15:20 -0500
From:   Andrew Davis <afd@ti.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH] dt-bindings: mfd: ti,j721e-system-controller: Remove syscon from example
Date:   Fri, 23 Jun 2023 15:15:19 -0500
Message-ID: <20230623201519.194269-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binding for ti,am654-ehrpwm-tbclk was updated to remove the syscon
compatible hint. Remove the same from the example in this binding.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 .../devicetree/bindings/mfd/ti,j721e-system-controller.yaml     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
index 0c98d913747bb..e6289fbe69070 100644
--- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
@@ -101,7 +101,7 @@ examples:
         };
 
         clock-controller@4140 {
-            compatible = "ti,am654-ehrpwm-tbclk", "syscon";
+            compatible = "ti,am654-ehrpwm-tbclk";
             reg = <0x4140 0x18>;
             #clock-cells = <1>;
         };
-- 
2.39.2

