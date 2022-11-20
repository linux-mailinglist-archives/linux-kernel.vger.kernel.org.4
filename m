Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418C4631347
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 11:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiKTKFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 05:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKTKFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 05:05:38 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20F15E9D4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 02:05:36 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id f3so8749831pgc.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 02:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U/Bc33roI0zaP9sSLDzodRArZVx0/t4o6T76+RrU4H0=;
        b=ADqMPAA5ZVDwR9PpWXgLt+7nF9o55cUhfnp7ySzMXq/emBtxoJvGVLvuvbCSMZmMrs
         jYDHaEnTMXtxH6nHXqO/EiiSbFGruY+c8syRhDEAGjbwIptDNlgQR+IEinYwQy5nkf9t
         /p5UHmPtxVvsN0E/fwYHzbozJgo4lva238AuBv7iHI2KmxfE3nzQjj+/9ZgGSuS2Rrh1
         ImVhB5NRYztV5GhlO6wsAVyr84V7tTnVGMyLXdD8XbDCdiNpzGgCNOx72vfBK23yYXZ9
         761I/P6gmp3lgHm3dE/PQuIreK8yC8Y8K2SvUWk/sQZvD+2mc+V+pKDvYqT0V1IJ5nWj
         W2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U/Bc33roI0zaP9sSLDzodRArZVx0/t4o6T76+RrU4H0=;
        b=2d3zWyX9RNjPez+13zl1kcikyXn+QH4Ax/iyXSRepmonl8eWSqlmYQMitDXrZYLqRE
         QOOcmFolOunHlP8w4WZlVMkc1j4a+utW5oJnqdjUUYOkDOhF28mctPvjuDURo2KiC7tD
         mqGfaVekwGkpSmeVf1A1x/fpmmKWcJ3IQTxArf9rNYKdRPisDa8agGN/Ll/J9D0pOYO2
         sr1WkYUb8wU8NtFYXvNCUCO54Y4tQrCs5Cuwcv+JROqA1BHsq8Re4+Mp//FrjtL9xIx4
         h/iMCscYoAj0RdQ9k2YO5QSvnURHYyWS0HT/G16ZS46ByG/L8UQs3liP1MJYjpTu95jO
         TF1Q==
X-Gm-Message-State: ANoB5pmIDf/kTNMlcpE5pnYKJ6bwc1WSwOiKq0MMFa9WyRx2q8ws625R
        R2Bsb3BaLA9HHn1q8l7zOHc=
X-Google-Smtp-Source: AA0mqf4TDU/lhiFMzadOM8ogPB1ww30eKR2t74wnz/8nLfGzsB3NZSyCtiwdXRb76OFZv/31gp4ChQ==
X-Received: by 2002:a63:5343:0:b0:452:8774:d5ab with SMTP id t3-20020a635343000000b004528774d5abmr3109585pgl.74.1668938736239;
        Sun, 20 Nov 2022 02:05:36 -0800 (PST)
Received: from [198.18.0.1] ([20.78.222.52])
        by smtp.gmail.com with ESMTPSA id p29-20020aa79e9d000000b005625ef68eecsm6424358pfq.31.2022.11.20.02.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 02:05:35 -0800 (PST)
Message-ID: <a62fcd23-068d-38f0-f426-d2511e23ed73@gmail.com>
Date:   Sun, 20 Nov 2022 18:05:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] staging: android: ashmem: remove usage of list iterator
 after the loop body
Content-Language: en-US
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
References: <20220331213934.866804-1-jakobkoschel@gmail.com>
From:   IFsuse <ifsuse14@gmail.com>
In-Reply-To: <20220331213934.866804-1-jakobkoschel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/4/1 上午5:39, Jakob Koschel 写道:
> In preparation to limit the scope of a list iterator to the list
> traversal loop, use a dedicated pointer to point to the found element
> [1].
>
> Before, the code implicitly used the head when no element was found
> when using &pos->list. Since the new variable is only set if an
> element was found, the head needs to be used explicitly if the
> variable is NULL.
>
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>   drivers/staging/android/ashmem.c | 21 ++++++++++++---------
>   1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> index ddbde3f8430e..a1e245827cf6 100644
> --- a/drivers/staging/android/ashmem.c
> +++ b/drivers/staging/android/ashmem.c
> @@ -703,30 +703,33 @@ static int ashmem_pin(struct ashmem_area *asma, size_t pgstart, size_t pgend,
>   static int ashmem_unpin(struct ashmem_area *asma, size_t pgstart, size_t pgend,
>   			struct ashmem_range **new_range)
>   {
> -	struct ashmem_range *range, *next;
> +	struct ashmem_range *range = NULL, *iter, *next;
>   	unsigned int purged = ASHMEM_NOT_PURGED;
>   
>   restart:
> -	list_for_each_entry_safe(range, next, &asma->unpinned_list, unpinned) {
> +	list_for_each_entry_safe(iter, next, &asma->unpinned_list, unpinned) {
>   		/* short circuit: this is our insertion point */
> -		if (range_before_page(range, pgstart))
> +		if (range_before_page(iter, pgstart)) {
> +			range = iter;
>   			break;
> +		}
>   
>   		/*
>   		 * The user can ask us to unpin pages that are already entirely
>   		 * or partially pinned. We handle those two cases here.
>   		 */
> -		if (page_range_subsumed_by_range(range, pgstart, pgend))
> +		if (page_range_subsumed_by_range(iter, pgstart, pgend))
>   			return 0;
> -		if (page_range_in_range(range, pgstart, pgend)) {
> -			pgstart = min(range->pgstart, pgstart);
> -			pgend = max(range->pgend, pgend);
> -			purged |= range->purged;
> -			range_del(range);
> +		if (page_range_in_range(iter, pgstart, pgend)) {
> +			pgstart = min(iter->pgstart, pgstart);
> +			pgend = max(iter->pgend, pgend);
> +			purged |= iter->purged;
> +			range_del(iter);
>   			goto restart;
>   		}
>   	}
>   
> +	range = list_prepare_entry(range, &asma->unpinned_list, unpinned);
>   	range_alloc(asma, range, purged, pgstart, pgend, new_range);
>   	return 0;
>   }
>
> base-commit: f82da161ea75dc4db21b2499e4b1facd36dab275
