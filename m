Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0835F0EF8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiI3PhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbiI3Pg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:36:57 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC0F1A0D20
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:36:56 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 129so4488295pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ZxqNeg9qYIg+s4/UlajiiC5HVdIkGrA2Kg81oKMQ+/o=;
        b=ksNJeksNLwIY/rpd0fWUf+Te+/bxcrN2bGCTzVlMyb9TRGW7RUmlnW1iEfp/ckw4+8
         QvHwtMC8jkc3hPnu2xaan5dRgwCXJ+tk4Ea75d+59X7D1J1SSPh0WeZCP3OJkcPoFmSW
         gX/Srdo/WYMBb7jFFe0ZJI+sTRQU390yexSqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZxqNeg9qYIg+s4/UlajiiC5HVdIkGrA2Kg81oKMQ+/o=;
        b=qxVH9e/11pkv+qmO9c7opXVbg9/Ro7LOEnabef+xQ5ZITsRiZjDqY1N+uCzuCW7Uy0
         lad3CQ3SejYftFDqmOtA0ygK9ao/0E2sMw8HIJXk5G0aUbzSWfVcA5IXOrzJXslUmR5y
         ekXuTDoBqqwXgNXW0/jP1l7rhmTnBM2A1Vo8PJKvz33xkxI/12B9fyqtSijpAtSX2Ibv
         BonC+L0nNdlm+UbTRaXMg4PB8g8smvgLZ05ptGm9qQMWxSUCUyjwzezCDKbzWR7aHhOy
         DhGN6bnvnmVUOXRL+StAajsJInfW+WxY7L0gi3i3Jb7fmDlfCTHWWgQbmNtrtyyeG0Y8
         FIzA==
X-Gm-Message-State: ACrzQf3tPTKv2p+df5Ztb8BcdAR41XvhAeygXR6HCo6BVqYlQCMCGI49
        34co2toUuI/37Jk5VGnlTF9Bbw==
X-Google-Smtp-Source: AMsMyM5eTepICctmAmSn5g9cc4mggiq9B3ai+b4KcYpc4PM9p2a6gM05xb08V4IprjyxdJqwyiyhJw==
X-Received: by 2002:a63:24d:0:b0:439:3804:d0ff with SMTP id 74-20020a63024d000000b004393804d0ffmr8091351pgc.414.1664552216064;
        Fri, 30 Sep 2022 08:36:56 -0700 (PDT)
Received: from judyhsiao0523.c.googlers.com.com (21.160.199.104.bc.googleusercontent.com. [104.199.160.21])
        by smtp.gmail.com with ESMTPSA id s13-20020a170902ea0d00b0016d72804664sm2025155plg.205.2022.09.30.08.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 08:36:55 -0700 (PDT)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     andersson@kernel.org
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        dianders@chromium.org, mka@chromium.org, cychiang@google.com,
        judyhsiao@google.com, swboyd@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Judy Hsiao <judyhsiao@chromium.org>
Subject: [PATCH v5 1/3] arm64: dts: qcom: sc7280: herobrine: Add pinconf settings for mi2s1
Date:   Fri, 30 Sep 2022 15:36:41 +0000
Message-Id: <20220930153643.2018907-2-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20220930153643.2018907-1-judyhsiao@chromium.org>
References: <20220930153643.2018907-1-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Add drive strength property for mi2s1 on sc7280 based platforms.
2. Disable the pull-up for mi2s1 lines.

Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index c11e37160f34..83a42a77121c 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -639,6 +639,36 @@ &dp_hot_plug_det {
 	bias-disable;
 };
 
+&mi2s1_data0 {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&mi2s1_sclk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&mi2s1_ws {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&mi2s1_data0 {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&mi2s1_sclk {
+	drive-strength = <6>;
+	bias-disable;
+};
+
+&mi2s1_ws {
+	drive-strength = <6>;
+	bias-disable;
+};
+
 &pcie1_clkreq_n {
 	bias-pull-up;
 	drive-strength = <2>;
-- 
2.37.3.998.g577e59143f-goog

