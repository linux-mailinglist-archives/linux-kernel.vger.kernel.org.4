Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174985E540D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 21:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiIUT4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 15:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiIUT4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 15:56:30 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBFBA262B;
        Wed, 21 Sep 2022 12:56:29 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 53ECF536;
        Wed, 21 Sep 2022 19:56:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 53ECF536
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1663790188; bh=J4TUGJz5eNPoFfgErVz4BBubGR6lAxIEDm0mESOY7/k=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=WKAl3wloiO1k2S6izp4l20idZEQZpCWQOBrejVjHz+p3Wq2I+usIaKRpTu5iCbQau
         AN61NAETYKBMYLipUh41TQuNGb1oK3uJ85zcv15OxVvboPc+0mBgky38xdViGMycM7
         bQnqTr0ku6pyzYR8iN+Rmg7e7kx5aP2zT6RVAHl8Sk6lB9KwnYdFsONK4ommbqNL6s
         +/3zKHt4QWHRdo1BvtOQnifTo51mA6Unulf6T9aorG163b5J8GfqOUeEYk4WV7wAUH
         WaZpq3xEv+YvH1bVrwJxcsxO3gwAiAKXoL1fM2KyIK31Jy/TlNTDhH6tYpQbtXAAcu
         icK9sb0UoHAfg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tuo Cao <91tuocao@gmail.com>, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        91tuocao@gmail.com
Subject: Re: [PATCH v3] docs: x86: replace do_IRQ int the entry_64.rst with
 common_interrupt()
In-Reply-To: <20220915150155.9908-1-91tuocao@gmail.com>
References: <20220915150155.9908-1-91tuocao@gmail.com>
Date:   Wed, 21 Sep 2022 13:56:27 -0600
Message-ID: <877d1wwlg4.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tuo Cao <91tuocao@gmail.com> writes:

> do_IRQ has been replaced by common_interrupt in commit
> fa5e5c409213 ("x86/entry: Use idtentry for interrupts").
>
> Signed-off-by: Tuo Cao <91tuocao@gmail.com>
> ---
>  Documentation/x86/entry_64.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/x86/entry_64.rst b/Documentation/x86/entry_64.rst
> index e433e08f7018..0afdce3c06f4 100644
> --- a/Documentation/x86/entry_64.rst
> +++ b/Documentation/x86/entry_64.rst
> @@ -33,8 +33,8 @@ Some of these entries are:
>   - interrupt: An array of entries.  Every IDT vector that doesn't
>     explicitly point somewhere else gets set to the corresponding
>     value in interrupts.  These point to a whole array of
> -   magically-generated functions that make their way to do_IRQ with
> -   the interrupt number as a parameter.
> +   magically-generated functions that make their way to common_interrupt()
> +   with the interrupt number as a parameter.
>  
>   - APIC interrupts: Various special-purpose interrupts for things
>     like TLB shootdown.

Applied, thanks.

jon
