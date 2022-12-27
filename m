Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294AC656D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 17:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiL0Qyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 11:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiL0Qyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 11:54:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3AA63B0;
        Tue, 27 Dec 2022 08:54:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10BCE611B0;
        Tue, 27 Dec 2022 16:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABE2C433D2;
        Tue, 27 Dec 2022 16:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672160072;
        bh=FjO0kGb5McobYOGtVa+aVVHYwK3oE3vAipnorW/kpCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O5Vgz6TUUNuwRztLJqZITREONGnIswy7XN91/s9NDAHCD7g4JUJKdW/LYvgRocEDR
         l14MANQkqpfAUAKOXinUauyc4TL0vQkZIN6p3vb+hy/Y1QzWr4PoQpjvq+qw1RvKxU
         dAaBtN/F747EyV6NKWhwspzAdWuTLgOPZmyspBBszLXZzWpw1XE670eKekeY4+mE07
         h1Jgj6iWStOqVZcrqaP/6oLiYtn3IroEwpm1N0s62CgTEACc4oObReL/YWEmqfwh9p
         P2m5XIji4hML0PTl7dD1hplIcIZ9xyx9/ljZ/Mv2W6ExjO51vUm92RHx5wXFHNWJ9D
         VNt1SAMKEGggg==
Date:   Tue, 27 Dec 2022 09:54:30 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jun ASAKA <JunASAKA@zzy040330.moe>
Cc:     masahiroy@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: add a missing line for help message
Message-ID: <Y6sjRvdmzGqer5oL@dev-arch.thelio-3990X>
References: <20221227092157.329109-1-JunASAKA@zzy040330.moe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221227092157.329109-1-JunASAKA@zzy040330.moe>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 05:21:57PM +0800, Jun ASAKA wrote:
> The help message line for building the source RPM package was missing.
> Added it.
> 
> Signed-off-by: Jun ASAKA <JunASAKA@zzy040330.moe>

Thank you for the patch!

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  scripts/Makefile.package | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> index 539e9f765d64..525a2820976f 100644
> --- a/scripts/Makefile.package
> +++ b/scripts/Makefile.package
> @@ -158,6 +158,7 @@ $(perf-tar-pkgs):
>  PHONY += help
>  help:
>  	@echo '  rpm-pkg             - Build both source and binary RPM kernel packages'
> +	@echo '  srcrpm-pkg          - Build only the source kernel RPM package'
>  	@echo '  binrpm-pkg          - Build only the binary kernel RPM package'
>  	@echo '  deb-pkg             - Build both source and binary deb kernel packages'
>  	@echo '  bindeb-pkg          - Build only the binary kernel deb package'
> -- 
> 2.31.1
> 
