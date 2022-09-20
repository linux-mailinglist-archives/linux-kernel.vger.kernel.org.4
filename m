Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470B75BE991
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiITPEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiITPDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:03:55 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BFC371B2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:03:52 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e16so4765342wrx.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=u7lzZcB+wCTOpq/I4J4b3D9MEs3lpsunTG7mgG7CDRI=;
        b=pZ6EiFLPNl8e6/H0Au0y+MFbYIanGZLwXXbLCQeDIQd1XlsPpReAgXodzTcYuT61Aa
         89zzyJrGM1So1I3uZXgPgsoL53xHWUsa8nke7jyJjO2S2Fl/Tfa0JoBGJbe10ujXTy2k
         myFsTLnqt03KF5BNomb9iFIqvAe4dlBWsdagiF/Vb3ujI9X0v+wJXEc2gbg9pZAeJ749
         rwziamgDGIcBsNEf+fdsq2/41S+l/koemt/xk+6/1HB3Ie1mdjwgzIEzjMlLMyvZo7zI
         0EiFuO4Tt5w3QkwGA3VU9eTOAntFo7p2CipZVzgW+7l9UtqX6ByT9SYUKfFjnoD0uKCn
         xHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=u7lzZcB+wCTOpq/I4J4b3D9MEs3lpsunTG7mgG7CDRI=;
        b=yZ3C0iWnXqJhxrh8dMfA31K5IYLcmFxcTwKxL2XNs+Tg+tGc+F/GAMVDPtwAjJNAq2
         o6T7o45Gy4tkEggXhjjKkYMpdkv+Us/e0lMo05mG/NOsEUFVcJo0uYHJJyXKB5MwdURG
         2cYNhuO0usJBiWpb5IKYwZsFPjopRQbDNrB2R58U0xInTv9tr/sB3b03PhaxWAP+chUP
         +9mL2sVHRNm0I37AfcwML9jD0/m2KcQdSaCytPusTdxXKDaP3EoCrAnHpWd3Rnkvrn5Y
         8BnqQUBr+PCLVTX1UZP5XuXCv6jDnW/o6LDOA2AvP1UsE7CfmQHvpByDdecQLmzubk3m
         pGCQ==
X-Gm-Message-State: ACrzQf1ewqZl+6BBdGqUMwyPJ1n2es6+zFV63sSKZXWg4hP18hkjU8+A
        NvnT1WxemR5It7WTqv9P6N/SPQ==
X-Google-Smtp-Source: AMsMyM4FjLTURV4Dt0OgXUCHHJVpnZfgXmsFGwBQXoynQ3Novbcx7O0gpXHOBrzgjoeWWrmAN/7EVw==
X-Received: by 2002:a5d:47c3:0:b0:22b:ac9:92e with SMTP id o3-20020a5d47c3000000b0022b0ac9092emr5164232wrc.376.1663686231003;
        Tue, 20 Sep 2022 08:03:51 -0700 (PDT)
Received: from [127.0.1.1] (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.googlemail.com with ESMTPSA id u3-20020a5d4683000000b00225239d9265sm242056wrq.74.2022.09.20.08.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 08:03:50 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Date:   Tue, 20 Sep 2022 17:03:48 +0200
Subject: [PATCH v5 1/4] dt-bindings: thermal: mediatek: add binding documentation for
 MT8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-i350-thermal-up-v5-1-123bc852d199@baylibre.com>
References: <20220920-i350-thermal-up-v5-0-123bc852d199@baylibre.com>
In-Reply-To: <20220920-i350-thermal-up-v5-0-123bc852d199@baylibre.com>
To:     Amit Kucheria <amitk@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-pm@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Kao <michael.kao@mediatek.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.10.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1663686228; l=1160;
 i=aouledameur@baylibre.com; s=20220920; h=from:subject:message-id;
 bh=Ub01dL5lJO3HNAW69Ya4ycDE389//wyHtwywY+gaBdc=;
 b=74IdXWfel2MH3YMf/5GSvjnaUPFZaWOdAfv1u1EwWpISTYhcQ2znV5BZFo+6oRG+qqDuslWg7tTs
 7M5ta8gcAZgPrbqwIfS95/tp8jcOcwL48HVgbtTrQygMBOSnE613
X-Developer-Key: i=aouledameur@baylibre.com; a=ed25519;
 pk=HgYWawSL4qLGPx+RzJ+Cuu+V8Pi/KQnDDm1wjWPMOFE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
b4 0.10.0
