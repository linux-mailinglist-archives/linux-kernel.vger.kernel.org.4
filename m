Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62C36ADB64
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCGKHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCGKH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:07:28 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA4539290
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 02:07:25 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso6855167wmo.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 02:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678183643;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a99hADv24Oq3ePO/xWvEGujHuLCx8t+cyBnnFpp72io=;
        b=YSCUIcYocqMFAD+dkwuethgWjxG3R4uzFSWinK5RLr140QsCU9/Oe0rM5ZuaIhjjlZ
         vLkeaHOAcmuKVZ4jiUMD6z4xU/D3k31VgNAqaDG+ftVlNyRfytFVYE88oMwdz55UYkBc
         dPHaWmbI2+Hci/kGAvHYh+JEYcRcAsKBFMw9R3Q6xBp344epu5ycicCpYVNC11FzxRkg
         p+jb84OS2IF1+c1CY4XRBPNlCfoRoKIRoG9g2Km1pCYxgJDzkCVrjTIY1tKh404zn5mH
         mK7095HXFummUmioTMTIU0ZAMdx8D10VtV94aJ4rOQ1hih7MrXGvayUUYd6vLKQXjpgV
         mqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678183643;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a99hADv24Oq3ePO/xWvEGujHuLCx8t+cyBnnFpp72io=;
        b=woqFwpW7tVK2t9emJE8ilDeSAIOfQws3M7YDKjEyX6xLsNcNwSH+BtHaPkv5X+YjnZ
         toMrDbOMnkWx0T69irhvUnTRQ4Ck5GVkqXNMRrCC87UQJ72hvpZGYRxsfNTShkpomgTa
         SDlx+jIJcqZZ/55G262JpJcuvPiwc7Sz9Wpzi1XH1wbWp4tydmE06wEMbwsxV5uTBCf2
         vOuUN2phnb84xdvf4ixo/qUy+KVHgxCbSAkRkGYOJdgeZ4z9WGywZDLqX1fKQnecMrfj
         nkEKWDtWJW/5PEoFW7da6rOcv2JlHHZYpZOda/MwWRlk1PpLZLoHTIOfY2Uz20MHlp8z
         0D+w==
X-Gm-Message-State: AO0yUKUnrJvgKtaMFkLBCeU6FCfIUVC9cOoaHeI/0m0pt8mGdm0txLEU
        vdoJ6k29riKa5wZDyvrl1uvtlT5wQwoQrd0H+Fw=
X-Google-Smtp-Source: AK7set9LisboRMIbelSbZwB9/xid+f7oLBqZmrU5e7MBZwglzYbYVjzgLLCrOA+yg2thby9TmUO7ZQ==
X-Received: by 2002:a05:600c:4448:b0:3dc:18de:b20d with SMTP id v8-20020a05600c444800b003dc18deb20dmr12895539wmn.33.1678183643561;
        Tue, 07 Mar 2023 02:07:23 -0800 (PST)
Received: from [127.0.1.1] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id i16-20020a05600c355000b003dc4480df80sm18026288wmq.34.2023.03.07.02.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 02:07:23 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Tue, 07 Mar 2023 11:07:14 +0100
Subject: [PATCH v4] dt-bindings: display: mediatek: clean unnecessary item
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230306-ccorr-binding-fix-v4-0-117daea88efb@baylibre.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@gmail.com>
Cc:     Alexandre Mergnat <amergnat@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2628; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=G42YvKxkrZJb/teIAV/+HSCiQBvvc6k4e2mWKdkwM3Y=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkBwzaI++vi8o18d0x4WW7CSZlcGaJz7zBjybAHxbD
 0V0R9veJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZAcM2gAKCRArRkmdfjHUReLqD/
 4pmKEEHsKgsyphpRf2jTAS+qD61DtVytoGOcCZ4giSLMXJY928D5l57zSrlei1a8RnOoIlg1DGp5r4
 iPALGAhEz2FBWrvEb83xeukIb+2xHJiYXEmrNjh92YYVp4RuvlMBecTQHkElypf9zdRIOaerymRzgA
 98zV6VxYjO3A5Gqxm/G8YQVSvCFHBtWktRpco3h505EFQ40A6UilfZ14lqK+GhmZj07ueoaU8Mmo8D
 vn0yK59187hXXJqO2RdZ2P7zUtuJlq1we1SxMueoI+7EAOoQneokgl3UtJ722DUsYXpKzkcDeB5/lb
 /d6i1Cud3Xm2+RrpV2lKkbD3Yn8y/ycGJ5cOQGHFoApUCFhaxBiuOcfSscyoWvx+o8MN+9sCndHWin
 IqS5fZjGZ8Fez0VV4HicvFI/IXwsieGUAnV+LEJ06FVHTjN005Y8sDnbqqJlYCZcPa2VKv7ijuWaCy
 CzXs2P0a5mG0AOvR0mVFvn4DkW27zkRa6B0lcbe/rOPF0ELOTwHKyhUVWeqftAcmubptyOn+LJGxGh
 qNLzvBb3pZoNxVNp/K4Izf97hQ4+VFHgrOnyojV9D70keC/+sIdcXuB+u4XYEgBz9PQTx01SjvA8ny
 aAYYnop6rMjZIaoqrfxd2Zo2YfFPwqQAOrP3T7kJxtnPJloGNVPirysHrzHQ==
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

The item which have the mediatek,mt8192-disp-ccorr as const compatible
already exist above. Merge all compatibles which have the same fallback
under the same item.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
