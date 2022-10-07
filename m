Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A175F7870
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 15:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJGM7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 08:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJGM7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 08:59:40 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56C3262D;
        Fri,  7 Oct 2022 05:59:38 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w18so7193653wro.7;
        Fri, 07 Oct 2022 05:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jv44eLn5NBzZ2l/C4c+X3coz25UlOTpTrzr64+4VaYk=;
        b=MuM8hM0nbyOrg3KeHbDFTuBIVsEMcTbFBl6MDZlnYZfE1cH2RDEBOCUIIs9PzwILfe
         0qmHo135P+i68z8BqCVo5YIagRtqrQ4T0O0/NbCnspkfhkkJG0QEBIPtpGVqiQsSVQur
         dwK/bRvofOCPoSnfC3q81V2r7/6/3SK5VwLphlHm1MTKlLkA0eEqLjef5vRXIrAkb1w1
         ZXG6LFvL5dc5SFHMhMlpjlEv7cAB6bgwVEqfGUd/EkkxqSbC6xoq/OdNh1biFcUpOiMi
         KoYMjfkhavw1NfP64RTHH9GajbdNN+xmCB8v1iouXT38KSm6KyWhcZXMnAp/f2watLBs
         y0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jv44eLn5NBzZ2l/C4c+X3coz25UlOTpTrzr64+4VaYk=;
        b=7RB7b4Jt0BKSQ02jPtyJRXOljIVIuo5jTdqRddc9fXTKnaO/OF9phSzzRu6JV1rLME
         wtKlajYJ6WLvaar3EXfd7EiOGPW05Yrg7q6MqbZahRZpxHBDXx/OdfWzJhg4gIaJBU4X
         c3eUdo8+YUYiqIG9fZZiYW+3O+mbyWROjmpmWyNB9oiGoWaRfVZ3A6kTo+vddqPE8lEe
         jk6eBR1sc3Te9JuO304yz4K0DbkNA9NqhN1jwtuwQbEKQAiV+kQ1vt+44UOyMd7ENS2g
         5YnrLnyb9I6LHZkT+az251Ic0CfAMnIPZ7Tg83XuJbiSYj7mq3i4m5EdKM99krbVqVF7
         1AgA==
X-Gm-Message-State: ACrzQf0Hak8KeBbEJTYdvD2UQUjmrrdDoo9hUarT3xmIT8cBahyRd7uN
        bsRbROKmTxxToqu9QDazIu4=
X-Google-Smtp-Source: AMsMyM4vYCnsY6VSZkZ7UNJcM2dG96KmQJwNtCghn8lQjzSQLCois44HVHDEtx86+WJ3fAo9gkEmmQ==
X-Received: by 2002:a5d:5012:0:b0:22e:4e0e:f4c3 with SMTP id e18-20020a5d5012000000b0022e4e0ef4c3mr3115829wrt.187.1665147577264;
        Fri, 07 Oct 2022 05:59:37 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id i15-20020adffdcf000000b00223b8168b15sm2008243wrs.66.2022.10.07.05.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 05:59:36 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 02/10] dt-bindings: pinctrl: mediatek,mt6779-pinctrl: Improve description
Date:   Fri,  7 Oct 2022 15:58:56 +0300
Message-Id: <20221007125904.55371-3-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221007125904.55371-1-y.oudjana@protonmail.com>
References: <20221007125904.55371-1-y.oudjana@protonmail.com>
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

The current description mentions having to put the pin controller
node under a syscon node, but this is not the case in the current
MT6779 device tree. This is not actually needed, so replace the
current description with something more generic that describes
the use of the hardware block.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pinctrl/mediatek,mt6779-pinctrl.yaml          | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
index 8c79fcef7c52..c6290bcdded6 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
@@ -9,10 +9,9 @@ title: Mediatek MT6779 Pin Controller
 maintainers:
   - Andy Teng <andy.teng@mediatek.com>
 
-description: |+
-  The pin controller node should be the child of a syscon node with the
-  required property:
-  - compatible: "syscon"
+description:
+  The MediaTek pin controller on MT6779 is used to control pin
+  functions, pull up/down resistance and drive strength options.
 
 properties:
   compatible:
-- 
2.38.0

