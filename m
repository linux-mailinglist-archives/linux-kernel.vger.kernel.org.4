Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA7C745563
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 08:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjGCGUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 02:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjGCGUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 02:20:00 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E7FC0
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 23:19:58 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fa9850bfebso41188535e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jul 2023 23:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688365197; x=1690957197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIA8PGEOYws0vmVhO9ZbwpnpL5VKVZvMUon+9TyoBpI=;
        b=G28N59EBqbA1TV1NU1uC3s8kAkrfBErBxvNr2G/qFOJK2E54h05y0DRcJ3xxoCztG5
         Q4N40aSZk/g5pXFRQHkarqTf4DZs3X7wL2345oNsjJH8e53OJ5sF9P5cxapjmofvL/Nj
         f29CR6105WEeo2//RW2Wyl/EBUDrrHlyi595e6w8n4k3iJKtcaR3Uig2Hd6M0fmL2bu8
         g1wKa1TYVRHxyQK6y3Qg3wZ4U8ZVlgzWFXA2tziamptWb9hzjqWbmdRkp1+Fm4IbJEmC
         DzFIBJkfaQqpbGENW26FK3KbR1seicOuBAdwtZlcC6ArQjIvmaMnv61m73QIJDzv/ybA
         hRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688365197; x=1690957197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIA8PGEOYws0vmVhO9ZbwpnpL5VKVZvMUon+9TyoBpI=;
        b=XY7c4oCpEgvSK9jur2S3cpQ+UJRRyIE1ZR16T+MRWC9m6GhbSvNrK5BtQCVEIK9SUR
         h5oeDsZGAuwV8NJnIfpmkAWEbg1343x1gjaFApuBNqDlYRUIjYTRa0jzuRlDQTROivvT
         tj6Jsz7wXIeEpeyyc4hzt18g7NSljaBB3vHWyJq56tZXNiMUiukBS+Mzvkffo9dpOiu9
         2A471PXRsqzSd2YE8rcLcRDuUyCZEAHA+Yvlzo7bOEBf8chN28sZrjV7m5X8lkZBMYt8
         Vy0kHEskFC//sFw8awqqNagZ8aA+4YwS/T1uWRHX1XZBTR7EOFv7uYdMDgHtNnfRYhFI
         rbdg==
X-Gm-Message-State: ABy/qLZvLZMOggaT6nEpqfoyLFn0wIk4SwkusZCayHiilb4SHQcbs0gi
        weNj1TCrDzwZNWUwasUoP8z4ztiFXBbdWH46BBOzEQ==
X-Google-Smtp-Source: APBJJlEGTc+phyaAeTPWFFONu5TUwojxZNGJBdfvyl86jwAZEp9blrmCMJKrpwCX7fYL9Do4AqX75KbcPMfQRU1K8RM=
X-Received: by 2002:adf:cc81:0:b0:314:d19:fc31 with SMTP id
 p1-20020adfcc81000000b003140d19fc31mr7536169wrj.51.1688365197436; Sun, 02 Jul
 2023 23:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230702095735.860-1-cuiyunhui@bytedance.com> <20230702-headway-dreamlike-d7ba39ac4910@spud>
 <ZKJM1fG3JXEBApfj@sunil-laptop>
In-Reply-To: <ZKJM1fG3JXEBApfj@sunil-laptop>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Mon, 3 Jul 2023 14:19:46 +0800
Message-ID: <CAEEQ3wnsedWJYEEg8z+3C_HuCca0nD50NGpCdU3scxavrrOucA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/3] riscv: obtain ACPI RSDP from FFI.
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     Conor Dooley <conor@kernel.org>, ardb@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        rminnich@gmail.com, mark.rutland@arm.com, lpieralisi@kernel.org,
        rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com, alexghiti@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sunil,

On Mon, Jul 3, 2023 at 12:22=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> Hi Yunhui Cui,
> On Sun, Jul 02, 2023 at 02:47:41PM +0100, Conor Dooley wrote:
> > Hey,
> > %subject: riscv: obtain ACPI RSDP from FFI.
> >
> > This subject is a bit unhelpful because FFI would commonly mean "foreig=
n
> > function interface" & you have not yet introduced it. It seems like it
> > would be better to do s/FFI/devicetree/ or similar.
> > Please also drop the full stop from the commit messages ;)
> >
> > Please use a cover letter for multi-patch series & include changelogs.
> >
> > +CC Sunil, Alex:
> >
> > Can you guys please take a look at this & see if it is something that w=
e
> > want to do (ACPI without EFI)?
> >
>
> We have supported ACPI only with UEFI. The current booting contract
> between firmware and OS is to pass only one of DT or ACPI, not both.
> This approach brings another booting contract for Linux mixing ACPI and
> DT which affects RVI specs. As per policy and since it can affect
> multiple OSs, a frozen RVI spec is required for taking this patch into
> linux. So, could you please bring this topic for discussion in [1] and
> get agreement?
>
> Isn't it simpler to provide a minimum UEFI configuration table and
> stubbed BS/RS?
>
> Have you done a PoC? I am curious how do you handle EFI memory map
> dependencies.

Yes, Poc has been completed.
a memory node in DTS can solve it.

>
> In case this is approved, I am wondering why do we need new FFI?
>
> [1] - https://lists.riscv.org/g/tech-brs

We have discussed with Ard and Ron many times about the series of
questions you mentioned above, and reached a consensus.
Please see the v1:
https://patches.linaro.org/project/linux-acpi/patch/20230426034001.16-1-cui=
yunhui@bytedance.com/

Thanks,
Yunhui
