Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03F062F1C2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242082AbiKRJrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241704AbiKRJqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:46:17 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E56F8FF9C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 01:45:59 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m14so4079712pji.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 01:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+LunitHsdCgLLW1VoFHmBgMOIE3cNaCsaWNVFErOTmY=;
        b=aQ4KZtAX658NAj/o8lo0KSjpGSr48QbLFE5VvnNZcruKE8p1gd81gHOn9rbDpJLNmf
         ltFaqOksTl+Jtbjl54zaqwKFX5ew8Hh79wOdf58AucPJ2Q8N/3S1GKsl7SSMFXZPW7jw
         Bcey4gsGGzFhGGkL+Qnb3FCUoYTgjRQmNdeA4DkEOgRoFLMXxtrVyam9eNR4wha4vB31
         dvdpmmVXAQrvNm1KW1rVG349g5/x5sdeYWNdCdPnA9nxYhX5S0FMY2sOFrllWRWDwEPU
         p3vs72lbPsEO9c3bDKRahZVnlDX3FULGalC761rKGuIDox/1BPu91yTKXgowXFM3FGtd
         pZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+LunitHsdCgLLW1VoFHmBgMOIE3cNaCsaWNVFErOTmY=;
        b=eX9RVeYFWTzR8UUxKKnCf1ElhrNO5uIB/Ho3m/vDzuNO4EEQLVIbpmdRK5n7gSIOyF
         fVD7sZcmTOKgjAdBkrDPRvqso6wO4FTuMThHfPD56g5gZqFO1shCcrO+Ea7V9KDbIfQh
         AmxYy8vI8MKd4mq/YFbGXUMp9/WOUe+aeZ4gxZ6qQCFhhAoXa/zvA9BV2LmpYslH2jyC
         dFncq4yZQXZQoBPiNsk7LlqOLhGN5N1ch/lbt8MF0cmEZj+sUzZdVVsob2aVaPJbG5/A
         rT69aG39FaesxSUUaq//b3q5mhOOtayRlAF/s7ZJuBRaAA0nD/0lK/+2LWeYnDrNrsOk
         NTVA==
X-Gm-Message-State: ANoB5pm56D+jATTlIXXC1O0XQnab1hCczuHFhh9kw9nEOfH0R9x6e0M+
        alFrMYQhvktxYcuwPtXJGewvKsaPRkVxbAKW0jjH+A==
X-Google-Smtp-Source: AA0mqf50Leg3BWtS7X/LE7CcS9rTrdq5lzWSZ23MXu2li1TfWer+1pbvPTS4gmVlfx71NlFowgeSu/E8hivvgR8I6oU=
X-Received: by 2002:a17:90a:7804:b0:211:2d90:321 with SMTP id
 w4-20020a17090a780400b002112d900321mr13061139pjk.84.1668764758536; Fri, 18
 Nov 2022 01:45:58 -0800 (PST)
MIME-Version: 1.0
References: <20221114230217.202634-1-dinguyen@kernel.org> <20221114230217.202634-5-dinguyen@kernel.org>
In-Reply-To: <20221114230217.202634-5-dinguyen@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Nov 2022 10:45:21 +0100
Message-ID: <CAPDyKFqmHhDwMXd2vcymSJ6mD9Dhxgc_D2Jc-0nJ6k7b9FkpHg@mail.gmail.com>
Subject: Re: [PATCHv9 5/6] clk: socfpga: remove the setting of clk-phase for sdmmc_clk
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     jh80.chung@samsung.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2022 at 00:02, Dinh Nguyen <dinguyen@kernel.org> wrote:
>
> Now that the SDMMC driver supports setting the clk-phase, we can remove
> the need to do it in the clock driver.
>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v9: no changes
> v8: no changes
> v7: add acked-by
> v6: remove unused clk_phase in clk-gate.c
> v5: new
> ---
>  drivers/clk/socfpga/clk-gate-a10.c | 68 ------------------------------
>  drivers/clk/socfpga/clk-gate.c     | 61 ---------------------------
>  drivers/clk/socfpga/clk.h          |  1 -
>  3 files changed, 130 deletions(-)
>
> diff --git a/drivers/clk/socfpga/clk-gate-a10.c b/drivers/clk/socfpga/clk-gate-a10.c
> index 738c53391e39..7cdf2f07c79b 100644
> --- a/drivers/clk/socfpga/clk-gate-a10.c
> +++ b/drivers/clk/socfpga/clk-gate-a10.c
> @@ -35,59 +35,7 @@ static unsigned long socfpga_gate_clk_recalc_rate(struct clk_hw *hwclk,
>         return parent_rate / div;
>  }
>
> -static int socfpga_clk_prepare(struct clk_hw *hwclk)
> -{
> -       struct socfpga_gate_clk *socfpgaclk = to_socfpga_gate_clk(hwclk);
> -       int i;
> -       u32 hs_timing;
> -       u32 clk_phase[2];
> -
> -       if (socfpgaclk->clk_phase[0] || socfpgaclk->clk_phase[1]) {
> -               for (i = 0; i < ARRAY_SIZE(clk_phase); i++) {
> -                       switch (socfpgaclk->clk_phase[i]) {
> -                       case 0:
> -                               clk_phase[i] = 0;
> -                               break;
> -                       case 45:
> -                               clk_phase[i] = 1;
> -                               break;
> -                       case 90:
> -                               clk_phase[i] = 2;
> -                               break;
> -                       case 135:
> -                               clk_phase[i] = 3;
> -                               break;
> -                       case 180:
> -                               clk_phase[i] = 4;
> -                               break;
> -                       case 225:
> -                               clk_phase[i] = 5;
> -                               break;
> -                       case 270:
> -                               clk_phase[i] = 6;
> -                               break;
> -                       case 315:
> -                               clk_phase[i] = 7;
> -                               break;
> -                       default:
> -                               clk_phase[i] = 0;
> -                               break;
> -                       }
> -               }
> -
> -               hs_timing = SYSMGR_SDMMC_CTRL_SET_AS10(clk_phase[0], clk_phase[1]);
> -               if (!IS_ERR(socfpgaclk->sys_mgr_base_addr))
> -                       regmap_write(socfpgaclk->sys_mgr_base_addr,
> -                                    SYSMGR_SDMMCGRP_CTRL_OFFSET, hs_timing);
> -               else
> -                       pr_err("%s: cannot set clk_phase because sys_mgr_base_addr is not available!\n",
> -                                       __func__);
> -       }
> -       return 0;
> -}
> -
>  static struct clk_ops gateclk_ops = {
> -       .prepare = socfpga_clk_prepare,
>         .recalc_rate = socfpga_gate_clk_recalc_rate,
>  };
>
> @@ -96,7 +44,6 @@ static void __init __socfpga_gate_init(struct device_node *node,
>  {
>         u32 clk_gate[2];
>         u32 div_reg[3];
> -       u32 clk_phase[2];
>         u32 fixed_div;
>         struct clk_hw *hw_clk;
>         struct socfpga_gate_clk *socfpga_clk;
> @@ -136,21 +83,6 @@ static void __init __socfpga_gate_init(struct device_node *node,
>                 socfpga_clk->div_reg = NULL;
>         }
>
> -       rc = of_property_read_u32_array(node, "clk-phase", clk_phase, 2);
> -       if (!rc) {
> -               socfpga_clk->clk_phase[0] = clk_phase[0];
> -               socfpga_clk->clk_phase[1] = clk_phase[1];
> -
> -               socfpga_clk->sys_mgr_base_addr =
> -                       syscon_regmap_lookup_by_compatible("altr,sys-mgr");
> -               if (IS_ERR(socfpga_clk->sys_mgr_base_addr)) {
> -                       pr_err("%s: failed to find altr,sys-mgr regmap!\n",
> -                                       __func__);
> -                       kfree(socfpga_clk);
> -                       return;
> -               }
> -       }
> -
>         of_property_read_string(node, "clock-output-names", &clk_name);
>
>         init.name = clk_name;
> diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-gate.c
> index 53d6e3ec4309..3e347b9e9eff 100644
> --- a/drivers/clk/socfpga/clk-gate.c
> +++ b/drivers/clk/socfpga/clk-gate.c
> @@ -108,61 +108,7 @@ static unsigned long socfpga_clk_recalc_rate(struct clk_hw *hwclk,
>         return parent_rate / div;
>  }
>
> -static int socfpga_clk_prepare(struct clk_hw *hwclk)
> -{
> -       struct socfpga_gate_clk *socfpgaclk = to_socfpga_gate_clk(hwclk);
> -       struct regmap *sys_mgr_base_addr;
> -       int i;
> -       u32 hs_timing;
> -       u32 clk_phase[2];
> -
> -       if (socfpgaclk->clk_phase[0] || socfpgaclk->clk_phase[1]) {
> -               sys_mgr_base_addr = syscon_regmap_lookup_by_compatible("altr,sys-mgr");
> -               if (IS_ERR(sys_mgr_base_addr)) {
> -                       pr_err("%s: failed to find altr,sys-mgr regmap!\n", __func__);
> -                       return -EINVAL;
> -               }
> -
> -               for (i = 0; i < 2; i++) {
> -                       switch (socfpgaclk->clk_phase[i]) {
> -                       case 0:
> -                               clk_phase[i] = 0;
> -                               break;
> -                       case 45:
> -                               clk_phase[i] = 1;
> -                               break;
> -                       case 90:
> -                               clk_phase[i] = 2;
> -                               break;
> -                       case 135:
> -                               clk_phase[i] = 3;
> -                               break;
> -                       case 180:
> -                               clk_phase[i] = 4;
> -                               break;
> -                       case 225:
> -                               clk_phase[i] = 5;
> -                               break;
> -                       case 270:
> -                               clk_phase[i] = 6;
> -                               break;
> -                       case 315:
> -                               clk_phase[i] = 7;
> -                               break;
> -                       default:
> -                               clk_phase[i] = 0;
> -                               break;
> -                       }
> -               }
> -               hs_timing = SYSMGR_SDMMC_CTRL_SET(clk_phase[0], clk_phase[1]);
> -               regmap_write(sys_mgr_base_addr, SYSMGR_SDMMCGRP_CTRL_OFFSET,
> -                       hs_timing);
> -       }
> -       return 0;
> -}
> -
>  static struct clk_ops gateclk_ops = {
> -       .prepare = socfpga_clk_prepare,
>         .recalc_rate = socfpga_clk_recalc_rate,
>         .get_parent = socfpga_clk_get_parent,
>         .set_parent = socfpga_clk_set_parent,
> @@ -172,7 +118,6 @@ void __init socfpga_gate_init(struct device_node *node)
>  {
>         u32 clk_gate[2];
>         u32 div_reg[3];
> -       u32 clk_phase[2];
>         u32 fixed_div;
>         struct clk_hw *hw_clk;
>         struct socfpga_gate_clk *socfpga_clk;
> @@ -218,12 +163,6 @@ void __init socfpga_gate_init(struct device_node *node)
>                 socfpga_clk->div_reg = NULL;
>         }
>
> -       rc = of_property_read_u32_array(node, "clk-phase", clk_phase, 2);
> -       if (!rc) {
> -               socfpga_clk->clk_phase[0] = clk_phase[0];
> -               socfpga_clk->clk_phase[1] = clk_phase[1];
> -       }
> -
>         of_property_read_string(node, "clock-output-names", &clk_name);
>
>         init.name = clk_name;
> diff --git a/drivers/clk/socfpga/clk.h b/drivers/clk/socfpga/clk.h
> index d80115fbdd6a..9a2fb2dde5b8 100644
> --- a/drivers/clk/socfpga/clk.h
> +++ b/drivers/clk/socfpga/clk.h
> @@ -50,7 +50,6 @@ struct socfpga_gate_clk {
>         u32 width;      /* only valid if div_reg != 0 */
>         u32 shift;      /* only valid if div_reg != 0 */
>         u32 bypass_shift;      /* only valid if bypass_reg != 0 */
> -       u32 clk_phase[2];
>  };
>
>  struct socfpga_periph_clk {
> --
> 2.25.1
>
