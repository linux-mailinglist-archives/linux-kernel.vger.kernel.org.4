Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EEB676938
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 21:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjAUU2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 15:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjAUU2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 15:28:51 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A8425290
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 12:28:50 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id x2-20020a17090a46c200b002295ca9855aso12123844pjg.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 12:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kw+rDkNLwBsHFPfuOub9wI9lZiy1N7CBbHJRkBpxch8=;
        b=uj04C5rq2HjGK4mocBeuyHigZm14p9ZqcCckQCU1cTRSa6fr0EoYvULkjcESCJ4yCl
         ys7VdkOe807LUnydqRfFWS4x2Bp/6BU7oFVzv/sInJ52cttWu5Wa4yxhrgDoaC2i97a/
         T+qeq6NvFNwRiYlk4vvW626U2waJoKILRigKjcULzSFv2pEARduoYYtUX4zfuKzbQOTR
         Ju21NqPCsc72wTMu8Yw6rlVrEwe2qTCtnk097gNrpZF9OjOzDb61wgUgl5+hl/LV87ay
         YzLJyfjGzw4VI7Y+FJo/VX2BUuhJ0jiK4x2MHpJm6l07oq9KfserrnIZN5f6trlo5GWP
         RCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kw+rDkNLwBsHFPfuOub9wI9lZiy1N7CBbHJRkBpxch8=;
        b=D/F0ENQxtH0vhvW74fRz/Xd/rl5a82yPCM1IZGCh3Uv0wvhLRsTrkBH3uYZK2iWQds
         mIYhxnd1Fwm5M82F0jZxcAZWAXpPmkeIfogUZIipBafw9VIWjTrkbn9kVravICIx5dkx
         wnohw6beV+XQ8ltUvUU99jdgGcpDcWuHdIdjSLNA084Cks2vbqchlcby7IGCKrb2DA35
         thPwSr68Jcq/3QvuzhdjuzcV5Q2PbNjamYoFq3yEXqajqQu3GTPEbvmQ/e6ELYpZCY2S
         +hxTfeCUAcjyBzJrRqs2O6kGdWlCahIRhz3VDiCqeDkmvmABRBZIAQxmnJQN9actb1uH
         N5WA==
X-Gm-Message-State: AFqh2kpIPK2gVGB6Pl1nd54xCxVYHoW6BAKSuoLniiETNskvMF3EXzVN
        SHAg8Dar1SGymgQ+6MkT3YcFDbh2l5ulG5kjxrd+Tg==
X-Google-Smtp-Source: AMrXdXsEMvpIDmBk7ijUINDgglFo5IRfBMJQj2Q2J3zetJqNnPQjmSL7Y96Y2YoTBR+Uh4mML/nFFQ4lRYAdEkKDfuQ=
X-Received: by 2002:a17:90b:3711:b0:226:197:63fd with SMTP id
 mg17-20020a17090b371100b00226019763fdmr1915508pjb.55.1674332929525; Sat, 21
 Jan 2023 12:28:49 -0800 (PST)
MIME-Version: 1.0
References: <20220726200739.30017-1-semen.protsenko@linaro.org>
 <CGME20220726200747eucas1p226a18ed7760741ddaed94483ba1f9228@eucas1p2.samsung.com>
 <20220726200739.30017-2-semen.protsenko@linaro.org> <7e9e509a-0ef7-087d-e379-14fb58e3e14f@samsung.com>
 <CAPLW+4n-Lf6je61rxdJ9nJnX9h9F8F-y+qikG7eFF0avQpMV9Q@mail.gmail.com>
 <CAPLW+4mPeX-cQR_oLKh+zPwEXuwfQtk2t2USP77C6Y9UmgYq_w@mail.gmail.com>
 <3751c425-aefa-a3b4-62f4-53d7e369bc1e@samsung.com> <CAPLW+4=-cqQPmQi57_ARn1C6LqK+LffrFEgLqi6Lwb=YJ7sRSw@mail.gmail.com>
 <5757a45f-0685-a82b-edd6-ae5c98781ad3@samsung.com>
In-Reply-To: <5757a45f-0685-a82b-edd6-ae5c98781ad3@samsung.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Sat, 21 Jan 2023 14:28:37 -0600
Message-ID: <CAPLW+4==df_3KjLG5-5As-1HB11q3j55JmGwBCv0XqbYiB8ieg@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu/exynos: Abstract getting the fault info
To:     Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On Thu, 22 Dec 2022 at 09:34, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> On 22.12.2022 16:23, Sam Protsenko wrote:
> > On Thu, 22 Dec 2022 at 07:20, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> >
> > [snip]
> >
> >>> So, what do you think about this?
> >> Okay, go ahead with your approach. If I find a better way, I will rework
> >> it then. I would just like to have the code for fault handling for hw
> >> v1, v5 and v7 similar as much as possible.
> >>
> > Thanks, Marek!
> >
> > Joerg, can you please apply this series? Please let me know if I need
> > to rebase it first, but I guess there shouldn't be any issues, the
> > SysMMU driver doesn't seem to get updated often.
>
> Just to makes things a bit more formal - feel free to add:
>
> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
>

Can you please apply this series?

Thanks!


> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
