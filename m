Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0E963E160
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiK3ULV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiK3UK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:10:56 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D239FED0;
        Wed, 30 Nov 2022 12:10:02 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id x6so7998110lji.10;
        Wed, 30 Nov 2022 12:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qIj/q/S/M+xmpa0Crss8iDZZEgJSAa+iZUKMRDbQ1A=;
        b=fwXoyKVd99qyS5eoWoK6kZVSv67qIbENqpVmajCXCwnWltjp+zrXyAXKH0Obiq5w4d
         2Mfw9Bq/frgOoGkBPOll4xlsehKKYclGHi+NhBVtFd1nk47L05MYzT/AQW4cPYOG9k7H
         kt04Mn1WEISAqeMBD8CWlfF0f7aDoHohZl84qPpZlwmHtM2nSED6+qZwak+mPdpNBncR
         rknHgNvT5duvR5qFd1V0Yp5wrJzamnBxE1E2c08f3ny1Va5zTSixVS8RG9Apnv8U4Xy1
         sJCx4BvWraIt1CFGu8C3JjZv755jd/smdAE2ff+qVfiKkOfY+DJyBkLaoP0Pdbl2K5uz
         o/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qIj/q/S/M+xmpa0Crss8iDZZEgJSAa+iZUKMRDbQ1A=;
        b=hYGzIr4evOBwdPHPDJiEB66zU2kgFjVs17g9ae4wVJTy7PoSDnWWpb5FtaSSc4yvdH
         s7PzqKbnUYk2Wm3SikTLeIWL6rhSTAC80iUQrvG58DXdi8S4FuuxqXrDNW/9Lxk/usAC
         uQtl4rIgCpHX3t1peDiVzLD5CqYSi+U+kOLF6e+uidQqi96tAoa3YR/V3dm+iDPCodl3
         jJQGWzGLJTr7vNPjqdz0H2zOoO9JktnJOCc4+GbKoRhmYCU6h+s8DoUFpgke4STos70W
         ZoeLy3Ik7YCduOG7ilFSIVSBtVKvoxLZid5o/YJdRorcja411lhwqzP6WYMvEbZdp7Q4
         X6uQ==
X-Gm-Message-State: ANoB5pkGclNI9QN4TKsuLnJCAXn69HPLZSGmjsITJDUki54T32CMMrYp
        u8/QVbm+k3tEG8kkxhzm/7TGj3lTtx0=
X-Google-Smtp-Source: AA0mqf6GebFaXhqxSqjzPGpEH8cA6UmpAytnONRCzSRyZXmFXci38kir6+W3OcWKtliqBRb28VbkMw==
X-Received: by 2002:a05:651c:1c3:b0:278:eab6:7542 with SMTP id d3-20020a05651c01c300b00278eab67542mr15028408ljn.400.1669839001010;
        Wed, 30 Nov 2022 12:10:01 -0800 (PST)
Received: from localhost.localdomain (ccy110.neoplus.adsl.tpnet.pl. [83.30.148.110])
        by smtp.gmail.com with ESMTPSA id a25-20020a056512201900b004b4e9580b1asm369754lfb.66.2022.11.30.12.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 12:10:00 -0800 (PST)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 02/12] dt-bindings: thermal: tsens: Add SM6115 compatible
Date:   Wed, 30 Nov 2022 21:09:40 +0100
Message-Id: <20221130200950.144618-3-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130200950.144618-1-a39.skl@gmail.com>
References: <20221130200950.144618-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document compatible for tsens on Qualcomm SM6115 platform
according to downstream dts it ship v2.4 of IP

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 038d81338fcf..c41fcf404117 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -53,6 +53,7 @@ properties:
               - qcom,sc8280xp-tsens
               - qcom,sdm630-tsens
               - qcom,sdm845-tsens
+              - qcom,sm6115-tsens
               - qcom,sm6350-tsens
               - qcom,sm8150-tsens
               - qcom,sm8250-tsens
-- 
2.25.1

