Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEB56BE786
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjCQLEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCQLEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:04:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA76658C20
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 04:04:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5A3071FDDF;
        Fri, 17 Mar 2023 11:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679051060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0gTqNyOWas1b1mGuUVuoC2toQOZDunokBIW1RrnAt9s=;
        b=Pv66YiMjFihFlXGEgUrQ+mP5exd7suUo7O/FGooBsMGQRYn3WAHPyVU9JNbf8LbVUfveUF
        buiEWJkCKAZgAK6+ncebBkiJMMcq2wjjQbufNi8c/irmbyxfkfE9LmCJV4iQ9a0W8imKXn
        hB30+lcszzXvc1hJipoj90IJVcfuKe0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679051060;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0gTqNyOWas1b1mGuUVuoC2toQOZDunokBIW1RrnAt9s=;
        b=rEsjJ8acbBKWGCy0+vPHW+wekO5LGfupl4FU8YKvhylebz4xhuCxG1XNk79WhvWB0cJi7Y
        XIDTn0iWLaIEQ7CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 409DD13428;
        Fri, 17 Mar 2023 11:04:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RzkODzRJFGQhBQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 17 Mar 2023 11:04:20 +0000
Message-ID: <ab97a4bf-b89a-0c8e-f871-d5f2b3dfa645@suse.cz>
Date:   Fri, 17 Mar 2023 12:04:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] mm/slub: fix help comment of SLUB_DEBUG
Content-Language: en-US
To:     Vernon Yang <vernon2gm@gmail.com>, akpm@linux-foundation.org,
        42.hyeyoo@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230314071601.343817-1-vernon2gm@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230314071601.343817-1-vernon2gm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/23 08:16, Vernon Yang wrote:
> Since commit ab4d5ed5eeda ("slub: Enable sysfs support for
> !CONFIG_SLUB_DEBUG"), disabling SLUB_DEBUG also disables
> SLUB sysfs support that is not true anymore, so fix it correctly.
> 
> Signed-off-by: Vernon Yang <vernon2gm@gmail.com>

Thanks, slightly reworded and pushed to slab/for-6.4/trivial

> ---
>  mm/Kconfig.debug | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index c3547a373c9c..9a90a88ce053 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -60,9 +60,8 @@ config SLUB_DEBUG
>  	select STACKDEPOT if STACKTRACE_SUPPORT
>  	help
>  	  SLUB has extensive debug support features. Disabling these can
> -	  result in significant savings in code size. This also disables
> -	  SLUB sysfs support. /sys/slab will not exist and there will be
> -	  no support for cache validation etc.
> +	  result in significant savings in code size, the /sys/kernel/slab
> +	  will exist but will not provide e.g. cache validation.
>  
>  config SLUB_DEBUG_ON
>  	bool "SLUB debugging on by default"

