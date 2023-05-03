Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF8C6F61A0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 01:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjECXAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 19:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjECXAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 19:00:31 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [5.144.164.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316A14C27;
        Wed,  3 May 2023 16:00:28 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 799BA3FDCE;
        Thu,  4 May 2023 01:00:25 +0200 (CEST)
Date:   Thu, 4 May 2023 01:00:24 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] drm/msm/dpu: Enable compression for command mode
Message-ID: <rg6nlm4knw4hgtnwtvr4a5wqusyvvsetygiwxscp6bs6pun7ii@wzz6rd2y3vcn>
References: <20230405-add-dsc-support-v1-0-6bc6f03ae735@quicinc.com>
 <20230405-add-dsc-support-v1-4-6bc6f03ae735@quicinc.com>
 <hxqxnfcydzyfrlvihmil3gecan6p6xyjw44gielu63ltgtqul7@xwvoprzofq6g>
 <d4b7a747-77a0-95eb-1201-c8b1c80defe3@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4b7a747-77a0-95eb-1201-c8b1c80defe3@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jessica,

On 2023-05-03 12:04:59, Jessica Zhang wrote:
> 
> 
> On 5/3/2023 12:28 AM, Marijn Suijten wrote:
> > On 2023-05-02 18:19:15, Jessica Zhang wrote:
> >> Add a dpu_hw_intf op to enable data compression.
> >>
> >> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> >> ---
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c | 4 ++++
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c          | 7 +++++++
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h          | 2 ++
> >>   3 files changed, 13 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> >> index 74470d068622..4321a1aba17f 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> > 
> > Can we have INTF DCE on video-mode encoders as well?
> 
> Hi Marijn,
> 
> Currently, there's no way to validate DSC for video mode as I've only 
> made changes to support DSI for command mode. We are planning to post 
> changes to support DSC over DP, which will include changes for video mode.

Okay, but then mention so in the patch description (which is rather
short in this revision).

<snip>

> >>   #define INTF_CFG2_DATABUS_WIDEN	BIT(0)
> >>   #define INTF_CFG2_DATA_HCTL_EN	BIT(4)
> > 
> > These should probably be reindented to match the below... And the rest
> > of the defines use spaces instead of tabs.
> 
> Fair point, though I think fixing the whitespace for these 2 macros 
> specifically might be better in a more relevant series.

Yes, I have many patches to start cleaning these up, as well as all the
broken kerneldoc comments, but it's an uphill battle.  Not sure if I'll
get to it any time soon if at all.

> With that being said, I'll change the spacing of the DATA_COMPRESS bit 
> to spaces instead of tabs.

Thanks, that seems to be the most common format.

> >> +#define INTF_CFG2_DCE_DATA_COMPRESS	BIT(12)
> >>   
> >>   #define INTF_MISR_CTRL			0x180
> >>   #define INTF_MISR_SIGNATURE		0x184
> > 
> > This does not seem to apply on top of:
> > https://lore.kernel.org/linux-arm-msm/20230411-dpu-intf-te-v4-10-27ce1a5ab5c6@somainline.org/
> 
> Seems like I'm missing some patches from that series on my working 
> branch. Will rebase on top of the full series for the v2.

Thanks, but do discuss with Abhinav/Dmitry which series will land first.

> >> +static inline void dpu_hw_intf_enable_compression(struct dpu_hw_intf *ctx)
> > 
> > Why inline?  This is used as a pointer callback.
> 
> Acked, will remove the inline.
> 
> > 
> >> +{
> >> +	DPU_REG_WRITE(&ctx->hw, INTF_CONFIG2, INTF_CFG2_DCE_DATA_COMPRESS);
> > 
> > dpu_hw_intf_setup_timing_engine() also programs INTF_CONFIG2.  Is it
> > double-buffered, or is that config **always** unused when DSI CMD mode
> > is used in conjunction with DSC/DCE?  Otherwise this should perhaps OR
> > the bitflag into the register, or write the whole thing at once in
> > dpu_hw_intf_setup_timing_engine()?
> 
> For command mode, INTF_CONFIG2 is unused aside from setting 
> DATA_COMPRESS for DSC.
> 
> Since setup_timing_engine() is only used for video mode, the 
> corresponding changes will be made in the DSC v1.2 for DP changes.

Ack, that makes sense.  However, is this a guarantee that nothing else
will write INTF_CONFIG2 in the future, or will we solve that problem
when it happens?  I'm afraid more config-bits get added to this register
in the future and might possibly race/overwrite each other.

- Marijn

<snip>
