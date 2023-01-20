Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE79675F4D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 22:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjATVBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 16:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjATVB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 16:01:26 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D7FCE897
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:01:20 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id tz11so17108825ejc.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZI0mGZqPWNWXo10nShEsAnlud3zWKZXf/8L1lgJABU=;
        b=VKHyVpdfr1VP8s+ttJ18P1ptwa5pjtcz8Pd4A71OK+zYUz7QfN9HCLCaEf6v3vXD7I
         Po3EdOboLWrqsQe68s4V9be5TB/HvlFC2v6PCuE6NoX7JMgveySJRdFlTCGWkcrZG2C6
         Lgb8KW+orzRBZe6Wp0GI+CVCYgOMUUs6Jvxte9riSrqcGxlIsoF87FAE+e5L43I7+VrK
         6Qyv4kFRgi92nF1tKNB/YiDiEbBc7Uz8KKacz0fKEerLTYk6fOVjnmNv19GF98gEBCtL
         wpPKK6yjdp7zyJ98+Z+ciRWf66F6mQRhNfeObR+D3eSYK1bosWkpGjqPXolURzJLg6fM
         wIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZI0mGZqPWNWXo10nShEsAnlud3zWKZXf/8L1lgJABU=;
        b=vYSGWmnoRfvEeB/xeZbBxv8eOeNFP0to9BMJF/O7cIzRGjDPbVhM6N50czPSRsmTMS
         i+EA5diriwM742Xvq6xx/v/mjWvYXpC4gheEBUBses7LXayejK+b/nx3uG0PRZtsfyAY
         oV5NnrcE9k9CGhi0sXFG+OtpVIpkkZdBK14mjo/2Bhc220uSdpkMCPlj37QXAYbtwk7r
         1ZyXIoAxJxBf9w6lRl9FXQaTzjhLmwpEPxtJiUdhf4knZ22QFfY0FwRkRbroYAnZr6gv
         UsUuxCPF9gRuT2YlKUkcEUj/SuGe9OC3myQ9/4fvj4k2dO93K92edOn/d7ALynNQuMV1
         GQ0g==
X-Gm-Message-State: AFqh2kp2Lrze1txE1mVUXNyXWeTQfkO7wATs1dIgkUG/f36C8BE+ggNz
        WMPGJM80g9/4IkWId9Mheu48Gg==
X-Google-Smtp-Source: AMrXdXtGHb97GiTH9eM7hMgq/1duL22/HTOfybkpkkSEk6RfbLNX2jepelJYZxwPa5Um3RKUWXJi6Q==
X-Received: by 2002:a17:906:1605:b0:872:41a5:7c78 with SMTP id m5-20020a170906160500b0087241a57c78mr21938890ejd.3.1674248478851;
        Fri, 20 Jan 2023 13:01:18 -0800 (PST)
Received: from localhost.localdomain (abyk37.neoplus.adsl.tpnet.pl. [83.9.30.37])
        by smtp.gmail.com with ESMTPSA id g22-20020a170906595600b0087221268e49sm6581229ejr.186.2023.01.20.13.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 13:01:18 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Foss <rfoss@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 3/8] arm64: dts: qcom: sm8350: Fix DSI1 interrupt
Date:   Fri, 20 Jan 2023 22:00:55 +0100
Message-Id: <20230120210101.2146852-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230120210101.2146852-1-konrad.dybcio@linaro.org>
References: <20230120210101.2146852-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt was wrong, likely copypasted from DSI0. Fix it.

Fixes: d4a4410583ed ("arm64: dts: qcom: sm8350: Add display system nodes")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index c0ba67747c24..ed0106829cb9 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -3062,7 +3062,7 @@ mdss_dsi1: dsi@ae96000 {
 				reg-names = "dsi_ctrl";
 
 				interrupt-parent = <&mdss>;
-				interrupts = <4>;
+				interrupts = <5>;
 
 				clocks = <&dispcc DISP_CC_MDSS_BYTE1_CLK>,
 					 <&dispcc DISP_CC_MDSS_BYTE1_INTF_CLK>,
-- 
2.39.1

