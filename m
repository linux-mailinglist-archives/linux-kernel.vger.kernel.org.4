Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E671F5E9CA8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbiIZI5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbiIZI5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:57:39 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85B73DBD4;
        Mon, 26 Sep 2022 01:57:37 -0700 (PDT)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 28Q8vHsj010624;
        Mon, 26 Sep 2022 17:57:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 28Q8vHsj010624
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664182637;
        bh=vlkbVUYC6luO+m9Ikti3NG43M3VtHm2puQBFVEFsQrY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KY7QXY1dq9zl60QZkjgo2j9B17vAiVIW7LuJ9oTkHb2YImiFCF3pUsOaFC5NNc0YU
         rIBfQqtacpcxFCU2AihjOyIpNClPgY0ixCMdL4JV1r2gIc18T/zxhdckbLfZwFZmVD
         dPNpZ/rRZLu4oMo1/oxJxo0yeOqowKjAJZpvrTizOex74idCZZpEYrHOxl6j/2x2dU
         iiieZbX50Ca58ivODWDy8rU9iRsHXb4OzJX7QSkZTEaGTq5RUdFxe/9o2d6O0a1zyz
         QP9yMVerbJWlQfT60eRsCf65o4wcc43oXSeFQ+tLGVdRFJJ69OQaZool3qV+t08Yuk
         Uj7klbYVvXR6g==
X-Nifty-SrcIP: [209.85.167.178]
Received: by mail-oi1-f178.google.com with SMTP id v130so7462738oie.2;
        Mon, 26 Sep 2022 01:57:17 -0700 (PDT)
X-Gm-Message-State: ACrzQf3gPOlO6xCNuUMHNxNLPNyeuFjAbdCfpTlrAs+lYAHbCwBrabMM
        mmnwZDWg7kpn/dZqGoAWvSzLRwKzoPH8D0CAAyQ=
X-Google-Smtp-Source: AMsMyM5lTuCqBocFYoR82VLsqcYSHYEXb4vwAWkRiOaytmxxtyxns+2TLiPuEomBdT8w0SIPiBJSgUYqG6rIWeplWQ0=
X-Received: by 2002:a54:400c:0:b0:34f:9913:262 with SMTP id
 x12-20020a54400c000000b0034f99130262mr9358774oie.287.1664182636355; Mon, 26
 Sep 2022 01:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAH7mPvj64Scp6_Nbaj8KOfkoV5f7_N5L=Tv5Z9zGyn5SS+gsUw@mail.gmail.com>
In-Reply-To: <CAH7mPvj64Scp6_Nbaj8KOfkoV5f7_N5L=Tv5Z9zGyn5SS+gsUw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 26 Sep 2022 17:56:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS_vgMXAVdmSBV=nrXL5Covd2tMX0weXtst3WoL_JGwsw@mail.gmail.com>
Message-ID: <CAK7LNAS_vgMXAVdmSBV=nrXL5Covd2tMX0weXtst3WoL_JGwsw@mail.gmail.com>
Subject: Re: Any interest in building the Linux kernel from a MacOS host?
To:     Nick Desaulniers <nick.desaulniers@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "marcan@marcan.st" <marcan@marcan.st>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        asahi@lists.linux.dev,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 4:51 PM Nick Desaulniers
<nick.desaulniers@gmail.com> wrote:
>
> Not sure if this is potentially interesting to anyone but I was able
> to get the kernel building from MacOS my M2 Air with a small amount of
> effort (read: duct tape and bailing wire).  If this might seem helpful
> to anyone's workflow, I wouldn't mind pursuing this (with some
> cleanup, sending a more formal patch set).  Maybe this helps us
> bootstrap or get Linux up and running sooner on these machines?
>
> Take a look at the commit message linked below for the trials & tribulati=
ons:
> https://github.com/ClangBuiltLinux/linux/commit/f06333e29addbc3d714adb340=
355f471c1dfe95a
>
> Thanks,
> ~Nick Desaulniers



I see some efforts in this direction, for example,


commit dd2a3acaecd7abb2d43b09a823cf2e4c967fa2ac
Author: Andreas Bie=C3=9Fmann <andreas@biessmann.de>
Date:   Fri Feb 24 08:23:53 2012 +0100

    mod/file2alias: make modpost compile on darwin again



I do not mind a small amount of code addition.
It may be broken from time to time because there are less number of
developers testing kernel builds on macOS.


--=20
Best Regards
Masahiro Yamada
