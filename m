Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6246AADAD
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 01:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjCEArj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 19:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCEArg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 19:47:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE87F741
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 16:47:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 626E960906
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 00:47:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6889C433D2;
        Sun,  5 Mar 2023 00:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677977254;
        bh=gTJusva4QQ8ut+azWvsGLI6nvO2B8kQ/P1pT8VoQrU4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Cmx6j7z1rcbtRO3EoerGPUmswXfNk7SHk5QTByeDwjHu0ccl24Rz04BXazwE2fS3j
         FjVQcZeSfWi+UQLE1PtfAIg3hGO26sM5mLgcWNZxmwiyeJ3admDOvTeFSw/WMlMHJk
         2prUYVfq0q+JFAfwLvzoVJa2ooQ5aRGZBNYEn6qbj5jvGchoSZfHKoocIIqNenXk5k
         fW2m1wWT6tAi2g8o1m1nyFeVJxU11jOYBTgoY7oItF2naR7wDSBbsL3SY6V+6nEkRt
         szqMCSJA/Zg4wX0379VptnCLHOBF2VXeqTkkwyPlGl3Fbcsq1ikMzL4H+tjpFT9zY+
         8DqnlW007eadw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4BE1C5C036B; Sat,  4 Mar 2023 16:47:34 -0800 (PST)
Date:   Sat, 4 Mar 2023 16:47:34 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org,
        Vincent Dagonneau <v@vda.io>
Subject: Re: [PATCH 1/4] tools/nolibc: add stdint.h
Message-ID: <20230305004734.GA1270367@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230304142606.5995-1-w@1wt.eu>
 <20230304142606.5995-2-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230304142606.5995-2-w@1wt.eu>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2023 at 03:26:03PM +0100, Willy Tarreau wrote:
> From: Vincent Dagonneau <v@vda.io>
> 
> Nolibc works fine for small and limited program however most program
> expect integer types to be defined in stdint.h rather than std.h.
> 
> This is a quick fix that moves the existing integer definitions in std.h
> to stdint.h.
> 
> Signed-off-by: Vincent Dagonneau <v@vda.io>
> Reviewed-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> Signed-off-by: Willy Tarreau <w@1wt.eu>

I queued all three serieses, and it does look good, thank you!

make[1]: Leaving directory '/home/git/linux-rcu'
125 test(s) passed.

I am figuring on pushing these into the v6.4 merge window, that is,
the one after the current just-now-closing merge window.

						Thanx, Paul

> ---
>  tools/include/nolibc/Makefile |  4 ++--
>  tools/include/nolibc/std.h    | 15 +--------------
>  tools/include/nolibc/stdint.h | 24 ++++++++++++++++++++++++
>  3 files changed, 27 insertions(+), 16 deletions(-)
>  create mode 100644 tools/include/nolibc/stdint.h
> 
> diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
> index cfd06764b5ae..ec57d3932506 100644
> --- a/tools/include/nolibc/Makefile
> +++ b/tools/include/nolibc/Makefile
> @@ -25,8 +25,8 @@ endif
>  
>  nolibc_arch := $(patsubst arm64,aarch64,$(ARCH))
>  arch_file := arch-$(nolibc_arch).h
> -all_files := ctype.h errno.h nolibc.h signal.h std.h stdio.h stdlib.h string.h \
> -             sys.h time.h types.h unistd.h
> +all_files := ctype.h errno.h nolibc.h signal.h std.h stdint.h stdio.h stdlib.h \
> +             string.h sys.h time.h types.h unistd.h
>  
>  # install all headers needed to support a bare-metal compiler
>  all: headers
> diff --git a/tools/include/nolibc/std.h b/tools/include/nolibc/std.h
> index 1747ae125392..933bc0be7e1c 100644
> --- a/tools/include/nolibc/std.h
> +++ b/tools/include/nolibc/std.h
> @@ -18,20 +18,7 @@
>  #define NULL ((void *)0)
>  #endif
>  
> -/* stdint types */
> -typedef unsigned char       uint8_t;
> -typedef   signed char        int8_t;
> -typedef unsigned short     uint16_t;
> -typedef   signed short      int16_t;
> -typedef unsigned int       uint32_t;
> -typedef   signed int        int32_t;
> -typedef unsigned long long uint64_t;
> -typedef   signed long long  int64_t;
> -typedef unsigned long        size_t;
> -typedef   signed long       ssize_t;
> -typedef unsigned long     uintptr_t;
> -typedef   signed long      intptr_t;
> -typedef   signed long     ptrdiff_t;
> +#include "stdint.h"
>  
>  /* those are commonly provided by sys/types.h */
>  typedef unsigned int          dev_t;
> diff --git a/tools/include/nolibc/stdint.h b/tools/include/nolibc/stdint.h
> new file mode 100644
> index 000000000000..4ba264031df9
> --- /dev/null
> +++ b/tools/include/nolibc/stdint.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> +/*
> + * Standard definitions and types for NOLIBC
> + * Copyright (C) 2023 Vincent Dagonneau <v@vda.io>
> + */
> +
> +#ifndef _NOLIBC_STDINT_H
> +#define _NOLIBC_STDINT_H
> +
> +typedef unsigned char       uint8_t;
> +typedef   signed char        int8_t;
> +typedef unsigned short     uint16_t;
> +typedef   signed short      int16_t;
> +typedef unsigned int       uint32_t;
> +typedef   signed int        int32_t;
> +typedef unsigned long long uint64_t;
> +typedef   signed long long  int64_t;
> +typedef unsigned long        size_t;
> +typedef   signed long       ssize_t;
> +typedef unsigned long     uintptr_t;
> +typedef   signed long      intptr_t;
> +typedef   signed long     ptrdiff_t;
> +
> +#endif /* _NOLIBC_STDINT_H */
> -- 
> 2.17.5
> 
