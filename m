Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B328F6B1F57
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjCIJHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjCIJGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:06:51 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775DA268A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:06:11 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id e13so1101886wro.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 01:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678352770;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DWLXsrQU8r8iBGzoibkZ5OVm/pVG4g0LW7vlYuupzQ0=;
        b=c9DY57l6BH328f1T/IuGy3UGlMX08fdyv0xGGK71ceYc8K6OxMVs5U7DH6Ds/NteNr
         HLJt9zi9wkF+pZk9PY6jZB846V1M997sQ2np8mNY1siIPAIubeIKXImVEqZWq3yx2Jdz
         39U8oyTxDnBv6ZhHzgjpoIRHWlrXF0uV1TzTmuOR1gOsf2ib5T56EcRv6P24KrIqOy77
         XnImIlM+NT0QPv9dWHDT3XmNt8OhptXL20KveMaomIM8oBoR9LJjRggljwjSdfVJRg5t
         L4ZUGpofa5Gn444pQgTEmLW2bwoOJqStNUYHbW5DSPcqZ0mVZ0X61r3gvNxIDikUcLtI
         vEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678352770;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DWLXsrQU8r8iBGzoibkZ5OVm/pVG4g0LW7vlYuupzQ0=;
        b=PBzfkwClspSpBXtVa76fN1HPXJ33R2hOfSP4dyNY7a9q/Nza8MCC5JxE1jdlugN3jp
         klB4SdYb47Fcz+Y1IXplXmM71L7oOnJpQ4hQA1fheHz6exDyZdOlkJ3HjMhkxskVQyZ7
         7JyL0BLzqAsnKr/91gSa4TNoHsUpwxN3k3LRsAx0DWI5rYt5fABilzzc0QPE0k6HxV/e
         FHZ+EUrI2PgBkg5Re1+HSSfVnBO2C8JzW7gdgD3tyVxpjXnCYkTznbSgHtnCyBd9oM9g
         +fDXQ4YBeMmxgHIpL4/w/BtH0Tf64/kbXmxuGHZExWHIrOPigARzfSV+T/ytLAlHLyD6
         548g==
X-Gm-Message-State: AO0yUKXhbyXIjf4djA13yPFxwQXL43qLzvdT4hwB2iLehBeILEhC1dRS
        15zdEKUpsXzwMljPpdFJo9AJmA==
X-Google-Smtp-Source: AK7set/xWcQ3e6C8V9K1no/lYj82bJP03UJ98Zjsnfj7tf47EfzLA58Hl0ucNV55U1teahWwBS6hEA==
X-Received: by 2002:a5d:6148:0:b0:2c5:5335:73f3 with SMTP id y8-20020a5d6148000000b002c5533573f3mr18826708wrt.34.1678352769884;
        Thu, 09 Mar 2023 01:06:09 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id g11-20020a05600c310b00b003eb68bb61c8sm2073243wmo.3.2023.03.09.01.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 01:06:09 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 09 Mar 2023 10:06:02 +0100
Subject: [PATCH v5] dt-bindings: display: mediatek: clean unnecessary item
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230306-ccorr-binding-fix-v5-0-6c56aaecc3b1@baylibre.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>,
        linux-mediatek@lists.infradead.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2889; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=ane73DE2EH6XTssrtokRfjsFxb/F2uv7GT+5uVVvMaA=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkCaGACge7X0KLwuoqnZ4fw3r3jhLJMOt67yG9WGat
 LuOxaJuJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZAmhgAAKCRArRkmdfjHURVd7EA
 Czp7QiKLjtd5p68htZwWE4nDjor7AOsvtp3IS4KjRWv/VRtZrXJsy+RgqgCKe5cf0sGQSlHXgZvm2A
 Xg9ZwbC4WqVxgaDSQi8Ghgzcjg/nba7zSYTdMH6aChuWSUkPqDm/9MRkoNs+doS7ZAs7kwR6M+l9dz
 wnJsH686DmFkjzIRXxVbpTFSqlt0lCj4jzoO2WAsnz7CTslFXqLqSzmFtHaOLps1D5dWTdPHH/rcHZ
 UaNzDgSg7p3mKBJ8VJoMxLT9/FUDvursRQJ8Zox+wFSq8CL6ueKnsqjT18/SK7tyvLNIZ7zRngd0n9
 JMovt8IlYUhN2zmrAkXKH6skGQcKbteBFsKgUssRv7zflF+Hvonghl40mY7mbOs20b2g+ujmwQAOXB
 oYU7ybbe2IJewTR1XEXaEgHmABOyXh5ohHOMypvBe7jh3ZMsl5xacZe0MbZSsrTq+TTfi5Usv41Axa
 MKIfhfXUS6SChFwYNp+jTWY5rCwYFalQaLdh/0FOA3QT1VASQnEYV13WK+3qbF7wBo3bMtGzmSuh9x
 HJqU8GPrnfzkOXDaA2shnlVpNTfgOnbbVYqgc+dmExtZZkM/tWyUJx4IZU81fQ61BpuSyY/nAwsEor
 ap7GzUHFvcovcqTA1vSeUrkn46guO3pjI25vYVNDF27Nm7EsCZVflwUxcqBA==
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

The item which have the mediatek,mt8192-disp-ccorr as const compatible
already exist above. Merge all compatibles which have the same fallback
under the same item.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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
Changes in v5:
- Add trailers.
- Link to v4: https://lore.kernel.org/r/20230306-ccorr-binding-fix-v4-0-117daea88efb@baylibre.com

Changes in v4:
- Reword commit title and message.
- Link to v3: https://lore.kernel.org/r/20230306-ccorr-binding-fix-v3-0-7877613a35cb@baylibre.com

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
