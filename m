Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8974D5F85AF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 16:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiJHO63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 10:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJHO60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 10:58:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE11540BCC;
        Sat,  8 Oct 2022 07:58:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44CD360684;
        Sat,  8 Oct 2022 14:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5E5C433D7;
        Sat,  8 Oct 2022 14:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665241104;
        bh=aPQLhQqDhgqtTeKKu7I6BgunfElRN0VLe4/LVpiJj8Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SJ2U+BG/re37qpGCtt3ylT+on4KjrFXyfCEuFahc5V7IeLfifDA0XOELAlPeDySsJ
         3AsHED0Kcw3KLM0Ey2pDyesh5MYq1/DSgeMUceEf+7gi8InvmRem8uCuvT3yel+g+y
         X/ctAd9i3bWuByZjqvZMGibtLBNGuHOf512C/GGzlxbt1JbonmV3ik4f+6VWeTK9xu
         ORy8ieAJUrf5XMk9S07lgEzGb39APA3k1VAmNNoLaGpcIqGQnX3X6EKb5pM7As8vcG
         Q+dcRO8RIWq1knxSL2smEIUPSObaTJMjGyyQonuCTEmgy65yEks2BQXS2XY2nD3U3F
         m3zp/Q7kO6h0A==
Received: by mail-ed1-f43.google.com with SMTP id m15so10491130edb.13;
        Sat, 08 Oct 2022 07:58:24 -0700 (PDT)
X-Gm-Message-State: ACrzQf2IPuLiNdcTk01Zy/QHjBBKfdcnrba/noLLdshByv0jaPySU/tB
        FFYy91YUooRAaSLe/tfJnVkpZNZJiMsdWsRXBV0=
X-Google-Smtp-Source: AMsMyM6tc39Kmj/GVcBx0J/xlI1xhKO7ntaFXB97jjzs9fTFqPC4XA07V2UJbpEf5LTfC+yYAolkU1xA83SO+5Ypajc=
X-Received: by 2002:a05:6402:c81:b0:458:c428:173a with SMTP id
 cm1-20020a0564020c8100b00458c428173amr9336461edb.298.1665241102794; Sat, 08
 Oct 2022 07:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221007201939.2755407-1-colin.i.king@gmail.com>
In-Reply-To: <20221007201939.2755407-1-colin.i.king@gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 8 Oct 2022 22:58:10 +0800
X-Gmail-Original-Message-ID: <CAAhV-H721Wfkam+_+evNRXyuaio9oGqQQaDO6t-T31UdNp8gSQ@mail.gmail.com>
Message-ID: <CAAhV-H721Wfkam+_+evNRXyuaio9oGqQQaDO6t-T31UdNp8gSQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Kconfig: Fix spelling mistake "delibrately" -> "deliberately"
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued for loongarch-next, thank you.

Huacai

On Sat, Oct 8, 2022 at 4:19 AM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> There is a spelling mistake in a commented section. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  arch/loongarch/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 898263224bbc..903096bd87f8 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -171,7 +171,7 @@ config STACKTRACE_SUPPORT
>         bool
>         default y
>
> -# MACH_LOONGSON32 and MACH_LOONGSON64 are delibrately carried over from the
> +# MACH_LOONGSON32 and MACH_LOONGSON64 are deliberately carried over from the
>  # MIPS Loongson code, to preserve Loongson-specific code paths in drivers that
>  # are shared between architectures, and specifically expecting the symbols.
>  config MACH_LOONGSON32
> --
> 2.37.3
>
