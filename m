Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5D869017F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 08:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjBIHp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 02:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjBIHpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:45:24 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EAB1BFD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 23:45:22 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so3213154wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 23:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9TkylMnx0XQBQew9nKf+BKJgpUdEs2B8pdYOfjTDzfQ=;
        b=mJGpNRd/F4LQdfBYXiJpWkXwj8GEt0IjRpQBjZOnO6dLb5qFtcfi83WQg2Wa5Whl85
         dDKrubK9L1NpoG9AO6o+buLCb7grKDImJPolYmnr/gX1Fgf71D0P2sYwfumBUECYDi7p
         FH2blYdNjoGH/bstRynqbsF/ZFeSnPLQXDOXRhDNDUFckjgACFk/adDbUeH4A1bu1tl1
         tRPY0oiLluOn3zF8H8izL6h9uUo7TdiO/0wrzovumlXjIsTAcxyKyhPcewzApejP0R/C
         LrsfGESibzYe8+5zaMxm+/S2gOeieI+fP3XM6OC8lG5bdNKtuLdd6sRLueBYQwng1BYh
         9x0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9TkylMnx0XQBQew9nKf+BKJgpUdEs2B8pdYOfjTDzfQ=;
        b=ksoBqH1saGrdt0Eh8lpuxl07SCm8mqWrgWTDUVRMUKGvYxP9S7X/BRjCVuLkrMg4CA
         7FyuveZR+LG0r0Tc6CZrLU9djSqxYYb28dLcf5Ow7/GC/d43rX5D4GT0QwQ9jGz8fGaB
         IqTdNRDpxV/Hus6B6PAydrHLx30tF1ooAXyomZOmw11j6VavQcC91hgMuLKAaD1d31rV
         4kL70IZaw2FuLuBmYmOi6GMpP2kN8SIQ3KJUqJyfkwPDoHfl2HSiI7VHcZKWC//FwREL
         yv1npXN6E47VPnM481hNu2BaJ2C0oGw6LtzD1Latyff6FSEjaMwfisdH5FaqLy5fAGzq
         AWnw==
X-Gm-Message-State: AO0yUKUTwrXJXpIEYTGX5idfd49eT/pUEbzC+Ei8uAIie1VEIN3c5o8v
        pgg2P6F5lmA9cPtR9s3F4p5EZA==
X-Google-Smtp-Source: AK7set89HhsrBhTriSqbmLeEi21fPXSAahsF5YD1NGqBEG7pnypTG60x39SPE6byhfuwbIloSUNjtw==
X-Received: by 2002:a05:600c:491c:b0:3dc:1687:9ba2 with SMTP id f28-20020a05600c491c00b003dc16879ba2mr8734012wmp.35.1675928721190;
        Wed, 08 Feb 2023 23:45:21 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c4e8800b003da28dfdedcsm1115472wmq.5.2023.02.08.23.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 23:45:19 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 1/2] pinctrl: qcom: Add support for i2c specific pull feature
Date:   Thu,  9 Feb 2023 09:45:09 +0200
Message-Id: <20230209074510.4153294-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the new i2c_pull property introduced for SM8550 setting
a I2C specific pull mode on I2C able pins. Add the bit to the SM8550
specific driver while at it.

Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

The v3 of this specific patch is here:
https://lore.kernel.org/all/20230208081836.984673-1-abel.vesa@linaro.org/

Changes since v3:
 * changed the condition in msm_config_group_set to "arg == MSM_I2C_STRONG_PULL_UP"
   as Bjorn suggested

Changes since v2:
 * This time, this patch is sent separate w.r.t. SM8550 pinctrl driver
 * The qcom,i2c-pull is dropped, bias-pull-up with value is used instead
 * Default value for i2c pull up is 2.2kOhms and since SM8550 is the
   first one to use it, we hard code it for now
 * changed the authorship as the implementation looks entirely different now

 drivers/pinctrl/qcom/pinctrl-msm.c    | 7 +++++++
 drivers/pinctrl/qcom/pinctrl-msm.h    | 1 +
 drivers/pinctrl/qcom/pinctrl-sm8550.c | 1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 5142c363480a..a69f93e74435 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -310,6 +310,8 @@ static int msm_config_reg(struct msm_pinctrl *pctrl,
 	case PIN_CONFIG_BIAS_PULL_UP:
 		*bit = g->pull_bit;
 		*mask = 3;
+		if (g->i2c_pull_bit)
+			*mask |= BIT(g->i2c_pull_bit) >> *bit;
 		break;
 	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
 		*bit = g->od_bit;
@@ -336,6 +338,7 @@ static int msm_config_reg(struct msm_pinctrl *pctrl,
 #define MSM_KEEPER		2
 #define MSM_PULL_UP_NO_KEEPER	2
 #define MSM_PULL_UP		3
+#define MSM_I2C_STRONG_PULL_UP	2200
 
 static unsigned msm_regval_to_drive(u32 val)
 {
@@ -387,6 +390,8 @@ static int msm_config_group_get(struct pinctrl_dev *pctldev,
 	case PIN_CONFIG_BIAS_PULL_UP:
 		if (pctrl->soc->pull_no_keeper)
 			arg = arg == MSM_PULL_UP_NO_KEEPER;
+		else if (arg & BIT(g->i2c_pull_bit))
+			arg = MSM_I2C_STRONG_PULL_UP;
 		else
 			arg = arg == MSM_PULL_UP;
 		if (!arg)
@@ -467,6 +472,8 @@ static int msm_config_group_set(struct pinctrl_dev *pctldev,
 		case PIN_CONFIG_BIAS_PULL_UP:
 			if (pctrl->soc->pull_no_keeper)
 				arg = MSM_PULL_UP_NO_KEEPER;
+			else if (g->i2c_pull_bit && arg == MSM_I2C_STRONG_PULL_UP)
+				arg = BIT(g->i2c_pull_bit) | MSM_PULL_UP;
 			else
 				arg = MSM_PULL_UP;
 			break;
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
index 05a1209bf9ae..985eceda2517 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.h
+++ b/drivers/pinctrl/qcom/pinctrl-msm.h
@@ -80,6 +80,7 @@ struct msm_pingroup {
 
 	unsigned pull_bit:5;
 	unsigned drv_bit:5;
+	unsigned i2c_pull_bit:5;
 
 	unsigned od_bit:5;
 	unsigned egpio_enable:5;
diff --git a/drivers/pinctrl/qcom/pinctrl-sm8550.c b/drivers/pinctrl/qcom/pinctrl-sm8550.c
index 0b7db7d4054a..c9d038098f2c 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm8550.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm8550.c
@@ -47,6 +47,7 @@
 		.mux_bit = 2,			\
 		.pull_bit = 0,			\
 		.drv_bit = 6,			\
+		.i2c_pull_bit = 13,		\
 		.egpio_enable = 12,		\
 		.egpio_present = 11,		\
 		.oe_bit = 9,			\
-- 
2.34.1

