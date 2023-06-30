Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A91743429
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 07:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjF3FZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 01:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjF3FZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 01:25:30 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A76335A7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 22:25:26 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-26307d808a4so1060641a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 22:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688102725; x=1690694725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzaczCUBTZTvAfZLPO+zN4aCSdU9+F5DHZ/dQrcjWzU=;
        b=gyQqADp/Sx903gGG+OLLNk+axKHxz5gbLh03VL9H3rJuq5frIVmqzynqnNdfUUkSO0
         chWzDJq2lk/NdeF58MtUmYE7rgpSzHA4Ilke0sHlMqPANkrZEudFK0RYm5MfTpP/s4Ga
         zW1HeN0uelHRkHaABPcmIdqJBVT4QvqCgK1/PBqH2yqrko+u3/kb0jmSz/FnArnW0Kqh
         wrFJRW6IeMWEJW/aUiQsaSI9Xxiw3LH/pbgdrhIti3ipTb0RUrDI2ehb/mTLq/y2lpBh
         W4nEVl1stzehvrVw5xWZnqomsyIQkIRFXHzVqK+nmyXlm+P1JPB8V4Y4cT2wxjx49U3H
         ZH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688102725; x=1690694725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WzaczCUBTZTvAfZLPO+zN4aCSdU9+F5DHZ/dQrcjWzU=;
        b=MV8yNn+L7ocIjRPqPyttH7xbtFNriPogbbBwGXW2TL/aCgQIm/6nZb8AF8pYmt8Y/A
         k4miyfeHHn6t1HX9lsKiUGf3ax+XUihzzwoaiQD6ECr8XcFpPJqCxwJgYMoXKX2yNKag
         xfDWOP5rSefvyjd0Pw6rnkEOnAglU9TeZxYEOfcSSRXkQuVcJ+xmeFW6xpwpv3UGqfoz
         f9iB0D2uqbCvBQz+cQqtbOQ0O/qNAVgVKJIRFd4mdtGM0V9ToazMgop6piouCRIIyMrk
         1aI2Y5jOLmc9hCz7nxx+mRkqE35GRlck/sMXzO95hUo8hdgPbS8+IKUfxp3fC/bEw5ZG
         NZXA==
X-Gm-Message-State: ABy/qLY4Wd6fvEzYLbzV69k/Yz5JHkscWjgFRX5WcaMDmo6UGmsR64fS
        D2NYSkc1CcNHxeL+JnxMN08E2kVIEilcGzYCOaPXtQ==
X-Google-Smtp-Source: APBJJlEerSM3CUZkODwE5AWzXSKWK4mLESDhEoDSC1FUtMU+f/Z6odp2bCPSDoFODGkGksQKGE17TmrF/h6P0IVn9PA=
X-Received: by 2002:a17:90a:3e0c:b0:262:ea83:ed34 with SMTP id
 j12-20020a17090a3e0c00b00262ea83ed34mr1463410pjc.0.1688102725225; Thu, 29 Jun
 2023 22:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230629184151.705870770@linuxfoundation.org> <CAEUSe7__cNqH6d1D96m8XriVckS9MnL6CRfd+iTYXnNkqu9nvQ@mail.gmail.com>
 <2023063037-matrix-urologist-030d@gregkh>
In-Reply-To: <2023063037-matrix-urologist-030d@gregkh>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Thu, 29 Jun 2023 23:25:13 -0600
Message-ID: <CAEUSe7-K199dv5_11O877i4pWYtCkaZU2zrsfVo4-QnNPdPQ+A@mail.gmail.com>
Subject: Re: [PATCH 6.3 00/29] 6.3.11-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, 29 Jun 2023 at 23:19, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, Jun 29, 2023 at 03:54:03PM -0600, Daniel D=C3=ADaz wrote:
> > Hello!
> >
> > Early report of failures.
> >
> > Arm64 fails with GCC-11 on the following configurations:
> > * lkftconfig
> > * lkftconfig-64k_page_size
> > * lkftconfig-debug
> > * lkftconfig-debug-kmemleak
> > * lkftconfig-kasan
> > * lkftconfig-kselftest
> > * lkftconfig-kunit
> > * lkftconfig-libgpiod
> > * lkftconfig-perf
> > * lkftconfig-rcutorture
> >
> > lkftconfig is basically defconfig + a few fragments [1]. The suffixes
> > mean that we're enabling a few other kconfigs.
> >
> > Failure:
> > -----8<-----
> > /builds/linux/arch/arm64/mm/fault.c: In function 'do_page_fault':
> > /builds/linux/arch/arm64/mm/fault.c:576:9: error: 'vma' undeclared
> > (first use in this function); did you mean 'vmap'?
> >   576 |         vma =3D lock_mm_and_find_vma(mm, addr, regs);
> >       |         ^~~
> >       |         vmap
> > /builds/linux/arch/arm64/mm/fault.c:576:9: note: each undeclared
> > identifier is reported only once for each function it appears in
> > /builds/linux/arch/arm64/mm/fault.c:579:17: error: label 'done' used
> > but not defined
> >   579 |                 goto done;
> >       |                 ^~~~
> > make[4]: *** [/builds/linux/scripts/Makefile.build:252:
> > arch/arm64/mm/fault.o] Error 1
> > make[4]: Target 'arch/arm64/mm/' not remade because of errors.
> > ----->8-----
>
> Is this also failing in Linus's tree?

(Sorry for the previous top-post.)

No, only here on 6.3.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
