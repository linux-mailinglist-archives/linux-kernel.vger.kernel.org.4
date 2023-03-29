Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0526CD561
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjC2IzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjC2IzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:55:01 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3772C2122
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:54:57 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r11so14831615wrr.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680080096;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hVP5ogEJUfh7DhnBZdRIBIwVL+R9BPURRS9YlmwkoZs=;
        b=k+Nmni1Rb9y2/ilRFy4uDkbXD3gpCGYyS28Ea/O3AYecarLNqIoPHUysWteYiRb2go
         TEtO3l2aWTF0+UhVX1u45HrZHNMjZVeEPHJnia2nJ7suQfVwlHzr6KWvoTiZQQE1P0Vw
         jg2TdtLrcK61nFSnJznlOHuSkr9J54oP2pXWQms4lNJoH7eNImedRsHt1WlO5XuUA3OI
         VtzjQJJMXzmrcAw4t1ybV6/76LmE2uqOrxmsNOREN600CPlKZ1OtWmnseRseaWvdgXw/
         Uo/c7q3UvzsWSVO6DAxGB6Sspqk/1Dvtrpot/oLdD2hfWY+gPAgSMwT/yyITLfGiRlI3
         09YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680080096;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVP5ogEJUfh7DhnBZdRIBIwVL+R9BPURRS9YlmwkoZs=;
        b=dLq7yl6ciq/8PF4GegBfAuAWwX1jZ5td5P326SctGI4nZ7sTmoVkc+ACbmTtm/+Dp9
         DUJ0x5DCUJW4g4orutcx9KfVhrgoXSlZS3b6NZgp4irWxDBHs9LgKyv3HsCEVz4YxqV3
         foYPDU5EFy75fVqf/BlH4M9xQmTwEQ3oAf4IpAb4AaPw4aEUWaZk8zGLI46yDXolQyoD
         5BZjukTyW1yWocfwK0ck6ul2e4wRrkVLmBNRaU3++CIEg2r57ejeNSYXK8HNNiYzns1S
         HgeXyu0QGUNNZeX4KqRZ1RoUhqNNK2UNGadti/AQjDy8H2ZWWet4qs3h5MIkrvxpiPRd
         HGjQ==
X-Gm-Message-State: AAQBX9fSnDc1vjsepu+QNkSopgGByhS5BPKpQa5W0ONfGFQwBJpXXdGH
        ptQw4kG1pnVih6S3Pc+Pl4GWHw==
X-Google-Smtp-Source: AKy350bM6jzZfbFxzCV249eUTj3usBz4gdmxhhofiRr7kO2NsjfNamiYWT3HZC6p0LBPT+My9bsYtg==
X-Received: by 2002:a5d:4d4c:0:b0:2ce:aad8:9bee with SMTP id a12-20020a5d4d4c000000b002ceaad89beemr14955632wru.46.1680080095706;
        Wed, 29 Mar 2023 01:54:55 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f9-20020adff989000000b002cea392f000sm29571964wrr.69.2023.03.29.01.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 01:54:55 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 29 Mar 2023 10:54:23 +0200
Subject: [PATCH v3 02/17] dt-bindings: pinctrl: mediatek,mt8365-pinctrl:
 add drive strength property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v3-2-0003e80e0095@baylibre.com>
References: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1062; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=Q6KYTQGi9BQ9506wErkVzgHSmMBN0a0BRBzstC8ybEY=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkI/zblB4RGAHNE+u3bmnkO8ILb2ZIXB3T7xVpT6WS
 AvCMQQiJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCP82wAKCRArRkmdfjHURdonD/
 4yZPAZubkiDP1QhAA7kBXJXeh6TssL0PBYQYI9ScFAJ4ISeajBVhKdTCmJdSUjutkauaKljkPXKFg/
 Z2seGD/nqR51iUPHQJgr0xVDGXRbxiAb9OLoTrJRvc9uuF/ix3cnYm7YVsztKhrl5NsQXVJFEARrV6
 HJ0IsrsUVWY6NuDP8AjBfkh5oT94Eav+5qc9XZUUODVYbyJImZ0tziN0Ur3ThHE2380AJgkzwfca6r
 RWkvqMQ6+URxaN+RH5IdCYzatDuUPsNpGu0yiVov5+BYQ6/z2SSEU61hH3dnl4VD4fv0EAD50cRAd6
 roaptS0VbansANLDMzHDEuCfPKdspW2z8ZX4H7/49VlhXeHQNcNFZ1bW9igmGdWBCuEGZI/JkFkit+
 MwhYBgN1EScGnRBSnCGBMOKuc3yT0d09cSt4+x81XlOuVvrQgiR2OXYyv1j4slaTKAL0IJrtEudidr
 0PsmjsHSgb4VgJYrw4Y9p6fciKflZA+CEJYoqJ4JH//hY26+n4402DWQZXTaP77Qo0nz22EP2CMdaO
 4UQ8hQHR9ATr4gRcIM0LEIJHt8oYdOzjsDOGjotuk1u/YkkXhJb1tMKIVkhSGgddZCbpN+3V617Y+1
 yYVAnIj7Y9WDcw6huhoKs0osDpE9M8Ik/wp68pPWGwyHUHSdIgfcJ6PHvIng==
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
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
index 4b96884a1afc..101871ec6693 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
@@ -79,6 +79,9 @@ patternProperties:
 
           bias-pull-down: true
 
+          drive-strength:
+            enum: [2, 4, 6, 8, 10, 12, 14, 16]
+
           input-enable: true
 
           input-disable: true

-- 
2.25.1

