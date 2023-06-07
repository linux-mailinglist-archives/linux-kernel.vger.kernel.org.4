Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7D972599B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbjFGJJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239593AbjFGJJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:09:08 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EC22110
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 02:08:28 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5147f5efeb5so1153739a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 02:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686128907; x=1688720907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f3HXgHwKsy4N8Tpc/elaxbaWilZIps/qalSkKTcZzsY=;
        b=aCFzWsjbotx8Jk1NBq55ns9s0MmDl9b2v4bYD4xHJkszGTRexRhviAIgbATMgEVgD7
         4a1SFUElAKadevTwEppruLY3b911melhqc/cQsRgL+Ol91FE3dFSu439SUYUk7OR1oc6
         3wZUwAHGXHhcIkRjoRMRsABX7UleO5CSR+x8SKjErK9XrRbuewQUE5NdlUBtnfe5Q/x3
         KWml/YgvGyodsBbQjwnHnxl1jplPjZuv73WBn8iZm5XefwBNNz9aaxdfliq0qyTEDCu3
         NzP7D3CeF5d9o3so+m4xPhAMPqD7dKalISMSJbMUaIBk7eZhz63+VefoT47u0bE2xS69
         uCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686128907; x=1688720907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f3HXgHwKsy4N8Tpc/elaxbaWilZIps/qalSkKTcZzsY=;
        b=aRcKgEgD/y8qrrE8/0t3/s8wJFOaIiL2bZgnIHtjQYWt1OFx5DZ3EcJasMgGPS6wwd
         WDKdgBI2QFPGb1tUwN5k4X2hg9MY1IfMRb8qppTXMSNmV+8Mgx2UxB9g733mhpf2L7Z0
         7zdWs0T1vHTZIlZqYYC9Oy2D5EjjJ6ihkGTCK3kjfozhMbWA77iaWAoqlSXB0CK5BZbu
         sEHHVxYkl+jrB1FDzdmYjXjDh9xMn9VXLDtqTdx8p7DbIR4GYjkovJh0O0DA0h7HZRkg
         sqTGQgz0AjRD6z21Cl3fTQSOEcdDO1WwL/aOICMxiiqKnYq27QoBH2BYCQG1iJ16Gnlp
         xUIA==
X-Gm-Message-State: AC+VfDydc/YMzqJoRieu6OqP8nIC0eQjumGUwl8CAVKjTEN0I2eOFT8a
        xiKZn/O5OxIHbzbgz2P93Xhfyg==
X-Google-Smtp-Source: ACHHUZ7ZyCS7a5sq4Nvpos2aBqlX93n3jTFDSFT1X51+drYZhfsW7cljvrgMH3xlBTAEOEDdL2/cIw==
X-Received: by 2002:a17:907:a42c:b0:974:1c90:2205 with SMTP id sg44-20020a170907a42c00b009741c902205mr5228122ejc.13.1686128907425;
        Wed, 07 Jun 2023 02:08:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id u21-20020aa7d995000000b00514a3c04646sm5990934eds.73.2023.06.07.02.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 02:08:27 -0700 (PDT)
Message-ID: <2ca6e619-1d57-8fff-6176-9ee890e0d167@linaro.org>
Date:   Wed, 7 Jun 2023 11:08:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1] dt-bindings: nand: meson: Fix 'nand-rb' property
Content-Language: en-US
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        oxffffaa@gmail.com, kernel@sberdevices.ru,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230606193507.35024-1-AVKrasnov@sberdevices.ru>
 <20230607095802.3adcd4f9@xps-13>
 <166bdc27-f77c-9076-f866-180cfa5bff76@sberdevices.ru>
 <08da4e86-433a-7d2e-25ff-ffa24221abdf@linaro.org>
 <835a3587-1e0f-64d7-1d1a-b639ae8b7307@sberdevices.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <835a3587-1e0f-64d7-1d1a-b639ae8b7307@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 10:57, Arseniy Krasnov wrote:
> 
> 
> On 07.06.2023 11:53, Krzysztof Kozlowski wrote:
>> On 07/06/2023 10:40, Arseniy Krasnov wrote:
>>> Hello Miquel, 
>>>
>>> On 07.06.2023 10:58, Miquel Raynal wrote:
>>>
>>>> Hi Arseniy,
>>>>
>>>> AVKrasnov@sberdevices.ru wrote on Tue, 6 Jun 2023 22:35:07 +0300:
>>>>
>>>>> Add description of 'nand-rb' property. Use "Fixes" because this property
>>>>> must be supported since the beginning. For this controller 'nand-rb' is
>>>>> stored in the controller node (not in chip), because it has only single
>>>>> r/b wire for all chips.
>>>>
>>>> Sorry if I mislead you in the first place, but you could definitely
>>>> have two chips and only one with RB wired. It needs to be defined in
>>>> the chips.
>>>
>>> Ok, so to clarify: is it ok, that in bindings this property will be placed in the
>>> chip, but in driver, i'm trying to read it from the controller node (thus  in
>>> dts file it will be also in controller node)?
>>
>> No, because how would your DTS pass validation? I understand you did not
>> test the bindings, but this will improve, right?
> 
> Ok, i'll follow DTS layout in the driver, "test the bindings" You mean "make dt_binding_check"?

Yes. They were sent without testing.

But please also test your DTS with dtbs_check.


Best regards,
Krzysztof

