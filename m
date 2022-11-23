Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC60635CDF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 13:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237628AbiKWM3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 07:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237224AbiKWM24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 07:28:56 -0500
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEA523BF5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 04:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1669206461; x=1671798461;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EJGHdb5kUSy4eZ7uaihRWaAL5/Unjj0zF+phb9X5lU0=;
        b=CT7yxG1oomj1RvuJUxvTG/xzzUACe5RqviJkHDZSyR8Q27omCWI5DSU9HOS7toyQ
        SqpGRGaFR6lENnDpKpwtwZO4ALCTxIUdHuY/uIbBVED/Cr1UTV99Qw5pGAXQy1oQ
        MWTZ97bpvkCiaJava9pF8ndqhL7pA3qszhK5mfSSB3M=;
X-AuditID: ac14000a-833f270000003940-4b-637e11bd6ede
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 50.03.14656.DB11E736; Wed, 23 Nov 2022 13:27:41 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 23 Nov
 2022 13:27:41 +0100
From:   Wadim Egorov <w.egorov@phytec.de>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: arm: ti: Add bindings for PHYTEC AM64x based hardware
Date:   Wed, 23 Nov 2022 13:27:31 +0100
Message-ID: <20221123122732.3864641-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsWyRpKBR3evYF2ywZspShbzj5xjtVj+eTa7
        Rd+Lh8wWmx5fY7W4vGsOm8WbH2eZLFr3HmG3+H/2A7sDh8emVZ1sHneu7WHz2Lyk3uP4je1M
        Hp83yQWwRnHZpKTmZJalFunbJXBltH+6xVSwjKOi/eI3pgbGg2xdjJwcEgImEve/vmQEsYUE
        FjNJ3Gq06WLkArKfMErsWXSOHSTBJqAucWfDN1YQW0QgS+LEoassIDazQInE3EkHmUFsYYEo
        iU+/T4ANZRFQlXjQ8wxsKK+ApcSJNftYIZbJS8y89J0dIi4ocXLmE6g58hLNW2czQ9gSEgdf
        vGCGOEhe4sWl5SwwvdPOvWaGsEMltn7ZzjSBUWAWklGzkIyahWTUAkbmVYxCuZnJ2alFmdl6
        BRmVJanJeimpmxhBYS7CwLWDsW+OxyFGJg7GQ4wSHMxKIrz1njXJQrwpiZVVqUX58UWlOanF
        hxilOViUxHnv9zAlCgmkJ5akZqemFqQWwWSZODilGhgTWT6y9gfYudzZpu606myv/ur6Jr3V
        M08eWHb5Sf73tNjO8l83PPzPJdkvDJ5zco+B8ulZ55KXlQlvTNjQ1yr7dr5+y5/ru7+lMC9b
        Zh17kzk9WEzia57SdTbWmnOHJjbkuZS2m8sz7Dzh7t9ucoXvzTaf58flO37XPp4h2Hzq78oX
        6zqcpskpsRRnJBpqMRcVJwIASGpShGECAAA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings for AM64x based phyCORE-AM64 SoM
and phyBOARD-Electra RDK.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v3: No changes
v2:
  - Add Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 28b8232e1c5b..2b9c045e39bf 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -38,6 +38,12 @@ properties:
               - ti,am642-sk
           - const: ti,am642
 
+      - description: K3 AM642 SoC PHYTEC phyBOARD-Electra
+        items:
+          - const: phytec,am642-phyboard-electra-rdk
+          - const: phytec,am64-phycore-som
+          - const: ti,am642
+
       - description: K3 AM654 SoC
         items:
           - enum:
-- 
2.34.1

