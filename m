Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BD8625FA6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbiKKQiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 11:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbiKKQiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:38:08 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E89836B6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 08:38:07 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso5951213wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 08:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JaZVtFPPaLB1/chqLl5fXGZ9i1oLa0XpBUVRRJxd9cI=;
        b=oZCyUTC9OW+Gao72Y6/Jy0WiGm29zM05RoR72zuCvODktorROYHO90I0wv148pxUJ3
         AK61RQ5U62x4Rnv5wOt/kwbKT5vkWIIPdCRPXskn4CArmJgmYxukx8Hh8N76iuaCMrd7
         MW4BNKE8I6AEM2OdLf7LnD4v5v7FD0+MyVozjtociVgHUjoblN1xGqLciTssf0vn8yCz
         qZZlviM95ZPISMODwyEEmZBjsaEbNadI2eRHZwsGxZK/LPmRtWGtB2Pg6WvIsgmsaEbR
         hMnqAU42OrbaqPR7sqSKj7H1sU3uW9peKaVCDtg0ihVjd3g0A3w17vX2/J5XbztGcgsE
         fnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JaZVtFPPaLB1/chqLl5fXGZ9i1oLa0XpBUVRRJxd9cI=;
        b=RPRJnSigE1UD569BJMpwjBRXMKzKa3UhLCtOB6qoNcLNYqLB85cwAtR7f9sblVPydM
         /9s/ze40xMtA9CicpNUHMd2D7zQZitcmUi/AIAN4WzmybT8JhVtaqIhuB77WceBty/gE
         Yz7lpRxRQfLn4i5DeLsIMnQ+zCidnq89Ra0zevp6NlWVsf7puvy4GGy6AtVn4tsTamdC
         NCCdNP8k47dO2EPBs/+BVG2r/yyOsc2G1org0+gs/KWN4ntHUZiczzYDx/KSxEwD8NWq
         wUuWOkBBzXWPg85t2ROexNmu4ZGn31UAPmZ8zI2E1DyjJMZ1+3X3qxCEF6xTvP4/meOY
         FMqg==
X-Gm-Message-State: ANoB5pmba7jXWNQx7SMfC6StlpUV9nZQ/wv4ssYunWuSFFJlN6+0w14i
        QfuGQs0lLBxij9EZFMQ/daQfUA==
X-Google-Smtp-Source: AA0mqf6HUq6BrzK2oEKsXnAtk4vpxLbFgDJjdJOF9mPjgwAHthV3NwQdmBi7OGwhXnGVxnyF073M6Q==
X-Received: by 2002:a05:600c:204d:b0:3cf:a3c4:59b3 with SMTP id p13-20020a05600c204d00b003cfa3c459b3mr1854849wmg.198.1668184686366;
        Fri, 11 Nov 2022 08:38:06 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id w9-20020adfee49000000b00228cd9f6349sm2265623wro.106.2022.11.11.08.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 08:38:05 -0800 (PST)
Message-ID: <49722205-bd5b-8241-d2ff-7eb956e05ec1@linaro.org>
Date:   Fri, 11 Nov 2022 16:38:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] ASoC: codecs: wsa883x: use correct header file
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
References: <20221108001829.5100-1-rdunlap@infradead.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20221108001829.5100-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/11/2022 00:18, Randy Dunlap wrote:
> Fix build errors when GPIOLIB is not set/enabled:
> 
> ../sound/soc/codecs/wsa883x.c: In function 'wsa883x_probe':
> ../sound/soc/codecs/wsa883x.c:1394:25: error: implicit declaration of function 'devm_gpiod_get_optional'; did you mean 'devm_regulator_get_optional'? [-Werror=implicit-function-declaration]
>           wsa883x->sd_n = devm_gpiod_get_optional(&pdev->dev, "powerdown",
> ../sound/soc/codecs/wsa883x.c:1395:49: error: 'GPIOD_FLAGS_BIT_NONEXCLUSIVE' undeclared (first use in this function)
>           GPIOD_FLAGS_BIT_NONEXCLUSIVE);
> ../sound/soc/codecs/wsa883x.c:1414:9: error: implicit declaration of function 'gpiod_direction_output'; did you mean 'gpio_direction_output'? [-Werror=implicit-function-declaration]
>           gpiod_direction_output(wsa883x->sd_n, 1);
> 
> Fixes: 43b8c7dc85a1 ("ASoC: codecs: add wsa883x amplifier support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Banajit Goswami <bgoswami@quicinc.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: alsa-devel@alsa-project.org
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> ---

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>



> v2: add the correct header file instead of messing with GPIOLIB in Kconfig
> 
>   sound/soc/codecs/wsa883x.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -- a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
> --- a/sound/soc/codecs/wsa883x.c
> +++ b/sound/soc/codecs/wsa883x.c
> @@ -7,7 +7,7 @@
>   #include <linux/debugfs.h>
>   #include <linux/delay.h>
>   #include <linux/device.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>   #include <linux/init.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
