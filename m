Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFB65F197C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 05:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiJADXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 23:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbiJADWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 23:22:44 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84245927B;
        Fri, 30 Sep 2022 20:15:11 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id q9so5610296pgq.8;
        Fri, 30 Sep 2022 20:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=OjbUXeviY6YCLLqqd/ejLKx1ctiYSztmp1vKiw+VYlw=;
        b=kv/hMCBpwPx1AS03mHziigBRB2G8MlK0iEWkbLMeubLTLIntN3tDV4Qu5L0dSGLR2p
         SneA9do1ja78xR//Dg0n+xHqssgt+6nc9wrGpjppU3+8ct1qUR0SkWN8U4d861VYA0Kf
         6aPDNdl7jdT1QOCWVZzl3rmVv5Q64UkJvViFtSSabvLl9tLbFM5qoFQj173TerYMrdki
         XCj2S22kiRYxgoR5S1snJhDipcfuLtpvcdX3EhDHIVt2nED0qFYP6SU0rBnH+lSW22st
         WjN4SyYs/KRZBeEKDAJX2Uh0HlT9FpZ3pOwUoYffjKSKnW9mVyv7Dx0rmWtB0OfzqyBQ
         9O+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OjbUXeviY6YCLLqqd/ejLKx1ctiYSztmp1vKiw+VYlw=;
        b=2ARzBb5xSc/ACf8YYPf8Mjo8vb3W8Z0qWvv239R+7lq1IciRAhvTQBeHdcccreuaTK
         LtP7Kx9VrYV5cYn75IXiqo3Pnaal9Uv/acik1iAYsSBctpQOQo/WLRYpsSQ0e8UNfaQC
         a5j3GFJTw5YaXnEbnnhKGdUip+kuQ2OYN78g3RoWfIlrn4p4tVJenw2NYruFSH6bZ9o+
         l6KB2YpnEkBAEQwgMLk5hbqR126xgfZmfiwxAAebv70J34e2OmZnqZnXWm9BRcWM+cbA
         1gfmmnIpxMfiyWC1pf42QeZgRceUUIn5R7mqL+kMsY+H5OY3sRdVnxHX6DRFfsdpFujf
         cI0g==
X-Gm-Message-State: ACrzQf2J9SmIzqx2tCdS4QbHGwSpmNs3zndpzc1nO9B1OikqBrql21ZA
        5XQTzVpl3f609kDCwUUxHM3UF5ivmyDlMFSw
X-Google-Smtp-Source: AMsMyM7YGaMrIxgxfaY+uyPMm8aET9qoU3uwamwCRMeldo9Hs1JCPZc2JVNho+pSrnI8/R3Tccv0YQ==
X-Received: by 2002:a63:6cc3:0:b0:43c:7585:1ec with SMTP id h186-20020a636cc3000000b0043c758501ecmr10179937pgc.571.1664594052863;
        Fri, 30 Sep 2022 20:14:12 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:5d7c:3fe4:8f6d:b1b6:f2bf])
        by smtp.googlemail.com with ESMTPSA id cp1-20020a170902e78100b00172a567d910sm2627371plb.289.2022.09.30.20.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 20:14:12 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v6 3/5] dt-bindings: remoteproc: qcom: wcnss: Add qcom,pronto compatible
Date:   Sat,  1 Oct 2022 08:43:42 +0530
Message-Id: <20221001031345.31293-4-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001031345.31293-1-sireeshkodali1@gmail.com>
References: <20221001031345.31293-1-sireeshkodali1@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/remoteproc/qcom,wcnss-pil.yaml       | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
index c22a6090220f..0eb2617e3482 100644
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
@@ -200,7 +205,7 @@ examples:
     #include <dt-bindings/clock/qcom,rpmcc.h>
     #include <dt-bindings/power/qcom-rpmpd.h>
     pronto@a21b000 {
-        compatible = "qcom,pronto-v2-pil";
+        compatible = "qcom,pronto-v2-pil", "qcom,pronto";
         reg = <0x0a204000 0x2000>, <0x0a202000 0x1000>, <0x0a21b000 0x3000>;
         reg-names = "ccu", "dxe", "pmu";
 
-- 
2.37.3

