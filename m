Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAB173DDC0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 13:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjFZLev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 07:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjFZLeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:34:03 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DA0E4E;
        Mon, 26 Jun 2023 04:33:48 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-313f1085ac2so760521f8f.1;
        Mon, 26 Jun 2023 04:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687779227; x=1690371227;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uWJ2m6hM9/UPQKvpX2tpk6Qe1joTg2sFo9t5IZ8C27Y=;
        b=Ql+QylvB8BF3n6GaTFakt0E4R1symVCHCxKDdOET0ikCKPKIj1sM99/pElSs9o4Xac
         7fmS52uahIUk3AhQqELcArmqkluj4ZdAkE4PSfTbkrdRBehN3NVNog3rRzjkwlSIxuty
         XZSmuMaQq7YWHm5C9w2KjDDkgaG2fFgQsjsRtSxqgqs11IkOu5oaUEQFxAwtO6/gLNL3
         7QdUXieZM76VQOVRDLSDhDVazpPogTKowWfw+++vKkL8vUkHIXja4x3PWNkVwvD+R/Xh
         g3cdNLtmJ/jlZmHpg2asTkQ/cHe+nzlvNAMtYsyhX6V146lfsXrT1rYfeI3YlJcVGzxf
         VzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687779227; x=1690371227;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uWJ2m6hM9/UPQKvpX2tpk6Qe1joTg2sFo9t5IZ8C27Y=;
        b=GdALX3x16AIWMkswHqsHfoSC8O60CA1I5Ti4rlZDuVuFUl/4K7VH69y5fJ4vtSOA7t
         MC5P/uMrx2qXrpazJNtS+05xtRX1RMgOuYBe9l69W7fkdsSr3y3fdQ9RYxGaiT/3NuDr
         xSpt5OqAC++89LEKW0lbLZa+eaAULKAT2b/m7CJWEB8yq5O16XYPQc5BlkSqbvxhTuUP
         cuyuZ1pBVfCJQzGVUcv8TDnmg8DP58T1YMH8lgx/ADztpPfC2k8B3D4ky2Z2zvkzndfx
         D+5RXA+Q8WahTHbiOgYTDxPRtq0WUkRHLysdC/AumudyzHijeSlUS/Kk0g1pFhzFQxi8
         7uzg==
X-Gm-Message-State: AC+VfDwjJuG1mlmsqkpeNzTflTKF3AvjAMx/8f7dFbZkVk95qJ9RUjjZ
        mkmO+pL/Xt8Ag/r7d5eOfXM=
X-Google-Smtp-Source: ACHHUZ6ZixlK0wtfB4OMzQSPYlAyxGBq5ZXjbhz31HoIbkWwoYL7eASSfRQ1bj4aUvmvOn9f6/NLog==
X-Received: by 2002:a5d:4242:0:b0:311:de0:8975 with SMTP id s2-20020a5d4242000000b003110de08975mr19166661wrr.55.1687779226846;
        Mon, 26 Jun 2023 04:33:46 -0700 (PDT)
Received: from ?IPV6:2a00:e180:158d:7600:d62f:c4fb:6eee:7b87? ([2a00:e180:158d:7600:d62f:c4fb:6eee:7b87])
        by smtp.gmail.com with ESMTPSA id u18-20020a5d6ad2000000b00313e90d1d0dsm5186467wrw.112.2023.06.26.04.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 04:33:46 -0700 (PDT)
Message-ID: <f63137cd-2032-1598-a1d7-484248ef1d02@gmail.com>
Date:   Mon, 26 Jun 2023 13:33:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/4] drm/ttm: Don't leak a resource on swapout move
 error
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
        <thomas.hellstrom@linux.intel.com>, intel-xe@lists.freedesktop.org
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
        Nirmoy Das <nirmoy.das@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230626091450.14757-1-thomas.hellstrom@linux.intel.com>
 <20230626091450.14757-5-thomas.hellstrom@linux.intel.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230626091450.14757-5-thomas.hellstrom@linux.intel.com>
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
> If moving the bo to system for swapout failed, we were leaking
> a resource. Fix.
>
> Fixes: bfa3357ef9ab ("drm/ttm: allocate resource object instead of embedding it v2")
> Cc: Christian König <christian.koenig@amd.com>
> Cc: "Christian König" <ckoenig.leichtzumerken@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v5.14+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/ttm/ttm_bo.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index c0e3bbd21d3d..d9a8f227f310 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -1166,6 +1166,7 @@ int ttm_bo_swapout(struct ttm_buffer_object *bo, struct ttm_operation_ctx *ctx,
>   		ret = ttm_bo_handle_move_mem(bo, evict_mem, true, ctx, &hop);
>   		if (unlikely(ret != 0)) {
>   			WARN(ret == -EMULTIHOP, "Unexpected multihop in swaput - likely driver bug.\n");
> +			ttm_resource_free(bo, &evict_mem);
>   			goto out;
>   		}
>   	}

