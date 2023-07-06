Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C610E74A552
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 22:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjGFUzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 16:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGFUzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 16:55:13 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404A21992;
        Thu,  6 Jul 2023 13:55:10 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-34611de0ee4so4341195ab.0;
        Thu, 06 Jul 2023 13:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688676909; x=1691268909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aVukZwI0IOMjnv4hyH2oqxidljYpWmvRhbJtUvocg6g=;
        b=G6OsCpaZbTCtRun6sjL9NmAkv32miqpUxSFBNXd5HAzT08mzWyClJFDc2h8G/lSCk9
         o47ctnNF4ZnTE85ipW703JBlBxyjHI1nR+bo9bLBisRQkjmE8ZYMOBAe4jtGPQl8LjU8
         oJ5PgsdxApVfW8BufIttJHwqqs8NHkUaCpSqqirNxKongUX/VcZo0PhvuCIT6rlY1oRi
         T+DXRttegaXeASw0j/WrQCgUtK5km6+XcpU4nYI2U0qQ2gJmzGkK1WjhgXOzsnSWw1ue
         T17tF085y5o0UiomBWQ6yBaXyL+BTjVuMma6K1nywy5A9lQDy/iFaeyUe8sL3/0Uxsi1
         n2wA==
X-Gm-Message-State: ABy/qLagQHTrFgmCeMnPRhu4Ct6Nj15giZJkQwk1mzPth3s8cXqWWOUn
        N2J6h3XfYco6xbeCw6SLgA==
X-Google-Smtp-Source: APBJJlEtrBC8b2uceobgUA8vZfqeg1x06SpsIhly69f5IFf1Mwk90kWZGYAtdyD12QvaqV4SGT0btA==
X-Received: by 2002:a92:dccb:0:b0:345:dd77:8ab9 with SMTP id b11-20020a92dccb000000b00345dd778ab9mr3059918ilr.11.1688676909378;
        Thu, 06 Jul 2023 13:55:09 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id w16-20020a92c890000000b0034632ab31c9sm767804ilo.21.2023.07.06.13.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 13:55:08 -0700 (PDT)
Received: (nullmailer pid 308606 invoked by uid 1000);
        Thu, 06 Jul 2023 20:55:07 -0000
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: arm: pmu: Add Cortex A520, A715, A720, X3, and X4
Date:   Thu,  6 Jul 2023 14:55:03 -0600
Message-Id: <20230706205505.308523-1-robh@kernel.org>
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

Add compatible strings for the Arm Cortex-A520, Cortex-A715,
Cortex-A720, Cortex-X3, and Cortex-X4 CPU PMUs.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Also add Cortex-X3 and Cortex-X4
---
 Documentation/devicetree/bindings/arm/pmu.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/pmu.yaml b/Documentation/devicetree/bindings/arm/pmu.yaml
index e14358bf0b9c..99b5e9530707 100644
--- a/Documentation/devicetree/bindings/arm/pmu.yaml
+++ b/Documentation/devicetree/bindings/arm/pmu.yaml
@@ -49,9 +49,14 @@ properties:
           - arm,cortex-a77-pmu
           - arm,cortex-a78-pmu
           - arm,cortex-a510-pmu
+          - arm,cortex-a520-pmu
           - arm,cortex-a710-pmu
+          - arm,cortex-a715-pmu
+          - arm,cortex-a720-pmu
           - arm,cortex-x1-pmu
           - arm,cortex-x2-pmu
+          - arm,cortex-x3-pmu
+          - arm,cortex-x4-pmu
           - arm,neoverse-e1-pmu
           - arm,neoverse-n1-pmu
           - arm,neoverse-n2-pmu
-- 
2.40.1

