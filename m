Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAED5F594D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 19:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiJERpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 13:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiJERoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 13:44:38 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB63E7F10C;
        Wed,  5 Oct 2022 10:44:31 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b7so19403020wrq.9;
        Wed, 05 Oct 2022 10:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=xzQ3pu4AkkWqxTHaHeMz8ghBZOwYoCN5mkKi0p9uYHs=;
        b=gaxodBeuuMM0XJH7Z5uOppiufptWExBXPakriMQEZRFk5LQ8wOj1eNupyQ+0+uEsV8
         O3mMmjs74AOR0Aog3r7N8Z+3lzTidhDvS0hPgQnUv94KLIIvnVnxi+R7rGMSHfZhqFYj
         /kaLDrfXNYIMlV4NpxIiyOiaDXQfGK9lRBdx6lz5FYcQdxw0H1psJgNimkMTZKuXtnBu
         C0dIJ6MBT7V251msfdS0ElJQEw6qsNj9UsQmvrqoC4qmd/G5eF1/9HqH0GAPwrcpwsTo
         fbdKfP68fd0VOTJy7qtd4Yqq4Z3U3HJJ3KGIyRcJvk6g9UT7VwCCpyAOpKG/czGc5rD1
         uaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xzQ3pu4AkkWqxTHaHeMz8ghBZOwYoCN5mkKi0p9uYHs=;
        b=ROrZ6uz7J8grq+XXWuZtt01k4dgLsUYsEY92ki8LE4vMWDAr0G2Cv/wOP+BboqDZg4
         1A8oYk93vCBbzDtCrd8Zmr+laAvt8tVv5OyrTEk/iwETm9PI7rNbfZzCLdjdJhpzpHUu
         s5Y+bzdcK5JNimf+HbXxDZD/Qy9zYfoTrKO2QL8Tq4WYEtQ7xWPMKFZ/tZcUQbcxf1NR
         p+lXNi2Ve3kWnQsFkV2Vh0DBw07k3ld5fYIrf5LTKnzbhwgehqP0j09W0CYrlukCCJf7
         s+jqRCCBXQ/FPJRXfqaCWLD2tu/4euhVLHKH3ZWD/P9AznR9qi43thXLmOQWwY0WxAnK
         cPgg==
X-Gm-Message-State: ACrzQf3H4hVPOt5tZb/0mZVJUF+zYOfb9Oz6s5pn9oDYqlZwwK7cVR67
        XUPbgigyJs9PZ6k9AK+5Tgk=
X-Google-Smtp-Source: AMsMyM5aaW/jqs7PzwW9R7tJincjwVTCwCF2vgEwDG/p+WiHo0oGn0xHe/dbMN4IpZ6oR/jLR9Xtaw==
X-Received: by 2002:adf:e0cb:0:b0:22e:2e7e:e57d with SMTP id m11-20020adfe0cb000000b0022e2e7ee57dmr585151wri.170.1664991869718;
        Wed, 05 Oct 2022 10:44:29 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id c6-20020a5d4146000000b0022a403954c3sm16075491wrq.42.2022.10.05.10.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 10:44:29 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/10] dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Document MT6765 pin controller
Date:   Wed,  5 Oct 2022 20:43:41 +0300
Message-Id: <20221005174343.24240-9-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221005174343.24240-1-y.oudjana@protonmail.com>
References: <20221005174343.24240-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

The MT6765 pin controller has had a driver for a while, but DT
bindings were never documented for it.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../pinctrl/mediatek,mt6779-pinctrl.yaml      | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
index 64d4b6a3b5bd..f10d1d5543cb 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
@@ -18,6 +18,7 @@ description:
 properties:
   compatible:
     enum:
+      - mediatek,mt6765-pinctrl
       - mediatek,mt6779-pinctrl
       - mediatek,mt6795-pinctrl
       - mediatek,mt6797-pinctrl
@@ -60,6 +61,28 @@ required:
 
 allOf:
   - $ref: "pinctrl.yaml#"
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt6765-pinctrl
+    then:
+      properties:
+        reg:
+          minItems: 9
+          maxItems: 9
+
+        reg-names:
+          items:
+            - const: iocfg0
+            - const: iocfg1
+            - const: iocfg2
+            - const: iocfg3
+            - const: iocfg4
+            - const: iocfg5
+            - const: iocfg6
+            - const: iocfg7
+            - const: eint
   - if:
       properties:
         compatible:
-- 
2.38.0

