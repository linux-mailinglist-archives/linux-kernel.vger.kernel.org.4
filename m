Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4452F740C3C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236758AbjF1JCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:02:23 -0400
Received: from mg.richtek.com ([220.130.44.152]:44342 "EHLO mg.richtek.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236443AbjF1Iri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:47:38 -0400
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTP Server V5.0(12336:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Wed, 28 Jun 2023 16:47:19 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Wed, 28 Jun
 2023 16:47:18 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Wed, 28 Jun 2023 16:47:18 +0800
From:   <cy_huang@richtek.com>
To:     <broonie@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <robh+dt@kernel.org>, <lgirdwood@gmail.com>,
        <cy_huang@richtek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] regulator: dt-bindings: rt5739: Add compatible for rt5733
Date:   Wed, 28 Jun 2023 16:47:16 +0800
Message-ID: <1687942037-14652-2-git-send-email-cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1687942037-14652-1-git-send-email-cy_huang@richtek.com>
References: <1687942037-14652-1-git-send-email-cy_huang@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add compatible string for rt5733.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 Documentation/devicetree/bindings/regulator/richtek,rt5739.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5739.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt5739.yaml
index 358297dd3fb7..e95e046e9ed6 100644
--- a/Documentation/devicetree/bindings/regulator/richtek,rt5739.yaml
+++ b/Documentation/devicetree/bindings/regulator/richtek,rt5739.yaml
@@ -21,6 +21,7 @@ allOf:
 properties:
   compatible:
     enum:
+      - richtek,rt5733
       - richtek,rt5739
 
   reg:
-- 
2.40.1

