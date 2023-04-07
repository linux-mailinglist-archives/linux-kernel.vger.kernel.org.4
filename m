Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215106DB490
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjDGTzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjDGTyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:54:52 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330BF976D
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 12:54:51 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id h25so55662615lfv.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 12:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680897290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HrrXtbRkA/TPN5iifxIhcwLiJb4rv7pfySUS4qMYehs=;
        b=Uf1E/REFFX5GFkeXVT1+e3z009N8o23rDUvS1gCMi+LubcZG/stiFQFgN+9Rn4TJLm
         hCrsIsiJkjMzj8oninsA7fKuH/6niBTkjA/yqzDj01W11mgLJ1QGFuw2K2IuB3aAfLsx
         HBucvmcZrpmbePIK7iRpvSmUq6uBBO/OgiZBes0kfbSNGH/TDwRdj9g6IXNpXp2bpBgV
         uhgJq9tx6or7+Bt7L+1d5yQ+8fSichKQI8NviZ0NbI+AtdTQk90rJrGLm7jaSn/xGNQf
         Yz+WKC3n1mK2Of0hPwm3NVaTB2Cxrs8Nj8medEIZCda41pJkLFw7cd4uAEbpYsnfL6FI
         p4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680897290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrrXtbRkA/TPN5iifxIhcwLiJb4rv7pfySUS4qMYehs=;
        b=paWTeXUnkKiE/JP3yUGHvmJyy0plAg4Tb3Z0sIlxAoOM6OgXVWoEl2Rw9uTI7i4qb9
         Vaq1lqiAJXTqazymuRxFsXPAZLI2ySAb4ivLoHm+FKZKExPlZiZKPYChRzD2mCaE/GHM
         zpFEBLankiO3NXpsl1KV5qD631swr1B4pahnofxpIrlYVMpmAnTO6rgfGcO+aiPRHWFn
         oEiWY1ao6LmB4yyjJB+wYVcjBX/mt6OqDhsEEPIrvhv5fuR9Tj9vplSJmGEQ/cS2IQx/
         si7vrPyIyqWQJSI+ngEVX/AgqjdwQ1elGHlmdlq/kV0n7WbLZJhdPfXKIufIBJ4ZU3U0
         okJQ==
X-Gm-Message-State: AAQBX9daAvDyd5vAJ7S/q6gTAyc/Xzpeutd/pfDWMnSbFgY5/jpbqQaT
        Ozfy2iL33JSIHiGJhANgEvyjYg==
X-Google-Smtp-Source: AKy350b+PGdCiTvI6mSRe18Rp5mHPr19pLPZR+kKF0m5RE0EfhXSl3nXExaaisfhoEmAhbf6ogJHhw==
X-Received: by 2002:ac2:5290:0:b0:4b6:ecfb:ee98 with SMTP id q16-20020ac25290000000b004b6ecfbee98mr1028200lfm.41.1680897290751;
        Fri, 07 Apr 2023 12:54:50 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id u5-20020ac248a5000000b004d856fe5121sm839981lfg.194.2023.04.07.12.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 12:54:50 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 07 Apr 2023 21:54:43 +0200
Subject: [PATCH v2 3/4] arm64: dts: qcom: sm6115p-j606f: Enable remoteprocs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-topic-lenovo_features-v2-3-625d7cb4a944@linaro.org>
References: <20230406-topic-lenovo_features-v2-0-625d7cb4a944@linaro.org>
In-Reply-To: <20230406-topic-lenovo_features-v2-0-625d7cb4a944@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680897283; l=1042;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=LheeN2mshsAs8brSHZ+At1/DkO/Urs9BzGBJSfcH0V0=;
 b=n7GkBgoMqoqy2+U6y+lxt6w26SMGcXHwa4SOBOfhJ9tg7oDFeyBsaWpfojbP797Ad6ZC63v276w3
 bphMEjZgALDUYvIIIAiHSM4TQYLqph0NqSasINjVr2ajYzf7XbH7
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

Enable the [AC]DSP and MPSS and specify the firmware paths.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
index cd47fbc993ba..bc232deb802b 100644
--- a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
+++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
@@ -89,6 +89,21 @@ &pon_resin {
 	status = "okay";
 };
 
+&remoteproc_adsp {
+	firmware-name = "qcom/sm6115/LENOVO/J606F/adsp.mbn";
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/sm6115/LENOVO/J606F/cdsp.mbn";
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/sm6115/LENOVO/J606F/modem.mbn";
+	status = "okay";
+};
+
 &rpm_requests {
 	regulators-0 {
 		compatible = "qcom,rpm-pm6125-regulators";

-- 
2.40.0

