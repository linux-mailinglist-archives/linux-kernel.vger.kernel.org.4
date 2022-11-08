Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACBF621C30
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbiKHSo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiKHSoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:44:16 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1591DA67
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 10:44:15 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id t1so9392734wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 10:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vlDqIjsLXTsLOVaB8vd3OkA5S2UoaPdLtsIDpj43x2c=;
        b=BYOCyO+bb2kdgFf+IQXnllPA8KG+ULOKr2u5pTzNlB19Lf3j40UG1RZijo7Y0/dzq/
         AF/aYrwiiIQaP6x1ELhtaWR9iD+iq5NQ4WKw+w1mWu7BMd/iGE/Oe6BSy+0sq2zMerak
         tKfhtNaasBcmEMbjNcQ+S202FCZ8DHMlSpAcFazGAs3Ztv0/k3CNF+sXyka79AFVN0Yb
         oODBPM2zMi7AM+sMh5oSCd9Snr5CJqFF0Az0yuneh4yvlmm5mA7UjNnPlZ/RAXttBKAw
         ehA3rPKyQ5e76hLebM3PW8ehPYNlVlIRJ1wEgXDn29f3frWeYEs8lUma3DWbj51RsnpH
         YQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlDqIjsLXTsLOVaB8vd3OkA5S2UoaPdLtsIDpj43x2c=;
        b=LCMvwOjQ3hdxO9kgm+6PEeMwkVUlwkT1u2ARXF5muQqBFK9t9P+5yHLzCPA7jF/Sfb
         quyWkS6yzsGATo29vjFEtHdWI0m2eLhmar1iIzESTI0165K175zmtDpnAkeq1fXR3LQW
         bVlhiTrRbZagXzvT5RqvNBQVrnxwnKiuRptbNiKUZIcIyLbSjHr6R/wwqR7mIeqPzPBF
         6PwsJOteIKMOEMB+UCCMd6CsPs3GJEGtKAFhQMHnrgr+OSOtJyYk4psaiP2BXdcVv5JL
         b/6V6lvX5486/B+3k+KQVepmVSZA+TB6oDJxjahHyCY7IBeQfHFtlj4IQ267znWuT4xv
         3NbA==
X-Gm-Message-State: ACrzQf3T+mLByBoraAXC+alRX/RPMoT83RRwbcFPREcdZJ8a8WjohuTZ
        ChuKLIJaTx29P+hmpOlBcJbYmg==
X-Google-Smtp-Source: AMsMyM58wAq1y+h8vVNYOMiF2ELmoU8hLvCu+Jchx0EIlxqBBtZMzUw41rs50l4rbL73f9+wR+N22w==
X-Received: by 2002:a05:600c:a0b:b0:3b4:f9a7:f79b with SMTP id z11-20020a05600c0a0b00b003b4f9a7f79bmr46623457wmp.99.1667933053693;
        Tue, 08 Nov 2022 10:44:13 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id m6-20020a05600c3b0600b003cf6c2f9513sm13564009wms.2.2022.11.08.10.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:44:12 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Tue, 08 Nov 2022 19:43:36 +0100
Subject: [PATCH v4 1/9] dt-bindings: input: mtk-pmic-keys: add binding for MT6357
 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mt6357-support-v4-1-5d2bb58e6087@baylibre.com>
References: <20221005-mt6357-support-v4-0-5d2bb58e6087@baylibre.com>
In-Reply-To: <20221005-mt6357-support-v4-0-5d2bb58e6087@baylibre.com>
To:     Fabien Parent <fabien.parent@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-leds@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-rtc@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1006; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=acIU37N8P1oQiEeAFVfuuIgjK7XT7A/zFtqy1fGJDhM=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjaqN66fYqgivLlb/uwv5YlVdM2vSdwHFMjBG7yoYS
 chbjgBeJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY2qjegAKCRArRkmdfjHURS8vD/
 9gWsBxvGWsnueLnh+8eZVcOIt9VpVXe/hbrY/M7yOPoesCPZrw9orB99mUw7w16iA5vi7QmlADzcCk
 XKCUdnEoSqJU0QQgq2pmaqt4T8G7eWPd9idhG6bOEAly6+/XkomG1VJBJoxO/Xsex9I+L3lsR8XQRe
 Ig8dka7HNNaOwYthiaU4zJlr91/+IdPlxjQTY6NC0N65rYpTGxDHzMlK5TuCcv71gU4+ekosVAedS9
 s1boIO2Gu2laFxKTo7yq15gXZnNgF2yvvCfh45yyvMoIDgP2nL9OOgS2FUDCPAtIs4q7hhNo0udrqt
 kroGhHXGsOpHQxVMDUhCgImaB1uF26RLrfTQ5Z+FAC5rcOL0eMSwVbzkyrLKvFoaarSMI5sFnmUi50
 6LcVB3ZaIgJF/9/fz25eiB86kv4iaVflcodnroQoab8g7EuxTEXyUydVl5RCqZS05gPtexK5viqfnL
 XbEI8dw/ofSgWVHKxQMryxjqPS/uK9b6i/aTBCUco5XMjXSzKHAiZ7497KyUapChIuKR8CiuYXlcYj
 BQSpgqHVt/ZE3Kbp4cZg1eChLbp1J71DpP3bhOw394Z0yE/8RK2Q4+noiTKJ1EsCY2oE8a0lNKAHNA
 vnSGkM/iJVQazBlpAQ9cp83Xrvq8Q0US1bYvss5JF/XX4lRPEI/xTe0gQZ/A==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

Add binding documentation for the PMIC keys on MT6357.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
index 2f72ec418415..037c3ae9f1c3 100644
--- a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
+++ b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
@@ -26,6 +26,7 @@ properties:
     enum:
       - mediatek,mt6323-keys
       - mediatek,mt6331-keys
+      - mediatek,mt6357-keys
       - mediatek,mt6358-keys
       - mediatek,mt6397-keys
 

-- 
b4 0.10.1
