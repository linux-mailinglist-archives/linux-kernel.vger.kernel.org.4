Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB9672EC84
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240328AbjFMUKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237764AbjFMUKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:10:07 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742C41BDC;
        Tue, 13 Jun 2023 13:10:06 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-33b1e83e204so26284505ab.1;
        Tue, 13 Jun 2023 13:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686687005; x=1689279005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0SbnFlItAWad/ujWZeSpUG23g+KB9i3Y20nYCUuAL0w=;
        b=YqgKvwoamk40ZaqyKU9vnUkABr3f6isvqE6OpQD4aIF/JcQpl4SFeJr9ypz58JDmpy
         b7tQOPc4s8KbUQLRhpFYNBgqpceuvFiNLKS233n7DuZ6qjfEwcLoc1xhz9Z395NVo7z/
         rhpIAcngnRsyvOWrVLBWqEzbF1T7XQlQMaEtVOWuclk8Rd4oBshE8hXCOFjnz5Ebmsi0
         c/bDt5d9NInuFWEx9GNAZkuNWLZlVPa3MvcNd8RLeXFbpBlYztuFnqGwYc2KVlwoiz0B
         wvZ8rcBki0BayYu6xikW46wfKs5IetZoDmzZrEALJ1gGR+nkGC96XNx/0dVzGgn3VXsG
         cjxQ==
X-Gm-Message-State: AC+VfDy8oIh3JlZksnrZQHLY9LcrTmWt2x0xAl5CLduVmEdQmt7RnYX9
        hOY14oWOE5jXTfNjk261pw==
X-Google-Smtp-Source: ACHHUZ7Kk3TGuBb9HcJOEiIT87QDlrASPfN1Hv6HgdKE+ubylXIM2EjkG75/5Al1Z1Rtd/T2ExTvzw==
X-Received: by 2002:a92:c64b:0:b0:340:54f1:35dc with SMTP id 11-20020a92c64b000000b0034054f135dcmr3996014ill.18.1686687005685;
        Tue, 13 Jun 2023 13:10:05 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id e6-20020a92de46000000b0033bdfbbb5ebsm4032754ilr.42.2023.06.13.13.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:10:04 -0700 (PDT)
Received: (nullmailer pid 2822918 invoked by uid 1000);
        Tue, 13 Jun 2023 20:10:03 -0000
From:   Rob Herring <robh@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Lee Jones <lee@kernel.org>,
        Alexandre Courbot <acourbot@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] regulator: dt-bindings: pwm-regulator: Add missing type for "pwm-dutycycle-unit"
Date:   Tue, 13 Jun 2023 14:09:56 -0600
Message-Id: <20230613200956.2822740-1-robh@kernel.org>
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

"pwm-dutycycle-unit" is missing a type, add it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/regulator/pwm-regulator.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/regulator/pwm-regulator.yaml b/Documentation/devicetree/bindings/regulator/pwm-regulator.yaml
index 7e58471097f8..80ecf938b749 100644
--- a/Documentation/devicetree/bindings/regulator/pwm-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/pwm-regulator.yaml
@@ -64,6 +64,7 @@ properties:
         defined, <100> is assumed, meaning that
         pwm-dutycycle-range contains values expressed in
         percent.
+    $ref: /schemas/types.yaml#/definitions/uint32
     default: 100
 
   pwm-dutycycle-range:
-- 
2.39.2

