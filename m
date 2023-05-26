Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A83F71293B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243954AbjEZPSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237050AbjEZPSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:18:01 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B021EE7
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:18:00 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-96fbc74fbf1so148060966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20221208.gappssmtp.com; s=20221208; t=1685114279; x=1687706279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sd+Dqbtp7qNkmD7ajxLTDaj4AydWZwx3n13Wvgc7GFs=;
        b=TRHNHAAR6c1NlEv/sGYH1HA06wpmtw1E4UZ90c07jFTP1sVRLv1Jrof9UjKetX5ZkQ
         ze2mFYeXe+O+qNKCluJbQmhNyUfuW8hnf7DoNBOVME4k9tlA+MJaQC6jv5wkyWn0TREW
         zTPvIOm+ziJ77lNzncoyzYWHB5sIC5H1TPvavJPgDDzFyFZeMHY8mzzgWG4JoC2I8zky
         YCLnVsuCjdpMVgRgE8yTjN0U/lraQpoHD44hNQSp1XDVy/P+yIclNzAhhXuhzfY7sngJ
         riRi/IvdV/G1sX0RbULMNqAwEIJgP+os7FAWAEs6bMetrwR2UpfxmWshperLPxPM9RTs
         X1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685114279; x=1687706279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sd+Dqbtp7qNkmD7ajxLTDaj4AydWZwx3n13Wvgc7GFs=;
        b=K/giS7wv//W+2l7L0wiZT0ZiD5/GnuJUkgNhIAFcT6jYlqgHTYEhQMcICVOSzRwzYf
         ImtDZPODgpJp68uKC/zFpFGeIVUlkzEIvYRBjCoYwlF/2tvF5VR/Ny+TACXx6+dz2wwG
         8Ga6KCjVtCvZ+AahHYYG5eOEaufA5OnBISoyKRjqfdPvt/+LyFViQF6nCFIn5p7LiQQ1
         j5q7G/MxKfQYW5ubmr1Ytzl/zObikGRrOXw9jj9xUi8C8Sn7VGr8Hg0/AaBjSwxq1arQ
         R5N02kgK/4Xqq/lRQPJfgcDJIMXrld6vKA31qWcxTe6RurW3gMAaHljlJXrfA5YWLaco
         mTOg==
X-Gm-Message-State: AC+VfDz6w7iqwAQwBxHHyh8tF0wufs2Wqhzn3HARObG4gsw1AEOevGyI
        VUENfSgzSUe5Wjq7o8emWk8TXQSaXIvhkHUotUFEHQ==
X-Google-Smtp-Source: ACHHUZ5LynO2GJiwmoeAQI5/buwE8oRlwAL8Srf5qC3wN/oPJW8SyryyE6aZMB0q9lTrjXtGQtrDsuFBKljZsrNW58Y=
X-Received: by 2002:a17:907:7f8e:b0:933:4d37:82b2 with SMTP id
 qk14-20020a1709077f8e00b009334d3782b2mr2787208ejc.57.1685114279026; Fri, 26
 May 2023 08:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230525-shrapnel-precut-26500fca4a48@wendy> <CAAhSdy3SqeLdAfaojUki=ht21nr4ZUPMkW_t9M6ntQCt6Ds4Nw@mail.gmail.com>
 <20230525-citric-waged-a2f78d27eb0c@wendy> <CAOnJCULfC0jmiucLNMeJZwJf4QbGAN6r4B-ubUbP16KVpxrCfA@mail.gmail.com>
 <20230525-flaring-trading-f2bf0713ae26@spud> <CAOnJCUK_EgX-En1QNS8yX1WA1nj8w2kpvXMQcvgWuR3dvzEQYw@mail.gmail.com>
 <20230525-desecrate-imposing-d97ab34e06ad@spud> <CAOnJCUKfRv68Bh8ue=ZhMGxai9_UEHLpm3553g2c2NXh-RP-TQ@mail.gmail.com>
 <20230525-batting-botch-7e03393a2d97@spud> <CAHVXubiDezbwZO6X2btvgpq-XqHnxZjXzaMnSK2YrHc_ioLx8Q@mail.gmail.com>
 <20230526-steep-omen-a5a46a1086bf@spud> <f82e7d3d-a16d-593e-7513-753b5cbf28af@ghiti.fr>
In-Reply-To: <f82e7d3d-a16d-593e-7513-753b5cbf28af@ghiti.fr>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 26 May 2023 20:47:46 +0530
Message-ID: <CAAhSdy0_XqiB=1w3hnYkipPj1aF_D=z=MD2fKLxk6rb_iDdBow@mail.gmail.com>
Subject: Re: Bug report: kernel paniced when system hibernates
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Conor Dooley <conor@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Atish Patra <atishp@atishpatra.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>, robh@kernel.org,
        jeeheng.sia@starfivetech.com, linux-kernel@vger.kernel.org,
        palmer@rivosinc.com, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Song Shuai <suagrfillet@gmail.com>,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 8:42=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
>
> On 26/05/2023 16:59, Conor Dooley wrote:
> > On Fri, May 26, 2023 at 03:14:33PM +0200, Alexandre Ghiti wrote:
> >> Hi everyone,
> >>
> >> On Thu, May 25, 2023 at 11:24=E2=80=AFPM Conor Dooley <conor@kernel.or=
g> wrote:
> >>> On Thu, May 25, 2023 at 01:06:04PM -0700, Atish Patra wrote:
> >>>> On Thu, May 25, 2023 at 11:39=E2=80=AFAM Conor Dooley <conor@kernel.=
org> wrote:
> >>>>> On Thu, May 25, 2023 at 11:37:40AM -0700, Atish Patra wrote:
> >>>>>
> >>>>>> Any testing of hibernation still needs to revert the patch until w=
e
> >>>>>> have the proper fix.
> >>>>> "the patch" is what exactly? I assume you don't mean depending on
> >>>>> NONPORTABLE, since that is a Kconfig option.
> >>>> Nope. Sorry I meant the commit
> >>>>
> >>>> 3335068 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
> >>> Ah, if your SBI implementation is one of the affected ones, yeah.
> >>> If not, you can just set NONPORTABLE :)
> >> @Bj=C3=B6rn T=C3=B6pel emitted the idea of excluding from the hibernat=
ion all
> >> the memory nodes in the "/reserved-memory" node
> >> (https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/device=
tree/bindings/reserved-memory/reserved-memory.yaml):
> >> I have to admit that I don't see why it is not done by default by the
> >> kernel.
> > My understanding was that it was perfectly fine to use reserved memory
> > nodes to fence off some memory to use in device drivers etc, which then
> > may need to be saved/restored.
>
>
> Agreed, but I would say that it's up to the driver then to take care of
> that, see https://docs.kernel.org/driver-api/pm/notifiers.html

I agree, it should be drivers responsibility to save/restore the dedicated
reserved memory used by itself.

Although, I think we should at least save/restore reserved memory
regions having "reusable" property set.

Regards,
Anup

>
>
> >> Unless there is stuff in this node that needs to be "hibernated", I
> >> think that would be a very good solution since we would not rely on
> >> the name of the "internal" nodes of "/reserved-memory" (i.e.
> >> "mmode_resv").
> >>
> >> I'm digging into why it is not done by default, just wanted to have
> >> your feedback before the week-end :)
