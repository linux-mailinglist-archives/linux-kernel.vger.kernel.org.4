Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866B7692008
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 14:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjBJNqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 08:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjBJNqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 08:46:00 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C38973954;
        Fri, 10 Feb 2023 05:45:59 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 139so4940915ybe.3;
        Fri, 10 Feb 2023 05:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hB+mOJqD5Y0H3JYjXP2CcVgplj5XVV1e0fTBRG32UaQ=;
        b=WX5QCkNjdJQ8c0rOOlxK/JExQefxLbENbWB8LclIHqEilDbLyE+wQEKp/7P2huRAUr
         8i+AG2rbESwOr/sThtxE8/PEe4Gj+CMPqMMAody/v8RAr3/cx1mXKaHO9K/DUkRicQll
         7oMnIsjR5qJTMCC9OXk/jMLLWWZo03yHiIw7tkIiyRkx4rrkKyHw78e2ohOKjN3zn4f9
         /K0MU2yvOjVXBlIOyXllKDLm5yHdFJu9kYuddAoHxTQ1oblKI94r+hwths2m0P4boBzN
         rvrrZ8tcssXiFw6Q8azKfFkttRYJX8vsZnYac+VgR02320HCNxAEUutYslA4JTpTmBrn
         BDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hB+mOJqD5Y0H3JYjXP2CcVgplj5XVV1e0fTBRG32UaQ=;
        b=k9E6p9uFAFgUwQabbJlNFHXAAAW553IQZBsUuPVz6INdwGIqyPUy5KdJB6GnFlIrMH
         vq2IGxVXn11TEtvs9AbOayAXZDqsw41bmAO7fLHqTMQ0u5M2aipzS7Ityp9nGEAtHjzo
         y/URiBFbi2EeX70ePPtOjoTzo06F2xgLi7Vc/mQ0ch2zrnMA5YpQPRTpxctIxPeO09RW
         oIkbFeQbkb7XNrXvO4+gSOxpMHd2NHBsG09uCK8mFC4MA86apNtSQd8RXn4ZLytz7/xB
         PkW3BSMXd8MbPD3tA7fA0+CvMZyKej3p+KHDMYQOHsJGqQBXrJLUD2cWJpIJm2UagIld
         w3eQ==
X-Gm-Message-State: AO0yUKWKNx0XJ5BbMYoVZVq9DPkKTIoo6IsOxN9v+tDvgSGHqGCJrTBe
        iBAw8yqA0hZyP3cNXgXldhICgXvlb6HVUzJnbrU=
X-Google-Smtp-Source: AK7set9p/mFPR8AIII7jz3WOMjkRUH0Ch3Js3xuR613P1LexlUXemUWuB53vPhLb9B1ej5nch2AYNjVrD/5+KoHTKps=
X-Received: by 2002:a5b:d09:0:b0:8a0:96fa:f8f1 with SMTP id
 y9-20020a5b0d09000000b008a096faf8f1mr1722831ybp.535.1676036758352; Fri, 10
 Feb 2023 05:45:58 -0800 (PST)
MIME-Version: 1.0
References: <20230206002136.29401-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdUXXrYPcNiD3M_ONjX2Jn16KKXdY=4JMqJbm9F=9GMBvA@mail.gmail.com>
In-Reply-To: <CAMuHMdUXXrYPcNiD3M_ONjX2Jn16KKXdY=4JMqJbm9F=9GMBvA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 10 Feb 2023 13:45:32 +0000
Message-ID: <CA+V-a8uWyCrziE2+LNy7jK0hU-5bKUC2i++oQqEt8qoqwjm07Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: Drop specifying the
 GIC_CPU_MASK_SIMPLE() for GICv3 systems
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Geert,

Thank you for the review.

On Fri, Feb 10, 2023 at 11:10 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Feb 6, 2023 at 1:28 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > The GICv3 interrupts binding does not have a cpumask. The CPU mask only
> > applies to pre-GICv3. So just drop using them from GICv3 systems.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-devel for v6.4...
>
> > ---
> > Note, this patch applies on top of [0]
> >
> > [0] https://patchwork.kernel.org/project/linux-renesas-soc/cover/20230131223529.11905-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>
> As this patch is a fix, I think it makes sense to drop that dependency.
>
Agreed.

> So I'll do
>
>     git show -- arch/arm64/boot/dts/renesas/r9a07g044.dtsi | sed -e
> 's/044/054/g' | patch -p1 && git commit -a --amend
>
Hmm that's something new for me to learn!

> while applying.
>
Thanks.

Cheers,
Prabhakar
