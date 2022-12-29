Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B5A658F84
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbiL2RUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiL2RUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:20:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2918D218;
        Thu, 29 Dec 2022 09:20:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B96046184B;
        Thu, 29 Dec 2022 17:20:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5386C433D2;
        Thu, 29 Dec 2022 17:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672334442;
        bh=0GvxcREki2V+wu5z+rdDeKg6yQvHhxHUduxIL3zva1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MAWZddv0euydsn+heUUTwah8LEwctH7oKFQ33M4mnrepc0vp7SGAPxYOVEe6bGGy6
         yUlou1G9LDgPGZwcF41NRmXqKZFpvgmBc8vMsGRR7KbBrwd2NFiDdDcntLz1GFDhXW
         M/ofoYUEPqbdtJj/QNP9SrD9l4NCeUpU5Iyd5vDtWR/d5VWyjn5rNcn9V9ilIvzq7h
         Jl4lVl9U0w44xzVS0qnnnrqIBUfK3zP9UDmacK50RFyBI3T1crY60nb1j5CEC/YTjc
         koQ4EeIBVz6c+M3yU48DzK89l9KMBYZ+Jgbx06PP5BYVlAr2wXVuG7u0Z00mq5tXee
         F2pwR0O/ulu1Q==
Date:   Thu, 29 Dec 2022 10:20:40 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH v2] kbuild: sort single-targets alphabetically again
Message-ID: <Y63MaK+98prCZq0R@dev-arch.thelio-3990X>
References: <20221229121642.1046890-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229121642.1046890-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 09:16:42PM +0900, Masahiro Yamada wrote:
> This was previously alphabetically sorted. Sort it again.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
> Changes in v2:
>   - Move %.rsi after %.o to make it really sorted
> 
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index c0d7c75d8f14..8daf1be6a2e4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -289,7 +289,7 @@ no-compiler-targets := $(no-dot-config-targets) install dtbs_install \
>  			headers_install modules_install kernelrelease image_name
>  no-sync-config-targets := $(no-dot-config-targets) %install kernelrelease \
>  			  image_name
> -single-targets := %.a %.i %.rsi %.ko %.lds %.ll %.lst %.mod %.o %.s %.symtypes %/
> +single-targets := %.a %.i %.ko %.lds %.ll %.lst %.mod %.o %.rsi %.s %.symtypes %/
>  
>  config-build	:=
>  mixed-build	:=
> -- 
> 2.34.1
> 
