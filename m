Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24526B9571
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjCNNGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjCNNGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:06:22 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF61410271
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:03:01 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id cy23so61598167edb.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678798962;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FQYNV4JS9J59GL9ARq0SzSc6IYTv8e6Odhxu43xh8dM=;
        b=g1YUOxGK+t9+BCwHjCEkOjaze2rhJX1Mhkk1/4mSKMXjs3OkUKUZEcpsiLsZpdY+rE
         zGpFTjEvLe+KrLgtrFiX73f62HsXcwXi1FGGZxE7Bomkx8BXstMUBt8lVCaemqDHB903
         aRGM1PVK7m0kO4NMlVsgsbiuJBYU96m6rgxNR1KngGsrM/EXKba2WB+tktwG45qHuBeo
         ue4M4kOTNJuy0yxnOw5GO1NqXJoFX0YD9+YF+E56cWg5pFEwCyESv/7+iVPckmH2p71W
         W6RhlBPst7uBM0c53wPxAhsmdXX1FsT6qIKApNu6h7O3VbW0r+OXoGo7+OBSmHck9zWf
         4edA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678798962;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQYNV4JS9J59GL9ARq0SzSc6IYTv8e6Odhxu43xh8dM=;
        b=Li7K+AobMQ6uCTrgKNHV1nuderv28CE1g+vmnOMGTvKKxFgFqc+mhN2Hk50ck9vij+
         3+3q+tSJgs4YceKapM+6qemtk7whh/85FLgSWLWvP0BOSWehczj12nciiO5ziA1S5PXU
         ayZTq/nyZrNkgxtHtbOHU7kbQ1+cqaQnF7/6rowCAz75MabMQ3wGq3be1lV8VR8+h1bx
         3LwwX88jEi0EYNPL+UBmQQ5qCjbjHGM8sVtNhC1KoKwAS4yeXlMmkp3r3biu4USgqF0p
         04v9kjKFrZDYvHC7565NCl0i7fGSWvFiS93PBYl/9J0PIUiAu1g+Az5G7w1gGggB96zw
         DpJw==
X-Gm-Message-State: AO0yUKVScJedqJ7KlvoV+TCah49A87uep/90h1cCXeeo2h6CGub1tTO3
        itFPqGIIOQiFcGsurQ3D9fkIGHroE6uU8nIxKKw=
X-Google-Smtp-Source: AK7set/mIFSkFUi0R/m1jVrscAIJA30bZ0/Za28UAQk9sWPAr9Zdpre4fTc8I9Ct7+OhtZVjkPjGnA==
X-Received: by 2002:a2e:3a16:0:b0:295:b0a5:f66f with SMTP id h22-20020a2e3a16000000b00295b0a5f66fmr10286645lja.28.1678798397989;
        Tue, 14 Mar 2023 05:53:17 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id s9-20020a19ad49000000b004dda74eccafsm395374lfd.68.2023.03.14.05.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 05:53:17 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 14 Mar 2023 13:53:00 +0100
Subject: [PATCH 5/6] dt-bindings: usb: dwc3: Add QCM2290 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230314-topic-2290_compats-v1-5-47e26c3c0365@linaro.org>
References: <20230314-topic-2290_compats-v1-0-47e26c3c0365@linaro.org>
In-Reply-To: <20230314-topic-2290_compats-v1-0-47e26c3c0365@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678798384; l=984;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=6UMUh/04krKh/2VacWll/qoFcprxFJbKkd3m3SNGTZM=;
 b=/oaiLc0pXANHZhWzQ/BEVQSNywVPnQB31vN4WC+T8+P+ztrzZ8NNt0yoLTJ+2er1hnvbb21gkHWH
 kqGpBpdUDsPK0PfXwn5NMl/sBElXyHKHZwL7EtIQ0THs9nQTJV+Y
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the QCM2290 DWC3 controller.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index 4875c5b7d5b5..a2aabdac4105 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -21,6 +21,7 @@ properties:
           - qcom,msm8994-dwc3
           - qcom,msm8996-dwc3
           - qcom,msm8998-dwc3
+          - qcom,qcm2290-dwc3
           - qcom,qcs404-dwc3
           - qcom,sc7180-dwc3
           - qcom,sc7280-dwc3
@@ -300,6 +301,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,qcm2290-dwc3
               - qcom,sm6115-dwc3
               - qcom,sm6125-dwc3
               - qcom,sm8150-dwc3

-- 
2.39.2

