Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4176C09EA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 06:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjCTFN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 01:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCTFNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 01:13:53 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BC6A5F2;
        Sun, 19 Mar 2023 22:13:51 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32K5Dj52123108;
        Mon, 20 Mar 2023 00:13:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679289225;
        bh=Wi3/I1AaX7DG7Bes1Nm62RnN5cblhkTJFAmz3pnEfQA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ZXH4EY8tZum/E+pwNELI9MOqFGtn4q5xltTAVNxc3vCLEuSUbm+j/XLetphzMzDZX
         sQYXQY1pkg+3NzHepKrSvHYEDEbhUCTa6vm1xbq36lyPLZFrjcdnJxJze1C/xzOGTY
         dkHS9+emBqkFcbVVbef9RBeqWo491j+McgM1etDA=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32K5Dj6O077497
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Mar 2023 00:13:45 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 20
 Mar 2023 00:13:45 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 20 Mar 2023 00:13:44 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32K5Ddsq046592;
        Mon, 20 Mar 2023 00:13:42 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] dt-bindings: arm: ti: k3: Add compatible for AM62x LP SK
Date:   Mon, 20 Mar 2023 10:43:02 +0530
Message-ID: <20230320051304.2730692-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230320051304.2730692-1-vigneshr@ti.com>
References: <20230320051304.2730692-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for AM62x SoC based Low Power Starter Kit board[1]

[1] https://www.ti.com/tool/SK-AM62-LP

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index a60a4065caa8..56fdd94bf899 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -29,6 +29,7 @@ properties:
         items:
           - enum:
               - ti,am625-sk
+              - ti,am62x-lp-sk
           - const: ti,am625
 
       - description: K3 AM642 SoC
-- 
2.40.0

