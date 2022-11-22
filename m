Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE1663396B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbiKVKLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbiKVKK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:10:59 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F09853EC9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:10:58 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id a22-20020a17090a6d9600b0021896eb5554so7882807pjk.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Ffx34EpUvz/wk2V0TkLGpQPfUVhIxoixoNZG+R5yhU=;
        b=TVN5V6A7gjqPVkAUn4JbFNorOWRrBKFn7ykWEJFI2TJyoLwiq9OSTR31A7QwxM/sgq
         KMg0c+/ECORPxlNsN7/S07SNEgU7QXb2cUDS2ry1M5DkXy0wp3y18EEdHQvJYEmYK/Rl
         C4OS51EMJa4XoawksMYV/Cf9b5L1ulCHoVN65dRBkBMOIDHvmj8jN2tkIGErvk/9QZG8
         vsxqY2OPl5wDk2T4Ja6eJ0XKeO3maMTXu6xlKRLV5URoxFCGq+WOl6szvf11N02f8hpi
         B34fRWv1L4KyL4bhKSwrv1dEOgWY/rFh3gVsHIVXnfFcWQUalNUho/A+qyH5hiABzQ8l
         F42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Ffx34EpUvz/wk2V0TkLGpQPfUVhIxoixoNZG+R5yhU=;
        b=DB3a6To2fe/zy5h9QQEDFtJR/74u9vCHuLNvX7akmMwxoo+2bPJPRJgMLZ5fcjq9Fc
         H9+zpB0Qs1wNevs4TnChynicKq0+0VFhZtZw+SACA++I5X2hO419UMEeyiXVEfPmEkjB
         yd7lCLAqPdfYsuhWmuxSc+bSlij6jXFzrEjb0v517aY9VFIccVip+ucYTTjk18yylShO
         t97IQZOplLDoKlEjAaxCQGIJZyd2LNo62B//U8lNgBw3VwY5Wy7p6mBxRBRollfI8pCG
         p1AeXA8LCopxXluu08eKAEE7COjkY/F2xyeMaG5u+rRa49F4+14k5ws9gXwUzlDHRTrf
         Vg9Q==
X-Gm-Message-State: ANoB5pktCkxJ++nsaFxqK8kyqap1JZtjhBGQ11W2bd+OWsFP36BiMQN6
        BoKwe738g0IdE2GnO2U6FLiKNPRxPtCEjOJc7fc=
X-Google-Smtp-Source: AA0mqf7EWECK5efgWxORmvkHfTeEiAaT/+7tYzpwh78/RlRBi/8M0vH9zW9E6QMP8gG5GC3WkLfXJn+8uC6/tjmYfu8=
X-Received: by 2002:a17:902:6847:b0:183:6555:38ef with SMTP id
 f7-20020a170902684700b00183655538efmr6778345pln.157.1669111858051; Tue, 22
 Nov 2022 02:10:58 -0800 (PST)
MIME-Version: 1.0
References: <20220923100149.2647325-1-suagrfillet@gmail.com>
In-Reply-To: <20220923100149.2647325-1-suagrfillet@gmail.com>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Tue, 22 Nov 2022 10:10:46 +0000
Message-ID: <CAAYs2=hx49ahtY3pe1z241Vd1mRNZjc-oigubmKy0aGqg6T8ag@mail.gmail.com>
Subject: Re: [PATCH RESEND] riscv : select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
To:     Guo Ren <guoren@kernel.org>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     guoren@linux.alibaba.com, linux-riscv@lists.infradead.org,
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

Song Shuai <suagrfillet@gmail.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=8823=E6=97=
=A5=E5=91=A8=E4=BA=94 10:03=E5=86=99=E9=81=93=EF=BC=9A
>
> riscv now uses -fpatchable-function-entry with dynamic ftrace after
> the `afc76b8b8` commit, which means recordmcount shouldn't be called
> to create the __mcount_loc section before the vmlinux linking.
>
> We should select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY to tell
> Makefile not to run recordmcount.
>
Hi,Guo:

Can this patch squeeze into your v3 series ?

Thanks,
Song
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index c22f58155948..25db8cea876a 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -246,6 +246,7 @@ config ARCH_RV64I
>         select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-option,-=
fpatchable-function-entry=3D8)
>         select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
>         select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> +       select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if DYNAMIC_FTRA=
CE
>         select HAVE_FUNCTION_GRAPH_TRACER
>         select HAVE_FUNCTION_TRACER if !XIP_KERNEL
>         select SWIOTLB if MMU
> --
> 2.20.1
>
