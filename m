Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CBC618B62
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiKCW0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiKCW01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:26:27 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19E321274
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 15:26:26 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id u7so2102897qvn.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 15:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pm4RXMLMyayJrb7lXI9IxGRtGOHJZv7BC9yPVfB+mM8=;
        b=GL8m1CzuwZwzNpYIUHbow5Fvi19Ye6qn7FHPSJkUDGa7SGHl1NmnmwTIE2RPPSwVZC
         +Av/sCDTctqtN8YgL186XiH7W6YP6hsYEpbhZdHJuowuM4OzherwAPIIudwEzTghx8J3
         pg0HumM2LiB77w2KM6FvRoalcwXjQntGVF7Htyqr0NQyRAbJw7lXeUmcqpONMu1T+ZkS
         +/F5TMgZipWfMcHQlmvX6gxruNsOnQ3ck5ELgEkEU/QxhxPc5Prud9xndNiAqSKUQobQ
         1JsXNU8GtkuCt7tM1DwiWXLALlBmN5XU60R9tjo3umqEnXW0R+MoC5xnC+IFt9saIjX/
         PrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pm4RXMLMyayJrb7lXI9IxGRtGOHJZv7BC9yPVfB+mM8=;
        b=XlBWT3bs6ZjyLoppHzKdFwIo75z2S4YDBO74C3cI5HHToJ8aLNdIWHaSaCACeZYrJy
         dBihkjfWd47KgPhpHbKOxiAE6caWTABab/MJW2rWBtcltYDUdpWg6ob89ZyKaaLMlwWM
         leWF9+pucnrl1NYjkGAzmSzYeDn2s5atho7v9b+qQ3FvZ3HCabeXursleeCfVKMpd0P1
         pLAkUDOdMMrx5s5V7lzBDyGbaEQt5AprbxCLlksxyUyf4FU9RFRyUjP+M5ctl0hVhjBz
         Kqo3r5bbccK/WoRHlXGPoOUacQ5lL6EX5w2NmCS2TVgquSgg0RvhwBj3ax0x2cwfkmZ4
         SQOg==
X-Gm-Message-State: ACrzQf2ZtR36vOCfKWWvZU+2bJS2AWuP+9S/b8dvlnLxPk0WnIfZLmD0
        qYqAqYK/0LSncomzdsTBPAzCGA==
X-Google-Smtp-Source: AMsMyM7hZ5+D9gSJ6uhU8oVvFrzmk6OCUfAr9KAFklUH9XwGX9WRYuM+AJbJfAXlFjMU2GCStm9RBQ==
X-Received: by 2002:a05:6214:d0a:b0:4bb:e1a9:4c84 with SMTP id 10-20020a0562140d0a00b004bbe1a94c84mr24798897qvh.27.1667514385906;
        Thu, 03 Nov 2022 15:26:25 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id b18-20020a05620a127200b006eeb51bb33dsm1532153qkl.78.2022.11.03.15.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 15:26:25 -0700 (PDT)
Message-ID: <1b1aba4b-e260-8bee-a8f6-761946361b11@linaro.org>
Date:   Thu, 3 Nov 2022 18:26:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 2/8] ASoC: dt-bindings: realtek,rt5682s: Add dbvdd and
 ldo1-in supplies
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Derek Fang <derek.fang@realtek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221028205540.3197304-1-nfraprado@collabora.com>
 <20221028205540.3197304-3-nfraprado@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221028205540.3197304-3-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2022 16:55, Nícolas F. R. A. Prado wrote:
> The rt5682s codec has two additional power supply pins, DBVDD and
> LDO1_IN, that aren't currently described in the binding. Add them.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

