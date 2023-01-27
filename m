Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E7D67E9E6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbjA0Ppy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbjA0Ppf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:45:35 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264F28716A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:45:18 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso5675909wmn.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SPsz6CoLNjPAxyd2ASpUS9AhmaiVkC3z8HgK93csZ1U=;
        b=0naiJqR3CXP1CSUH1JQR7KqPG5pckDblSfUbPNiY67L+/CLsqv4wi5V5lnThoQnQfl
         XBC9cwMNuPjcBILcxSYXsUZqO9BE9yCR+xJTVP4s/uQnxBlrR2Pr8EuZ6r4G4RbpAur5
         fLaMjFycUMucwjXPSWBteTfKo2O7UPlo5UnMzfZRccczYDKBW7lwXcpvQoooB9qX9cjY
         D/Wt7zpopMVtACqOu/iwYdKALBWTYIdAamnjV1/C4XrzUr+jGYs8W6BG6YjXMwmbukX1
         Wn1lkzevcAlX5ax3PXci1dCalYpVZi9obzdYHx850/weXQ5a2jdpRJfni0sUdxt1bsEU
         4nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPsz6CoLNjPAxyd2ASpUS9AhmaiVkC3z8HgK93csZ1U=;
        b=GfqcKL89ig8bf85cPeiOCh7T0fiRgQY2TIJps0rrpTM6BnZBBUwhw6F7qWiU8dog5+
         qgL7WSzENkS8ie4sEtZ3SW/74YlcZHCknbgU/uFPUAHkHBwjKkBoBBg94BiYF70ypCz1
         /TTFejVL3Mkux/uMxUqEzjaTeBEvAwv3AqHM6VATJ5xvG0QS3mE2rKePpMbaYKG3htJD
         Qnk21ta/Pz6SCBeS+dGKVP4Mgp8XNvto6mkJ9n3RbcTngRzLYCDVIKhfRcSJYeu5eYge
         jAVP96tTqeTPvM4ALBmQvxcf1smq9LHBG36QsCjKv+lqn49zT3Dny/hux2QYBY9jM80G
         lksw==
X-Gm-Message-State: AFqh2kpjfyAdfLYdswO400AGUR21R52Ij4criMKcFFd8qQHL5F9CI7Z4
        aV6aVxmaMCttUpB4Jog5aSDy5w==
X-Google-Smtp-Source: AMrXdXsg6RnczMKZuJgcZwxUHpUG3sqVBTrRPEnjW9UFwbQg6oRXkOpof410jj6/R6m59blyvzTJ5A==
X-Received: by 2002:a05:600c:3b83:b0:3d9:f758:e280 with SMTP id n3-20020a05600c3b8300b003d9f758e280mr41502552wms.24.1674834315495;
        Fri, 27 Jan 2023 07:45:15 -0800 (PST)
Received: from [127.0.1.1] (62.213.132.195.rev.sfr.net. [195.132.213.62])
        by smtp.googlemail.com with ESMTPSA id z12-20020adff74c000000b00291f1a5ced6sm4381153wrp.53.2023.01.27.07.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 07:45:15 -0800 (PST)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Date:   Fri, 27 Jan 2023 16:44:42 +0100
Subject: [PATCH v9 1/5] dt-bindings: thermal: mediatek: add binding
 documentation for MT8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221018-up-i350-thermal-bringup-v9-1-55a1ae14af74@baylibre.com>
References: <20221018-up-i350-thermal-bringup-v9-0-55a1ae14af74@baylibre.com>
In-Reply-To: <20221018-up-i350-thermal-bringup-v9-0-55a1ae14af74@baylibre.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Michael Kao <michael.kao@mediatek.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674834313; l=1282;
 i=aouledameur@baylibre.com; s=20220920; h=from:subject:message-id;
 bh=C4Y1Pt62EoG+4OlWvlrEg4v27fXBsImkQVLZNvvWkNY=;
 b=p84J/BeWtHAWzJ/Wpyo21Fc9gYwpI3/1DIJKFge6sSwRcon816f95HVnjLyZsd4fyWILpsQ8U34m
 FjtNhucEBTBh/OBALocVjgieplh21yx7IezruVT933+1fiowOTEA
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
---
 Documentation/devicetree/bindings/thermal/mediatek-thermal.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
index 38b32bb447e3..ac39c7156fde 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
@@ -16,6 +16,7 @@ Required properties:
   - "mediatek,mt7981-thermal", "mediatek,mt7986-thermal" : For MT7981 SoC
   - "mediatek,mt7986-thermal" : For MT7986 SoC
   - "mediatek,mt8183-thermal" : For MT8183 family of SoCs
+  - "mediatek,mt8365-thermal" : For MT8365 family of SoCs
   - "mediatek,mt8516-thermal", "mediatek,mt2701-thermal : For MT8516 family of SoCs
 - reg: Address range of the thermal controller
 - interrupts: IRQ for the thermal controller

-- 
2.39.1
