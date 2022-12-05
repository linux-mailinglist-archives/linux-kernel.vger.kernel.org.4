Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE3C64288C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbiLEMeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiLEMd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:33:58 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D5C17595
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 04:33:55 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id p24so10665490plw.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 04:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q40E+8775Ytgz5QSPBn2r/4sQuSdgbu05Kbc0jHoATk=;
        b=MZhsePv3EtViNeCdHKcApYH2WEX0tXDjbOxdICRoiz3JB8UoTMHkYtRUGjPzfw8G7M
         R2a5hEOvxUL8qP4UucwnFEu88M6QMTifKtxN3vWOSJMc02ZNQNmxBrWwJzSpezF8xLg4
         rZWU0zGYT/s6ZmQXOjANZ3PsSciGIJlb15YwVuKAnNR6tFLOugy192txBkWTjsJiEONK
         QgJP9iYG048n92r9BbBQYBCOCdtiO/eqfCLkfJMAHr/9p0jZa3udTOqh8Up/5MC53gYn
         aUI95Mo74WP3W06g+hK35/c/yvbhV8bUJRZPfklJHkuS6a5n/TRRmbr6OQ4ORYTp0iG5
         caaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q40E+8775Ytgz5QSPBn2r/4sQuSdgbu05Kbc0jHoATk=;
        b=mywMQCwhM2N8UnMcS63XjXnvSa/Z0WG6FCWxrFtmrWe0dE5Xjc9xBzCQaEPYYZqjq2
         3BwywsoNnpPcHHMVnaukCvOTvyGZnOF8kBUM6XGGXjb63vW/1vqqUXsbwXqTJMgwCj/T
         bozrXfE868zY0QzQ8LsFRbPdd9b50l8Bv8cEGI5+YlF0HX4meCxmb8Q4oUUoY17/esiW
         fhqxxhAOkygZ0WqXXutbX1EP9yonfflJXAv0NFoq8SX903yI0EFQxJvDNlBMJMjt4AnP
         azeJQ9B5GhS5mueanVVEqmLdrkB34EIdOptDC0ucSnzXkyk3mjiIaWaXdi3xAJmeYaQE
         lJmQ==
X-Gm-Message-State: ANoB5pl9EhxCbPVVEfXQdN0FbMG0isqV3exH2g62V1uGItXoWZCS4ETU
        RxsYVa0dZrs9Kpjf9ck5XbG/hmZB41/Fw/bcvyg=
X-Google-Smtp-Source: AA0mqf4QoWxvCzWRsRTp0PvP1pSS70z3LSPhA5x4wbfTZmWepsOLqym0zZitGlWZ95Z20ekzgvlJ4eIxGMijR8Vsf9I=
X-Received: by 2002:a17:90a:e551:b0:219:aa91:d689 with SMTP id
 ei17-20020a17090ae55100b00219aa91d689mr10806324pjb.180.1670243635346; Mon, 05
 Dec 2022 04:33:55 -0800 (PST)
MIME-Version: 1.0
References: <20221201151336.8044-1-suagrfillet@gmail.com> <Y4jICn5oxLozsv6m@wendy>
 <Y4jtfrJt+/Q5nMOz@spud>
In-Reply-To: <Y4jtfrJt+/Q5nMOz@spud>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Mon, 5 Dec 2022 12:33:43 +0000
Message-ID: <CAAYs2=gF7FetnJh2UE=1uFS6RChn4eTG5gdasn3KL4Uj2=bMag@mail.gmail.com>
Subject: Re: [PATCH v3] riscv : select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>, guoren@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, apatel@ventanamicro.com,
        atishp@atishpatra.org, heiko@sntech.de, anshuman.khandual@arm.com,
        liaochang1@huawei.com, juerg.haefliger@canonical.com,
        wangkefeng.wang@huawei.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conor Dooley <conor@kernel.org> =E4=BA=8E2022=E5=B9=B412=E6=9C=881=E6=97=A5=
=E5=91=A8=E5=9B=9B 18:08=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Dec 01, 2022 at 03:28:10PM +0000, Conor Dooley wrote:
> > On Thu, Dec 01, 2022 at 11:13:36PM +0800, Song Shuai wrote:
> > > In RISC-V, -fpatchable-function-entry option is used to support
> > > dynamic ftrace in this commit afc76b8b8011 ("riscv: Using
> > > PATCHABLE_FUNCTION_ENTRY instead of MCOUNT"). So recordmcount
> > > don't have to be called to create the __mcount_loc section before
> > > the vmlinux linking.
> > >
> > > Here selects FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY to tell
> > > Makefile not to run recordmcount.
> > >
> > > Link_v1: https://lore.kernel.org/linux-riscv/CAAYs2=3Dj3Eak9vU6xbAw0z=
Puoh00rh8v5C2U3fePkokZFibWs2g@mail.gmail.com/T/#t
> > > Link_v2: https://lore.kernel.org/linux-riscv/CAAYs2=3DiYn8sLQB8oh+RzT=
Kd2VKs8MXOLX6Mwpamx5gdVVN6mkA@mail.gmail.com/T/#m62138d7a76664798d00051818a=
438a601eff4cf1
> >
> > Hey Song Shuai,
> >
> > For future patches, please use normal "Link:" tags. If you're just
> > linking to prior versions of the patch, just put them below the ---
> > line so they don't end up in the git history.
>
> > > Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> > > Tested-by: Guo Ren <guoren@kernel.org>
> > > ---
> > >  arch/riscv/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index 572973103d73..c19cddb8feb9 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -277,6 +277,7 @@ config ARCH_RV64I
> > >     select 64BIT
> > >     select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
> > >     select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-option,-=
fpatchable-function-entry=3D8)
> > > +   select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if DYNAMIC_FTRA=
CE
>
> Also, why are these not added in alphabetical order, like the current
> list is? I don't see HAVE_DYNAMIC_FTRACE in linux-next from the other
> day so that probably needs fixing in the series you are based on too.
>
Sorry for bothering you with this disorderly CONFIG  and the 'Link' tags
I'll tidy them up with Guo Ren in the next version.

> > >     select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
> > >     select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> > >     select HAVE_SAMPLE_FTRACE_DIRECT
> > > --
> > > 2.20.1
> > >



--
Thanks,
Song
