Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6826861F9A0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbiKGQ1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiKGQ1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:27:06 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E4D20F51
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:23:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8D1511F889;
        Mon,  7 Nov 2022 16:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667838220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VdVD9Iy0J2qFkVY2cKemTlbtgmWlhAb1cl0vbCf5xbI=;
        b=vBUVPW0o/dbrqtz3mD/bXG7oo6YeijAN4TfU7xNCshIE4vb3PPu8hZczD4I3vtd5i7da8X
        V/MOmSToQIx36MlFVgWhlmcqD9zSCGDCrqN+cmOFEbl+GVaF4Nac9WNHolAHYrlLsnq0FW
        I2+wck7CmtdTpc/HxJ6U7rNEEoN8gJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667838220;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VdVD9Iy0J2qFkVY2cKemTlbtgmWlhAb1cl0vbCf5xbI=;
        b=n92vtlvGc69ogFNhO2Gpbw4jMAXPuHVc2k8fAnvoasp1beVEu/t59Ut6ly5HDIvHmM8EO4
        enKwkl9y6dIDPYBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5BEE213AC7;
        Mon,  7 Nov 2022 16:23:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zbAlFQwxaWM+WQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 07 Nov 2022 16:23:40 +0000
Message-ID: <71b57f2d-37cd-9c33-c6b2-7f4b14b2b691@suse.cz>
Date:   Mon, 7 Nov 2022 17:23:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: Duplicate kernel-doc comments for ksize()
Content-Language: en-US
To:     Akira Yokosawa <akiyks@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <d33440f6-40cf-9747-3340-e54ffaf7afb8@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <d33440f6-40cf-9747-3340-e54ffaf7afb8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/22 11:41, Akira Yokosawa wrote:
> Hi Kees,
> 
> "make htmldocs" reports duplicate C declaration of ksize()
> as follows:
> 
> /linux/Documentation/core-api/mm-api:43: ./mm/slab_common.c:1428: WARNING: Duplicate C declaration, also defined at core-api/mm-api:212.
> Declaration is '.. c:function:: size_t ksize (const void *objp)'.
> 
> This is due to the kernel-doc comment for ksize() added in
> include/linux/slab.h by a commit you have authored:
>   05a940656e1e ("slab:Introduce kmalloc_size_roundup()").
> 
> /**
>  * ksize - Report actual allocation size of associated object
>  *
>  * @objp: Pointer returned from a prior kmalloc()-family allocation.
>  *
>  * This should not be used for writing beyond the originally requested
>  * allocation size. Either use krealloc() or round up the allocation size
>  * with kmalloc_size_roundup() prior to allocation. If this is used to
>  * access beyond the originally requested allocation size, UBSAN_BOUNDS
>  * and/or FORTIFY_SOURCE may trip, since they only know about the
>  * originally allocated size via the __alloc_size attribute.
>  */
> 
> There is another kernel-doc comment in mm/slab_common.c (originally
> by Manfred, since v2.6.14):
> 
> /**
>  * ksize - get the actual amount of memory allocated for a given object
>  * @objp: Pointer to the object
>  *
>  * kmalloc may internally round up allocations and return more memory
>  * than requested. ksize() can be used to determine the actual amount of
>  * memory allocated. The caller may use this additional memory, even though
>  * a smaller amount of memory was initially specified with the kmalloc call.
>  * The caller must guarantee that objp points to a valid object previously
>  * allocated with either kmalloc() or kmem_cache_alloc(). The object
>  * must not be freed during the duration of the call.
>  *
>  * Return: size of the actual memory used by @objp in bytes
>  */
> 
> I guess the one in slab_common.c is outdated and can be removed.
> Can you please take care of it?

Thanks for the report, I've removed the comment myself in a slab.git fixes
branch I'll be sending a PR for this week:

https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/commit/?h=slab/for-6.1-rc4/fixes&id=c18c20f16219516b12a4f2fd29c25e06be97e064

>         Thanks, Akira

