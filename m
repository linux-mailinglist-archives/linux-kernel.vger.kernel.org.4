Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED11F653837
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 22:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbiLUVco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 16:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiLUVcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 16:32:41 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBC012A8E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 13:32:40 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id 21so11595445pfw.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 13:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MrBMXlM/PPucL2ewFp8ah2l3bi7uAYq0NzUMHnh5YoI=;
        b=pRNb0ldWbyMBo7VrEAvBmAT+yPI2hLPO0fYYHkAS9PNkHBEQmql77FkcG8c6cHtTXs
         LIDs90mEdA4kYXr06z6pv8Q6gkMgRgAs9+5yXvLOUDO1uBuLS3lTSn6pWr8f0/JgN5Tn
         P5Y83E+ai7bF/FCCZdEdAfbTsYUKf0K32/7OysyCLNLVy9iQwpC0poi2oW9cmMUTistt
         jCYpOJSpHbAnigX14r29F+d7XoaGHJI+Q9gqiyE8yRKXwlDcQNcVgB6qL2KhjlvdWzch
         2YwLEubM/P4sogocS7S9rZmk632faVL0H7psNswtIX4EeTRyBF8/oM7QylRpnDXSIm1C
         1SRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MrBMXlM/PPucL2ewFp8ah2l3bi7uAYq0NzUMHnh5YoI=;
        b=j5DK97OaEt57xjk1lKniYwlZAs8NF0dLDZUyCjLN4IBQo9wuQcRqlkBTnntfJ7aLPg
         q/QLyO6smD9mK6PQESUCnc5Tc7NZeY7WKXX7PYZ/WEvktp4sbUMWrT0+SG9ip2IBAhDv
         s7k9l9BSzP70VrvsK5lDtNAAbFCizEXrQckFSIozXgODHMAfH5H9z2o7JlCU9nEQGL5r
         /889ylKHiNoVcVf3ZGBIiIOmfcapmam0w7m57qPuahW+rFyP3uIX1zsREdsZ9PmMWFBQ
         Wuv0LY5O5DKrQwfbQ/3zmG9DVE48Uy1qTz2S/tukh6VW9wAzvJIUjf4IYGiiqihTfDmY
         7FIA==
X-Gm-Message-State: AFqh2krgQ4qzVn6AbWVA0/sI/TRKA0QH+t1T93o79d+oIQplriVfhlwR
        nDmypO9R3vWDSRv85tIlNdTJqOx0w7d1GOLKb0fJUw==
X-Google-Smtp-Source: AMrXdXsNBi8/ReLwjQzffiE6gznKI76a59rEhIrU/zCiqZylXSFp5D1KHj386Cvgn+Ab613xGEYChgmQa5IhgZRmGdc=
X-Received: by 2002:aa7:85d3:0:b0:577:599d:b2b7 with SMTP id
 z19-20020aa785d3000000b00577599db2b7mr234449pfn.25.1671658360171; Wed, 21 Dec
 2022 13:32:40 -0800 (PST)
MIME-Version: 1.0
References: <20220726200739.30017-1-semen.protsenko@linaro.org>
 <CGME20220726200747eucas1p226a18ed7760741ddaed94483ba1f9228@eucas1p2.samsung.com>
 <20220726200739.30017-2-semen.protsenko@linaro.org> <7e9e509a-0ef7-087d-e379-14fb58e3e14f@samsung.com>
 <CAPLW+4n-Lf6je61rxdJ9nJnX9h9F8F-y+qikG7eFF0avQpMV9Q@mail.gmail.com>
In-Reply-To: <CAPLW+4n-Lf6je61rxdJ9nJnX9h9F8F-y+qikG7eFF0avQpMV9Q@mail.gmail.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 21 Dec 2022 15:32:28 -0600
Message-ID: <CAPLW+4mPeX-cQR_oLKh+zPwEXuwfQtk2t2USP77C6Y9UmgYq_w@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu/exynos: Abstract getting the fault info
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On Mon, 24 Oct 2022 at 09:43, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> Hi Marek,
>
> On Fri, 12 Aug 2022 at 14:25, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> >
> > Hi Sam,
> >
>
> [snip]
>
> > > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> >
> > I'm not very happy with converting the sysmmu_fault_info arrays into the
> > decoding functions. If I got the code right, adding v7 is still possible
> > with the current approach. The main advantage of the array-based
> > approach is readability and keeping all the information together in a
> > single place.
> >
> > I agree for the items listed above as 'minor functional changes',
> > though. Those sysmmu_fault_info arrays might be a part of sysmmu hw
> > variant to avoid decoding hw version for each fault.
> >
> > I'm not sure that the linear scan is so problematic with regards to the
> > performance. You really don't want your drivers to trigger IOMMU fault
> > so often during normal operation. It is just a way to get some debugging
> > information or handle some exception.
> >
> > You mentioned that the transaction type is read from the separate
> > register in case of v7, but your code (here and in second patch) still
> > relies on the reported interrupt bits.
> >
> > Could you try to rework all your changes in a such way, that the
> > sysmmu_fault_info arrays are still used? V7 is really very similar to
> > the v5 already supported by the current driver.
> >
>
> That's actually how I implemented this patch on my first attempt.
> Really didn't like it, because a half of existing sysmmu_fault_info
> structure doesn't make sense for v7, and some functionality of v7 has
> to be implemented separately from that structure. I'd argue that
> previous abstraction is just broken, and doesn't work for all SysMMU
> versions anymore. It's easy to see how much difference between v5 and
> v7, just by looking at corresponding get_fault_info() functions I
> implemented. For example, the transaction type is probed from
> different registers using different version, etc. There is also the
> need to handle new VM/non-VM registers on v7. Also there is some extra
> functionality that will be added later, like multiple translation
> domains support, which is also quite different from how things done
> for v5.
>
> I'd show more specifics to demonstrate my statements above, but alas I
> already deleted my initial implementation (which was exactly what you
> suggest). This callback-style HAL seems to be a perfect choice, and I
> spent several days just experimenting with different approaches and
> seeing all pros and cons. And from my point of view, this way is the
> best for providing actual solid abstraction, which doesn't require
> adding any workarounds on top of that. I understand that my patch
> changes the very conception of how IRQ is handled in this driver, but
> I'm still convinced it's a proper way to do that for all v1/v5/v7,
> especially w.r.t. further v7 additions, to keep the abstraction solid.
> Not that I'm lazy and don't want to rework things :) But in this
> particular case I'd go with unchanged patches.
>
> Do you think it's reasonable to take this series as is? I can try and
> collect more particular code snippets to demonstrate my point, if you
> like.
>
> Thanks!
>

So, what do you think about this?

> [snip]
