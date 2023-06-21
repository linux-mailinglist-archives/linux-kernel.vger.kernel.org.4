Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509807392E6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 01:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjFUXLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 19:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjFUXK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 19:10:58 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8FE1BDA;
        Wed, 21 Jun 2023 16:10:55 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-77e250985b5so211661339f.3;
        Wed, 21 Jun 2023 16:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687389055; x=1689981055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+cdXzYmnF96v1E71Zu6XrOKF8Cb4IXXwU3O5Owr5fQE=;
        b=FMbmTnqWSrX6AFBrCRDHHLn9WAvHFJkXhttF0KxiiI0kXSXwTnCaNmDokA1YhCUn39
         zt9PQ+Z+E55U40JskBGq62kPp21TamYRbvHrjVVkRlecuSQy3p65TpS5ugq5r23bLJvq
         wrQBTWbX2aQAmD9JyGbWJNX7nuD6puRTCHcNkihroQvaCpt80Z30OA8gpnfieUBRdQWZ
         75zmFSZXjB/M7RAVcZefWgYN/WpqR8vi1bmWTCKmFRfzyzKkV/+fLZpEGVNKhD4WFxSY
         KZvF9J8Qi66cGtk4BdwKisfRkg1+Rx2ADpVns3rSZ5QW4rsLf9PzQguNJPx1N/JKMyR+
         BcVA==
X-Gm-Message-State: AC+VfDxYa8wMy3LsTS5zLPySQ05Mz0ZVgU3A65p2PVdiCM6DqGRbbYBw
        V2xi+L4LN6b0Bt4mkWO5ow==
X-Google-Smtp-Source: ACHHUZ5uH+NDPqnnnHYVHfXFn8cPMNXTTm0JQH1Rj/SmPeaUvcuYRyrweK9eZTYGvcZh5/iyNIhF0Q==
X-Received: by 2002:a6b:6107:0:b0:77e:52:a52a with SMTP id v7-20020a6b6107000000b0077e0052a52amr13773135iob.17.1687389055089;
        Wed, 21 Jun 2023 16:10:55 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id y4-20020a02c004000000b0042683fb069csm1704205jai.46.2023.06.21.16.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 16:10:54 -0700 (PDT)
Received: (nullmailer pid 3817127 invoked by uid 1000);
        Wed, 21 Jun 2023 23:10:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: microchip,sama7g5-pdmc: Simplify "microchip,mic-pos" constraints
Date:   Wed, 21 Jun 2023 17:10:44 -0600
Message-Id: <20230621231044.3816914-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
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

"enum" values should be integers or strings, not arrays (though json-schema
does allow arrays, we do not). In this case, all possible combinations are
allowed anyways, so there's little point in expressing as an array.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml b/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml
index 9b40268537cb..9aa65c975c4e 100644
--- a/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml
+++ b/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml
@@ -56,13 +56,9 @@ properties:
     items:
       items:
         - description: value for DS line
+          enum: [0, 1]
         - description: value for sampling edge
-      anyOf:
-        - enum:
-            - [0, 0]
-            - [0, 1]
-            - [1, 0]
-            - [1, 1]
+          enum: [0, 1]
     minItems: 1
     maxItems: 4
     uniqueItems: true
-- 
2.40.1

