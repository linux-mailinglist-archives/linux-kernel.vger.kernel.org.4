Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA60A5BF571
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 06:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiIUEib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 00:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiIUEiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 00:38:14 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F2F7D1DA;
        Tue, 20 Sep 2022 21:38:11 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id w20so4449334ply.12;
        Tue, 20 Sep 2022 21:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=H9Lyby/AOHYpoRwKIB5rcnp3xciz8PrySMGo21yL8A8=;
        b=M1eghGyw8JviZ1oXKl1saV4WE/7JIVi7F+pxOHnmQHfJRv7foWtNuJUg+oSWcQXs9c
         /le3vx2Jnfs3Xbn2dgj3e1HRkE3/NM/BdxREnd5vSwbln+qda7UjXhJgXHx3lQu5Toz9
         HxquzCpLSIbHNQkkmDpaeLA+Kx6DBrsCY1n+FlDXlU7/7MHfKPpur431VI8zgUUs2geh
         FI7mwfzWhSxqlLF/o9Kagi2lRq+bLkc7TwGoVlihGUpE0W2rZovCrGkjtG698LgYBTW8
         Lkzeo6vFb0lsm5qVd3vD9pYGghcDU+MAcwJaGww+yVN9UIvfpSi1/F8OED95w5UxSKyS
         eDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=H9Lyby/AOHYpoRwKIB5rcnp3xciz8PrySMGo21yL8A8=;
        b=cmjVOGMYrNRN9F9TXO8j0fR1u42rhmta65/PhtT9Ka38uDPIdggfCI7/vUOlKpK9QV
         +mNLKErAGuA+qr8VU3w5mpT+c97hvUV/+vsCjF7lFoL9lrbE32Fd/VonjLLhPVnwK//V
         C5o1ACIBHN6aiLposhVFlA2u3qzzgo49w9OMfOiRW8BpHTltyRq2je5oB0GMoid01sbZ
         byQX3W8tELW3uFSLyXoEYBYYEpCXegtIr4WZJTF+XUue2fV51vb1INH1nlEX/ukNMLvv
         s15RPq+5LCifr+N7S47//+xwTceETKnWxieCdx5KqC6yiFo12qTCjKMmMzeJXQzgn2oq
         v/vw==
X-Gm-Message-State: ACrzQf095bj32uzmbkKvTCAgjfeYxljnctkOAy6Qn+J3abIK9ZndeN0+
        0ze5xBHQZ4OAtfV5BAXeMvSkNcACdy7mmQ==
X-Google-Smtp-Source: AMsMyM6BuzpcCHEyPpVgq4OMhJIlSePE6NeRODXptVtu0Xp6YIKeBVEiNZuyFXfU+T0AeZJ+eoUUhQ==
X-Received: by 2002:a17:902:ea0f:b0:178:23f7:5a30 with SMTP id s15-20020a170902ea0f00b0017823f75a30mr2923586plg.150.1663735090323;
        Tue, 20 Sep 2022 21:38:10 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:8a0f:392d:db19:673c:627a])
        by smtp.googlemail.com with ESMTPSA id t185-20020a6378c2000000b0042c0ffa0e62sm821182pgc.47.2022.09.20.21.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 21:38:09 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 3/4] dt-bindings: remoteproc: qcom: wcnss: Add qcom,pronto compatible
Date:   Wed, 21 Sep 2022 10:06:47 +0530
Message-Id: <20220921043648.2152725-4-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220921043648.2152725-1-sireeshkodali1@gmail.com>
References: <20220921043648.2152725-1-sireeshkodali1@gmail.com>
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
 .../bindings/remoteproc/qcom,wcnss-pil.yaml       | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
index a99a1e5242f8..31232c59b22b 100644
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
@@ -198,7 +203,7 @@ examples:
     #include <dt-bindings/clock/qcom,rpmcc.h>
     #include <dt-bindings/power/qcom-rpmpd.h>
     pronto@a21b000 {
-        compatible = "qcom,pronto-v2-pil";
+        compatible = "qcom,pronto-v2-pil", "qcom,pronto";
         reg = <0x0a204000 0x2000>, <0x0a202000 0x1000>, <0x0a21b000 0x3000>;
         reg-names = "ccu", "dxe", "pmu";
 
-- 
2.37.3

