Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4E473DD9F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 13:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjFZLdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 07:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjFZLdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:33:04 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550B2A0;
        Mon, 26 Jun 2023 04:33:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-313f18f5295so1054749f8f.3;
        Mon, 26 Jun 2023 04:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687779182; x=1690371182;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+SRZEwipWy/cjOgEXgKgnNMeRlmoMeF7Dl+vBl4nmyI=;
        b=SDlbF25K8CznCfDXhIQspLYCYiziLOk5/eskJUr+xpO5seAEQ6lJmPo8Xrp54wb72q
         p+PQ423QOfOuArzmwjCl+nJuJUDnMVRi+k0xOZ+oq2CAd1ygaZRYddDLem17dAZLwsIw
         UEd6VRquDR6rsZlp4qpMxDALmIGjfEdlfsnaOjsRE2z7x5i2kNiZ/5jFgi1B/EXNSrav
         gaNTYUJ/s+OFqgQzFI8pAdHAprmywKwNVXXho544UrbpCUIrYvlyWvGM7WTPyNZGWejr
         emluld6C6B42FvWApLfisxICs804QJt5a23iyD8h5X/BceGX72K+r8z0QsBJadCLDw28
         qX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687779182; x=1690371182;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+SRZEwipWy/cjOgEXgKgnNMeRlmoMeF7Dl+vBl4nmyI=;
        b=YXaUEETOQ9jpzfBy4Moqnz0SUcqBpE44OEoAdBfQqgQDgGwAzpqQDZMuOXcCgmctPF
         RW493CgiWF/u7ehNjwpi3YgvQYkUBlJc62PrTDkgrw+5VTml3y9cgo2JRxCxOtP7BPES
         UU/eyxTaN1iSU5WnOA98Xyt1/oyEH8byzIFxFy38EcNg/oY2ezDgJKTKMo0cEORcneiX
         GIAQMQcjQel4MARxVGMmjAAG753YQuPC2CgOcBHzcQ/rKUhzREmTwqP3J+DzxbwG94Q3
         QCIoCEeglaoes/E5odDyj+5TpfWF5jejyLl9B7W3oM/aCH98iHck33MicgK1G0PLzANt
         5aWg==
X-Gm-Message-State: AC+VfDyCa9NI5r6LPsVfrnmZzbyNtE7NraZvYqREw74MwJQJhTZ+QFpm
        cM8tvQBlYfbeG3DTlcM14F0=
X-Google-Smtp-Source: ACHHUZ4yUVe1NS+g9PNDkBGGvzC4bdn2WCFLjpynRmfAcWWAU1VoJXhjGm1U4gu7U5oeFzwBnVNLeg==
X-Received: by 2002:adf:fd49:0:b0:311:e96:a6f2 with SMTP id h9-20020adffd49000000b003110e96a6f2mr23242376wrs.29.1687779181492;
        Mon, 26 Jun 2023 04:33:01 -0700 (PDT)
Received: from ?IPV6:2a00:e180:158d:7600:d62f:c4fb:6eee:7b87? ([2a00:e180:158d:7600:d62f:c4fb:6eee:7b87])
        by smtp.gmail.com with ESMTPSA id t1-20020adfe441000000b00313f45f74a8sm1564636wrm.103.2023.06.26.04.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 04:33:01 -0700 (PDT)
Message-ID: <aa189924-795c-0bd0-1a85-b60445572153@gmail.com>
Date:   Mon, 26 Jun 2023 13:32:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/4] drm/ttm: Don't leak a resource on eviction error
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>, intel-xe@lists.freedesktop.org
Cc:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org,
        stable@vger.kernel.org, Nirmoy Das <nirmoy.das@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Andi Shyti <andi.shyti@linux.intel.com>
References: <20230626091450.14757-1-thomas.hellstrom@linux.intel.com>
 <20230626091450.14757-4-thomas.hellstrom@linux.intel.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230626091450.14757-4-thomas.hellstrom@linux.intel.com>
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
> On eviction errors other than -EMULTIHOP we were leaking a resource.
> Fix.
>
> v2:
> - Avoid yet another goto (Andi Shyti)
>
> Fixes: 403797925768 ("drm/ttm: Fix multihop assert on eviction.")
> Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v5.15+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Reviewed-by: Nirmoy Das <nirmoy.das@intel.com> #v1

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/ttm/ttm_bo.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 615d30c4262d..c0e3bbd21d3d 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -458,18 +458,18 @@ static int ttm_bo_evict(struct ttm_buffer_object *bo,
>   		goto out;
>   	}
>   
> -bounce:
> -	ret = ttm_bo_handle_move_mem(bo, evict_mem, true, ctx, &hop);
> -	if (ret == -EMULTIHOP) {
> +	do {
> +		ret = ttm_bo_handle_move_mem(bo, evict_mem, true, ctx, &hop);
> +		if (ret != -EMULTIHOP)
> +			break;
> +
>   		ret = ttm_bo_bounce_temp_buffer(bo, &evict_mem, ctx, &hop);
> -		if (ret) {
> -			if (ret != -ERESTARTSYS && ret != -EINTR)
> -				pr_err("Buffer eviction failed\n");
> -			ttm_resource_free(bo, &evict_mem);
> -			goto out;
> -		}
> -		/* try and move to final place now. */
> -		goto bounce;
> +	} while (!ret);
> +
> +	if (ret) {
> +		ttm_resource_free(bo, &evict_mem);
> +		if (ret != -ERESTARTSYS && ret != -EINTR)
> +			pr_err("Buffer eviction failed\n");
>   	}
>   out:
>   	return ret;

