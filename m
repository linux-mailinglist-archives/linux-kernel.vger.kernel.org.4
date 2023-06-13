Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7F272EC9B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjFMULl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240347AbjFMULZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:11:25 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DE51FDB;
        Tue, 13 Jun 2023 13:11:03 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-76c64da0e46so269386139f.0;
        Tue, 13 Jun 2023 13:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686687063; x=1689279063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mUj26fejO957l4yBbEEAi9JZZ08xfdS4qcBuiIeOXuw=;
        b=AGf1ZL+JijBsIvE0/RjSZxaShk/vYU7cZbpVUEB87uBaSNetQ24V+KnPaPUqw9UizR
         bLhWdITJ6Eoja6kPrWnPGTDJg0cz3pdr1n7ECDpYSFyHCvP7vdWdBmON1Y2Bo91sKVSc
         kHsqp0C0LyYdjECrHvomOzcDw0BvlIQzKRTDXNVZoIH4r2BCVlmoWQ9Dmd5GbyygWA73
         tSt8J94BCyYF54/GvIbptjwEp3hf61XhDt6JT0ZUNDDMiSitcdJGAN1aqWMP6EXZPYEf
         tYk0Eq5fZtsXL/WYhvLnVynmpNz9ta16W5nhIP1NJ/IQu32yq3iaamOY5WwsDUeDszAv
         pxTw==
X-Gm-Message-State: AC+VfDwH400U3A+IEEEMl3yA4v0hId+2RT9tbT3UXUwDAUnrY3Lu60MA
        I7D4J9Tx5qNcrsGq7ukPmA==
X-Google-Smtp-Source: ACHHUZ7oOMR5aJtfWBZ1LlyuTCJpf3sWNQfrhOkUmJyXlASL8oj+Ddej7IKvS0CC5AIBvuDB5noIIQ==
X-Received: by 2002:a6b:6d0b:0:b0:77a:d2d3:fbde with SMTP id a11-20020a6b6d0b000000b0077ad2d3fbdemr12166870iod.3.1686687062754;
        Tue, 13 Jun 2023 13:11:02 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id v3-20020a5ec103000000b00763699c3d02sm4103356iol.0.2023.06.13.13.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:11:02 -0700 (PDT)
Received: (nullmailer pid 2824314 invoked by uid 1000);
        Tue, 13 Jun 2023 20:11:00 -0000
From:   Rob Herring <robh@kernel.org>
To:     Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: auxdisplay: holtek: Add missing type for "linux,no-autorepeat"
Date:   Tue, 13 Jun 2023 14:10:49 -0600
Message-Id: <20230613201049.2824028-1-robh@kernel.org>
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

"linux,no-autorepeat" is missing a type, add it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml b/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
index 49304a1476ab..be95f6b97b41 100644
--- a/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
+++ b/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
@@ -40,6 +40,7 @@ properties:
   linux,keymap: true
 
   linux,no-autorepeat:
+    type: boolean
     description: Disable keyrepeat
 
   default-brightness-level:
-- 
2.39.2

