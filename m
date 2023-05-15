Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CEF703F93
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245356AbjEOVYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242402AbjEOVX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:23:58 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABDE93D9
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 14:23:57 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id EF0851F6B4;
        Mon, 15 May 2023 23:23:55 +0200 (CEST)
Date:   Mon, 15 May 2023 23:23:54 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        andersson@kernel.org, quic_jesszhan@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/8] drm/msm/dpu: add dsc blocks for remaining
 chipsets in catalog
Message-ID: <zkvmqpcdgeg3qjkddopqx2yfipmqjjyva2cnk5bq4npxzxto4v@gfgvp5hkblkm>
References: <1683914423-17612-1-git-send-email-quic_khsieh@quicinc.com>
 <1683914423-17612-2-git-send-email-quic_khsieh@quicinc.com>
 <4tmuqrz3du7pwwih3gzp6zveyfvwxj3meeksgxkbg2v5mdtyu3@e5xxuoe64rvv>
 <69538f77-ff08-c3ce-3d4a-9f7250ee2505@quicinc.com>
 <u47xthqfjxpbbzjbvnrz4qa2f2m3aip4iose7cwuhzg4raf7db@qxbos7u55wko>
 <d10da0ce-a22e-24e9-e895-fae4c3a35222@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d10da0ce-a22e-24e9-e895-fae4c3a35222@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-15 13:58:35, Abhinav Kumar wrote:
> 
> 
> 
> On 5/15/2023 1:07 PM, Marijn Suijten wrote:
> > On 2023-05-15 11:20:02, Abhinav Kumar wrote:
> >>
> >>
> >>
> >> On 5/14/2023 2:39 PM, Marijn Suijten wrote:
> >>> DSC*, and mention 1.1 explicitly (since this skips the 1.2 blocks, while
> >>> the series is clearly aimed at 1.1...).  This was done for the DSC 1.2
> >>> HW block patch after all.
> >>>
> >>> in catalog -> to catalog
> >>>
> >>> But it's just two platforms, you can fit MSM8998 and SC8180X in the
> >>> title.
> >>>
> >>> On 2023-05-12 11:00:16, Kuogee Hsieh wrote:
> >>>>
> >>>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> >>>>
> >>>> There are some platforms has DSC blocks but it is not declared at catalog.
> >>>
> >>> Some platforms have DSC blocks which have not yet been declared in the
> >>> catalog.*
> >>>
> >>>> For completeness, this patch adds DSC blocks for platforms which missed
> >>>> them.
> >>>
> >>> Drop "this patch":
> >>>
> >>>       Complete DSC 1.1 support for all platforms by adding the missing
> >>>       blocks to MSM8998 and SC8180X.
> >>>
> >>>>
> >>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> >>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>>> ---
> >>>>    drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h |  7 +++++++
> >>>>    drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h | 11 +++++++++++
> >>>
> >>> How about SC7180, and any other DPU 6.x revision?
> >>>
> >>
> >> Will let kuogee respond to the other nits. There is no DSC in sc7180 /
> >> sm6115 / qcm2290. So this patch is complete.
> > 
> > Thank you for checking as I didn't have the DTS close (and it seems
> > SC7180 would have supported this, but no).  I did check other SoCs in
> > the DPU 6.x range that are currently floating in my tree and on the
> > list, which do need their DSC 1.1 block added (both a single block at
> > 0x81000 downstream, 0x80000 upstream), if you can in a resend Konrad:
> > 
> > DPU 6.4 in SM6350: https://lore.kernel.org/linux-arm-msm/20230411-topic-straitlagoon_mdss-v3-6-9837d6b3516d@linaro.org/
> > DPU 6.9 in SM6375: https://lore.kernel.org/linux-arm-msm/20230411-topic-straitlagoon_mdss-v3-8-9837d6b3516d@linaro.org/
> > 
> 
> If these are still on the list, can Konrad add them to his change as 
> that way his catalog change will be complete? Otherwise I would prefer 
> to add them in a follow up change because marking this change as 
> dependent on a catalog change which adds a new chipset is not right.

The question was for Konrad (and I addressed him by name, not you) as
his series is not merged and the DSC blocks can be added to it directly
without depending on this series.  DSC 1.1 is after all available for
some time now.

- Marijn
