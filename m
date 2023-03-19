Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBE86C037B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 18:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjCSRai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 13:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjCSRaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 13:30:35 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BD91423A;
        Sun, 19 Mar 2023 10:30:34 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id h5so5426730ile.13;
        Sun, 19 Mar 2023 10:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679247033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3OyXeMWwUcICjLt5skJDFYn4DtNOe/WaaKZtvUJ6fbQ=;
        b=39bf/3Lqv1ZLXoZal1l1swuVDQBFnmnOh1D5OHaTb2FkJqKFF4Ub97HhqnWfFgVN+v
         Dr0+ykeBsjhBwbX0ZPtPRSvkUp8encpHpgQXhj8zd/dUaiia2M3qzeheid7R51mYgRp3
         Q9z9Ow5oMKpOniOkpmKdA6T/KtIc5bAdph/CO+SFQbb1o56lB+xW0+rRSTVxyDQnM23P
         C94byvpy+YBmoYFCbcDCD4c41eCJwgkOTl7Ln8ZqJQPfvTFkBrNxG3KBNr2GPtg2QEAF
         szixmp34qvZn7lqOfGZc9a4yki0SICBqNAq8yhcpwtPec1vBnoR+mTw0yGMornfTJq2e
         BGow==
X-Gm-Message-State: AO0yUKXmToOdzAy55JYDeXM6lyLU60f30Z2XDB2cc01x1B0oddhL8SXu
        SsBf8wftRyiXh/Y1hQRwqA==
X-Google-Smtp-Source: AK7set8ACMMvQgQNUSW8MZKD/yXBXF9f59lk/bVOHbqn7d499Uw5wsnlVpVGfw6TSXLh+x3kZp6H0A==
X-Received: by 2002:a92:d083:0:b0:315:3421:ef2a with SMTP id h3-20020a92d083000000b003153421ef2amr3551536ilh.25.1679247033336;
        Sun, 19 Mar 2023 10:30:33 -0700 (PDT)
Received: from robh_at_kernel.org ([2605:ef80:80c2:711:b843:6628:3fd6:ded4])
        by smtp.gmail.com with ESMTPSA id q12-20020a05663810cc00b003e8a17d7b1fsm2617956jad.27.2023.03.19.10.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 10:30:33 -0700 (PDT)
Received: (nullmailer pid 30794 invoked by uid 1000);
        Sun, 19 Mar 2023 17:30:24 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: mmc: fujitsu: Add Socionext Synquacer
Date:   Sun, 19 Mar 2023 12:30:06 -0500
Message-Id: <20230319173006.30455-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Socionext Synquacer SDHCI. This binding has been in use for
some time.

The interrupts were not documented. The driver only uses the first
interrupt, but the DT and example have 2 interrupts. The 2nd one is
unknown. "dma-coherent" was also not documented, but is used on Synquacer.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Rebase on conversion done by Kunihiko
---
 .../bindings/mmc/fujitsu,sdhci-fujitsu.yaml       | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/fujitsu,sdhci-fujitsu.yaml b/Documentation/devicetree/bindings/mmc/fujitsu,sdhci-fujitsu.yaml
index 73d747e917f3..430b62899397 100644
--- a/Documentation/devicetree/bindings/mmc/fujitsu,sdhci-fujitsu.yaml
+++ b/Documentation/devicetree/bindings/mmc/fujitsu,sdhci-fujitsu.yaml
@@ -14,9 +14,13 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - fujitsu,mb86s70-sdhci-3.0
-      - socionext,f-sdh30-e51-mmc
+    oneOf:
+      - items:
+          - const: socionext,synquacer-sdhci
+          - const: fujitsu,mb86s70-sdhci-3.0
+      - enum:
+          - fujitsu,mb86s70-sdhci-3.0
+          - socionext,f-sdh30-e51-mmc
 
   reg:
     maxItems: 1
@@ -29,6 +33,11 @@ properties:
       - const: iface
       - const: core
 
+  dma-coherent: true
+
+  interrupts:
+    maxItems: 2
+
   resets:
     maxItems: 1
 
-- 
2.39.2

