Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7B065337E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 16:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiLUPgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 10:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbiLUPfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 10:35:38 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506BA24F39;
        Wed, 21 Dec 2022 07:32:17 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id u4-20020a17090a518400b00223f7eba2c4so2406293pjh.5;
        Wed, 21 Dec 2022 07:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dX5Ufydbl+p2sHxSvGtWPn7nIriGhnFrTMO/deTHyGc=;
        b=iiWcSXNheQcb430tsQZJphtJrB+Ja/HWXMfg3h7fPve0YOLZfED3bTDNHtGmGlvP9x
         N/pP/6ztIdMvRdO6X826MByELkp0Jas+8v6Jt52Y6qhDg0e8kh9zKpEcXqio+p1Vd+/X
         2yrtWvoxOV19rBVa0IiL0XyzBN01Kf86VA49yynFC9xVGS0fDBAzjXJrk8aeFlFd7cFD
         q/ndB6hwC3p3fYURXJtwIToBuZFA9dTLJHZxPw545c4V2zeTOKY4pAUupe1zcC6Y2mm7
         FfQEF73g3gENaScT5fXfRxMD4v8rGKDTyDAp8p03HiNl3nsiF1cgy225Hnq85cAOXgnG
         KM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dX5Ufydbl+p2sHxSvGtWPn7nIriGhnFrTMO/deTHyGc=;
        b=h366jOBxzJDK3xx5OKMy0NxxAtNOZrNgVbH6mWA+dpH8NUToNBH8DdOGV4wUjhqmDD
         hmmZjExYTvDckMtXsvxpNNnoqrr1U3qDSYOGrudSrgmvfrbw8F9+3xF1yAuBPo+CHNlS
         7ZmS8sQRfSfHsDzvSvAqrfkwCc/0/q2VHirWwfamNVcRN6rEe013a6pPeHXVLXS1ZtX/
         D+QklIMWzNmFBNtnvduufznj2jVhQ7/dAOhVLIuyBoVi1ef7iQ1BCtrq/FUKCwSncb5S
         xxEcYxcd5XZdApVZ/GKN1weHcUX/rJwL+3e0+OfxOfaT5GC3z98bh9p9OKR6j7cxCauN
         qOgQ==
X-Gm-Message-State: AFqh2kpldTUrcrD0ZaSFa7W5waZp/w4RjinkcPD7NSx77WkqkiBLR3u7
        vUaPVWLB6f5MYZ7eazoWlN0=
X-Google-Smtp-Source: AMrXdXv3PJXfMd9ydRhNUnF86mNqHkZssnnnst4tlLt8CwvNSmBzGTR5Nw9Y5XwRR01EpbYoAIJ+ag==
X-Received: by 2002:a17:902:db85:b0:189:9fb2:2558 with SMTP id m5-20020a170902db8500b001899fb22558mr2574891pld.1.1671636736830;
        Wed, 21 Dec 2022 07:32:16 -0800 (PST)
Received: from localhost.localdomain ([45.62.172.3])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b00186ff402508sm11633409plf.281.2022.12.21.07.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 07:32:16 -0800 (PST)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-fbdev@vger.kernel.org, Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH v2 2/2] dt-bindings: leds: backlight: Add Kinetic KTZ8866 backlight
Date:   Wed, 21 Dec 2022 23:31:54 +0800
Message-Id: <20221221153154.25411-2-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20221221153154.25411-1-lujianhua000@gmail.com>
References: <20221221153154.25411-1-lujianhua000@gmail.com>
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
Changes in v2:
  - Remove "items" between "compatible" and "const: kinetic,ktz8866"
  - Change "additionalProperties" to "unevaluatedProperties"

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

