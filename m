Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A8A67FB5D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 23:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbjA1WbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 17:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjA1WbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 17:31:12 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E8123866;
        Sat, 28 Jan 2023 14:31:09 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id m199so10094121ybm.4;
        Sat, 28 Jan 2023 14:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gq3UXuY96IZ2a/ozeYCG10SAJUx0PEg/adXlBHwr8e8=;
        b=eIAhUQ1nNA2M/sdDSFQfpRPBbPGWVJPKwENHe8GqyOMTuJ0pn2A6rJwnWzb2Pgqf4C
         YlmZn3aSHmJPt5bTI0DTwBTn1WVi0/NsrsdaIqesNY+ZgOsQwRc84bXIbxEWj3+ByORK
         wjgF6OU5a6RXvg1M08LkTpbFdXkpKn4tYYh1UeGewKSUdKRpKBIxClmbPLGn2bLKglul
         b0KMJyqWdrJgNTW5RFtiN6Yw61eXu1pPm9qQn11v2M3h8lamlvDjgSq+6nBBwzdVPawD
         qggCVJgytLQp4g8zCJqAJjLuJUlxO+ZoxfIr9+s9yIeldOXV2iVHPJgnQdqjtUNP8K+v
         GOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gq3UXuY96IZ2a/ozeYCG10SAJUx0PEg/adXlBHwr8e8=;
        b=gOFx9uUjaqgoRj4+5eqLiyt6zirUR3/2MPFqCJXngTTggzM09X2RoDWtWRwZc5x03m
         WcYBB4b1bxgUHvsrTsAIwkrwNxhV+jmdqZ3/UGFhLSHeu2mJKQV1gGUisL6JB3dNppbK
         xNKF0oo18/AYSm++VcqtWh4AX711WwCdeHeAHN03RaSmG7dF4RwSiyLBPhKi93uSD4E4
         bODJJBAbAW8GOU7oAQMG4OHfjRX57yeGvN7ErqYXv6/WTy1sjbW/0fRfy/W3ASgtn5r1
         aqVzo5cYwOTM1/0ZBj6eHiyh1NT/aVc8ftrWvkgQScjsZEcELq+J1qGA+lW6kTz1ajBB
         spFQ==
X-Gm-Message-State: AFqh2kroCwuwb/3Cz8dRxtwyQpPvwgmyvAjrlT+sPxHOsceWf2rAS7JJ
        8aM+HiR5N0b7HAjUqDCiT7KSfEpfMBGMTQD3678=
X-Google-Smtp-Source: AMrXdXudUBRygvpqBA/djU59Mnt9ZklHyflmHzzXm8ltVAxQCE0xGNZEx4bYcQEUYVA7PBOG5YuKBN2fHYVKxY9tJm0=
X-Received: by 2002:a25:8d03:0:b0:7bb:3a71:263d with SMTP id
 n3-20020a258d03000000b007bb3a71263dmr2993234ybl.425.1674945068778; Sat, 28
 Jan 2023 14:31:08 -0800 (PST)
MIME-Version: 1.0
References: <20230128055214.33648-1-jamiemdouglass@gmail.com> <f8590655-3869-d905-ebad-347b8c9ae8dd@linaro.org>
In-Reply-To: <f8590655-3869-d905-ebad-347b8c9ae8dd@linaro.org>
From:   Jamie Douglass <jamiemdouglass@gmail.com>
Date:   Sun, 29 Jan 2023 09:30:57 +1100
Message-ID: <CAETzdaEjfCbaGj8UeBsAZGbZnvOHgMP9KTCyxsY46qL5MxUhzg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: msm8992-lg-bullhead: Correct memory
 overlap with SMEM region
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Petr Vorel <petr.vorel@gmail.com>,
        Dominik Kobinski <dominikkobinski314@gmail.com>,
        Konrad Dybico <konrad.dybico@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies, I completely forgot that I did that!

That change was necessary, because extending the reserved region
past 0x7000000 creates another memory overlap, this time with the
mpss_mem region:
               OF: reserved mem: OVERLAP DETECTED!
               reserved@6c00000 (0x0000000006c00000--0x0000000007200000)
               overlaps with memory@7000000
               (0x0000000007000000--0x000000000ca00000)

So my original patch is correct.

Thanks,
Jamie


On Sun, 29 Jan 2023 at 01:30, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 28.01.2023 06:52, Jamie Douglass wrote:
> > A previously committed reserved memory region was overlapping with the
> > SMEM memory region, causing an error message in dmesg:
> >       OF: reserved mem: OVERLAP DETECTED!
> >       reserved@5000000 (0x0000000005000000--0x0000000007200000)
> >       overlaps with smem_region@6a00000
> >       (0x0000000006a00000--0x0000000006c00000)
> > This patch splits the previous reserved memory region into two
> > reserved sections either side of the SMEM memory region.
> >
> > Signed-off-by: Jamie Douglass <jamiemdouglass@gmail.com>
> > ---
> >  arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi b/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi
> > index 79de9cc395c4..5e375ea73c79 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi
> > @@ -53,8 +53,13 @@ cont_splash_mem: memory@3400000 {
> >                       no-map;
> >               };
> >
> > -             removed_region: reserved@5000000 {
> > -                     reg = <0 0x05000000 0 0x2200000>;
> > +             reserved@5000000 {
> > +                     reg = <0x0 0x05000000 0x0 0x1a00000>;
> > +                     no-map;
> > +             };
> > +
> > +             reserved@6c00000 {
> > +                     reg = <0x0 0x06c00000 0x0 0x400000>;
> I think you made this 0x200000 too small, unless there
> is supposed to be functional change.
>
> Konrad
> >                       no-map;
> >               };
> >       };
