Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13865B308A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiIIHkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiIIHkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:40:21 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACFC12F218
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:36:29 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m3-20020a05600c3b0300b003a5e0557150so3119033wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 00:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=SBA5Xqva8ic7f5V6Esgp2+e9b0zEOXFed5sBgTSTFt4=;
        b=F4JIZZsLEbBIwtP/6ytVB148bSeusbnZgcYQhBUJknGtCAmFs8Rthjcmb/fSh602Tf
         LNECSMg4Dbqh3hugIRuDKeM8kYhIQznbrUdtco02ya7yEe7bOhk6V4dtAfsj6nCKyTnq
         KfNnw0tcztkYJlacX/ow8uA18iasLU58GzTxcuT8rOaaR2KmEC96ZBji0wgNjeA+fln0
         XBV+5rbYDCoZy48G36qRq1deIxgZVuOPlPX2gYCwmP6Anjggr9wGbURuPSMM6KstXVrR
         t314whH0KlmrBA6d1cYCnD35xmU9PfQfr0oWXvpyaeDnuR99D3ZSgENTNP8SOVVX0jxO
         VaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=SBA5Xqva8ic7f5V6Esgp2+e9b0zEOXFed5sBgTSTFt4=;
        b=4clcqNwf2NF/4gBYiHSvS/fvp/8acS1TF3HOn+iHlYevYvzBaIpzuOuY9+WxHLrDee
         MVXpdbwb+Dut+d39eCbDYni5+l68hJDYkjL7W8wnrJLKGR4yc5+VDew8Cs2HCtFZqpjO
         20FjpmOY24UsS9HnpOUB3xgN/iF4RHyMTiYsWXInZb8dRz0ve/RlX7UIA7uRtteScIG7
         r/ObuL90vic+5X/BRECO/QbFiFG36WcIz++uPLlSYZwiidEOeD5vQuM1pR9l/B1wCh6y
         I5DNXCz7mmVtXzkC2OO+3dqBA3OtnPribubIvILEVkJrFUQc/C8x2SYu62GP3W+yFsTV
         AQTA==
X-Gm-Message-State: ACgBeo1BNYKGff1E7D2chZK/2YVO8mZTBvsNxYmAP2P6NHjeCAnGE71B
        f9IFnKm8uofOTj0VBoK8uEee9A==
X-Google-Smtp-Source: AA6agR5ibgbyV7k8sEkNeKh4P9/DH4nNCrCM4+I7tJ/E7l0hcZkbVFXtF+uml8bHhUkxmacNDH20KQ==
X-Received: by 2002:a1c:4c03:0:b0:3a5:d65c:c1e7 with SMTP id z3-20020a1c4c03000000b003a5d65cc1e7mr4674884wmf.4.1662708983953;
        Fri, 09 Sep 2022 00:36:23 -0700 (PDT)
Received: from amjad-ThinkPad-T490.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j5-20020a05600c1c0500b003a682354f63sm5345901wms.11.2022.09.09.00.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 00:36:23 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     matthias.bgg@gmail.com
Cc:     Fabien Parent <fparent@baylibre.com>, rafael@kernel.org,
        amitk@kernel.org, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        robh+dt@kernel.org, rui.zhang@intel.com,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/4] dt-bindings: thermal: mediatek: add binding documentation for MT8365 SoC
Date:   Fri,  9 Sep 2022 09:36:06 +0200
Message-Id: <20220909073609.32337-2-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220909073609.32337-1-aouledameur@baylibre.com>
References: <20220909073609.32337-1-aouledameur@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

Add the binding documentation for the thermal support on MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/thermal/mediatek-thermal.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
index 5c7e7bdd029a..ba4ebffeade4 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
@@ -14,6 +14,7 @@ Required properties:
   - "mediatek,mt2712-thermal" : For MT2712 family of SoCs
   - "mediatek,mt7622-thermal" : For MT7622 SoC
   - "mediatek,mt8183-thermal" : For MT8183 family of SoCs
+  - "mediatek,mt8365-thermal" : For MT8365 family of SoCs
   - "mediatek,mt8516-thermal", "mediatek,mt2701-thermal : For MT8516 family of SoCs
 - reg: Address range of the thermal controller
 - interrupts: IRQ for the thermal controller
-- 
2.37.3

