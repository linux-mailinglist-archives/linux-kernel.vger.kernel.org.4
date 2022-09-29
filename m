Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F265EECF2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 07:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbiI2FDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 01:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbiI2FCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 01:02:52 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CAF1284AB;
        Wed, 28 Sep 2022 22:02:49 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d82so433992pfd.10;
        Wed, 28 Sep 2022 22:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=OjbUXeviY6YCLLqqd/ejLKx1ctiYSztmp1vKiw+VYlw=;
        b=Jo1A7O6swPjc0F0f+2xRsgznsiBUTKvJ3WjrBZIGhVas+leC7IU0rnAHf/Cj37cH8F
         76KbjOj4xCxZac2cbrNzFHiqKq8z05m8n3ux4MXi2pQOvIp4I3vHtWHjOCWGYYxvuCMh
         rIEuux109nIr3j0irWhRvhIP8tzmktJwTvL+/ImNYnIjMTzskXgwYBaIfFGMS5H39Zdf
         G1b+HkvlU67nWzlVLAzYosf/C1iCb/EiXLJf6LwtIkNEBkk/OnvpTPrGkjU+FpF3UFSf
         PMR/UAeCFprOzysbhT2fpxRjHChXT/zuuU3tmpem3fFuBTSYTbOil4DWKvaGcz+e6v4y
         GdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OjbUXeviY6YCLLqqd/ejLKx1ctiYSztmp1vKiw+VYlw=;
        b=Kqxtt6Tby4zpiSVBMAybCfprC8Vm5qkdGIb6Os2e1jKJBtUxzD0RHg8FhdlgOOEUx6
         94ur72VLPDJYnaSNFXc1K6uaiJJGF+xvHrtpWBxqbiUczwpeFCwL40cwRhaxrJzQjuzv
         Es8VhNcNEkCuU9MXzQdV7g81H154trRG9YtOP56LsoPFYp0cu8wSvFkrhi19OmamxZk2
         1XeL4AfltZ7ENnio9oMCP/Pt29JGj4Sr9Ad5tf4fJUzayS9x1joKikkpRf/xTl9E3Sf+
         0xmXY4aK20k4sq7EEKxs95fL0hARLSYATbws46ABoRxk9bAF/WsBM+kAjGsOc0I7jFJ9
         gOFA==
X-Gm-Message-State: ACrzQf10dF7YPChFbmKSHrdpKboRf9r64YPLvDqrk3kaRxffEL5NRqdK
        bgeAO90jmpyIQywNGgZztvAc9pRZt4qyZhLs
X-Google-Smtp-Source: AMsMyM4/YAif8eXW7RyhxhKNYSshi6eBzvw3kqm12UBks0lokKEaNBifc656zZ2wXXbUks7fjPHOdQ==
X-Received: by 2002:aa7:946f:0:b0:541:fcf0:31d7 with SMTP id t15-20020aa7946f000000b00541fcf031d7mr1505273pfq.35.1664427768501;
        Wed, 28 Sep 2022 22:02:48 -0700 (PDT)
Received: from skynet-linux.local ([2a09:bac0:579::681d:4237])
        by smtp.googlemail.com with ESMTPSA id rm13-20020a17090b3ecd00b0020263b7177csm1895962pjb.3.2022.09.28.22.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 22:02:47 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v5 3/5] dt-bindings: remoteproc: qcom: wcnss: Add qcom,pronto compatible
Date:   Thu, 29 Sep 2022 10:32:07 +0530
Message-Id: <20220929050209.1464526-4-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220929050209.1464526-1-sireeshkodali1@gmail.com>
References: <20220929050209.1464526-1-sireeshkodali1@gmail.com>
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

