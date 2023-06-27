Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B267400F8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjF0QZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjF0QZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:25:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0482115;
        Tue, 27 Jun 2023 09:25:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A592611D1;
        Tue, 27 Jun 2023 16:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36845C433C0;
        Tue, 27 Jun 2023 16:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687883114;
        bh=abXpFTTuUCBmcbnkpnmJtVpSKqQCH7MmcQizSI+8UwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bf+1nHmWvUr3kRD0ZuwmHSoep1vIrh0qJZgvsk8nlnHqA5vuW61Onv1xwnq27FNZn
         DTxsQPAr9qLEegeAaZOBj5tuT89gXMkQacVqnbuxJ6bamy3FsSqu1zcNCe2pQoxJ7q
         JoCiI78enrsBgw6ZeUlOEB5XKdk3itmXLTshpMceWLZVhyaIqmbPLi7QZXQIFTQUwL
         xgf1ASuRdFn+dLX5KDIhHNWcoItUX2H6WDl3M6Jfud3oz3LVi1AqVGwsN9Ni1UE3aL
         C07SEc1ObwLcp3NdFrRGZX1iOdq2HbiKW2++8KS0njjlnP4H6tFM25d968N1BZE7ro
         CrFo3eXRWzW0g==
Date:   Tue, 27 Jun 2023 09:25:12 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Rui <wangrui@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Subject: Re: [PATCH 2/2] LoongArch: Include KBUILD_CPPFLAGS in CHECKFLAGS
 invocation
Message-ID: <20230627162512.GB223742@dev-arch.thelio-3990X>
References: <20230627130122.1491765-1-kernel@xen0n.name>
 <20230627130122.1491765-3-kernel@xen0n.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627130122.1491765-3-kernel@xen0n.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 09:01:22PM +0800, WANG Xuerui wrote:
> From: WANG Xuerui <git@xen0n.name>
> 
> This is a port of commit 08f6554ff90e ("mips: Include KBUILD_CPPFLAGS
> in CHECKFLAGS invocation") to arch/loongarch, for fixing
> cross-compilation of Linux/LoongArch with Clang, where previously the
> `--target` flag would no longer be present for the CHECKFLAGS cc
> invocation leading to build failure.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1787#issuecomment-1608306002
> Signed-off-by: WANG Xuerui <git@xen0n.name>

Thanks for the patch!

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/loongarch/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index a63683da3bcf..09ba338a64de 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -112,7 +112,7 @@ KBUILD_CFLAGS += -isystem $(shell $(CC) -print-file-name=include)
>  KBUILD_LDFLAGS	+= -m $(ld-emul)
>  
>  ifdef CONFIG_LOONGARCH
> -CHECKFLAGS += $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
> +CHECKFLAGS += $(shell $(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
>  	grep -E -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \
>  	sed -e "s/^\#define /-D'/" -e "s/ /'='/" -e "s/$$/'/" -e 's/\$$/&&/g')
>  endif
> -- 
> 2.40.0
> 
