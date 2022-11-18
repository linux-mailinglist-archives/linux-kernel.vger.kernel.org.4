Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C89662FF2C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 22:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiKRVI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 16:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiKRVIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 16:08:51 -0500
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FD22D1E6;
        Fri, 18 Nov 2022 13:08:48 -0800 (PST)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 2AIL8Vfu010629;
        Sat, 19 Nov 2022 06:08:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 2AIL8Vfu010629
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1668805712;
        bh=MeBNvxRxh9A/m0IrLHY4qRwLUfPaCWNGrltukchBfQI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SPY0hpve8al2WWWO8KMqHaYRc3/Zp7LwRRc/tKb2RDC11bD3rCJuYaG1mQuYcPq6M
         kWKzudUOCtJU/kkALI9gSwoqRHqyiFlq2YcjbA/Jmlu4RPrSPhltdiGiH1UXJC4Bw3
         JeEz8fVkTJjXmlObs6F5TZ9qgJmGkzMX1Vk2WvF6XTxACZISwgRWCkUVIJoIMb6c7z
         JqTMRoHvliEZuZeDPKHpm9O3iI45PoT7vLqygTmtw6/Emcxpdv2SV9ZyuL/eX3HTP4
         J0g5ep+xfRfGBTiQsxTrK02/qNhyHPextzVGS4wcefAqW7V4oGVmCE4aki5bNxpv/2
         1Q5wG3aHFCKTA==
X-Nifty-SrcIP: [209.85.210.51]
Received: by mail-ot1-f51.google.com with SMTP id p10-20020a9d76ca000000b0066d6c6bce58so3814557otl.7;
        Fri, 18 Nov 2022 13:08:32 -0800 (PST)
X-Gm-Message-State: ANoB5pl9QFDkuAfIrsQaYQJmopZa1MCGzthb/ZNjNesu9yox7GXt4oqE
        QHzRdEVh98Ryl/1rczEm7ABr3Fk4daNQx1+6hRE=
X-Google-Smtp-Source: AA0mqf4AtJDvReYVXE7OCM7SPmwCMZ+JzCefyPdJmJ0JfWrkv3y3m7EATeCEJOqKn4+XfjP4Rg+qe4Oe0NXs5FRlLug=
X-Received: by 2002:a05:6830:1b67:b0:661:8d9e:1959 with SMTP id
 d7-20020a0568301b6700b006618d9e1959mr4774176ote.225.1668805710944; Fri, 18
 Nov 2022 13:08:30 -0800 (PST)
MIME-Version: 1.0
References: <20221118195307.86049-1-masahiroy@kernel.org> <20221118195307.86049-2-masahiroy@kernel.org>
In-Reply-To: <20221118195307.86049-2-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 19 Nov 2022 06:07:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS4cRT7Jgdp10HUB4gCMU9OHOq3DKEHVfHhYzkbOPqsdw@mail.gmail.com>
Message-ID: <CAK7LNAS4cRT7Jgdp10HUB4gCMU9OHOq3DKEHVfHhYzkbOPqsdw@mail.gmail.com>
Subject: Re: [PATCH 1/6] kbuild: add test-{le,ge,lt,gt} macros
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2022 at 4:53 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Because GNU Make is only able to handle strings, it is very hard to
> perform arighmetic in Makefiles.


arighmetic -> arithmetic


>
> When we compare two integers, we invokes shell. One example is in the


invokes -> invoke



> top Makefile:
>
>   ifeq ($(shell test $(CONFIG_LLD_VERSION) -lt 130000; echo $$?),0)
>
> This is more expensive than using built-in functions since it forks a
> process.
>
> If we know the two have the same number of digits, we can do better.
>
> This commit adds four macros, test-le, test-ge, test-lt, test-gt.
>
> $(call test-lt, A, B) is evaluated to 'y' if A is less than B, or
> empty otherwise. This will replace $(call shell test A -lt B).
>
> Again, the limitation is that A and B must have the same number of
> digits because these macros are based on $(sort ) function.
>
>   $(call test-lt, 1, 9)    -->  y        (Works!)
>   $(call test-lt, 10, 9)   -->  y        (Not work...)
>
> To make the latter work, you need to add '0' prefix to align the number
> of digits:
>
>   $(call test-lt, 10, 09)  -->  empty    (Works!)
>
> Actually, we can live with this limitation in many places. As for the
> example above, we know $(CONFIG_LLD_VERSION) is 6-digits because the
> minimal supported version of LLVM is 11.0.0.
>
> So, the shell invocation can be replaced with more efficient code:
>
>   ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 130000),y)
>
> Of course, this assumption will break when LLVM 100 is released, but it
> will be far in the future.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---



-- 
Best Regards
Masahiro Yamada
