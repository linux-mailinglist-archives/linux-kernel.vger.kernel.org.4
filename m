Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0C2631EE5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiKUK6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKUK6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:58:38 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6749E951;
        Mon, 21 Nov 2022 02:58:36 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id bj12so27514078ejb.13;
        Mon, 21 Nov 2022 02:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yuufDN8MAkZ+z/1NDCLZ9tHt7lifmvSE7ROToVJ/Z04=;
        b=ZLoPWLhoKYxmHi/+IEWgDRPnqyYviYWLV2Jv3fhHz4fokTK+GyWrKFeWB7iIwuoSTz
         Quf2F9gQ7o0rGRz0uKepfni+gYMcuVSWOXz8HuXsvBJcxzEc1Z49vHixl0t6xsU4sBYH
         FN/3u2GhJ+gEC8xhq7k6JBDttv/s3SbT5fNUgDAAUWjgaTdlsaHfQUvdxVzOvh0XY2NN
         II+b9Hrg8zgRJ1FxdZpxY9RRrhVxg0EWAda9OKconHCmHU2uk9rTF+9t2RVuBcc/SnG7
         HK4W+EjgDr0EDbn41X0qNZkiMuVir3Dhy2Q4v0rKlXZkIB7AKHsiiibfm6TTRYYGPO2K
         GdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yuufDN8MAkZ+z/1NDCLZ9tHt7lifmvSE7ROToVJ/Z04=;
        b=6hna8scE0Je+fjLlbhtjSC8mw7j6xtlloCMp0u9H9odR5RJdLUAtm4SOIO6OMqVt0V
         7oOf644ls8ARMdPTrPF34ucDnPinTjFws4IiQRSTqUaE28/Lm2uSiW0pmNRxrU8MiyLC
         vowt7Vn9+eFuMsAZTdGUWIACGgreOcKvFoVyWPmuS9M+3ngURxlH9uGO2jmHefybUp2K
         gBAAEMhXpTFzpaV5yMSehlWA421rbcjR/HxXSlODQxDL8Lfyq6vxgjQS/mMhLwNWIOHF
         +VEZVfmEKvnCq3MNL5GeP5hyd79z9eE8jaw1L/yZUaE47zun5GuPFuGdaw6a+ObWyu2J
         9OPQ==
X-Gm-Message-State: ANoB5pk9J9q9DUO5V/L0PEJeWEvjmtJenbB1rop41kLYsjNVp4QCJ9l0
        7k3oA8BlrXw7rOC5wszrmic=
X-Google-Smtp-Source: AA0mqf54asC375YIqRZi1ostE5mdXb4wOP9ZiJG3ecr1g4Kt9CqeEvbwGhIPZ6W7NP+kX0CDNqsmpQ==
X-Received: by 2002:a17:906:901:b0:7ae:23c:3cb4 with SMTP id i1-20020a170906090100b007ae023c3cb4mr14566927ejd.599.1669028315126;
        Mon, 21 Nov 2022 02:58:35 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id mf20-20020a1709071a5400b0078a543e9301sm4869041ejc.200.2022.11.21.02.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 02:58:34 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH dt-schema.git] schemas: add NVMEM cell with #nvmem-cell-cells
Date:   Mon, 21 Nov 2022 11:58:30 +0100
Message-Id: <20221121105830.7411-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Some NVMEM cells may provide more than 1 value. An example can be base
MAC address that is used for calculating multiple MACs (for few
different devices). For specifying value to read phandle needs to be
used with an argument.

Cc: Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>
Cc: Michael Walle <michael@walle.cc>
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
This bit is required for moving forward with the
[PATCH v2 00/20] nvmem: core: introduce NVMEM layouts
https://lore.kernel.org/linux-arm-kernel/20220901221857.2600340-1-michael@walle.cc/

As pointed out by Rob #nvmem-cell-cells should be added to the dt-schema
and not a Linux binding:
Re: [PATCH v2 15/20] dt-bindings: nvmem: add YAML schema for the sl28 vpd layout
https://lore.kernel.org/linux-arm-kernel/20220912192038.GA1661550-robh@kernel.org/

sl28 is one example that needs #nvmem-cell-cells
u-boot,env is another one

Please let me know if I got this binding right at all.
---
 dtschema/schemas/nvmem/nvmem-cell.yaml | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 dtschema/schemas/nvmem/nvmem-cell.yaml

diff --git a/dtschema/schemas/nvmem/nvmem-cell.yaml b/dtschema/schemas/nvmem/nvmem-cell.yaml
new file mode 100644
index 0000000..dfa99b8
--- /dev/null
+++ b/dtschema/schemas/nvmem/nvmem-cell.yaml
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: BSD-2-Clause
+$id: "http://devicetree.org/schemas/nvmem/nvmem-cell.yaml#"
+$schema: "http://devicetree.org/meta-schemas/base.yaml#"
+
+title: NVMEM Cell Common Properties
+description: "Schema for NVMEM cell devicetree bindings"
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+# always select the core schema
+select: true
+
+properties:
+  "#nvmem-cell-cells":
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description: >
+      Some NVMEM cells may consist of raw data that requires some extra
+      processing. They may provide more than 1 value.
+
+      Passing extra argument(s) allows selecting data to access.
+
+additionalProperties: true
-- 
2.34.1

