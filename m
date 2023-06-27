Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EE573F80B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjF0JCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjF0JCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:02:39 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4372710C9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 02:02:36 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id C0A7A3F792;
        Tue, 27 Jun 2023 11:02:28 +0200 (CEST)
Date:   Tue, 27 Jun 2023 11:02:27 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>
Subject: Re: [PATCH 03/15] dt-bindings: clock: qcom,dispcc-sm6125: Require
 GCC PLL0 DIV clock
Message-ID: <makhh4ebdmoa5f6r4mbx4g2v2cpcsi74wqf3622dxuli4w7tb6@els2rvqcnvgz>
References: <52c57cab-10cf-2e7e-2c1d-fa6506786d45@linaro.org>
 <jmtjuya4c423rmdlo4ubvvqndbxvgapal5otjqnejdpdd25izp@kewbjmqdu2xs>
 <6311f26f-79ee-c471-649f-5e0b4629cfcc@linaro.org>
 <uuy5prkjhhs66te7h6z3pu4lzj2cfbiqk6ftjijwoeqpw573av@ogs6cboanvzc>
 <ziykmixskqkgheigefvyo4q3katbc4uix6jtcg7mncs25z4tj5@5gykrfgns4bm>
 <16731023-7dc7-d43d-1b16-fda44c0948ed@linaro.org>
 <yofju7jp7vmv33x7dzvzoelpumfsz3fjqy2ozakfphsuysunon@pglt2wzlsjex>
 <683a6f7e-bf1a-aff2-070b-472fb14e0353@linaro.org>
 <3nnk4xvmpnum2q6g6c6crjlqq3ra7j2z5zis53xcqbvevymuhz@mkffvs45n6ut>
 <145ab255-b3f8-1c6c-824d-5f1b40568d30@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <145ab255-b3f8-1c6c-824d-5f1b40568d30@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-27 10:21:12, Krzysztof Kozlowski wrote:
> On 27/06/2023 09:49, Marijn Suijten wrote:
> > On 2023-06-27 09:29:53, Krzysztof Kozlowski wrote:
> >> On 27/06/2023 08:54, Marijn Suijten wrote:
> >>> On 2023-06-27 08:24:41, Krzysztof Kozlowski wrote:
> >>>> On 26/06/2023 20:53, Marijn Suijten wrote:
> >>>>> On 2023-06-26 20:51:38, Marijn Suijten wrote:
> >>>>> <snip>
> >>>>>>> Not really, binding also defines the list of clocks - their order and
> >>>>>>> specific entries. This changes.
> >>>>>>
> >>>>>> And so it does in "dt-bindings: clock: qcom,dispcc-sm6125: Remove unused
> >>>>>> GCC_DISP_AHB_CLK"?
> >>>>>
> >>>>> Never mind: it is the last item so the order of the other items doesn't
> >>>>> change.  The total number of items decreases though, which sounds like
> >>>>> an ABI-break too?
> >>>>
> >>>> How does it break? Old DTS works exactly the same, doesn't it?
> >>>
> >>> So deleting a new item at the end does not matter.  But what if I respin
> >>> this patch to add the new clock _at the end_, which will then be at the
> >>> same index as the previous GCC_DISP_AHB_CLK?
> >>
> >> I think you know the answer, right? What do you want to prove? That two
> >> independent changes can have together negative effect? We know this.
> > 
> > The question is whether this is allowed?
> 
> That would be an ABI break and I already explained if it is or is not
> allowed.

How should we solve it then, if we cannot remove GCC_DISP_AHB_CLK in one
patch and add GCC_DISP_GPLL0_DIV_CLK_SRC **at the end** in the next
patch?  Keep an empty spot at the original index of GCC_DISP_AHB_CLK?

- Marijn
