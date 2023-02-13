Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0755D69487C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjBMOqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBMOqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:46:44 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3664E1C30F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:46:34 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id cq19so10492737edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mYt0UvSCB3GCUEfFP2VKDcvyRzb86/6xZ/drofUnvWU=;
        b=H7CmGL4toJujXUyjXiOqsBKS3oQ/OPCqgVxR2qZX3NIeNQomor2BuTBe3CxRxqblOg
         yYfBXQny4rQqh8eTKQjULC97fd68fuEk/j88P6cGhkoqjNmfsUnk6Thq/HwPVKffaTLq
         hJ4EVomttNgezaxMnpMSAekHR3CBBEALmptn7WxA8YPndyn/qrQcSI9L/239c9nhGfhs
         AuLXsPwRbpI2oROquQp6CUGkJgaeWHc34u39xDVF+HhJJ7KpqfoS76/sy72Darn9lJRp
         j0grQk86/WmBZx38gX2/wXwYFtMwjRQf3g+IlLzTgEtY4THIh0DXVw6OPRvpPDUHkNIk
         3BOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mYt0UvSCB3GCUEfFP2VKDcvyRzb86/6xZ/drofUnvWU=;
        b=xW9qe5TkbleA9h0yWtMS6AZuenDCCefGPOlmPlb8CVBIsv8zlLdgWQSKl9giBZbyxf
         EkyyhxsxmSMJPQVP2ArgNhRctQxnC/sQEPZxIDcve/9Sbxyqh8OoOPZHVfvWv8vosDiH
         HnGwiCjeVneK4Au+7PvrjbCOHcJyS0q642FGE/MO4rJkooExQGz19mTxPZcSjwbZGAAu
         ngFI96+Z7gA4LpFvjcaKp/MhB3Nq9e3mi4HCqKLblLGXcUCJwoIMwr2h6Qt5XkSrQTWY
         f9Al4Ezt8wskDqBoJPTqToTGCf93EsP99PLkkAvkGLa2sNgPSx/mhVFwrzumDVSU3bok
         fTwA==
X-Gm-Message-State: AO0yUKXNpbK89TFwAKw656n7nlGq4Xrj9s+sFrq7bsRwMpJ+mkzWYYTh
        ewkdnAc3h43ERIVlGIeuxIIe+Q==
X-Google-Smtp-Source: AK7set8kR2+9bPXCt4cS7kPEIOFtMli+K3NI8BYypsYy9bfi0z72yfNI8hiPIiJhzQbpCmp7+qBE+w==
X-Received: by 2002:a50:c35a:0:b0:4ac:c12b:8ef8 with SMTP id q26-20020a50c35a000000b004acc12b8ef8mr4904070edb.26.1676299592737;
        Mon, 13 Feb 2023 06:46:32 -0800 (PST)
Received: from [172.16.220.87] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id b19-20020a17090636d300b0085d6bfc6201sm6884208ejc.86.2023.02.13.06.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 06:46:32 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Mon, 13 Feb 2023 15:46:31 +0100
Subject: [PATCH v2 2/2] arm64: dts: qcom: sm7225-fairphone-fp4: enable
 remaining i2c busses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230213-fp4-more-i2c-v2-2-1c459c572f80@fairphone.com>
References: <20230213-fp4-more-i2c-v2-0-1c459c572f80@fairphone.com>
In-Reply-To: <20230213-fp4-more-i2c-v2-0-1c459c572f80@fairphone.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable all i2c busses where something is connected on this phone. Add
comments as placeholders for which components are still missing.

Also enable gpi_dma and the other qupv3 for that.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts | 33 +++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index 86114dd2c0c4..7ae6aba5d2ec 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -359,10 +359,39 @@ &cdsp {
 	status = "okay";
 };
 
+&gpi_dma0 {
+	status = "okay";
+};
+
+&gpi_dma1 {
+	status = "okay";
+};
+
+&i2c0 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	/* ST21NFCD NFC @ 8 */
+	/* VL53L3 ToF @ 29 */
+	/* AW88264A amplifier @ 34 */
+	/* AW88264A amplifier @ 35 */
+};
+
+&i2c8 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	/* HX83112A touchscreen @ 48 */
+};
+
 &i2c10 {
 	clock-frequency = <400000>;
 	status = "okay";
 
+	/* PM8008 PMIC @ 8 and 9 */
+	/* PX8618 @ 26 */
+	/* SMB1395 PMIC @ 34 */
+
 	haptics@5a {
 		compatible = "awinic,aw8695";
 		reg = <0x5a>;
@@ -495,6 +524,10 @@ adc-chan@644 {
 	};
 };
 
+&qupv3_id_0 {
+	status = "okay";
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };

-- 
2.39.1

