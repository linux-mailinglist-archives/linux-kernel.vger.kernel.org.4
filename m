Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F169F67895B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbjAWVSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjAWVSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:18:43 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F23E1ABF0;
        Mon, 23 Jan 2023 13:18:42 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id n7so12072695wrx.5;
        Mon, 23 Jan 2023 13:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xpwrGNkZx+sVBzOW0j2j89vPfNOgreFG5uTvNf7DxPU=;
        b=Re4cufl2WPD0YzvKeEyjkmvLydeJYy4KQuxRe9CRuQ7oDQ2oxGsg7J74D+XYFYfct+
         DVJ1YyRjLXunFJRCg4W/rjWhbeRwbuzEblodhZwoqiC7r3x2pzyAbbQtAynNERDGnnbX
         zMVrCMPY8ke7Jbh2+8hj+26bMuG4dp1g33QvGkYP9QdftlePedoBdkirLZe4pOKb7ukQ
         M8JQ9vwHFsNZVwYcEW/QRxpZY/otC5RMcGVuQ4X85bysv+eFZSIjdjjjuNlioOjFf9n8
         2St3GosQSf2WgkMhkmFO6DpjIlYyqTMgsMYYCHuDvI8R1kYPfZMb72uxwYqPDdR3AAm0
         wxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xpwrGNkZx+sVBzOW0j2j89vPfNOgreFG5uTvNf7DxPU=;
        b=wJ7LccqocBR14g4rKzce5ezVkMtiHo6HrqOMtgUyvI/C1cfI4rGv7e252Cnh9gUzmU
         iqPLL/26S0wS41FoySJDnH5UQhN73GrokjHakJzVg82XEvYquCyWWb3TPipLvYel8+jA
         7cL9KXBRe8iLITNCoYMljcQrlpRTWwKhW12O1e4oIMEnqFIjyKBw6r4/i3hUgN8QRQND
         eUMfRvsRKaUXb+54/8Ktf8/TYfkZETy/qxYaEbUW5pmIMhMRlHYI5oJmYmQaooL7zFVu
         16wQc3M4829Rh4DaIMB5k6foINb+SM+CJvwpaF02Rpej5CiXi6OUcQ6gSdcfoYas1YNl
         5RMg==
X-Gm-Message-State: AFqh2krV2lYGZeHRngH2vZk7WFKRhwo4hAtpeJ5VaxCjee3ekxXkv0yC
        fFOYz3cwHIE5iLnXVbyzK28=
X-Google-Smtp-Source: AMrXdXuTEcmNF+SqV8HUBdeUbSceMBFZ6/+tS/tF0O/XdFHGgavdDJZnFa9jxPCwWwHamsCJj6BzeA==
X-Received: by 2002:adf:e2d0:0:b0:2bb:e868:6a45 with SMTP id d16-20020adfe2d0000000b002bbe8686a45mr17384896wrj.56.1674508720406;
        Mon, 23 Jan 2023 13:18:40 -0800 (PST)
Received: from localhost.localdomain (93-34-89-61.ip49.fastwebnet.it. [93.34.89.61])
        by smtp.googlemail.com with ESMTPSA id v1-20020a5d4b01000000b002be53aa2260sm314121wrq.117.2023.01.23.13.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 13:18:40 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH] dt-bindings: arm: qcom,ids: Add Soc IDs for IPQ8064 and variants
Date:   Mon, 23 Jan 2023 22:17:27 +0100
Message-Id: <20230123211727.21542-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Soc IDs for Qualcomm IPQ8064 and variants.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/dt-bindings/arm/qcom,ids.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index f7aef3f310d7..dc86461ab664 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -45,6 +45,10 @@
 #define QCOM_ID_MSM8126			198
 #define QCOM_ID_APQ8026			199
 #define QCOM_ID_MSM8926			200
+#define QCOM_ID_IPQ8062			201
+#define QCOM_ID_IPQ8064			202
+#define QCOM_ID_IPQ8066			203
+#define QCOM_ID_IPQ8068			204
 #define QCOM_ID_MSM8326			205
 #define QCOM_ID_MSM8916			206
 #define QCOM_ID_MSM8994			207
@@ -80,6 +84,8 @@
 #define QCOM_ID_APQ8094			253
 #define QCOM_ID_MSM8956			266
 #define QCOM_ID_MSM8976			278
+#define QCOM_ID_IPQ8065			280
+#define QCOM_ID_IPQ8069			281
 #define QCOM_ID_MDM9607			290
 #define QCOM_ID_APQ8096			291
 #define QCOM_ID_MSM8998			292
-- 
2.38.1

