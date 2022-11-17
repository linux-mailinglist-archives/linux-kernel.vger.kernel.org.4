Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC3B62E4C2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239449AbiKQStY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbiKQStV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:49:21 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8B55917F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:49:20 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id z3so2083964iof.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1Iy41MhZ3FqRDS+o4OCXIP3MAQhIgzbJl+JqnbSgTg=;
        b=NVAIjCoIr/gY3oZpSuV7SLL0QFcamToBZNGZFjyj8wdTwSUsNp+svdXfX1TbEXO3Ts
         ASj0kombCmsJtGIVLisb2N0pdbwKTtR7hHEwxwvccLERx+spTa+N+Q4ueHn2fuHahW1r
         NPkl04UJXnGnewPI5Py9iJ950jaEhDxY9Nafo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1Iy41MhZ3FqRDS+o4OCXIP3MAQhIgzbJl+JqnbSgTg=;
        b=UtgROMirzytGNZ6C6Kybu3Yg1fn+xRiJDvIXoPlh3uRjMJdxAjQ9YIZMdVWE+FLyiy
         /35MPMaePn8ChSqi/Atgt0lxPKR211AxxNFtmAEDSwld/M0j2JA7FL/czajRpueQYQ/y
         7ii5XxxCkZ0sqTP+EdGQCWQSVQb1+ZkEDfil3Bw+6Hkg+yBvXhtInVl0mfcArQrNdU/w
         66dJwaeLvOB47VvDi4Y9Ik/QmlbRGuS6HnBKpeBempAGJrZVn7hrSP5iew0r2Dq26ith
         yUMsPxN3OE8kUUSNsQTuoYHGjlYFSIU8uWIs4WP+KvOzKeUjtTMcd0NaYJfFn/hSgcZb
         yJYQ==
X-Gm-Message-State: ANoB5pmQvUTSgYgbAjUed9ORVguw/jc5mJwRJ456PiwwRacQXnB+z48d
        hEz3BF0uUUfoUOXjonVmeNIsMwND7zA7Bs6PaVc=
X-Google-Smtp-Source: AA0mqf6vmCAIs3qAaXGbusGYJSfA0ySnQwbOahFjbsIcsmewZddLmRdMGLBKlzld0AnajTBv/k6z0w==
X-Received: by 2002:a02:7409:0:b0:375:4727:8625 with SMTP id o9-20020a027409000000b0037547278625mr1629567jac.300.1668710959492;
        Thu, 17 Nov 2022 10:49:19 -0800 (PST)
Received: from markhas1.corp.google.com ([100.107.108.223])
        by smtp.gmail.com with ESMTPSA id q6-20020a02a986000000b00363faa1ea9asm503282jam.15.2022.11.17.10.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 10:49:19 -0800 (PST)
From:   Mark Hasemeyer <markhas@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Raul Rangel <rrangel@chromium.org>,
        Mark Hasemeyer <markhas@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org
Subject: [PATCH v7 2/3] dt-bindings: mfd: Add DT compatible string "google,cros_ec_uart"
Date:   Thu, 17 Nov 2022 11:48:47 -0700
Message-Id: <20221117114818.v7.2.I9e018ecb8bdf341648cb64417085978ff0d22a46@changeid>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221117114818.v7.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
References: <20221117114818.v7.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
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

Add DT compatible string in
Documentation/devicetree/bindings/mfd/cros_ec.txt

Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

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
 .../devicetree/bindings/mfd/google,cros-ec.yaml       | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index 04962bb29576e..26787e4574b8d 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -28,6 +28,9 @@ properties:
       - description:
           For implementations of the EC is connected through RPMSG.
         const: google,cros-ec-rpmsg
+      - description:
+          For implementations of the EC is connected through UART.
+        const: google,cros-ec-uart
 
   controller-data:
     description:
@@ -222,4 +225,12 @@ examples:
             compatible = "google,cros-ec-rpmsg";
         };
     };
+
+  # Example for UART
+  - |
+    uart0 {
+        cros-ec {
+            compatible = "google,cros-ec-uart";
+        };
+    };
 ...
-- 
2.38.1.584.g0f3c55d4c2-goog

