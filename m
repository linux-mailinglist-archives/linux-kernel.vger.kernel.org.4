Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3302C6185EA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiKCRM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiKCRLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:11:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FFE1A23B;
        Thu,  3 Nov 2022 10:11:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 515BE21C4A;
        Thu,  3 Nov 2022 17:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667495465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X3iAPKntN8bwEwSZKuEYeP/9JRqwBa3SZbFPVF6pxVM=;
        b=vR9OkHI9NPjlluxOknVMsYrw7uh/arpCvfU0ytSr/PsFpF6U/ETxnLg2UHflMUAuADAW+I
        ycrlTizsIHpIQIZbievRSrhD34q0EctoUFu5NpadeIwhQQlWXYkzGVEn8eSA83aQU5UoBa
        9hUN13smcE8Sdloq56qPpTViFXOWxkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667495465;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X3iAPKntN8bwEwSZKuEYeP/9JRqwBa3SZbFPVF6pxVM=;
        b=Pcpy6hkqntziw2oZvSI3CC7+3FS6jLwCGOqP6YiDvIvCa/balcuTqKiSIXCBTzid2FRHHE
        eNtlYnCDW03B35DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2580A13AAF;
        Thu,  3 Nov 2022 17:11:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VFWXCCn2Y2PvWQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 03 Nov 2022 17:11:05 +0000
Message-ID: <fccfaa2a-07f0-7d4d-027b-ec283a1cb748@suse.cz>
Date:   Thu, 3 Nov 2022 18:11:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] mm/slab_common: repair kernel-doc for __ksize()
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221031092920.976-1-lukas.bulwahn@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221031092920.976-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/22 10:29, Lukas Bulwahn wrote:
> Commit 445d41d7a7c1 ("Merge branch 'slab/for-6.1/kmalloc_size_roundup' into
> slab/for-next") resolved a conflict of two concurrent changes to __ksize().
> 
> However, it did not adjust the kernel-doc comment of __ksize(), while the
> name of the argument to __ksize() was renamed.
> 
> Hence, ./scripts/ kernel-doc -none mm/slab_common.c warns about it.
> 
> Adjust the kernel-doc comment for __ksize() for make W=1 happiness.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thanks! Adding to slab/for-6.1-rc4/fixes

Vlastimil

> ---
>  mm/slab_common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 33b1886b06eb..74a991fd9d31 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1010,7 +1010,7 @@ EXPORT_SYMBOL(kfree);
>  
>  /**
>   * __ksize -- Report full size of underlying allocation
> - * @objp: pointer to the object
> + * @object: pointer to the object
>   *
>   * This should only be used internally to query the true size of allocations.
>   * It is not meant to be a way to discover the usable size of an allocation
> @@ -1018,7 +1018,7 @@ EXPORT_SYMBOL(kfree);
>   * the originally requested allocation size may trigger KASAN, UBSAN_BOUNDS,
>   * and/or FORTIFY_SOURCE.
>   *
> - * Return: size of the actual memory used by @objp in bytes
> + * Return: size of the actual memory used by @object in bytes
>   */
>  size_t __ksize(const void *object)
>  {

