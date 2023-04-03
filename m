Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96676D4F0E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjDCRgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjDCRga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:36:30 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00EF1FFC
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 10:36:28 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x17so39121476lfu.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 10:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680543387;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TBvlpAK7/o8+j8xD5iOhFbOub8lAxsWFT3ml9SF2k8w=;
        b=pVSHW4PAuNqPDtga0H+TNnSJkHF6vACVmUdZrLcN7oIwTMIcX0/K2/n3bJxzpRuY37
         53LlrhPZ4kskfWyZSETT/+qr08/R/+ZSNmj99wqQ4qqH2MOWtTuyJmjYYJG6g+5HwIey
         qx06ibGDlersfvOpEhEo/plJiI2uT1YpJycwNmx3wppDfW91l9LLosVcbvpPOIS1gup/
         V0PZ9TM8EgtxzMs0KMo3kDsBjzMD6t+wz47A8ZhLqnw1rmfeO69kPHr5DaK2Hu2LduvP
         QB9lU2WmgtO+Tou4rvNmK647IM3LIrbEUqGBLLWXlOT3LdBf/gM9Xj5vN4vmBv6GURPe
         NlBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680543387;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBvlpAK7/o8+j8xD5iOhFbOub8lAxsWFT3ml9SF2k8w=;
        b=RPUXFLds46/4Vgw3FRp/D4HC3AWEbtv//Bz6vFbf/ZG1FLAd5WO7CWj7vzpBXdbYfU
         V6IaPHt+9+e6lxkH3I/PD+2NrTThOEAJ7ZR0neYUdQKuJwjvQkbPZsd7I1RNhchTOjwA
         l231kjJ8ZgFBceHP8uvu9fhMLOhA4EL2VZaDR2v7QORhkKDEND1dsxKUu+pPa6wYcm0G
         rX8TkJigDT16THZ7JS0kFVtSJ6lzIPG1C1l6ZDH5qAHASVoLaAUTbyPEsjYRpjv4kPOA
         5PGXmkO28760tdJ0xOKL0QIW8CDEAV01adjTxAh+HLfS8aDcLxc59tnQA9moPWU56C24
         H7rQ==
X-Gm-Message-State: AAQBX9fT3phVLGiBa01myHW9zoZqmPwkCtCHGq7UyFLzEW3lPcaIiIpV
        sGlIIPq4/Op8KG4DJKL1Db9o+A==
X-Google-Smtp-Source: AKy350ZPcOlRP/SHBR/lSTxQrru/S9RLs7psdb0vj739i+w24uSW8v/Q3Bf1M/x2O3HSBcz+GuKxDA==
X-Received: by 2002:ac2:5e87:0:b0:4db:405f:d5c0 with SMTP id b7-20020ac25e87000000b004db405fd5c0mr9949850lfq.48.1680543386984;
        Mon, 03 Apr 2023 10:36:26 -0700 (PDT)
Received: from [192.168.1.101] (abxj135.neoplus.adsl.tpnet.pl. [83.9.3.135])
        by smtp.gmail.com with ESMTPSA id v2-20020a056512096200b004cc5f44747dsm1871094lft.220.2023.04.03.10.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:36:26 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 03 Apr 2023 19:35:59 +0200
Subject: [PATCH 1/9] dt-bindings: firmware: document Qualcomm QCM2290 SCM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230403-topic-rb1_qcm-v1-1-ca849b62ba07@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680543384; l=1279;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=hZK413Fcu+BN0crcpQ11mOoyXOGctjEEVv2fsaW1SYg=;
 b=Q3mDf8jw3EgBBLGu845DYQ9YsIGMUCvnRM3PsbvtwnSUHv8hL6+0PyoeykcEIgLARdqwM2jZ2HMn
 TaM3P4t2BiAP2cl9aXRMcqntBCZj2JZbbDQ6gbBHE71dDELlQR1g
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

Add a compatible for Qualcomm QCM2290 SCM and add it to the core clock
users list.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 543feb3b6c58..35540f292bfd 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -40,6 +40,7 @@ properties:
           - qcom,scm-msm8994
           - qcom,scm-msm8996
           - qcom,scm-msm8998
+          - qcom,scm-qcm2290
           - qcom,scm-qdu1000
           - qcom,scm-sa8775p
           - qcom,scm-sc7180
@@ -109,6 +110,7 @@ allOf:
               - qcom,scm-msm8960
               - qcom,scm-msm8974
               - qcom,scm-msm8976
+              - qcom,scm-qcm2290
               - qcom,scm-sm6375
     then:
       required:
@@ -127,6 +129,7 @@ allOf:
               - qcom,scm-apq8064
               - qcom,scm-msm8660
               - qcom,scm-msm8960
+              - qcom,scm-qcm2290
               - qcom,scm-sm6375
     then:
       properties:

-- 
2.40.0

