Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C087405DA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 23:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjF0Vqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 17:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjF0Vq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 17:46:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB3E272D;
        Tue, 27 Jun 2023 14:46:27 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6AD66660716B;
        Tue, 27 Jun 2023 22:46:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687902385;
        bh=Ud2ruCQMrs0y4/oeVi64N6XaZrL6MD3Lu7ndY/b2YiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OX4G7uSaFVf1Rp+S5iCmBZuljKzbtG39+f4Fu4sgj7vuOZ7zbTVP7mIOXjSiMkzkx
         KnTEnsqh7eKb7K1um2WAEez1k6/QVYbHo+OMfYILQnycfc5DrPJLt7Nbjx6C0E5fwR
         t5ADZ0wYP8AvqGKNNINOQxQPSD4Z4Elyv+MHgyuoqr3FrkgkcqSc8twxoX0cHzwKKz
         /crOOTx+3AnC3X2hajK3C8lWRr1o73oTf6aNm7EkGpWn3+MhEJYrvFFZFsdTDPvmXu
         NCaH3PGvFIPxu2pqu4Spj9YLyK3Oj/fb/qhZZNhYw6SLFf6bFIiO1mPLIJK9vlB4W/
         /656KnuIXCOfQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 1/7] media: dt-bindings: mediatek,vcodec: Allow single clock for mt8183
Date:   Tue, 27 Jun 2023 17:45:51 -0400
Message-ID: <20230627214615.1503901-2-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230627214615.1503901-1-nfraprado@collabora.com>
References: <20230627214615.1503901-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8173 and MT8183 have different clocks, and consequently clock-names.
Relax the number of clocks and set clock-names based on compatible.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

(no changes since v3)

Changes in v3:
- Reintroduced this commit from v1 since the active clock is no longer
  used.
- Further constrained clocks as suggested in v1.

 .../media/mediatek,vcodec-decoder.yaml        | 37 ++++++++++++++-----
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
index fad59b486d5d..1506d2693f7d 100644
--- a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
@@ -27,18 +27,12 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 1
     maxItems: 8
 
   clock-names:
-    items:
-      - const: vcodecpll
-      - const: univpll_d2
-      - const: clk_cci400_sel
-      - const: vdec_sel
-      - const: vdecpll
-      - const: vencpll
-      - const: venc_lt_sel
-      - const: vdec_bus_clk_src
+    minItems: 1
+    maxItems: 8
 
   assigned-clocks: true
 
@@ -88,6 +82,15 @@ allOf:
       required:
         - mediatek,scp
 
+      properties:
+        clocks:
+          minItems: 1
+          maxItems: 1
+
+        clock-names:
+          items:
+            - const: vdec
+
   - if:
       properties:
         compatible:
@@ -99,6 +102,22 @@ allOf:
       required:
         - mediatek,vpu
 
+      properties:
+        clocks:
+          minItems: 8
+          maxItems: 8
+
+        clock-names:
+          items:
+            - const: vcodecpll
+            - const: univpll_d2
+            - const: clk_cci400_sel
+            - const: vdec_sel
+            - const: vdecpll
+            - const: vencpll
+            - const: venc_lt_sel
+            - const: vdec_bus_clk_src
+
 additionalProperties: false
 
 examples:
-- 
2.41.0

