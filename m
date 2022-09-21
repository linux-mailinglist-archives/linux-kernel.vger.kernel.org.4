Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E492F5BFE96
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 15:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiIUNCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 09:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIUNCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 09:02:40 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9CD8C45C;
        Wed, 21 Sep 2022 06:02:39 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MXdqb488Vz4xG7;
        Wed, 21 Sep 2022 23:02:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1663765357;
        bh=tVR1ERCIck0Y/ChkqfjA1TreIEUvGzhMF7W62nKahGc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Fva9vD0ssU2FUxkajpYcHjuMWl9N8zWDrV/aVcLriXoX3ZYSRLOPJgAkftVV3ovZN
         w3WG05uyfBRed/OZa3/kwWAorpSOpzadjrWJkc3w1b74Sv0Mqepb8nR04a/Cq4RgWR
         UlLJvW5oK9sNOnDaH4gytX+xeLkQf1B1UT1Cts3iXpdeHxTloX8uKys3i7z2JjHl9r
         Z0Kbyiqv7MYaXdHkFPWz7IcMPmTdFKJErQYVv2vu029DEES/T6/7Xq0lzzGXOYoIT/
         xDQYXX/USXSJAjBZgWJXuniGr9rB1KiJzL53BO1XG5alqgSNMsFto1kNH/W9Ffr/XI
         OTi1tl6JvjzkQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        David Hildenbrand <david@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1 2/3] powerpc/prom_init: drop PROM_BUG()
In-Reply-To: <20220920122302.99195-3-david@redhat.com>
References: <20220920122302.99195-1-david@redhat.com>
 <20220920122302.99195-3-david@redhat.com>
Date:   Wed, 21 Sep 2022 23:02:35 +1000
Message-ID: <877d1w2844.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:
> Unused, let's drop it.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/powerpc/kernel/prom_init.c | 6 ------
>  1 file changed, 6 deletions(-)

Thanks. I'll take this one via the powerpc tree, and the others can go
via wherever?

cheers

> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index a6669c40c1db..d464ba412084 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -96,12 +96,6 @@ static int of_workarounds __prombss;
>  #define OF_WA_CLAIM	1	/* do phys/virt claim separately, then map */
>  #define OF_WA_LONGTRAIL	2	/* work around longtrail bugs */
>  
> -#define PROM_BUG() do {						\
> -        prom_printf("kernel BUG at %s line 0x%x!\n",		\
> -		    __FILE__, __LINE__);			\
> -	__builtin_trap();					\
> -} while (0)
> -
>  #ifdef DEBUG_PROM
>  #define prom_debug(x...)	prom_printf(x)
>  #else
> -- 
> 2.37.3
