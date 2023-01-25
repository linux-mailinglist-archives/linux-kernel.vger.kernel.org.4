Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AFC67BFB3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 23:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbjAYWOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 17:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235567AbjAYWOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 17:14:02 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B4E518E1;
        Wed, 25 Jan 2023 14:14:02 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id v17so17598879oie.5;
        Wed, 25 Jan 2023 14:14:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dJ9z57UwZG4tTNorqhSO8lGfimRHzs0UtM70Y/wGFLA=;
        b=sxEJsutjqbIT88DxXVutPafEaKKf417BDyUyUfT44d6Vt/CEmRW73OHOwpo0hK84AS
         DME5yzPKC0oxR9mLf14NFtnvw+Krk1B4zejOsFnzDy9e61RFGofD3mXlBdbXfx45xyd3
         4qaQvjNLfP6Y/Xm2S70eCrp+NU6hnAWal/HDSzgmmZTp+bSxAQrZdratER1xNGX+/2fX
         qoQkTmExXohzuuJBx3nTpt7UbrhAc7y6H8yUHe6sGMrCAoE7GmaIFzvJX0PcRAqrNiae
         20OdBDzXABm06CQW5bYtSOHrHJN9y7ElMlgqMokaQfIXYY4QndCNaUbK5XB24Mzxix/j
         Uwgw==
X-Gm-Message-State: AO0yUKXIWN3s+S0mmutVUV4GZoDdLOGolAyHPsJF055Kj5eYPu+GpY5u
        QONlUbL6If9DPphv9aUysByIR4K76w==
X-Google-Smtp-Source: AK7set8GspnsCWGYKbxKN1uTZJxpgT1DCK5rPr1zBkbIBamx+JrDWk3S0vq7V9yELy/gC+8h18sZYA==
X-Received: by 2002:aca:45c4:0:b0:36d:9536:160 with SMTP id s187-20020aca45c4000000b0036d95360160mr7317oia.32.1674684841524;
        Wed, 25 Jan 2023 14:14:01 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j2-20020a056808034200b003648b84a2b5sm2780771oie.33.2023.01.25.14.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 14:14:01 -0800 (PST)
Received: (nullmailer pid 3057738 invoked by uid 1000);
        Wed, 25 Jan 2023 22:14:00 -0000
From:   Rob Herring <robh@kernel.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: display: msm: Drop type from 'memory-region'
Date:   Wed, 25 Jan 2023 16:13:56 -0600
Message-Id: <20230125221357.3057655-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'memory-region' is a common property and already has a type.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index c5f49842dc7b..304525f81563 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -89,7 +89,7 @@ properties:
       help bring the GPU out of secure mode.
     properties:
       memory-region:
-        $ref: /schemas/types.yaml#/definitions/phandle
+        maxItems: 1
 
       firmware-name:
         description: |
-- 
2.39.0

