Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A235E7FC0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbiIWQ2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiIWQ2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:28:02 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5EC147CCA
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:27:39 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z6so830931wrq.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=oYS931QxypUChKHoLGJVldhhe0rE/S6dyM7vUBrMOiU=;
        b=Zqvxfogh49z4nlATM3a1Eir2F6ueo9XGy+Fz9Cg3TMolya41ElD6+i28w7JiBO9t2V
         CdzJMPfpEyYyKFELjyeOFaAtW1b1lE4oHFiuXAn+phX7oywMEOLfB+FcOVthnIj1sxxt
         7tX8CLKT6jMnfgxmR/yTDgR5c7JH7kz32e9Ii0InpCF2HHrAzC0JBewslzjDNSV/4Ca+
         GTmlEOQ1BqWhEFXPO5Nq7D4C2NIY6WaG68pmWCFLvGpAEdzA9Nm0Dspv3VrEBKOYNoLe
         +cZVbl15ruEzeGom+SFtXtImJuqFm1qAMQfIlY+/aiFIdhBTiVRnu771V4HXhPPr4x0Q
         ZsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=oYS931QxypUChKHoLGJVldhhe0rE/S6dyM7vUBrMOiU=;
        b=v2zZe8G1ra8hiFdI0jPNRgkOFoDjp/Ep1TuHo9fICkYXat/hkFMvUzQN+lAUhQ2xxI
         a5J6O/JtZv7CtVSh3XU1RArMZnzGjq6jz0u5oRLSoD9nQCxNzsAo8VJf8GsgZ9wFNapO
         WpNUSBC684mARCiZ8b5e5gfsWBYXs5ouSMFn8t2TjJaka2/phXqt3CQMP4g26yujF4si
         OrZcIJ4Iy/bn2swzbSv1mBrDs7mGdd9dvf0rN6mRsyuJ1V938H2BRcFT7OfzhTyGptL1
         hIybkJrE2uSQgyLS8kaGgBfIiG0f2TBtDq3QDqRfhXIeWx0rDKPkgT6NUE45iEhH0279
         N6Kg==
X-Gm-Message-State: ACrzQf133zHbPiWkhRCMDO/MpR5T0G0TjHvECYWg5TyPZeKeXk9S1XsB
        fa58wRari7DFSAniGIiR2787dDQFGC39wa105z7GMA==
X-Google-Smtp-Source: AMsMyM6NTJ+2A73KKiFe9n7hUORCLxnfvs0iYzjbS7DtbiGBB3bNYtqzkHL9uGgAE9rr+YZLYG9gQmBL1ohHuUfrv3U=
X-Received: by 2002:a05:6000:1886:b0:22a:2944:a09 with SMTP id
 a6-20020a056000188600b0022a29440a09mr5840574wri.391.1663950457617; Fri, 23
 Sep 2022 09:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220921214439.1491510-1-stillson@rivosinc.com>
 <20220921214439.1491510-5-stillson@rivosinc.com> <a91e3e67-d077-050c-48a3-1466c2deb7c4@sholland.org>
In-Reply-To: <a91e3e67-d077-050c-48a3-1466c2deb7c4@sholland.org>
From:   Chris Stillson <stillson@rivosinc.com>
Date:   Fri, 23 Sep 2022 09:27:01 -0700
Message-ID: <CAM2SziUBmXcte+GGsXPyKC7ce5EVjaiiWGAU=bWev2LAWrHYrA@mail.gmail.com>
Subject: Re: [PATCH v12 05/17] riscv: Add has_vector/riscv_vsize to save
 vector features.
To:     Samuel Holland <samuel@sholland.org>
Cc:     Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Oleg Nesterov <oleg@redhat.com>, Guo Ren <guoren@kernel.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Dao Lu <daolu@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Ruinland Tsai <ruinland.tsai@sifive.com>,
        Han-Kuan Chen <hankuan.chen@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(resending, as I forgot to set it to plain mail)

This is the way the original set of patches worked. I tried to change
them as little as possible for the rebase.

On Wed, Sep 21, 2022 at 9:23 PM Samuel Holland <samuel@sholland.org> wrote:
>
> On 9/21/22 16:43, Chris Stillson wrote:
> > From: Greentime Hu <greentime.hu@sifive.com>
> >
> > This patch is used to detect vector support status of CPU and use
> > riscv_vsize to save the size of all the vector registers. It assumes
> > all harts has the same capabilities in SMP system.
> >
> > [guoren@linux.alibaba.com: add has_vector checking]
> > Co-developed-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> > Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > ---
> >  arch/riscv/include/asm/vector.h | 14 +++++
> >  arch/riscv/kernel/cpufeature.c  | 19 +++++++
> >  arch/riscv/kernel/riscv_ksyms.c |  6 +++
> >  arch/riscv/kernel/vector.S      | 93 +++++++++++++++++++++++++++++++++
>
> This file is not added to the Makefile until patch 8.
>
> >  4 files changed, 132 insertions(+)
> >  create mode 100644 arch/riscv/include/asm/vector.h
> >  create mode 100644 arch/riscv/kernel/vector.S
>
