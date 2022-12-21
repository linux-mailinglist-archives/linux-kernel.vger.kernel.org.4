Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D3665319E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 14:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiLUNYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 08:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLUNYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 08:24:43 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76EA1A815;
        Wed, 21 Dec 2022 05:24:42 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id w20so8909388ply.12;
        Wed, 21 Dec 2022 05:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jMBazgguIgQnT/Mfr+HQSy2WLX0y7isn8sMtEFf85Wg=;
        b=kNRsGjC3Wqkdn/++8P5gRTcdeSLguv5CIeAe43Uy8U3rmvbWCU8Dy9Zr7e0J2htilo
         Do8IGB9B9IEENSbVKZTj01xL1Rb22uR5Icx6Nc1wCQUBxSrhi5TAnfNrIC1sSvT3khfR
         7805PWzRGJ0b+BC5v3ndPamSfs5qeDdzJqWMdIq+nbD5Y3Q2QxnutoMHH2wucS7FfazU
         O+fhyYOA2JfHM2FJ8X6XbfrBbRMfoPz5S2PmI7TcUvv1XyeoINgTGKG9WeENnsUMrHl6
         Y5e8ataafW4+s503Y0rF0tlGzKFRNO3unMsjreoosE6YMnujBJQUES8MdY4otP8gj6C7
         ngtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jMBazgguIgQnT/Mfr+HQSy2WLX0y7isn8sMtEFf85Wg=;
        b=B4+mvcYi99zPxRLplp5xG+KCmCVAQZG2SLS/PlWeebcXU0pKEJGdUm+wQtewcO0stC
         LZ/L3s9KHiRLyIoxfZonn+2ywHr3dXqRocl598eIqn7ANLNCgZzNMpF4nITghc+OQ8ol
         lfXJXQVNrtma9F8uV0Y5+InmRQn+LJeUJDU8sBmwqioW6d9YNKBIPcA3PU99AlOqdZDO
         QJsdMvT879teuFQQyoTc7g64VNv4R/TQXin6luy5+pnv4kE34GBjdH+BbCoorSqx9uFn
         82Inpild0fxPtl/WsW+kxDIbHT0Q9XJNY9XCJQjsO4NVij9J3m3jUyQN2YGzuaWUrBQa
         lvxQ==
X-Gm-Message-State: AFqh2krAId8TSLRlflpVzkSHCxI9/eLeHaaU4E85qI39Dp2HmGEa4UL3
        9raW6OBH0TNVkviuJSveSmM=
X-Google-Smtp-Source: AMrXdXviajQgLWtVSDrAHnBTla7bczbaZZ5qjxiASUZtTmQMFu22hW8pKwM96yZVp4ijtFVoisaZ4Q==
X-Received: by 2002:a17:902:e382:b0:189:db2b:93ad with SMTP id g2-20020a170902e38200b00189db2b93admr1768225ple.2.1671629082341;
        Wed, 21 Dec 2022 05:24:42 -0800 (PST)
Received: from localhost.localdomain ([117.189.239.185])
        by smtp.gmail.com with ESMTPSA id q3-20020a17090311c300b0018099c9618esm11462479plh.231.2022.12.21.05.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 05:24:41 -0800 (PST)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        Jianhua Lu <lujianhua000@gmail.com>
Subject: [RESEND] dt-bindings: leds: backlight: Add Kinetic KTZ8866 backlight
Date:   Wed, 21 Dec 2022 21:24:28 +0800
Message-Id: <20221221132428.702-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.38.2
MIME-Version: 1.0
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

Add Kinetic KTZ8866 backlight binding documentation.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
 .../leds/backlight/kinetic,ktz8866.yaml       | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
new file mode 100644
index 000000000000..c63c21bf69d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/kinetic,ktz8866.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kinetic Technologies KTZ8866 backlight
+
+maintainers:
+  - Jianhua Lu <lujianhua000@gmail.com>
+
+description: |
+  The Kinetic Technologies KTZ8866 is a high efficiency 6-sinks led backlight
+  with dual lcd bias power.
+  https://www.kinet-ic.com/ktz8866/
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    const: kinetic,ktz8866
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    backlight {
+        compatible = "kinetic,ktz8866";
+
+        pinctrl-names = "default";
+        pinctrl-0 = <&bl_en_default>;
+    };
-- 
2.38.2

