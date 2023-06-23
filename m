Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B3D73B95D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjFWOHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjFWOHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:07:12 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23FD2688
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:07:09 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-c029d59fcb7so584147276.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687529229; x=1690121229;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RiTsI118hafq6i7nvtRJQvtGzINzF3YoXOeY8ZJPq3A=;
        b=I73lpsaBMc0XCR6IVKEAqO9BTMv4WIAHysjUU3hEuxBO4wItAaE29RcseaPW/qLmtU
         D9OArOCZ/fjcEvxjmKeKeaPMmD6sElsbLNWBrYGtUywFe0Za4UsOHARyAp3MVTaKdD4L
         ZV9ZzOYlc17QmrRTHaTAoQRA7VHCC6s3y2qQEbC/NRfuliJE7c87Bw/xJKI/1Ng4hm11
         +U5VbUst/Rn/5yv0zI2mKrSk3pYz9lTU32a0udN5aPcqX3nlFUbAq4ZAPIK5BfU0Mrhh
         8QTMmTSTsBxuHP3kVnpl+7Kv+G586s84HV3y8bRulyMIvAA4Di+neNPL9jEpNjwDl5CN
         mz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687529229; x=1690121229;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RiTsI118hafq6i7nvtRJQvtGzINzF3YoXOeY8ZJPq3A=;
        b=EfhzivWGpgkVaZw3tgN0j8d0zFSHGiEYnDYyj3/DeMUJgSjxOxvBhgIPy6jHQKeK4F
         t/E4T2zJ6OygaXBBsPxIUtf8UaPHuqmPskxuFEoSaJ3imJedHPDVjP3aEgDEbcMdYfIg
         v4OhFqDO+wi+UwcNAE0Gr+5LS4NwMflkPJ3TTNYQu2Lizl1t90fhRkIAVZowcXpFwSOv
         RGB43T2kZil3ep1oO33jUn/DyYs0dRJti7Qv8gPirWSPL4W8WbXgpvqU7DcND07bmiLs
         ilAgt0QEPfoHkKPHO5zFxm6keQ/Nqc8xXWIL0ulD2WFaGu+6yPJsagd3+uAjDZauK3ZY
         W6Bg==
X-Gm-Message-State: AC+VfDx7CHm4VIkfpdjLQ7YI5R4IoqgQrbijCqydSUEiWIwWPSa6voTH
        K7QsuN2fnybc4s4O9f6EH1arWAEyEBM4Jukp/J9dbA==
X-Google-Smtp-Source: ACHHUZ5jvJ6GmqvtQsOQTLLuQkFQ6bbuFf78sByUgFT/7MU80lXUpNxJtuz6gFslpjENxjQ4EgbwL15CIaoB/AnF1DQ=
X-Received: by 2002:a25:4183:0:b0:bcc:571d:a300 with SMTP id
 o125-20020a254183000000b00bcc571da300mr15312465yba.20.1687529229088; Fri, 23
 Jun 2023 07:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230616104941.921555-1-quic_imrashai@quicinc.com>
 <20230616104941.921555-3-quic_imrashai@quicinc.com> <acc8d1e4-e899-2ea4-947f-2bdcef7b7263@linaro.org>
 <66da39ad-33bf-2de8-949d-9f2f93e915e3@quicinc.com>
In-Reply-To: <66da39ad-33bf-2de8-949d-9f2f93e915e3@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 23 Jun 2023 17:06:57 +0300
Message-ID: <CAA8EJpqynBfuoxnVMc5yG9qYgZO3sKMssjAz-REt2umYqe2_8w@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: qcom: gcc-qdu1000: Update GCC clocks and add
 support for GDSCs
To:     Imran Shaik <quic_imrashai@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2023 at 13:08, Imran Shaik <quic_imrashai@quicinc.com> wrote:
>
>
>
> On 6/16/2023 4:50 PM, Dmitry Baryshkov wrote:
> > On 16/06/2023 13:49, Imran Shaik wrote:
> >> Update the GCC clocks and add support for GDSCs for QDU1000 and
> >> QRU1000 SoCs. While at it, fix the PCIe pipe clock handling and
> >> add support for v2 variant.
> >
> > Please split this into individual chunks instead of squashing everything
> > together. For each change please describe the logic behind the change in
> > the commit message. Please describe why, not what is changed.
> >
>
> Sure, will split this patch and post the next series.
>
> >>
> >> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> >> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
> >
> > This doesn't look fully logical. Who is the author of the patch? If
> > there are two authors, please add Co-developed-by tag.
> >
>
> Yes, will use Co-developed-by tag in the next patch series.
>
> >> ---
> >>   drivers/clk/qcom/gcc-qdu1000.c | 162 ++++++++++++++++++++++-----------
> >>   1 file changed, 110 insertions(+), 52 deletions(-)
> >>
> >> diff --git a/drivers/clk/qcom/gcc-qdu1000.c
> >> b/drivers/clk/qcom/gcc-qdu1000.c
> >> index 5051769ad90c..5d8125c0eacc 100644
> >> --- a/drivers/clk/qcom/gcc-qdu1000.c
> >> +++ b/drivers/clk/qcom/gcc-qdu1000.c
> >> @@ -1,6 +1,6 @@
> >>   // SPDX-License-Identifier: GPL-2.0-only
> >>   /*
> >> - * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights
> >> reserved.
> >> + * Copyright (c) 2022-2023, Qualcomm Innovation Center, Inc. All
> >> rights reserved.
> >>    */
> >>   #include <linux/clk-provider.h>
> >> @@ -17,6 +17,7 @@
> >>   #include "clk-regmap-divider.h"
> >>   #include "clk-regmap-mux.h"
> >>   #include "clk-regmap-phy-mux.h"
> >> +#include "gdsc.h"
> >>   #include "reset.h"
> >>   enum {
> >> @@ -370,16 +371,6 @@ static const struct clk_parent_data
> >> gcc_parent_data_6[] = {
> >>       { .index = DT_TCXO_IDX },
> >>   };
> >> -static const struct parent_map gcc_parent_map_7[] = {
> >> -    { P_PCIE_0_PIPE_CLK, 0 },
> >> -    { P_BI_TCXO, 2 },
> >> -};
> >> -
> >> -static const struct clk_parent_data gcc_parent_data_7[] = {
> >> -    { .index = DT_PCIE_0_PIPE_CLK_IDX },
> >> -    { .index = DT_TCXO_IDX },
> >> -};
> >> -
> >>   static const struct parent_map gcc_parent_map_8[] = {
> >>       { P_BI_TCXO, 0 },
> >>       { P_GCC_GPLL0_OUT_MAIN, 1 },
> >> @@ -439,16 +430,15 @@ static struct clk_regmap_mux
> >> gcc_pcie_0_phy_aux_clk_src = {
> >>       },
> >>   };
> >> -static struct clk_regmap_mux gcc_pcie_0_pipe_clk_src = {
> >> +static struct clk_regmap_phy_mux gcc_pcie_0_pipe_clk_src = {
> >>       .reg = 0x9d064,
> >> -    .shift = 0,
> >> -    .width = 2,
> >> -    .parent_map = gcc_parent_map_7,
> >>       .clkr = {
> >>           .hw.init = &(const struct clk_init_data) {
> >>               .name = "gcc_pcie_0_pipe_clk_src",
> >> -            .parent_data = gcc_parent_data_7,
> >> -            .num_parents = ARRAY_SIZE(gcc_parent_data_7),
> >> +            .parent_data = &(const struct clk_parent_data){
> >> +                .index = DT_PCIE_0_PIPE_CLK_IDX,
> >> +            },
> >> +            .num_parents = 1,
> >>               .ops = &clk_regmap_phy_mux_ops,
> >>           },
> >>       },
> >> @@ -485,7 +475,7 @@ static struct clk_rcg2
> >> gcc_aggre_noc_ecpri_dma_clk_src = {
> >>           .name = "gcc_aggre_noc_ecpri_dma_clk_src",
> >>           .parent_data = gcc_parent_data_4,
> >>           .num_parents = ARRAY_SIZE(gcc_parent_data_4),
> >> -        .ops = &clk_rcg2_ops,
> >> +        .ops = &clk_rcg2_shared_ops,
> >>       },
> >>   };
> >> @@ -505,7 +495,7 @@ static struct clk_rcg2
> >> gcc_aggre_noc_ecpri_gsi_clk_src = {
> >>           .name = "gcc_aggre_noc_ecpri_gsi_clk_src",
> >>           .parent_data = gcc_parent_data_5,
> >>           .num_parents = ARRAY_SIZE(gcc_parent_data_5),
> >> -        .ops = &clk_rcg2_ops,
> >> +        .ops = &clk_rcg2_shared_ops,
> >
> > This is probably some kind of NoC or NIU clock. If it is not to be
> > touched by Linux, the recent clk_rcg2_ro_ops patch looks promising here.
> >
>
> This is not a NoC or NIU clock and Linux will use this clock.

The clock name ("gcc_aggre_noc_ecpri_gsi_clk_src") seems to disagree with you.

> >>       },
> >>   };
> >> @@ -524,7 +514,7 @@ static struct clk_rcg2 gcc_gp1_clk_src = {
> >>           .name = "gcc_gp1_clk_src",
> >>           .parent_data = gcc_parent_data_1,
> >>           .num_parents = ARRAY_SIZE(gcc_parent_data_1),
> >> -        .ops = &clk_rcg2_ops,
> >> +        .ops = &clk_rcg2_shared_ops,
> >
> > But why? GP clocks are not shared.
> > The 'why?' question applies to all such changes. As I wrote, please
> > split & describe the reason.
> >
>
> We want to park all the RCGs at safe clock source (XO) during disable.
> Hence using the clk_rcg2_shared_ops for all the RCGs.
>
> Will split and post the next patch series.

For this (and for all other changes) please describe the reason behind
the change in the commit message.
For example, for GP clocks there seems to be no reason to park them.
On other platforms it was perfectly fine to disable them instead.


-- 
With best wishes
Dmitry
