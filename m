Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DE672C3EB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 14:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbjFLMXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 08:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjFLMXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 08:23:48 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414568F;
        Mon, 12 Jun 2023 05:23:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686572625; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KraH3vMubcmrj0C2LD6TbL1LwuPdGFzlSs1CP1s/MVK0/sR/7t1/HhJ9P6HvifIUBq
    4CpyLAop5mZokq4xG/Oqne0mUVoriENfN368pnrKYkap9PX4Jjd6Ye1wRX7egqH7BDyv
    dkkBZSaewfJpC6VWhJtgcyjThLHpPlEyUn/2AJIt3ef9pShdQMOZ5u5uIU6Zhlq8qbcQ
    3NwDBi16UA6tR4TiI6JIj/hctmemlcgdtKDm0xLkf/fT+aAnPmUmlocFhsQG4rYB1kBM
    CNLVWuca6UbLVAetiC7CjCm8lTItfNb1ivpW3eP8vlTpjUbTC4bgUQlGEZpOU+8c0Ggy
    Z6gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686572625;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=uwXBG3E5s7DWlWXmcS9AKhqA3Zu6XaqcG4rf7Fj3hkI=;
    b=BMv7CfX6d82rYMFlmfzPvcVMBA/Jxb8aiqwzyrAmUv+VdFVhp3YgvJAOabyL6CPvka
    2NLDLLsKyWBDlF5JwuxZ2HDRRpLruAglq77K65ClqQBu/63TlxK7G95f4CBnaFuhFCLG
    nDDOd7Cf58FpE05/ChY41n62XlfLSc+TA9glIjQwRXSagNpHuPQwaJTKQ+QNN4za5ko+
    Rnw0mqnZpcIreNcbs2Spd3OQP2eKswQbUIAzzAGEXdBloK77FjltCmiPy294YmKF7jws
    rF1G98SulIyHbrNjIyYoJd//MDlYdBRC0J+pN+wPss71FRXuNyeMcLMXo/Z1krBAhxR6
    DSew==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686572625;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=uwXBG3E5s7DWlWXmcS9AKhqA3Zu6XaqcG4rf7Fj3hkI=;
    b=izeyL70k/zgCOp8FrY/UKT2wBY9C+byoAzviCeTtDJCEOHC/LyY1x9Hk7NLr9b+Qt/
    kYx8YBEm0aOp8gvt0dfZBUHEzJY8bcYMXnUoS5kF2qEZl9ewp5N4SV6Xba4OrWC9SP9D
    M9qSnWcnHJ7Ee4ZwcPdyO8vqQsCExfkc6+es+rcCuwy40ZfuDFrm4LL1BdY7fe7pAoPm
    3kpf9noM41hDMXpeKfkVKDiGROXNOvnFVuDir/gPs7GGDWM48yBvU+yyHknI1ueoyfsM
    wj1BiYFfm6Pv7XGTu0EOZw/l5pQ4y6NSQ+tsXUOeokUKDVA4OhFtW0A4HQo2BbGnMv0o
    I+jA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686572625;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=uwXBG3E5s7DWlWXmcS9AKhqA3Zu6XaqcG4rf7Fj3hkI=;
    b=2M/8jbyDvm2/Nyphv4KnQQsPFw2rbODQRZLPwms608pFPhfYIXkG3p9vHL23ps+ORe
    lAKzELcNHPPYLKNsZWAQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8peN1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5CCNjUhs
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 12 Jun 2023 14:23:45 +0200 (CEST)
Date:   Mon, 12 Jun 2023 14:23:39 +0200
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
Message-ID: <ZIcOS2o0l72R3lbt@gerhold.net>
References: <20230612-topic-rcg2_ro-v1-0-e7d824aeb628@linaro.org>
 <20230612-topic-rcg2_ro-v1-2-e7d824aeb628@linaro.org>
 <ZIbw0dEdFNFcC0Hr@gerhold.net>
 <8196144d-6cf1-897c-2520-3686e6414abb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8196144d-6cf1-897c-2520-3686e6414abb@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 01:46:26PM +0200, Konrad Dybcio wrote:
> On 12.06.2023 12:17, Stephan Gerhold wrote:
> > On Mon, Jun 12, 2023 at 11:22:48AM +0200, Konrad Dybcio wrote:
> >> The config/periph/system NoC clocks are wholly controlled by the
> >> RPM firmware and Linux should never ever alter their configuration.
> >>
> >> Switch them over to read-only ops to avoid that.
> >>
> >> Fixes: b1e010c0730a ("clk: qcom: Add MSM8996 Global Clock Control (GCC) driver")
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> ---
> >>  drivers/clk/qcom/gcc-msm8996.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/clk/qcom/gcc-msm8996.c b/drivers/clk/qcom/gcc-msm8996.c
> >> index 5e44d1bcca9e..588e3b67657a 100644
> >> --- a/drivers/clk/qcom/gcc-msm8996.c
> >> +++ b/drivers/clk/qcom/gcc-msm8996.c
> >> @@ -264,7 +264,7 @@ static struct clk_rcg2 system_noc_clk_src = {
> >>  		.name = "system_noc_clk_src",
> >>  		.parent_data = gcc_xo_gpll0_gpll0_early_div,
> >>  		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_early_div),
> >> -		.ops = &clk_rcg2_ops,
> >> +		.ops = &clk_rcg2_ro_ops,
> >>  	},
> >>  };
> >>  
> >> @@ -284,7 +284,7 @@ static struct clk_rcg2 config_noc_clk_src = {
> >>  		.name = "config_noc_clk_src",
> >>  		.parent_data = gcc_xo_gpll0,
> >>  		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
> >> -		.ops = &clk_rcg2_ops,
> >> +		.ops = &clk_rcg2_ro_ops,
> >>  	},
> >>  };
> >>  
> >> @@ -306,7 +306,7 @@ static struct clk_rcg2 periph_noc_clk_src = {
> >>  		.name = "periph_noc_clk_src",
> >>  		.parent_data = gcc_xo_gpll0,
> >>  		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
> >> -		.ops = &clk_rcg2_ops,
> >> +		.ops = &clk_rcg2_ro_ops,
> >>  	},
> >>  };
> >>  
> > 
> > If the rcg is read-only then it shouldn't need a .freq_tbl (the
> > .recalc_rate() works without it). These clocks have one for some reason.
> .get_parent needs it
> 

Hm? .get_parent uses the ->parent_map but not the ->freq_tbl as far as I
can see. :)

Stephan
