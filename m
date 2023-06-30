Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA18744291
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjF3S4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjF3S4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:56:09 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF443C17;
        Fri, 30 Jun 2023 11:56:08 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-78372b896d0so92103939f.2;
        Fri, 30 Jun 2023 11:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688151367; x=1690743367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBsvzXB7J1T8smPYnRti2Y7WQp0yg4tNQa4bMVJSe5s=;
        b=GhDL6YLOXj6zcpmZQKDlxQAmtZSao/M5/o59yMiA9Zu/9NQ8LW3LJFhvL1xno1l1G2
         wlf4Ug48xdGf3GBPZxMNr6E474vApY+BTPQfeBZAYnXtemA2lBTKQlVjnaDQX++jVf3p
         Lga+axq3UpyKpPwki7k3XVGUT8J5CA8hinVv9KnBoraa9B3yEMJWrQyPazadNcZ12rf6
         AP1akpZqtiHORY/bFVgEx+Hd9MckwMBqTLl5tra3gM+gg5nn8m2E1RVxY4PC2oCRURPr
         83FdnK8HwLsI7dAU/WXkxrwGf1oiuO0hoVnW5l3R9vQwE9DzV504uUHw5unolnaJ8Al2
         89QA==
X-Gm-Message-State: ABy/qLapXf13iQP7H17TNUeMCpjOaZjkK/XsCHHn1ApvcKC/tyLZKgd4
        C2ffPMo6DOczkaSNc89tvg==
X-Google-Smtp-Source: APBJJlFbal0TSSFUEyZJj6gaS/OIeklfv37G7dQ9yMSEemrqVGCYWLyUg5LqgSoJI8r6LFLWHesWCg==
X-Received: by 2002:a92:d48e:0:b0:345:6ffa:63c5 with SMTP id p14-20020a92d48e000000b003456ffa63c5mr2738484ilg.32.1688151367484;
        Fri, 30 Jun 2023 11:56:07 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id b4-20020a92c844000000b0033e62b47a49sm2154252ilq.41.2023.06.30.11.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 11:56:06 -0700 (PDT)
Received: (nullmailer pid 2175660 invoked by uid 1000);
        Fri, 30 Jun 2023 18:56:04 -0000
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: pmu: Add Cortex-A520, Cortex-A715, and Cortex-A720
Date:   Fri, 30 Jun 2023 12:56:01 -0600
Message-Id: <20230630185602.2175559-1-robh@kernel.org>
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

Add compatible strings for the Arm Cortex-A520, Cortex-A715, and
Cortex-A720 CPU PMUs.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/pmu.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/pmu.yaml b/Documentation/devicetree/bindings/arm/pmu.yaml
index e14358bf0b9c..0cc468d6c372 100644
--- a/Documentation/devicetree/bindings/arm/pmu.yaml
+++ b/Documentation/devicetree/bindings/arm/pmu.yaml
@@ -49,7 +49,10 @@ properties:
           - arm,cortex-a77-pmu
           - arm,cortex-a78-pmu
           - arm,cortex-a510-pmu
+          - arm,cortex-a520-pmu
           - arm,cortex-a710-pmu
+          - arm,cortex-a715-pmu
+          - arm,cortex-a720-pmu
           - arm,cortex-x1-pmu
           - arm,cortex-x2-pmu
           - arm,neoverse-e1-pmu
-- 
2.40.1

