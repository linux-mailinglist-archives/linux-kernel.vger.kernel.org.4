Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697D46D4F11
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjDCRgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjDCRgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:36:32 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0110026B7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 10:36:29 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id h25so39085143lfv.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 10:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680543388;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s2Gfp4ouQK4BWK0PrRYjNegXpUm2LWNClNwwcmLs7w4=;
        b=tenijuDXiECErbvvYH7AW6EupEhUxxco/eb4dAjDJeVyhacG440pO+B/3buvg5rO6i
         H0f+b8H/EZW6UEtOR3bCrCr7O7ny4yaMyXTDF4GO6Xjulm1UdibXChjWjp7i0uJRdnKx
         t/3s/KlClmMRz45UeSbd9sEgpj05vUxeOxecpA/hITTPyL/AGL+rhv1ptZqPcJ6TslHq
         xD+FUR7F5uRH5p8YTOuns2J3pwJSygFZsWoGBomeXKlrs3X6R8aYfADpCLA1s7hhRp/8
         +isTlSE4FrEjW4vyXQ1j30wQPNzirAsP6Em/27TcO4b/vZE8jNqdiMp29UuSMjCMSN7L
         47xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680543388;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2Gfp4ouQK4BWK0PrRYjNegXpUm2LWNClNwwcmLs7w4=;
        b=jM6Y5S/7Jgp1h+FIOn3YBiyBt40ASqK2HUaKy7PLwFe8+P6DcSqvOtLSo+Y6SmakJA
         oCZweMdj4X9td723DFs5cscTU+zVVJdBJ11dfLx4sxP6cQ0zsfKsrZ7sKofLV/dn6ugE
         5q5UbzLba/pobWIwd+Gz/R43RJttjiEbyT7RSXYxXvc0V6V3aDHqINR5qBEe9JmtfTMy
         C2aArmEfkqbSe+6Kv0O1hg1inXD4QlCRM20X5jif7XcTZ0VrBAZgEtbbFd62a1ays4Uh
         UiyC/n4te/Swn3mrXDkF8/rcgT0exwt9FNf/hZNVgh0xoKD262Jxn8LtE289cw5pmv6i
         3whA==
X-Gm-Message-State: AAQBX9fTTbAHRPDdSSVdbv/Ki0zH7xsrBNMQ38/602Rekqkj8QYWMwoY
        1BSX/ypDiEMo8O8BWPis+Vti0Q==
X-Google-Smtp-Source: AKy350ZmDA9dAfVbC2rfjTB8M74Fp17S7P9NROc4fbk+AnlRN2fGFM48vS5moO0AKQvMbE5V7qSbag==
X-Received: by 2002:ac2:5318:0:b0:4ea:fa26:2378 with SMTP id c24-20020ac25318000000b004eafa262378mr10552369lfh.23.1680543388388;
        Mon, 03 Apr 2023 10:36:28 -0700 (PDT)
Received: from [192.168.1.101] (abxj135.neoplus.adsl.tpnet.pl. [83.9.3.135])
        by smtp.gmail.com with ESMTPSA id v2-20020a056512096200b004cc5f44747dsm1871094lft.220.2023.04.03.10.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:36:28 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 03 Apr 2023 19:36:00 +0200
Subject: [PATCH 2/9] dt-bindings: arm: qcom: Add QRB2210/QCM2290 and RB1
 board
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230403-topic-rb1_qcm-v1-2-ca849b62ba07@linaro.org>
References: <20230403-topic-rb1_qcm-v1-0-ca849b62ba07@linaro.org>
In-Reply-To: <20230403-topic-rb1_qcm-v1-0-ca849b62ba07@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680543384; l=1125;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=K1uCi7RaJN7lMlJeAejUJpCXXekP7RaotMQIk58D8DU=;
 b=9/RAdxgHqVwNW5PUmUGjkrh1TQQCR8HTp6YX+E/9q1B9rFm8wzuvXe3nTvSsSHoYbYg6+YhQGTr5
 7UV+ewIXDVoykJtUQSH7A7m839r+i0nVUNswXuas35qr5/RMIjhj
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document QRB210, a QRB version of QCM2290.

Document QTI Robotics RB1 as a QRB2210 device.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 05badce5fedc..f663af451eb2 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -47,6 +47,8 @@ description: |
         msm8996
         msm8998
         qcs404
+        qcm2290
+        qrb2210
         qdu1000
         qru1000
         sa8155p
@@ -353,6 +355,12 @@ properties:
           - const: swir,wp8548
           - const: qcom,mdm9615
 
+      - description: Qualcomm Technologies, Inc. Robotics RB1
+        items:
+          - const: qcom,qrb2210-rb1
+          - const: qcom,qrb2210
+          - const: qcom,qcm2290
+
       - description: Qualcomm Technologies, Inc. Distributed Unit 1000 platform
         items:
           - enum:

-- 
2.40.0

