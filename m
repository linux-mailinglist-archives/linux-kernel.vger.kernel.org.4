Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6841E6CC02B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjC1NIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbjC1NH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:07:57 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E474A9EC6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:07:24 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so7406041wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680008843;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZCUDC113hZrfc4/w637u6Evx1aNuEaVcx74j51VyTM=;
        b=uoroKRPzK9rs9wPecKIL+FAsDmGrHpnOBjWXWavpjuNbBvVP8hqk47XarvJK8FiWQH
         2SVd07zgg3VYJSfkTyNR+UlE8gSo9Qj8hJD9X/d0GJt4mePqlDQV/XhHI4+IO26TLVCw
         mar8OwufFS9x5kUvFjEuJUYxpCN0qnmfk+MBlspF1quV4pI77yXYf9KZa5KBgjB+dB41
         YFz2BS4jjU2gxdJ1LaVIEkde+Bg7/m+GnuFCpamRYF15z1fI4Y/QAZQvmaNndQj0o8x+
         LSLg8jPxOtTqIJYb0i27ju0iSVs/0WT5OYn1RHKHNoy4UmV5aQszCxjfUSkbttptVLhT
         kahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680008843;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZCUDC113hZrfc4/w637u6Evx1aNuEaVcx74j51VyTM=;
        b=01ptbKXpn6EmiqVLQdxcSOnPZFJmr2oYVkFIBgU4UNr2ddL85f3IbaW8WqKNbcFE0p
         VH3KftmeGvyKlQlJ5XmyQkeKAZlm88kx9DsCQGvmH/2OAFl3oA6cPt5WJrsiiMzyaA4v
         FJHN+ZfdojJSEC2VmaJ4iZteM8Ok1uR23myuL/CA1Fy9wuysrT5uMlbFILTMGYuct6+R
         DqtpEATjv7F81x3yQJI3ixuxMMcOKhrBgT25PfpGndb3xhZJNty/0+gzUXnPHdfDV1At
         WTgGKB4VxrWzwUth3b1rAWCgs+kN/iWv3YH3Sf3EBOeT/kKAtxzHZCDnrAJdgKhxgpKL
         rRtQ==
X-Gm-Message-State: AO0yUKWOcoCu3K5Vow+ONsX/5Oc3Ohypqf0wfKLu1LJ62p18UghJQxsS
        hqji5WTH+fshyq21bmxHQGcGrQ==
X-Google-Smtp-Source: AK7set+Qn0QNdIv72uD1VA07borwcLXRZGmrN7Ku5Wm5hRlUJq4FRQmbaJsv8P4qDs/N6t3ccpeO4g==
X-Received: by 2002:a7b:c459:0:b0:3eb:a4e:a2b2 with SMTP id l25-20020a7bc459000000b003eb0a4ea2b2mr12130724wmi.4.1680008843401;
        Tue, 28 Mar 2023 06:07:23 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id z6-20020a05600c0a0600b003ee6aa4e6a9sm12733650wmp.5.2023.03.28.06.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 06:07:23 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Tue, 28 Mar 2023 15:06:32 +0200
Subject: [PATCH 1/2] dt-bindings: pinctrl: mediatek: deprecate custom drive
 strength property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230327-cleanup-pinctrl-binding-v1-1-b695e32e4f2e@baylibre.com>
References: <20230327-cleanup-pinctrl-binding-v1-0-b695e32e4f2e@baylibre.com>
In-Reply-To: <20230327-cleanup-pinctrl-binding-v1-0-b695e32e4f2e@baylibre.com>
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
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3294; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=Panj4X+b8/VMaW+LvlJ1ecWkOV96Ee2HxiKik6gJXi8=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkIuaJY3OkB+NsfNUaQoH79+5BJZdOW5QZzUOiim6I
 l82EFoOJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCLmiQAKCRArRkmdfjHURSeiEA
 Cr6PC0vlcLoWQvViOLHWiZPUEdkJ7pygYavOjfVXwQZXiGfKWBpOnFh/r2b0iIqk5b/XKQAqH5birv
 B0ZqUBzENIP7WN1OnRGEfhA4NP7MCSZiemF+sezKab7p7G9Xs8cwWhl9gIYWqXTpEqDB5GIYZXqkrh
 t53BElPXNzMHS7p3W7svxnmmZwNY+MYfrQWol9ryN29++M/dWfZSp2kHrCo3AMFIf2ES47K0RJNHDZ
 TbkNhMFgtEXeYDYDJyXESMVK7wh7jbeVoquLU0lQN9zL4q4/LVgt76QTRwx2Rn7sns1tCSMHtGco9V
 5CnNK5SYWgvdNH2kxjqlP8vcvnxq5gGW6+f2TuSa38ETnehymWw6atDGzJ5UamCRTWN4PPLk8geTyw
 f/Q9HmWnu9KF8sIJQF3u6xHGHYRt0oo8rEVz7vqxb4zC31UsI73qwsokjfL2XEr3XU3YLC8Wbr0cVt
 prJQVQ7Y5nzqxyxcY916mz43WVFyy9RatPGszh0iM/4yrqutvOUeKBsSUtVmG2iZYv+bs7Rz6gPn6a
 yUIBHH5La8RcOzfEZb0JEJp9XGsRGeZztlqmYAeyJUR7ynR7FGBHhQFwFIpM+lD2mx903Mzx3Kxabw
 PKMuOqKmpa103h7u/dSQNnoIQrl56u5rgcjUDB7XZodnJ7TPG7wb0BtDDNzw==
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

Deprecate mediatek,drive-strength-adv which shall not exist, that was an
unnecessary property that leaked upstream from downstream kernels and
there's no reason to use it.

The generic property drive-strength-microamp should be used instead.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml      | 8 ++++++--
 .../devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml      | 6 +++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
index c30cd0d010dd..b82a066b91ec 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml
@@ -110,8 +110,13 @@ patternProperties:
           drive-strength:
             enum: [2, 4, 6, 8, 10, 12, 14, 16]
 
+          drive-strength-microamp:
+            enum: [125, 250, 500, 1000]
+
           mediatek,drive-strength-adv:
+            deprecated: true
             description: |
+              DEPRECATED: Please use drive-strength-microamp instead.
               Describe the specific driving setup property.
               For I2C pins, the existing generic driving setup can only support
               2/4/6/8/10/12/14/16mA driving. But in specific driving setup, they
@@ -215,7 +220,7 @@ examples:
               pinmux = <PINMUX_GPIO48__FUNC_SCL5>,
                 <PINMUX_GPIO49__FUNC_SDA5>;
               mediatek,pull-up-adv = <3>;
-              mediatek,drive-strength-adv = <7>;
+              drive-strength-microamp = <1000>;
             };
           };
 
@@ -224,7 +229,6 @@ examples:
               pinmux = <PINMUX_GPIO50__FUNC_SCL3>,
                 <PINMUX_GPIO51__FUNC_SDA3>;
               mediatek,pull-down-adv = <2>;
-              mediatek,drive-strength-adv = <4>;
             };
           };
         };
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
index 4b96884a1afc..347f533776ba 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
@@ -91,8 +91,13 @@ patternProperties:
 
           input-schmitt-disable: true
 
+          drive-strength-microamp:
+            enum: [125, 250, 500, 1000]
+
           mediatek,drive-strength-adv:
+            deprecated: true
             description: |
+              DEPRECATED: Please use drive-strength-microamp instead.
               Describe the specific driving setup property.
               For I2C pins, the existing generic driving setup can only support
               2/4/6/8/10/12/14/16mA driving. But in specific driving setup, they
@@ -189,7 +194,6 @@ examples:
           pins {
             pinmux = <MT8365_PIN_59_SDA1__FUNC_SDA1_0>, <MT8365_PIN_60_SCL1__FUNC_SCL1_0>;
             mediatek,pull-up-adv = <3>;
-            mediatek,drive-strength-adv = <00>;
             bias-pull-up;
           };
         };

-- 
2.25.1

