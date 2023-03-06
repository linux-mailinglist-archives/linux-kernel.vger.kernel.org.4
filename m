Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAC46AC97A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjCFRMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjCFRMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:12:02 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC065FE8E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 09:11:25 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id j2so9570356wrh.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 09:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678122606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4PzzPL3yf/OvHrUyvtjdzmob9yX9CWqWw1Cbp7amTnc=;
        b=G8dExvrsNRqq6dp23s57GMB3tat6Oh3IGRZEq7Lil7Y/MafWTAwc1xARppZ/yIAlER
         9/r5yAqKcZSPmd0KF3KGlKcrESpGgyE2b2zWEHgmwGZsbDsq8BUnPc0T1qgikT4WSSJw
         s5zfl4HsPMFdNc58HIWgGrOYxmjxEjwh4q4tIbEFxpZVDAuLSAzf+miPIxe1lcCFB/U0
         gL1tXPgrlpRCxQQVQSt9kaNrpYwb6ExbDSQECMiEwsqhTlyovT+kRzAyWai/6EiQyUNV
         gksvFpxbBic9TYSYhbPAtaWxzQ8Dr08wxncjbKHeJYU2m9ms8tJr+PhpFk6Ja1g6whhP
         0tyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678122606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4PzzPL3yf/OvHrUyvtjdzmob9yX9CWqWw1Cbp7amTnc=;
        b=lMX3o76BREyaOpmympaYFdMeMaBspKAbSrPHnKQYiaZcAZnO/7S4Viz/N1Loo/+t54
         H6IS7q+FUyMaISqFTUl6pRd3lgc7QQyqlLzJsgp3JMw2geY2+mtfaO1s582GG15FqsmT
         VHdXEkYjdnXqe379lS51MDzVlMYHlF/kWc3bmSmLNK0wlyWgiQ6emWMb/GrD5zwJ/Qcn
         DrRaDMBJxUgpubd75TXtgtA7tHzC1wkSHukLjlgMGs5PTXASMd+Ap0iwO7VMgdj95ceZ
         /5rSRk1CXvCVlIaIZNxLuqMyFPeZPGdLG+A6r1fXTwtbyfUbpt0Wnppf/YT3lNxSO2zI
         y6Lw==
X-Gm-Message-State: AO0yUKWN8eFiivD5kAa+wJsbHAbCBPOBZUacyxLHleVVTM8IgafSFDPz
        RLi5SDE7Dt2Zh+kyTlp/nuv3EgOjFBvDnxTsjH2tTA==
X-Google-Smtp-Source: AK7set/hlySjQjG9XahK1Wr1L2iX8UrH1gzGxxXqeuWd8StHpPzUUpQ8ndgAdNdgjYv9LluMSUP3FOfArTNRFu85UMc=
X-Received: by 2002:adf:ee4e:0:b0:2c7:17b8:5759 with SMTP id
 w14-20020adfee4e000000b002c717b85759mr2138518wro.3.1678122605647; Mon, 06 Mar
 2023 09:10:05 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYtwqro9qaCmxOBAM1qt8L7k5ZwceaYBLY8RWoELDghhsw@mail.gmail.com>
In-Reply-To: <CA+G9fYtwqro9qaCmxOBAM1qt8L7k5ZwceaYBLY8RWoELDghhsw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 6 Mar 2023 09:09:53 -0800
Message-ID: <CAJuCfpEiO1Kg5apwfiQ+apjAu+NCXe4TwtLX6oRTXWYroRW1SQ@mail.gmail.com>
Subject: Re: next: mm/khugepaged.c:1702:30: error: implicit declaration of
 function 'vma_try_start_write'; did you mean 'vma_start_write'? [-Werror=implicit-function-declaration]
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, linux-mm <linux-mm@kvack.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 6, 2023 at 3:13 AM Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Following build regression noticed on i386, mips and s390.
>
> mm/khugepaged.c: In function 'retract_page_tables':
> mm/khugepaged.c:1702:30: error: implicit declaration of function
> 'vma_try_start_write'; did you mean 'vma_start_write'?
> [-Werror=implicit-function-declaration]
>  1702 |                         if (!vma_try_start_write(vma))
>       |                              ^~~~~~~~~~~~~~~~~~~
>       |                              vma_start_write
> cc1: all warnings being treated as errors

Thanks for reporting. I posted a fix over the weekend:
https://lore.kernel.org/all/20230304232856.DD36BC433D2@smtp.kernel.org/
which should be merged soon.

>
> build details:
> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230306/testrun/15286608/suite/build/test/gcc-11-lkftconfig-rcutorture/details/
> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230306/testrun/15286608/suite/build/test/gcc-11-lkftconfig-rcutorture/log
>
> # To install tuxmake on your system globally:
> # sudo pip3 install -U tuxmake
> #
>
> tuxmake --runtime podman \
>          --target-arch i386 \
>          --toolchain gcc-12 \
>          --kconfig
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2McWOXP1OH5MiYficVNv8hJCR4F/config
>
> Similar issues have been reported and discussed on the mailing list.
> - https://lore.kernel.org/all/20230305191335.fee8e6aa285b0ca771cab9dd@linux-foundation.org/
>
> --
> Linaro LKFT
> https://lkft.linaro.org
