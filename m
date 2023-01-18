Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBA8671FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjAROgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjAROgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:36:11 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24F34DCDE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:25:03 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id b7so8112618wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUkyFlJusLSnwIIR/wf8AL5ONjMFRSNPV9rHtyU1Zww=;
        b=NbeSaHSrJ5yPyIfWeYbJBvgYMFr956GkLKeI246tcDhvBsEIdF2PQk3tET/4T8hg3K
         LEQBQpoGZc4MM0Wl0AGaaZx5i2gry8WBIL4Mjz2SKSlr+zyXDl0IQMw3s9SnbDsQj7d+
         wpkN9paKRF8UKwCj06V1KiV7rcc1sRyR32BD8F79G2uJOW5aacE/GM+FwP98ykZu7WmS
         wU07IFaZiD9xv8ae4E2NQZrpt5OxT2YlQSFJONV96EfGCyWamXr6/JvKfsSL3qWb79qO
         QZqdN4ZX5N6UMazXNB9+zwywdT7oR2FzzyKKH5Z3yfgXOmNNYCzXcQe22G9ZOF3EQV6E
         rwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUkyFlJusLSnwIIR/wf8AL5ONjMFRSNPV9rHtyU1Zww=;
        b=Yn4nTMAZ9XbP0siZKna00IiU07aHOwAZIAi4zcD/fMlanE4B4bvtJBkiTvu5IkprxY
         RwFJKHSv15x/ONLaTGiNu1tNCqigURgtXcMBfLHlxgZ/zHbKv4JDw8/tlFKdcwaKxK0I
         CMAATruSPCDHUG861MaZv9NAAuc1SHNUKZ4lkNuIEd0kzRm6a3QmptUz3CF77i85A+cd
         hhz6oVolrT8Qv3FBOjc7qEdyUR2xY6QCa0hyDFf8KvpvOBwJWMCcXu1V62+8D+0ScwXG
         IHU81UnZdEb9fdFwQH2/ReL3i8nOOwLt619jcccir91c98Bfi9hzO/twULScLq6agJa1
         PsiQ==
X-Gm-Message-State: AFqh2krEdkeqRTDPWfQaoVLCpcnDo7iRwDtBJ7xx3+Cv4k4VucbzdxXF
        Wd7lJfCAcjDxs+YfwWNusW/kJA==
X-Google-Smtp-Source: AMrXdXsnBmFmC4eIVNJl+lLpVQkHbqavB5ac4cuudf4xjdFXaHPZDW6ajfTH7Mt50uHzS2xXa4FK5g==
X-Received: by 2002:a5d:66d1:0:b0:2be:3538:2ef2 with SMTP id k17-20020a5d66d1000000b002be35382ef2mr1001975wrw.45.1674051902361;
        Wed, 18 Jan 2023 06:25:02 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id h3-20020adfe983000000b002bdf5832843sm10612919wrm.66.2023.01.18.06.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 06:25:01 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 18 Jan 2023 15:24:57 +0100
Subject: [PATCH v4 2/3] arm64: dts: qcom: sm8550-mtp: enable display hardware
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230104-topic-sm8550-upstream-dts-display-v4-2-1729cfc0e5db@linaro.org>
References: <20230104-topic-sm8550-upstream-dts-display-v4-0-1729cfc0e5db@linaro.org>
In-Reply-To: <20230104-topic-sm8550-upstream-dts-display-v4-0-1729cfc0e5db@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index 81fcbdc6bdc4..0dfd1d3db86c 100644
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
