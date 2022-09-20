Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D2A5BDA9F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 05:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiITDEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 23:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiITDD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 23:03:56 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F2358B4D;
        Mon, 19 Sep 2022 20:03:54 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id b23so1451770pfp.9;
        Mon, 19 Sep 2022 20:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+3eju7uhrhrPGpe9XN04gsAsv03pWlu1T8bRnciTvXY=;
        b=oILFDOvKt0Nwhx4ckErDPUov3ejPkKnaW9Cet8ChQenqDx+XwBS2ulIeZqt/vOQlUN
         UBl0eljyCNU3/WkeeKJHeEqhdvasZ/u15/4eEvT9IhZdQ3IJAjdhhzQgOmaVQQSZGY34
         0fiuXAfuoT/r0z7ZfwHVh/eYcSANlfH2eSdOqPbJHztWkTfUCwln4XfLwGGU54j6zz/8
         CH/Tw28NPyI+Ygu2w8bLsCp2WodV8dFuRHQB7yOE0hh4Apurkpr9h371SSRuo95Bz20b
         TBPAHiqlK77KRu8Jya3lacipdLXHkqJDx+LrM8e4TJB9qfiyRe4HXNhHD1pVM2tRSvFj
         5Nog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+3eju7uhrhrPGpe9XN04gsAsv03pWlu1T8bRnciTvXY=;
        b=ZP1KelDguehvsTW6UrFr6DrfG3pTl68QDCr7bqPNFWZ63cYS+DK5M3Fp/+oJ4qIaGy
         QInYqfh7FKVqYfFgLGaGngP4Ovb1NdgQQ78w9Qi5t2yJu/fNwp/OsDVcFTcuIs35hmZX
         z0j+rHSc8c12KbPJnuXkiT6s/mvggaDl1wDkxdlt2VLzYQqN8OX/61Dt4WDja3T7/w6T
         JaULYRRoliBOTgPZLcG3IK4I4HW910iRSzcuaMpyFiaN26NkWJbj2LPRmoFvIscb2UfX
         yfORhmjxHpz0/ZNrnzbAodljbyzc7EEnSy6Tl8Uk19GhkU2CQmEHJ9wNakqWHCCukJjG
         wtAg==
X-Gm-Message-State: ACrzQf1DAYm2ZmdXORoTCHvwD5TC0dkO646TdB+gbbn0GL7I5SY/vHnK
        XVV3eJ2JqtXXq6R5Z5Dv1Zozx37481xemw==
X-Google-Smtp-Source: AMsMyM6Y9MR8VWMfkGukz6soHNJTZJ3gq0xGxlNzkf6dDkUjROwudAaTkwNMoadvTs0WKSzGU4kTxQ==
X-Received: by 2002:a63:e909:0:b0:438:c9c9:61e3 with SMTP id i9-20020a63e909000000b00438c9c961e3mr18490380pgh.194.1663643033509;
        Mon, 19 Sep 2022 20:03:53 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:8a0f:392d:db19:673c:627a])
        by smtp.googlemail.com with ESMTPSA id t193-20020a635fca000000b0043a18cef977sm171083pgb.13.2022.09.19.20.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 20:03:53 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     andersson@kernel.org, Sireesh Kodali <sireeshkodali1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 3/4] dt-bindings: remoteproc: qcom: wcnss: Add qcom,pronto compatible
Date:   Tue, 20 Sep 2022 08:33:15 +0530
Message-Id: <20220920030316.1619781-4-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920030316.1619781-1-sireeshkodali1@gmail.com>
References: <20220920030316.1619781-1-sireeshkodali1@gmail.com>
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

This is not a fallback compatible, it must be present in addition to
"qcom,pronto-v*". It is also not documented in qcom,wcnss-pil.txt.  This
is the reason for documenting it in a separate commit.

This compatible is used in the wcn36xx driver to determine which
register must be accessed. However it isn't immediately clear why the
wcn36xx driver relies on this extra compatible string rather than just
looking for "qcom,pronto-v*".

Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 .../bindings/remoteproc/qcom,wcnss-pil.yaml         | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
index bb499ae9a4f0..31232c59b22b 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
@@ -15,10 +15,15 @@ description:
 
 properties:
   compatible:
-    enum:
-      - qcom,riva-pil
-      - qcom,pronto-v1-pil
-      - qcom,pronto-v2-pil
+    description:
+      Append "qcom,pronto" if the device is actually pronto, and not riva
+    oneOf:
+      - items:
+          - enum:
+              - qcom,pronto-v1-pil
+              - qcom,pronto-v2-pil
+          - const: qcom,pronto
+      - const: qcom,riva-pil
 
   reg:
     maxItems: 3
-- 
2.37.3

