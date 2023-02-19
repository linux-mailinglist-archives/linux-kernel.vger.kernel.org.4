Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426C969C18F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 18:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjBSRFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 12:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjBSRFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 12:05:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2750B9753;
        Sun, 19 Feb 2023 09:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=qlQjQbgZaX/BxYheJjKk8j2q/20OKbrPzj69dSzHx3Q=; b=wL0Xqw13KFnWACAi75iNxrHy7d
        suct2aA5kBDaeW5vQ+sIYV43G2cGHucdr0a+eYNtBqt+uVyVKvqGJxe5IDB4L2vGLympPJePejqT8
        WAdSDfRcO35rmr27K9XASxzOIFAgmg+uvBhvZ3IECbr9v1wx02fREM88rlEsd5gcX2vlFeTAcQS6s
        xYEpWt5dBIpP7PJsFbQQiuCpAJo1POCuWf3fSEYYXDze+NdajHlWJCzeCzOvjeNmUWm3aSJ+kzhfe
        prv/Kz/4Mw1Ic9GXMJi+4O5KdqtbIarLgPQ3xq1ROECzsJn42JKQt9FbIQ0qbM7Y8igV4L7tsYX4k
        LlZq6qow==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pTn7k-001zML-Go; Sun, 19 Feb 2023 17:05:16 +0000
Message-ID: <00937217-0df9-1aa6-9ed7-5b4226bb8ba2@infradead.org>
Date:   Sun, 19 Feb 2023 09:05:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 2/4] sh: move build rule of cchips/hd6446x/ to
 arch/sh/Kbuild
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
References: <20230219141555.2308306-1-masahiroy@kernel.org>
 <20230219141555.2308306-2-masahiroy@kernel.org>
Content-Language: en-US
In-Reply-To: <20230219141555.2308306-2-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/19/23 06:15, Masahiro Yamada wrote:
> This is the last user of core-y in ARCH=sh.
> 
> Use the standard obj-y syntax.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> 
>  arch/sh/Kbuild   | 2 ++
>  arch/sh/Makefile | 3 ---
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/sh/Kbuild b/arch/sh/Kbuild
> index be171880977e..056efec72c2a 100644
> --- a/arch/sh/Kbuild
> +++ b/arch/sh/Kbuild
> @@ -3,5 +3,7 @@ obj-y				+= kernel/ mm/ boards/
>  obj-$(CONFIG_SH_FPU_EMU)	+= math-emu/
>  obj-$(CONFIG_USE_BUILTIN_DTB)	+= boot/dts/
>  
> +obj-$(CONFIG_HD6446X_SERIES)	+= cchips/hd6446x/
> +
>  # for cleaning
>  subdir- += boot
> diff --git a/arch/sh/Makefile b/arch/sh/Makefile
> index a9cad5137f92..0625796cfe7f 100644
> --- a/arch/sh/Makefile
> +++ b/arch/sh/Makefile
> @@ -126,9 +126,6 @@ machdir-$(CONFIG_SH_X3PROTO)			+= mach-x3proto
>  machdir-$(CONFIG_SH_LANDISK)			+= mach-landisk
>  machdir-y					+= mach-common
>  
> -# Companion chips
> -core-$(CONFIG_HD6446X_SERIES)	+= arch/sh/cchips/hd6446x/
> -
>  #
>  # CPU header paths
>  #

-- 
~Randy
