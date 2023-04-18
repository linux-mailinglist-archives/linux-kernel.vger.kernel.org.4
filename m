Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EC46E67C0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjDRPGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjDRPGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:06:38 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A142997;
        Tue, 18 Apr 2023 08:06:37 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-38c35975545so447616b6e.1;
        Tue, 18 Apr 2023 08:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681830397; x=1684422397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=grZMSKokWBxTMT6BuCDaQ21smq7KTeNGJhRCrqdfwnY=;
        b=V06SPmeFVDIDD9NQ2XpVIE87cRIMXpzRhEAjqmYRj9+NkOv5iRomRQU30VYU+k1vI/
         QaM4b0fxItAjT0VyoPgbbt+z4x9raFfaWfjAWcvAMhoYx8MfPojBfPY2A4j8QY9pV/h5
         cv4RHfGONWpR6dFe77V6m2lO1AFVt7HcMI8PsOf8E3FXT0xY5fMXY4UGiV7NIX/We5ay
         bT73VHe+u4FJkgLSQ8Z80j8TFmDIIaYLLnCv3c2f3EDwTwWVSl4wzgAQtm9qI7CUzq2X
         2gnDhd7MhKuCsX8RDj1DkD2wRziWDYQVJ7R/XaKYBnGgt/L30uAfT8UuTVeoJwYW90qu
         chqg==
X-Gm-Message-State: AAQBX9dBKhBBmNEbALYn/TStmr9vRI7daWM571uXSE4FJ/tfdf/dzjnT
        0i5ao0QNyVHEY4HcZJs07Q==
X-Google-Smtp-Source: AKy350YZEHvbP5PVh2rbBKiQ4nne5bUninf44qFbBPUMLt8mF9m0hikYSD3j5eUGCPTt4Uh9jPBCzg==
X-Received: by 2002:a54:4719:0:b0:38b:c1ae:cb1a with SMTP id k25-20020a544719000000b0038bc1aecb1amr1147526oik.22.1681830396798;
        Tue, 18 Apr 2023 08:06:36 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z64-20020aca3343000000b0038e1564951fsm1809406oiz.55.2023.04.18.08.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 08:06:11 -0700 (PDT)
Received: (nullmailer pid 1528206 invoked by uid 1000);
        Tue, 18 Apr 2023 15:06:10 -0000
From:   Rob Herring <robh@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: pinctrl: qcom,pmic-mpp: Fix schema for "qcom,paired"
Date:   Tue, 18 Apr 2023 10:06:06 -0500
Message-Id: <20230418150606.1528107-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "qcom,paired" schema is all wrong. First, it's a list rather than an
object(dictionary). Second, it is missing a required type. The meta-schema
normally catches this, but schemas under "$defs" was not getting checked.
A fix for that is pending.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
index 9412b9362328..4c3e9ff82105 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
@@ -144,8 +144,9 @@ $defs:
         enum: [0, 1, 2, 3, 4, 5, 6, 7]
 
       qcom,paired:
-        - description:
-            Indicates that the pin should be operating in paired mode.
+        type: boolean
+        description:
+          Indicates that the pin should be operating in paired mode.
 
     required:
       - pins
-- 
2.39.2

