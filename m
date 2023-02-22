Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E427269FB01
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjBVSaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjBVSaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:30:21 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D12539CE3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 10:30:17 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id o8so1168905ilt.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 10:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1677090617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/OiGxXdhMijif1OrnbqcE7MLbFzI92LPmx4R6TbKMMc=;
        b=W+vuxZLUd+mJ/F8W+ZcBVKYcXbuIEKmpD5s5pnEKXDFW9CLflCZRp6TF47PIZwBAmJ
         M7nTySzgGanAsSVnGZB8jiSW2AEN4oUhGQjCRv53nW/KD/nWIC42gQQ/ZxhS2GBfrG+R
         7kJZgPoe1A4PbbXRTV0oFKciryCmH7ZYVewL6Pw5CUAlZ3QSLkbiUf7HMejD2sgD/BtY
         47MPGZF7R9msLMlSO64M4zFyu1OQrZ18kkE8b9v3kXhGVrEMvhOWXMPtEHw4v6d6LNSq
         i5oW6858mcF3gSuOInrQ4cfPx69Z9WkQeJaWV67zjxPR6xjzRJQtCOWRpo0U4BHVSpvl
         PgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677090617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/OiGxXdhMijif1OrnbqcE7MLbFzI92LPmx4R6TbKMMc=;
        b=NSC0QYPn0xE9sEnEmxtbomxwAb6XFRHpekXZ+DBVw26AXi2zWI/xp1HiGUtXm/+AMt
         i5OcbZY2ZJEBOYViLFvACSxDaQY9xVIWwS0/RXNmL09yrtefaz1D/PAxUJ3ZZ+BU0ptp
         E7Ftoklf/WrcitAp53JpEIF/JhbHnpZxKM2M4bGeHuujt+WxODE2zLXbUhskVRP/ZJlG
         C6eZrgiX1eyU4Sds5ltb3o+67i1D3JgtIQmZJ0aaczt9tKTeDRF2TOlHF+gKAWZ4zExO
         9RzKLoJFIUBxpx78gTu3jFAcDT4MxGPWfR0Zcv2o/lsaGc/Z2H7F7KaYkcJZmHD2UYUJ
         YtEA==
X-Gm-Message-State: AO0yUKX3wCRCNQ10KjknWjWya/onj1auhBSVOyUMcMBfZ6pUnIGYzoCl
        ON2DEyF272s1CN0MhMK2h2csKg==
X-Google-Smtp-Source: AK7set/e1iwBIhPd5GBJKzX/zo+fr7RQssIJpTzPLRJTrJallE9NEohMFmQMhtKpGONDG2YzmQu8nw==
X-Received: by 2002:a05:6e02:d08:b0:316:e2ee:3a15 with SMTP id g8-20020a056e020d0800b00316e2ee3a15mr2621798ilj.1.1677090617221;
        Wed, 22 Feb 2023 10:30:17 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id g14-20020a056e021a2e00b00313d86cd988sm2579889ile.49.2023.02.22.10.30.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 10:30:16 -0800 (PST)
Message-ID: <b0c82199-fb96-08a2-6158-cb1655b6ba3d@kernel.dk>
Date:   Wed, 22 Feb 2023 11:30:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 2/2] io_uring: Add KASAN support for alloc_caches
Content-Language: en-US
To:     Breno Leitao <leitao@debian.org>, asml.silence@gmail.com,
        io-uring@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gustavold@meta.com, leit@meta.com,
        kasan-dev@googlegroups.com, Breno Leitao <leit@fb.com>
References: <20230222180035.3226075-1-leitao@debian.org>
 <20230222180035.3226075-3-leitao@debian.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230222180035.3226075-3-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/23 11:00?AM, Breno Leitao wrote:
> -static inline struct io_cache_entry *io_alloc_cache_get(struct io_alloc_cache *cache)
> +static inline struct io_cache_entry *io_alloc_cache_get(struct io_alloc_cache *cache,
> +							size_t size)
>  {
>  	if (cache->list.next) {
>  		struct io_cache_entry *entry;
>  		entry = container_of(cache->list.next, struct io_cache_entry, node);
> +		kasan_unpoison_range(entry, size);
>  		cache->list.next = cache->list.next->next;
>  		return entry;
>  	}

Does this generate the same code if KASAN isn't enabled? Since there's a
4-byte hole in struct io_alloc_cache(), might be cleaner to simply add
the 'size' argument to io_alloc_cache_init() and store it in the cache.
Then the above just becomes:

	kasan_unpoison_range(entry, cache->elem_size);

instead and that'd definitely generate the same code as before if KASAN
isn't enabled.

-- 
Jens Axboe

