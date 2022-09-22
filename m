Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CAA5E570E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 02:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiIVAOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 20:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiIVAOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 20:14:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B436425;
        Wed, 21 Sep 2022 17:14:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1E9D632DE;
        Thu, 22 Sep 2022 00:14:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD59C433C1;
        Thu, 22 Sep 2022 00:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663805672;
        bh=AqQ9r6jKKEdIP1KLMG+7Lq7QqqeArJ/0yKpA4jI6foM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GWXzjieCObHHLAI7eAidV1+pSLEjUgOnbjmxVnfaqwrQgaFRxrIwMzD92BBTiDmNp
         Lvljc+9ApYsP2PVl0HFUD5UKwHJYOn/MkzcRfRU2Xd+G6YIc7L2rraiXnOzfkb77Et
         aNiyAAY48lW95eG4NnMbgCIe4VlHsZVQiyGXDKHXnAtim5Boc68pbVGMJZgRuStimz
         HERLh/vDN/9eNZ80FuLF3fUJy2yWACyfYnqtpTMllOV+Fh0Vk/u/98UGJgHO1BRVTV
         mloqMmODCZrGdOrLJPSXUZJ0CPFJxUGRWlEK/gCCR8LV9XpDqgcwNKOm2Xd89yZh/Q
         tidsaAe9FepsA==
Date:   Wed, 21 Sep 2022 19:14:29 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] dt-bindings: msm/dp: Add SDM845 and SC8280XP
 compatibles
Message-ID: <20220922001429.zqfap3clprvlo6jo@builder.lan>
References: <20220916200028.25009-1-quic_bjorande@quicinc.com>
 <20220916200028.25009-2-quic_bjorande@quicinc.com>
 <1641e41c-08c7-859b-644a-28d966fb00f3@linaro.org>
 <20220919211832.6b3buqxrnfp6yjjg@builder.lan>
 <6b242b44-b657-c7a6-63ca-465c7031376f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b242b44-b657-c7a6-63ca-465c7031376f@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 09:09:13AM +0200, Krzysztof Kozlowski wrote:
> On 19/09/2022 23:18, Bjorn Andersson wrote:
> > On Sat, Sep 17, 2022 at 06:03:27PM +0100, Krzysztof Kozlowski wrote:
> >> On 16/09/2022 21:00, Bjorn Andersson wrote:
> >>> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> >>>
> >>> Add compatibles for the DisplayPort and Embedded DisplayPort blocks in
> >>> Qualcomm SDM845 and SC8280XP platforms.
> >>>
> >>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >>> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> >>
> >> No need for quicinc SoB (unless you also take ownership).
> >>
> > 
> > It's my understanding that both needs to be there. Bjorn @ Linaro
> > authored the patch and the author must certify its origin, but as the
> > submitter I must certify its origin.
> 
> It's the same person. There are no two Bjorns (unless there are :) ), so
> you certify with old email. SoB chain is coming from people, not email
> addresses.
> 

IANAL, but I don't think it's the same person. I can't use my old
signature to certify the origin in a contribution today and I can't
claim authorship of something Linaro did.

> And it is not only my understanding of SoB chain.
> https://lore.kernel.org/all/YuKcBO5JatwRYQJ3@kroah.com/
> 

Again, IANAL, but I think the situation is different given AMD and
Xilinx relationship.

> > 
> > I'm not entirely sure what you mean about taking ownership, 
> 
> I meant you to be the author of the commit.
> 

As mentioned above, I can't do that.

Regards,
Bjorn

> > I am going
> > to pursue getting these patches landed. But it wouldn't be correct for
> > new me to claim I authored them.
> 
> Yeah, that's true.
> 
> 
> Best regards,
> Krzysztof
