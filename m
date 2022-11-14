Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5C56286DD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237646AbiKNRU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237965AbiKNRUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:20:00 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C7023170
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:19:58 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id n12so29962315eja.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v9W4KqdCieBpZJnWLkIE2s46ppozsXEoH+8VL5wBYv4=;
        b=HXqpq8QaYEoZJny7TWW3p60gQDNq4RK5Q0F2OoAWFwrHTIymJ6CZmN5DaP+PKe3J6A
         3EzU6QHeHl8jFyQh1ne5Een3NxtVx8WpENopH6zYINj3rEWMivKhtnDDNcrKNQM7tc3c
         bL+MCSZZM2goL63CLHTMy6KKjiXIG7ZCg2qJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v9W4KqdCieBpZJnWLkIE2s46ppozsXEoH+8VL5wBYv4=;
        b=WEtsENffZtXu/I3f/GoJeWB2ppyerjsmRSJ3WyEsLxZai5MpblnAZmj+d5Ojxdup9i
         ndAMsg0sfCguhhfttPydenN63LRs0kpFnhQzcGI1VzeBxgednOwkhISebKBKag3Ha/ru
         FuZaRsbyhhqyhsyuOz2aVFMAoTtTH86z6hYVtIf7Z1J33uFY5RifRSiNy3JFOy5evFt7
         cFG4pvVuvyWJTpMuf9PUA1w3snfhNED+ioNaJCettpQnM0UphLw2h3BB2NoFDFlxIjm3
         Zdls1Pswb6Bh2FNuEL3HFaO1rWMN6X5eR4H5BLf6Mv0w2t5iv4lWexORX92o6mXJZCzU
         FHlQ==
X-Gm-Message-State: ANoB5pnjGY0lgUx+qJGBX72/d5PLEZEl47pH4OxF1Du4GSwweIV+OVZv
        A9YdxJ0lmeih1vA7pB/uNymC3R/WERnsETcGLih2Bg==
X-Google-Smtp-Source: AA0mqf4SY4F2CQFHCZcazkFIy9OxnZarh1UBunKS04PYoQzkqk4Rm3HKAvHSsqzMnDz6xGnRIsfAeRnaS37nPnexBWc=
X-Received: by 2002:a17:906:4911:b0:7ad:9891:8756 with SMTP id
 b17-20020a170906491100b007ad98918756mr11254276ejq.203.1668446396499; Mon, 14
 Nov 2022 09:19:56 -0800 (PST)
MIME-Version: 1.0
References: <20221113180710.1625410-1-dario.binacchi@amarulasolutions.com>
 <20221113180710.1625410-2-dario.binacchi@amarulasolutions.com> <20221114083405.lpy2fjslfg644wex@pengutronix.de>
In-Reply-To: <20221114083405.lpy2fjslfg644wex@pengutronix.de>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Mon, 14 Nov 2022 18:19:45 +0100
Message-ID: <CABGWkvoBnq7PCzbAcF1oFVr0ydnpWPs5z7vLWBAnuectetMoDw@mail.gmail.com>
Subject: Re: [PATCH 1/5] clk: imx8mn: rename vpu_pll to m7_alt_pll
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-amarula@amarulasolutions.com,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, michael@amarulasolutions.com,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Abel Vesa <abelvesa@kernel.org>
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

Hi Marco,

On Mon, Nov 14, 2022 at 9:34 AM Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> Hi Dario,
>
> On 22-11-13, Dario Binacchi wrote:
> > There is no occurrence of vpu pll in the reference manual (document
> > IMX8MNRM Rev 2, 07/2022). From an analysis of the code and the RM
> > itself, I think vpu pll is used instead of m7 alternate pll, probably
> > for copy and paste of code taken from modules of similar architectures.
> >
> > As an example for all, if we consider the second row of the "Clock Root"
> > table of chapter 5 (Clocks and Power Management) of the RM:
> >
> >      Clock Root     offset     Source Select (CCM_TARGET_ROOTn[MUX])
> >         ...          ...                    ...
> >   ARM_M7_CLK_ROOT   0x8080            000 - 24M_REF_CLK
> >                                       001 - SYSTEM_PLL2_DIV5
> >                                     010 - SYSTEM_PLL2_DIV4
> >                                     011 - M7_ALT_PLL_CLK
> >                                     100 - SYSTEM_PLL1_CLK
> >                                     101 - AUDIO_PLL1_CLK
> >                                     110 - VIDEO_PLL_CLK
> >                                     111 - SYSTEM_PLL3_CLK
> >         ...          ...                    ...
> >
> > but in the source code, the imx8mn_m7_sels clocks list contains vpu_pll
> > for the source select bits 011b.
>
> Thanks for the real detailed description. Maybe we should mention, that
> the 8MN has no VPU complex at all.
>
> > So, let's rename "vpu_pll" to "m7_alt_pll" to be consistent with the RM.
> >
> > No functional changes intended.
> >
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > ---
> >
> >  drivers/clk/imx/clk-imx8mn.c             | 16 ++++++++--------
> >  include/dt-bindings/clock/imx8mn-clock.h |  8 ++++----
> >  2 files changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
> > index d37c45b676ab..72f9563a0ff6 100644
> > --- a/drivers/clk/imx/clk-imx8mn.c
> > +++ b/drivers/clk/imx/clk-imx8mn.c
> > @@ -30,7 +30,7 @@ static const char * const audio_pll2_bypass_sels[] = {"audio_pll2", "audio_pll2_
> >  static const char * const video_pll1_bypass_sels[] = {"video_pll1", "video_pll1_ref_sel", };
> >  static const char * const dram_pll_bypass_sels[] = {"dram_pll", "dram_pll_ref_sel", };
> >  static const char * const gpu_pll_bypass_sels[] = {"gpu_pll", "gpu_pll_ref_sel", };
> > -static const char * const vpu_pll_bypass_sels[] = {"vpu_pll", "vpu_pll_ref_sel", };
> > +static const char * const m7_alt_pll_bypass_sels[] = {"m7_alt_pll", "m7_alt_pll_ref_sel", };
> >  static const char * const arm_pll_bypass_sels[] = {"arm_pll", "arm_pll_ref_sel", };
> >  static const char * const sys_pll3_bypass_sels[] = {"sys_pll3", "sys_pll3_ref_sel", };
> >
> > @@ -40,7 +40,7 @@ static const char * const imx8mn_a53_sels[] = {"osc_24m", "arm_pll_out", "sys_pl
> >
> >  static const char * const imx8mn_a53_core_sels[] = {"arm_a53_div", "arm_pll_out", };
> >
> > -static const char * const imx8mn_m7_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll2_250m", "vpu_pll_out",
> > +static const char * const imx8mn_m7_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll2_250m", "m7_alt_pll_out",
> >                                      "sys_pll1_800m", "audio_pll1_out", "video_pll1_out", "sys_pll3_out", };
> >
> >  static const char * const imx8mn_gpu_core_sels[] = {"osc_24m", "gpu_pll_out", "sys_pll1_800m",
> > @@ -252,10 +252,10 @@ static const char * const imx8mn_gpt6_sels[] = {"osc_24m", "sys_pll2_100m", "sys
> >                                               "audio_pll1_out", "clk_ext1", };
> >
> >  static const char * const imx8mn_wdog_sels[] = {"osc_24m", "sys_pll1_133m", "sys_pll1_160m",
> > -                                             "vpu_pll_out", "sys_pll2_125m", "sys_pll3_out",
> > +                                             "m7_alt_pll_out", "sys_pll2_125m", "sys_pll3_out",
> >                                               "sys_pll1_80m", "sys_pll2_166m", };
> >
> > -static const char * const imx8mn_wrclk_sels[] = {"osc_24m", "sys_pll1_40m", "vpu_pll_out",
> > +static const char * const imx8mn_wrclk_sels[] = {"osc_24m", "sys_pll1_40m", "m7_alt_pll_out",
> >                                                "sys_pll3_out", "sys_pll2_200m", "sys_pll1_266m",
> >                                                "sys_pll2_500m", "sys_pll1_100m", };
> >
> > @@ -352,7 +352,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
> >       hws[IMX8MN_VIDEO_PLL1_REF_SEL] = imx_clk_hw_mux("video_pll1_ref_sel", base + 0x28, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> >       hws[IMX8MN_DRAM_PLL_REF_SEL] = imx_clk_hw_mux("dram_pll_ref_sel", base + 0x50, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> >       hws[IMX8MN_GPU_PLL_REF_SEL] = imx_clk_hw_mux("gpu_pll_ref_sel", base + 0x64, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> > -     hws[IMX8MN_VPU_PLL_REF_SEL] = imx_clk_hw_mux("vpu_pll_ref_sel", base + 0x74, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> > +     hws[IMX8MN_M7_ALT_PLL_REF_SEL] = imx_clk_hw_mux("m7_alt_pll_ref_sel", base + 0x74, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> >       hws[IMX8MN_ARM_PLL_REF_SEL] = imx_clk_hw_mux("arm_pll_ref_sel", base + 0x84, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> >       hws[IMX8MN_SYS_PLL3_REF_SEL] = imx_clk_hw_mux("sys_pll3_ref_sel", base + 0x114, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> >
> > @@ -361,7 +361,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
> >       hws[IMX8MN_VIDEO_PLL1] = imx_clk_hw_pll14xx("video_pll1", "video_pll1_ref_sel", base + 0x28, &imx_1443x_pll);
> >       hws[IMX8MN_DRAM_PLL] = imx_clk_hw_pll14xx("dram_pll", "dram_pll_ref_sel", base + 0x50, &imx_1443x_dram_pll);
> >       hws[IMX8MN_GPU_PLL] = imx_clk_hw_pll14xx("gpu_pll", "gpu_pll_ref_sel", base + 0x64, &imx_1416x_pll);
> > -     hws[IMX8MN_VPU_PLL] = imx_clk_hw_pll14xx("vpu_pll", "vpu_pll_ref_sel", base + 0x74, &imx_1416x_pll);
> > +     hws[IMX8MN_M7_ALT_PLL] = imx_clk_hw_pll14xx("m7_alt_pll", "m7_alt_pll_ref_sel", base + 0x74, &imx_1416x_pll);
> >       hws[IMX8MN_ARM_PLL] = imx_clk_hw_pll14xx("arm_pll", "arm_pll_ref_sel", base + 0x84, &imx_1416x_pll);
> >       hws[IMX8MN_SYS_PLL1] = imx_clk_hw_fixed("sys_pll1", 800000000);
> >       hws[IMX8MN_SYS_PLL2] = imx_clk_hw_fixed("sys_pll2", 1000000000);
> > @@ -373,7 +373,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
> >       hws[IMX8MN_VIDEO_PLL1_BYPASS] = imx_clk_hw_mux_flags("video_pll1_bypass", base + 0x28, 16, 1, video_pll1_bypass_sels, ARRAY_SIZE(video_pll1_bypass_sels), CLK_SET_RATE_PARENT);
> >       hws[IMX8MN_DRAM_PLL_BYPASS] = imx_clk_hw_mux_flags("dram_pll_bypass", base + 0x50, 16, 1, dram_pll_bypass_sels, ARRAY_SIZE(dram_pll_bypass_sels), CLK_SET_RATE_PARENT);
> >       hws[IMX8MN_GPU_PLL_BYPASS] = imx_clk_hw_mux_flags("gpu_pll_bypass", base + 0x64, 28, 1, gpu_pll_bypass_sels, ARRAY_SIZE(gpu_pll_bypass_sels), CLK_SET_RATE_PARENT);
> > -     hws[IMX8MN_VPU_PLL_BYPASS] = imx_clk_hw_mux_flags("vpu_pll_bypass", base + 0x74, 28, 1, vpu_pll_bypass_sels, ARRAY_SIZE(vpu_pll_bypass_sels), CLK_SET_RATE_PARENT);
> > +     hws[IMX8MN_M7_ALT_PLL_BYPASS] = imx_clk_hw_mux_flags("m7_alt_pll_bypass", base + 0x74, 28, 1, m7_alt_pll_bypass_sels, ARRAY_SIZE(m7_alt_pll_bypass_sels), CLK_SET_RATE_PARENT);
> >       hws[IMX8MN_ARM_PLL_BYPASS] = imx_clk_hw_mux_flags("arm_pll_bypass", base + 0x84, 28, 1, arm_pll_bypass_sels, ARRAY_SIZE(arm_pll_bypass_sels), CLK_SET_RATE_PARENT);
> >       hws[IMX8MN_SYS_PLL3_BYPASS] = imx_clk_hw_mux_flags("sys_pll3_bypass", base + 0x114, 28, 1, sys_pll3_bypass_sels, ARRAY_SIZE(sys_pll3_bypass_sels), CLK_SET_RATE_PARENT);
> >
> > @@ -383,7 +383,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
> >       hws[IMX8MN_VIDEO_PLL1_OUT] = imx_clk_hw_gate("video_pll1_out", "video_pll1_bypass", base + 0x28, 13);
> >       hws[IMX8MN_DRAM_PLL_OUT] = imx_clk_hw_gate("dram_pll_out", "dram_pll_bypass", base + 0x50, 13);
> >       hws[IMX8MN_GPU_PLL_OUT] = imx_clk_hw_gate("gpu_pll_out", "gpu_pll_bypass", base + 0x64, 11);
> > -     hws[IMX8MN_VPU_PLL_OUT] = imx_clk_hw_gate("vpu_pll_out", "vpu_pll_bypass", base + 0x74, 11);
> > +     hws[IMX8MN_M7_ALT_PLL_OUT] = imx_clk_hw_gate("m7_alt_pll_out", "m7_alt_pll_bypass", base + 0x74, 11);
> >       hws[IMX8MN_ARM_PLL_OUT] = imx_clk_hw_gate("arm_pll_out", "arm_pll_bypass", base + 0x84, 11);
> >       hws[IMX8MN_SYS_PLL3_OUT] = imx_clk_hw_gate("sys_pll3_out", "sys_pll3_bypass", base + 0x114, 11);
>
> The driver changes looking good from my pov.
>
> > diff --git a/include/dt-bindings/clock/imx8mn-clock.h b/include/dt-bindings/clock/imx8mn-clock.h
> > index 07b8a282c268..f103b008a12a 100644
> > --- a/include/dt-bindings/clock/imx8mn-clock.h
> > +++ b/include/dt-bindings/clock/imx8mn-clock.h
> > @@ -19,7 +19,7 @@
> >  #define IMX8MN_VIDEO_PLL1_REF_SEL            10
> >  #define IMX8MN_DRAM_PLL_REF_SEL                      11
> >  #define IMX8MN_GPU_PLL_REF_SEL                       12
> > -#define IMX8MN_VPU_PLL_REF_SEL                       13
> > +#define IMX8MN_M7_ALT_PLL_REF_SEL            13
>
> If we take backward compatibility serious we can't do that since this
> may break existing device trees. What you can do is:
>
> #define IMX8MN_M7_ALT_PLL_REF_SEL               13
> #define IMX8MN_VPU_PLL_REF_SEL                  IMX8MN_M7_ALT_PLL_REF_SEL
>
> and add a comment that we need this for backward compatibility. Same
> applies for the below defines.

If I run the command "git grep IMX8MN_VPU_PLL", this is the output:
drivers/clk/imx/clk-imx8mn.c:   hws[IMX8MN_VPU_PLL_REF_SEL] =
imx_clk_hw_mux("vpu_pll_ref_sel", base + 0x74, 0, 2, pll_ref_sels,
ARRAY_SIZE(pll_ref_sels));
drivers/clk/imx/clk-imx8mn.c:   hws[IMX8MN_VPU_PLL] =
imx_clk_hw_pll14xx("vpu_pll", "vpu_pll_ref_sel", base + 0x74,
&imx_1416x_pll);
drivers/clk/imx/clk-imx8mn.c:   hws[IMX8MN_VPU_PLL_BYPASS] =
imx_clk_hw_mux_flags("vpu_pll_bypass", base + 0x74, 28, 1,
vpu_pll_bypass_sels, ARRAY_SIZE(vpu_pll_bypass_sels),
CLK_SET_RATE_PARENT);
drivers/clk/imx/clk-imx8mn.c:   hws[IMX8MN_VPU_PLL_OUT] =
imx_clk_hw_gate("vpu_pll_out", "vpu_pll_bypass", base + 0x74, 11);
include/dt-bindings/clock/imx8mn-clock.h:#define
IMX8MN_VPU_PLL_REF_SEL                 13
include/dt-bindings/clock/imx8mn-clock.h:#define IMX8MN_VPU_PLL
                 23
include/dt-bindings/clock/imx8mn-clock.h:#define IMX8MN_VPU_PLL_BYPASS
                 33
include/dt-bindings/clock/imx8mn-clock.h:#define IMX8MN_VPU_PLL_OUT
                 43

No device tree comes out.
So can we say that backwards compatibility is guaranteed or am I
missing something ?

Thanks and regards,
Dario

>
> Regards,
>   Marco
>
> >  #define IMX8MN_ARM_PLL_REF_SEL                       14
> >  #define IMX8MN_SYS_PLL1_REF_SEL                      15
> >  #define IMX8MN_SYS_PLL2_REF_SEL                      16
> > @@ -29,7 +29,7 @@
> >  #define IMX8MN_VIDEO_PLL1                    20
> >  #define IMX8MN_DRAM_PLL                              21
> >  #define IMX8MN_GPU_PLL                               22
> > -#define IMX8MN_VPU_PLL                               23
> > +#define IMX8MN_M7_ALT_PLL                    23
> >  #define IMX8MN_ARM_PLL                               24
> >  #define IMX8MN_SYS_PLL1                              25
> >  #define IMX8MN_SYS_PLL2                              26
> > @@ -39,7 +39,7 @@
> >  #define IMX8MN_VIDEO_PLL1_BYPASS             30
> >  #define IMX8MN_DRAM_PLL_BYPASS                       31
> >  #define IMX8MN_GPU_PLL_BYPASS                        32
> > -#define IMX8MN_VPU_PLL_BYPASS                        33
> > +#define IMX8MN_M7_ALT_PLL_BYPASS             33
> >  #define IMX8MN_ARM_PLL_BYPASS                        34
> >  #define IMX8MN_SYS_PLL1_BYPASS                       35
> >  #define IMX8MN_SYS_PLL2_BYPASS                       36
> > @@ -49,7 +49,7 @@
> >  #define IMX8MN_VIDEO_PLL1_OUT                        40
> >  #define IMX8MN_DRAM_PLL_OUT                  41
> >  #define IMX8MN_GPU_PLL_OUT                   42
> > -#define IMX8MN_VPU_PLL_OUT                   43
> > +#define IMX8MN_M7_ALT_PLL_OUT                        43
> >  #define IMX8MN_ARM_PLL_OUT                   44
> >  #define IMX8MN_SYS_PLL1_OUT                  45
> >  #define IMX8MN_SYS_PLL2_OUT                  46
> > --
> > 2.32.0
> >
> >
> >



-- 

Dario Binacchi

Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
