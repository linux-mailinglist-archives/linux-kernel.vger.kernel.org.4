Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CC96A94D8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjCCKIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjCCKIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:08:12 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE29F746
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 02:08:10 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id o15so7976938edr.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 02:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677838089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ESrclwBCHM69+hLsPL2pqUpQkFKX4EOhHF1Eje8eSI=;
        b=PGRkUs4K5kO9por33thnuXgcO+reDiGastPA2Dp5H/pHJ06Egemrwng4RG4q0GnnzC
         9Ex9M2x04CFgb8fHQm/eYOMkDggcVOvks0DCBoqZxFEBpU87cNN9RGaib7xlccFm7eIm
         9b5/y2MZLL4BKuruSQcTHTfZ/AC8tbuc8YNgENUPD/Q7tdGasN+Ni1KDPnsI2CddUEkN
         Ydj+2QcmGKqeXaXuCtak6YZao2mH0YO19qTpy0ZZfQv084E+271q+PSsPlB777FL1w3S
         47nKilU+OnouEvxEFHNThXBAJetTXiagDNBGC1RWHsMGRrrLqmZJcnn3UtSLh9vLd7Sp
         AfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677838089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ESrclwBCHM69+hLsPL2pqUpQkFKX4EOhHF1Eje8eSI=;
        b=cRXccvkTABvw1UPicnexQbNiowx4UFZx90apE+wqekZvnnfTENyc9TgUwvPDyiMLHF
         n9zd06eYv4HEhAp2CZlPg7r1Qw9BWIJT+2Did6Lzr4QCsAE44+IN6HHB2OjcO1/d7M8T
         eotdew/aV5YJQg3J4DAGhMU6ud4s0pVbarc3xuJtgscKV6ugnEqAyvLyymB6FqN3w30C
         EB8EIon3w4NCCtX2IEnpGtCovHY6nmcdoX3akjlVP+EoinZFYr28d1KjcXSJ/5rzb1ZI
         sBw8I7ES34OMu8nuG1RunzpITNKP4v0G3Ow1oAxZZhRK1Ez5SzxCUhMQHld8JWY/lfSv
         D60Q==
X-Gm-Message-State: AO0yUKVcTvGNJuaXWRTrNbFE8peEnydClelyrLX5VQe4BQCPMXUacWjK
        7BM+ts2h3ateHNI++5PH7p4KQQ==
X-Google-Smtp-Source: AK7set85Koytwyp8k9BMsQvzSBYoh1IytCTgthCWFMdVefdMvJrjVRop+xFCZwSfBoyFqtTTrxnyXw==
X-Received: by 2002:a17:906:1450:b0:8af:ef00:b853 with SMTP id q16-20020a170906145000b008afef00b853mr1092169ejc.73.1677838089296;
        Fri, 03 Mar 2023 02:08:09 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id d25-20020a1709064c5900b008b17de96f00sm768389ejw.151.2023.03.03.02.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 02:08:08 -0800 (PST)
Message-ID: <6781aacb-a44b-bff7-214a-3b3b5cee427b@linaro.org>
Date:   Fri, 3 Mar 2023 11:08:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/3] ASoC: dt-bindings: maxim,max9867: convert txt
 bindings to yaml
Content-Language: en-US
To:     richard.leitner@linux.dev, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ladislav Michl <ladis@linux-mips.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
Cc:     Benjamin Bara <bbara93@gmail.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Leitner <richard.leitner@skidata.com>
References: <20230302-max9867-v2-0-fd2036d5e825@skidata.com>
 <20230302-max9867-v2-1-fd2036d5e825@skidata.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230302-max9867-v2-1-fd2036d5e825@skidata.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2023 11:04, richard.leitner@linux.dev wrote:
> From: Richard Leitner <richard.leitner@skidata.com>
> 
> Convert from max9867.txt to maxim,max9867.yaml and add missing
> '#sound-dai-cells' property.
> 
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> ---
>  .../devicetree/bindings/sound/max9867.txt          | 17 -------
>  .../devicetree/bindings/sound/maxim,max9867.yaml   | 55 ++++++++++++++++++++++
>  2 files changed, 55 insertions(+), 17 deletions(-)
> 

Looks ok. Need to wait for Rob's bot to check for issues.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

