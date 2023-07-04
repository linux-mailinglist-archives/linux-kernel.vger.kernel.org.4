Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D7E747205
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjGDM7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGDM7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:59:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3FF12E;
        Tue,  4 Jul 2023 05:59:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D73556123C;
        Tue,  4 Jul 2023 12:59:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE6AC433C7;
        Tue,  4 Jul 2023 12:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688475578;
        bh=gdXfAe6zNFUWfjfbNMvNFg9rBY6S+Ics8BpCv867pFI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VaHQK3rzaDBrU5kW2Rxv4QvphNneg88u1Wm43hq2n6qrQevAjyhZybEnpAINkfEP/
         YFASjpW2VcHt/EQPIOa2iPQf1/xnCny4JJq+KG6A+hLCYO+BhIaIUysPDncXOVCfOB
         bDUZ/Vjsb4U5FWEKnQUrg+NQvmsPruMduOqxS3RqynaA/USpUOjY1q6sxYn7YqlLNl
         Qes5JcYuYm+nyQMZZeg9Cs5Lyp1dQ9NGhbOBXFtyV1tWqDeOSwEDJYuau8TlBCY+gE
         veNA3yJQZmMEFqlaCHmppfOoUCj14WK//qSU4psDDUyy+Rgcb2t9JrqT2dEdEyFmbg
         fyz8lPKniLRBw==
Date:   Tue, 4 Jul 2023 21:59:32 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     paulmck@kernel.org
Cc:     mtk.manpages@gmail.com, mhiramat@kernel.org, corbet@lwn.net,
        akpm@linux-foundation.org, ndesaulniers@google.com, vbabka@suse.cz,
        hannes@cmpxchg.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc.5: Clarify that boot arguments can be embedded in
 image
Message-Id: <20230704215932.c9cab0af086528e52ca0bfbb@kernel.org>
In-Reply-To: <433d742b-743b-4335-878f-1ca0f45698f7@paulmck-laptop>
References: <433d742b-743b-4335-878f-1ca0f45698f7@paulmck-laptop>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2023 16:33:28 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> With the advent of the CONFIG_BOOT_CONFIG Kconfig option, kernel boot
> arguments can now be embedded in the kernel image, either attached
> to the end of initramfs or embedded in the kernel itself.  Document
> this possibility in the /proc/cmdline entry of proc.5.

Thanks for update!

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> 
> diff --git a/man5/proc.5 b/man5/proc.5
> index c6684620e..141a2983c 100644
> --- a/man5/proc.5
> +++ b/man5/proc.5
> @@ -3100,6 +3100,9 @@ Often done via a boot manager such as
>  .BR lilo (8)
>  or
>  .BR grub (8).
> +Any arguments embedded in the kernel image or initramfs via 
> +.B CONFIG_BOOT_CONFIG
> +will also be displayed.
>  .TP
>  .IR /proc/config.gz " (since Linux 2.6)"
>  This file exposes the configuration options that were used


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
