Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06BB6E1AB8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 05:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjDNDXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 23:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDNDXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 23:23:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD7B2D78;
        Thu, 13 Apr 2023 20:23:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6C8E6142A;
        Fri, 14 Apr 2023 03:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1086AC433D2;
        Fri, 14 Apr 2023 03:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681442628;
        bh=dWGS/YaPHR/fQv4dBr6p4FNjaecwHauI4HlGGWcgXT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MfRNr1aTuyIX7APY63DHiwdotjsX7QOVFjacYy6BXKxKiam+MSquLnJaAXuelFx19
         JZT5jCN52ex/gUS6+HA13IgHi7WxrRCdmQkVddt+r6qotXikbQF77b60zcJUUOb/m2
         /ZK7Qod/CW0N8oiSmmxyBtJSzzx2JM1Fkp6WNSe82zF9fzqal2QD8Woe7azzAvrz4D
         7rZKvYrQiQjYHDIzrCB+aK0PsViv4YbEYU3Tm2sUcrO+uTL9myACCv4o+3/ZAwvBsb
         PXHkMBjggWxdKGm27n+o0I4yCMWJnWw1uf011L2DwPMQ8A7yMIUhYaHLb7fbLDc02g
         OQJS4ona4XwHQ==
Date:   Thu, 13 Apr 2023 20:27:26 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] clk: qcom: Introduce SM8350 VIDEOCC
Message-ID: <20230414032726.ppssnbensuzcrjrm@ripper>
References: <20230413-topic-lahaina_vidcc-v1-0-134f9b22a5b3@linaro.org>
 <20230413-topic-lahaina_vidcc-v1-2-134f9b22a5b3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413-topic-lahaina_vidcc-v1-2-134f9b22a5b3@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 08:44:59PM +0200, Konrad Dybcio wrote:
> diff --git a/drivers/clk/qcom/videocc-sm8350.c b/drivers/clk/qcom/videocc-sm8350.c
[..]
> +static struct clk_alpha_pll video_pll0 = {
> +	.offset = 0x42c,
> +	.vco_table = lucid_5lpe_vco,
> +	.num_vco = ARRAY_SIZE(lucid_5lpe_vco),
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
> +	.clkr = {
> +		.hw.init = &(struct clk_init_data){

I know it's tiny, but please add a <space> between ) and { of these.

> +			.name = "video_pll0",
> +			.parent_data = &(const struct clk_parent_data){
> +				.index = DT_BI_TCXO,
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_lucid_5lpe_ops,
> +		},
> +	},
> +};
[..]
> +
> +static int __init video_cc_sm8350_init(void)
> +{
> +	return platform_driver_register(&video_cc_sm8350_driver);
> +}
> +subsys_initcall(video_cc_sm8350_init);

You don't need this at subsys_initcall(), please use
module_platform_driver().

Thanks,
Bjorn
