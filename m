Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D19D651DCA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 10:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbiLTJml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 04:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbiLTJlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:41:52 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576BB17581;
        Tue, 20 Dec 2022 01:41:49 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 62so7947795pgb.13;
        Tue, 20 Dec 2022 01:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxkElKmgrqtTP5be0jVrJHJmBiDppX9Zdl7lKzzovCQ=;
        b=pH7Cm3mKyxTbueJoVzD5hHXBNaXyBMl+Weg3bkxZFgZroypu4OHitbdLwmedbZsyyE
         O18u+Q1nBFWSiau/ylVhwBrIseIz/0rSVXNa7hkny5sAmlFDUG255NzGqslO29ZBU8OB
         1WYm0jeJV5i5WylxSIdFztp5RGaS+lFJziyvLtLrfqjLMy2m4/642I7q6yCcv2/U9NXv
         ozvMTnfX+lHKeSRfH+ABh69a5TJvHf1Vg5YeGAwRREyIuk7Od5mMuKWbfprx9i5hoDs1
         4Qt8hAw7s+MUlb7XN4ZdekK0RU/677hP0WLBWyGQf4n316mGiZNbRHJ+hOJKRsRLtjgT
         ndcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxkElKmgrqtTP5be0jVrJHJmBiDppX9Zdl7lKzzovCQ=;
        b=oaKx3BPWWk9CzYfqLdKBZ0hHkoFJ3Vtd7MJVJyqnZTsUtoD/d4kKId+e+wQi9gnDq1
         7Kua/Pgdx9riNqP3/Je/KhrtBVTMwyKRikoFpWyqF97B320hMDuM8p2HhkIuTZt6091Q
         bjRhJb53v+9YA2wwwvCmTvjLJmzYLcrNbvuJfYUFdx32STNCDpYvu0BEFNEQah5vplPH
         E3f0fCQNKN1VugLYsu8DHSeYmwYA4Q4n3BXYmvS6z/0QM4EjjYaafA+1HdRctpjGLMLn
         W6lE20w6DWYbp3h5uuPtLP/jM+NdzfoghWSm/Y2qLzU2dQMujbHFaxwxR1NBczVFjKJ7
         8B0A==
X-Gm-Message-State: AFqh2kpfEx4r4z5S2zB+G5aN4MTj6dpGm4N2MHCxHZDpOUn7rBY8as3j
        pdvbhxAi9XDJoE7g/LJmIDg=
X-Google-Smtp-Source: AMrXdXvR6xLrhW/hIn8vNNF3Xc7BCym3+D0fHxWVUigoUhSfjztDLfahsDGOZDi5cCqzfQH/ThdibQ==
X-Received: by 2002:aa7:8541:0:b0:57f:f2cd:6180 with SMTP id y1-20020aa78541000000b0057ff2cd6180mr5115033pfn.0.1671529308752;
        Tue, 20 Dec 2022 01:41:48 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id b17-20020a621b11000000b00576a89978e5sm8210230pfb.63.2022.12.20.01.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 01:41:48 -0800 (PST)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrzej.p@collabora.com
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kflin@nuvoton.com,
        Marvin Lin <milkfafa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 3/7] dt-bindings: arm: nuvoton: Add bindings for NPCM GFXI
Date:   Tue, 20 Dec 2022 17:40:51 +0800
Message-Id: <20221220094055.3011916-4-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221220094055.3011916-1-milkfafa@gmail.com>
References: <20221220094055.3011916-1-milkfafa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings document for Graphics Core Information (GFXI) node. It
is used by NPCM video driver to retrieve Graphics core information.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/arm/npcm/nuvoton,gfxi.yaml       | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml

diff --git a/Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml b/Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml
new file mode 100644
index 000000000000..c033128e567a
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/npcm/nuvoton,gfxi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Graphics Core Information block in Nuvoton SoCs
+
+maintainers:
+  - Joseph Liu <kwliu@nuvoton.com>
+  - Marvin Lin <kflin@nuvoton.com>
+
+description:
+  The Graphics Core Information (GFXI) are a block of registers in Nuvoton SoCs
+  that analyzes Graphics core behavior and provides information in registers.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - nuvoton,npcm750-gfxi
+          - nuvoton,npcm845-gfxi
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    gfxi: gfxi@e000 {
+      compatible = "nuvoton,npcm750-gfxi", "syscon";
+      reg = <0xe000 0x100>;
+    };
-- 
2.34.1

