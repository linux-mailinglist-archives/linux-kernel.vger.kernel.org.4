Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F7665D9D6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239682AbjADQaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239932AbjADQ3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:29:53 -0500
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8405833D48
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 08:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1672849790; x=1675441790;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=k2LNwpyqgnwIIWGpWIUItJTEja1sIrjCi/q5WAARKac=;
        b=sWevkYLAVb50w/ySo+rmRfErC1C/0LcVUDsiOZ6l1OwJN7HEOB23iFUS2LAu0KOY
        wX9hzlzdEqYhk3dNMJxoW212yVljMQdBvVIa9mSqPOdsk5nLKhVZvxYgf5qkzAu5
        VuuboeKfoZdLtP9w+Larh4dkmwCofmm9jWynOZKYzc8=;
X-AuditID: ac14000a-923ff70000007ecb-1e-63b5a97e2df4
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 9A.EC.32459.E79A5B36; Wed,  4 Jan 2023 17:29:50 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 4 Jan
 2023 17:29:50 +0100
From:   Wadim Egorov <w.egorov@phytec.de>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <upstream@lists.phytec.de>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <nm@ti.com>
Subject: [PATCH v4 1/2] dt-bindings: arm: ti: Add bindings for PHYTEC AM64x based hardware
Date:   Wed, 4 Jan 2023 17:29:26 +0100
Message-ID: <20230104162927.1215033-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsWyRpKBR7du5dZkgxUXlSzmHznHarH882x2
        i74XD5ktNj2+xmpxedccNos3P84yWbTuPcJu0f1O3eL/2Q/sDpwem1Z1snncubaHzWPzknqP
        /u4WVo/jN7YzeXzeJBfAFsVlk5Kak1mWWqRvl8CVcXz5euaCbRwVc+c9ZmtgPMvWxcjJISFg
        InFl32uWLkYuDiGBxUwS1/sPsEI4jxklnr38zghSxSagLnFnwzewhIhAG6PErDXXWEASzAIl
        EmuO32MHsYUFoiSeLtkGZrMIqEhM3badGcTmFbCU2HJzMtQ6eYmZl76zQ8QFJU7OfAI1R16i
        eetsZghbQuLgixdgthBQ/MWl5SwwvdPOvWaGsEMljmxazTSBUWAWklGzkIyahWTUAkbmVYxC
        uZnJ2alFmdl6BRmVJanJeimpmxhBwS/CwLWDsW+OxyFGJg7GQ4wSHMxKIryTXmxKFuJNSays
        Si3Kjy8qzUktPsQozcGiJM57v4cpUUggPbEkNTs1tSC1CCbLxMEp1cDof2HWvEl5PQt//Nzz
        Zfcu9d01GmbP7Fn770ZG2/teXLSG0WyhQOyxq6YTtq2T9mY6oPar87ylocjnsD0XOItct+aK
        6c7qc3m1Mdqy4LuCE+OKQl6+kgM9e12m/rsVUCWadv/eHs/mY9Mu7750TGUZR2tuj/j2Y0pB
        87e8fuQv9XfStdypd69uUGIpzkg01GIuKk4EABdbY/RsAgAA
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
v4: No changes
v3: No changes
v2:
  - Add Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 203faab80142..c55e3fdb7b33 100644
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

