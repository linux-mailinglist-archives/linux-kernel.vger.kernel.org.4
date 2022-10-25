Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B7E60CBC8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiJYM1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiJYM06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:26:58 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBE3182C56
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:26:53 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id f22so7345552qto.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xCIU8CZjfuPZw7IS/sRiIMsineNAClLLYlq1Bt65gWI=;
        b=ty+JBmSBnsoFGQoN3FXgSzneooTBYtKYwlu9c6DqoYdZCjylA4+3SGvmOyGcw0EtW3
         PdTYmJOMFd9R8PDUnsmwKjyc2gdo6c1Y09qcZOU+4kAfOnozKWRuER+6ofzO5YkM73fc
         CEEO4JkJEgzv+WKgfBbgrG0p1HTo6II37FW5LspmNYqzy1x1DrVmnAB0a+dqxxabAhqa
         BC2wOJcaF5lUTxND52MSe/AEnVp6QmL0t7VHRnv08qVP0tViL+lPhsbta0FcTIetAZ5C
         ycvGDrTe9wW2CCxZrzqALE3qDr2btEXOWON7R0wjjOcktz3lknY0Z4ZHTat57cVMsPZC
         oxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xCIU8CZjfuPZw7IS/sRiIMsineNAClLLYlq1Bt65gWI=;
        b=uYb3iNyjpZHm+3kIFuqoLlkPhsxD63+nGzBdBi7j9OjRcViaP7VB/IMpE5Bw4WfsFP
         3gGFA+ab9e5X/hvivALxKL6W+UOCA0/e/t/g6QeaHb1Pl5d/m4GIbWBq52aY7aBuFRu1
         RSZKvQT+dUx+sJV6ZOolPM3EfOSMFRX6WichxBQgMyISzbrlQZ870Q3SQ035oPm35gsq
         t4quMC095x94ggjPXEYiHNJykDuZdphgHCD/3bZc6NQfgswFyjzNTpqTnpxnVS+jeN3a
         MSOVrzNiLk1Cs76diNW5OP1l8hrE10NE4n48M9dSU148kfKaQjDjSrFiCrmqTa2Gp0va
         QN7g==
X-Gm-Message-State: ACrzQf32bIxepNd560hKHc9GaAmBex5zxjOV7BGmuw04WQEwb9RKqrIl
        8HvR9pgvDX9sPiwSGqAj8wj0pQ==
X-Google-Smtp-Source: AMsMyM616hRFDMD78cMDiRdvGGqoFXuOCYHofMIyqXoqO7EGsp72sOoMZz4ijuR6Nlf4tF3bGhCT8g==
X-Received: by 2002:a05:622a:310:b0:39c:dc1f:dba6 with SMTP id q16-20020a05622a031000b0039cdc1fdba6mr30526799qtw.121.1666700812319;
        Tue, 25 Oct 2022 05:26:52 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id 135-20020a37068d000000b006b5cc25535fsm1889640qkg.99.2022.10.25.05.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 05:26:51 -0700 (PDT)
Message-ID: <a344ef3c-edc7-99f7-4507-9c7378f38a87@linaro.org>
Date:   Tue, 25 Oct 2022 08:26:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 3/4] ASoC: dt-bindings: rt5682: Set sound-dai-cells to
 1
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221024220015.1759428-1-nfraprado@collabora.com>
 <20221024220015.1759428-4-nfraprado@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221024220015.1759428-4-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2022 18:00, Nícolas F. R. A. Prado wrote:
> Commit 0adccaf1eac9 ("ASoC: dt-bindings: rt5682: Add #sound-dai-cells")
> defined the sound-dai-cells property as 0. However, rt5682 has two DAIs,
> AIF1 and AIF2, and therefore should have sound-dai-cells set to 1. Fix
> it.
> 
> Fixes: 0adccaf1eac9 ("ASoC: dt-bindings: rt5682: Add #sound-dai-cells")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

