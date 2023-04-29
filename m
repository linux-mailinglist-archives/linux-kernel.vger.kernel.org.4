Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15F66F25F0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 21:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjD2THB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 15:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjD2TG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 15:06:59 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29B6E5B
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 12:06:56 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2a8a59daec5so9146531fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 12:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682795215; x=1685387215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZQprsIFxkb6uN+gB/WxK+KPOh1VYzqWl9rnM0y+44U=;
        b=pqAoyNDvckoNrFVRFtTSPp+aKQgzq2t1zKzWv8Gf+uwfWoU1EacoHb/KSumyadsmTN
         ligsXTgRi7NgYGtXbNjWLhdLhquagRrcLsIgUQnDzkW21cWhRXl+A8A3cREW+DdR5wf3
         i+VgJ7sAe68KrIJF8voahlUHYa+aZ7FkDRIipStSGZkMsRksQ9xOo1HFhxJrrN5WjVPE
         6AsrJtEEteOfTbqyP6CxKcT7Yth5kfU1n9tTzj3uMBAzDBg/0eSecVMy3u9zOYd4huZw
         XVtHo4uQr++T6PPrl2Fzeuj0XMZ31Hld5PAnyepyMOi9zDzKIuWhVHf7RWrR2XsaSps+
         IZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682795215; x=1685387215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZQprsIFxkb6uN+gB/WxK+KPOh1VYzqWl9rnM0y+44U=;
        b=c/o5Eoe263MubwLClkHxv+tyxKBVLUBQGQ/Dh+1mpE5fTABZOK7tIT7e6h8vEi38Ib
         FerLNigV9RA1JC+StFXmC1503a1ag25NF5b7ndzKv+SC7sec5FRGeQ+790zoeXelOeEz
         FhmNpcaC4XXzrfO7DTL7XD7pv0xys5syJRukTsrgejTqf+TplXreBFGsE1mo/QLiuwqv
         9Y8QhNPswN9lv6SRDpyzdxN7pjbS4Uo9t7/3yPW0tWW4N/oDpJkby3x3qx+oLCp9QkyJ
         2mIMON5fzLUVKmLqTkN6fsgL67PFLNKRmU15elwZz/tVsz862t+Bwyul7CH/yR2DMYrD
         J+hw==
X-Gm-Message-State: AC+VfDzwuw52LLanf8ZCUteSwOaE+BR1KAgNuEgmAub+qOvpCbf9HDrZ
        A26bXplf3iYR/ONGZPmzb5HOP9Xr77frHhACiXtO53UaLxTkxrYa
X-Google-Smtp-Source: ACHHUZ6YEnTDHMPe1uXVXbjjrDwRb8mKocGJYkJfVMTo4Cs4HcMhIoy/gBJIb0fiPeJlM3NlbXL7zkgVBDBT5Nrme3A=
X-Received: by 2002:a2e:9d47:0:b0:2a7:6e12:f75a with SMTP id
 y7-20020a2e9d47000000b002a76e12f75amr2226666ljj.53.1682795215108; Sat, 29 Apr
 2023 12:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230429155247.12131-1-rdunlap@infradead.org> <CALs-HsuG3EFBs60sgiMcPHoE1dF7mhi3GKt=AWvRPaUHAfA88Q@mail.gmail.com>
 <20230429-outboard-hypocrite-983e977103d2@spud> <CALs-HstrR3Cm3jQKt6dmfYiRRVkAVibAZDtFo0wmXz4LEvRf_A@mail.gmail.com>
 <37e6b325-44e4-8e65-68e3-eab2943018ac@infradead.org>
In-Reply-To: <37e6b325-44e4-8e65-68e3-eab2943018ac@infradead.org>
From:   Evan Green <evan@rivosinc.com>
Date:   Sat, 29 Apr 2023 12:06:19 -0700
Message-ID: <CALs-Hss3b86zAqohK9NYEkzn+pnLeMB37qaj1EA6f6bRkFWwCg@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: fix sifive and thead section mismatches in errata
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 29, 2023 at 10:58=E2=80=AFAM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
>
>
> On 4/29/23 10:48, Evan Green wrote:
> > On Sat, Apr 29, 2023 at 10:24=E2=80=AFAM Conor Dooley <conor@kernel.org=
> wrote:
> >>
> >> On Sat, Apr 29, 2023 at 10:21:39AM -0700, Evan Green wrote:
> >>> On Sat, Apr 29, 2023 at 8:52=E2=80=AFAM Randy Dunlap <rdunlap@infrade=
ad.org> wrote:
> >>>>
> >>>> When CONFIG_MODULES is set, __init_or_module becomes <empty>, but wh=
en
> >>>> CONFIG_MODULES is not set, __init_or_module becomes __init.
> >>>> In the latter case, it causes section mismatch warnings:
> >>>>
> >>>> WARNING: modpost: vmlinux.o: section mismatch in reference: riscv_fi=
ll_cpu_mfr_info (section: .text) -> sifive_errata_patch_func (section: .ini=
t.text)
> >>>> WARNING: modpost: vmlinux.o: section mismatch in reference: riscv_fi=
ll_cpu_mfr_info (section: .text) -> thead_errata_patch_func (section: .init=
.text)
> >>>>
> >>>> Fixes: bb3f89487fd9 ("RISC-V: hwprobe: Remove __init on probe_vendor=
_features()")
> >>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >>>> Cc: Heiko Stuebner <heiko@sntech.de>
> >>>> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> >>>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> >>>> Cc: Albert Ou <aou@eecs.berkeley.edu>
> >>>> Cc: linux-riscv@lists.infradead.org
> >>>> Cc: Conor Dooley <conor@kernel.org>
> >>>> Cc: Evan Green <evan@rivosinc.com>
> >>>> ---
> >>>
> >>> Thanks, Randy. I'm confused at how I didn't see that when I made the
> >>> original fix. I feel like repro of these section mismatch errors
> >>> depend on some other factor I'm not understanding. In any case:
> >>
> >> Perhaps you had a cut-down config that did not enable either of the
> >> relevant ARCH_ options to get those errata compiled?
> >
> > It was weird, my original "fix" (the one listed in this Fixes tag) was
> > needed because while the hwprobe series was clean on Palmer's branch,
> > it generated a "section mismatch" on linux-next. As noted here, it was
> > only with !CONFIG_MODULES, so I explicitly remember generating that
> > config and checking it on linux-next to generate this "fix", and it
> > came out clean. It's like the robots are getting smarter.
> > -Evan
>
> I observed the problem in 8 out of 20 randconfig builds,
> using linux-next 20230427.

Oh interesting, so not the stock k210_nommu defconfig. That makes me
feel a little better at least.
-Evan
