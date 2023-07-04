Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D31746ABE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjGDHgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjGDHfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:35:55 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8A2199
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 00:35:54 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99364ae9596so231979366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 00:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688456153; x=1691048153;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JgkFjDmJN4L2mqgKB/0BaH17v6L6ydu/UCB0MlAoBco=;
        b=XbB2CLRM6WmaMSTNEHIOJpeVYs4bCWJglJGn6V25auCeVm/GMm7BQ+zHJDDIuAoUoP
         EtBS1J62jz6pz3PEc4w8Lkw+tnRAHpF0Wvw7+Be3x1jMgWZ70up0ou0i5WzRYhYGr0+L
         kykn+LoNoRGk1ijBZrBNq+i5xKOKgJszEmyWgxNDtYImT/SKoDvlNqExo+495CilRhLK
         +Ok/X/pxJPZyh6NpNaJ/Pv0zbri5fyNQlF/p1vRhlNnOoaBoXOAvrxZR/uyWDBI4aCoa
         VwKX1lqhkIQONhRSle5dM4ROKmMoAyl8eOFZU79d0QTmF8Q2a/aWhCwZviVvmKtIViQ7
         G+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688456153; x=1691048153;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JgkFjDmJN4L2mqgKB/0BaH17v6L6ydu/UCB0MlAoBco=;
        b=OJ7UdHG5IZLHlGbKAQyDH7rKSg9YYA/Cb89/IcDKw2OM1Wqy21YZ+puNB70+2HToGk
         M/M2zG43H02355kZI2vXbMP9ChfkiacS3L8HIaPzBa9PeYSA5yp3UFLH4Cfx57ArJkdM
         DZxghqL+EtTPihMWHLhQABP8LB1Y6QGD6S/cP0GGyzQP8BVFiTlC13OmvDW0QAgMy77a
         VNNOk+o6dq4i7nJN32CKBjIzav3607Af4S6h/wOtX4neptdswswlxa4elTz7sc4uuDwJ
         mbZ704eOS2bSWpUG5FDZf3lWbTMxWSIo26XEeQov8YOe7RsOD+TJlB/uOM5pWAIfMhyR
         vx4Q==
X-Gm-Message-State: ABy/qLa0y07xU30qx3oXOBqbnWyZulgfLSi5PYYpws05WOWaMjMhoypA
        xwzGvTQgrzxW9Dx455uBtoC2mg==
X-Google-Smtp-Source: APBJJlF8KCRzGhgGld7oGDnmBvSCdNcyLsFRT7uwR9ICZAIjQ65DHVppLpZmPi1mo/hvSiAXP/RX5Q==
X-Received: by 2002:a17:906:ae51:b0:966:471c:2565 with SMTP id lf17-20020a170906ae5100b00966471c2565mr8331205ejb.48.1688456152720;
        Tue, 04 Jul 2023 00:35:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id x26-20020a1709065ada00b00992025654c1sm9721649ejs.179.2023.07.04.00.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 00:35:52 -0700 (PDT)
Message-ID: <88edab79-5f9a-007d-f2e9-d264178fe80b@linaro.org>
Date:   Tue, 4 Jul 2023 09:35:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/exynos: fix a possible null-pointer dereference due
 to data race in exynos_drm_crtc_atomic_disable()
Content-Language: en-US
To:     Tuo Li <islituo@gmail.com>, inki.dae@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com,
        airlied@gmail.com, daniel@ffwll.ch, alim.akhtar@samsung.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@outlook.com, BassCheck <bass@buaa.edu.cn>
References: <20230630021906.1035115-1-islituo@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230630021906.1035115-1-islituo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2023 04:19, Tuo Li wrote:
> The variable crtc->state->event is often protected by the lock 
> crtc->dev->event_lock when is accessed. However, it is accessed as a 
> condition of an if statement in exynos_drm_crtc_atomic_disable() without
> holding the lock:
> 
>   if (crtc->state->event && !crtc->state->active)
> 
> However, if crtc->state->event is changed to NULL by another thread right
> after the conditions of the if statement is checked to be true, a
> null-pointer dereference can occur in drm_crtc_send_vblank_event():
> 
>   e->pipe = pipe;
> 
> To fix this possible null-pointer dereference caused by data race, the 
> spin lock coverage is extended to protect the if statement as well as the 
> function call to drm_crtc_send_vblank_event().
> 
> Reported-by: BassCheck <bass@buaa.edu.cn>
> Signed-off-by: Tuo Li <islituo@gmail.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

