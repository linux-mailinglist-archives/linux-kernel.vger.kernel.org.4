Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F1463125B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 04:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiKTDDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 22:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiKTDD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 22:03:28 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E609B4071;
        Sat, 19 Nov 2022 19:03:26 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id a27so5500198qtw.10;
        Sat, 19 Nov 2022 19:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5y5SYwuSDLQh4zh9qXh26loAgAEz0UdAAjWmFJDPZA=;
        b=k6Ujwuh+Eqstr/7J8LWSr3KYFnxzJsemkS3ajM5CSU3VxSzzS4Aw24FNkMRO9nSmf4
         RPmJrAlvHGn9aYQO+CKp68DaoO3FvPfJrsY2q/MEe358X93du+icRDr4p26hUL0An/nn
         6xEkZEWTKYf2f1NbGc3G+yQivwPJ7XFZiV2CnnOYG8oi0/OMxVeruegfxnOK+ORP1nCm
         /s/HjPHrV617AGFNumYjcb/HLRIW3PdX8H+YIv+upSUYqyDKgWzOAGnzlOj28MqTFyfV
         9Pb46tQ55VatN1slAnb1IFumY2a9cXaZD/6wpeM9Ajwy1ETkf43yAwmBws4MOEbrAYXw
         vZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5y5SYwuSDLQh4zh9qXh26loAgAEz0UdAAjWmFJDPZA=;
        b=UryWTNrKZNmMmvA5BUkIRYMimcpIyi7T3FQo6DZwH0GiLdgyXDdlEYWWRAHjsO0+qs
         8HTcstmq7oAsWB5vgxBXupSdLeThOuHOpLRO3VOYFPWC2uUxH/QrZZksF2/Zl+vtB9Uc
         oJrGCgU2Jr5RPQmrTHOJEMo/v2vEqY4ey0M8VeOiDOBkBcu8+6r3eNczGIfBd5HAFHb5
         Ikbm6LHEp95v6r70IEp4Fj2OB3H9p0hR5BHy3J3EG0xtYPn0HRcoQgv69J4YntBCAvZf
         TqD9tOYAl+j7xGhR/emzKJPMYSPSnG8CZr0BJKp0BWuZc0X6qs8gifI8bqAYIqrX8KqN
         5m/w==
X-Gm-Message-State: ANoB5pmA0OQVx/krfQq3A2xYcgpSXAiDQ2cTCZzZtojCe/Y4nCO3GyN1
        CDfGEtP/sgIWEdo5Dh+EHrw=
X-Google-Smtp-Source: AA0mqf6VkNKkZa0DC3muw2lCH7lnwgg1OK8EfeXvZUQnkJjaa1USibl4Bq84PwJN/2yegWq1KgZqfw==
X-Received: by 2002:ac8:5e95:0:b0:3a5:50c6:bdc6 with SMTP id r21-20020ac85e95000000b003a550c6bdc6mr12631443qtx.370.1668913405609;
        Sat, 19 Nov 2022 19:03:25 -0800 (PST)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id u8-20020ac80508000000b0039cc47752casm4522423qtg.77.2022.11.19.19.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 19:03:25 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     Liam Beguin <liambeguin@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] clk: lmk04832: drop unnecessary semicolons
Date:   Sat, 19 Nov 2022 22:02:55 -0500
Message-Id: <20221120030257.531153-3-liambeguin@gmail.com>
X-Mailer: git-send-email 2.37.1.223.g6a475b71f8c4
In-Reply-To: <20221120030257.531153-1-liambeguin@gmail.com>
References: <20221120030257.531153-1-liambeguin@gmail.com>
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

Semicolons on the closing brace of a function definition are
unnecessary, remove them.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 drivers/clk/clk-lmk04832.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/clk-lmk04832.c b/drivers/clk/clk-lmk04832.c
index 9d18fd23bea0..3a5961fe604d 100644
--- a/drivers/clk/clk-lmk04832.c
+++ b/drivers/clk/clk-lmk04832.c
@@ -282,7 +282,7 @@ static bool lmk04832_regmap_rd_regs(struct device *dev, unsigned int reg)
 	default:
 		return false;
 	};
-};
+}
 
 static bool lmk04832_regmap_wr_regs(struct device *dev, unsigned int reg)
 {
@@ -305,7 +305,7 @@ static bool lmk04832_regmap_wr_regs(struct device *dev, unsigned int reg)
 	default:
 		return false;
 	};
-};
+}
 
 static const struct regmap_config regmap_config = {
 	.name = "lmk04832",
@@ -403,7 +403,7 @@ static unsigned long lmk04832_vco_recalc_rate(struct clk_hw *hw,
 				       pll2_misc)) * pll2_n * pll2_p[p] / pll2_r;
 
 	return vco_rate;
-};
+}
 
 /**
  * lmk04832_check_vco_ranges - Check requested VCO frequency against VCO ranges
@@ -509,7 +509,7 @@ static long lmk04832_vco_round_rate(struct clk_hw *hw, unsigned long rate,
 		return -EINVAL;
 
 	return vco_rate;
-};
+}
 
 static int lmk04832_vco_set_rate(struct clk_hw *hw, unsigned long rate,
 				 unsigned long prate)
@@ -568,7 +568,7 @@ static int lmk04832_vco_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	return regmap_write(lmk->regmap, LMK04832_REG_PLL2_N_2,
 			    FIELD_GET(0x0000ff, n));
-};
+}
 
 static const struct clk_ops lmk04832_vco_ops = {
 	.is_enabled = lmk04832_vco_is_enabled,
@@ -1063,7 +1063,7 @@ static unsigned long lmk04832_dclk_recalc_rate(struct clk_hw *hw,
 	rate = DIV_ROUND_CLOSEST(prate, dclk_div);
 
 	return rate;
-};
+}
 
 static long lmk04832_dclk_round_rate(struct clk_hw *hw, unsigned long rate,
 				     unsigned long *prate)
@@ -1085,7 +1085,7 @@ static long lmk04832_dclk_round_rate(struct clk_hw *hw, unsigned long rate,
 		return -EINVAL;
 
 	return dclk_rate;
-};
+}
 
 static int lmk04832_dclk_set_rate(struct clk_hw *hw, unsigned long rate,
 				  unsigned long prate)
@@ -1147,7 +1147,7 @@ static int lmk04832_dclk_set_rate(struct clk_hw *hw, unsigned long rate,
 		dev_err(lmk->dev, "SYNC sequence failed\n");
 
 	return ret;
-};
+}
 
 static const struct clk_ops lmk04832_dclk_ops = {
 	.is_enabled = lmk04832_dclk_is_enabled,
@@ -1551,6 +1551,7 @@ static void lmk04832_remove(struct spi_device *spi)
 	clk_disable_unprepare(lmk->oscin);
 	of_clk_del_provider(spi->dev.of_node);
 }
+
 static const struct spi_device_id lmk04832_id[] = {
 	{ "lmk04832", LMK04832 },
 	{}
-- 
2.37.1.223.g6a475b71f8c4

