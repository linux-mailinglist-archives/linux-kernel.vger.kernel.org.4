Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5CA618F30
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 04:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiKDDjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 23:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiKDDir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 23:38:47 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420EC616D;
        Thu,  3 Nov 2022 20:38:46 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id k5so3439700pjo.5;
        Thu, 03 Nov 2022 20:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpUM4DPw4PRlVAAk+U/JNafDpQLlQw9oEkCZcgNX0RU=;
        b=LxkauC06VejSBsAckjZBGDEDRNz2SBZjQ9gMJLr9A2GtW9Y6KhTvGBRpaJ5Wr2AFIX
         wvK+Kzz2AX+Eh0jHczD5CG62G0F113vZU/t0+CAW5bwupAlaGjme9nVGIwTMYa4OABDJ
         5V0XaH9C2HWawbIoM5LLCxH7ZpHmDi6LL/P9mLFDat6mDGIaHYOT2Lsmu/E8Z+Zlj4Cw
         0t1ZMFACPl9G+/z5iChlo4hah2OfFikD9XP9ZO/YMsv6Ks4J0wRUOeB6NlpJlN2eNOpu
         sYQzrf+P/VdDyZ8EBPnq8ER/kV93OBMGrgmF01EQMY4M4wHQuKxw7PpkJH674n6KGKCn
         GPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpUM4DPw4PRlVAAk+U/JNafDpQLlQw9oEkCZcgNX0RU=;
        b=sDoxsxyf9/vszWBHfnUCwkQ9kr4kUMQu7vCUD//A+F6ALjBtnEICNd2QTHpXAsyWwF
         1H5f+qNNyXNh8n1IZHlyrdzqbUgoSopvDqIJXd6VfXNTJZz/oKEreUF1pSg9vsyKml43
         Ezu4kqY393Cu13Bgjsi5lJmjjZ2XyxlkFRjLWPK3EXR+MeAWmst9kie371xH1CStSvl8
         BQ6LOKxowa0kHcNqGeWxIpIRxl31NQq66ZccGDZndkg2O2lleOe+OXqjLBWxVjgBa28a
         tn1tDHhHs3tdX6jDSRI92cGHIhXe6+oDVO5mV+fdbKhuS+tB5140K++1mgK1N33mxeiy
         OwXg==
X-Gm-Message-State: ACrzQf14t1jVlrlwZn5Aei9bpFG9/ppSak7y+gxcxGp8i2tULQyIpuh/
        H+RxT3+G5pamguwSsxfcQYM=
X-Google-Smtp-Source: AMsMyM6Fw0X/jGTNSbL/TUfTdLbFU+ZffcKr2BAHToIRdjTd4iCwxb40S/QBdeqSm0w7I33rqwNjBQ==
X-Received: by 2002:a17:90b:3504:b0:214:199e:7e6d with SMTP id ls4-20020a17090b350400b00214199e7e6dmr16125190pjb.192.1667533125662;
        Thu, 03 Nov 2022 20:38:45 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id f17-20020aa79d91000000b0056bb06ce1cfsm1545759pfq.97.2022.11.03.20.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 20:38:45 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v6 3/5] dt-bindings: arm/npcm: Add dt-bindings for Graphics Core Information
Date:   Fri,  4 Nov 2022 11:38:08 +0800
Message-Id: <20221104033810.1324686-4-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104033810.1324686-1-milkfafa@gmail.com>
References: <20221104033810.1324686-1-milkfafa@gmail.com>
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

Add dt-bindings document for Graphics Core Information (GFXI) node. It is
necessary for the NPCM Video Capture/Encode Engine driver to retrieve
Graphics core information.

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

