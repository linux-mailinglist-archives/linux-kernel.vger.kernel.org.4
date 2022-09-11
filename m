Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AC35B4EBA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 14:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiIKMWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 08:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiIKMWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 08:22:20 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0079326C3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 05:22:18 -0700 (PDT)
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 28BCLrdL027206;
        Sun, 11 Sep 2022 21:21:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 28BCLrdL027206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662898914;
        bh=07On58pfAqeOPq4SkhwmI7FDSiggencyKc6cl9k18mg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dJMv7n+wlGbFk5b6w07BTCC2ykK9x39n82TqtW3YMB3HZOBYegrwB0giz2raRx/ml
         4yx955rw6BYEfWPp1/98STbneSPZUlkZ7ZA2AgZ9BbSW9JT36LaCmIy+VfN6d+8KEU
         /ctj/EBHWfuWBk814AnmytwBG9Ryvygg/fQ2jc3K+ULSVpLyeg1v/kSJOMiUdiOp1S
         NOnmmpHBtN0uCJd92A4gBv+e4WfmqjefDpCHeMqWL/KJPhLMXL/MJwllrspUozJ4O5
         S3FyPagW33DtNBUrGlkdJRs5EAnWb3BNy82rZ9fjGLjcl0AhAxVlDIn2ut7DpllNzq
         E5SPhuNSK4gYA==
X-Nifty-SrcIP: [209.85.160.53]
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-127dca21a7dso16382158fac.12;
        Sun, 11 Sep 2022 05:21:54 -0700 (PDT)
X-Gm-Message-State: ACgBeo3/TM45+z2BUVIxV+AKOMmMr1Wf2a3PQ5KMToWxxHp15CAvsbI/
        eLjwKDuGp0kxwXzR5Hay1PiPPvwfOw29gtGIInc=
X-Google-Smtp-Source: AA6agR4mmN3oWojOW4OyzpDwjNMuHZ5shgZclcZMD4/8WBxQTrzs7mm0t4r8VgIgsbuMgBYDyJe3ol8lYCxc862U/y8=
X-Received: by 2002:a54:400c:0:b0:34f:9913:262 with SMTP id
 x12-20020a54400c000000b0034f99130262mr900341oie.287.1662898912945; Sun, 11
 Sep 2022 05:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <202209101939.bvk64Fok-lkp@intel.com> <CAKwvOdn0i3N1DZCmx1RNoiq3086hBi_S2tkDmqNRhDx5-6rSeQ@mail.gmail.com>
In-Reply-To: <CAKwvOdn0i3N1DZCmx1RNoiq3086hBi_S2tkDmqNRhDx5-6rSeQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 11 Sep 2022 21:21:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNASbcsLqUU+WsO7zQ-toucvkd1ePGX_HW7ehrywoS-cUMQ@mail.gmail.com>
Message-ID: <CAK7LNASbcsLqUU+WsO7zQ-toucvkd1ePGX_HW7ehrywoS-cUMQ@mail.gmail.com>
Subject: Re: [masahiroy:fixes 6/6] arch/mips/kernel/branch.c:712:20: error:
 instruction requires a CPU feature not currently enabled
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     clang-built-linux <llvm@lists.linux.dev>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>,
        linux-mips <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2022 at 2:56 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sat, Sep 10, 2022 at 12:24 PM kernel test robot <lkp@intel.com> wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git fixes
> > head:   97f72ed7a6b5a6bbac628f1f6e91cf06d1ea2cb5
> > commit: 97f72ed7a6b5a6bbac628f1f6e91cf06d1ea2cb5 [6/6] Makefile.compiler: Use KBUILD_AFLAGS for as-option
> > config: mips-loongson2k_defconfig (https://download.01.org/0day-ci/archive/20220910/202209101939.bvk64Fok-lkp@intel.com/config)
>
> This is likely:
> arch/mips/loongson2ef/Platform
> 28:cflags-$(CONFIG_CPU_LOONGSON2EF)     += $(call
> as-option,-Wa$(comma)-mno-fix-loongson3-llsc,)
> arch/mips/Makefile
> 155:cflags-y += $(call as-option,-Wa$(comma)-mno-fix-loongson3-llsc,)
>
> probably both need to use cc-option similar to
> https://lore.kernel.org/llvm/20220907045907.484043-2-ndesaulniers@google.com/
>
> Masahiro, I'm at Linux Plumbers Conf; not sure when I can get to a
> formal patch.  Want to drop my 2 patches and I'll send a v4 at some
> point?



OK, dropped.

Thanks.






-- 
Best Regards
Masahiro Yamada
