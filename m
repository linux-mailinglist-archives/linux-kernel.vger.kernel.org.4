Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5C76C67A3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjCWMGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjCWMGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:06:18 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329D92737
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:05:31 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id p13-20020a05600c358d00b003ed346d4522so922767wmq.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679573129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5nthKiCCtskWOUHDP1TDgAH52w68ye1G1Vy1mMMFfmc=;
        b=ABuY7nwI5teQ7fIK/HTE63eTYkyyYFsLAki6OOc3ckXsMNf+wybFErzGDFIx64SkBW
         TfZolPVkGRkFmm99MFhlRpscA7vDPFIUiT0fBT+LU0U2hNxBkf1qrIoVWyr4abv8ae8+
         MliJSEyVFz+EKMJe2E1uUIyww61YSdZHysWWvFDhOSz6Zszw7bjPoa3RgZ7ezGAaOiqw
         jVqN2DsIeYQD7tsRWPbf1pLtc+gbZR8in1myMGyE2fFuGr57nNY6VnPh6evc4vgGzIrp
         1e8aFDkg3eTT7hiNogo3LR7avj9ukvAtkVhd1OXrZ2Kb6TYgPeNxMnWwq0+0ma82faRK
         bIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679573129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nthKiCCtskWOUHDP1TDgAH52w68ye1G1Vy1mMMFfmc=;
        b=aUiRUqXttWhuqt1p9W5Ob2GqmUUUfD/wqO14i4jNlKrDDxb24cjlCIlRl8811wZApV
         23Xfj505uBGa4x5I78jGmQYUUotWfY1zDuB3EnPNezGgBzpcOdJaQwUQr2i7qCtO60mk
         xbc447CFtDPZonjxO7MXJQ5gNvHvQDQgRgx4A+FbtDyZmBrYww62c2pBVtVRv8dFsOt6
         BjVlXfrVXyPpskXrvFYRK6bB6oaYRL6yCwfATBqPSMVlgqAPLEIR06cegbI60mmnKcYx
         CEurHvhgFGu27cVDGBcESERtZVCI7LIyWvd6jP7QC5iJwv6Co1BqZnNpvk4XesW/gYF5
         jA+w==
X-Gm-Message-State: AO0yUKVp770U8Dkn0xsKZHjjlbQ0Y2WDxc1BzA3Tv+yZ5lHJfdhgD6hu
        LRlf4M7YMWlR93MS+x5ZXFs=
X-Google-Smtp-Source: AK7set/0wItgi8/Z4pUs/AX2dffkEaRdh4RUbdXf/xaS2GNyABTujAc4Q1wTMMdyXGX6BLJbYyinkA==
X-Received: by 2002:a7b:c848:0:b0:3ed:2b27:5bcc with SMTP id c8-20020a7bc848000000b003ed2b275bccmr2077905wml.38.1679573129526;
        Thu, 23 Mar 2023 05:05:29 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id f24-20020a7bc8d8000000b003eb596cbc54sm1772219wml.0.2023.03.23.05.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 05:05:28 -0700 (PDT)
Date:   Thu, 23 Mar 2023 12:05:28 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Baoquan He <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: vmalloc: fix vmap_ram_vread_iter() return value
Message-ID: <0958ea78-c299-478b-8840-f1cafd893771@lucifer.local>
References: <20230323115903.1483668-1-arnd@kernel.org>
 <20230323115903.1483668-2-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323115903.1483668-2-arnd@kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 12:58:35PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The error handling in vmap_ram_vread_iter() can return an
> uninitialized value in some cases:
>
> mm/vmalloc.c:3539:6: error: variable 'remains' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>         if (!vb)
>             ^~~
> mm/vmalloc.c:3587:17: note: uninitialized use occurs here
>         return count - remains + zero_iter(iter, remains);
>                        ^~~~~~~
>
> Move the initialization up a few lines.
>
> Fixes: d9cab54f7737 ("mm: vmalloc: convert vread() to vread_iter()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  mm/vmalloc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ebfa1e9fe6f9..fb216495fe5a 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3521,7 +3521,7 @@ static size_t vmap_ram_vread_iter(struct iov_iter *iter, const char *addr,
>  	struct vmap_block *vb;
>  	unsigned long offset;
>  	unsigned int rs, re;
> -	size_t remains, n;
> +	size_t remains = count, n;
>
>  	/*
>  	 * If it's area created by vm_map_ram() interface directly, but
> @@ -3545,7 +3545,6 @@ static size_t vmap_ram_vread_iter(struct iov_iter *iter, const char *addr,
>  		goto finished_zero;
>  	}
>
> -	remains = count;
>  	for_each_set_bitrange(rs, re, vb->used_map, VMAP_BBMAP_BITS) {
>  		size_t copied;
>
> --
> 2.39.2
>
>

This was also already fixed in a more recent version of this patch set, in
v5 I believe. Again apologies for this!

Latest version at
https://lore.kernel.org/all/cover.1679566220.git.lstoakes@gmail.com
