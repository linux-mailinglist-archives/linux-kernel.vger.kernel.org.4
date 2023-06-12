Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A28B72BF4C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjFLKj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbjFLKjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:39:13 -0400
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de [IPv6:2a01:238:400:200::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE2311D8B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686565081; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jxn8o9EnAZ8Io5P5JZbCzVNuEdgs9765qhTvoxlzmgNG+ZB+a3qH83ZGCHgxa7MRni
    rd1QmJaPbqRzj1kygjgu3Dv62Rbz6BkTF16CAHAN33mxv4djQT/ZGakT8J3Tfr42zSF7
    wrQNksBHZIQ+TImWNyl2QlwQ85hcuYWz7uPgGkCQKYs/EMcxXsVHaE77FN825x24qX91
    msTB+6/vQRlpXNnyi1IGqhbRMTp2tn5fpUZX4kAN6aJmHbIJglL+LhgAmrbzk3Wrm193
    UwOwIX4RzxtWV6ksMDf3UkDOgwjqUKHpKFhh5h5GgHETsqMPJUgUhkl1ZleNUPAJ+q6A
    K3bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686565081;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=O0ppVuWISUsVQVfyM0fiPG5Ry6Z19qZGKk5vMjERVQ4=;
    b=eBeRtHe19dIi+u8OLbqyzC4BGmhf2LNtHjNIFtuzf/pmtIrL3aX7jZd/SaTiib3ad7
    Xnlf+rMJJfS2DCAiyg9+vDehO3e7em+oU+u1fLjTKhX37DJI+3DWPd4XqaMjVA/bL34O
    GwjK4wcGBoISEDFpPqT7S1oXxjSssEsq/QRfaDoiOMLNrphVUhsq/ptI1671s7cOGZLb
    YrJUoaQGznOuiCk0B6hkROUyekrPy6gv4eKNRgklrXSvAm+W+OVRYn0qLmd50OR/qjbc
    mneMSS/Aooqk1AySG5l9v0iI7Cibasx8UIGNQrdFxAzU1li/9qwUOSHh0vts8guocAQo
    c2/Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686565081;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=O0ppVuWISUsVQVfyM0fiPG5Ry6Z19qZGKk5vMjERVQ4=;
    b=o+y0d+46Fm7NRgJv8lcRVeCh801vkUiooz4camOnQCqtQIVU9HwrwZZAJ4fvauxA09
    KIswFXAB/QxMpcMCnZQ4inl6iBSESc5nWWLBB3GY+CBv5EUdCQdgYZprwaDcTVDK1ja0
    C9Ij/ZVKvgBc5rsPeh85O7ERfIMJb3QpJyKwfhehW9JKbmlVHRY1u8sfnAMSyc1Oh9YX
    P2WCRxG7x2LXvxkheJ4X0MXCK8WKqDeAbeu2c21DzIqnULtsMlG2d3grIIZCDU1tRHax
    Kt2tx12t2yajPy7SbRqY9FEj8Yv79CgX1Qq7rpW48YJMif3KXdetjeMEYn8Oa9AQJRIY
    qCTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686565081;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=O0ppVuWISUsVQVfyM0fiPG5Ry6Z19qZGKk5vMjERVQ4=;
    b=6NIVw0t7WSuZnbxpcEe3ebtHr+D9bplt4WaKUYqHwRFv6C42KPR+SEeCmbAhopKuh/
    aw4SaluFAglLOlRX0pCA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8peN1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5CAI1U4o
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 12 Jun 2023 12:18:01 +0200 (CEST)
Date:   Mon, 12 Jun 2023 12:17:53 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] clk: qcom: gcc-msm8996: Use read-only RCG ops for
 RPM bus clocks
Message-ID: <ZIbw0dEdFNFcC0Hr@gerhold.net>
References: <20230612-topic-rcg2_ro-v1-0-e7d824aeb628@linaro.org>
 <20230612-topic-rcg2_ro-v1-2-e7d824aeb628@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612-topic-rcg2_ro-v1-2-e7d824aeb628@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:22:48AM +0200, Konrad Dybcio wrote:
> The config/periph/system NoC clocks are wholly controlled by the
> RPM firmware and Linux should never ever alter their configuration.
> 
> Switch them over to read-only ops to avoid that.
> 
> Fixes: b1e010c0730a ("clk: qcom: Add MSM8996 Global Clock Control (GCC) driver")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/clk/qcom/gcc-msm8996.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-msm8996.c b/drivers/clk/qcom/gcc-msm8996.c
> index 5e44d1bcca9e..588e3b67657a 100644
> --- a/drivers/clk/qcom/gcc-msm8996.c
> +++ b/drivers/clk/qcom/gcc-msm8996.c
> @@ -264,7 +264,7 @@ static struct clk_rcg2 system_noc_clk_src = {
>  		.name = "system_noc_clk_src",
>  		.parent_data = gcc_xo_gpll0_gpll0_early_div,
>  		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_early_div),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_ro_ops,
>  	},
>  };
>  
> @@ -284,7 +284,7 @@ static struct clk_rcg2 config_noc_clk_src = {
>  		.name = "config_noc_clk_src",
>  		.parent_data = gcc_xo_gpll0,
>  		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_ro_ops,
>  	},
>  };
>  
> @@ -306,7 +306,7 @@ static struct clk_rcg2 periph_noc_clk_src = {
>  		.name = "periph_noc_clk_src",
>  		.parent_data = gcc_xo_gpll0,
>  		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_ro_ops,
>  	},
>  };
>  

If the rcg is read-only then it shouldn't need a .freq_tbl (the
.recalc_rate() works without it). These clocks have one for some reason.

Maybe we should also set .flags = CLK_GET_RATE_NOCACHE to ensure that
clk_get_rate() doesn't return some stale value? Although I'm not sure if
it's enough to set it here or if it would need to be set on all child
clocks as well.

Thanks,
Stephan
