Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9891765FFBE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 12:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbjAFLpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 06:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbjAFLot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 06:44:49 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99157289C;
        Fri,  6 Jan 2023 03:44:39 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id y25so1605769lfa.9;
        Fri, 06 Jan 2023 03:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5irNV1hNyR0Do6fsEmjA5PW9Al1mS3pqAQZVCiHC7Rg=;
        b=TY3jSlP4Pb+SHN0F4iGFOHzKa/rtPa7uKe6GVtWuHdZ0Awd3F6DWQ2nrrDaeEt2833
         dzQA8KE30KGlCl3nQsqrT1m7N9bVs6i3aJcNvLmM8JJaudQpMkY/UjSsuun8XIOXPvJA
         QYEKRoJpy6DVxFeg1ra4tijDp9D5lis3TFdl9W/y8dhuqdU3Gp6lPppCd2PlZATRxTby
         45CD/Ia3AlYhcuWntycOWEHkJFkoXYU/bM7YXinoeBwHj9KNV5x3O3RXU6CJzBCn43fQ
         IZD7em0dmop8LXIfPCjTCozjVJjJm4/NkQrNrRwEwk7WQAL66dfGBagxyJSx7GyZOe7t
         OGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5irNV1hNyR0Do6fsEmjA5PW9Al1mS3pqAQZVCiHC7Rg=;
        b=yLuyJFfoVnbDVdkmh0v5MazJ7ohHYqvMRdbYdWVqHJ0uFGARPZQQ8OkulJNvoqVBxa
         n09bJ3OlYZPrlhg5iBjr8S2o7hompCWGAOQ2Fu01XnVQsuPAZG69o/uwPLUOJGPHE8Fh
         Br0a9jEmwOaLVqAZllEI90y2FsHQ6efnna0GBm9rsQZAuCZITqBcQnC7HhTXmofGpezi
         p1ClvxLapTpfp7huDQF6YOZP4dlqWOBUch7ikX8n9Hz/KvSCZc+MhsW53KSbGHwGB9qJ
         fR31orVF9dopxaGIO9A6ZjaqEMkUOAgwjKpU1FjbyLHDM8opJAiLLICXwtVCUEvQQJVh
         4/QQ==
X-Gm-Message-State: AFqh2kqx5jp20fbHIidmmEdHCEhvm06KVis2juBRB9/2jTDvjvSkcDLu
        IOevQ60Db0LTL2zdXM40LMpD04Pn9hElPw==
X-Google-Smtp-Source: AMrXdXu+k8ipnAm8OrpKH3hq3Uu5L09QNj4BYxsINvOq7F6JsETV/zir+opHAT+SdbgcxdJQ+97DIw==
X-Received: by 2002:ac2:4bd3:0:b0:4a4:68b7:d638 with SMTP id o19-20020ac24bd3000000b004a468b7d638mr14607443lfq.31.1673005477945;
        Fri, 06 Jan 2023 03:44:37 -0800 (PST)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id u3-20020ac258c3000000b004b5872a7003sm129747lfo.98.2023.01.06.03.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 03:44:37 -0800 (PST)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] pinctrl: qcom: msm8226: Add General Purpose clocks
Date:   Fri,  6 Jan 2023 13:44:02 +0200
Message-Id: <20230106114403.275865-3-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230106114403.275865-1-matti.lehtimaki@gmail.com>
References: <20230106114403.275865-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Luca Weiss <luca@z3ntu.xyz>

Add support for the general purpose clocks that are found on MSM8226.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Co-developed-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 drivers/pinctrl/qcom/pinctrl-msm8226.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm8226.c b/drivers/pinctrl/qcom/pinctrl-msm8226.c
index fca0645e8008..0f05725e0a21 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm8226.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm8226.c
@@ -362,6 +362,8 @@ enum msm8226_functions {
 	MSM_MUX_cam_mclk0,
 	MSM_MUX_cam_mclk1,
 	MSM_MUX_cci_i2c0,
+	MSM_MUX_gp0_clk,
+	MSM_MUX_gp1_clk,
 	MSM_MUX_gpio,
 	MSM_MUX_sdc3,
 	MSM_MUX_wlan,
@@ -447,6 +449,9 @@ static const char * const cci_i2c0_groups[] = { "gpio29", "gpio30" };
 static const char * const cam_mclk0_groups[] = { "gpio26" };
 static const char * const cam_mclk1_groups[] = { "gpio27" };
 
+static const char * const gp0_clk_groups[] = { "gpio33" };
+static const char * const gp1_clk_groups[] = { "gpio34" };
+
 static const char * const sdc3_groups[] = {
 	"gpio39", "gpio40", "gpio41", "gpio42", "gpio43", "gpio44"
 };
@@ -480,6 +485,8 @@ static const struct msm_function msm8226_functions[] = {
 	FUNCTION(cam_mclk0),
 	FUNCTION(cam_mclk1),
 	FUNCTION(cci_i2c0),
+	FUNCTION(gp0_clk),
+	FUNCTION(gp1_clk),
 	FUNCTION(gpio),
 	FUNCTION(sdc3),
 	FUNCTION(wlan),
@@ -519,8 +526,8 @@ static const struct msm_pingroup msm8226_groups[] = {
 	PINGROUP(30,  cci_i2c0, NA, NA, NA, NA, NA, NA),
 	PINGROUP(31,  NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(32,  NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(33,  NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(34,  NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(33,  NA, NA, gp0_clk, NA, NA, NA, NA),
+	PINGROUP(34,  NA, NA, gp1_clk, NA, NA, NA, NA),
 	PINGROUP(35,  NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(36,  NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(37,  NA, NA, NA, NA, NA, NA, NA),
-- 
2.34.1

