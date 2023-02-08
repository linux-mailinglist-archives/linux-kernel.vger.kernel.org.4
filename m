Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5011368E9B6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 09:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjBHIT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 03:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjBHIT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 03:19:56 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979D4B46A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 00:19:54 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id az4-20020a05600c600400b003dff767a1f1so836023wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 00:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0l1LQIgPjZSYHp6ZlYWpsxbiEcCjDEndwPKdoxGHr50=;
        b=KcFcxyTfkRuWf/DmKpWOjhrVHMIKVfJzEKMvB9JXDx+7IGP7mqqRJaWpGSwue++j6w
         Wnqx/yGRjSFwwrGsQ5d5E6xxJslmW2IaNKwDR/L2HXdvnQjFiuaxzo07jZcOrK19rq+J
         /dUAAp58FsoZeRyEJMGlgss3RlK0w7JiIyiXwiXTOirn2gR70sRiobITRLQNVqLJdxVr
         AEqRTVM26mU7xLCks+g9sDtLQMwMRtvn0d4XW0enzGD9mPj8u7DjnO+FWQpAh73nOrfj
         L/DTCMeyI6Ki+iQ3IMHCz25Um8GN3/NS6zsne9DZmyZzA6+VFLegXpJ1XeLMj8BdHoSU
         yPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0l1LQIgPjZSYHp6ZlYWpsxbiEcCjDEndwPKdoxGHr50=;
        b=nc+3WtNlp5kiKagddKWHImngCyLD4MMdG1oTR7HWJ5SSBReV7585kYkDf4iYK7/XYT
         iK0QNW/nOR4CUCo0l4cHOI/9zvYfaxLsnOWeZWANpqOZxVyDnZIWU7qYlEMB4b5Vgs4F
         ge57NsR+3wUb9DMOkBEBpFJBW3UBbzza8uXudLxt+N/vZLrPHWxc1MQypz3Q0Fqe3g7J
         eKNOAhcd45p2e37RP+HrKUvbAdsh388EA2xg/7g90b4fu+1SNuGr80r7dmBz5oC1g3dW
         a2jJ9caw2redLAdOFf1SxjApUhXwju3Y8nBx76H84BSs+r3xTnN+g/21yvS0sF10i/of
         PSbg==
X-Gm-Message-State: AO0yUKXJ7IsnxBxVskQWWHJv5GFDUWBKsyvkCMSMROvbpjf0DfZ19Zlp
        IndEeV6ehwfVUsLGiUB/RqylZ/u9yeWql3Da
X-Google-Smtp-Source: AK7set+9FyNwI+o7IDokP38uw7oFjz4TgpYpE07R3Wj1J4s0h8bXD/vtlJmiTSqKeDaDhxrI1MYcGg==
X-Received: by 2002:a05:600c:2eca:b0:3e0:ffd4:bfab with SMTP id q10-20020a05600c2eca00b003e0ffd4bfabmr1913924wmn.13.1675844393194;
        Wed, 08 Feb 2023 00:19:53 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id a3-20020a05600c224300b003db01178b62sm1142452wmm.40.2023.02.08.00.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 00:19:52 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 1/2] pinctrl: qcom: Add support for i2c specific pull feature
Date:   Wed,  8 Feb 2023 10:18:35 +0200
Message-Id: <20230208081836.984673-1-abel.vesa@linaro.org>
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

The v2 of this specific patch is here:
https://lore.kernel.org/all/20221123152001.694546-4-abel.vesa@linaro.org/

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
index 5142c363480a..510c964dd0f5 100644
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
+			else if (g->i2c_pull_bit && arg > 1)
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

