Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538537146C4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 10:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjE2I7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 04:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjE2I7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 04:59:02 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF65B8
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 01:59:00 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-568af2f6454so632507b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 01:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685350740; x=1687942740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7G8mSY6cwpEBtIRdyLb1Wuow1MtdS79EJRALhFSrT0=;
        b=uElgLj1CK0yPJ2Kf7KZKbIWZYEHqi7BL5MPBvGOPuBrjvhwOfO9zy0dGoU6c6Y9zSs
         oUoga3lxKCF475XPBPA1wwHFNgQRfKQ/pEC5sqdNYLXfwOC5+sA564GtKi06HJAUsZ2r
         9IJLUC/4v9d/59dqzapGMKWrFBIfwwl07tEZEvuzYQT4XHWhPOMq3/VtOW/HXZnajlJV
         9epEh2bUdaMPpkJ1Gno7R1ZYyyKGXZC2L0j5FQWXlwLKnif9HbTfiWErVa9mmqYlnW3p
         URBaZG2XqMn3Ua3EcWYEHe6Zd5gD0TVueDGxYRdIl59++wjgXLL4wRUi6jKhC9FsRhHm
         Ie0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685350740; x=1687942740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q7G8mSY6cwpEBtIRdyLb1Wuow1MtdS79EJRALhFSrT0=;
        b=G7942aM/hW19hQsCSSk/DiPlzK18G+JvO6kFH4dPGIYBcG0j/M2jdeMWZVT9U7dmUe
         TJ1V4iuJbglPO9we8yUrSFHVk57++W1XFq4pSu8eDUK5DWKXIWa9MOykJjJoHK9G9j4f
         X6p8qwVbedsYsAAKAvkkC0TppoG+5IEDA8VDFMdNGURWI8AH3TEG3+yXXikzz9gmD2a5
         GhqYr6dmzLb4xCTPPFU4LcrX0q0E3VjJlITngjRftczgbUdBvkStzSLcfrELyWK4Cjhx
         rqlXlrjjc8WI0uW6TatLLZrQvHjHbs0xOyH3eK7z6sVZ4q8A04l3TZWbRRiLHQExtQzC
         17mg==
X-Gm-Message-State: AC+VfDwk17/Ic0QXcL7QwfgrpqaKNBPHVGZeqjvmLax/ohf6IKZDqG0H
        wQknTgEwb2JOrf2kQvm6UugCJWdR1phuhtrJBO2IVg==
X-Google-Smtp-Source: ACHHUZ63Fxmgf6gqJCKJfHyBl4a3uclUlTCg9MXLYGktGp1bmcog4uxx4rP9WY2QpDtM005V/iQHD18IapytTSodY0I=
X-Received: by 2002:a25:d890:0:b0:b9a:7693:93f7 with SMTP id
 p138-20020a25d890000000b00b9a769393f7mr10172830ybg.45.1685350739795; Mon, 29
 May 2023 01:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230424110933.3908-1-quic_mkshah@quicinc.com>
 <CAPDyKFqSY9HJgKwuOqJPU5aA=wcAtDp91s0hkQye+dm=Wk=YDQ@mail.gmail.com> <20230525024546.ug6nbrmkgx2alerc@ripper>
In-Reply-To: <20230525024546.ug6nbrmkgx2alerc@ripper>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 29 May 2023 10:58:23 +0200
Message-ID: <CAPDyKFrzHHz+c_y787TVKLGizA3vVfKvnu+uJ1JC+itgryfdSQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Use PSCI OS initiated mode for sc7280
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Maulik Shah <quic_mkshah@quicinc.com>, dianders@chromium.org,
        swboyd@chromium.org, wingers@google.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com,
        jwerner@chromium.org, quic_lsrao@quicinc.com,
        quic_rjendra@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2023 at 04:41, Bjorn Andersson <andersson@kernel.org> wrote:
>
> On Wed, May 24, 2023 at 11:56:28AM +0200, Ulf Hansson wrote:
> > On Mon, 24 Apr 2023 at 13:09, Maulik Shah <quic_mkshah@quicinc.com> wrote:
> > >
> > > Changes in v4:
> > > - Add missing s-o-b line and reviewed by in patch 1
> > > - Address ulf's comments for error handling in patch 2
> > >
> > > Changes in v3:
> > > - Add new change to provide helper function dt_idle_pd_remove_topology()
> > > - Address ulf's comments for error handling
> > > - Add reviewed by ulf for devicetree change
> > >
> > > Changes in v2:
> > > - Add new change to Move enabling OSI mode after power domains creation
> > > - Fix compatible string to domains-idle-states for cluster idle state.
> > > - Update cover letter with some more details on OSI and PC mode
> > >   comparision
> > >
> > > The dependency [2] is now merged in trustedfirmware project.
> > >
> > > Stats comparision between OSI and PC mode are captured at [3] with
> > > usecase
> > > details, where during multiple CPUs online the residency in cluster idle
> > > state is better with OSI and also inline with single CPU mode. In PC
> > > mode
> > > with multiple CPUs cluster idle state residency is dropping compare to
> > > single CPU mode.
> > >
> > > Recording of this meeting is also available at [4].
> > >
> > > This change adds power-domains for cpuidle states to use PSCI OS
> > > initiated mode for sc7280.
> > >
> > > This change depends on external project changes [1] & [2] which are
> > > under review/discussion to add PSCI os-initiated support in Arm Trusted
> > > Firmware.
> > >
> > > I can update here once the dependency are in and change is ready to
> > > merge.
> > >
> > > [1] https://review.trustedfirmware.org/q/topic:psci-osi
> > > [2] https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/19487
> > > [3] https://www.trustedfirmware.org/docs/PSCI-OS-initiated.pdf
> > > [4] https://www.trustedfirmware.org/meetings/tf-a-technical-forum
> > >
> > > Maulik Shah (3):
> > >   cpuidle: dt_idle_genpd: Add helper function to remove genpd topology
> > >   cpuidle: psci: Move enabling OSI mode after power domains creation
> > >   arm64: dts: qcom: sc7280: Add power-domains for cpuidle states
> > >
> > >  arch/arm64/boot/dts/qcom/sc7280.dtsi  | 98 ++++++++++++++++++++-------
> > >  drivers/cpuidle/cpuidle-psci-domain.c | 39 ++++-------
> > >  drivers/cpuidle/dt_idle_genpd.c       | 24 +++++++
> > >  drivers/cpuidle/dt_idle_genpd.h       |  7 ++
> > >  4 files changed, 117 insertions(+), 51 deletions(-)
> > >
> >
> > Looks like this series has not been queued up yet. Note that patch1
> > and patch2 are needed for stable kernels too. Moreover, patch3 (Qcom
> > DTS change) is dependent on patch 1 and patch2.
> >
> > Therefore I suggest Bjorn to pick this up via the Qcom SoC tree.
> > Bjorn, is that okay for you?
> >
>
> Sorry, this fell between the chairs after you pointed me to it...
>
> I can certainly pick the 3 patches through my tree, but are they fixing
> any current regressions, or is it just that we need the first two
> patches to land before the 3rd patch?

I am not aware of any current regressions.

>
> I also presume the 3rd patch is only needed when paired with the new
> ATF?

Patch3 is beneficial to use with a new TF-A, but works with an old
TF-A too. Anyway, forget what I said about patch3 earlier, as that was
just not the complete information.

The problem is that we can't be using a new TF-A (supporting both PSCI
OSI and PC mode) without patch1 and patch2, unless we are using
patch3.

Thus, I strongly suggest we tag patch1 and patch2 for stable kernels,
to avoid any potential conflicts of TF-A versions that may be used.

>
> Regards,
> Bjorn

Did that make more sense?

Br
Uffe
