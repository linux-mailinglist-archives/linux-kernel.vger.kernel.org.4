Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286BE665AD5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238839AbjAKL5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239112AbjAKL5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:57:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DD1392D2;
        Wed, 11 Jan 2023 03:50:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C536B81B8E;
        Wed, 11 Jan 2023 11:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC784C433EF;
        Wed, 11 Jan 2023 11:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673437803;
        bh=edHyw0CMr5nTfSwCWBZWUMB1jeFW3iiervEuXxZpw9A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KkPbCf2bGi1QeoUejAl+dtSgqcAwfDZBnN6SGdfSSiT+rgRR5LwNyfOYtbwNmloyb
         BT1okBxaNyBoq5/bUupjWAE4gVXv8CorudYNOreVjhCDBOjgR20xtaXf6TOnPHBcw4
         3opOOoKu9iJQvYIRvMud3a6GKhJcS2wMhFR93EekcbLGAQYsomdz1q+DW6rnzrh7Ke
         tgvtDu/c/sSuaWN6JZRWqbMuyXvq6iPUSqxjM8Z4QobuZTk+7MT+M0qUEeo8D2o8UK
         zT8cV6JPj0c5i7WwHmbVIwHTzyuHs+Kfe2hI2HqHtRqUMbhaBsH9W0dOpKhz8L2cHp
         82wdXP+uRzm+g==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-15085b8a2f7so15262295fac.2;
        Wed, 11 Jan 2023 03:50:03 -0800 (PST)
X-Gm-Message-State: AFqh2kr/ofIzwqzwvQHr1P7ToKWmFuYUrONdsVPBePUSyTBXdJZRZAXU
        aiX6STiRHNSGNTtVZI09O6yS8Hjj3nxS9xA28Zw=
X-Google-Smtp-Source: AMrXdXsFUlD81QbuFGV78qMtfY8YAM2vD0R1WfWM9vPd5Ki85wXX29/2YCWq8xlWSevNzuirFzdPYdCxm9TNLy0vrFM=
X-Received: by 2002:a05:6870:50a:b0:15b:9941:ac30 with SMTP id
 j10-20020a056870050a00b0015b9941ac30mr836548oao.287.1673437803108; Wed, 11
 Jan 2023 03:50:03 -0800 (PST)
MIME-Version: 1.0
References: <20230109201837.23873-1-eliasfleckenstein@web.de>
In-Reply-To: <20230109201837.23873-1-eliasfleckenstein@web.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 11 Jan 2023 20:49:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQEMTTJ5+JipmEFHf7tdP9k0xMiPD=OzePV=Giu6pCL7g@mail.gmail.com>
Message-ID: <CAK7LNAQEMTTJ5+JipmEFHf7tdP9k0xMiPD=OzePV=Giu6pCL7g@mail.gmail.com>
Subject: Re: [PATCH] kconfig: fix typo (usafe -> unsafe)
To:     Lizzy Fleckenstein <eliasfleckenstein@web.de>,
        akpm@linux-foundation.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,


Please revise the patch subject to init/Kconfig:

I want to see "kconfig:" only for changes in scripts/kconfig/.


See this:
https://lore.kernel.org/all/CAK7LNARmyKYC4e3fOyACPVJJ03gTh4TwNqXAx_SLP_Zkei0XXA@mail.gmail.com/T/#t

This is a good choice for the subject.









On Tue, Jan 10, 2023 at 5:19 AM Lizzy Fleckenstein
<eliasfleckenstein@web.de> wrote:
>
> Fix the help text for the PRINTK_SAFE_LOG_BUF_SHIFT setting.
>
> Signed-off-by: Lizzy Fleckenstein <eliasfleckenstein@web.de>
> ---
>  init/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 7e5c3ddc341d..57c8d224ea4c 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -776,7 +776,7 @@ config PRINTK_SAFE_LOG_BUF_SHIFT
>         depends on PRINTK
>         help
>           Select the size of an alternate printk per-CPU buffer where messages
> -         printed from usafe contexts are temporary stored. One example would
> +         printed from unsafe contexts are temporary stored. One example would
>           be NMI messages, another one - printk recursion. The messages are
>           copied to the main log buffer in a safe context to avoid a deadlock.
>           The value defines the size as a power of 2.
> --
> 2.39.0
>


-- 
Best Regards
Masahiro Yamada
