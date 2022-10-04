Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74E85F3DD5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiJDIIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJDIIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:08:31 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A302CDE2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:08:28 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bu30so183577wrb.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 01:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=omyJ2+Yvtg/1K+Zuwm5EWF60S7/hDyGjB124c9861qM=;
        b=H1GaYf/JKNR0prajMrnT++ezhghOe9mNhnTs7BMdstQa2nuofxX3Zfik5EtEb8j6YH
         CyrLCs/ECz7A+ODNNLj2xgojpPYPJIKHwz0CXm9d+tRE6CffluqMuzE60kIobly4ZzT6
         2S/Bl5O0qyz3dsUanuldzhw+gR8phnKo1BZ8yLJroHndIxo9iTf+kDqvE3nSybYZ7HWY
         L7Wh3/m/borYUo8YM6mJCz10TElYGxw9ICxu7LRv3eWoNrLv7gBTY78VQvEK1TJ8H5JG
         HKa140k1V1qlJff5+i/Vu6FsVKHkdnZ+/U4BCazsi5C6iBl8v2nuyzoONpgoBG57m7SL
         rS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=omyJ2+Yvtg/1K+Zuwm5EWF60S7/hDyGjB124c9861qM=;
        b=Nf1Bokn9Iad2o001JKpEfSRFnLlboNh8Ukk1GR4ZG7EHWTvngmth/YzoX9NNhwL9vB
         X1tgkXeBbGDR3z9Sgn+IIj+I1dun17wcv7BHjr7n3Ltq1OguLlFUeVsjEfC4YQC5yBY1
         MgviH8mxDw8mQzhrLXa9ILsIE63xNmeR3MlJ7TBO0Jy/uOKq3RSWTMomHP8eH6dY0dki
         0EsvoLhKKJjSBc+U79xa7QmxZCAiStFGDo9CXmzI8VYO7wjnjzWfwk0THGvr2tkG6AjG
         MDMJ363AIe5N4k6RgJ2cR1tg6Yy6O7znM+ZQwaAV7tQlMGH4tjlKe4gj755A1JdNgqrm
         DRJg==
X-Gm-Message-State: ACrzQf3ep+8gMgKpqjlgDCYcjKbX3AYTS7V51JZKC4VzcOXgdDfcVvib
        syQT0nPhGO9udfKB9L+XOzAnUQ==
X-Google-Smtp-Source: AMsMyM7UcsRYJRURnJD0AcBiwANc06uYZmU22chyYEmoRTyxl4E5LBN7QbSFzLpFyf+jd89PevtyhA==
X-Received: by 2002:a05:6000:156b:b0:22a:a83a:d349 with SMTP id 11-20020a056000156b00b0022aa83ad349mr15635586wrz.277.1664870907039;
        Tue, 04 Oct 2022 01:08:27 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id l2-20020a1c7902000000b003b33943ce5esm20228866wme.32.2022.10.04.01.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 01:08:26 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 04 Oct 2022 08:08:19 +0000
Subject: [PATCH v2 03/11] arm: dts: qcom: mdm9615: add missing reg in cpu@0 node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220928-mdm9615-dt-schema-fixes-v2-3-87fbeb4ae053@linaro.org>
References: <20220928-mdm9615-dt-schema-fixes-v2-0-87fbeb4ae053@linaro.org>
In-Reply-To: <20220928-mdm9615-dt-schema-fixes-v2-0-87fbeb4ae053@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-input@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org
X-Mailer: b4 0.10.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes cpu@0: 'reg' is a required property from dtbs check.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
index de36e4545e75..eaa3236f62db 100644
--- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
@@ -27,6 +27,7 @@ cpus {
 
 		cpu0: cpu@0 {
 			compatible = "arm,cortex-a5";
+			reg = <0>;
 			device_type = "cpu";
 			next-level-cache = <&L2>;
 		};

-- 
b4 0.10.0
