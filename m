Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55A5639862
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 23:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiKZWOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 17:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKZWOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 17:14:19 -0500
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3A511816
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 14:14:17 -0800 (PST)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 2AQMDuxC012288
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 07:13:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 2AQMDuxC012288
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1669500837;
        bh=s0a/zjAuK1ndkJmMZDENgzv3OKHe1ZW/pI+qHIjiGXc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r4RPRmXrX2+AHDAToBmubkRg7hqChal7AwE/5XsNlEXRH4u+hVz9/l+w9P+qTSVJD
         uMYcUjwZzYuw9gkg7lVWjSSzpQX63kvmPMf15/0lwmAuayYD4xck+oggIIUEOLJ8Gn
         4KjPJBI8/mhgWGytSLujQUunIrfs7vG6A4gbpFlKWiD2hVMfqKY7/KF+WII1CZG/pL
         8zA1mlFtp5wX9V0/x3LfmenKbK6Dcc26QcmPbkhdHUToSIB8XveWtDUVMXsvwVMhRq
         smwHUHz+mzbxry6N6qF78pnzxcAkiHd632TDf8LXrzmBiq+wGf/YQsNr3V3rV8YWYI
         JqRDS/x9kWffw==
X-Nifty-SrcIP: [209.85.161.47]
Received: by mail-oo1-f47.google.com with SMTP id j6-20020a4ab1c6000000b004809a59818cso1146024ooo.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 14:13:57 -0800 (PST)
X-Gm-Message-State: ANoB5pnKI5LTSgwcKRy1Ejs9u8JPmIYhDOQOTUcHStGcvD/XBmK2n8tc
        hfQ+fw8tp6R9x1Py0Q+y+PLbRRhzK0IWgVFJwNw=
X-Google-Smtp-Source: AA0mqf76l2wK3mKIAJDJVFArHaLGuBw/aE77Bp4mfFOjNad9WnYlYwpqmqrPYE5zkcyqlZw2pKl6aDCh1wOE1MLpfdw=
X-Received: by 2002:a4a:b145:0:b0:49f:449a:5f6c with SMTP id
 e5-20020a4ab145000000b0049f449a5f6cmr10807854ooo.93.1669500836106; Sat, 26
 Nov 2022 14:13:56 -0800 (PST)
MIME-Version: 1.0
References: <20221126051002.123199-1-linux@weissschuh.net>
In-Reply-To: <20221126051002.123199-1-linux@weissschuh.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 27 Nov 2022 07:13:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNASre69jM6symHY3h2fDPmN=kmZqOVGVrrVAvZ+8UzXxqA@mail.gmail.com>
Message-ID: <CAK7LNASre69jM6symHY3h2fDPmN=kmZqOVGVrrVAvZ+8UzXxqA@mail.gmail.com>
Subject: Re: [PATCH 1/3] firmware_loader: remove #include <generated/utsrelease.h>
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
> utsrelease.h is potentially generated on each build.
> By removing this unused include we can get rid of some spurious
> recompilations.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---

Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>


>  drivers/base/firmware_loader/firmware.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmw=
are_loader/firmware.h
> index fe77e91c38a2..bf549d6500d7 100644
> --- a/drivers/base/firmware_loader/firmware.h
> +++ b/drivers/base/firmware_loader/firmware.h
> @@ -9,8 +9,6 @@
>  #include <linux/list.h>
>  #include <linux/completion.h>
>
> -#include <generated/utsrelease.h>
> -
>  /**
>   * enum fw_opt - options to control firmware loading behaviour
>   *
>
> base-commit: 0b1dcc2cf55ae6523c6fbd0d741b3ac28c9f4536
> --
> 2.38.1
>


--=20
Best Regards
Masahiro Yamada
