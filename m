Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0476725CE9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239533AbjFGLT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbjFGLTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:19:15 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477B31993
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 04:19:13 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b1bdfe51f8so5880601fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 04:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686136751; x=1688728751;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fjko3QRj+cFplx9h7zbRwTk/CwypS2aJGQpsJdnJBcU=;
        b=laRSDrsJNF9p2Ofs3Yfy7ka0nQNTWbKYMLIRRWEmQCnnCfuI+YpId+dWWU1TyPxBm5
         6Cmq3E/iMw+YsFNd5yjGx3NZnByip7EmAV9SHAEjtlw9byALWWELgRy3SYJKPWKGBQoA
         zd7Wx2S3Juto5ptbe+9OaIjOGSYJwY8qUnXwJ0mqTgROVxtyWUzZ4oFsGJL3roCX2sRO
         Y9TGulY7Yqn6MCizksVHMlD+JKfiPgjQ1QLNlr3CUB3MxpTlgwcWNJXjkbSqFCSvOL13
         QV332ueIJ64er8ta6wCXOPEjMGrVvRSizPJPSFBRJIB7bdpzGeMDVnBcH0iZ265hLEcE
         w+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686136751; x=1688728751;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fjko3QRj+cFplx9h7zbRwTk/CwypS2aJGQpsJdnJBcU=;
        b=VRIuYUkWBI2s0WZTzUZZa782gzQV45puHaS+93BSvnfdJFU9EO4jCwpU5+z4hNIe2U
         JcXNNuDeKKXvC6pAqG+gUPVAqMWuu8YHAZiym0SElMc7mtd8goCzSOn/yixqgrjd9pBI
         ohJzZG5D66nCnnLjojVbSRWlXghphUexR4EsOOTP3ZOarVZqayU3cA4EX/LCEf8cFXfw
         mYwItXwpFROVfKUz6Qyo8W9bxOHydirtVL0KwDiGO0vBSTMozeLoYgB8NYHCWUvOJEXS
         cBJaAM7TWxBhzwQxHAa4Nbc1CZJZVEWG5iRCPhpqTzSgc3yApcpwxewuriZPXracKsCm
         bbUA==
X-Gm-Message-State: AC+VfDwkdcKEaj3EFFDL3/fSmcYzkuNxpS7Rp+YsCUn2gyOixN+U2mU1
        tvPPNhCYNooIKFpvumMtuL9EmA==
X-Google-Smtp-Source: ACHHUZ5rgUIGYC9F4mfa/BwfD2kpufU+Xaf6Czj/chjjh9l/L1hLFCcM7s7tAr6X1R3s3BfQCW9tiA==
X-Received: by 2002:a05:651c:2050:b0:2b0:2214:f808 with SMTP id t16-20020a05651c205000b002b02214f808mr4542941ljo.16.1686136751092;
        Wed, 07 Jun 2023 04:19:11 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id x13-20020a2e7c0d000000b002ad90c2d0dasm2222771ljc.71.2023.06.07.04.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 04:19:10 -0700 (PDT)
Message-ID: <87810fde-c824-d494-17b3-b6ff34237bea@linaro.org>
Date:   Wed, 7 Jun 2023 14:19:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/9] clk: qcom: ipq5332: Fix USB related clock defines
Content-Language: en-GB
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, arnd@arndb.de, geert+renesas@glider.be,
        neil.armstrong@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, rafal@milecki.pl, quic_srichara@quicinc.com,
        quic_varada@quicinc.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
References: <cover.1686126439.git.quic_varada@quicinc.com>
 <3840e5b5795ef55ecbf25d0faa8c328f09c6d976.1686126439.git.quic_varada@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <3840e5b5795ef55ecbf25d0faa8c328f09c6d976.1686126439.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 13:56, Varadarajan Narayanan wrote:
> Fix the USB related clock defines and add details
> referenced by them
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>   drivers/clk/qcom/gcc-ipq5332.c | 34 +++++++++++++++++++++++-----------
>   1 file changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
> index a75ab88..2b58558 100644
> --- a/drivers/clk/qcom/gcc-ipq5332.c
> +++ b/drivers/clk/qcom/gcc-ipq5332.c
> @@ -351,6 +351,16 @@ static const struct freq_tbl ftbl_gcc_adss_pwm_clk_src[] = {
>   	{ }
>   };
>   
> +static const struct clk_parent_data gcc_usb3phy_0_cc_pipe_clk_xo[] = {
> +	{ .fw_name = "usb3phy_0_cc_pipe_clk" },
> +	{ .fw_name = "xo" },

gcc-ipq5332 uses DT indices, please don't mix that with .fw_name.

> +};
> +
> +static const struct parent_map gcc_usb3phy_0_cc_pipe_clk_xo_map[] = {
> +	{ P_USB3PHY_0_PIPE, 0 },
> +	{ P_XO, 2 },
> +};
> +
>   static struct clk_rcg2 gcc_adss_pwm_clk_src = {
>   	.cmd_rcgr = 0x1c004,
>   	.mnd_width = 0,
> @@ -1101,16 +1111,18 @@ static struct clk_rcg2 gcc_usb0_mock_utmi_clk_src = {
>   	},
>   };
>   
> -static struct clk_regmap_phy_mux gcc_usb0_pipe_clk_src = {
> +static struct clk_regmap_mux usb0_pipe_clk_src = {
>   	.reg = 0x2c074,
> +	.shift = 8,
> +	.width = 2,
> +	.parent_map = gcc_usb3phy_0_cc_pipe_clk_xo_map,
>   	.clkr = {
> -		.hw.init = &(struct clk_init_data) {
> -			.name = "gcc_usb0_pipe_clk_src",
> -			.parent_data = &(const struct clk_parent_data) {
> -				.index = DT_USB_PCIE_WRAPPER_PIPE_CLK,
> -			},
> -			.num_parents = 1,
> -			.ops = &clk_regmap_phy_mux_ops,
> +		.hw.init = &(const struct clk_init_data){
> +			.name = "usb0phy_0_cc_pipe_clk_src",
> +			.parent_data = gcc_usb3phy_0_cc_pipe_clk_xo,
> +			.num_parents = 2,
> +			.ops = &clk_regmap_mux_closest_ops,
> +			.flags = CLK_SET_RATE_PARENT,
>   		},

Soo... As you are reverting this. Is USB0 PIPE clock required to be 
parked to the XO? I was going to write 'before turning USB0_GDSC' off, 
but then I noticed that gcc-ipq5332 doesn't declare GDSCs. Does this 
platform have GDSCs?

>   	},
>   };
> @@ -3041,8 +3053,8 @@ static struct clk_branch gcc_usb0_pipe_clk = {
>   		.enable_mask = BIT(0),
>   		.hw.init = &(const struct clk_init_data) {
>   			.name = "gcc_usb0_pipe_clk",
> -			.parent_hws = (const struct clk_hw*[]) {
> -				&gcc_usb0_pipe_clk_src.clkr.hw,
> +			.parent_names = (const char *[]){
> +				"usb0_pipe_clk_src"

complete and definitive NAK. Do not use parent_names, we have just 
stopped migrating from them.

>   			},
>   			.num_parents = 1,
>   			.flags = CLK_SET_RATE_PARENT,
> @@ -3580,7 +3592,7 @@ static struct clk_regmap *gcc_ipq5332_clocks[] = {
>   	[GCC_PCIE3X2_PIPE_CLK_SRC] = &gcc_pcie3x2_pipe_clk_src.clkr,
>   	[GCC_PCIE3X1_0_PIPE_CLK_SRC] = &gcc_pcie3x1_0_pipe_clk_src.clkr,
>   	[GCC_PCIE3X1_1_PIPE_CLK_SRC] = &gcc_pcie3x1_1_pipe_clk_src.clkr,
> -	[GCC_USB0_PIPE_CLK_SRC] = &gcc_usb0_pipe_clk_src.clkr,
> +	[GCC_USB0_PIPE_CLK_SRC] = &usb0_pipe_clk_src.clkr,
>   };
>   
>   static const struct qcom_reset_map gcc_ipq5332_resets[] = {

-- 
With best wishes
Dmitry

