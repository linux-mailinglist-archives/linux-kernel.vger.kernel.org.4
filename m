Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0722368AAB5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 15:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjBDO5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 09:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBDO5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 09:57:03 -0500
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295191EBF8;
        Sat,  4 Feb 2023 06:57:02 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4P8Fwn69HKz9sbk;
        Sat,  4 Feb 2023 15:56:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1675522617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tkq61IaaphmcCMy0jeb65pNFPN5hEwtKvlzCHHr65SY=;
        b=ruCLNv4uxzOg+gYnZ7UzWq7RiWqSDJ0QW9FrjBvl5nFIn2EOs21ywIcAwYkQ0sLzcXs32A
        bm+duLT69SGjMfynzUu3dVffG7JQNkssaZdn3poOBLVMELOmCQ5oi61PijbP026JQuoKYf
        tNKMLme+W7F1B0xugy08/Vn/U6xfeT3mTlxwrmW9fbZMxzMBP2rxKLFz4UYr1KY9xXPHOQ
        pA54WmUSGh07PxKMcVmcObPmBgycvapcUvwI1W2NHb2EdYF8JlnlYWjCkZyu2uaS2DCnVA
        h83rvIkQuNyM0RtotiIfMfraBTIeoJ33gg8cupnjrPVc5R3+S+BvTO1OjvLSOA==
From:   Alexander Lobakin <alobakin@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1675522615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tkq61IaaphmcCMy0jeb65pNFPN5hEwtKvlzCHHr65SY=;
        b=ld9b3hQqb4aXsilESfxm1s3sG6h9RTAz0Z9f9GD6FQp2qw57/XuWtfZnfTTGYOT5e8aHWQ
        5BiOSz5avatdO8aCg+EanfxIvueWdUB0n0dE5VI20Jphl+YI3GySMha8LCa9g8qxreQzXK
        rTot9G4vCMtmZwRzelH1qbySUtc8ntNIPWocVJ+xpgKwpIbSOwoQY3xqyEjRMZMQVnKmAd
        dMdoDaFe/JJclmqVTI8pJ6JvuyRsTBhHYbICfYU0OjwDcIQj4bt4XT+uoOYvh3oF2X2jmt
        5I1bNB23mGN4moVDvd7yBwa1CuYZIhJG4Tg/I+vKbg0+6vcLsFcSE7qHZQ7RXQ==
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Alexander Lobakin <alobakin@mailbox.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Remove CONFIG_MIPS check in Makefile
Date:   Sat,  4 Feb 2023 15:56:41 +0100
Message-Id: <20230204145641.66417-1-alobakin@mailbox.org>
In-Reply-To: <1675328702-8328-1-git-send-email-yangtiezhu@loongson.cn>
References: <1675328702-8328-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: tpypxy5rexgmtbkqmk8b5b618i9quz5c
X-MBO-RS-ID: 28265f7d666235e2d41
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tiezhu Yang <yangtiezhu@loongson.cn>
Date: Thu,  2 Feb 2023 17:05:02 +0800

> CONFIG_MIPS is set as y by default in Kconfig, no need to check
> it in Makefile.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/mips/Makefile | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 490dea0..6ed41c8b 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -316,11 +316,9 @@ KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
>  
>  KBUILD_LDFLAGS		+= -m $(ld-emul)
>  
> -ifdef CONFIG_MIPS
>  CHECKFLAGS += $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
>  	grep -E -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \
>  	sed -e "s/^\#define /-D'/" -e "s/ /'='/" -e "s/$$/'/" -e 's/\$$/&&/g')
> -endif

When you run `make clean/mrproper/distclean`, .config is not read. Thus,
this block may actually provoke errors when cleaning, that's why it's
guarded.
At least it was like that a couple years ago, can't say for sure if
these guards are needed, but better recheck.

>  
>  OBJCOPYFLAGS		+= --remove-section=.reginfo
>  
> -- 
> 2.1.0

Thanks,
Olek
