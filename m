Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28C86CBFBF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjC1Mup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbjC1MuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:50:20 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CD2B762
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 05:49:53 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x17so15682029lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 05:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680007790;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jCNbxQ3fkGvJYs2TX33NcPDCODW7FsfSszu815y/rdQ=;
        b=MCBz/LZ9QWIqZkNLClNZpldMscplkOY6KzPqm1ilp2RwTVfmV6UEQ0JKtFLu8PoQjq
         3ZurKAErQhtWYyGO5BwuIEOAqgRh+dg2Oncy2FVTzp/93sEFFH55Erv73ZqM1KV/CRau
         fl7jjJbxJMce9RuRypNxCc9n3SpiU7UhV6WJZoV2T+74raMrrfeVr/6V3IhC64sdjQPi
         CO8L8Z7JVDaY8fsyals5wdV2tMO8HswrTlL8cANPYAtmuGW3WIkqtUy23LgjITyVtjQ0
         /clW442b3UHROWdk249Xem0GB/81P6RiyUuhKape9EPSV//F5XCz5zVST5krR/5rUpRW
         ILDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680007790;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCNbxQ3fkGvJYs2TX33NcPDCODW7FsfSszu815y/rdQ=;
        b=e3JqQwXZPxShDGdCVf8oeMcFFq/Jyn0TxlLdJZACnB2iyyYJqqiRNk+GpLo3WN+c5L
         +BcLM4LENCMC6dyp60s3TCzDkXLcjIUTz8SfzrJlAWOvzAtAL+mzoPTHhGrPBwIN+20o
         +51kWLgj8qG0hhA0e4jRUjdr7i1s7czMDU8OEV0q2laJtmPO0deTHx7JNtmPA7L0L6HD
         8yyOCF5pRHsxikPoXNWY+5chSCnAI2kjDvwpsPInzzv2k0BSnX8w0HvYy9+RUeDmo86Q
         /NISe56XxW2fx84td4p3hRkOJY8ufn4c/42WzQidmbyOhwQTVPg/hhkgi2fZKlYMu6m8
         2dkw==
X-Gm-Message-State: AAQBX9ckq8rcaJCErWB+7okqTxkjdbhDIpSVsOogYAHbqsL11qyyAdj7
        8lBsdCfl+/5otMlfU8fT7O/j8g==
X-Google-Smtp-Source: AKy350Yz7V22vnXhTlNBr/g4If2TgMC4S4/UxSSsgOQXdwXSlabRzM3x60Oy2TKJkb+WGsIgRC+sxA==
X-Received: by 2002:a19:7404:0:b0:4e8:3f38:7d21 with SMTP id v4-20020a197404000000b004e83f387d21mr4456398lfe.28.1680007790309;
        Tue, 28 Mar 2023 05:49:50 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id w7-20020ac24427000000b004db4f2f08f7sm5062556lfl.28.2023.03.28.05.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 05:49:49 -0700 (PDT)
Message-ID: <42ce6819-8a56-83ab-13c9-f49b3167b42e@linaro.org>
Date:   Tue, 28 Mar 2023 15:49:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 01/10] Revert "drm/msm: Add missing check and destroy for
 alloc_ordered_workqueue"
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
References: <20230306100722.28485-1-johan+linaro@kernel.org>
 <20230306100722.28485-2-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230306100722.28485-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2023 12:07, Johan Hovold wrote:
> This reverts commit 643b7d0869cc7f1f7a5ac7ca6bd25d88f54e31d0.
> 
> A recent patch that tried to fix up the msm_drm_init() paths with
> respect to the workqueue but only ended up making things worse:
> 
> First, the newly added calls to msm_drm_uninit() on early errors would
> trigger NULL-pointer dereferences, for example, as the kms pointer would
> not have been initialised. (Note that these paths were also modified by
> a second broken error handling patch which in effect cancelled out this
> part when merged.)
> 
> Second, the newly added allocation sanity check would still leak the
> previously allocated drm device.
> 
> Instead of trying to salvage what was badly broken (and clearly not
> tested), let's revert the bad commit so that clean and backportable
> fixes can be added in its place.
> 
> Fixes: 643b7d0869cc ("drm/msm: Add missing check and destroy for alloc_ordered_workqueue")
> Cc: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/gpu/drm/msm/msm_drv.c | 2 --
>   1 file changed, 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

