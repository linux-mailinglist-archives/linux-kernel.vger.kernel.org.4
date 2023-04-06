Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009276D9C4D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239699AbjDFP2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239720AbjDFP0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:26:10 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB0D7EFE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 08:25:58 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id c9so40867279lfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 08:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680794756;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h+aLAJdi57MkIHAk4AWHzzmjKf179Xo0Z9hPjbhZ5GY=;
        b=vXmzd7o//II0DtLBliD/Cd4YPIy37kAjJcHbAQteg80mPSYB7Fw1EOEM1480ywgr1r
         Yj8Mc5EqZ3NCoGpJFeqpZkzvWTWYfiJo3GZmYeikzok6CP0CR+5fGMr3DP6ee31NIfDb
         CahU+uRT6ycDKlv8XD7FFdY69MQDA64XoiKS0xOtNKI57G7APIsmO0jDbKF8pucFjuTc
         f/LMMRYZq70wJKLx6dzEgnjVadKQY4DUN0eIDbnaLXNMzK+jrFxJMNZ4AIWDE5GGF7uN
         6r23e8VAAVJFGZpE9izmbG4R60NUCxapaiz9S05KWGTN9hTTQx7DqurwNOHoey0fiCE7
         c30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680794756;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+aLAJdi57MkIHAk4AWHzzmjKf179Xo0Z9hPjbhZ5GY=;
        b=8M/11pfY6J94JPGhnkkg/ruN/VqD1ZzFOTTqV77IeOh5VHAg0YqhU4CLaZ5uY6dZL7
         dSUDjNq128ZyDoxUSHj4ayFlo+vobsYxPxNG7DI7xCyIPfT+sQuWsUIubSx7zkj8CpwS
         fzYZMtokB3Ntmp0DITqcQ9sRh8v3rgGh9U3ZhhjJLAFLquP3PYlffjhoZaT9Y3qSLxpz
         yZRuPGcSVQZ/0NQqXJbzuV6abKcODm/nRdfw6dRtFk8GNJvHx1yVld11k2o7QK3dyHvk
         HnIhYKdzplcBnMo7qrMUYVbeoLqtPHJmNvKfb94s5pWypki1mk7LxczmorYzHZpuqSFl
         1RcQ==
X-Gm-Message-State: AAQBX9dPS5jvtN9D1Bib/J1XOouOCOi/UWa2XXmCb1TaZ4MCQMyZsc1z
        4x43F6HqV1gBqx7LyzHrYsAYug==
X-Google-Smtp-Source: AKy350Z4x/RfCeYKxOpT96M2FR+1jjmIOz6NzlI+3UZcFUKfdeJ4TK7EZ8A2Rr17YTWhPQdAfs8cCA==
X-Received: by 2002:a05:6512:3e0a:b0:4e8:3d0:84b4 with SMTP id i10-20020a0565123e0a00b004e803d084b4mr1717667lfv.24.1680794756662;
        Thu, 06 Apr 2023 08:25:56 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id h4-20020a197004000000b004cc9042c9cfsm300103lfc.158.2023.04.06.08.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 08:25:56 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 06 Apr 2023 17:25:53 +0200
Subject: [PATCH 4/4] arm64: dts: qcom: sm6115p-j606f: Enable ATH10K WiFi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-topic-lenovo_features-v1-4-c73a5180e48e@linaro.org>
References: <20230406-topic-lenovo_features-v1-0-c73a5180e48e@linaro.org>
In-Reply-To: <20230406-topic-lenovo_features-v1-0-c73a5180e48e@linaro.org>
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
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680794750; l=1711;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=c+mfIUkIT3IWXbGjBUEX4H/q5dNkCi4IImmpojiqHv0=;
 b=36xnqFLl8WgGGY28BOulgRIS3xlFkVHwOuSSnkFCFyQYtEGlx0PnxuZQfPOkJjbl77W8FiK+voH8
 zfR8LwosC5kiFdkLG6NAnj5pW4JOFrzVdW/fDtWJt6QuQBjyFvz6
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

Enable the onboard QCA Wi-Fi. HW identifiers for reference:
qmi chip_id 0x320 chip_family 0x4001 board_id 0xff soc_id 0x400e0000

Firmware sources:
/vendor/firmware_mnt/image/wlanmdsp.bin -> qcom/.../wlanmdsp.mbn
/vendor/firmware_mnt/image/bdwlan.bXX [1] -> [2] -> ath10k/.../board-2.bin
[3] -> ath10k/.../firmware-5.bin

Not sure where 3 comes from on the device itself, gotta investigate that..

According to [4], it's called WCN3990_STRAIT.

[1] XX = board_id printed when the file is missing or by your downstream
kernel firmware loader in the dmesg; if XX=ff, use bdwlan.bin

[2] https://github.com/jhugo/linux/blob/5.5rc2_wifi/README
[3] https://github.com/kvalo/ath10k-firmware/blob/master/WCN3990/hw1.0/HL3.1/WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1/firmware-5.bin
[4] https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/wlan/qca-wifi-host-cmn/-/blob/LA.VENDOR.1.0.r1-20700-WAIPIO.QSSI13.0/hif/src/hif_hw_version.h#L55

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
index 2aac25171dec..4ba8e59a27d8 100644
--- a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
+++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
@@ -315,6 +315,14 @@ &usb_hsphy {
 	status = "okay";
 };
 
+&wifi {
+	vdd-0.8-cx-mx-supply = <&pm6125_l8>;
+	vdd-1.8-xo-supply = <&pm6125_l16>;
+	vdd-1.3-rfa-supply = <&pm6125_l17>;
+	vdd-3.3-ch0-supply = <&pm6125_l23>;
+	status = "okay";
+};
+
 &xo_board {
 	clock-frequency = <19200000>;
 };

-- 
2.40.0

