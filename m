Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C5D64BD60
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 20:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236868AbiLMTiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 14:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbiLMThx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 14:37:53 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662C41028
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:37:51 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 1so6694944lfz.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OFiQbMNOsGQd5LAX2ELckt7+VtkQSjG6Cwl5KLgY7Rg=;
        b=haABn60VF5x+zcoyfJ3XcngjJiyg+ltAfdWxRZad67oS+0l23RECEn3YS/2cBzNXqa
         Hswfjps23oDANZXW3URB8SMHvyfisc8DVc/NfxVXfHpCNDFeyD/F6NWGGVverwsBaIhm
         BA5W6NtMx+ZOLLuH5Oet3C/lT9PQ0OiQH/W3Engqf7V2v6kHA221iYn8rpim3/XNlp2p
         FGPEORTAomzGQJmA4cWfek1Tfjd3uk0iupmM4rbO/8UNVa93eqlliIk8FDD/UrcEoCj6
         rbGgCiMW46cPH6g0iSiAX6QfRrF3Qjm6xeZY3QK1W9DzMrH7q6l/KB/3MQo9P7Vhl/zm
         1a2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OFiQbMNOsGQd5LAX2ELckt7+VtkQSjG6Cwl5KLgY7Rg=;
        b=f28HHz0iLFv29bngVF87m+HimS18U4TXCnLoQaHxGzP2j/6YO0XihxshD0RayYV6gO
         ks7zfK3joK/1IMIi1lMfbBDfaLBDiggtZJw6uAzU9h3rtOUH/9huZvWv1geeKgtdOV3N
         5zfHcooZo9LI6MbwXn6HTsK3jMdARSpUKwOD2Ul/JsAKOwQbu8/MS1NCaK4Iy5mLhChV
         SieQpscBbDUy3VUYlA9aEJUKg4g2vdA3lVrDle/rES4b3Kw7PUQdBCobDcIyYhkp3GAG
         jfzr3ekkG/J0CHpfTlxZfPkLzxAQAUGo0qxZ2PhvLBG1m//RL3Rl84YMWyxx8yK6HGNz
         EEHw==
X-Gm-Message-State: ANoB5pnlO2F8iT3WmdjxHN9w7jAowasdcoSRyTYleP7w9Qb6emAO3WEz
        ZqzuMe2FZ/x9USnUY7Bmvh53b+hH27IL/nUe
X-Google-Smtp-Source: AA0mqf5+PKjEzDAfMEN3yI8/ZKnHdyzYuEovCyfzo6fzuVX+czgS0nCul5VVmpxGK9FkDaXa1LZwhA==
X-Received: by 2002:a05:6512:1150:b0:4b5:7a91:70f5 with SMTP id m16-20020a056512115000b004b57a9170f5mr6808254lfg.63.1670960269794;
        Tue, 13 Dec 2022 11:37:49 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d28-20020a0565123d1c00b004a03fd4476esm482363lfv.287.2022.12.13.11.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 11:37:49 -0800 (PST)
Message-ID: <1e0d86ee-a832-642d-c835-df1f6505940e@linaro.org>
Date:   Tue, 13 Dec 2022 20:37:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 1/1] dt-bindings: mfd: x-powers,axp152: Document the
 AXP1530 variant
Content-Language: en-US
To:     Martin Botka <martin.botka@somainline.org>, martin.botka1@gmail.com
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Jan Trmal <jtrmal@gmail.com>, Tom <takuya@takuya.tech>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221213182743.3087889-1-martin.botka@somainline.org>
 <20221213182743.3087889-2-martin.botka@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221213182743.3087889-2-martin.botka@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2022 19:27, Martin Botka wrote:
> AXP1530 is a PMIC used on board BIQU CB1 SoM
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---
>  Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 1 +

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.

Best regards,
Krzysztof

