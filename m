Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BCF617D66
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiKCNFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiKCNEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:04:43 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD1BCEC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:03:20 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso1717699pjc.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 06:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sCUBB08PoVZ26bcT4Cxprl0+CgnyFaSro8o/etFxILQ=;
        b=NMOF7LMrwGZkM4Tpc29C7h3cTqZFKOVJ3vIia5vjFEJJ4H7B5PBOcPyzkq455HN7gk
         FTmv3c9jmCde5kxbFdR10ZoLz4a0JGb7Znsy/G7IW3aeadZOKKCIwmKa6neDPb/+PMlQ
         G5q3pQ/DzKlFHkwEqE1EWRBb8h1BN/hw2oOsWTTcIxbTC8Rbh0h6JO5zsVlRMtfDcPmG
         EwsBA48uyosKZ2jbVe5iAc8agQJkePiVass7YVRzKWxPROkBwJrrtbt0YtPlspLlftVk
         CaAE3bU5N7T2BznUtAq+AbzJjt2hmk0sVJOfygsa2zvm6OklRDJ4p1kusTQunUxAS2Uc
         +2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sCUBB08PoVZ26bcT4Cxprl0+CgnyFaSro8o/etFxILQ=;
        b=tetYgbxqwt3vS7IkYBQG9zyC9UGgUj4nM36kwSPi0cMZQvDNZbcfR2AUmX4xBXhs1o
         i3Er6mNcFQeGYnpZza7NthOux6asAi3q52kNGrzGViYWoOZcJJAX78REXSVaxwmgofgP
         i7CGHeyphsTva1cLuiyoaiUtFGs+JAiW597ECbU/zIvXTVi9WK6mv0dbfunVhdJp/IzP
         Hr1UIpMxPNCUXhr22rE9y7UVRhhbuAJCYttj2eJz9pJCHFDfHO/ImSeL2bu4p21w5EYU
         ubBNw5S0QMz/J8bPe/AIG5oDinObITPnzCTh919DTZMb1LIbj7mLvdChBl1UNbl0oBeW
         pGnA==
X-Gm-Message-State: ACrzQf3TSMMcTgtQ3Omn2Wo1Yr4RPDbq4S/yzxH3QvMwA6SLzjHgLPse
        6uTYH4dlzwjX/+T9+1bRChzJ8dc+iDZmXjpT0OcyUA==
X-Google-Smtp-Source: AMsMyM7FZiZCLkFDkx1bnVpjXpomckekbyKXpexKWDuVwHGpOCtLDD7blXzZ7m7RqCbEnHJAeDZqypgjZcrJQy4UliA=
X-Received: by 2002:a17:903:41cc:b0:186:b756:a5f0 with SMTP id
 u12-20020a17090341cc00b00186b756a5f0mr30145351ple.132.1667480600358; Thu, 03
 Nov 2022 06:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221028191243.31721-1-semen.protsenko@linaro.org>
 <CGME20221028191256eucas1p1a4fd95cbcc44959fa968956a92738f03@eucas1p1.samsung.com>
 <20221028191243.31721-4-semen.protsenko@linaro.org> <7ed8c884-cee1-7cb0-f2ce-f7ec156cd841@samsung.com>
In-Reply-To: <7ed8c884-cee1-7cb0-f2ce-f7ec156cd841@samsung.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 3 Nov 2022 14:03:08 +0100
Message-ID: <CAPLW+4nrns9BovWCTOsi3F7=2FWLi2sK0+Cid4Cva2Vs2ZWdqQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] iommu/exynos: Modularize the driver
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

[snip]

> MODULE_DEVICE_TABLE(of, sysmmu_of_match); is missing, so the driver
> won't be automatically loaded, what breaks its operation if compiled as
> module.
>

Right, didn't think about hot-plug case. Will add
MODULE_DEVICE_TABLE() along with MODULE_ALIAS() in v2, thanks.

> Also Exynos DRM and S5P-MFC drivers rely on the Exynos IOMMU being
> built-in, so they need to be adjusted for modularized builds too imho,
> at least in the Kconfig dependency.
>

Sure, I'll check all Kconfigs and defconfigs before sending out v2.

Btw, can you please also check my most recent reply [1] for the
"[PATCH 1/2] iommu/exynos: Abstract getting the fault info"?

[1] https://lore.kernel.org/lkml/CAPLW+4n-Lf6je61rxdJ9nJnX9h9F8F-y+qikG7eFF0avQpMV9Q@mail.gmail.com/

Thanks!

[snip]
