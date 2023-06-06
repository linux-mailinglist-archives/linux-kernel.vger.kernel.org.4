Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDB9724167
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237289AbjFFL6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237276AbjFFL6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:58:10 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F31E6B;
        Tue,  6 Jun 2023 04:58:08 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3569qXq2018383;
        Tue, 6 Jun 2023 13:57:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=rBpJCWbpPhct1VdjPG5ZyNaQxPKpgg62x6NbS5SPTUk=;
 b=0+DkH1J52yLp/iEd8xwNveK4OTDN94QIndvkef9TfmVjtNnccI6AoastqeQqqZECB2Hn
 mQCC7rq8G3a+iCRu4m6WXIxiWZ18DW7aS42dadwjBkc1eq9xX1CetsJ9wrcu3GKu/XUx
 3vedC1RynAmZ5XI3YC8Hl9XDSf/wAJ90+xjC26X0/Ts4RephC/s4hdhsXJLKUm7MF2J5
 fZaV+qWGOdbWvwCuJU8W3ymQT4PwjAzEBh5A7ipgk8gWz/4o7lIvODhoYerdOBdxD14q
 XmEeBFl5ju+sv7N7Od8BcgP3KMlElYULqETnT4dzu9r7155BzABEUzlSXpY6yjziwBdt 8w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r1yvnj5mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 13:57:45 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B159D100038;
        Tue,  6 Jun 2023 13:57:44 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A8D8621D3B3;
        Tue,  6 Jun 2023 13:57:44 +0200 (CEST)
Received: from localhost (10.201.20.178) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 6 Jun
 2023 13:57:44 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] ASoC: dt-bindings: stm32: document audio of graph port for i2s
Date:   Tue, 6 Jun 2023 13:56:02 +0200
Message-ID: <20230606115605.1633595-2-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230606115605.1633595-1-olivier.moysan@foss.st.com>
References: <20230606115605.1633595-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_08,2023-06-06_02,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When linking the STM32 I2S to another DAI component, according
to audio graph cards bindings, an OF graph port property is expected
in the node. Document the port property.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 .../devicetree/bindings/sound/st,stm32-i2s.yaml       | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml b/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
index a040d4d31412..b9111d375b93 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
@@ -61,6 +61,10 @@ properties:
     description: Configure the I2S device as MCLK clock provider.
     const: 0
 
+  port:
+    $ref: audio-graph-port.yaml#
+    unevaluatedProperties: false
+
 required:
   - compatible
   - "#sound-dai-cells"
@@ -89,6 +93,13 @@ examples:
         dma-names = "rx", "tx";
         pinctrl-names = "default";
         pinctrl-0 = <&i2s2_pins_a>;
+
+        /* assume audio-graph */
+        port {
+            codec_endpoint: endpoint {
+                remote-endpoint = <&codec_endpoint>;
+            };
+        };
     };
 
 ...
-- 
2.25.1

