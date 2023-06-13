Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C065C72EC87
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240427AbjFMUKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240347AbjFMUKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:10:16 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD441BD2;
        Tue, 13 Jun 2023 13:10:14 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3406c8e921fso2938835ab.0;
        Tue, 13 Jun 2023 13:10:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686687014; x=1689279014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fNJF+JpqUK2LzFWyZXr4JUPL5v94vmK36QO13SvQR1s=;
        b=ckVB5Iyd2+V82PEZgtGceZwnZZekipPZRqCMxI2gO3Y0j00NHrbsKJAAjzaQ2VXpaW
         JUjKy8XssO+uiovL7EzSSPmqP4bt0XU7jTyKONT9+cgRKCmzbNq6fiCZTK335751z3Ku
         evArUMYKM8bs3u0d1G3kEKQpcdIObxVEMfboCj/INPZe0WBl8cZ0LyyQoSiNvb85rGZH
         JOXrXCpTK3/yTFA0c2+hRnhK0TX/36pgOs7JjQjCH3PLmwLW7LiHhe1NfDozBREhr1ZM
         mP/+weuqCRBWcoj7IqDd5Nm2WtgsS2Ad9w6fzUi9nqc2GRFB6BviCyT/sAtUB74nZUb4
         0xkg==
X-Gm-Message-State: AC+VfDz7M5L1+0dQrGzrdZFV+UDiNbzZWPli2BETU0ZFvuiMzMkKLnpN
        cvy9Eax/u5+4M515dSKoog==
X-Google-Smtp-Source: ACHHUZ4X3ORRu8CW/zCZ3uLQTOZ9V3VzYdxcKGNZp/bYlo7DSHB+vI05hHFlC7glBgPB+/+Zrs5/aQ==
X-Received: by 2002:a92:c686:0:b0:334:de38:d600 with SMTP id o6-20020a92c686000000b00334de38d600mr10113765ilg.3.1686687013783;
        Tue, 13 Jun 2023 13:10:13 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id s7-20020a92d907000000b003350c8ae201sm4029875iln.29.2023.06.13.13.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:10:13 -0700 (PDT)
Received: (nullmailer pid 2823122 invoked by uid 1000);
        Tue, 13 Jun 2023 20:10:11 -0000
From:   Rob Herring <robh@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jai Luthra <j-luthra@ti.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: ti,tlv320aic3x: Add missing type for "gpio-reset"
Date:   Tue, 13 Jun 2023 14:10:05 -0600
Message-Id: <20230613201006.2822985-1-robh@kernel.org>
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

"gpio-reset" may be deprecated, but it still needs a type.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/ti,tlv320aic3x.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/ti,tlv320aic3x.yaml b/Documentation/devicetree/bindings/sound/ti,tlv320aic3x.yaml
index e8ca9f3369f8..206f6d61e362 100644
--- a/Documentation/devicetree/bindings/sound/ti,tlv320aic3x.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,tlv320aic3x.yaml
@@ -61,6 +61,7 @@ properties:
       GPIO specification for the active low RESET input.
 
   gpio-reset:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
     maxItems: 1
     description:
       Deprecated, please use reset-gpios instead.
-- 
2.39.2

