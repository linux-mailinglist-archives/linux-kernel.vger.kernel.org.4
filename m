Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACDE673DB2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 16:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjASPjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 10:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjASPjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:39:12 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EE680177
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 07:39:11 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r9so2265343wrw.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 07:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OOhxRkaK5iJsPmgu7cE4ichYw4bJxnhNB1oQShnuPiw=;
        b=RzbKzm235PZAcKc7WeZAK6jCGYYnK4e2HJxFybcU+CbC/oAe/unT6TT0MwdrpHKAsj
         RRUNd3X+YacYM5A2vApQLC3G1GD9/d8eIweSSVzatbqb5N6GdpgMxpgq4R6e20qiUWM6
         K/U7FqDMSbYwMiO2tywoqCgXZ4qeoDgMcu1pKj0BtE4dAoroKbdF91Qi6bPNUU8qFIgI
         wj47VfIf8eT3AvXTjigfzfDBSOOK5/Y7n3fnlD6B7oUcZYDjZbfK8PLIvA4S/0XoRJ41
         rCmxG9WuaF4qO5SpIGutLo/aVmZnc3JL1dsMfCri595JTaEI6rh2rLGJdTkJva3CMRiD
         vN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OOhxRkaK5iJsPmgu7cE4ichYw4bJxnhNB1oQShnuPiw=;
        b=AVPqSQiRwylrWhRXU6OJYWgeHasUon26uDzGcZUrZmfer+YOgUa+U24RuijJHzS7Kk
         huhGNx2fQzkST8yeCDp9/6aTVWr0ItFlynOC77NZmNiFSAH0A3lSigVKIIMrlTZ2RE7w
         udOz4feGd9XkDV/FoWy4LRF72Hag6TCTu1rzll1fxgsDtuTWCcn/P7w6/dXVCL/9dsOr
         BljmTg65gThZrciMf71UnH7aU+EHvVuNRB+ZeyjlB5g8VLqBpLym8yGhCAfMC+PLsCTj
         7xpdCciG5O6sKozqhh6BxU9MWdrzXj5Z80jBuqX3A3k6K5hI2T+MEoZ6MoJ6IsIBadTr
         qSGw==
X-Gm-Message-State: AFqh2kpXY6WZX304+xgNKyLsUNaS3kVJZsVx7o3E3Kf3GvCbVfUI3R0h
        /t5C2ugEmCfcIBnWyRPuQ68rwA==
X-Google-Smtp-Source: AMrXdXtwYxY5U66bazeYqy96ygdXa4/ViKWR2UtRp2JjJBOGMcGXo6hk/d07aUoCXYWnvDgztytwnw==
X-Received: by 2002:adf:f6cf:0:b0:2bc:858a:3def with SMTP id y15-20020adff6cf000000b002bc858a3defmr18528056wrp.5.1674142749637;
        Thu, 19 Jan 2023 07:39:09 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n13-20020a5d67cd000000b002bdcce37d31sm23591319wrw.99.2023.01.19.07.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 07:39:09 -0800 (PST)
Message-ID: <479bc3b3-b923-d7c7-5c5c-b6b8b8eec7a8@linaro.org>
Date:   Thu, 19 Jan 2023 16:39:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 1/5] ASoC: samsung: remove DMA filter function and data
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <20230118161110.521504-1-arnd@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230118161110.521504-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 17:10, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This data is no longer passed by the platform code, so
> there is no point passing it down at all.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/platform_data/asoc-s3c.h |  6 ------
>  sound/soc/samsung/dma.h                |  2 +-
>  sound/soc/samsung/dmaengine.c          |  3 +--
>  sound/soc/samsung/i2s.c                | 21 +++------------------
>  sound/soc/samsung/pcm.c                | 11 +----------
>  sound/soc/samsung/spdif.c              |  9 +--------
>  6 files changed, 7 insertions(+), 45 deletions(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

