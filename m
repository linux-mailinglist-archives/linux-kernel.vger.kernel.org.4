Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF7572BCCE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjFLJep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjFLJeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:34:09 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1224D559F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:26:16 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-977e0fbd742so602630066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686561974; x=1689153974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pZgj9wvv613Msqi5j0pNGHar4gpn1QPcjVJUf+RkefE=;
        b=i2TCaqhZmtxqKa2FTr8J4p+zAFI/+lVqsWQ5y7bdE6iNVyw+L98nByQq/SFsTHNxKZ
         hZLWCXh1+WWkSdGx67v8v58MUcGnJEtmW5f4QTZ4Hcej2Y226Aim935GXxaTT+5CEObh
         i8G17mDBpJWZGh/CtQBuFeznNW0GzNd8YCCmYnWsx0n5LZwXpAMZnfIIXSFlOxXt4yFc
         trstfV5qnwQU4B16XRPfFhq8tsUjmF6lHyFA3pnjFmByIqhdmx3qU6Q0CGf5sn4wBovU
         I1TSwjQm027D5TUoiQwmvCRjLYj0bDkAyAYyrkqfufQRUuv5i/M+PcmpvCNlYAbHNM41
         Lmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686561974; x=1689153974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZgj9wvv613Msqi5j0pNGHar4gpn1QPcjVJUf+RkefE=;
        b=S1VTkas24E5QLSdV/IucHc7zuk4pEE9UXxAm6J79CrP3nHmRWjmZ2DOmPx1d1hrZsW
         JhFxEflJoycKiivsBoKqWbhF51miBS2Q27BZcFoQ5TOsVPu27hlTFU+040JzcbW3O1oN
         dBtaG4IvjOIhSgtzzsU8i7yTqVuLOb9RVsLrX003bnk99h8sPB74oET6t/S1e/WSPBSi
         4IxWshMVPdQbk/YWFNCid+iAVCtyEOQYzodrfcei//V5gdS7q7d8Op02syE1Vt1ya6PT
         58GpgKVgcVyU0N8mrzTXhGjADb0U9EBqXYEipqsFzNEycQk/H346Qfu6oyM7Z/oss0It
         ghpw==
X-Gm-Message-State: AC+VfDzQse/NSCLsZIsT3/AQ/qD5yJkVOfyHNnJ0dOTeNGJ+aMOsb4al
        Sqi1M+JXd1bmmeCiyHWG+DDVLg==
X-Google-Smtp-Source: ACHHUZ5/TSH+NnE5zaLXzI48jDVBI9q7FBbcwiHpWan/hFHxb2/LmYxEPMrVPOY5GOABNato6EZyNQ==
X-Received: by 2002:a17:907:94ce:b0:973:dbcd:52d4 with SMTP id dn14-20020a17090794ce00b00973dbcd52d4mr8177843ejc.37.1686561974430;
        Mon, 12 Jun 2023 02:26:14 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id kt5-20020a170906aac500b00978868cb24csm5035900ejb.144.2023.06.12.02.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:26:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: example-schema: don't use enum as fallback, explain clock-names
Date:   Mon, 12 Jun 2023 11:26:11 +0200
Message-Id: <20230612092611.12385-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compatibles with multiple entries should have usually only one fallback
compatible thus enum followed by enum is not a common case.  Use 'const'
as second compatible to show the recommended approach.

Explain also when clock-names are not really necessary.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/example-schema.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/example-schema.yaml b/Documentation/devicetree/bindings/example-schema.yaml
index f4eec4c42fb3..a41f9b9a196b 100644
--- a/Documentation/devicetree/bindings/example-schema.yaml
+++ b/Documentation/devicetree/bindings/example-schema.yaml
@@ -52,8 +52,7 @@ properties:
               - vendor,soc4-ip
               - vendor,soc3-ip
               - vendor,soc2-ip
-          - enum:
-              - vendor,soc1-ip
+          - const: vendor,soc1-ip
         # additionalItems being false is implied
         # minItems/maxItems equal to 2 is implied
       - items:
@@ -85,6 +84,9 @@ properties:
       discouraged.
 
   clock-names:
+    # For single-entry lists in clocks, resets etc., the xxx-names often do not
+    # bring any value, especially if they copy the IP block name.  In such case
+    # just skip the xxx-names.
     items:
       - const: bus
 
-- 
2.34.1

