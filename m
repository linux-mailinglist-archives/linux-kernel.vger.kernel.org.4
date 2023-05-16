Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3147050B9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbjEPO2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbjEPO2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:28:37 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2982E526E
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:28:31 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f38bea8be8so3737781e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1684247309; x=1686839309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOOZCXXP4LpksxHkg4nvdaIq0tmnRiTZx/elW7W7niI=;
        b=arVBo25pNBMxfPhoKYvltlB2Uawur/F4MwIhKfOR0W/WANPEJ4fkT9fZ9/Z+67DvC4
         PYkZ5qy1YsWJ2cSP3jNStIcHxio06VMqYxMIt9Bm7J6eRNLlkKTJ+ZQF3SZI5VsbCQd3
         rqAETBqGvxX4bPwjK+3MGw9NTSsRra04LPUHsz8jciXU0YhQ0HB2OvRipVMi7ek1okZk
         RAsQxXpyYyiPbFwi19FE0r55eKYoalQ0p9nbdnhjFMsctO4owxzAEyKYPAnPs83Rv/Ar
         SdYtn0w0UqI1dYILJ+yIfP8lZPB9XYe4HuDndSPPOw2dpNi0RZkKl3oRuIuF6XYpPhQS
         LCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684247309; x=1686839309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOOZCXXP4LpksxHkg4nvdaIq0tmnRiTZx/elW7W7niI=;
        b=hCQ0ozGWwm4oeUxFR+Dx0BoUXgUmXwgLAfU6oNNmjkE3THOTXclZl32E8a0Cim6Pah
         RiGj7u3o8UG74Cm+TyfjUStzQaTfsGRbyH1lDDEU5CPx6znnET5dnB/yclpn1ynCXSZh
         NmGoDWLT/9e3blMrAHBptdHFbCf60x7av/A6DI5DBtN6NpZ8SAUfQcOblfQD9bd73njz
         k+WAOhAnRklS2GqtPh+EC4FhwuvlTRE47saGnaQdIgwgCNQ3YxIv6OpYB7Q6PaANdGob
         yBIdfnBrh+qxjg1FHnYOmjYVUq5fPe/cKrnHdTyjCynD7U7afAblzzOzx/iSu7DcBKeJ
         sFgg==
X-Gm-Message-State: AC+VfDyoxoepNS90aZP760+eQkeD0Xy6zdm/mcSveVWn7jJwaa5GjYvQ
        b/h87BwT4/SePZvSVEttl/+WCaqLruwrjYWMjuPfIQ==
X-Google-Smtp-Source: ACHHUZ7c3hpAgVDEakFIgQTQp0miw0Pxe4R/I3dNmfZOb4bLnc8dYAsrTxAxvOzRqzhyH7uBZf87J9mRIW+Ood4BRJY=
X-Received: by 2002:a05:6512:90d:b0:4eb:e8e:4139 with SMTP id
 e13-20020a056512090d00b004eb0e8e4139mr6452092lft.2.1684247309388; Tue, 16 May
 2023 07:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230514090432.78217-1-bagasdotme@gmail.com> <20230514090432.78217-4-bagasdotme@gmail.com>
 <20230514-proposal-resort-3ce1beeaa089@spud>
In-Reply-To: <20230514-proposal-resort-3ce1beeaa089@spud>
From:   Andy Chiu <andy.chiu@sifive.com>
Date:   Tue, 16 May 2023 22:28:18 +0800
Message-ID: <CABgGipWt+ux3CJwotoG588MBqO1EeSV2E4mw8Kvm+d01WTPPzQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] Documentation: riscv: vector: Use bullet lists for
 prctl list
To:     Conor Dooley <conor@kernel.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux RISC-V <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Vincent Chen <vincent.chen@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bagas,

On Sun, May 14, 2023 at 5:49=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> Hey Bagas,
>
> On Sun, May 14, 2023 at 04:04:30PM +0700, Bagas Sanjaya wrote:
> > The documentation lists two userspace prctl() calls. Use bullet
> > lists for the listing.
> >
> > Fixes: 412c68cfeeb178 ("riscv: Add documentation for Vector")
>
> Firstly, these fixes commit hashes would not be stable as this series
> has been applied to riscv/for-next [1]. But also, from this commit
> onwards, things seem like stylistic comments that would be undeserving
> of a Fixes: tag to begin with.
> Perhaps you'd be better off suggesting these changes in response to the
> original thread [2], so that it goes in "correctly" in the first place?
> Andy has to re-submit anyway as there are a few bugs that crept in in
> the most recent revision of his series.
>
> Thanks,
> Conor.
>
> 1 - https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/log/?=
h=3Dfor-next
> 2 - https://lore.kernel.org/linux-riscv/20230509103033.11285-25-andy.chiu=
@sifive.com/
>
> > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > ---
> >  Documentation/riscv/vector.rst | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/riscv/vector.rst b/Documentation/riscv/vecto=
r.rst
> > index 178b3f3f452462..c7bd701c7963b6 100644
> > --- a/Documentation/riscv/vector.rst
> > +++ b/Documentation/riscv/vector.rst
> > @@ -13,7 +13,7 @@ order to support the use of the RISC-V Vector Extensi=
on.
> >  Two new prctl() calls are added to allow programs to manage the enable=
ment
> >  status for the use of Vector in userspace:
> >
> > -prctl(PR_RISCV_V_SET_CONTROL, unsigned long arg)
> > +* prctl(PR_RISCV_V_SET_CONTROL, unsigned long arg)
> >
> >      Sets the Vector enablement status of the calling thread, where the=
 control
> >      argument consists of two 2-bit enablement statuses and a bit for i=
nheritance
> > @@ -89,7 +89,7 @@ prctl(PR_RISCV_V_SET_CONTROL, unsigned long arg)
> >          * Every successful call overwrites a previous setting for the =
calling
> >            thread.
> >
> > -prctl(PR_RISCV_V_SET_CONTROL)
> > +* prctl(PR_RISCV_V_SET_CONTROL)
> >
> >      Gets the same Vector enablement status for the calling thread. Set=
ting for
> >      next execve() call and the inheritance bit are all OR-ed together.
> > --
> > An old man doll... just what I always wanted! - Clara
> >

Thanks for fixing the document. Do you mind if I merge them into my
patch and add you as a co-developer? I think merging those fixes into
the one original patch would be much cleaner than providing fix
patches afterward.

Thanks,
Andy
