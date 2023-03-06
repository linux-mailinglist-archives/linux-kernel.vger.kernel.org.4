Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C226AC7CA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCFQX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjCFQX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:23:29 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE276A6A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 08:22:05 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id i34so40935215eda.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 08:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678119652;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eoT4nVEHPLKYoD5WLwLRDEbDFsrUlZVmGeWjEVeiTO8=;
        b=hzaQi41EnB8iABJhplSxLHLE4++NFbzDr/VciMZtMLgj4V9v5rJv60byErPcqO3CHA
         AHdDgnfs2Tt1F7NP2DRvbFBinSBdCDE84+bOfFCd8vdI0RWZ6iuwmXfnHK58hQWRZlAT
         ZHXH+TG9yOaVfcy3n7hSuXNNO4yFvz3xc2WdzV7HjICEvn5H1FSo6jB7t7D3HTdLjnBP
         MZ9KgxfeUJW/r/NByt57ijJ0HtndMv4upH32ZzSzmKP0LxXMO+BJB1gwR41h41HQTvvj
         Jqif1z+XaBFuw30n5Dh7r6C8ZP9blX1BkA/NQJXOZU/mW/Uq+l9F1VkWZQHU03GaABRw
         ygsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678119652;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eoT4nVEHPLKYoD5WLwLRDEbDFsrUlZVmGeWjEVeiTO8=;
        b=PYwFsCTzUfEa9me2wjZcV/1Y9BrOQGFmSnpXMSNV2z+0+iKoL+7EZFOKnkmbOkjZSY
         qjjts+bpBrvqypp6QkHvYMPOZ3Jh2T+WTuDz2EVv/Mw2KIdWyq0r4FuzYhjjVregrxgY
         /Q5/psgfckZvYG56xAPfFsOfSecOtRy9jQjPzky+dlqOuDLSM9KnB1UQ5oDTgyQyqIwL
         KHwWdaq9Kg18njJX2izkqJpQDqfZQ0PToA556Msy7kK0X9HV9mC0FonSN3YxoNwegto7
         gPwX4e5dougmzq5UcOyKFw5MzXgstlegawuBSY+JcTiQjp60w2S/CX29EAvY65X4bCmJ
         RkmQ==
X-Gm-Message-State: AO0yUKWBqPZhQo8EunxcM6URYBqnkbqtOhHIxZIOQ1Y/KJGhkCiEU+73
        +8IaCgAOQpOlch2LsK3UECEt6wPk/zZTsQtRcSo=
X-Google-Smtp-Source: AK7set8fuuLFOKxeQmjjgaTKE54Up+U1LGn/33b2wjrGTQyYcWBdlhu7QcX/T1JDWTzBC9tsOQFJ6A==
X-Received: by 2002:a17:907:98d2:b0:8af:54d0:181d with SMTP id kd18-20020a17090798d200b008af54d0181dmr9691625ejc.35.1678119651865;
        Mon, 06 Mar 2023 08:20:51 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id e22-20020a170906081600b008d1693c212csm4722340ejd.8.2023.03.06.08.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 08:20:51 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 06 Mar 2023 17:20:45 +0100
Subject: [PATCH v3] dt-bindings: display: mediatek: Fix the duplicated fallback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230306-ccorr-binding-fix-v3-0-7877613a35cb@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        linux-mediatek@lists.infradead.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2468; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=23T/1fFc4VnkKyoBRTW6JwY1WrACxyhmLzCmzLaQ6ZE=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkBhLiP81CAammTNgGV2PesxvLj3jcDfR/OozCuUj8
 nfi703eJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZAYS4gAKCRArRkmdfjHURX2hEA
 CkW6J8DMjJc7a8ghMZ9f7DqlbjoFNsCh/PWv61+0EE0dw3V6Z07qe374M2dlsBJRvwdr/qWrktmwGx
 /ByZVgYUjAhDrRHYse5JVGh5hKhUWx3HHywgo/fuWjrFxRdsak+7Zsm3JJ121m6DXUurQ3mA7FlKez
 S6IImcHWq9A56o8ZCyahNR0mR0TaqNbLiTnyBVmWpfZCkTl31Vu3Xj43hUUJeck4z0+wQfEcVR01b3
 O/2OV/zTCnBIDq+7xmEl4BG/JrYf7REEINpAztmeP6FV2OYMmRO3XEPZJSWNpnf8Ruu0SgZJ/5ChOk
 9Sp5ITaqUe1sBPVffaJe8VKXzH+A/IRMWfluznGgxHiirKm8SAesgNrmEQw86kye6yA2+GgwafxGyn
 nrRR5tFCZ8t4DaEiwSctd/jKi03teV+siW5YjIxrPO8P3/UpXkziM67kxpn8dxGNuMSj5KROduuqcj
 lCVgZOXPYRMcxA/Ulwq1aZmz0d3xN95k5//2LRRX4I4kWIi7BAr8eOCZQ6Fsk8WBVaSBGd090gmgV+
 pZYfE1h+iSREvn7+8BNGGtrhKKvyDS45bBV/5S26YScGxFA+Ki5j2WIQGslDHMdif3WixWLtlI0i9X
 AGby2/S/Z3KbE/rBRhj+pbMdINRMv0J/yEionIt5zHRUzdQFBnyfXOgpTjow==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The item which have the mediatek,mt8192-disp-ccorr const compatible already
exist above. Remove duplicated fallback.

Fixes: 137272ef1b0f ("dt-bindings: display: mediatek: Fix the fallback for mediatek,mt8186-disp-ccorr")
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
Fix MTK color correction binding

The fallback compatible has been duplicated in the 137272ef1b0f commit.

To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
To: David Airlie <airlied@gmail.com>
To: Daniel Vetter <daniel@ffwll.ch>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc: Rob Herring <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-mediatek@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
Changes in v3:
- Re-order compatible.
- Link to v2: https://lore.kernel.org/r/20230306-ccorr-binding-fix-v2-0-4822939a837d@baylibre.com

Changes in v2:
- Fix commit title.
- Link to v1: https://lore.kernel.org/r/20230306-ccorr-binding-fix-v1-0-177d81d60c69@baylibre.com
---
 .../devicetree/bindings/display/mediatek/mediatek,ccorr.yaml         | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
index b04820c95b22..bda86e6857f5 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
@@ -27,13 +27,10 @@ properties:
           - const: mediatek,mt8192-disp-ccorr
       - items:
           - enum:
+              - mediatek,mt8186-disp-ccorr
               - mediatek,mt8188-disp-ccorr
               - mediatek,mt8195-disp-ccorr
           - const: mediatek,mt8192-disp-ccorr
-      - items:
-          - enum:
-              - mediatek,mt8186-disp-ccorr
-          - const: mediatek,mt8192-disp-ccorr
 
   reg:
     maxItems: 1

---
base-commit: add072536971d7ce891fde3cdbf68c55e7cfa95a
change-id: 20230306-ccorr-binding-fix-718c6d725088

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>
