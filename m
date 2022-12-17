Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA76264F8E7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 13:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbiLQMGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 07:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQMGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 07:06:12 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73272DF1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 04:06:10 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id y16so4813757wrm.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 04:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=POKL28xeKckqwooEWuCkv5vGb2GjbJvUlEjyzAmbpY8=;
        b=jiZSEsI42oaWN/lhuulJgHTYd2WoL+sd2M+NYHisj8JvoEVAtdek3GPpyztYdzO1eW
         IAaTNQ+oU6u1qPvNhi7fgYTHUhBN+ch9JxG0C6l0272PdfBcHFrC2P/IfBKLq5nWTYO2
         Og/brGySLw5EyoBGR4yIsKTUHwvqk7Ll0Vu0we1ZzLY5CB/CKEOdV6Fgx4H6cIdexr99
         aDfC3p35CdKeQQptej8W8WqZta308wdnFNLiZldl/ZySdY3JhyIEAaxu4VQAGLDS6o0c
         cNDj4/UDS71NK1fZF6gWv8NnDJbV1JBjz5K2pW/WDnigmUyOEzAW0R5ZC81Veouf7jrj
         ycfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POKL28xeKckqwooEWuCkv5vGb2GjbJvUlEjyzAmbpY8=;
        b=73bfHcgsmHua2FP8fBwU5r9cMYHvaVUfTLMNLSLEwj7+65M3jSZD2FSbTtsbQGeuOZ
         2xrYlUcVbzlrbbvWVSfGLad2x492eQdbx4IzxaLcsPitDS17P6x6mPGXTHhzo5aw6+AH
         0c15vNzm6GolWet09BbCUUY4IlJjWpFKrsDKkWEmbqUIyq8wlCv7WmXC2AVmfKIpHuZ0
         nSP4ZYUppOsHMDFWaB4wvGAWpNVOYLKrUhNbSEXXm3wIKBmscOnY02FxKBFd12mQbO4K
         fz66f8BC2P+xy+wmdKXmdoSRyed/tK0bWVkFGwuX+uSo/+tGJhfBYMAD03JcRlvTzANb
         2bJg==
X-Gm-Message-State: ANoB5plUulDbkI4T+HcC4j1fReeps1/V35UUjnUDVcrPBq0M/aYeyuVP
        3/jbAcj9E3budB4Zxr9LV20=
X-Google-Smtp-Source: AA0mqf7KTCacAybkroui6e8EqfpF8Ukpby5PrdXTFPQ4zRHtpE2yeiH7GhzUv6GuNzRNsCP6NwdjfA==
X-Received: by 2002:a5d:4a0e:0:b0:242:643e:6954 with SMTP id m14-20020a5d4a0e000000b00242643e6954mr24254256wrq.14.1671278769322;
        Sat, 17 Dec 2022 04:06:09 -0800 (PST)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id y6-20020adfe6c6000000b00241e8d00b79sm5494067wrm.54.2022.12.17.04.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 04:06:08 -0800 (PST)
Date:   Sat, 17 Dec 2022 12:06:08 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, urezki@gmail.com,
        stephen.s.brennan@oracle.com, willy@infradead.org,
        akpm@linux-foundation.org, hch@infradead.org
Subject: Re: [PATCH v2 3/7] mm/vmalloc.c: allow vread() to read out
 vm_map_ram areas
Message-ID: <Y52wsONH+u/h0nuj@lucifer>
References: <20221217015435.73889-1-bhe@redhat.com>
 <20221217015435.73889-4-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221217015435.73889-4-bhe@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2022 at 09:54:31AM +0800, Baoquan He wrote:
> Currently, vread can read out vmalloc areas which is associated with
> a vm_struct. While this doesn't work for areas created by vm_map_ram()
> interface because it doesn't have an associated vm_struct. Then in vread(),
> these areas will be skipped.
>
> Here, add a new function vb_vread() to read out areas managed by
> vmap_block specifically. Then recognize vm_map_ram areas via vmap->flags
> and handle them respectively.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/vmalloc.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 59 insertions(+), 7 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 190f29bbaaa7..6612914459cf 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3515,6 +3515,51 @@ static int aligned_vread(char *buf, char *addr, unsigned long count)
>  	return copied;
>  }
>
> +static void vb_vread(char *buf, char *addr, int count)
> +{
> +	char *start;
> +	struct vmap_block *vb;
> +	unsigned long offset;
> +	unsigned int rs, re, n;
> +
> +	vb = xa_load(&vmap_blocks, addr_to_vb_idx((unsigned long)addr));
> +
> +	spin_lock(&vb->lock);
> +	if (bitmap_empty(vb->used_map, VMAP_BBMAP_BITS)) {
> +		spin_unlock(&vb->lock);
> +		memset(buf, 0, count);
> +		return;
> +	}
> +	for_each_set_bitrange(rs, re, vb->used_map, VMAP_BBMAP_BITS) {
> +		if (!count)
> +			break;
> +		start = vmap_block_vaddr(vb->va->va_start, rs);
> +		if (addr < start) {
> +			if (count == 0)
> +				break;
> +			*buf = '\0';
> +			buf++;
> +			addr++;
> +			count--;
> +		}

I may be missing something here, but is this not essentially 'if the address is
below a used region, write a single null byte into the buffer and continue,
assuming we are now in a used area?'

This doesn't seem right, but I am happy to be corrected (perhaps we only expect
to be a single byte below a start region?)

> +		/*it could start reading from the middle of used region*/
> +		offset = offset_in_page(addr);
> +		n = (re - rs + 1) << PAGE_SHIFT - offset;

The kernel bot has already picked up on this paren issue :)

> +		if (n > count)
> +			n = count;
> +		aligned_vread(buf, start+offset, n);
> +
> +		buf += n;
> +		addr += n;
> +		count -= n;
> +	}
> +	spin_unlock(&vb->lock);
> +
> +	/* zero-fill the left dirty or free regions */
> +	if (count)
> +		memset(buf, 0, count);
> +}
> +
>  /**
>   * vread() - read vmalloc area in a safe way.
>   * @buf:     buffer for reading data
> @@ -3545,7 +3590,7 @@ long vread(char *buf, char *addr, unsigned long count)
>  	struct vm_struct *vm;
>  	char *vaddr, *buf_start = buf;
>  	unsigned long buflen = count;
> -	unsigned long n;
> +	unsigned long n, size, flags;
>
>  	addr = kasan_reset_tag(addr);
>
> @@ -3566,12 +3611,16 @@ long vread(char *buf, char *addr, unsigned long count)
>  		if (!count)
>  			break;
>
> -		if (!va->vm)
> +		vm = va->vm;
> +		flags = va->flags & VMAP_FLAGS_MASK;
> +
> +		if (!vm && !flags)
>  			continue;
>

This seems very delicate now as going forward, vm _could_ be NULL. In fact, a
later patch in the series then goes on to use vm and assume it is not null (will
comment).

I feel we should be very explicit after here asserting that vm != NULL.

> -		vm = va->vm;
> -		vaddr = (char *) vm->addr;
> -		if (addr >= vaddr + get_vm_area_size(vm))
> +		vaddr = (char *) va->va_start;
> +		size = flags ? va_size(va) : get_vm_area_size(vm);

For example here, I feel that this ternary should be reversed and based on
whether vm is null, unles we expect vm to ever be non-null _and_ flags to be
set?

> +
> +		if (addr >= vaddr + size)
>  			continue;
>  		while (addr < vaddr) {
>  			if (count == 0)
> @@ -3581,10 +3630,13 @@ long vread(char *buf, char *addr, unsigned long count)
>  			addr++;
>  			count--;
>  		}
> -		n = vaddr + get_vm_area_size(vm) - addr;
> +		n = vaddr + size - addr;
>  		if (n > count)
>  			n = count;
> -		if (!(vm->flags & VM_IOREMAP))
> +
> +		if ((flags & (VMAP_RAM|VMAP_BLOCK)) == (VMAP_RAM|VMAP_BLOCK))
> +			vb_vread(buf, addr, n);
> +		else if ((flags & VMAP_RAM) || !(vm->flags & VM_IOREMAP))
>  			aligned_vread(buf, addr, n);
>  		else /* IOREMAP area is treated as memory hole */
>  			memset(buf, 0, n);
> --
> 2.34.1
>
