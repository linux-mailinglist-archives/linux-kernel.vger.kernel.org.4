Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA946639865
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 23:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiKZWSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 17:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKZWST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 17:18:19 -0500
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D0917E28
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 14:18:17 -0800 (PST)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 2AQMHlpm015109
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 07:17:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 2AQMHlpm015109
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1669501068;
        bh=uMYjlILPqJ8SrLVYqEu74wUNH0+GPpNjC8d5G2tGxQY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IDbDsci9+nVR6gmDtSDJ27gLlrD3FoCIDzRzjzVasT2OMAbycfkQIri8cOe3Pwjto
         iaQUiV6xz/cGk16/IMGJDCRZF7GHQdUReg8IjN9vpgLu5kUMMDsXUTHD/DdldJ7p4D
         c+DBjOoop1l42hsbDTwP33vav+0Z7BFtzrLTi5j4w6Zr/bKH5HesccasItRo0wBYCr
         4EofMiJoOZVbhnhYQrAIAAcBi0MS4mZMD3ialo547Z5idYxrJ0db9fbt5jMcqwDPEe
         Vymmw2dihAIS0nwZCMtzBV2df5IVzmpJBndTJphCSASqjoaWKAW+n3xwt3NvcnGe64
         EiXMxQCbrZxQw==
X-Nifty-SrcIP: [209.85.167.178]
Received: by mail-oi1-f178.google.com with SMTP id m204so7922325oib.6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 14:17:47 -0800 (PST)
X-Gm-Message-State: ANoB5pkUK2S78j7gzmzyGmmN8a4TIaqPl0k4RoI2uhxSqhNZm4/fE4+t
        INrKNImZaCVhQ1F3OVb50v1r1GzXojwaxq7RybM=
X-Google-Smtp-Source: AA0mqf7DrCgQxqlmM/2+u7mcCqohRJuQjWmra2YCG3G/NdsvlzOWmND2/oMnaB4DLAstZR1kdTqNdgKSkiGc+gfTJGg=
X-Received: by 2002:aca:1c06:0:b0:354:28ae:23b3 with SMTP id
 c6-20020aca1c06000000b0035428ae23b3mr13083821oic.287.1669501066859; Sat, 26
 Nov 2022 14:17:46 -0800 (PST)
MIME-Version: 1.0
References: <20221126051002.123199-1-linux@weissschuh.net> <20221126051002.123199-2-linux@weissschuh.net>
In-Reply-To: <20221126051002.123199-2-linux@weissschuh.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 27 Nov 2022 07:17:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNATPW2QE8ZnE56hC_ayWeG9s8nBkArae9a1d9Sqw=Xy_gg@mail.gmail.com>
Message-ID: <CAK7LNATPW2QE8ZnE56hC_ayWeG9s8nBkArae9a1d9Sqw=Xy_gg@mail.gmail.com>
Subject: Re: [PATCH 2/3] powerpc/book3e: remove #include <generated/utsrelease.h>
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
> Commit 7ad4bd887d27 ("powerpc/book3e: get rid of #include <generated/comp=
ile.h>")
> removed the usage of the define UTS_VERSION but forgot to drop the
> include.
>
> Fixes: 7ad4bd887d27 ("powerpc/book3e: get rid of #include <generated/comp=
ile.h>")
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---


Assuming you will fix the commit description,

Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>




>  arch/powerpc/mm/nohash/kaslr_booke.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/powerpc/mm/nohash/kaslr_booke.c b/arch/powerpc/mm/nohas=
h/kaslr_booke.c
> index 0d04f9d5da8d..2fb3edafe9ab 100644
> --- a/arch/powerpc/mm/nohash/kaslr_booke.c
> +++ b/arch/powerpc/mm/nohash/kaslr_booke.c
> @@ -19,7 +19,6 @@
>  #include <asm/cacheflush.h>
>  #include <asm/kdump.h>
>  #include <mm/mmu_decl.h>
> -#include <generated/utsrelease.h>
>
>  struct regions {
>         unsigned long pa_start;
> --
> 2.38.1
>


--
Best Regards

Masahiro Yamada
