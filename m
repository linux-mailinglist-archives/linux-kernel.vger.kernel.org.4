Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE1F6F5174
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 09:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjECH2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 03:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjECH16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 03:27:58 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56262D6B;
        Wed,  3 May 2023 00:27:34 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-956eacbe651so958026066b.3;
        Wed, 03 May 2023 00:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683098853; x=1685690853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Vjy0njVYlk4DJBe6xXSLpMploNAvBdfi1zWVLfGo2U=;
        b=RUTK25YiYQ7CLZ05QlEdu4wwlG6TLGr87ALM61BMl/m6DuJmNWK1nuTM3Wmac9dMoB
         yHhe09fi/Sr4sqM/xTuNKniouv5zKjknoZCWtP/wNmrkPiIcnl2549PIwfvVG5x6KDfT
         oNQ5kt9So95GgFCbgc2diRmJ5A8c0FR+oC06PIASBr5+yrJliznri9dfJIHzPQDRjifr
         FTRUJJCTOAOYLWc25G4IHNp3uLlLEQ5+QIMvs/gCgZUCO6Aeg7o+7ipgGVCEbC5fBCyP
         Q2FXc+Pn9+l067pWUplTRbZm52Fvgw68QdXfyyHIFGHkOUpnz5F6jidVAAVFGWAPs3Sr
         ZDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683098853; x=1685690853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Vjy0njVYlk4DJBe6xXSLpMploNAvBdfi1zWVLfGo2U=;
        b=ip3UhNbWX548rYOEbEvfh7+9IvlXWT/iiMIrh5Z20XB/BEpTnah/YbFoQ39ZFbat/L
         dr889RRbl8AGLo3k5WE+0RmAab6Rq8Qdi234gUi8BY398NcNjogsgjft90Iic6nISJ/4
         BAwN/xd1Tr8h2MHkVOFjwirpWMGpWwADwSHWOPwUESqV//y+o78N3Y7zTxlYXfozLblQ
         qVL+KB37G4+F4JMmiG1iJdwZEZBy/3M7SJWkED0FreQLtzbCb4THhM2D6KlUQLB0hEv/
         z5lEfE6pVT3J1fW7MvQ5RVwEFoQ7Oogbn1gxAr+pKswGDGvnytSNqvC/5UvBzef4pnCo
         1LuQ==
X-Gm-Message-State: AC+VfDyoyN7Vc29zgsWWyVA6CIt+LTpRbGNOeRcc+g3Y1/AEG2267QKl
        nv5Hwa/QwUYD9XHol2YMIso=
X-Google-Smtp-Source: ACHHUZ4T9bS8sbiihvCjmQVgyX4U1r515yDDgtUgefwQNOSSPoZ1kUscQBDeTBBAMACBZSDhpDziiQ==
X-Received: by 2002:a17:907:3da2:b0:960:f1a6:6a12 with SMTP id he34-20020a1709073da200b00960f1a66a12mr2444084ejc.55.1683098853270;
        Wed, 03 May 2023 00:27:33 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.33])
        by smtp.gmail.com with ESMTPSA id t26-20020a1709064f1a00b0094f34fe27c6sm17072009eju.170.2023.05.03.00.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 00:27:33 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hansverk@cisco.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: qcom: msm8996: Add CAMSS power domain and power-domain-names to CAMSS
Date:   Wed,  3 May 2023 10:25:42 +0300
Message-Id: <20230503072543.4837-3-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503072543.4837-1-y.oudjana@protonmail.com>
References: <20230503072543.4837-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add the CAMSS power domain as well as power-domain-names for all CAMSS power domains.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 30f6ebc4bd11..0168a086f57d 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2118,7 +2118,9 @@ camss: camss@a00000 {
 				"vfe0",
 				"vfe1";
 			power-domains = <&mmcc VFE0_GDSC>,
-					<&mmcc VFE1_GDSC>;
+					<&mmcc VFE1_GDSC>,
+					<&mmcc CAMSS_GDSC>;
+			power-domain-names = "vfe0", "vfe1", "camss";
 			clocks = <&mmcc CAMSS_TOP_AHB_CLK>,
 				<&mmcc CAMSS_ISPIF_AHB_CLK>,
 				<&mmcc CAMSS_CSI0PHYTIMER_CLK>,
-- 
2.40.0

