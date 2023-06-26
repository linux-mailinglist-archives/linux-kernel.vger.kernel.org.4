Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B53273E301
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjFZPPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjFZPPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:15:38 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F6510E4;
        Mon, 26 Jun 2023 08:15:33 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fa96fd79feso12971645e9.2;
        Mon, 26 Jun 2023 08:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687792531; x=1690384531;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PmRfirqXfSvkyoAOVtCyAnitstVlhaC7q73gfVyb+4M=;
        b=Tz3rIQUnMqhrKtipZlRQ8sTMEJdS6wklxEeNVoGqe3XAeOD0UTPdSzU2qgGrltKqFi
         RIMyxRSqw+dgR8vnDhIFK91ubOr+jvEBmk+UgYvi38nW8hCsqQApZjBKDtxsh9rfMJhF
         zTs/D2G4m+/nqDyI7UhxwD7M4YF3TZmdTnbyV/5ylE0wXb7b+CIsyMCMxzgCTO/Um/ws
         cMHmSGN5MKInTke/cSFNpdLqUjypIM9SFlyXlSCntJBBaMH3LzrSIk7ZWCOLplFESPDc
         0LupZyhvQnlbOhX5EbY6+j/d/Z3Z/Kz+FjROZ5ES26qnp7UoyVjjh9/HnXgeFRHLLRtT
         tPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687792531; x=1690384531;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PmRfirqXfSvkyoAOVtCyAnitstVlhaC7q73gfVyb+4M=;
        b=LaQViUmWQTggCNU4ocwy94cMYxtKYLF+rJJvIWBP6kYgobJwDgxPe+yG9SrEbSzH4y
         fJNPPYoAYBAKTT8BcEg8mSNOBwgViyCxndQAAH/eUXvhfAatofQdAt6THYr+3BsEw8Gl
         Vzj7etqP/8zsCaWT0O1gNRP5ciozyA66H9SYN5VzCEM7079hvMqA3HIS1H7UCC0bx8OR
         1YZmUWHgc9ycYYvgUQ7F8PzWMbMpwfFkhFFdVf8wg6Yeq0bpVKKRy25uA47ADIfup7Dx
         Btg6X20hs86HCYxCaN3zMkxktRFkpCTxFHxV5Il6mql/4ZlfpxO+Zs6N3PU2KW64QflR
         BG1A==
X-Gm-Message-State: AC+VfDw+aJMwx5b0m4BxgiCSJuGf3/jg5Ul9daGA5ZsMGT606xWuGhoW
        EyPDsCsUi3vb3JBiWNgVsLM=
X-Google-Smtp-Source: ACHHUZ5GC9RZ5QCTpLhMVxwupOthRTX84J9A9FhGSg/kiJCyizTE4+re4OC1YLSKt8hn616Hrc4NJA==
X-Received: by 2002:a7b:ce09:0:b0:3f6:536:a4b2 with SMTP id m9-20020a7bce09000000b003f60536a4b2mr24178300wmc.27.1687792531467;
        Mon, 26 Jun 2023 08:15:31 -0700 (PDT)
Received: from ?IPV6:2a00:e180:158d:7600:862:d9d5:c1f7:84a1? ([2a00:e180:158d:7600:862:d9d5:c1f7:84a1])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c22d500b003f96d10eafbsm8012451wmg.12.2023.06.26.08.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 08:15:30 -0700 (PDT)
Message-ID: <8b22c855-c84d-4b56-c94b-a3a079ab3037@gmail.com>
Date:   Mon, 26 Jun 2023 17:15:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/4] drm/ttm: Don't shadow the operation context
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>, intel-xe@lists.freedesktop.org
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Roger He <Hongbo.He@amd.com>, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, stable@vger.kernel.org,
        Matthew Brost <matthew.brost@intel.com>,
        linux-kernel@vger.kernel.org,
        Andi Shyti <andi.shyti@linux.intel.com>
References: <20230626091450.14757-1-thomas.hellstrom@linux.intel.com>
 <20230626091450.14757-3-thomas.hellstrom@linux.intel.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230626091450.14757-3-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 26.06.23 um 11:14 schrieb Thomas Hellström:
> ttm_bo_swapout() shadows the ttm operation context which may cause
> major confusion in driver callbacks when swapping out !TTM_PL_SYSTEM
> memory. Fix this by reusing the operation context argument to
> ttm_bo_swapout().
>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: Roger He <Hongbo.He@amd.com>
> Cc: <dri-devel@lists.freedesktop.org>
> Cc: <intel-gfx@lists.freedesktop.org>
> Cc: <stable@vger.kernel.org> # v4.16+
> Fixes: dc947770cf34 ("drm/ttm: enable swapout for reserved BOs during allocation")
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Acked-by: Matthew Brost <matthew.brost@intel.com>

We intentionally didn't used the parameter here, but I absolutely can't 
figure out why.

Feel free to add my rb, but let's give it some time upstream before you 
base anything on top of this. Just in case we missed something.

Regards,
Christian.

> ---
>   drivers/gpu/drm/ttm/ttm_bo.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index bd5dae4d1624..615d30c4262d 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -1154,7 +1154,6 @@ int ttm_bo_swapout(struct ttm_buffer_object *bo, struct ttm_operation_ctx *ctx,
>   	 * Move to system cached
>   	 */
>   	if (bo->resource->mem_type != TTM_PL_SYSTEM) {
> -		struct ttm_operation_ctx ctx = { false, false };
>   		struct ttm_resource *evict_mem;
>   		struct ttm_place hop;
>   
> @@ -1164,7 +1163,7 @@ int ttm_bo_swapout(struct ttm_buffer_object *bo, struct ttm_operation_ctx *ctx,
>   		if (unlikely(ret))
>   			goto out;
>   
> -		ret = ttm_bo_handle_move_mem(bo, evict_mem, true, &ctx, &hop);
> +		ret = ttm_bo_handle_move_mem(bo, evict_mem, true, ctx, &hop);
>   		if (unlikely(ret != 0)) {
>   			WARN(ret == -EMULTIHOP, "Unexpected multihop in swaput - likely driver bug.\n");
>   			goto out;

