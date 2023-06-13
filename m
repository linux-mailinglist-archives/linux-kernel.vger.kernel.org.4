Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2AC72EC99
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240799AbjFMUL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjFMULN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:11:13 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8EB1FC9;
        Tue, 13 Jun 2023 13:10:49 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-77acb944bdfso346751339f.0;
        Tue, 13 Jun 2023 13:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686687049; x=1689279049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/0Ld9Rv7cpsr9VbIPD46nT8UE2Lan47fsXtsoJnXmY=;
        b=HFiNiVpKKWUM/bWNozAIFsQaP9oFWg9u+0F3nAIXaswaMpe5ft+Ix+7D8xuJUy4s6C
         BVnyZD6zkqZd2vMvGtpatHj8xwibXsAYQemhfql7Y+OZWjiQvDsjgkomoColl59xszag
         +WkKT1OC4gjTCuknGz7l0OZW5RAgDEQ170RWuCfcW3BWhsxB21PGgjrtL1f25PgFm1/x
         ByjCzU/VBk0hqv8grFC66gYG2MRIdbX36AOSrApkT2+cAwvbZloP0j7eXhoxkDcAgjay
         6cYw+RwE5VHarK3BaoBp5DC3w+JhIQtO9GxO9D2LhHjPvo/ch3OKw0wQhnJuaV2xrUj5
         XaUA==
X-Gm-Message-State: AC+VfDyHzy76cfJKCOBhzMOanhT7b5zUr9UdmeTA+MxjD7xiGOkL2I4W
        PgOE+RebMgFyc3CMJ+0a7g==
X-Google-Smtp-Source: ACHHUZ5uW/zGOo0tQgIhPAfnV1Zc8GBjuvZGKJYam6fCcqz5xYi7Ghl5jBM6tpUZne+7Uvhv3mb8Fw==
X-Received: by 2002:a5e:9509:0:b0:77a:1307:1e4e with SMTP id r9-20020a5e9509000000b0077a13071e4emr13227179ioj.18.1686687048997;
        Tue, 13 Jun 2023 13:10:48 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id w12-20020a02cf8c000000b0041653d00c1fsm3633263jar.72.2023.06.13.13.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:10:48 -0700 (PDT)
Received: (nullmailer pid 2823983 invoked by uid 1000);
        Tue, 13 Jun 2023 20:10:46 -0000
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen Zhong <chen.zhong@mediatek.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] dt-bindings: input: mediatek,pmic-keys: Fix typo in "linux,keycodes" property name
Date:   Tue, 13 Jun 2023 14:10:40 -0600
Message-Id: <20230613201040.2823802-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"linux-keycodes" is the wrong property name and is unused. It should be
"linux,keycodes" instead.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
index 037c3ae9f1c3..e34c9e78d38d 100644
--- a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
+++ b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
@@ -55,7 +55,7 @@ patternProperties:
 
       interrupt-names: true
 
-      linux-keycodes:
+      linux,keycodes:
         maxItems: 1
 
       wakeup-source: true
-- 
2.39.2

