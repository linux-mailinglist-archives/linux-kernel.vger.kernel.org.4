Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6347447DC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 10:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjGAIC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 04:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjGAIBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 04:01:48 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F5510E5
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 01:01:45 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51d7e8dd118so3015578a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 01:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688198504; x=1690790504;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+/7TuI/hQwkZhyymEuytfw8tljO+CF4LNtsLy3kjnEs=;
        b=Ou/rDZBt62vQN0g6wf8sflLQ5ypZfVU4sHRXMyBJBFWIjv9gqQQLTCW8EuKRyG+NBR
         xIjScWjY5dZgKHSHb9rlP8TnNy0on9Y8TcqwZ1UzOn8GrFjI0qhSNC6opsr3C8vcxj4v
         KibRH8x4qmo93VqHlE6Dr/B1pTtee/5+fgVlV9wtt10SAMxLe1UswkSjz5eQ5BFk1rTO
         aZmeLwwNeabJtPoDohYLsGNztEwTH6mjAuDrKhZi/I4BSmNsLP4PJOIfnj8s0Cvmd383
         8Zq2GzVGIbNP+8T/GLoqX/B0e4spM8/Pdr9htwsjSif/G/lHJM5Ig4Svo0dXK9dc/6RD
         NfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688198504; x=1690790504;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+/7TuI/hQwkZhyymEuytfw8tljO+CF4LNtsLy3kjnEs=;
        b=aoVdrhNknb73umDidhWWP5n5bUgPxYvjmGt8GDgnRvGcuhKln0oU7xkOOZclCX7T/D
         NbZjL3aQZIifuqnlxxpYJESFbbbx3jv70dxxoIjkYFmUB6TgXMq4ZpATegdVz/STd8Mt
         Hfgn6Lgji369MhcNcNwk9Oe6SV0DUozX0S751nnlcdtcPk1MpKZ/WdUyDGxW0dEIfzll
         gIxzxGvHZLkMOJayAgH03oBnI/cI9QIX2HU3rdcIlfViwYadLp8XCkol14YuFkOLfuKT
         F2PtXi6lNNMiGqjBfSsjpQwsjb9sUa8aTw8utaKv58flAwOPQyyICUsBPvd1QJzTFE+J
         lntQ==
X-Gm-Message-State: ABy/qLY+Uc8Vc7LhZx9UJk1OJH32LBuTpEkxE8hLEN7JXNpv0bNI6KSW
        wmzT2R+1nqyZCyzYwrEcbnGcFQ==
X-Google-Smtp-Source: ACHHUZ5F8xUIAMknqjsoPu2of+I/Txby9lVW5dSl1hKwXHTjXld0F3vDjgHEZdD7r802EbZERuvF+g==
X-Received: by 2002:a17:907:2c66:b0:991:fef4:bb7 with SMTP id ib6-20020a1709072c6600b00991fef40bb7mr4187077ejc.73.1688198503859;
        Sat, 01 Jul 2023 01:01:43 -0700 (PDT)
Received: from [192.168.10.214] ([217.169.179.6])
        by smtp.gmail.com with ESMTPSA id bm4-20020a170906c04400b00973ca837a68sm8996694ejb.217.2023.07.01.01.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jul 2023 01:01:43 -0700 (PDT)
Message-ID: <207f70b5-e017-33bc-bf46-206b3fb69a04@linaro.org>
Date:   Sat, 1 Jul 2023 10:01:42 +0200
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

I cannot find this report. This is an open source work and public
collaboration. The "Reported-by" usually means that the issue was
reported to us, in some way, usually in public. Can we see the report?
Otherwise adding non-public, non-verifiable reports is useless and
clutters our report-credit-system.

Best regards,
Krzysztof

