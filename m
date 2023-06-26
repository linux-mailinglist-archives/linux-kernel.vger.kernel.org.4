Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFFF73D7DE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 08:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjFZGnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 02:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjFZGnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 02:43:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681A61A7;
        Sun, 25 Jun 2023 23:43:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEE6960C98;
        Mon, 26 Jun 2023 06:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52347C433D9;
        Mon, 26 Jun 2023 06:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687761790;
        bh=PCjX38sWy+8o+giL2BsPMNvdOxlsGH1hEh8od7hNbBM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B/6ylKyrSjxVvwkGsDuP4dv8adwxtzNLvoWzhF6hEYfAJO2/faxHKtHDLXheCp99X
         gUUsJQKbdxA63sJGNMbccqm5qe2Cf8Nu6Hna8WSSDbRvGdX8raz+K/8cVwHiW5gsJH
         Tb688+3+cYoFzhr8Kis54cB8thbfCRzJiSsfsSXRV9m9Zmuzy++pDjEfhMy3LZjOxz
         rRY3C/kuTwzz2Pvw21ItwRk4g7g+6AnyeBk3dxP85Vrw1r7SuXzP06fjrnzzUFc5ft
         xoLeY8vHUlkLMPNGiFXUcXHIXFkRFvtRCtkKXtAfVNHFy07JrdnvOebIh1IdvBIcgV
         PjV9YW1nGyQfA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4fb73ba3b5dso910129e87.1;
        Sun, 25 Jun 2023 23:43:10 -0700 (PDT)
X-Gm-Message-State: AC+VfDx5ki4TBeLHyLk0pNu3o1AdU/Kmzn1ZbxAttd02CvY6ap3h/CgV
        CQ1eyrE4d1J8bYRNPMFC9C3gi1g6Cjp3UaXbCsw=
X-Google-Smtp-Source: ACHHUZ6MxPt5pZZvHaDzsv696tPD1MHF4iteIzTclmq04bj17d2JjJdizMQkwqR3S531TyJf0xXV4jvIelO4SPbodnM=
X-Received: by 2002:a19:6403:0:b0:4f9:567a:7a62 with SMTP id
 y3-20020a196403000000b004f9567a7a62mr8584473lfb.21.1687761788301; Sun, 25 Jun
 2023 23:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230426034001.16-1-cuiyunhui@bytedance.com> <CAMj1kXEKh9O-ndk3QFibJMYfMbG7vm-cLN2vVQM5eDsYK84NzQ@mail.gmail.com>
 <CAEEQ3wkJB5CKm33mHXUOPX5makYOHF8By6FYGnNzRkM-Mo72OQ@mail.gmail.com>
 <ZEj33QLZqEeL+/y4@FVFF77S0Q05N> <CAEEQ3wmDBJkfOeKCQfcnuE+1=1K0D2pzu+Sn+zPEWk+RHs0NFQ@mail.gmail.com>
 <CAP6exY+ydbzh1EkWTFejzwaW+PA-ySVO2Qj+CVJ1XbSMce2S9Q@mail.gmail.com>
 <CAP6exY+tqAU0j1TVEMTzTb18M6_mPH5bWWiAS=94gyDGTY3hyQ@mail.gmail.com>
 <CAEEQ3w=wBdpZWnUd2WWVBC3BtFiUp-PQtNAtdXE4cO4n0XT-fg@mail.gmail.com>
 <CAMj1kXFGpXEPtYpy1+bs13F2P_LLZf9rTMfYMU=6jzgd3=SEcw@mail.gmail.com>
 <CAEEQ3wnbXE0vJnQRLo5MhfDc-Q4PbNWBoWS-oMn71CcJU51JdA@mail.gmail.com>
 <CAMj1kXHfqkU2QxvjTkGBSkEcTf_HirbdOReOJwdpgz3hM8fBHw@mail.gmail.com>
 <CAEEQ3wn2n48TpNQ3MuvrRH4zzg28SaiOswunPeZ01jFm-TbJ5w@mail.gmail.com>
 <CAMj1kXHgaLD43jx0f6hn_j209LGT_4G+w5XEGaYB9znV5p9tdA@mail.gmail.com>
 <CAP6exYJRE8iM63SX3hQP9_5aKYcnN5x0KOAtZOgeEWU5bwLEBA@mail.gmail.com> <CAEEQ3wn2zHUZP8gs8ezCczQLdQJqU6MqAgpcG0YeDW2aYTz0TA@mail.gmail.com>
In-Reply-To: <CAEEQ3wn2zHUZP8gs8ezCczQLdQJqU6MqAgpcG0YeDW2aYTz0TA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 26 Jun 2023 08:42:56 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFn7+W=ZGNcSLL6p383SbA8=wstutJ85+qvXzt2G66Seg@mail.gmail.com>
Message-ID: <CAMj1kXFn7+W=ZGNcSLL6p383SbA8=wstutJ85+qvXzt2G66Seg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] firmware: added a firmware information
 passing method FFI
To:     =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Cc:     ron minnich <rminnich@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, rafael@kernel.org,
        lenb@kernel.org, jdelvare@suse.com, yc.hung@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        =?UTF-8?B?6JGb5aOr5bu6?= <geshijian@bytedance.com>,
        =?UTF-8?B?6Z+m5Lic?= <weidong.wd@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2023 at 04:35, =E8=BF=90=E8=BE=89=E5=B4=94 <cuiyunhui@byteda=
nce.com> wrote:
>
> Hi Ron, Ard,
>
> On Sun, Jun 25, 2023 at 11:57=E2=80=AFPM ron minnich <rminnich@gmail.com>=
 wrote:
> >
> > Hey Ard, thanks for the discussion, sounds like we are able to move for=
ward now!
>
> >
> > On Sun, Jun 25, 2023, 6:13 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >>
> >> If this is only used on RISC-V, and implemented under arch/riscv, I
> >> have no objections.
>
> Thank you for your suggestions that made us reach an agreement, let's
> continue to review this patch.
>
> The current logic is to implement the common interface under
> drivers/firmware/, if we need this function, we can call
> fdt_fwtbl_init() to complete it in arch/xxx/kernel/setup.c.
>
> For enabling on RISC-V, we can complete it in a subsequent patch to
> setup_arch-->fdt_fwtbl_init() in arch/riscv/kernel/setup.c.
>
> What do you think?
>

I think all of this belongs under arch/riscv
