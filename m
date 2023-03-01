Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71976A68EC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 09:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCAI2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 03:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjCAI2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 03:28:14 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68FD10C3;
        Wed,  1 Mar 2023 00:28:11 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id v11so9670612plz.8;
        Wed, 01 Mar 2023 00:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677659291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7sZ5QMejw6iYZe3voviTFum1T1dofKPjV1mBViIgC/U=;
        b=E/+sjHiN+X5ygvglxuZ8/nnSHxEAHz/HVcpSuWxVf17Q/8mk5CioW0pyKTi1qxGpvn
         r9lXC2Czoa8DLgEY5iI8+wnnKTHdNCUsO4ezS1ygiTn6tWtksLUQ9Nz3a2sWX5dQj8c0
         XVLSeAkYBRgla4jvIbrFS6xneXuGoN5ox7wNeVDKVNPeMEDBQf+bfIzLuuiFZhQ+7i3I
         4+KNf1BXoPA5R4BBkIRWe8nv6Nqai4z1kSJolcVNMnoOCnZKbkcdRTx9Eimx0L/o+MLL
         xH+YZALu0z79b645yC/PMHm2aoUN0M8emzviiVAPIBLU3N4gtsPRaS1HFddEpCphSP55
         ATLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677659291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7sZ5QMejw6iYZe3voviTFum1T1dofKPjV1mBViIgC/U=;
        b=KGPyjZZ2M4e6qxbn4qE249mwFPseiq+r+RsaUefjg+oQL2/72tGlq0ZEW3emP2/Cvm
         U/ln/BiBZ+fWmBbAy9s+gqWq5pxIvq5B+LR+2Fo4XpcnB3QEe6q0dlDs2cmPXIGJCvSR
         cMrmGHgogVdJbhVZUxi3z7T59Tl2qp4s0vul3kQDX0a2E9Xf+9q5fkJNHgAUVQpq2tpw
         nFLbm0cMvUX0BDR5osSVshyiL4KpINP2tkX+PnLwgooWvvX6q6ZDc3SEsLX/wJ1R1Zw9
         DLCxoVJnhcXt9pyzK6n7OFzcG0tGbjyn8r/uBwXuCiVAp7RDcRMDQc+gt38DJfCOxoDX
         Hw3w==
X-Gm-Message-State: AO0yUKU/1+phi84i1RaUFjBdqGD0NZGvS/Lz9E23J8kG04j0UzUGumz9
        4tfV0YAdSNA6ByRHD6MHxes=
X-Google-Smtp-Source: AK7set+f85af+gXx0M8VaSMb/VOvinKTLPhYimAmMWJMRIThpaCS0eXbsQbHbmRqFMbxDMhAgNHb7A==
X-Received: by 2002:a05:6a21:6d8a:b0:cc:c69b:f7f1 with SMTP id wl10-20020a056a216d8a00b000ccc69bf7f1mr7161371pzb.15.1677659291078;
        Wed, 01 Mar 2023 00:28:11 -0800 (PST)
Received: from [192.168.43.80] (subs03-180-214-233-68.three.co.id. [180.214.233.68])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7810f000000b005b6f63c6cf4sm7321262pfi.30.2023.03.01.00.28.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 00:28:10 -0800 (PST)
Message-ID: <635a2923-b69a-4ce9-f37d-6fe50b6dd164@gmail.com>
Date:   Wed, 1 Mar 2023 15:28:02 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v8 01/16] dma-buf/dma-fence: Add deadline awareness
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Gustavo Padovan <gustavo@padovan.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230228225833.2920879-1-robdclark@gmail.com>
 <20230228225833.2920879-2-robdclark@gmail.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230228225833.2920879-2-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/23 05:58, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Add a way to hint to the fence signaler of an upcoming deadline, such as
> vblank, which the fence waiter would prefer not to miss.  This is to aid
> the fence signaler in making power management decisions, like boosting
> frequency as the deadline approaches and awareness of missing deadlines
> so that can be factored in to the frequency scaling.
> 
> v2: Drop dma_fence::deadline and related logic to filter duplicate
>     deadlines, to avoid increasing dma_fence size.  The fence-context
>     implementation will need similar logic to track deadlines of all
>     the fences on the same timeline.  [ckoenig]
> v3: Clarify locking wrt. set_deadline callback
> v4: Clarify in docs comment that this is a hint
> v5: Drop DMA_FENCE_FLAG_HAS_DEADLINE_BIT.
> v6: More docs
> v7: Fix typo, clarify past deadlines
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>

I have given my Reviewed-by from v7 [1], but it didn't get picked up,
thus giving it again:

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thanks.

[1]: https://lore.kernel.org/linux-doc/Y%2F7LfLxhIjDpD4D3@debian.me/

-- 
An old man doll... just what I always wanted! - Clara

