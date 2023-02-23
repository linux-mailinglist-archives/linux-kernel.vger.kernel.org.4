Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43BE6A0B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbjBWOED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbjBWODq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:03:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEF343450;
        Thu, 23 Feb 2023 06:03:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68A30616E3;
        Thu, 23 Feb 2023 14:03:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73022C433EF;
        Thu, 23 Feb 2023 14:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677161024;
        bh=UvqRkk4xih+DRkLjI1MDeXGN+OiFJukTXZcTvgj39Fc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ozvg272CDfsOwANz/sLn9jZnDJtP1t1Qi/0Rk8PSA5L1r1dAoJthKQRqboWFaAHF0
         Li6gQRzG1HKN3P24fvKgFZdVAZRUaUgpX6r7kP2swp9lto6n1ZRd+89lQUD6A8RnJy
         H7aX27usN8XRYFQUDxU1syCyOUquVF1BlaUxFQinLc+QjFwj9y5pYKIbqdhqmVLbAr
         kOPz9qn1DNRvNIOBTxd+DGlr+UYqv6oZsyVKBKhnj0/3veURO9zA9+qa/Dedf5a5q1
         9LmcR2CwrEWDyUDbuHkIBxqOuL+iVj/1Wav/drAm6ZzF9uZx+RCPh9QmtOA3sSu7Ms
         9DJB03lLiI7tw==
Date:   Thu, 23 Feb 2023 06:07:10 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Jun Nie <jun.nie@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Masney <masneyb@onstation.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 08/10] interconnect: qcom: msm8996: Specify no bus
 clock scaling on A0NoC
Message-ID: <20230223140710.72qcxcvyme5npf2v@ripper>
References: <20230217-topic-icc-fixes-v5-v5-0-c9a550f9fdb9@linaro.org>
 <20230217-topic-icc-fixes-v5-v5-8-c9a550f9fdb9@linaro.org>
 <8c4f1cc8-c1f8-06b6-53fe-7507d74ca958@linaro.org>
 <3c205131-632a-6592-5dc0-82313b26e5f6@linaro.org>
 <CAA8EJprJYPAsFZgu-DwjOHm6FsUEJ309zDo=Muh04L4B4oWhmw@mail.gmail.com>
 <5a2f502a-6530-dc8c-a81e-3d2a33964366@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a2f502a-6530-dc8c-a81e-3d2a33964366@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 09:28:54PM +0100, Konrad Dybcio wrote:
> 
> 
> On 17.02.2023 21:26, Dmitry Baryshkov wrote:
> > On Fri, 17 Feb 2023 at 21:53, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>
> >>
> >>
> >> On 17.02.2023 20:27, Konrad Dybcio wrote:
> >>>
> >>>
> >>> On 17.02.2023 11:46, Konrad Dybcio wrote:
> >>>> A0NoC only does bus scaling through RPM votes and does not have any
> >>>> ICC clocks. Describe this.
> >>>>
> >>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >>>> ---
> >>> This is bad, as devm_clk_get_bulk{"", _optional} doesn't
> >>> check if num_clocks makes sense and passes "-1" down the
> >>> devres alloc chain..
> >>>
> >>> I'll rework this for the next revision by simply assigning
> >>> the common "bus", "bus_a" set everywhere instead of relying
> >>> on it being there by default..
> >> Or maybe I shouldn't, as that will require redefining the array
> >> over and over again.. Perhaps just passing <&xo_board>, <&xo_board>
> >> to a0noc's "bus", "bus_a", similar to what's been done on SDM630's
> >> GNoC would be less messy?
> > 
> > What about simply skipping a call to devm_clk_get if num_bus_clocks is negative?
> I tested that locally before reporting the mistake on my side and
> while it works, I just consider it.. ugly, because:
> 
> num_clocks =
> >0 => use the externally specified num_/clocks (logical)
> =0 => use the default 2

Why not let go of this "convenience" and have num_clocks actually mean
number of clocks?

Regards,
Bjorn

> <0 => consider there's zero
> 
> ..but maybe that's just me.. if you don't find it ugly, I may just
> go with that.
> 
> Konrad
> > 
> >>
> >> Konrad
> >>>
> >>> Konrad
> >>>>  drivers/interconnect/qcom/msm8996.c | 1 +
> >>>>  1 file changed, 1 insertion(+)
> >>>>
> >>>> diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
> >>>> index 1a5e0ad36cc4..45eb8675fb11 100644
> >>>> --- a/drivers/interconnect/qcom/msm8996.c
> >>>> +++ b/drivers/interconnect/qcom/msm8996.c
> >>>> @@ -1817,6 +1817,7 @@ static const struct qcom_icc_desc msm8996_a0noc = {
> >>>>      .type = QCOM_ICC_NOC,
> >>>>      .nodes = a0noc_nodes,
> >>>>      .num_nodes = ARRAY_SIZE(a0noc_nodes),
> >>>> +    .num_bus_clocks = -1, /* No bus clock scaling */
> >>>>      .intf_clocks = a0noc_intf_clocks,
> >>>>      .num_intf_clocks = ARRAY_SIZE(a0noc_intf_clocks),
> >>>>      .has_bus_pd = true,
> >>>>
> > 
> > 
> > 
