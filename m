Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9226C4ADA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjCVMkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjCVMkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:40:02 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9B24D603;
        Wed, 22 Mar 2023 05:39:59 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32MCdj3d089800;
        Wed, 22 Mar 2023 07:39:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679488785;
        bh=f5QRQeUeazx0dofpVGNmcI1tCS5Xgk/ldnpJD9MahC8=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=JL6lRQamOiabfejmh+XKaeRoH2ARs8npgZjKtSPKTjNVIxMf3P/XKbwkwNU4ZwIbp
         Sk/pTcEAeqCAIfKBRAQaP8otCkHHH5E2MJuMnmGsdvPyQXe4OipOJVUHiU+pk82Kin
         I3biczuKwdmuA7ZkvO+SPYBslBayv87cYR2km8qc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32MCdj8u066259
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Mar 2023 07:39:45 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 22
 Mar 2023 07:39:45 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 22 Mar 2023 07:39:45 -0500
Received: from [127.0.1.1] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32MCdcnY098356;
        Wed, 22 Mar 2023 07:39:42 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
Date:   Wed, 22 Mar 2023 18:09:20 +0530
Subject: [PATCH v2 1/3] dt-bindings: arm: ti: k3: Add compatible for AM62x
 LP SK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230321-am62-lp-sk-v2-1-0a56e1694804@ti.com>
References: <20230321-am62-lp-sk-v2-0-0a56e1694804@ti.com>
In-Reply-To: <20230321-am62-lp-sk-v2-0-0a56e1694804@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        "Tero Kristo" <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lore.kernel.org/r/20230320051304.2730692-1-vigneshr@ti.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for AM62x SoC based Low Power Starter Kit board[1]

[1] https://www.ti.com/tool/SK-AM62-LP

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index a60a4065caa8..56e5747c066c 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -29,6 +29,7 @@ properties:
         items:
           - enum:
               - ti,am625-sk
+              - ti,am62-lp-sk
           - const: ti,am625
 
       - description: K3 AM642 SoC

-- 
2.40.0

