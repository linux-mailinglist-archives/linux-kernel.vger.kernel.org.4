Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7ECD63770F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiKXLC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiKXLCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:02:50 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FA5186D5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:02:43 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id p8so1987055lfu.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nu6pjkXIBFfjqNqFnOUYgw7nMcsD0pE0OGpEOCK7UF8=;
        b=g18UXMLu+HaZr5Vma7hCKLNfw8vE5DtyJQQ/h0wELeQztKUsZinIOYD0Emd571Ttaz
         G8gKTl4Gjfv1qddAZVO3V5bexes47auyNSgRTXKOFA86NLV4OWBnG9IySg8lw/SBqNR2
         6PnX/oZdvF05r2urpn9cDwRFY4lTHRC9NUOphPu+GJomqjVeCR67oNZPdO6U6XYaFViv
         cSLl3JDzwhR0gYG+PpVdE8ZNwH+pw2fU52yOyyPiANnlSXP5ypDsEtRIcm6t9u4lM4mm
         2qK/nbsG3QfaEEb8Qrp6NUkLU/PLhyZ5sjNo2AWS7bXDpvtI76RbrJIFzcVc0Y9wceiN
         bngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nu6pjkXIBFfjqNqFnOUYgw7nMcsD0pE0OGpEOCK7UF8=;
        b=z5755fAIhv3FjoZncSzAJAzMWUHgcOrH5T9bKxrLpqoZUeBuLSLsw39gRRbIqGzBf7
         B+91lSS2yTMWD60mhDcz34Cn6HPinT1LavBEUxlvwOjnoDAiIxtO4fBguUUpeYhyzrUV
         l5y//Yunb3EEXB6gk44Kh42HqiRVlOYoHe4nlpYEcIlRehOYLWKaZSRhbjqZ7I3+k3B3
         1hRVsILDI0HuTyf1DUMJI70g5EWnSwdOVpI9zC0wzcG41B9cWUKheYKt6As9MVOfuMVM
         16D6krH46pUFZSgMpj9UrJTgl9LJXOPO8dGO0ofZpVeZSBPAS/+Qmy0u0LLDa3b09How
         XuEg==
X-Gm-Message-State: ANoB5pl4h/Gbc5i5pwd3I6o79j327k9vgtLcsSn8Dne4ihn6uho6elPL
        B6h6WGEeZhjc/1ZRjUbq2oTbrA==
X-Google-Smtp-Source: AA0mqf467/nJeQnupvv/69oKsa3gmbQrSZGWwkEVDwG8CorBpsO5lNOGph3XKFrZdmNiiKGZ18jCjg==
X-Received: by 2002:a19:7b0f:0:b0:4a2:3bed:2008 with SMTP id w15-20020a197b0f000000b004a23bed2008mr11520699lfc.88.1669287761901;
        Thu, 24 Nov 2022 03:02:41 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f18-20020a05651c161200b00278e9c0d3a2sm73435ljq.33.2022.11.24.03.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 03:02:41 -0800 (PST)
Message-ID: <69540766-4fe8-cc21-f2bc-4ad04643e4b6@linaro.org>
Date:   Thu, 24 Nov 2022 12:02:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] MAINTAINERS: Update email of Tudor Ambarus
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     herbert@gondor.apana.org.au, krzysztof.kozlowski+dt@linaro.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Mark Brown <broonie@kernel.org>, qyousef@layalina.io,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>, tkhai@ya.ru,
        quic_abhinavk@quicinc.com, vasily.averin@linux.dev,
        baolin.wang@linux.alibaba.com, colin.i.king@gmail.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        pratyush@kernel.org, Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
References: <20221122125244.175295-1-tudor.ambarus@microchip.com>
 <024e0a68-bb79-4e2e-84f8-f44afb759cdd@app.fastmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <024e0a68-bb79-4e2e-84f8-f44afb759cdd@app.fastmail.com>
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

On 22/11/2022 14:15, Arnd Bergmann wrote:
> On Tue, Nov 22, 2022, at 13:52, Tudor Ambarus wrote:
>> My professional email will change and the microchip one will bounce after
>> mid-november of 2022.
>>
>> Update the MAINTAINERS file, the YAML bindings, MODULE_AUTHOR entries and
>> author mentions, and add an entry in the .mailmap file.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> I can take this through the fixes branch of the SoC tree if that
> works for everyone. Alternatively, I can take only the MAINTAINERS
> and .mailmap bits and expect the other changes to get merged
> by the devicetree and crypto maintainers for 6.2.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

