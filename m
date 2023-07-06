Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6FF74A546
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 22:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjGFUxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 16:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjGFUxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 16:53:47 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6929D;
        Thu,  6 Jul 2023 13:53:46 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3460b67fdd8so4473505ab.0;
        Thu, 06 Jul 2023 13:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688676826; x=1691268826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QmQlTYnbBO7R2y5tWSbbd2m1y7eVu/gcaftDtIQ03T4=;
        b=M+kx9tnsJIGhUCdxlR5hM9B47L5M8xifvVk6v932/5z0Oj65TyD7LVQJFH459ET0ln
         uy1YbLAWg4ep8nWPmnZ2FqdrgHvoIerPkLdByyBnUYDuIvEtvT+O7JNTNlU0d97aCuMB
         sD1fF2lYAHATxMop/1mfiRII/b3rGe/9nZpHFfjmvF0+8Z+SgyQ4gz18T88zNe7WSUzL
         b69UKlndu3v3exDLMu//1pZJvsdbv6QNTYc7xSq/I9GW3T6FXnyDu9pt03IJjkYjK6Op
         LvkjIC5hLtEf4ahZWzMRZ3Ute7p6L2bgHT+/59gmakQ4IPybBvGUnetZQhOfPCW81qDl
         2Hzg==
X-Gm-Message-State: ABy/qLY3+zd8VMshT//+5uCBm9JBW3NBG7kFbGqWnrWfny2khqu/zkyH
        eTAsvw/i34TcXagMm/0FfA==
X-Google-Smtp-Source: APBJJlFBZXyr9owyggFM+k8tIXdwksUQtmvJBi274bxuyokVJOmryuNTKBlOKKE+NLYnM9wqKMZCTw==
X-Received: by 2002:a92:db4c:0:b0:345:baef:842b with SMTP id w12-20020a92db4c000000b00345baef842bmr2980057ilq.25.1688676826136;
        Thu, 06 Jul 2023 13:53:46 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id r16-20020a028810000000b0042b0a6d899fsm767400jai.60.2023.07.06.13.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 13:53:45 -0700 (PDT)
Received: (nullmailer pid 306726 invoked by uid 1000);
        Thu, 06 Jul 2023 20:53:44 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: arm: cpus: Add Cortex A520, A720, and X4
Date:   Thu,  6 Jul 2023 14:53:34 -0600
Message-Id: <20230706205334.306483-1-robh@kernel.org>
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

Add compatible strings for the Arm Cortex-A520, Cortex-A720, and
Cortex-X4 2023 CPUs.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Also add Cortex-X4
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 9e6a45eea4e5..0d17cbad9778 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -143,8 +143,10 @@ properties:
       - arm,cortex-a78ae
       - arm,cortex-a78c
       - arm,cortex-a510
+      - arm,cortex-a520
       - arm,cortex-a710
       - arm,cortex-a715
+      - arm,cortex-a720
       - arm,cortex-m0
       - arm,cortex-m0+
       - arm,cortex-m1
@@ -158,6 +160,7 @@ properties:
       - arm,cortex-x1c
       - arm,cortex-x2
       - arm,cortex-x3
+      - arm,cortex-x4
       - arm,neoverse-e1
       - arm,neoverse-n1
       - arm,neoverse-n2
-- 
2.40.1

