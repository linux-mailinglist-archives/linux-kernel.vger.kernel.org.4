Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE13A6E4A15
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjDQNif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjDQNi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:38:29 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2181676B9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:38:25 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id a10so9805410ljr.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681738703; x=1684330703;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sxeJD9/zGNXy/RTKZruExxY/TG6TAvdOAAv05PMUESw=;
        b=kKNbP91GQ5UBPQ4iiq3aw+/n+Z11Q3G8KtkL8hQugnCtuiclhvkJIugzsNiNDf9j01
         t13oIqP8/z8+tAzRksiHRwZqPCufUGUWa3eLYLyQsY38QEcn49NMY59jqMeI6e1+YYzU
         Sp3/LlmAFTuOEbD34/7ZWVeHliouu8EdtK6pZDYb9qEqxpVgSsAiJxSJqv79RGjnlu9H
         CZbB7j6LlAyUuhgtZ3IHIMY4e86GXydNf5NgbsZ6nEtdcA0MJNwV8O8Sr6ZEPGXIhFEl
         8Mvc1OG40atCGSvX5hM/td8PHeyYmhStI6FTlKPYsHJzN62HOf86kgsjn9qvsUdIUK+B
         kH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681738703; x=1684330703;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sxeJD9/zGNXy/RTKZruExxY/TG6TAvdOAAv05PMUESw=;
        b=K7XER1XvZt0HwG+4c1efiBAfc9GTT7YjKEnn3hsoCdJTWFRM4YQBqgB0yXt9XmOUis
         Ir2MbD0VowiRVG8eYoAuqhTJjK/S3hDumKKvAeJWpwzLEaJ+XG2uvjbLHYek4oTiz/9b
         wrTyc3csg988rKqqUqZ0QBJNPe1JrESSkov41IGwxAEmh2CTsriP23szAGiSpv+2P3s0
         t8PL0igtWsupXkj0bgS33Y5yLwt0V8grS9GEmhTXnXMzsKdRkr9PbRVxDENdpUfLXmds
         MmGniXlfDzHGWnYURg/1cPD9iGmHJo90nF4JQb9ZkHzsvNC/BqMaKaBZ5JP8KFyxshbK
         gixA==
X-Gm-Message-State: AAQBX9cbHxobV+KiLSpftDzoDbGGIAvvqrk4jF6KzWHKgl/krUOMscbi
        FW+vX7C4mYOkwKnA+ZDwTaGp/Q==
X-Google-Smtp-Source: AKy350YZvftTLyPAfQnKUozMLRKcke2ymH9J45/NHW6VLrKWxkbu0FTJ7YG8zldXLyTsUb8BbzH7Iw==
X-Received: by 2002:a2e:8ec9:0:b0:299:ac61:4e78 with SMTP id e9-20020a2e8ec9000000b00299ac614e78mr4024831ljl.10.1681738703310;
        Mon, 17 Apr 2023 06:38:23 -0700 (PDT)
Received: from [192.168.1.101] (abyk99.neoplus.adsl.tpnet.pl. [83.9.30.99])
        by smtp.gmail.com with ESMTPSA id z22-20020a2e9b96000000b002a8c1462ecbsm742157lji.137.2023.04.17.06.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 06:38:22 -0700 (PDT)
Message-ID: <df752738-824c-20be-f7d9-83e470912260@linaro.org>
Date:   Mon, 17 Apr 2023 15:38:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] drm/panel: novatek-nt35950: Improve error handling
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        neil.armstrong@linaro.org, Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230415-konrad-longbois-next-v1-1-ce695dc9df84@linaro.org>
 <ea9f27a2-ce75-01a9-3758-0fe0bfcd1e5e@linaro.org>
 <e9c2e179-eacc-151e-123b-a4e425e76333@collabora.com>
 <51d94c13-853c-519d-f206-722288b5edf4@collabora.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <51d94c13-853c-519d-f206-722288b5edf4@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.04.2023 11:44, AngeloGioacchino Del Regno wrote:
> Il 17/04/23 11:44, AngeloGioacchino Del Regno ha scritto:
>> Il 17/04/23 09:25, Neil Armstrong ha scritto:
>>> On 15/04/2023 13:00, Konrad Dybcio wrote:
>>>> In a very peculiar case when probing and registering with the secondary
>>>> DSI host succeeds, but the OF backlight or DSI attachment fails, the
>>>> primary DSI device is automatically cleaned up, but the secondary one
>>>> is not, leading to -EEXIST when the driver core tries to handle
>>>> -EPROBE_DEFER.
>>>>
>>>> Unregister the DSI1 device manually on failure to prevent that.
>>>>
>>>> Fixes: 623a3531e9cf ("drm/panel: Add driver for Novatek NT35950 DSI DriverIC panels")
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>>   drivers/gpu/drm/panel/panel-novatek-nt35950.c | 8 +++++++-
>>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35950.c b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
>>>> index abf752b36a52..7498fc6258bb 100644
>>>> --- a/drivers/gpu/drm/panel/panel-novatek-nt35950.c
>>>> +++ b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
>>>> @@ -585,8 +585,11 @@ static int nt35950_probe(struct mipi_dsi_device *dsi)
>>>>                  DRM_MODE_CONNECTOR_DSI);
>>>>       ret = drm_panel_of_backlight(&nt->panel);
>>>> -    if (ret)
>>>> +    if (ret) {
>>
>> If this is not a dual-DSI case, nt->dsi[1] will be NULL: I agree it's still
>> fine as in the kernel won't crash in that case, but for logical correctness
>> I would still account for that:
>>
>>          if (num_dsis == 2)
>>              mipi_dsi_device_unregister(nt->dsi[1]);
>>
>>>> +        mipi_dsi_device_unregister(nt->dsi[1]);
>>>> +
>>>>           return dev_err_probe(dev, ret, "Failed to get backlight\n");
>>>> +    }
>>>>       drm_panel_add(&nt->panel);
>>>> @@ -602,6 +605,9 @@ static int nt35950_probe(struct mipi_dsi_device *dsi)
>>>>           ret = mipi_dsi_attach(nt->dsi[i]);
>>>>           if (ret < 0) {
>>
>> Same here, please add a check for num_dsis.
Right, I'll send an incremental patch to fix the fix, thanks
for spotting this!

Konrad
>>
>> Regards,
>> Angelo
> 
> Eh, too late, I just noticed that this got picked already...
