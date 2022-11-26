Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316B3639867
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 23:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiKZWTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 17:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKZWTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 17:19:01 -0500
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC2718E1B
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 14:19:00 -0800 (PST)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 2AQMIlnY014115
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 07:18:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 2AQMIlnY014115
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1669501128;
        bh=eCoWv21FlmpHLwc97EGzHeLTUW/a+GA8t8Cm/ZadSPA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H1NXzImV6t9rh6H+zukX1U9G5gNCaZqJwJpSQrTN/iJQJGvTgGAaKp/Wkfkpp9Ncs
         uHVQmUvw8db/MGbc7ZojBF94+nFJDgviM9vfGJfcYZbOOU9eXwj2MmHBi+Od8yfJHz
         zcKMQ0y9Xhyn0bVuZjhYZYWFt6IVP3CNQJ11NI3+5NkZhBUXT9+C7HFJNneMcY0f2+
         4EciOMdBJzjnotVxXvRaSEWAbX6xs6Xyx+OWEIsnf3KFlpFqmq3xMMXlyXZWTSvKSV
         8aifW98sNvQwZeDuTfNvA09Wo4w0sf5ux5GsM4Kv3Uk/wTAebZbylg1/bbE/miLEaO
         wyuDCy6Ec3S6Q==
X-Nifty-SrcIP: [209.85.167.177]
Received: by mail-oi1-f177.google.com with SMTP id r76so7905256oie.13
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 14:18:48 -0800 (PST)
X-Gm-Message-State: ANoB5pmuylHV+CUSlvwu6/qH0qQVNPwkn3xXFlhfPcQHtZzQDVN7SgW2
        I7w9UDJvX1rep1PtlptozXKDKkJVE4ouCZEFhJs=
X-Google-Smtp-Source: AA0mqf5n1/RIeUfwDyZLminfvFm1O0saHRY4Zh7CYxiBKtXxUzb8vn1K4cCYK1laaA3SYsvpI3YO38U22j/k9BMNlRU=
X-Received: by 2002:a05:6808:3009:b0:354:94a6:a721 with SMTP id
 ay9-20020a056808300900b0035494a6a721mr12844494oib.194.1669501127494; Sat, 26
 Nov 2022 14:18:47 -0800 (PST)
MIME-Version: 1.0
References: <20221126051002.123199-1-linux@weissschuh.net> <20221126051002.123199-3-linux@weissschuh.net>
In-Reply-To: <20221126051002.123199-3-linux@weissschuh.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 27 Nov 2022 07:18:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNAREVSp_5d1SaFOLyBHJJrJ6zE_qxSYWAFFnfoz3d0w3-Q@mail.gmail.com>
Message-ID: <CAK7LNAREVSp_5d1SaFOLyBHJJrJ6zE_qxSYWAFFnfoz3d0w3-Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] init/version.c: remove #include <generated/utsversion.h>
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
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

On Sat, Nov 26, 2022 at 2:10 PM Thomas Wei=C3=9Fschuh <linux@weissschuh.net=
> wrote:
>
> Commit 2df8220cc511 ("kbuild: build init/built-in.a just once") moved
> the usage of the define UTS_VERSION to the file version-timestamp.c.

With s/UTS_VERSION/UTS_RELEASE/,


Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>

>
> version-timestamp.c in turn is included from version.c but already
> includes utsversion.h itself properly.
>
> The unneeded include of utsversion.h from version.c can be dropped.
>
> Fixes: 2df8220cc511 ("kbuild: build init/built-in.a just once")
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>  init/version.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/init/version.c b/init/version.c
> index 01d4ab05f0ba..f117921811b4 100644
> --- a/init/version.c
> +++ b/init/version.c
> @@ -15,7 +15,6 @@
>  #include <linux/printk.h>
>  #include <linux/uts.h>
>  #include <linux/utsname.h>
> -#include <generated/utsrelease.h>
>  #include <linux/proc_ns.h>
>
>  static int __init early_hostname(char *arg)
> --
> 2.38.1
>


--=20
Best Regards
Masahiro Yamada
