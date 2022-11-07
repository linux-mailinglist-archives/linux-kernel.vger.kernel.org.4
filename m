Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1436E61F214
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiKGLlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbiKGLlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:41:07 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640E41A3AE;
        Mon,  7 Nov 2022 03:41:04 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h9so15818484wrt.0;
        Mon, 07 Nov 2022 03:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rmhla3csj1QnIc/ifXl6LMJ1rocErgRj/cyob/iBjRY=;
        b=hB9abZnoPuEw6kD8hqcOdC5ebz1Xe0NTAK9hJCuN/iJchSS5FMp+l2ci/cXvkgcIbC
         /CsGBlfOO1JJKi0MwybYsz1HAjW8AXEpT9aDLba1+kyoWUjlsdWVcoNDjl6L/VcpHaha
         Thp6nkjgJ+mfWlTP5TFRTfoXdgqC1fXn1ZUzq1Hg5XyHSR28VV/1UCn3wPrbybH4BfBx
         m6eho8KyEq98NeGoT6+k7XsR4nUc2A3bzQGSwPAiVlKPgwDjG6KYa7u8cr+pxwm0wYg1
         rmuhQKvaEFo9I6v/zq+fFIMtMN6hE/KJIBGaTcNvK1qHH+zboT7nvpC2oGVNrF6oXirq
         XZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rmhla3csj1QnIc/ifXl6LMJ1rocErgRj/cyob/iBjRY=;
        b=IST2lb0qUrQM1EzPvUPAjR3nP189ldoASmA7/rrjTdg8Ntp2QeFBHjPcLtCcF+MBT7
         6E9nXlbPKT92kPmNP8WYlbdnabcCteJJD05JgVvhEfaJJBHkwM1J28Gv+fkeJAsl5vi+
         eqmrH2+5DGDf8N4CHJjlzs+km4jMY/jV+NsONLI8DOL+ves+0A//nbaOmCOlZZ8DoTh/
         fU6GcoRegizBkJMGSDiMkBhC6loh/XSLK7vPyx1zuQkL/pZihw1tuqn1LN4ktBzCwKI3
         BmXkNZPjj75Fh05mvlaFIkqXzslvnX1Ym7y1B9Kd6KVYR1tz+CmxacQL4jt00G0JjDmg
         IuKA==
X-Gm-Message-State: ACrzQf3W7gVg6TvEOKYcMNrCEVIZz+hHHWfYdCUCGiy1eh5iqpZ0yzcq
        6oGkkdndiBYSSHGl5tD4cxo=
X-Google-Smtp-Source: AMsMyM4v4NQotkR2gmANHCsNDoa7jzDVolh+sbNdYjpXceN0sDDUAsBtpMDio7vJgoKscGmVJ9lQAw==
X-Received: by 2002:a5d:6185:0:b0:236:776f:2bed with SMTP id j5-20020a5d6185000000b00236776f2bedmr30678035wru.535.1667821262895;
        Mon, 07 Nov 2022 03:41:02 -0800 (PST)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id t13-20020a5d460d000000b002366f9bd717sm8718298wrq.45.2022.11.07.03.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 03:41:02 -0800 (PST)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH] arm64: dts: qcom: msm8996pro-xiaomi-scorpio: Remove DSI PHY clocks from MMCC
Date:   Mon,  7 Nov 2022 14:40:17 +0300
Message-Id: <20221107114016.356112-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

Having DSI PHY clocks listed in the MMCC node while MDSS is disabled makes
it defer probe indefinitely, resulting in simplefb and other blocks that
depend on its clocks to defer probe as well. Remove DSI PHY clocks from
MMCC to let it probe with MDSS disabled.

Fixes: 48aa636285ad ("arm64: dts: qcom: msm8996: add clocks to the MMCC device node")
Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../boot/dts/qcom/msm8996pro-xiaomi-scorpio.dts     | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dts b/arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dts
index 7bf6ad1a214b..c68c2dadd7b4 100644
--- a/arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-scorpio.dts
@@ -113,6 +113,19 @@ &mdss {
 	status = "disabled";
 };
 
+&mmcc {
+	/*
+	 * Remove non-essential DSI PHY clocks to allow MMCC to probe
+	 * with MDSS disabled.
+	 */
+	clocks = <&xo_board>,
+		 <&gcc GCC_MMSS_NOC_CFG_AHB_CLK>,
+		 <&gcc GPLL0>;
+	clock-names = "xo",
+		      "gcc_mmss_noc_cfg_ahb_clk",
+		      "gpll0";
+};
+
 &mss_pil {
 	firmware-name = "qcom/msm8996/scorpio/mba.mbn",
 			"qcom/msm8996/scorpio/modem.mbn";
-- 
2.38.1

