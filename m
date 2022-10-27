Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEA160FBD1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbiJ0PXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiJ0PXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:23:49 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555AEDF7;
        Thu, 27 Oct 2022 08:23:48 -0700 (PDT)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 29RFNSUV029228;
        Fri, 28 Oct 2022 00:23:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 29RFNSUV029228
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1666884209;
        bh=HjLGoO2Lx7YPNTEAxUvyEaIlq5YG6EkDHPtsprtiT7I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aPdjIOqpBkiHzkUOVTu14o+cPcX1PAObAUWiBaZ6Hg8hV+W69uzlJQrfc6M3GiKTc
         5lr3mV/rHUpvPk8EpnlN+aXUVY9Z2i3KWeZIt8IuFjM+a9uN09y41Ck77p5Nkrxw1B
         h95APxgtK5I1ZETGWpc9Zag/ToYA7pxc44Qsck7oCPWibq0DmYCYsIQ4A+3CnkufxY
         1FHYes6YbFpspM+0A7ejbqTug56JjRStejKdY6EFsFnXpT8J9SWzxv11Db0pxwCkKE
         eN2AygK60ItpMDPj+2ppZFA5kdCCj1WHwZTAa9VPOK2zGbopxaAtSPqWuFG+MMc0Wk
         Kt8jtSZEG0Qeg==
X-Nifty-SrcIP: [209.85.167.182]
Received: by mail-oi1-f182.google.com with SMTP id g130so2464313oia.13;
        Thu, 27 Oct 2022 08:23:29 -0700 (PDT)
X-Gm-Message-State: ACrzQf3Y0+dtpDLBpVn9lhzZ3Wl7Jvj2urjtsrlEcghTOYDsrG6saC4F
        Wi68jPrB7cIfWkD21OtXKyQiRo72AH0Von1qubg=
X-Google-Smtp-Source: AMsMyM55SfsxUPxo2+u9BifUZK+zhiiFLFNtywbJ+DyCvRXcbN69GQohaAVX409azX6IWdYzzR/mFvVjEliwsnDLNEA=
X-Received: by 2002:a05:6808:1b85:b0:34d:8ce1:d5b0 with SMTP id
 cj5-20020a0568081b8500b0034d8ce1d5b0mr5133057oib.194.1666884207979; Thu, 27
 Oct 2022 08:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221025201744.1155260-1-willmcvicker@google.com> <20221025201744.1155260-2-willmcvicker@google.com>
In-Reply-To: <20221025201744.1155260-2-willmcvicker@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 28 Oct 2022 00:22:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQUcig1aY-vFKSOAF1MKknDC7DDfsJnNDvgC918PGWR+A@mail.gmail.com>
Message-ID: <CAK7LNAQUcig1aY-vFKSOAF1MKknDC7DDfsJnNDvgC918PGWR+A@mail.gmail.com>
Subject: Re: [PATCH v1] kbuild: fix typo in modpost
To:     Will McVicker <willmcvicker@google.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        kernel-team@android.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 5:18 AM Will McVicker <willmcvicker@google.com> wrote:
>
> Commit f73edc8951b2 ("kbuild: unify two modpost invocations") introduced
> a typo (moudle.symvers-if-present) which results in the kernel's
> Module.symvers to not be included as a prerequisite for
> $(KBUILD_EXTMOD)/Module.symvers. Fix the typo to restore the intended
> functionality.
>
> Signed-off-by: Will McVicker <willmcvicker@google.com>

Applied to linux-kbuild/fixes.
Thanks!


> ---
>  scripts/Makefile.modpost | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> base-commit: 1a2dcbdde82e3a5f1db9b2f4c48aa1aeba534fb2
>
> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index 8489a3402eb8..e41dee64d429 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -122,7 +122,7 @@ quiet_cmd_modpost = MODPOST $@
>         sed 's/ko$$/o/' $(or $(modorder-if-needed), /dev/null) | $(MODPOST) $(modpost-args) -T - $(vmlinux.o-if-present)
>
>  targets += $(output-symdump)
> -$(output-symdump): $(modorder-if-needed) $(vmlinux.o-if-present) $(moudle.symvers-if-present) $(MODPOST) FORCE
> +$(output-symdump): $(modorder-if-needed) $(vmlinux.o-if-present) $(module.symvers-if-present) $(MODPOST) FORCE
>         $(call if_changed,modpost)
>
>  __modpost: $(output-symdump)
> --
> 2.38.0.135.g90850a2211-goog
>


-- 
Best Regards
Masahiro Yamada
