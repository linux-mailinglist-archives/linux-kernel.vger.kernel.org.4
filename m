Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CD4621B6A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbiKHSGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbiKHSGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:06:06 -0500
X-Greylist: delayed 902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Nov 2022 10:06:01 PST
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C908554CC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 10:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1667929857; x=1670521857;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SPUAib5doCV+mvrwRccE4jwNreUFJ8EoGjQvNt+H0Tk=;
        b=DmyQt3hmEoFfPhoyKSnbPHRCI0iCEhk32XfFoXRtEmiz4/EcFM3EJGsV+G/RFg/k
        ohufL5l8XzNB3fpT8D26d8BPeobC3UPmueGorijNyKvTPWF3j9V4WFxz1nciXsnd
        bFO5Bg6nh7KqCVZy6pWRd/KDmLaGZW97xmUHEF/wSVI=;
X-AuditID: ac14000a-83bf370000003940-0b-636a97010b69
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 2F.C5.14656.1079A636; Tue,  8 Nov 2022 18:50:57 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Nov
 2022 18:50:57 +0100
From:   Wadim Egorov <w.egorov@phytec.de>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <upstream@phytec.de>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: arm: ti: Add bindings for PHYTEC AM64x based hardware
Date:   Tue, 8 Nov 2022 18:50:49 +0100
Message-ID: <20221108175050.285340-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsWyRpKBR5dxelayweMuA4v5R86xWiz/PJvd
        ou/FQ2aLTY+vsVpc3jWHzeLNj7NMFq17j7Bb/D/7gd2Bw2PTqk42jzvX9rB5bF5S73H8xnYm
        j8+b5AJYo7hsUlJzMstSi/TtErgyDp7vYC2YxlFx498j9gbGrWxdjJwcEgImEqs/X2IHsYUE
        FjNJrOl06mLkArIfM0pM6j/DApJgE1CXuLPhGyuILSKQJfFg7U52kCJmgS5GiYOTtjKBJIQF
        oiReb21h7GLk4GARUJGYessBJMwrYCHxZ/0pZohl8hIzL31nh4gLSpyc+QRsPjNQvHnrbGYI
        W0Li4IsXzBAHyUu8uLScBaZ32rnXUHNCJbZ+2c40gVFgFpJRs5CMmoVk1AJG5lWMQrmZydmp
        RZnZegUZlSWpyXopqZsYQWEuwsC1g7FvjschRiYOxkOMEhzMSiK8IjWZyUK8KYmVValF+fFF
        pTmpxYcYpTlYlMR57/cwJQoJpCeWpGanphakFsFkmTg4pRoYZ+kse8PHNyVe/0TDodhv63cF
        Xn/j2HZ+hvXWjDmvvZc/1JHU3+kr0/ApijX76iuWrQxfjp7Z2LF+oiL3Tr3vp9jWz5E66Vbk
        nH5Mzf3gQ83zhdM8erXUlid9dbkYcSh+XxCP720l83MNspkSpooSSi92bGWMXsa7PGlJ8fPc
        lP0pkwpddqq8UWIpzkg01GIuKk4EADtcw4ZhAgAA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

