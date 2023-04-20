Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D636E9932
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjDTQIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjDTQIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:08:19 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFCA2729;
        Thu, 20 Apr 2023 09:08:18 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 73433732;
        Thu, 20 Apr 2023 16:08:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 73433732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1682006898; bh=B3Xqo3nWn5ee6tZS82P0hkeSI480N7hQKWDJUqhNn0E=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MznbQH7U3J3DGvT8DMFedy7ylTzOHNUG3405M3EIM+5/Fs4tt/CNSjsziptvUuLNX
         uhcVWNTPAyVXbBSH/4Y28lnWrXzW69FECfBMbXZencwYKaiwQenmPpGn+M6OBm9W31
         fbRCZGbs2C1IMc2DhN5i1V9upC/gHpwIV1YRZSD0rmOgIW6FL7U8JXGA0jp+7C/Al1
         wRA/R3krtTdnt4T93PGDs8jUjApGF7V8JGbPR+lema37O/hPDz+2WJkka+NDEfwJ0w
         2lu5FcN8dGK9iIk0bwHPeSsNTzXa1MxYZcGO0dUfPCashPcghcsNxBMud34a0Q8Zpa
         GXtBTQsgyEYdw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-doc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] docs: kmemleak: adjust to config renaming
In-Reply-To: <20230414061241.12754-1-lukas.bulwahn@gmail.com>
References: <20230414061241.12754-1-lukas.bulwahn@gmail.com>
Date:   Thu, 20 Apr 2023 10:08:17 -0600
Message-ID: <87bkjitu32.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:

> Commit c87db8ca0902 ("kmemleak-test: fix kmemleak_test.c build logic")
> essentially renames the config DEBUG_KMEMLEAK_TEST to SAMPLE_KMEMLEAK, but
> misses to adjust the documentation.
>
> Adjust kmemleak documentation to this config renaming.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  Documentation/dev-tools/kmemleak.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/dev-tools/kmemleak.rst b/Documentation/dev-tools/kmemleak.rst
> index 5483fd39ef29..2cb00b53339f 100644
> --- a/Documentation/dev-tools/kmemleak.rst
> +++ b/Documentation/dev-tools/kmemleak.rst
> @@ -227,7 +227,7 @@ Testing with kmemleak-test
>  --------------------------
>  
>  To check if you have all set up to use kmemleak, you can use the kmemleak-test
> -module, a module that deliberately leaks memory. Set CONFIG_DEBUG_KMEMLEAK_TEST
> +module, a module that deliberately leaks memory. Set CONFIG_SAMPLE_KMEMLEAK
>  as module (it can't be used as built-in) and boot the kernel with kmemleak

Applied, thanks.

jon
