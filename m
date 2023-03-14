Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06036B958E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjCNNI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjCNNIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:08:30 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63A0A6746
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:05:08 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id eg48so2498562edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678799107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivdd8o1+4h9Hx06ZifsrxjjOXj5S7345Nu84eEYwm+I=;
        b=D1jZX9QRKXIhXE24JFbyyV8E5qpFV+/lDSDIZLBRliLPTlS2k6VMGao31WxVU4iW+W
         zQP4sY1jowylARPtVvhlrK6i9Czmq9cqMu2mF2794ry2ouqWkr0WdNDt4YtZQvjT+OYy
         Qef9jv+J1NnWywkGG+m8JF/KlJl3z9EOuBsZYtACh/hkbwaHXqAthUANWOjVmkbA94zo
         wa8ut7sXVX6oz0BAQKtEU37fy2Ow+KgUZVVGELaqmGflHeNk4aIQImw3eBWYik/EP/Gd
         AAzNxj/nx1NSJTYi7v1GHKdN4BaUP2Im/Y+ZMRla87Q/ZkdwT7F+LVNct4Gj8iYsWWDu
         jiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678799107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivdd8o1+4h9Hx06ZifsrxjjOXj5S7345Nu84eEYwm+I=;
        b=8LzMNwk6ZIQu45SazRMQe9BELW9DCAF9MiUALdBkaLJ2P8xTVb3tEx40m34vWDsuY2
         1m2GTUpxDL+79Y7+hUm85HjU0eCumz8YexShFoCYu8/IqJT26L+fRBNRwoHGAmLB+7bx
         SgJfACcHZi37xz1mY/mGXM8dGArWv01nN6LA8W6s0cgKQam0IoeF+2Dq/cRzOJbfoV6O
         sVh0WTIkgGsQ1eHt5bqdbodDMiQjVbA0FBsWNK9h7b3chE1I48fTQD0RIc8V8nh0C3to
         0CycNzb8jb9RbvzxCAZB6mkix7UL/XMhhy1yUGxyUA8X5lMzdyNNscid25vmtxX3q7WY
         4hFg==
X-Gm-Message-State: AO0yUKW8D1C5YN1sRcws8nZoJmIEf0PteIie3Zi9UQjnV6r7Prenqo2e
        dgvb7aOzFE1H/bUBFRwXp+PkVOAxwCv174cZ7Yc=
X-Google-Smtp-Source: AK7set+UcdT/m0UVY8fr52DNOQXx9OavRZSVrz2NLZY7LoiN/Wg81DC/eOMjnEm46lr41vpt6SuHhA==
X-Received: by 2002:ac2:5930:0:b0:4e8:3dc1:70f1 with SMTP id v16-20020ac25930000000b004e83dc170f1mr646535lfi.0.1678798400861;
        Tue, 14 Mar 2023 05:53:20 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id s9-20020a19ad49000000b004dda74eccafsm395374lfd.68.2023.03.14.05.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 05:53:20 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 14 Mar 2023 13:53:01 +0100
Subject: [PATCH 6/6] dt-bindings: thermal: tsens: Add QCM2290
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230314-topic-2290_compats-v1-6-47e26c3c0365@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678798384; l=820;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=/HqJnDrZDWmElYHarn/65QzTOlddvNyANiSR36b9lRk=;
 b=C+BlB3/yPgi2Eyf6wAEQCQcRQeP1r4y32t0AWbyQN1ZLofGrXHb5mOPucjfJP3ZwpbOFf3MRhdp9
 Sg9b/4D6CmS0GoV1u4AB0svIXG9ZSU8F8r2af1tHF8xAqiaf8JWY
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

Add the TSENS v2.x controller found on QCM2290.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 926e9c51c93c..1a6ffbf11bcc 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -48,6 +48,7 @@ properties:
               - qcom,msm8953-tsens
               - qcom,msm8996-tsens
               - qcom,msm8998-tsens
+              - qcom,qcm2290-tsens
               - qcom,sc7180-tsens
               - qcom,sc7280-tsens
               - qcom,sc8180x-tsens

-- 
2.39.2

