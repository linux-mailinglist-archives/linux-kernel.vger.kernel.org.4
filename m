Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B726DF434
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjDLLue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjDLLu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:50:28 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2746584
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:50:19 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l10-20020a05600c1d0a00b003f04bd3691eso16974941wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1681300218; x=1683892218;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JzlTWhv62VaZiRKLsbAHxTcR/RMyd3VLsnHpLPYjrZ0=;
        b=HITWWXT1ZzgwSMkiDkpU3WdtyXJc4v0U9neVhd181NDfHOUczICq3WXhblylRXoyzu
         Jpllv9hABzVEP4o6rQaXal1iPTHlN4SdKPrmPIuyDHqJ3JA+O7GhBUNnKR9kwIpuc345
         U4T4N/hGTsDpfB+06tBUdnUZHCfOgK90gGvXaL2v93gv7ekDQfyL4vntnNkLwtoRkbYY
         8xzJGAyrcX/Wj38O/dGgEhp2P1FJi6bBoZpEHLH2giOWTRkRbLshk/j5eHoxwJRX/tGo
         l2GHDoeAVvBCn3Nwlf3DNtEffGNKsUHWQhobjc1kJVWQj58C10D/v0Mzt2uXvH2Eievc
         LL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681300218; x=1683892218;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JzlTWhv62VaZiRKLsbAHxTcR/RMyd3VLsnHpLPYjrZ0=;
        b=oUDn0tyDywLC0a982mqPdBFyFxwsNJNx13aVHMT8EE0uWGNxIlzYdHz66ODNsQrDh/
         mLRMvRP9igWtQcVd2y+c9lKJZ7bk9imwbto9o9tmudfNaOLs83AT3HzaqyUlm5XLq8LA
         RAVXmw9fIvkbwHYVUWeNjbzI+s0GClZGuDaTOG6ThwNPf09rJETqbYQ7x4O37VIpH6Jl
         Sl52ZcnodaCSOCh45Sjr2CmiFv368XBpUUN9XybPUz5rMWlsA27fWf7ZkUA8kbsHsgFU
         G2PLYae1p4yYu95vRCD4lCYNEpLyOsu/k0zK7SQjOXIBSLqv9m3aBXx1uRGD6nREHhYN
         QM9w==
X-Gm-Message-State: AAQBX9dsZsW5tUJhZI2t/Aag8eAzvxUFYH1njzYPedPO+/VMLo+FrN+Y
        07NJkUfXgLoxbstMhbu9tnxhWw==
X-Google-Smtp-Source: AKy350ZoKAMx3Ue6bjpGi/c1fA/CMA+3bO7CJPgucbkUmBjCfM2fVW6GejBg7uF/c/JaGaaF/y1McQ==
X-Received: by 2002:a7b:cb86:0:b0:3ed:cf2a:3fe8 with SMTP id m6-20020a7bcb86000000b003edcf2a3fe8mr12684691wmi.8.1681300217907;
        Wed, 12 Apr 2023 04:50:17 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id n20-20020a05600c4f9400b003ed51cdb94csm2189863wmq.26.2023.04.12.04.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 04:50:17 -0700 (PDT)
Message-ID: <aabc8050-2bf2-131a-6ce7-5b9580ff86b2@baylibre.com>
Date:   Wed, 12 Apr 2023 13:50:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] clk: mediatek: clk-mt7986-infracfg: delete the code
 related to 'base'
Content-Language: en-US
To:     Xinyi Hou <Y_Ashley@163.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230407083729.31498-1-Y_Ashley@163.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230407083729.31498-1-Y_Ashley@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2023 10:37, Xinyi Hou wrote:
> In clk_mt7986_infracfg_probe(), 'base' is allocated but never used,
> either not released on both success failure path.
> 
> Fix this by deleting 'base' and the code related to it.
> 
> Signed-off-by: Xinyi Hou<Y_Ashley@163.com>
> Reviewed-by: Dongliang Mu<dzm91@hust.edu.cn>

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

