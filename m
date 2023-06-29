Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15E1742359
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 11:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjF2Ji6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 05:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjF2Jiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 05:38:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5B8ED;
        Thu, 29 Jun 2023 02:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688031526; x=1688636326; i=deller@gmx.de;
 bh=panwHVO6gMG/7LkBn+/2XCatbzRgXTbCGXRWA9nl57Q=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=nvQkac8XKmivKLlphuedgUmzOhkSznSA5SpqGx7Td4tl4vjfATgssDUL5ay926oNWX2dSQO
 NQdb8Ci1JJ5MYopbmOP1HqCznwDEoKJ49MliDMhW3qoMfKeOdheqipC6O8UB+wKydtkvqPzFO
 BZV1zBzLFRCaReJDJXEoEfR1PeofkIJBVAXWy93HleFjtuYR5D+jwfCqqevRXfJ2gMeomuz1Y
 1DL7IAp84xZx3eC9rt++2WkCzm5bqda1xTwSpsWg+1TfKg66N+0DJu7ERfx8r7E4+A8XmWtcD
 95m5Xx1p3AlBv2HQvUJIsWZYiRHOMONoafN5IRASwj3P3/XFHkXg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.146.6]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBUm7-1qKd7x0bN9-00CwzX; Thu, 29
 Jun 2023 11:38:46 +0200
Message-ID: <ec1e4376-56e0-c630-cbe6-b8bae2cb715a@gmx.de>
Date:   Thu, 29 Jun 2023 11:38:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: next: parisc: drivers/eisa/eisa-bus.c:436:19: error: conflicting
 types for 'eisa_init'; have 'int(void)'
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-parisc <linux-parisc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
References: <CA+G9fYsb4LCdjoXAz-o7myZfcCOQFdr2af68tYUP+JY17SikjQ@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <CA+G9fYsb4LCdjoXAz-o7myZfcCOQFdr2af68tYUP+JY17SikjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IQvvEQrpFvDa9wBerv9wVDcuJ4fRpGHs8tRS3z/dRy8YxRNGekX
 O4X53xB1ZK59Rjm/w7u2gleWKA1z51EWZ3+VuNmHuUK8gTtgm06ZYhlWpurtQGCn682EPOs
 XOdjVSvoSIcyjAnvbKK77G6mw652xy6A1NHDBnTdEmd1L5QeEOM3J46kFy6rLDQymd2X+sc
 M1h/28Ye7gP/9rGkox0AQ==
UI-OutboundReport: notjunk:1;M01:P0:wNKflYmbUC4=;QLixZxhr8vGzAoII5pLs7J7ttxy
 sz/zHyLSZbyP8abtPJ1mjH7xGYTZKVXyBtbLabU15GvvRhX3zEGVGa9Vbz/AFhOWV4tGLoJvd
 FJPZXBtstwyk2rOK4XZaCW0qyUCgPW1bO8+HgHVKcKC2C9XCEKGpGIq9DQbmwIFwwdOxIOzLf
 ZCokks7pB7/jFC2t5TzCwtZ9w2jCy27MWFUMZZhY1P8gNWuAEBPLSishE3y3DB975V2eT9vK7
 5K3No8a9Pe7b9i0eMVX4C84mWo3Hfw6/dLAMTXKHzS2eHO67YH0/0hSwoJWQE3HQ+HTSZ4zk0
 FSzs8bRBrbOXRv2+BzwsPRNx+wz/g4vhrQ3r81I3ma+Oe0jy/bdhy0LALwUzMWz9CqMRhoNTu
 FZcUNJxjRl3DaZi29DqqeT+xvoym4iVKQdjXpYKi2jRqn6+k4x4heLRViqNvGIjXui1mwmF8f
 mkODw5new5fjj8lcZgjQrkoc42EAv2a0CemIEBIBojQGtp7jtTbEXvsHnn7b1poV8g/LMuq+D
 6IDFV2JS39KuxzQj8Ipgoyn5i3z9lf9EQin+g6BMMesN38BkxXuQjING8oS6r8lf6pD5P3K92
 cxSAV9UUvOpHtYFXVaK164ZagkKFWfUwxAxuYIasnluVeKzORfQQ9U9DhVdul9dZRpJMW/XfL
 JRwb6wLJj/k4QgJyuAZaC9fmcbglRzEmjaAZoYxxhX/6KqGAoB9liZbtKSknctsZ1kI/gC1O+
 YgNhBoc8SHJ5Rx++TnYeNYuLKzDhokJDTJmkmkIwRGVtJPfAUhqQ4w09KnSOFVLErmZmm1chk
 mBJGjIp9VvmjVlZuE522kv943uwH5gl+H67G9oGyxRAmD3oDYdhxPrZ9i5ufJWGsSFmJw5ade
 sQ4phQ9gNNbd2/wAjf1OlkDuTeHLwP03mvrVOu0QKR4zB7d9hP0oCDKooEFex+PwQBsTAOMmL
 KEUt6+mW7xsYkIeaOR1jHBQweeA=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/23 09:51, Naresh Kamboju wrote:
> Following build error noticed on parisc with defconfig with gcc-11 on
> today's Linux next-20230629 tag.
>
> Regressions found on parisc:
>
>    - build/gcc-11-defconfig
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> drivers/eisa/eisa-bus.c:436:19: error: conflicting types for
> 'eisa_init'; have 'int(void)'
>    436 | static int __init eisa_init(void)
>        |                   ^~~~~~~~~


It's already fixed in latest parisc git tree.

Thanks,
Helge


> In file included from arch/parisc/include/asm/spinlock.h:7,
>                   from arch/parisc/include/asm/atomic.h:22,
>                   from include/linux/atomic.h:7,
>                   from arch/parisc/include/asm/bitops.h:13,
>                   from include/linux/bitops.h:68,
>                   from include/linux/kernel.h:22,
>                   from drivers/eisa/eisa-bus.c:8:
> arch/parisc/include/asm/processor.h:324:13: note: previous declaration
> of 'eisa_init' with type 'void(void)'
>    324 | extern void eisa_init(void);
>        |             ^~~~~~~~~
> make[5]: *** [scripts/Makefile.build:243: drivers/eisa/eisa-bus.o] Error=
 1
>
> Links,
> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-202306=
29/testrun/17921584/suite/build/test/gcc-11-defconfig/log
> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-202306=
29/testrun/17921584/suite/build/test/gcc-11-defconfig/details/
>
> Steps to reproduce:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> # pip3 install -U --user tuxmake
> #
> # Or install a deb/rpm depending on the running distribution
> # See https://tuxmake.org/install-deb/ or
> # https://tuxmake.org/install-rpm/
> #
> # See https://docs.tuxmake.org/ for complete documentation.
>
>
> tuxmake --runtime podman --target-arch parisc --toolchain gcc-11
> --kconfig defconfig
>
> --
> Linaro LKFT
> https://lkft.linaro.org

