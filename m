Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB6F6337AF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbiKVI6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbiKVI5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:57:55 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D719DF3E;
        Tue, 22 Nov 2022 00:57:53 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id g62so13766544pfb.10;
        Tue, 22 Nov 2022 00:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QxFvzBEseMTXAk5Jvzlkce9dFiJ2il9L5+/p6IBYfc=;
        b=pnhW6tKc7Iix9m89ow1QuJxbrLzebAZ4ATVfU3NcdQGTUgxy1NMQOg2lUfNFKKXYHU
         zLgmQBJ/mhN46QABh5yMzHvwxkKgB6EdzA+6I57r+JTP86LWYPAfrp0fLvRwVdJVRotn
         HaPK17BQ983IcUpTfsYMUBLtaLQl7rpDi8IgVzXdlBuswHRiYoQLEa0y7krQUy2Ur3ul
         B8w/OIHYBYSPGKLP5OgaqYOhaS8HQDQL0LMaKOLMeWa47tKlHPZK8+GUwSvx2rSocH/h
         kjeFVI0i2+f0twuTo1QsSj37uX3612wBElIyz924KxTyvdvEEvpaj/JWsjbn+gDGlz4D
         fsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QxFvzBEseMTXAk5Jvzlkce9dFiJ2il9L5+/p6IBYfc=;
        b=fTWI+anFfz5gtGg96jAddYvsLdJSJ1y8ovWs1PDNK3zcM/Fyvzv+0SnJgsNmtyH7pP
         EOaYMb13ytTdb2lO/a21Jie2SA+aQ3yvnrZC7WRLFF+gLlQB7Wup2u6ZgmmnD2K359Ml
         u4mM+yhLI0f7g0CPefhxZ3AN5DTcwN7igIdOgc7jUi85NXf7vjuyWkYuszHbqT7WvLve
         946+wsHbjjrc4PmbmyylCzj58iAnYkrXNkByfwjmp21Bpbtj9I1WWo9v/wio5Jj0s8JT
         k+SwHlMjzcu5QKi4miKB4LKV5T/1JEQGL+1C6yHdqXZt62cIIHGU01NzAyYP+RZv+pz2
         TFTw==
X-Gm-Message-State: ANoB5pn/54XGDKlwlKb3iFM5X89bx75CT/w9f3MAFsSmtO/3M1VQVvsE
        wfBZcLWHUl3RxHeap+YKl04=
X-Google-Smtp-Source: AA0mqf79v+hNxUODIHjJkHCLqwtR6BYlOh8mu8/V/UZMVjP91iQc1EvU9lnDaviLyE/2ZR/mMHElag==
X-Received: by 2002:a05:6a00:21c8:b0:562:e0fb:3c79 with SMTP id t8-20020a056a0021c800b00562e0fb3c79mr3077062pfj.39.1669107473001;
        Tue, 22 Nov 2022 00:57:53 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b0017a0668befasm11400246ple.124.2022.11.22.00.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 00:57:52 -0800 (PST)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v7 3/7] dt-bindings: arm: nuvoton: Add bindings for NPCM GFXI
Date:   Tue, 22 Nov 2022 16:57:20 +0800
Message-Id: <20221122085724.3245078-4-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221122085724.3245078-1-milkfafa@gmail.com>
References: <20221122085724.3245078-1-milkfafa@gmail.com>
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
---
 .../bindings/arm/npcm/nuvoton,gfxi.yaml       | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml

diff --git a/Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml b/Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml
new file mode 100644
index 000000000000..5b785bda5739
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
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
+  that analyzes Graphics core behavior and provides inforomation in registers.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - nuvoton,npcm750-gfxi
+          - nuvoton,npcm845-gfxi
+      - const: syscon
+      - const: simple-mfd
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
+      compatible = "nuvoton,npcm750-gfxi", "syscon", "simple-mfd";
+      reg = <0xe000 0x100>;
+    };
-- 
2.34.1

