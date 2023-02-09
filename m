Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A15690B3D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjBIODs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjBIODp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:03:45 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316F51A948
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 06:03:40 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id g8so1871580qtq.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 06:03:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W5LEMYJKTULDF0yIN2Ry+IVsYPZvyA1Fu5NFvlX6eN4=;
        b=lxangetnSooT6+ZH+dbfYL3Vd3RLfsJz5ZFlKicqyjJ2pjDi+fM/x/LGSs0srYDcWA
         KY4CO255oOpP0mmGchXgLXwCTxSiX3g+kCRLz+bGbYkiucp3unB+VZ4pmYRVE6DQiXRS
         EIWTuG4y4S6ao7URnq/wdaaXX3AGAYmRh/K3daDdHXTsnHUQfvcVUFmg/FsMvlhEfrtQ
         kunoS4PYufIF6yXNkm0FAmj5OoBEnSBIb+xwFZETcXKLRser5jlXUsAxmOZf5FDNo3P2
         WVC9XA5+mE6rWOMTU9MlVGR4PilO9yZjI3Qc7veFAuUBWyXUChMOh6hpIlIpF5dJaNJJ
         Gf7A==
X-Gm-Message-State: AO0yUKVFSw1BOBIbtAhONzucNAHuQ5G33GqlC/0v/9udTaqTA5WmBhty
        5jBvsO50S0o4qPrdpprOZ7dGYaOamJH9Kw==
X-Google-Smtp-Source: AK7set8AS4cCqxYI4EFs1BAAljCoUSPtbrzXhNgQ4HpXrynKKKcg82q0vgx18VxZuG3NIEhOpt1VkQ==
X-Received: by 2002:a05:622a:406:b0:3b9:8885:296a with SMTP id n6-20020a05622a040600b003b98885296amr17746255qtx.11.1675951418914;
        Thu, 09 Feb 2023 06:03:38 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id ce11-20020a05622a41cb00b003b9b4028d63sm1224937qtb.80.2023.02.09.06.03.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 06:03:38 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id q4so2413790ybu.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 06:03:38 -0800 (PST)
X-Received: by 2002:a25:5d11:0:b0:839:c329:be37 with SMTP id
 r17-20020a255d11000000b00839c329be37mr1244416ybb.89.1675951418101; Thu, 09
 Feb 2023 06:03:38 -0800 (PST)
MIME-Version: 1.0
References: <20230209010635.24016-1-rdunlap@infradead.org>
In-Reply-To: <20230209010635.24016-1-rdunlap@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 9 Feb 2023 15:03:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUrmKsi0arun17uVkAaoRe2vs1Xy_XY8Mb2dA6wu8q9iQ@mail.gmail.com>
Message-ID: <CAMuHMdUrmKsi0arun17uVkAaoRe2vs1Xy_XY8Mb2dA6wu8q9iQ@mail.gmail.com>
Subject: Re: [PATCH] m68k: allow PM menu options for COMPILE_TEST
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Thu, Feb 9, 2023 at 2:06 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> Allow PM options for COMPILE_TEST. This quietens a kconfig
> warning.
>
> This is similar to a patch for Sparc32 that was suggested by
> Arnd.
>
> WARNING: unmet direct dependencies detected for PM
>   Depends on [n]: !MMU [=y]
>   Selected by [y]:
>   - SUN20I_PPU [=y] && (ARCH_SUNXI || COMPILE_TEST [=y])
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks for your patch!

> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -126,7 +126,7 @@ menu "Kernel Features"
>
>  endmenu
>
> -if !MMU
> +if !MMU || COMPILE_TEST
>  menu "Power management options"

I think this is the wrong solution.
All other selects of PM are done by architecture/platform-gating
symbols, and none of them can be enabled for compile-testing.

So either SUN20I_PPU should depend on PM, or ARCH_SUNXI
should select PM.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
