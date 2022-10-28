Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089E7611600
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiJ1Pfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiJ1Pfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:35:34 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E9E7992E;
        Fri, 28 Oct 2022 08:35:31 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x2so8428788edd.2;
        Fri, 28 Oct 2022 08:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqCccumknJLELEs6P6qfy76QQ4LLkzIhoHsvgTTQP0A=;
        b=Tn73lx7E473nQMYoOWdMzrI4B7Y8cLS0asgGZ4ic/y9XfDXHi8Uknu1+0NNt/ochSe
         v+V0HUSncvJcrrBRUIH7B5buSwacbfeYn73OZbijlDaow5KZZKeMEhlhyNG/Fh1mxtHe
         vl9UKo9MUlYXzV0YQZrcfvtkNvPvFQ182phxyxvaksqAmpS1xtKsaKRg7ivadDebxmKK
         KsMZZxYsnouvNfW9xNWPeicZC3sMS8IeRAxYCPydS9gq3n8inlcbyluC/sKl7Knth5Tm
         /gjEWYHTWoOyemlIApJBHMBMfdLAWB+rx/qZ8h0W0TOTmgLOROVfFJ+zXdDc0yeEs0Gr
         IesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqCccumknJLELEs6P6qfy76QQ4LLkzIhoHsvgTTQP0A=;
        b=IYP0xiTabDz49Db7kWw7pHUr9BjZrpfo51uTIEf8sCg7TaTB8JlQpW7WyXagQ1Rmf2
         d3t9gZQFyc/m66WnXbcsVVtx82SWJIYY8XA6qFSyFww6yOdegz4y6JCsxyzDyywwdSwm
         NS5tc15DFYhgGYHhR/Deba29aj7p7EH+CbD9wAKrk9weTbdAROAGLuH1SFKX6YTQQaON
         qq2cv90I2YxbDf2WxqNPhlwq6jKJfURz1zeRjPNfJZX/opnxB5IgAaphq5vgoFVBrwF4
         bRClE17Wd57/DSJAbd9Rm6A7JH43q0hI283ueB5qVtpf5wHH3+j7LN8JEdp/Httua1Nd
         lP0w==
X-Gm-Message-State: ACrzQf3vNqR/W04L/+tCz9IgxseeNRBSKmS97k45rW2hqdhESAM0DkJs
        M57KrVsAAIHqvV6Eiovm9Ss=
X-Google-Smtp-Source: AMsMyM47SbkBLgzsyeqHvow0DxFIWZcWEVDjQy8qASHWKeuoqSZCOJP1h1nqlFCyxDv+tJeohq8wFA==
X-Received: by 2002:a05:6402:2791:b0:461:c5b4:d114 with SMTP id b17-20020a056402279100b00461c5b4d114mr25045506ede.357.1666971331095;
        Fri, 28 Oct 2022 08:35:31 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id ds12-20020a0564021ccc00b00461aebb2fe2sm2830635edb.54.2022.10.28.08.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:35:30 -0700 (PDT)
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
Subject: [PATCH v4 05/13] dt-bindings: pinctrl: mediatek,pinctrl-mt6795: Fix interrupt count
Date:   Fri, 28 Oct 2022 18:34:57 +0300
Message-Id: <20221028153505.23741-6-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221028153505.23741-1-y.oudjana@protonmail.com>
References: <20221028153505.23741-1-y.oudjana@protonmail.com>
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

The document currently states a maximum of 1 interrupt, but the DT
has 2 specified causing a dtbs_check error. Replace the maximum limit
with a minimum and add per-interrupt descriptions to pass the check.

Fixes: 81557a71564a ("dt-bindings: pinctrl: Add MediaTek MT6795 pinctrl bindings")
Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
index 73ae6e11410b..a3a3f7fb9605 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
@@ -47,7 +47,10 @@ properties:
 
   interrupts:
     description: The interrupt outputs to sysirq.
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: EINT interrupt
+      - description: EINT event_b interrupt
 
 # PIN CONFIGURATION NODES
 patternProperties:
-- 
2.38.1

