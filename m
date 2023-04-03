Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBB66D512A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 21:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjDCTS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 15:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDCTS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 15:18:56 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48B926A1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 12:18:54 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b20so121551052edd.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 12:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680549533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bZSGEHV1wcF9QDw9X095419CyG9Yv6xnJ2egeD+2O1o=;
        b=LklJQBi7hsnfQA5KrRPllFlnLE/+fwiO4CR61oHAc7N1n+GjhMt19kI7yYcf4mWKZx
         ovEN6BtGWxjdFpBTVrtJERecaOcriMZlEVboCoqEcFaPJZ/zNoLKhUFzTivWRryVmRbJ
         lDIvn0kBqh0e3DEm7TOz072Dbc1B0T+QHLxzK4XbQhEnRKhO/cLQ2zcEt/NIhF0t3cdl
         kZRuzyaZTTZuCkkgMqF8j1htHmUKHhIEsWULDQD/v2fLBab0geReln5011mAJxQ+Vcn3
         RRBfWrEM8GN/dVPpxskCHBrhlmBWyZmjbKR9MPCCN4Hv0ZHDwfhKlZr5cYWFvNdm7CLs
         /+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680549533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZSGEHV1wcF9QDw9X095419CyG9Yv6xnJ2egeD+2O1o=;
        b=l2GeWmaIzkaWnaVb5HrFBSOQJg6zDWtbwzvl4Whgp7i4LcsK5mp1zlEvXnUXehIA4O
         NWG/xUG0k9eNgHGzYCn+9aRoxvXvMw3y02RFuKpTy/gyOGg1Uv+KJ0MB4miw05eY+Lfr
         9W00ZYQaOysVBIvGKJyw7FXL7mJtlbQD5iq+prHUkEOXx+vyNT8GqOmy9aJ925sbRoOa
         ieTBNYO3aHggLvcduLtxAcatWYrB2KytICNsIMbD8gYH6qFsH67ubePeIQnTJ6jIuJ+E
         2cHQm68j9OuyZtxqg2I5WxTGhKRFlGdcZ6VkRJnCe/PjorrQ81xIgrcJd3kYPJzq9nY8
         7DGw==
X-Gm-Message-State: AAQBX9eSwZy9fJSVLogolKKu0KI5a0a3EqoFvNqpWPebQARfW1flerkj
        H0M1lA3eF+meAADV/yHYVX0/Fw==
X-Google-Smtp-Source: AKy350ZQ8gkFRQMSmLb2vCdVeG/SCcQL8iLCV2k8kwWTOf+zZkhnJeiPAPfb4yy7X5429anR4EH5TA==
X-Received: by 2002:a05:6402:4403:b0:4af:6e08:319 with SMTP id y3-20020a056402440300b004af6e080319mr18475608eda.15.1680549533217;
        Mon, 03 Apr 2023 12:18:53 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:ae90:d80:1069:4805])
        by smtp.gmail.com with ESMTPSA id n19-20020a509353000000b004c09527d62dsm5022999eda.30.2023.04.03.12.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 12:18:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Roger Quadros <rogerq@kernel.org>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] dt-bindings: usb: mediatek,mtk-xhci: drop assigned-clocks
Date:   Mon,  3 Apr 2023 21:18:48 +0200
Message-Id: <20230403191850.374839-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The meta schema from DT schema already defines assigned-clocks, so there
is no need for device schema to mention it at all.  There are also no
benefits of having it here.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml        | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
index 556bedb96165..72639c6b4e1c 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
@@ -87,14 +87,6 @@ properties:
       - const: dma_ck
       - const: xhci_ck
 
-  assigned-clocks:
-    minItems: 1
-    maxItems: 5
-
-  assigned-clock-parents:
-    minItems: 1
-    maxItems: 5
-
   phys:
     description:
       List of all PHYs used on this HCD, it's better to keep PHYs in order
-- 
2.34.1

