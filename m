Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8783D6DB492
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjDGTzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjDGTyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:54:54 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DABA27B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 12:54:53 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y20so55691794lfj.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 12:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680897292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UnW6A28IKcreFUAfuKike2SwwSqJ7t/qMOojsEiWd3o=;
        b=MwmFmghBv6y4HhNOaxXFNNuzkqK19RmVnmxCLV9ziJFoBJj36Uyj22QNGse8V10FED
         Ycn7rsZiJL7XOKtpf2EWV4qpPMfUhdv759rK9a2kBagd+9O0MfW2SvdgHXF+DUTidvs6
         0NuHdJn3tVfqdpCDpOulLjBicpoCTzr3Z76kGINvmk9J8UjgMozQcjVmuJe1r162BW8k
         xPPpd9R1EejUZmmFLIXV0Fs3gJ58IpJjXaP2QB7wdOKDHWeyecXoDyo9R5jEoEolHS/L
         9TsgTijFoz1ncDgN4P1a1yY63cg2NdIvwe9c3BJ1gmk8w49kPK3Pyl/XcLIrZN90ocYf
         MEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680897292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnW6A28IKcreFUAfuKike2SwwSqJ7t/qMOojsEiWd3o=;
        b=Smukj6oo2RQqj+jn+wJI24OsIECZ/zYsvYkK9tduF9GDST/CHYyW6rvP7m1aWZKKIn
         1WtcMr/6nB+JEHLBjPwVAA7fATisDgSAtCti1FsPDwXnzm35xxKrA2vLJsdO1PI8l4EX
         9sN2rLNne0UI2ukiwUSM+uweITlJtNEzmq5XQvr+1EWkNYuYo2D93Z20ceZ7PT6ceK+2
         uFKqa12tl4Ar8lhxnYMHQB92ZnW22vP/pvHnmIWvhi+HJwtRGTq9uT87Crbc3DDv2tdc
         hFftr4uYZEkM9qJoa6N7NWALMUY7om/u4XO+JYxG49PGRMFywLAuku6ZTZQaI1pF9e7H
         bn6A==
X-Gm-Message-State: AAQBX9dvMug2za8oUQlc0rGcBCLKJyVchs55JlsWbZVeakwRrOKvuxax
        VNy2Ij75MEjiHLMxC5MuNOGy0A==
X-Google-Smtp-Source: AKy350ZZhBTnloXL3RG6GqwZQd81A/jMWiVaAxZ9A4Rr9J2WSc8pzQlD5NC/nIpe1C+nfs6cMJsEPw==
X-Received: by 2002:ac2:5f0f:0:b0:4eb:13ff:6ca7 with SMTP id 15-20020ac25f0f000000b004eb13ff6ca7mr918254lfq.16.1680897292119;
        Fri, 07 Apr 2023 12:54:52 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id u5-20020ac248a5000000b004d856fe5121sm839981lfg.194.2023.04.07.12.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 12:54:51 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 07 Apr 2023 21:54:44 +0200
Subject: [PATCH v2 4/4] arm64: dts: qcom: sm6115p-j606f: Enable ATH10K WiFi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-topic-lenovo_features-v2-4-625d7cb4a944@linaro.org>
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
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680897283; l=1763;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=b3Zu3ZZnDQhyKIftWOiLA89iYJJNHGbq+oJ3wY2oUSk=;
 b=eVPsQfPvLHPeKGN8di7rL5TOwfLtMuC4wjd3d03xaNYMEJ9N8wylr+p90aUi7lfQEjG2NeH+8QY4
 XrznSAhtCYgwlrLVRl/DbslgdBrm3qdA/s64o9xWOM3fnCnTixe/
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
 arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
index bc232deb802b..ea3340d31110 100644
--- a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
+++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
@@ -315,6 +315,15 @@ &usb_hsphy {
 	status = "okay";
 };
 
+&wifi {
+	vdd-0.8-cx-mx-supply = <&pm6125_l8>;
+	vdd-1.8-xo-supply = <&pm6125_l16>;
+	vdd-1.3-rfa-supply = <&pm6125_l17>;
+	vdd-3.3-ch0-supply = <&pm6125_l23>;
+	qcom,ath10k-calibration-variant = "Lenovo_P11";
+	status = "okay";
+};
+
 &xo_board {
 	clock-frequency = <19200000>;
 };

-- 
2.40.0

