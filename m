Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D015695FE9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjBNJzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjBNJyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:54:47 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1A224CAD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:54:43 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id k16so7112356ejv.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Swwz0i61XmcyN0eChJbFKDnT0VXzHBOjQLzsplB2lBw=;
        b=xfpW5v5Onb1cwdnB7BYYtmOpk5i0yYw9DXeANC+ERy1qqllOZVEd5MgWVO9NRYUahL
         ABHFs9BX8UeWLEbR2qwp5UPacJF9gbN/xCeBc3WK3E6TWa6eJ5rg1Hx+3Pg0LGLH8CMX
         zKxyfSG86lnvdAijoLvQDDDcijWfwT1OV6jXd+uPa1BOkHGaOpZ6l6BIxss0Uq8MPGJt
         MWqiF4Cu5U0MfH2pxRS8wx35uH5o/fsi4rCkBiNE1wlumzSWRkr32dfU5NRKVz778r5E
         5hCKNaIzC2sK7vji0rdcuQYHAUhRjdAN39aha6mKSgVGY1pc1yBZ/c01fb8JyaiTwdt9
         /tXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Swwz0i61XmcyN0eChJbFKDnT0VXzHBOjQLzsplB2lBw=;
        b=M1L/AjM3fN1ctyLxk01T2lh/vPsIjx2l3sF1BPPXiehjNWcHpjWlUlPHBgyqphpc/F
         wRonlqzUAyEsSmSpszUDF1S2MCfiZjz1VoZhQ8d6pUuOcLkXyPQBtbOqP3hvNBFdTvWz
         9TtZ78/OxtFpUSOiPvlQ6UnGgU2Ciu6uGWfSeHxC5lqJFva3mUzzz0KBYt+imO4mgE2Y
         S4EU71YBsmyLeWceV/eVqukisvOxsd4LYSoIt+mx0WldBPVRVoVnCC3lpdX8DLJ4LYtS
         x0l6fOepyPqQT3GN0+hh2XR45s99YYK7DWsQDbwKXxxrQKe0Uz/wiNKIRDDdnrojgh27
         qU6w==
X-Gm-Message-State: AO0yUKUYtgtd4uhnuCUJb+SPCol+61oNo76jm8dezJ8/S1ey1fDFz44p
        C44wqKbVOWUNe08nyDQLmeOclw==
X-Google-Smtp-Source: AK7set+QdGEeDsU29vTFBfwboz+ZdIXrbE3fP1owJmZRH3EobdDwzTQ03oT/6r6fqOesnvKQS2PFag==
X-Received: by 2002:a17:906:5ac9:b0:882:ed4a:f23 with SMTP id x9-20020a1709065ac900b00882ed4a0f23mr2292261ejs.49.1676368481714;
        Tue, 14 Feb 2023 01:54:41 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id b12-20020a170906038c00b0088f464ac276sm7936172eja.30.2023.02.14.01.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 01:54:41 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: power: qcom,rpmpd: Add SA8155P
Date:   Tue, 14 Feb 2023 10:54:33 +0100
Message-Id: <20230214095435.2192153-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible for SA8155P platforms and relevant defines to the
include file.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 include/dt-bindings/power/qcom-rpmpd.h                  | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index afad3135ed67..f9c211a9a938 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -29,6 +29,7 @@ properties:
       - qcom,qcm2290-rpmpd
       - qcom,qcs404-rpmpd
       - qcom,qdu1000-rpmhpd
+      - qcom,sa8155p-rpmhpd
       - qcom,sa8540p-rpmhpd
       - qcom,sa8775p-rpmhpd
       - qcom,sdm660-rpmpd
diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index 1bf8e87ecd7e..5a6dd5ded087 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -4,6 +4,15 @@
 #ifndef _DT_BINDINGS_POWER_QCOM_RPMPD_H
 #define _DT_BINDINGS_POWER_QCOM_RPMPD_H
 
+/* SA8155P Power Domain Indexes */
+#define SA8155P_CX	0
+#define SA8155P_CX_AO	1
+#define SA8155P_EBI	2
+#define SA8155P_GFX	3
+#define SA8155P_MSS	4
+#define SA8155P_MX	5
+#define SA8155P_MX_AO	6
+
 /* SA8775P Power Domain Indexes */
 #define SA8775P_CX	0
 #define SA8775P_CX_AO	1
-- 
2.39.1

