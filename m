Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B7874CB05
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 06:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjGJEIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 00:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGJEIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 00:08:16 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A64E6;
        Sun,  9 Jul 2023 21:08:15 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1b055511b85so3069201fac.2;
        Sun, 09 Jul 2023 21:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688962094; x=1691554094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SI9RNcelEJRqjgZ3cj4A/MldUxL+d7rqihkZbBH1AFY=;
        b=iVKpTnqvNrUhmIj8Pead4qxzUx+5FEqEj2o2LZQPy/bO+4COQLAPUA2tYXOc/R2BgT
         WXXxngVaWFUrztbY3CREIS4d8vXvIbEUHInTqWO8/fcCVi/k61dqCs9L57T6/hQPeoTL
         djqWGsASDlN37qpDOunajF78cc7Miv4m5fR9daAJazyNoH/Jv0IoP4QuI8R0xXektt0Z
         BzUZmv9QLZnpwucS2nyyz/xwdmr7pR9/9w8M76YZcl6WiWHbfX6msKl+3Dl0nSAnHW2A
         n70RJ3CEVgoCVyWZRzjwy1vt9eb2l4ZKA4WC/qtPMPfB6EBkvQiU2qne580vUi/Mhbov
         qXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688962094; x=1691554094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SI9RNcelEJRqjgZ3cj4A/MldUxL+d7rqihkZbBH1AFY=;
        b=Q+6EfR1EDMLqnHzGYGsPkafP0E0jQu7zzhMUYm3JldflAl4oVD28Gcf339ZSmUKRLr
         smf87vNhaJV+oofS0ivFwj6W9U+fDOtMhIn+OM3TK/LXEMOzjVf/AmzTZBN1HgnicZft
         S/Obo74NidK1npRdVG+4KR5979ZVBj5v72rGZNQf1OasFS/P9hZGGvZDqfb6onFhRY23
         jQlxtjH8CKPrlY68nYfsQ78hBmlA4AJ10UuLvVXHMg6eO57sFrOBpP8N+QQFR5YQ19Hi
         f62c+EGoyOhhRdgpEQM9aV1DZNu1n84sKTOW0xB0EDDwxqrqxtwelTChHp15+AvShg2c
         vB8A==
X-Gm-Message-State: ABy/qLbFyEQeRZl+AwMSrPQt35A0E7SMGvET5Ja4VLnK/Q6yzxg4J/xp
        S500PhueBJXt6tAB4iPZb+rjfXbYkETShM3BPfg=
X-Google-Smtp-Source: APBJJlGmSNmHOoafZjLJZz8/wV792WRpiff+2GDpJxWf6XS+WYjRR+08RhvbYCi14YACNX/qF8Zpr859L/3Uxipik8M=
X-Received: by 2002:a05:6870:438f:b0:1b0:25b4:4b77 with SMTP id
 r15-20020a056870438f00b001b025b44b77mr12556779oah.14.1688962094392; Sun, 09
 Jul 2023 21:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230707095415.1449376-1-arnd@kernel.org> <20230707095415.1449376-4-arnd@kernel.org>
In-Reply-To: <20230707095415.1449376-4-arnd@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Sun, 9 Jul 2023 21:08:03 -0700
Message-ID: <CAMo8BfLOYkdxF4x=E2L4OYavw+GDtO0ftdAxCaVuFwGr=RUCyw@mail.gmail.com>
Subject: Re: [PATCH 4/4] vgacon, arch/*: remove unused screen_info definitions
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org, Ard Biesheuvel <ardb@kernel.org>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@quicinc.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 7, 2023 at 2:56=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wrot=
e:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> A number of architectures either kept the screen_info definition for
> historical purposes as it used to be required by the generic VT code, or
> they copied it from another architecture in order to build the VGA
> console driver in an allmodconfig build.
>
> Now that vgacon no longer builds on these architectures, remove the
> stale definitions.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/csky/kernel/setup.c          | 12 ------------
>  arch/hexagon/kernel/Makefile      |  2 --
>  arch/hexagon/kernel/screen_info.c |  3 ---
>  arch/nios2/kernel/setup.c         |  5 -----
>  arch/sh/kernel/setup.c            |  5 -----
>  arch/sparc/kernel/setup_32.c      | 13 -------------
>  arch/sparc/kernel/setup_64.c      | 13 -------------
>  arch/xtensa/kernel/setup.c        | 12 ------------

For xtensa:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max
