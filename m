Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C495FC99F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 18:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJLQ7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 12:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiJLQ7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:59:17 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD653FDB7D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 09:59:16 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id i9so11302816qvo.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 09:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QEi7mCU8aFQrq7+X6TvhVYf4QcPUFRJ3UuljS9y8koA=;
        b=seNl6HDTdPRmel6AJpVZSoutBpRKvr+Fl5eYJyJfzmQ09TFhOHG7w9fH+YZ3MeaX3F
         tfa7o/90smt5ohP3CfyZPWln986aidkMqSi4xH2UYQ9hZoJ8z6JUt1B4JfkBOSnPTckU
         L2MHRFVagT6JJTCYwIMABOuiQo/EistC7XK3lst2zcDplPuzbulJk2xRM77d+knDeRDc
         Qj5EJdZX95pei/CPMjqLwpAOlcilE7Jsd/rzS7t21U4xn9CNNdtyt+JPESojYzpV5l05
         rHVYLTKefmG1zjpKjqH/Xs500V1Hc3V8SETGBP8WM6aKSbV+h+AiAJIdofSsAPID6mq8
         4vQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QEi7mCU8aFQrq7+X6TvhVYf4QcPUFRJ3UuljS9y8koA=;
        b=BXux6U1WFXnxxUoeTEMT9Snx6BjI2zsd+URBmoZNaaPRFqxDBlBI4h6o7Jd1rxtD6g
         UhgyikgmoA4UWhoVNOJTSLn6sl2TUj2Qqi6TjPl8LOINNEgXNXaMaDV8+C9r6j0ZlJyc
         pkm3JDASzCLZ5wjFrr64T7jDMDzIvntd9nhv8AQCVFNg4J2KBBau/CqXvQW1vNnBTf/t
         7ISKo32LTcmA/UxES+UGuQh3129LM08GNOl4NNQnS91eAsFhHubUilcjO7QLaVVn4ypR
         LeSgiJbipFLNoIcpqnkUCw4LN8ZZtZRwHUSnTEbPz2fMSNUJf1nvR0LlSszsWJnztr8l
         56HA==
X-Gm-Message-State: ACrzQf3Hj/mpywztp6YTxSRIqlYQfxLpaKvNyBS9MCESGP79TLSbXvfH
        /XyUGcXXcnyBD9jPKnea8Lg9fg==
X-Google-Smtp-Source: AMsMyM6x34jR+AP+1/mSelLoInUqYH5ACE9NR5sY5Ibk5fqjjftS3t/PO24LF9V3ByCJkQ+scARgvw==
X-Received: by 2002:a05:6214:d8a:b0:4b1:9f67:450b with SMTP id e10-20020a0562140d8a00b004b19f67450bmr24107709qve.119.1665593955541;
        Wed, 12 Oct 2022 09:59:15 -0700 (PDT)
Received: from krzk-bin.home (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id r4-20020a05622a034400b00398a7c860c2sm9476039qtw.4.2022.10.12.09.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 09:59:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] arm64: dts: qcom: msm8994: Correct SPI10 CS pin
Date:   Wed, 12 Oct 2022 12:57:10 -0400
Message-Id: <20221012165712.93053-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The GPIO55 is part of SPI10 pins, not its chip-select.  Probably the
intention was to use one of dedicated chip-select GPIOs: 47 or 67.
GPIO47 is used for UART2, so choose GPIO67.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested on hardware.
---
 arch/arm64/boot/dts/qcom/msm8994.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index ded5b7ceeaf9..7a582a5fe3a8 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -897,7 +897,7 @@ default {
 				};
 				cs {
 					function = "gpio";
-					pins = "gpio55";
+					pins = "gpio67";
 					drive-strength = <2>;
 					bias-disable;
 				};
-- 
2.34.1

