Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07865F1A74
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 09:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJAHD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 03:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJAHDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 03:03:23 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C71E1A2A1F
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 00:03:22 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-353fbfa727cso63646967b3.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 00:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=uAsOMusmOv9rGWfhvmdzC31+QnKZUq7RRceyu2qijc8=;
        b=cg+UZrYLhxEcM6BFlQeU7q1b0m3x2IPwY1hlYkLD+jeqOH9mJ3n5fkkurT6IHbXPSS
         PQQ2qFiJH27ckelU65TtN2ixkSzdDu3f3MlGeNLidRZP0kI6/VjJirpRHAWqIy5TNEWF
         xH6reTWFa0FHevbyh87LrpiCBAThHeNQp9w1zEeGNBzd2xw/tOJQ9v3BLqDlD49D8jec
         r/hFJA1ctPMcSfPVr6/V2n4mx2ox/8T2gPWDxGOrr15ylvbIhw7xvTmrP11wlOE+iURD
         mR9L/ASKx9UJZj87ataP2Pzu+CA8yuBe4j2bT14ZyJcagiegX4UvTodLCcyvEjHEzGRU
         KnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=uAsOMusmOv9rGWfhvmdzC31+QnKZUq7RRceyu2qijc8=;
        b=GsG2sBvIy7/1o6JqROlDCn9XHChqrpl9C1E6Fq18DCIRG9nIoyV3RuKf46EsONZV1E
         W81mZ0CKnRgaLryE2d16P1Cii4WgbyrHgjW3u8uMU54x0Sw8iCAG/bO1AbfqKQTg5X3K
         9uYQtfBMBE0FPTcZ2hv2avIOltXjvU/spSWLVA1157GxhAT1b+VAr9lTQEtLqevOttwl
         CfE6D/wrCIzb4XK3aH+y3QV+uwSljod5qcfFqSh0xzvQsa0GjyLdPddmhbCvGNsKJkFD
         GluamRnLR2hHz9I6bI2yQA7tV8JAp9BjuaPtj21PbdS+xaxmrlnrjkTzBqsYvWlaTdzR
         QsgQ==
X-Gm-Message-State: ACrzQf3lHA8E/R4KSDOMs6ARiBfjsF3X+LmB6UF48URJe0dr5dYMxoW1
        oTITPiWhOCPJWYq5YyyMIlKkqsV11J8LehHk/At0tg==
X-Google-Smtp-Source: AMsMyM7n7fO1bBUcoE5IZG/jROB90kg3rRYMoPnOf0GeMAK4lyaVIcKkDdm9TJmTCkMfBkAnWBg42C+pR8+cM1wM/Gw=
X-Received: by 2002:a0d:d68a:0:b0:350:a7f0:7b69 with SMTP id
 y132-20020a0dd68a000000b00350a7f07b69mr11814671ywd.132.1664607801493; Sat, 01
 Oct 2022 00:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <20221001030403.27659-1-quic_molvera@quicinc.com> <20221001030403.27659-5-quic_molvera@quicinc.com>
In-Reply-To: <20221001030403.27659-5-quic_molvera@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 1 Oct 2022 10:03:00 +0300
Message-ID: <CAA8EJppBfYST2VQrv6-LZBvtLcNUMkpLgXcic-fSUzFXhiYbaA@mail.gmail.com>
Subject: Re: [PATCH 4/5] clk: qcom: Add support for QDU1000 and QRU1000 RPMh clocks
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Oct 2022 at 06:05, Melody Olvera <quic_molvera@quicinc.com> wrote:
>
> Add support for RMPh clocks for QDU1000 and QRU1000 SoCs.
>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  drivers/clk/qcom/clk-rpmh.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> index c07cab6905cb..27d11ffac71e 100644
> --- a/drivers/clk/qcom/clk-rpmh.c
> +++ b/drivers/clk/qcom/clk-rpmh.c
> @@ -628,6 +628,18 @@ static const struct clk_rpmh_desc clk_rpmh_sdx65 = {
>         .num_clks = ARRAY_SIZE(sdx65_rpmh_clocks),
>  };
>
> +DEFINE_CLK_RPMH_ARC(qdru1000, bi_tcxo, bi_tcxo_ao, "xo.lvl", 0x3, 1);
> +
> +static struct clk_hw *qdru1000_rpmh_clocks[] = {
> +       [RPMH_CXO_CLK]      = &qdru1000_bi_tcxo.hw,
> +       [RPMH_CXO_CLK_A]    = &qdru1000_bi_tcxo_ao.hw,
> +};
> +
> +static const struct clk_rpmh_desc clk_rpmh_qdru1000 = {
> +       .clks = qdru1000_rpmh_clocks,
> +       .num_clks = ARRAY_SIZE(qdru1000_rpmh_clocks),
> +};
> +
>  static struct clk_hw *of_clk_rpmh_hw_get(struct of_phandle_args *clkspec,
>                                          void *data)
>  {
> @@ -723,6 +735,8 @@ static const struct of_device_id clk_rpmh_match_table[] = {
>         { .compatible = "qcom,sm8350-rpmh-clk", .data = &clk_rpmh_sm8350},
>         { .compatible = "qcom,sm8450-rpmh-clk", .data = &clk_rpmh_sm8450},
>         { .compatible = "qcom,sc7280-rpmh-clk", .data = &clk_rpmh_sc7280},
> +       { .compatible = "qcom,qdu1000-rpmh-clk", .data = &clk_rpmh_qdru1000},
> +       { .compatible = "qcom,qru1000-rpmh-clk", .data = &clk_rpmh_qdru1000},

Also the list isn't fully sorted, let's target that. Please move your
compat strings into the beginning.

>         { }
>  };
>  MODULE_DEVICE_TABLE(of, clk_rpmh_match_table);
> --
> 2.37.3
>


-- 
With best wishes
Dmitry
