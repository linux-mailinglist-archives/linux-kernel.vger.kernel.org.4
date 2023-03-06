Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860F36AC7A4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjCFQUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbjCFQUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:20:24 -0500
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F085038027
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 08:18:21 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id g3so40986156eda.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 08:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678119366;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e9niV0lDM32nqHqYgD5Iv+BIY49mmSBNqShco7CYbZ0=;
        b=7l6dijN1SxoxyfdVaf28yN2A4H8PFN9TLFpsI6hPiPiQl2zozrvl2sv+2WzHCSCQpL
         h08Zy2G7uf8A1sp4/NLO6Qj3oCSq4B5rvwH3hdIyMgmqYRLOcsUnpA5ScoycxdHo2eQg
         7AAc9r9HtATADNErnkJ7sZpe+MP6DyqTKAJk/eZLhPyoVV4/Mf5XvvsrGEHHEIRarTmQ
         xrRY24e3Mj+0UaClfTt89hBdKVKE4S0+MkWnMF3qZjKSP56KHUfLnumAhyfJtFdZNTbt
         tgPKBQcJ6SqFHJU57Ode24vvYMhmhj7vBPQEkafD9o/B8jJkoUUGi+WObszt8LDS7Okh
         SKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678119366;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e9niV0lDM32nqHqYgD5Iv+BIY49mmSBNqShco7CYbZ0=;
        b=sNlCh5fQ/WF8qeODBbpS7ANvmBmgz5J2nY+Dioi0HD0oP/DudDibkjt1oaHNB8LX+o
         aNmsnyXbzSyBiMCMUe95wDlPL/oNJxZ3FzZxU3sr0wn1No/te7MIhqwzWlRmHNwDcWeJ
         vPYj0cbkTrf4yYauvI0PEfiKBT79Db0apgV2Voct2HegO+J2qTx4Q0OtKASx0jXd24XF
         MOI7G9ey4UBtKfS/Dsw3GtxjBm780eTmY9t2ZIxH+JdjO5+w2fXtd36EFc8KGSFLJ90x
         d5X87PwsG3tQSR/KrRzJAM44UZMbpWoD0z3pbGmcOH741BSHwjD/Ff75kEas3n9UYGIf
         Asiw==
X-Gm-Message-State: AO0yUKW2n3P95ftowSgrFtrOfijWSQpLLW7zCUmYrmvB8+zm7zBeeKGZ
        F1SY28ZJpzS/fbsOlVrU/ki+fg==
X-Google-Smtp-Source: AK7set8UJgx+RtN6p8sM/0DeC3tPMU8VJqx5A4m0mRCX7TvoPE1tRwsLeEzWPyNIXYZdIXH4gkDKDQ==
X-Received: by 2002:a17:906:fe07:b0:8b1:7de3:cfaa with SMTP id wy7-20020a170906fe0700b008b17de3cfaamr15805736ejb.3.1678119366668;
        Mon, 06 Mar 2023 08:16:06 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f14-20020a1709067f8e00b008c16025b318sm4725074ejr.155.2023.03.06.08.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 08:16:06 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 06 Mar 2023 17:15:55 +0100
Subject: [PATCH v2] dt-bindings: display: mediatek: Fix the duplicated fallback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230306-ccorr-binding-fix-v2-0-4822939a837d@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2172; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=4agDtIQ77F9ME6yRsPUjLAJBlnLGzpQX4bZnM0RC0x4=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkBhHFIaq0Oa2uH87DGmClu+FpsQAsxEPqMLB5HFNL
 i3nTFg2JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZAYRxQAKCRArRkmdfjHURcHRD/
 9MhoXFudTD4tZBPgh+Gp2RJsoD30POoNUwZRp0mjM/CQzuvWbkSoEKVOfDsjD7vYeM87ZaWl9TsWVe
 qXA2y0Dk0P2KrnThxIOx4SEB3cnKapUKxkD7NeyxQ8x5JttdB98Vs+Ndrm8Le9b1yScoxwskgtnhgH
 AosTF9wPB6SM31tRkr9vsAiznTgv7uhKiCttF9Qq30jdy/nTonScrsWo56HDRRC7EZk/JtS7yYnn9r
 L1DTWPuk+jam1HcwBKWwQR3GZWazffHpuWYlkJ9LrjHmSjqjmNL6eBgXbhjhlVonskoOZmrNoUWlmj
 g+fDofLPIVYkxQFDIjpDHUDtqQzxIHIN7a50vIECNGUdFZsmo7X3kj+51ljXMxsGg8GN2obSwiSfwY
 azGs8OqIV5YOaCSX2eT5Ork2Ysufqo3Cqk8IgHKq5nFwWIDJ44untGuLwOf0m2o9fgePQUWRMIaU0G
 0B0hW0p+G6izKCRfhaWfZ1HglzG8WwpGq51n+TRy3o23OQAXMRKvstdtKSWS5vD0uyh/Mvxu9Mc4zi
 95TNB+K8CDf7GJi16s6r5V8+TGCr6banMuY0yFEfHOPqOVV+2Y7RbOBeIYKshj4qOkpW3xOk5my05i
 YP3VRVJQLGZcMYZyq8ChWV7/CTAyFr1zC9enBdQbzk/j8xO8zweMTd1DnI8Q==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Changes in v2:
- Fix commit title.
- Link to v1: https://lore.kernel.org/r/20230306-ccorr-binding-fix-v1-0-177d81d60c69@baylibre.com
---
 Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
index b04820c95b22..3aaf44719786 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
@@ -29,9 +29,6 @@ properties:
           - enum:
               - mediatek,mt8188-disp-ccorr
               - mediatek,mt8195-disp-ccorr
-          - const: mediatek,mt8192-disp-ccorr
-      - items:
-          - enum:
               - mediatek,mt8186-disp-ccorr
           - const: mediatek,mt8192-disp-ccorr
 

---
base-commit: add072536971d7ce891fde3cdbf68c55e7cfa95a
change-id: 20230306-ccorr-binding-fix-718c6d725088

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>
