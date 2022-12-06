Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E569D644BCD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiLFSd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiLFSdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:33:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC2743852;
        Tue,  6 Dec 2022 10:31:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C0CB6189A;
        Tue,  6 Dec 2022 18:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5AFC433C1;
        Tue,  6 Dec 2022 18:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670351461;
        bh=5xTLjp4LeFj0uXRgLCQLSq2wJXbvdG8fJOW+4kkXY+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=amYtWejkR96N3Rc+kkrX8N3+no0s11/MLffgcbXb7n7YOdyxIIak+ZUvQI6VX/LUA
         u8QahuoSc7o4D7f9BMlgHunGFnbwHF8kFyTjzfxe6HW/PsufUfk/9bLWjBuxujZvj9
         bDcg/l+jLIk0df4Iw+tUNRSOp/DG3UpRvBBOAwxeAjq/nutULrKAu5srwrtxCOrpfZ
         1zyrM+aLV9H2o7qm1zD3A3SocX/yrJsxvc/pFLGp70Q87gcuKnaIF1k6ZQ69bMX3Cb
         TFag4Qqvm9fAE9V9i97cDPMa2O44XkmqwVZstDSJVubzxlrw0BSjQkIJbImfHz4EyG
         /OTJsPMFBMapg==
Date:   Tue, 6 Dec 2022 12:30:58 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Alex Elder <alex.elder@linaro.org>
Cc:     Alex Elder <elder@linaro.org>, sboyd@kernel.org,
        mturquette@baylibre.com, konrad.dybcio@linaro.org,
        agross@kernel.org, Luca Weiss <luca.weiss@fairphone.com>,
        dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: qcom: rpmh: add support for SM6350 rpmh IPA clock
Message-ID: <20221206183058.rsws5ciqa2u5q7oj@builder.lan>
References: <20221202221240.225720-1-elder@linaro.org>
 <20221205225646.gtwhakd4lxh6vlfc@builder.lan>
 <39903fb5-fd28-c159-b300-47d3ec4cd0fc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39903fb5-fd28-c159-b300-47d3ec4cd0fc@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 09:05:30PM -0600, Alex Elder wrote:
> On 12/5/22 4:56 PM, Bjorn Andersson wrote:
> > On Fri, Dec 02, 2022 at 04:12:40PM -0600, Alex Elder wrote:
> > > From: Luca Weiss <luca.weiss@fairphone.com>
> > > 
> > > The IPA core clock is required for SM6350.  Define it.
> > > 
> > > [elder@linaro.org: rebased with Dmitry's changes]
> > > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> 
> Sorry about that, I knew I was supposed to sign
> off and thought I had.
> 
> You told me separately that this was sufficient:
> 
> Signed-off-by: Alex Elder <elder@linaro.org>
> 
> If you want me to send a new version with the
> signoff just let me know.  Thanks.
> 

That works fine, thank you.
Bjorn

> 					-Alex
> > 
> > Thanks for rebasing this Alex. But as you're handling the patch you need
> > to add your S-o-b; which will make sure your [] makes sense as well.
> > 
> > Regards,
> > Bjorn
> > 
> > > ---
> > > v2: This is now based on qualcomm/for-next.
> > > 
> > >   drivers/clk/qcom/clk-rpmh.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> > > index 2c2ef4b6d130e..586a810c682ca 100644
> > > --- a/drivers/clk/qcom/clk-rpmh.c
> > > +++ b/drivers/clk/qcom/clk-rpmh.c
> > > @@ -606,6 +606,7 @@ static struct clk_hw *sm6350_rpmh_clocks[] = {
> > >   	[RPMH_LN_BB_CLK3_A]	= &clk_rpmh_ln_bb_clk3_g4_ao.hw,
> > >   	[RPMH_QLINK_CLK]	= &clk_rpmh_qlink_div4.hw,
> > >   	[RPMH_QLINK_CLK_A]	= &clk_rpmh_qlink_div4_ao.hw,
> > > +	[RPMH_IPA_CLK]		= &clk_rpmh_ipa.hw,
> > >   };
> > >   static const struct clk_rpmh_desc clk_rpmh_sm6350 = {
> > > -- 
> > > 2.34.1
> > > 
> 
