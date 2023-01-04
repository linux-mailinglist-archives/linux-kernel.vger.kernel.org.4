Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B60765DB10
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 18:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239933AbjADRQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 12:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239677AbjADRQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 12:16:49 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1812F003
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 09:16:47 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id bq39so43563538lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 09:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XsrAfu8WB+ADcxi8fs7MNUMoEHOQMutxstluF7jI5jI=;
        b=CDLvO1acOx2Ye0jrgyUN0SxiS+VjfdiAhsGbdkMb/cM1XVGv3iDrBRdhY1XNJmd5mN
         9B2ukKnaTXd2CQj8haaSQEsWdQJZ6XfcVsqQ3BALG+47gnFjIDYvWvDnQd7wE5eA/FGl
         onwFZ3ufUReX013ldkWGqhmdfiEDXI21iIphsnKXxy+ZC1EvAf4adNDnowF1ik5MzTWq
         CKn+//Xy0GwtamOxkYq+OiDf05vSFLQA6Wm6on7zIqkVDu4GlnEEA3m1O6kGb01eDonY
         X9qSWAIvCh5+rH9I6yA6/X3U28ahuo/exzrypc2iZh7ZmR2goXzft2OA7Pa53zwS7tKT
         ieLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XsrAfu8WB+ADcxi8fs7MNUMoEHOQMutxstluF7jI5jI=;
        b=ZHO7Mokzbqwm454bImtlRxXM91A1yP18kjh34Z2ZSpSz/+z+MZV246n9TwVbDiAoR2
         rO2Xvi9YWWksVncuKKrefhkcZZi+At7rAnjUhCsfOP4HPjmD8bnYRivNiSfWN4yoplrF
         FW5QuaZyI1eZX7hlMnEQJTr8wnj+64SSxve2Fg9duweBtiTrGib+LO5SEolmJYrHz1bO
         OUAkCfer8xQc3AggkuKk9OmHUrGDa/jOxU0xx6qU7MSXB6x7/lRmPGQc1RwmFxIPNvh5
         Qaif0A2jmeQ71C5DBW9jkeUOKjQB7DIieAICsvPRrOXnFgeMJs4EhE/yT6jSD9Co9wxq
         3okA==
X-Gm-Message-State: AFqh2kpw9B+wCOF8jWrfE74/vQnT5o9ztBfTy8iCwJNKEIHd2zXvvt0q
        GHj0zxAVnnfeT8Y06zyLV64Mhw==
X-Google-Smtp-Source: AMrXdXvQgxPQ/Ei03+3mymsd1M7IUkebY85kln+wQVeDgKFnSIzfcGfemMQjEsOHV0lCLPa3uSz9jQ==
X-Received: by 2002:a05:6512:318d:b0:4b5:70e0:f2e6 with SMTP id i13-20020a056512318d00b004b570e0f2e6mr17105422lfe.24.1672852606343;
        Wed, 04 Jan 2023 09:16:46 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id o22-20020a056512051600b004a44ffb1050sm5179520lfb.171.2023.01.04.09.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 09:16:45 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: interconnect: OSM L3: Add SM6350 OSM L3 compatible
Date:   Wed,  4 Jan 2023 18:16:40 +0100
Message-Id: <20230104171643.1004054-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
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

SM6350, similarly to SDM845, uses OSM hardware for L3 scaling.
Document it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 -> v2:
No changes

 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index 00afbbca9038..9d0a98d77ae9 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -22,6 +22,7 @@ properties:
               - qcom,sc7180-osm-l3
               - qcom,sc8180x-osm-l3
               - qcom,sdm845-osm-l3
+              - qcom,sm6350-osm-l3
               - qcom,sm8150-osm-l3
           - const: qcom,osm-l3
       - items:
-- 
2.39.0

