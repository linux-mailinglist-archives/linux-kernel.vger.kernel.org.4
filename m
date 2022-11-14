Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E04A62879F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237829AbiKNR6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236681AbiKNR6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:58:19 -0500
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA3326546
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:58:18 -0800 (PST)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 2AEHvrm4025921
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:57:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 2AEHvrm4025921
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1668448674;
        bh=FKc3qcfec+gHgboywrJ09NkfRlIxD8LBocwjtxNj3MI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BFK0rqzKhnpaGMVMVqwXYJ7mxovyV+PnOXS9BW9alLw8HkOLpbX4fR4b8LrOJGQ5x
         jBx1d/tCyytWKKnVaYBHYhQ+79vIe90KopUz04btzWmbmWKKtAqDp0Xzh2xgmeG2ql
         nNQqiu1Fj6BUivFzYZt1RKS88U3OgPc0P4587fjWeA3sjRvitatvjf8TqS3A2nLqb2
         5N6UjIt7Fw3EhTzzic9qUKEqtIFnivRs1Dhiiamrff9BhLskzJaOa5EWk3AXqbvlIo
         qEIs/c3VW5EUrHQ750m7HP/OBjvoi/DzS8SAF+ubqy8p3SmGavnjGcTmHtdRpaBHi0
         pIdgr+aOoO53A==
X-Nifty-SrcIP: [209.85.160.44]
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-13ae8117023so13318941fac.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:57:54 -0800 (PST)
X-Gm-Message-State: ANoB5plfW9ZhfECeN2HSKv+z39o7EdjvUBU4PkP6Twwb68sKjyIDAwVx
        exddF2jWSp6HqRrtSs4L1bdMMH16B08Sr/nHuFA=
X-Google-Smtp-Source: AA0mqf6lEFOoTSBPcrvmWZXNTd+o3OKLVL8/4ph0XLc06G+xgD66Gi8in+JQaCMGx+wJF5BW7gNoJ2sC+cGi+2/o544=
X-Received: by 2002:a05:6870:4b4a:b0:13b:5d72:d2c6 with SMTP id
 ls10-20020a0568704b4a00b0013b5d72d2c6mr7243528oab.287.1668448672780; Mon, 14
 Nov 2022 09:57:52 -0800 (PST)
MIME-Version: 1.0
References: <20221114114344.18650-1-jirislaby@kernel.org> <20221114114344.18650-3-jirislaby@kernel.org>
In-Reply-To: <20221114114344.18650-3-jirislaby@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 15 Nov 2022 02:57:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNASUb0PLiZahw46c0qBUn_caMWm2SrtY1Hb8Vd7RzsAwzg@mail.gmail.com>
Message-ID: <CAK7LNASUb0PLiZahw46c0qBUn_caMWm2SrtY1Hb8Vd7RzsAwzg@mail.gmail.com>
Subject: Re: [PATCH 02/46] kbuild: pass jobserver to cmd_ld_vmlinux.o
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Martin Liska <mliska@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 8:44 PM Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
>
> From: Jiri Slaby <jslaby@suse.cz>
>
> Until the link-vmlinux.sh split (cf. the commit below), the linker was
> run with jobserver set in MAKEFLAGS. After the split, the command in
> Makefile.vmlinux_o is not prefixed by "+" anymore, so this information
> is lost.
>
> Restore it as linkers working in parallel (namely gcc LTO) make a use of
> it. Actually, they complain, if jobserver is not set:
>   lto-wrapper: warning: jobserver is not available: '--jobserver-auth=' is not present in 'MAKEFLAGS'
>
> Fixes: 5d45950dfbb1 (kbuild: move vmlinux.o link to scripts/Makefile.vmlinux_o)


This Fixes is wrong since GCC LTO is not in upstream code.






> Cc: Sedat Dilek <sedat.dilek@gmail.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Martin Liska <mliska@suse.cz>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  scripts/Makefile.vmlinux_o | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
> index 0edfdb40364b..1c86895cfcf8 100644
> --- a/scripts/Makefile.vmlinux_o
> +++ b/scripts/Makefile.vmlinux_o
> @@ -58,7 +58,7 @@ define rule_ld_vmlinux.o
>  endef
>
>  vmlinux.o: $(initcalls-lds) vmlinux.a $(KBUILD_VMLINUX_LIBS) FORCE
> -       $(call if_changed_rule,ld_vmlinux.o)
> +       +$(call if_changed_rule,ld_vmlinux.o)
>
>  targets += vmlinux.o
>
> --
> 2.38.1
>


-- 
Best Regards
Masahiro Yamada
