Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CDC664C60
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239622AbjAJTXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239842AbjAJTWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:22:45 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01985551FB
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:22:44 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id ja17so9549998wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5zlEq+szaC9jzYJEsHWHt1ai4b91KOiLfW+IEavVvd0=;
        b=HvoTMm1s6sdwPzv8C23cwaqXrMEshROIJmcbTzHuCChp7AhXKL22TQjkA1SJ3L8fLE
         JMoPdfN9B+lz315IGm6RjGH31V5C0jeQfUdkJ/Bv7Pfw2asg1edzfDR4rGB2FbceMJtO
         OBRzt/EkjVTMMoLKzrAkzYev5dlcRcmQq0SL4EoHZxU1vKcu497xOvplcO3m+c4u3ZtM
         fjyHDtjFVvc7rp7AYb9F4H/sHvQgc2zN3sxOKXq5AZ9L5CgAlT2tw/Cx/doiD6nheivN
         bSgw5MSv7TwqqlK9BhcLwOIddmcgmH/EUcnZL7D6JoxYgts8TYd+N88nAYiJ68CLQ4Xl
         PwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zlEq+szaC9jzYJEsHWHt1ai4b91KOiLfW+IEavVvd0=;
        b=HZTMEVayGSV6L1YjS/R/HGiQJf8eN1e192tmpcI4gfLXbfBYQMmTk52O91pL+C9nd7
         lK+sNUW+8x9cUbMKmHzq5C0fMFHHz2lSQyaYctDjuy3WZpL98mA744cjhgJmGVaGaWaP
         65WayIUc5lkIvm7So7oxvWwYjeXoTVgTTfjBz3Jx7KFp5A3ZdbNGb6P7iM4Eno5JpOBb
         wNlDqKwhkQv2f1oeg1raQW86THwVoUkaAWCinHvwoKD/5h7iRDDvRYDpqJCOMa64bjE3
         RfkPGMMH74WP++az83vKxdCl7d3Kfkpdx03v1ESvdi0+98ufSEvgpeRQ8+ovKCKkj7S+
         SYDQ==
X-Gm-Message-State: AFqh2kqRYAsiIrCehwjz+kUWy4JzpkKCgZUQ7idZaowgNJ3uV2RmM8Nk
        tO+vDBHlsqyQ0uCj5U3QtacP4A==
X-Google-Smtp-Source: AMrXdXtwl+tzR7j30Byk5USB7+6s9fh52dD7EGx7AkK55FEmF+V9UI5OtGX1Xv2Gjx5FtRTuqXuV0Q==
X-Received: by 2002:a7b:c3c6:0:b0:3d2:3376:6f37 with SMTP id t6-20020a7bc3c6000000b003d233766f37mr49599033wmj.10.1673378562582;
        Tue, 10 Jan 2023 11:22:42 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l14-20020a05600c4f0e00b003d96c811d6dsm22284343wmq.30.2023.01.10.11.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 11:22:42 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 10 Jan 2023 20:22:37 +0100
Subject: [PATCH v2 2/3] arm64: dts: qcom: sm8550-mtp: enable display hardware
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230104-topic-sm8550-upstream-dts-display-v2-2-9fbb15263e0d@linaro.org>
References: <20230104-topic-sm8550-upstream-dts-display-v2-0-9fbb15263e0d@linaro.org>
In-Reply-To: <20230104-topic-sm8550-upstream-dts-display-v2-0-9fbb15263e0d@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable MDSS/DPU/DSI0 on SM8550-MTP device.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index 8586e16d6079..5b7e301cc2a2 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -359,6 +359,28 @@ vreg_l3g_1p2: ldo3 {
 	};
 };
 
+&dispcc {
+	status = "okay";
+};
+
+&mdss {
+	status = "okay";
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&vreg_l3e_1p2>;
+	status = "okay";
+};
+
+&mdss_dsi0_phy {
+	vdds-supply = <&vreg_l1e_0p88>;
+	status = "okay";
+};
+
+&mdss_mdp {
+	status = "okay";
+};
+
 &pm8550_gpios {
 	sdc2_card_det_n: sdc2-card-det-state {
 		pins = "gpio12";

-- 
2.34.1
