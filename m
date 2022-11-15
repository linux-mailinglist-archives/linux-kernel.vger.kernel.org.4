Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C4862982E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237459AbiKOMIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiKOMIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:08:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA7C19D;
        Tue, 15 Nov 2022 04:08:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBA34616F4;
        Tue, 15 Nov 2022 12:08:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A03BC433C1;
        Tue, 15 Nov 2022 12:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668514122;
        bh=36O5ZVGHwpudvTRB6K/ShaxuTdaYXWLBRiw6cKRjPQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X4X2MSR0/9alcGjFPpwcz6tiznvVr/oN7cY9afoKsqW+iiKJPfJahQC0Ge0WPq8at
         a8TNIxpjSLw/+c67G39RfdhcBSdnd7VeTYJET09y3C1HlNjK8Vk6/qu/hgPgFMbKCV
         MG1ldcnOs5G6/4FyqdRqRFCX1/jaoULEqnDW3374uoTkccIGDYXNQsPej+6c0YKx+W
         7cGt9Od2NFrA5j5m9IDMXPucZLRs+utfCkYN+SaE2ZJpJCLxUw1wMkd35um/ddZts1
         59EuAtn/vguxDPEiyGhz6dB8o9xsOvRcBMYjyTSJGIkJs5W4FVYiimnHp7Z7zXSkcz
         GEzKDcbzVBRng==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ouujb-0000HE-7s; Tue, 15 Nov 2022 13:08:11 +0100
Date:   Tue, 15 Nov 2022 13:08:11 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Shazad Hussain <quic_shazhuss@quicinc.com>
Cc:     andersson@kernel.org, sboyd@kernel.org, bmasney@redhat.com,
        agross@kernel.org, mturquette@baylibre.com,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: qcom: gcc-sc8280xp: add cxo as parent for three
 ufs ref clks
Message-ID: <Y3OBK0PponwcsQB1@hovoldconsulting.com>
References: <20221115102217.6381-1-quic_shazhuss@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115102217.6381-1-quic_shazhuss@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 03:52:17PM +0530, Shazad Hussain wrote:
> Added parent_data as CXO for three UFS reference clocks named,
> gcc_ufs_ref_clkref_clk, gcc_ufs_card_clkref_clk and
> gcc_ufs_1_card_clkref_clk.

The commit message should explain why this is needed rather than just
state what is being done. For example, something along the lines of

	The three UFS reference clocks gcc_ufs_ref_clkref_clk,
	gcc_ufs_card_clkref_clk and gcc_ufs_1_card_clkref_clk are all
	sourced from CXO.

	Update the clock driver to describe this.

should do.

> Fixes: d65d005f9a6c ("clk: qcom: add sc8280xp GCC driver")
> Link: https://lore.kernel.org/lkml/Y2Tber39cHuOSR%2FW@hovoldconsulting.com/
> Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>

Tested-by: Johan Hovold <johan+linaro@kernel.org>

And with a tweaked commit message you can also add:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

>---
> Changes since v1:
> - Renamed patch subject. Did not include Brian's T-b comment.
> - Added parent data for two ufs phy ref clocks.
> 
> v1 of this patch can be found at
> https://lore.kernel.org/all/20221030142333.31019-1-quic_shazhuss@quicinc.com/
> 
> used below patches for verification on next-20221114
> https://lore.kernel.org/lkml/20221104092045.17410-2-johan+linaro@kernel.org/
> https://lore.kernel.org/lkml/20221104092045.17410-3-johan+linaro@kernel.org/
> https://lore.kernel.org/lkml/20221111113732.461881-1-thierry.reding@gmail.com/
> 
>  drivers/clk/qcom/gcc-sc8280xp.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
> index a18ed88f3b82..b3198784e1c3 100644
> --- a/drivers/clk/qcom/gcc-sc8280xp.c
> +++ b/drivers/clk/qcom/gcc-sc8280xp.c
> @@ -5364,6 +5364,8 @@ static struct clk_branch gcc_ufs_1_card_clkref_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(const struct clk_init_data) {
>  			.name = "gcc_ufs_1_card_clkref_clk",
> +			.parent_data = &gcc_parent_data_tcxo,
> +			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -5432,6 +5434,8 @@ static struct clk_branch gcc_ufs_card_clkref_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(const struct clk_init_data) {
>  			.name = "gcc_ufs_card_clkref_clk",
> +			.parent_data = &gcc_parent_data_tcxo,
> +			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -5848,6 +5852,8 @@ static struct clk_branch gcc_ufs_ref_clkref_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(const struct clk_init_data) {
>  			.name = "gcc_ufs_ref_clkref_clk",
> +			.parent_data = &gcc_parent_data_tcxo,
> +			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},

Johan
