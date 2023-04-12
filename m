Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876F96DF276
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjDLLCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjDLLB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:01:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961076A69;
        Wed, 12 Apr 2023 04:01:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EC5B63255;
        Wed, 12 Apr 2023 11:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957CAC433A0;
        Wed, 12 Apr 2023 11:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681297313;
        bh=m4MkntAwRdrJQvlcVw3ImSl6t9gAMmJf4idgPyet3/I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e9R3x3vbWWNRynJa3g3OiAu8BOVVGwpC1XVn6QP20DTuhHyfV96n40Ouf37IGrZOt
         QHVVHb1NphfYDaMjGXfgSwmz3gmEtSGs7iaMBf7NxYmF+UF19fQ1pFwtt/Ya8gXOrI
         +QphtCsB8/MJaNCSb8B1LEh+paXr2bz2AIE8bSMmOhJLsN8e9yVw3aAcEIJGHr3FKR
         1/V+qA4pd1aoQ3i1VOvGaXRKYz3MDt357VOHMLJvX3urSlbggMOmR6LcZiBUVDMO/x
         HENTlcmW38yEoRLdY/wfEsR+ep6yDFni4IvJv+5T7Bbl3NTbOgNWmCfplG1p8gslei
         MU1yRdoUJNQrQ==
Received: by mail-lf1-f53.google.com with SMTP id t20so14125741lfd.5;
        Wed, 12 Apr 2023 04:01:53 -0700 (PDT)
X-Gm-Message-State: AAQBX9cadUQFC1AQG2H/LNTyax4GGNqdjco0P8ztbD8LxNyXZtsnS2z1
        DuQVJONMlZUUI0gTZKpxyZO0xooQoqKgIoyaAEI=
X-Google-Smtp-Source: AKy350bBrEEeUjMPiOADMBl9lCxlgmRE866oGWs7cWi45kEUL5WSFF569KIpg3BQ+5JMcmBNHVg6r1O9vDQSMCZvhdM=
X-Received: by 2002:ac2:4905:0:b0:4eb:dcc:52ce with SMTP id
 n5-20020ac24905000000b004eb0dcc52cemr583176lfi.9.1681297311590; Wed, 12 Apr
 2023 04:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsWEYWjPYLOiSuKfsqLzzbvq8p=mATJLahobEhTWOJ5+A@mail.gmail.com>
In-Reply-To: <CA+G9fYsWEYWjPYLOiSuKfsqLzzbvq8p=mATJLahobEhTWOJ5+A@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 12 Apr 2023 13:01:40 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGhS1JrzxpcRz05ABNwABniNJnBQ4uXGwYMDbE9qSZvfw@mail.gmail.com>
Message-ID: <CAMj1kXGhS1JrzxpcRz05ABNwABniNJnBQ4uXGwYMDbE9qSZvfw@mail.gmail.com>
Subject: Re: next: arm: #pragma message "The platform is deprecated and
 scheduled for removal
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2023 at 08:21, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Following arm build regressions noticed on Linux next-20230412.
> We need to investigate the list of platforms that are getting deprecated
>  and we will stop building platforms.
>
> Regressions found on arm:
>
> - build/clang-nightly-s3c6400_defconfig
> - build/gcc-12-s3c6400_defconfig
> - build/gcc-8-s3c6400_defconfig
>
> arch/arm/mach-s3c/s3c64xx.c:423:9: note: '#pragma message: The
> platform is deprecated and scheduled for removal. Please reach to the
> maintainers of the platform and linux-samsung-soc@vger.kernel.org if
> you still use it.Without such feedback, the platform will be removed
> after 2024.'
>   423 | #pragma message "The platform is deprecated and scheduled for
> removal. " \
>       |         ^~~~~~~
> arm-linux-gnueabihf-ld: arch/arm/vfp/entry.o: in function `do_vfp':
> arch/arm/vfp/entry.S:27: undefined reference to `vfp_entry'
> make[2]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 1
>

Thanks for the report. This has been fixed now in rmk's tree
