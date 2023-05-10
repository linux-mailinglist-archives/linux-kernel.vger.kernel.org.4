Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9306FE443
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbjEJS4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEJS4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:56:37 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B2B128;
        Wed, 10 May 2023 11:56:34 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-24de9c66559so5408328a91.0;
        Wed, 10 May 2023 11:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683744994; x=1686336994;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K+VF2cenGaqPThFTtrzmmuO5OlyCDcnj1nuwccLlAO4=;
        b=OjrR/ayeoIMIBguaKTn9DcEVjZ49C9hak/6fsfckw3hPUuFZWDXtPZ9dnHgYxscdi3
         HujEox9sq2doYRtDfuvPXRHPMIXqX2OmaDi08jyvnWvdfdL3DLaSid6P1R85QG9KgFdD
         iFuWpESmIPwdBWme90X0kMUJzjoWjeFT1hd13fvyjYhEFNeHHJLvKf7qECTCxG/TkFpI
         Py3Jho/jv87NLQB91tVZ8g5/cf2thvu+vyHvB9Av2P0jRIk7EHOBTKF+8f2s8Ek/Zc2h
         uIc7b9TyqEB1S2T1H0GqDbTVio3hC1yXJ86BdgWRUpYbdNEaxW02woF0pgW2iR5L8EBV
         t7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683744994; x=1686336994;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K+VF2cenGaqPThFTtrzmmuO5OlyCDcnj1nuwccLlAO4=;
        b=GNjLL37HFA0fZxWc3cndv51hGckr6egLn6kOsulFnELzf/7TIbQnmciGPJYh7oX78K
         zIgSs/e99ZAXMPkH/fdi6KnqzQpTQikDFp2O8F4ilvA8lMCi9qB8eBmnU+Ut2TiUKQKs
         yT2Gj78VLaWspxkMyfg1+MPEnrys3G0gnLq5gfzxcsq473XDL8M/3louo9jLs2Jchp4G
         TJjYdjNje6TZLXvjjUZ9PRhBMuNdo0OeVsbfV0XlqpbDjtLrv6rqbitElcZwy+3L2mbO
         c6tZ/blmfT9h8h/Z8SqLXRYVDOlmTkuQ70aPmTd4n1r3Xch/RRnsfsmWgECSFGFxz/cE
         8h4Q==
X-Gm-Message-State: AC+VfDx7+E/N5lQ2g/MWjCUmLkUrQ8VLKPqfX3/btYNTyR7mfkFPOpeu
        7y5Wex898Bcuzdi7K55AxQswEFtHClWlgg==
X-Google-Smtp-Source: ACHHUZ4fEqdWtbErDiyNfBvmE8x8eFLMQaahpMGODJGNB9tPZQ/SFPalSsTeXoockjBtSnWUBtYQdQ==
X-Received: by 2002:a17:90a:e398:b0:24e:5bc0:355e with SMTP id b24-20020a17090ae39800b0024e5bc0355emr18649333pjz.2.1683744993600;
        Wed, 10 May 2023 11:56:33 -0700 (PDT)
Received: from yoga ([2400:1f00:13:cea:b660:cefb:7eb9:2b8f])
        by smtp.gmail.com with ESMTPSA id q4-20020a17090a304400b0024e2230fdafsm15797974pjl.54.2023.05.10.11.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 11:56:33 -0700 (PDT)
Date:   Thu, 11 May 2023 00:26:25 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Anup Sharma <anupnewsmail@gmail.com>,
        Peter Meerwald <pmeerw@pmeerw.net>, broonie@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: iio: temperature: Add DT bindings for TMP006
Message-ID: <ZFvo2TIiPiMFlbXC@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding document for TMP006, IR thermopile sensor.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 .../bindings/iio/temperature/ti,tmp006.yaml   | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/ti,tmp006.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp006.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp006.yaml
new file mode 100644
index 000000000000..c6c5a4d10898
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp006.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/temperature/ti,tmp006.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI TMP006 IR thermopile sensor
+
+maintainers:
+  - Peter Meerwald <pmeerw@pmeerw.net>
+
+description: |
+  TI TMP006 - Infrared Thermopile Sensor in Chip-Scale Package.
+  https://cdn.sparkfun.com/datasheets/Sensors/Temp/tmp006.pdf
+
+properties:
+  compatible:
+    const: ti,tmp006
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        tmp006@40 {
+            compatible = "ti,tmp006";
+            reg = <0x40>;
+        };
+    };
-- 
2.34.1

