Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CF760933F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 15:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiJWNIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 09:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiJWNIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 09:08:46 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8EB72686
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 06:08:45 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id bb5so4328515qtb.11
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 06:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M2gFbSafpLVxGrnK3Tg0qfxx8Aw3Ko79Pc/9rxHqkHE=;
        b=tk+9lB/p62KsoOWZwKVgbrB9kefnRaiILS3i9PUqiUK7nbDX7D5bE9WabBDSYYUH2V
         n0vMtsySnXCyuCStJyxfLd9kPF3pO6B8oqyVknFpBUG46r/w+n+QC6xgxoZXgAJdWc9y
         mZlBTLQQhZnMQNdH4VA4qh97EOFF/QxPFxP1fu3cm9UC1DI3TAIBrshJf+bS/XqyDKHq
         hdH4myOSAMFvp0ClzUdyfebmgOyqp4JiaHqB/YLIMFwKczDyjvMtL3XuvpDUcVHACQ1f
         HQe3KPdA1hD8oGrB9YUhHBfGj51/nLXH8u9QHf27YxmbO6USXTFn26lJSvhpMB9CvBYZ
         NTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M2gFbSafpLVxGrnK3Tg0qfxx8Aw3Ko79Pc/9rxHqkHE=;
        b=2dno3LGgTAGmhCRcbO19hw5eNU+l2OtDdZ3Z9nwDc9H+wGa1X9WoMlysqtPhB/tKCl
         yY1i+8IXCr8xDMYCjg3gW0ZYwuTmD+c/tx3QOmdNftk0QLc9Z1xLaNk0ArUkdnL1qFfo
         86Z8wEIopLMZpPKsbQ2moEag70HZfJw3o+KJ3+YWmZzZnP1IvzdvmrHVuC92r+D+s493
         fZnNVDeGYfwupnxw/tyIl6/OM7AMvEdzjfLJ1ZNBKJj+Q5H5G7hVgMxr3DSA6b5uPZJM
         peA7jiZYCKM3UVSr17o1kE4V1gzms3B6ElieHz08AQpvQfb/lf2oqRW/GbV5N1RxNCYd
         a4jQ==
X-Gm-Message-State: ACrzQf2RZvLqOeWymlH/cqIVvN7KISk5kxXPCI56H2uqmZCDaPgfWr8F
        X5miFiw1XsaCXFtOLIGnKRSzhaPXlAkgyg==
X-Google-Smtp-Source: AMsMyM4yB1O6iJktvFaOE7c4rZ/hz48mOlHEfNbFjhzth0nVbpSnr07dQ43Guds7Ay2eEvGS2vvzBg==
X-Received: by 2002:a05:620a:2905:b0:6ee:cf79:bf9c with SMTP id m5-20020a05620a290500b006eecf79bf9cmr20178717qkp.28.1666530503551;
        Sun, 23 Oct 2022 06:08:23 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id j12-20020a05620a288c00b006b640efe6dasm13061603qkp.132.2022.10.23.06.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 06:08:22 -0700 (PDT)
Message-ID: <ef6a326b-5c61-988b-2ec2-cd8e233e5d28@linaro.org>
Date:   Sun, 23 Oct 2022 09:08:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 2/2] dt-bindings: ASoC: simple-card: Add
 system-clock-id property
Content-Language: en-US
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, broonie@kernel.org,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kuninori.morimoto.gx@renesas.com
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221022162742.21671-1-aidanmacdonald.0x0@gmail.com>
 <20221022162742.21671-2-aidanmacdonald.0x0@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221022162742.21671-2-aidanmacdonald.0x0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2022 12:27, Aidan MacDonald wrote:
> This is a new per-DAI property used to specify the clock ID argument
> to snd_soc_dai_set_sysclk().

You did no show the use of this property and here you refer to some
specific Linux driver implementation, so in total this does no look like
 a hardware property.

You also did not explain why do you need it (the most important piece of
commit msg).

> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/simple-card.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
> index ed19899bc94b..cb7774e235d0 100644
> --- a/Documentation/devicetree/bindings/sound/simple-card.yaml
> +++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
> @@ -57,6 +57,12 @@ definitions:
>        single fixed sampling rate.
>      $ref: /schemas/types.yaml#/definitions/flag
>  
> +  system-clock-id:
> +    description: |
> +      Specify the clock ID used for setting the DAI system clock.


With lack of explanation above, I would say - use common clock framework
to choose a clock...


Best regards,
Krzysztof

