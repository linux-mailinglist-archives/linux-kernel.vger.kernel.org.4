Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C88968BFB6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjBFONq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjBFONc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:13:32 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AF5CA19
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:12:52 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id h19so12740427vsv.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 06:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oi4fqKc8ViThZjQcyqO7FU4A4DRmVAyIaUuFWO0o8PA=;
        b=ENMdbCUKsdJeStCp68yuZIVyU4btt9a3NnvqhNk5RTRik9YizwNzF/2VIBmQUL+RBS
         0ynlpVNAe8zrN7FQF6ypUVdYGrOroz9u2XpvcZiD3+LZ1bMw8mK3ORtvWM4eIw2m08IC
         wgdL+XCUVRd8n57GvmhdNRduw4VVXuWzuUehpPhg5dhkeRuUDZsekrzkaBF7hNH2iTaU
         hvacjikDM82a0bZokqre4bb3JsfJWnqK/p0aCjgOqlB1cR2lDGXDSE+uuwAG+2YfkQUd
         3f7khg7THRhdOBlp36aRaZY712HodWYssDxvviJiOwWqkkOUXZF2rf/9rzU2GvSl/JWd
         7PFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oi4fqKc8ViThZjQcyqO7FU4A4DRmVAyIaUuFWO0o8PA=;
        b=yjvlSDt+Kz/SersOPKfns0f66H3qq1OOotpuJ4yWW/femfuV4LZ3Lq0rvs32zz3Q8N
         LSIB6eCy1k0LG6gRIHgmU71X+bAIG9D6pMA3O0mJ/V4/Ut2EbSJ0V2lG3PCj9WxgE9tO
         Bhd9kwrvCm1o86YJyXPvM6uCStj/BddBDbv7b4l2o4B888mHhE//yCCr3PtOvhrrx+ny
         KzK6GOpay4JJ6DCsWanwEooMsK2P5Bmw0pFQxwx3KovxKSg6OEltbcZXeCkknzN+1WYq
         piRY1a0zYQ01qjNgoUapheNoVwjgG4KNwxcP5An1FIwp/sGvzpCILKrOytJEOleHoEWx
         SbzA==
X-Gm-Message-State: AO0yUKWIR3HxZfmIsdky9StZYymZr5my4Sf7YF7fhy9xGa40k0INbIIw
        qVLV4HhO3VW7frYdTYBlgvocr+FbhXssSnJ+MjiCJw==
X-Google-Smtp-Source: AK7set9W1cqOslAljm2IbR0q5/qXbpfuRcZDUXKQ9VdbxWjIqw0l7z2qUW2rV1oj8sf/RuL5HumAJyO1vdB31QJ+GPI=
X-Received: by 2002:a05:6102:204d:b0:3f1:53d4:9e87 with SMTP id
 q13-20020a056102204d00b003f153d49e87mr2718607vsr.34.1675692770852; Mon, 06
 Feb 2023 06:12:50 -0800 (PST)
MIME-Version: 1.0
References: <20230203101009.946745030@linuxfoundation.org> <CA+G9fYtsSuw=W0LSpzJRzsXB6qGYS3og1v=FOrvPHSAdRPCDPA@mail.gmail.com>
 <Y+AIsz4/7Ms28aWK@dev-arch.thelio-3990X>
In-Reply-To: <Y+AIsz4/7Ms28aWK@dev-arch.thelio-3990X>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 6 Feb 2023 19:42:39 +0530
Message-ID: <CA+G9fYtN=0nMkkUE7FAFutK5jLS--fr_ZcrJw0nb5BhMqQoZUA@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/28] 6.1.10-rc1 review
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2023 at 01:21, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi Naresh,
>
> On Sat, Feb 04, 2023 at 12:55:10PM +0530, Naresh Kamboju wrote:
> > On Fri, 3 Feb 2023 at 15:50, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 6.1.10 release.
> > > There are 28 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >
> > > Responses should be made by Sun, 05 Feb 2023 10:09:58 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/pa=
tch-6.1.10-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git linux-6.1.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> >
> > Results from Linaro=E2=80=99s test farm.
> > No regressions on arm64, arm, x86_64, and i386.
> >
> > Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > NOTE:
> >
> > clang-nightly-allmodconfig - Failed
> >
> > Build error:
> > -----------
> >   include/linux/fortify-string.h:430:4: error: call to '__write_overflo=
w_field'
> >    declared with 'warning' attribute: detected write beyond size of fie=
ld
> >    (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warn=
ing]
> >
> > This is already reported upstream,
> > https://lore.kernel.org/llvm/63d0c141.050a0220.c848b.4e93@mx.google.com=
/
>
> I think you copied the wrong warning, as the one upstream is a write
> warning, whereas the one I see in your build logs is a read error:

You are right !
Thanks for checking build logs.

>
> In file included from /builds/linux/drivers/infiniband/core/cma.c:9:
> In file included from /builds/linux/include/linux/completion.h:12:
> In file included from /builds/linux/include/linux/swait.h:7:
> In file included from /builds/linux/include/linux/spinlock.h:56:
> In file included from /builds/linux/include/linux/preempt.h:78:
> In file included from /builds/linux/arch/x86/include/asm/preempt.h:7:
> In file included from /builds/linux/include/linux/thread_info.h:60:
> In file included from /builds/linux/arch/x86/include/asm/thread_info.h:53=
:
> In file included from /builds/linux/arch/x86/include/asm/cpufeature.h:5:
> In file included from /builds/linux/arch/x86/include/asm/processor.h:22:
> In file included from /builds/linux/arch/x86/include/asm/msr.h:11:
> In file included from /builds/linux/arch/x86/include/asm/cpumask.h:5:
> In file included from /builds/linux/include/linux/cpumask.h:12:
> In file included from /builds/linux/include/linux/bitmap.h:11:
> In file included from /builds/linux/include/linux/string.h:253:
> /builds/linux/include/linux/fortify-string.h:543:4: error: call to '__rea=
d_overflow' declared with 'error' attribute: detected read beyond size of o=
bject (1st parameter)
>                         __read_overflow();
>                         ^
>
> Regardless, this is still a clang bug that we are actively investigating,=
 so it
> can still be safely ignored by the kernel folks.
>
> https://github.com/ClangBuiltLinux/linux/issues/1687

Thank you.

> Cheers,
> Nathan

- Naresh
