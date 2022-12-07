Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2FA645EEA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiLGQ3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiLGQ2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:28:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E736142;
        Wed,  7 Dec 2022 08:28:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E56EE61AF8;
        Wed,  7 Dec 2022 16:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD250C433D6;
        Wed,  7 Dec 2022 16:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670430508;
        bh=ipjSmsI9QqNeS01tUG949g1IQiVfVqA0GymYF8fe8BM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EuKEN5V/QlL3cMGwV8JMrjwhdvYF8TUIs9wJMUWSNhXTkFqLcVHB1x31XJtVIwYor
         f6U1oRnyT5X0+cYOxIIavjnCOyrQTxfl/f8IJpsOXRV8MyP8u5QtUeEo8Wc16yKPQZ
         81S1s0mrJBfv6P202Gz8IaMRHt+VdqUdpNkAVCkidecBvefyHzJjq2XPUon4a5lxYl
         Pb7HW4LxZIdSrb5hXKjiij7OgHfFl0FaWQS2mtD9718OyIPt3cu2Ilt4FYYqHsi5eN
         KukKvie9m67IJIqMK0DWUPQsaNqQolLBPLTnD73KAZSAlMEgS73T4r8iJnb/0nmyj0
         FL4jW1jGjwxhQ==
Date:   Wed, 7 Dec 2022 10:28:24 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/13] drm/msm/dpu: Introduce SC8280XP
Message-ID: <20221207162824.kyxecdz43v5ojatx@builder.lan>
References: <20221205174433.16847-1-quic_bjorande@quicinc.com>
 <20221205174433.16847-3-quic_bjorande@quicinc.com>
 <0430d878-e0cd-3708-91a3-2eca66418386@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0430d878-e0cd-3708-91a3-2eca66418386@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 04:49:07PM +0200, Dmitry Baryshkov wrote:
> On 05/12/2022 19:44, Bjorn Andersson wrote:
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
[..]
> > +static const struct dpu_mdp_cfg sc8280xp_mdp[] = {
> > +	{
> > +	.name = "top_0", .id = MDP_TOP,
> > +	.base = 0x0, .len = 0x494,
> > +	.features = 0,
> > +	.highest_bank_bit = 0x3, /* TODO: 2 for LP_DDR4 */
> 
> ubwc_swizzle ? I'd suppose it's 6, but I'd bet on it.
> 

I don't see ubwc_swizzle defined for any other platform, and it seems to
be unused for DPU_HW_UBWC_VER_40. Am I perhaps missing something?

> > +	.clk_ctrls[DPU_CLK_CTRL_VIG0] = { .reg_off = 0x2ac, .bit_off = 0},
> > +	.clk_ctrls[DPU_CLK_CTRL_VIG1] = { .reg_off = 0x2b4, .bit_off = 0},
> > +	.clk_ctrls[DPU_CLK_CTRL_VIG2] = { .reg_off = 0x2bc, .bit_off = 0},
> > +	.clk_ctrls[DPU_CLK_CTRL_VIG3] = { .reg_off = 0x2c4, .bit_off = 0},
> > +	.clk_ctrls[DPU_CLK_CTRL_DMA0] = { .reg_off = 0x2ac, .bit_off = 8},
> > +	.clk_ctrls[DPU_CLK_CTRL_DMA1] = { .reg_off = 0x2b4, .bit_off = 8},
> > +	.clk_ctrls[DPU_CLK_CTRL_CURSOR0] = { .reg_off = 0x2bc, .bit_off = 8},
> > +	.clk_ctrls[DPU_CLK_CTRL_CURSOR1] = { .reg_off = 0x2c4, .bit_off = 8},
> > +	.clk_ctrls[DPU_CLK_CTRL_REG_DMA] = { .reg_off = 0x2bc, .bit_off = 20},
> > +	},
> > +};
> > +
> >   static const struct dpu_mdp_cfg qcm2290_mdp[] = {
> >   	{
> >   	.name = "top_0", .id = MDP_TOP,
> > @@ -648,6 +693,45 @@ static const struct dpu_ctl_cfg sc7180_ctl[] = {
> >   	},
> >   };
> > +static const struct dpu_ctl_cfg sc8280xp_ctl[] = {
> > +	{
> > +	.name = "ctl_0", .id = CTL_0,
> > +	.base = 0x15000, .len = 0x204,
> > +	.features = BIT(DPU_CTL_ACTIVE_CFG) | BIT(DPU_CTL_FETCH_ACTIVE) | BIT(DPU_CTL_VM_CFG),
> 
> Please use CTL_SC7270_MASK instead, unless you have a strong reasong not to
> do it.
> 

No strong reason, will update.

Thanks,
Bjorn
