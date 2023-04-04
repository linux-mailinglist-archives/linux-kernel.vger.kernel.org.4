Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CDC6D68E5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbjDDQa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbjDDQaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:30:16 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58AA11D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 09:30:11 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e18so33438504wra.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 09:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680625809;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RXCUKi5pLgJUBY4+DuTQW+y3V8bEHDXD8BVtVDMZZN0=;
        b=x83VudRGauAHV1kLMU4VIDKWdiOnacBuhBc9RYi3f4sxfs2XweNKIeNIy7rnpOsOkp
         gB3Y3PmWwfHJ6+rVwIGkzr+R90zB9f1ScZTmP5pBXTk6OCG+i/WM3YIYubUXwveDkFgW
         B5qtnSnJPQvaZwQv3DzcllhiYux4yPm/PQG5GKlpQk03mPF8LGkiP4QRSC9SH1D2cZdK
         RLeCG7AUpLveaizQd/zIfOAIc/9rfUv+HP/7vA6yF9lcjsZ/5466Cr2bE/vulCe91elu
         nCg+NMOKmLP/ADnn/I4Tp8bb4I9Q9vATZMVc6Mbo/tBYqEVrzBnjBJvWMdbx6FLMpkHe
         pF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680625809;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXCUKi5pLgJUBY4+DuTQW+y3V8bEHDXD8BVtVDMZZN0=;
        b=BVfLxQwWFWz9SJLrmElxISg8/HWTRoHmDRDGAL+9rV6TbqoGB/uCewh8Hq/hAs+zom
         r3RMxVH9YFRN0g+dqMEZ+pokjUH5Noebs27jhIZktyrFzPmjkyN43kwT9tS0JbVYPXt4
         N0A/oAcB28yajvnVjQzBQiUtfrzWwpoihonlqUdQ1sHHKje7TJuhsVMhqyfGIZT6yMmJ
         e+pcsMWhMwluXgJb0DxcB0FpAsT74A/l5+JDI5SYzIdmC9cEhYyaEtuvHMC1Vc+C+B7O
         0zSwSoBIO+jqa48LSMf+eqMxzRbQIRAokoSosSCA71U5HUIXiVnYrf4jE4MS5L5OWKdl
         zr9A==
X-Gm-Message-State: AAQBX9djppvVp7WHMxjqp7h8Dd7zEW2sefnT1DL93XvG7ltiFX+Bw32i
        JRn3JC5eI9X8KPVxrZVBi0VmYA==
X-Google-Smtp-Source: AKy350Zz0PfT3XGOK9Wa8a7yqRYF3C0KlPhlP1JiPHsCEgTyJVh7gGi6gYk/9kkxi1PRWnHtQi3S3w==
X-Received: by 2002:adf:f0c4:0:b0:2ce:aa2f:55ff with SMTP id x4-20020adff0c4000000b002ceaa2f55ffmr2047020wro.1.1680625809559;
        Tue, 04 Apr 2023 09:30:09 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id o7-20020adfe807000000b002e4cd2ec5c7sm12694528wrm.86.2023.04.04.09.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 09:30:09 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Tue, 04 Apr 2023 18:29:51 +0200
Subject: [PATCH v3 3/3] dt-bindings: pinctrl: mediatek,mt8365-pinctrl: add
 drive strength property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230327-cleanup-pinctrl-binding-v3-3-6f56d5c7a8de@baylibre.com>
References: <20230327-cleanup-pinctrl-binding-v3-0-6f56d5c7a8de@baylibre.com>
In-Reply-To: <20230327-cleanup-pinctrl-binding-v3-0-6f56d5c7a8de@baylibre.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=cYHxBDCQoGJzPsmuJwnAfXpE5ottu0FMlkHkQen22jw=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkLFCNiPnKq5m500FTYjWaFJHdGzwyKvH2iKxU1L0d
 XA/Iqa6JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCxQjQAKCRArRkmdfjHURdhPD/
 0X4LhELLZx9sdnK7pRBtxWQYcXNGprCl3/3LUi6CQHqWNoNLRA+F4wQ9LaiPkAbOoz6srmj/44kuoC
 D++ydE0BicfPHO3zA0HgvaZhK89jP5FHWmMNGzM3ruNbpUTxbTdZ/iuyATw/tFot6EZ2y03ezv98XG
 lEhUepZJeT38R8W+zuoNFoyudkAO7gdRNvsXDUks7VylKc2kdgKz2uaj3hBbJQGhw7S7aCMzruKh/+
 H6WqSMJvLI/V7DBBj4TgeIy2ObWmQCBwYHILu1Q/zia470nRoDOdiwGJXntlLIJuL4doGoJIniFU6C
 fuhnG5eCUpurqYRrr1hN2GhyB2pCLcMaTP8iv9cI2NaENkIwSYGY+UvImZplYEVQNezEvYiGi5zrqE
 2FdxbhcoPyFB+9Nm0bSgED0YIn/fYVlBexqBIThLXyI/jBWbvvus6HDgJaOXXdoNObQCcNRZEgzLuE
 XO+Oo0XIB80Ekijuol85ECWgScXzQqEsHjw1xcRjGRWuXcZCETY8XVVb0LJTgVdMmhh1Z3NkoAF7rh
 1WG87fxk2rLxzE9hKJR60KEETsFqBJpTMfvQXO0qwD5Zbdzlwjgsm5VQ1AZvyKvvfcA3GfVDvokh/4
 UnSR8FcAam0JL/osQs5ps8fd62s6sifvVVuWrSpYhAEnsKQSz8ER1Savx0Fg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This SoC is able to drive the following output current:
- 2 mA
- 4 mA
- 6 mA
- 8 mA
- 10 mA
- 12 mA
- 14 mA
- 16 mA

Then drive-strength property is set with enum to reflect its HW capability.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
index 75d74b92c767..61b33b5416f5 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
@@ -99,6 +99,9 @@ patternProperties:
               102: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
               103: (R1, R0) = (1, 1) which means R1 enabled and R0 enabled.
 
+          drive-strength:
+            enum: [2, 4, 6, 8, 10, 12, 14, 16]
+
           input-enable: true
 
           input-disable: true

-- 
2.25.1

