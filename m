Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56A0656E59
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 20:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiL0TdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 14:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiL0TdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 14:33:07 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FC3D2C5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 11:33:06 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id d123so7330326iof.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 11:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NE5d0lxAdxXOL2nWwxUeL+Wf2ItY+N8jvCklovTdI8=;
        b=ZU7hVaxlc2Z6/FY0OVxnYgSn1236LzQmO45sPj4Rnz6qGZuzu6mf76ojheaMgApR3S
         A+keFrT6ujnMgVXrk85N3uZiQHVmkALI7AuOk8ixSsibcZRcR66BGH76Pc7gB++UbezD
         +xmhXK1Ol5kHxHg0gUGBkiu/dM8VNODTRppso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NE5d0lxAdxXOL2nWwxUeL+Wf2ItY+N8jvCklovTdI8=;
        b=S2tTnfIhyhjiMTYW6twImEJHjmRfT4dZkl73wteMt96RlSx2gQrbLRJNY6ST9tpWHb
         hfcR7sGLlARObxiRZtO4OPBV7Lui9/4dB8NvNPXAOy3FgpTg4bDL/C113sVc/e86st6U
         tDuZeIufSkmeUPe0lvCJxKrKa6DMu61ntaOmJItNTrt8dvQflz/uAsfnQi5sF3DN9SKn
         SkbnceF1+SWhvoBZFkczKyHP5TptIcReZzxNtk15aUFF0CNAkztzfxkZbCXUvKK+qpgX
         zpFsLqUqikIc3rTaZSeBEXDa3Uk/tJtaPrWWNQ9ZoC/PLrgoLA4f2plrNC2myKj/izfS
         UJLw==
X-Gm-Message-State: AFqh2krwgQJcneYiMJK8DDtFh2jh56kjwmf3TQ47ribBc9QpngFe/fpo
        y5db9Eyvbmqj0pzguyxCTkYzqASU+9WCXxlA
X-Google-Smtp-Source: AMrXdXsP/YWzJ2jJguC0rczqMhzG3Croiw/nM0t9TB0bu5KL/yr4iwHHaC7myyEdSjjTAfBFIeYhng==
X-Received: by 2002:a6b:d919:0:b0:6e9:9776:a6c8 with SMTP id r25-20020a6bd919000000b006e99776a6c8mr23184159ioc.2.1672169585446;
        Tue, 27 Dec 2022 11:33:05 -0800 (PST)
Received: from markhas1.corp.google.com ([100.107.108.223])
        by smtp.gmail.com with ESMTPSA id a10-20020a02ac0a000000b003755a721e98sm4504995jao.107.2022.12.27.11.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 11:33:05 -0800 (PST)
From:   Mark Hasemeyer <markhas@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Raul Rangel <rrangel@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Mark Hasemeyer <markhas@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org
Subject: [PATCH v13 2/3] dt-bindings: mfd: cros-ec: Add UART compatible string
Date:   Tue, 27 Dec 2022 12:32:23 -0700
Message-Id: <20221227123212.v13.2.I9e018ecb8bdf341648cb64417085978ff0d22a46@changeid>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221227123212.v13.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
References: <20221227123212.v13.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhanu Prakash Maiya <bhanumaiya@chromium.org>

Add a compatible string to support the UART implementation of the cros
ec interface. The driver does not support the reg and interrupt
properties, so exempt them from being required for UART compatible nodes.

Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
Co-developed-by: Mark Hasemeyer <markhas@chromium.org>
Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v13:
- No change

Changes in v12:
- No change

Changes in v11:
- Update commit message to include device

Changes in v10:
- No change

Changes in v9:
- Rebase onto for-next
- Update node-name from uart0 to serial
- Remove reg and interrupt property requirement for UART compatible
  nodes.
- Update authorship

Changes in v8:
- Update commit message

Changes in v7:
- No change

Changes in v6:
- No change

Changes in v5:
- No change

Changes in v4:
- Changes in commit message.

Changes in v3:
- Rebased changes on google,cros-ec.yaml

Changes in v2:
- No change

---
 .../bindings/mfd/google,cros-ec.yaml          | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index 3d5efa5578d1b..cdf1d719efe9d 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -33,6 +33,9 @@ properties:
       - description:
           For implementations of the EC connected through RPMSG.
         const: google,cros-ec-rpmsg
+      - description:
+          For implementations of the EC connected through UART.
+        const: google,cros-ec-uart
 
   controller-data: true
 
@@ -187,6 +190,15 @@ allOf:
       properties:
         mediatek,rpmsg-name: false
 
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              enum:
+                - google,cros-ec-rpmsg
+                - google,cros-ec-uart
+    then:
       required:
         - reg
         - interrupts
@@ -299,4 +311,12 @@ examples:
         vdd-supply = <&pp3300_fp_mcu>;
       };
     };
+
+  # Example for UART
+  - |
+    serial {
+        cros-ec {
+            compatible = "google,cros-ec-uart";
+        };
+    };
 ...
-- 
2.39.0.314.g84b9a713c41-goog

