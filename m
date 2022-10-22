Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45E6608D01
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiJVLw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiJVLvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:51:55 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2561012AEC;
        Sat, 22 Oct 2022 04:50:53 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so5366230pjl.0;
        Sat, 22 Oct 2022 04:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gf6dQ9LAjbku9tNlXYs6K70y6uNvlcEqkF4aaiHp/zU=;
        b=E4aU0a07cwaHSsoed6bDFBy4lpC14k12UJKZDHn0WaJSzmsuK4OC57Uw++peddyAaT
         +ousCegB9LKUF9V+5fZ3aHQSpVDIOKlFEX/iAo8ZG6/sO4fqBW4Wcn503EtjHs5hly9k
         B7nhHt0inDgpVQqy1Zp9JtPaAFV9GM1By4hzyBsivJz0/9DNR8j4Mw6x8h+e3C38pQDH
         UtdVk+0AhVsn+kj3Pn2HbBg0yMzxK8u/9sVNaimy+QjSx/SfpQrWpBdbMbGHFrkGh6md
         k99oi+srIQRTDKACAPKhsmUAOXB0JcxERn55nOuQeYMsaCb8BKCLbSeXGCe9o0hj9TW2
         qa0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gf6dQ9LAjbku9tNlXYs6K70y6uNvlcEqkF4aaiHp/zU=;
        b=vXW8qfDLEzR3Phki/rom3Sy6zWCSyaZLIhorn7XK02ugzOl67BfvtB8X8DCHjbHvbS
         Fe/xW8QWiTOBMb2VcQsvUXWYuBW+G9gWlX4TVNIR/a7dqzgPbkXkUQsmvS9EqAuTJJmO
         uOzmHS0aLH19pyz0o0IsxcpmmsSx9W95nW5YKruwRWZAA6S+KJOedPyJEsF4LDvO7B5z
         I8PqSqITJOqNi+ww5GhAz5kaefh+ZYntSfrxrWRno7457GvQrOIr2YXzpZlv/KvDvAoG
         HRmTre24k1bMKZaS9jRPv6xa5xE0YbGbuIYUBLjWWHB4JMJOqgjuaKkU2mDVDRtVxX9i
         ZVtg==
X-Gm-Message-State: ACrzQf3E8xu64N4v4vWbEY4gyyqLCy5NBo2o1Q0wIFB3waSQjSsurfUC
        yJWnxpjwedl7CgohpLIMVU6hD5Wuskgq+g==
X-Google-Smtp-Source: AMsMyM5AmJOLPRTfil+lrVbmN2PHNf0wLvVe29ngBB+ANhMjqQEj59AKauVj1+TUcH4vXRO/S7naMg==
X-Received: by 2002:a17:902:bd98:b0:182:631b:7dd5 with SMTP id q24-20020a170902bd9800b00182631b7dd5mr23531125pls.165.1666439452757;
        Sat, 22 Oct 2022 04:50:52 -0700 (PDT)
Received: from [172.30.1.63] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id x11-20020a17090a6b4b00b0020ddea12227sm1223171pjl.55.2022.10.22.04.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 04:50:52 -0700 (PDT)
Message-ID: <0e0eff12-d8ea-72e9-d135-4259dda9a750@gmail.com>
Date:   Sat, 22 Oct 2022 20:50:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 11/21] clk: remove s3c24xx driver
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-11-arnd@kernel.org>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20221021203329.4143397-11-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 22. 10. 22. 05:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The s3c24xx platform is gone, so the clk driver can be removed as
> well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  MAINTAINERS                               |   1 -
>  drivers/clk/samsung/Kconfig               |  32 --
>  drivers/clk/samsung/Makefile              |   4 -
>  drivers/clk/samsung/clk-s3c2410-dclk.c    | 440 ---------------------
>  drivers/clk/samsung/clk-s3c2410.c         | 446 ----------------------
>  drivers/clk/samsung/clk-s3c2412.c         | 254 ------------
>  drivers/clk/samsung/clk-s3c2443.c         | 438 ---------------------
>  include/linux/platform_data/clk-s3c2410.h |  19 -
>  8 files changed, 1634 deletions(-)
>  delete mode 100644 drivers/clk/samsung/clk-s3c2410-dclk.c
>  delete mode 100644 drivers/clk/samsung/clk-s3c2410.c
>  delete mode 100644 drivers/clk/samsung/clk-s3c2412.c
>  delete mode 100644 drivers/clk/samsung/clk-s3c2443.c
>  delete mode 100644 include/linux/platform_data/clk-s3c2410.h

(snip)

I think that it should remove the pll code related to s3c24xx as following:

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index fe383471c5f0..0daea2aadce4 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -1061,48 +1061,6 @@ static void samsung_s3c2410_upll_disable(struct clk_hw *hw)
 	samsung_s3c2410_pll_enable(hw, 7, false);
 }
 
-static const struct clk_ops samsung_s3c2410_mpll_clk_min_ops = {
-	.recalc_rate = samsung_s3c2410_pll_recalc_rate,
-	.enable = samsung_s3c2410_mpll_enable,
-	.disable = samsung_s3c2410_mpll_disable,
-};
-
-static const struct clk_ops samsung_s3c2410_upll_clk_min_ops = {
-	.recalc_rate = samsung_s3c2410_pll_recalc_rate,
-	.enable = samsung_s3c2410_upll_enable,
-	.disable = samsung_s3c2410_upll_disable,
-};
-
-static const struct clk_ops samsung_s3c2440_mpll_clk_min_ops = {
-	.recalc_rate = samsung_s3c2440_mpll_recalc_rate,
-	.enable = samsung_s3c2410_mpll_enable,
-	.disable = samsung_s3c2410_mpll_disable,
-};
-
-static const struct clk_ops samsung_s3c2410_mpll_clk_ops = {
-	.recalc_rate = samsung_s3c2410_pll_recalc_rate,
-	.enable = samsung_s3c2410_mpll_enable,
-	.disable = samsung_s3c2410_mpll_disable,
-	.round_rate = samsung_pll_round_rate,
-	.set_rate = samsung_s3c2410_pll_set_rate,
-};
-
-static const struct clk_ops samsung_s3c2410_upll_clk_ops = {
-	.recalc_rate = samsung_s3c2410_pll_recalc_rate,
-	.enable = samsung_s3c2410_upll_enable,
-	.disable = samsung_s3c2410_upll_disable,
-	.round_rate = samsung_pll_round_rate,
-	.set_rate = samsung_s3c2410_pll_set_rate,
-};
-
-static const struct clk_ops samsung_s3c2440_mpll_clk_ops = {
-	.recalc_rate = samsung_s3c2440_mpll_recalc_rate,
-	.enable = samsung_s3c2410_mpll_enable,
-	.disable = samsung_s3c2410_mpll_disable,
-	.round_rate = samsung_pll_round_rate,
-	.set_rate = samsung_s3c2410_pll_set_rate,
-};
-
 /*
  * PLL2550x Clock Type
  */
@@ -1530,24 +1488,6 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 		else
 			init.ops = &samsung_pll46xx_clk_ops;
 		break;
-	case pll_s3c2410_mpll:
-		if (!pll->rate_table)
-			init.ops = &samsung_s3c2410_mpll_clk_min_ops;
-		else
-			init.ops = &samsung_s3c2410_mpll_clk_ops;
-		break;
-	case pll_s3c2410_upll:
-		if (!pll->rate_table)
-			init.ops = &samsung_s3c2410_upll_clk_min_ops;
-		else
-			init.ops = &samsung_s3c2410_upll_clk_ops;
-		break;
-	case pll_s3c2440_mpll:
-		if (!pll->rate_table)
-			init.ops = &samsung_s3c2440_mpll_clk_min_ops;
-		else
-			init.ops = &samsung_s3c2440_mpll_clk_ops;
-		break;
 	case pll_2550x:
 		init.ops = &samsung_pll2550x_clk_ops;
 		break;
diff --git a/drivers/clk/samsung/clk-pll.h b/drivers/clk/samsung/clk-pll.h
index a9892c2d1f57..5d5a58d40e7e 100644
--- a/drivers/clk/samsung/clk-pll.h
+++ b/drivers/clk/samsung/clk-pll.h
@@ -25,9 +25,6 @@ enum samsung_pll_type {
 	pll_6552,
 	pll_6552_s3c2416,
 	pll_6553,
-	pll_s3c2410_mpll,
-	pll_s3c2410_upll,
-	pll_s3c2440_mpll,
 	pll_2550x,
 	pll_2550xx,
 	pll_2650x,
@@ -56,24 +53,6 @@ enum samsung_pll_type {
 		.sdiv	=	(_s),				\
 	}
 
-#define PLL_S3C2410_MPLL_RATE(_fin, _rate, _m, _p, _s)		\
-	{							\
-		.rate	=	PLL_VALID_RATE(_fin, _rate,	\
-				_m + 8, _p + 2, _s, 0, 16),	\
-		.mdiv	=	(_m),				\
-		.pdiv	=	(_p),				\
-		.sdiv	=	(_s),				\
-	}
-
-#define PLL_S3C2440_MPLL_RATE(_fin, _rate, _m, _p, _s)		\
-	{							\
-		.rate	=	PLL_VALID_RATE(_fin, _rate,	\
-				2 * (_m + 8), _p + 2, _s, 0, 16), \
-		.mdiv	=	(_m),				\
-		.pdiv	=	(_p),				\
-		.sdiv	=	(_s),				\
-	}
-
 #define PLL_36XX_RATE(_fin, _rate, _m, _p, _s, _k)		\
 	{							\
 		.rate	=	PLL_VALID_RATE(_fin, _rate,	\


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

