Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767FF72EC95
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240618AbjFMULS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237764AbjFMULH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:11:07 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752B32128;
        Tue, 13 Jun 2023 13:10:39 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-34096e3799bso531655ab.2;
        Tue, 13 Jun 2023 13:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686687038; x=1689279038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OrFKDv64C3D/mFI/tKzX33+FI46+VP2OrxXGEXnBBaY=;
        b=WlOsIWXWUOIF14glcjb/a3qdWofPlx9FHjkbwKjujMOqCWmgMAUPxXY0Kk52eOpUE6
         jUwgipykkAAq8Ve1sSh0zJLrQAcCfHATnzFXJe4y26vf8uIgCvqE0dThpkIgjsXh6Os6
         mw6AvjwePbYu8X6fADL56EZKnjLJ/jR4IQ0Ldi1qQt41kFje9D9M2trQCyiTImUBUhK4
         TPQFMN4qykpymMxjUr9aPxypF//a/EZ07ib5O1QnYBwsFq5E5itQ8IeZHauqzY+Xc5ba
         8a8Q+n3SsePcAxGF2Y+DCOZEmGguucQA2A+sgNAcf3DHSJOgS7lQSL9sEQO8xx40y7CN
         Tyjw==
X-Gm-Message-State: AC+VfDxPwuTOIyusnej6STal2rduhcf+MOCPJCbDQm9htwkbtjjEd+7P
        XThsPtUmTRUF3In7D67cH+PB+EExTA==
X-Google-Smtp-Source: ACHHUZ4p4QXVC7+UoDw8SyyPdFsQCfC744w0znfg77T5EBiSJu0WhmplR1C5kCPCXOPO4NIaOWK7yQ==
X-Received: by 2002:a6b:e614:0:b0:777:b364:bab9 with SMTP id g20-20020a6be614000000b00777b364bab9mr12043059ioh.6.1686687038727;
        Tue, 13 Jun 2023 13:10:38 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id g1-20020a056638060100b0040b671bcf15sm3516700jar.30.2023.06.13.13.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:10:37 -0700 (PDT)
Received: (nullmailer pid 2823717 invoked by uid 1000);
        Tue, 13 Jun 2023 20:10:36 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jianhua Lu <lujianhua000@gmail.com>, Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: backlight: kinetic,ktz8866: Add missing type for "current-num-sinks"
Date:   Tue, 13 Jun 2023 14:10:22 -0600
Message-Id: <20230613201022.2823392-1-robh@kernel.org>
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

"current-num-sinks" is missing a type, add it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
index e1191453c2f0..11b6fc36183d 100644
--- a/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
@@ -33,6 +33,7 @@ properties:
 
   current-num-sinks:
     description: number of the LED current sinks' channels.
+    $ref: /schemas/types.yaml#/definitions/uint32
     enum: [1, 2, 3, 4, 5, 6]
 
   kinetic,current-ramp-delay-ms:
-- 
2.39.2

