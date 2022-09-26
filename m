Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8FA5EAC65
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbiIZQYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbiIZQYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:24:12 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583A06B8F8;
        Mon, 26 Sep 2022 08:13:04 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-127dca21a7dso9583793fac.12;
        Mon, 26 Sep 2022 08:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=N5zD8itGsjXgN7u5GbMQZZht7UZJCrojZyw1yQR9ywk=;
        b=wDFTKBG6q+2eac+VlhaX4M6N5IxXQ6aEQrxHcXSsCh7PrcZb1tH8bRTGgie+cvEHWe
         Az82WmMT6zYu489KS7Dv+OWjyzF8SWf6mHfalbaF7qnemetfyqfSyts1nwPkVyBt1QoH
         ICro/NCZwIuAjjKCZLM4FL2f7f2NdQYivlr5/gcn4xCJZWKgQxyo+ddKC+wgmlH1CP/L
         qvw/1qhkzvQ3M0o46chFBBeXty/4n0hfEuwQ3jRr7L5WjdbSfXSdNtTwZHdi4V/NXTz1
         lIwwJmK6fBIAn6M8gTQI8jDp/pfSZw11FwZ2nT4TnrinknVsCFy95cmTPtjK9H3bX6V/
         xJEw==
X-Gm-Message-State: ACrzQf1PBSXv6xn3MY5NapH4wNx1ts8neJocmmzbzKOtxaIcjS6Pa7dW
        avk0ntaQk21XxzBHmoJ7gA==
X-Google-Smtp-Source: AMsMyM4o9ytcOGwlT69mDGuQ5FCedY8pZACfPmctgBWZL50ej+sPLaNEuq93Q1Vl05KIUqsS8B5VBw==
X-Received: by 2002:a05:6870:828f:b0:126:19ae:68d9 with SMTP id q15-20020a056870828f00b0012619ae68d9mr19095618oae.116.1664205183361;
        Mon, 26 Sep 2022 08:13:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l25-20020a9d6a99000000b0063695ad0cbesm7961315otq.66.2022.09.26.08.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 08:13:02 -0700 (PDT)
Received: (nullmailer pid 1929738 invoked by uid 1000);
        Mon, 26 Sep 2022 15:13:02 -0000
Date:   Mon, 26 Sep 2022 10:13:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] dt-bindings: msm/dp: Add SDM845 and SC8280XP
 compatibles
Message-ID: <20220926151302.GA1880039-robh@kernel.org>
References: <20220916200028.25009-1-quic_bjorande@quicinc.com>
 <20220916200028.25009-2-quic_bjorande@quicinc.com>
 <1641e41c-08c7-859b-644a-28d966fb00f3@linaro.org>
 <20220919211832.6b3buqxrnfp6yjjg@builder.lan>
 <6b242b44-b657-c7a6-63ca-465c7031376f@linaro.org>
 <20220922001429.zqfap3clprvlo6jo@builder.lan>
 <acd9ff20-a07b-05ab-6f4b-34e3e8b1cae8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acd9ff20-a07b-05ab-6f4b-34e3e8b1cae8@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 05:37:39PM +0200, Krzysztof Kozlowski wrote:
> On 22/09/2022 02:14, Bjorn Andersson wrote:
> > On Tue, Sep 20, 2022 at 09:09:13AM +0200, Krzysztof Kozlowski wrote:
> >> On 19/09/2022 23:18, Bjorn Andersson wrote:
> >>> On Sat, Sep 17, 2022 at 06:03:27PM +0100, Krzysztof Kozlowski wrote:
> >>>> On 16/09/2022 21:00, Bjorn Andersson wrote:
> >>>>> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> >>>>>
> >>>>> Add compatibles for the DisplayPort and Embedded DisplayPort blocks in
> >>>>> Qualcomm SDM845 and SC8280XP platforms.
> >>>>>
> >>>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >>>>> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> >>>>
> >>>> No need for quicinc SoB (unless you also take ownership).
> >>>>
> >>>
> >>> It's my understanding that both needs to be there. Bjorn @ Linaro
> >>> authored the patch and the author must certify its origin, but as the
> >>> submitter I must certify its origin.
> >>
> >> It's the same person. There are no two Bjorns (unless there are :) ), so
> >> you certify with old email. SoB chain is coming from people, not email
> >> addresses.
> >>
> > 
> > IANAL, but I don't think it's the same person. I can't use my old
> > signature to certify the origin in a contribution today and I can't
> > claim authorship of something Linaro did.
> 
> Fine with me.
> 
> > 
> >> And it is not only my understanding of SoB chain.
> >> https://lore.kernel.org/all/YuKcBO5JatwRYQJ3@kroah.com/
> >>
> > 
> > Again, IANAL, but I think the situation is different given AMD and
> > Xilinx relationship.
> 
> Hm, I am not sure how it is different. We might know or we might know
> the change of ownership. Maybe the change of owner came with copyrights,
> maybe not (someone else bought them). I don't know, there can be many
> cases here. I interpret Greg's point there as in SoB statement - the
> person, not email address, certifies.

If Bjorn owned the copyright, then yeah, 1 email would be enough. But 
Linaro owned the copyright so it should be there.

Rob
