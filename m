Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA0F60B4A6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiJXR7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbiJXR6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:58:38 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1252DCAE9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:38:56 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id g11so5944822qts.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lGJrVQPc2u8BmXJHhbTLdghe4GhptaKKpCGXInaxYBc=;
        b=mN9JEcfA/k4mMvL/hZaY6pEx5NHRiDoUSSXyXc+7ktUksysoXmwb7A6j3c0J4sBPi4
         royZIXe/7FbOVh+Zgynooe8CQ6KGcnTMryluWGp/CC7+Jo2d71hU3E9h0GVnOqB/73pM
         01WzsLuqJqxdiWhX4TwvucbzFKYn/XKnzc1zj5xd5yNc+6bfcutHdo/ecPMD3+lnY9kE
         ntJp9Unx/qmeWLKaVGGdjj5fqj21OBcVJTOmLNpHZbzvmC+++I2G8TVFA6fA8YOhKjHO
         vJHvmuMw/P/QZeMQ9cwuHJlk4u26ZZ03c0wwxvS4tI5T6mauuDgA2sEB+KXEOybpwQ3r
         71Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lGJrVQPc2u8BmXJHhbTLdghe4GhptaKKpCGXInaxYBc=;
        b=GiE5zTdC+bgdbTjYkT5eDRJKx0SgTBnRnuA5DASzetDK7wb//yTV9drDtPD179+WdI
         1ayC/cuvaPQ/yM7AXWd4u2xIa8jYuuyTqRSIGOUTUoXHd90vyzzxhcPbdb6u7PCUvTUZ
         c0t4G5AgCMJh4i4tea6TNGRgEqjaAbJbXAbNcAoMboi/TTc7r4iYsVt7IwscTDQbb8P9
         DasvNCDsO/sNlHTR4js3l8PyVr/k7k2s7esCEdEp8CcJ1ug7YcbEyCNyxkDbZMUVvSbG
         +n2Gn0xyYPMmfH4sSNyKOYY7I/rDHhwZGbsSfEFZXzckvtvjn0prHJqXE1JxYZrprfGL
         sCjQ==
X-Gm-Message-State: ACrzQf0jM2C4hBeX4/hAvPKUVkA5NnhEdSGGnujG0s7RDAD/7d2TQ8G2
        7YpVX2WAbw9K1kjpXSSp42rhbAj1VjZjMQ==
X-Google-Smtp-Source: AMsMyM6nNKEGA5WXpAqyAoIBFJfkWQ0wIqWX2Rnnj9/gvhCBUBxmQ8Wb0wGieNxJDAU17FPd6rMxeQ==
X-Received: by 2002:a05:620a:858:b0:6ea:8a17:19fd with SMTP id u24-20020a05620a085800b006ea8a1719fdmr23874112qku.397.1666628955532;
        Mon, 24 Oct 2022 09:29:15 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id h7-20020a05620a284700b006ea7f9d8644sm201040qkp.96.2022.10.24.09.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 09:29:14 -0700 (PDT)
Message-ID: <1f56ff1d-4b59-97f9-60d0-12197100ae4a@linaro.org>
Date:   Mon, 24 Oct 2022 12:29:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 3/3] ASoC: dt-bindings: rt5682: Add AVDD, MICVDD and VBAT
 supplies
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221021190908.1502026-1-nfraprado@collabora.com>
 <20221021190908.1502026-4-nfraprado@collabora.com>
 <f7007c75-9c99-902d-170f-383b7347922c@linaro.org>
 <20221024160029.cfpyp2cptwig27jd@notapiano>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221024160029.cfpyp2cptwig27jd@notapiano>
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

On 24/10/2022 12:00, Nícolas F. R. A. Prado wrote:
> On Sat, Oct 22, 2022 at 12:41:01PM -0400, Krzysztof Kozlowski wrote:
>> On 21/10/2022 15:09, Nícolas F. R. A. Prado wrote:
>>> The rt5682 codec can have three supplies: AVDD, MICVDD and VBAT. Add
>>> properties for them.
>>>
>>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>> ---
>>>
>>>  Documentation/devicetree/bindings/sound/rt5682.txt | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/rt5682.txt b/Documentation/devicetree/bindings/sound/rt5682.txt
>>> index c5f2b8febcee..5ccf4eaf12a9 100644
>>> --- a/Documentation/devicetree/bindings/sound/rt5682.txt
>>> +++ b/Documentation/devicetree/bindings/sound/rt5682.txt
>>> @@ -48,6 +48,12 @@ Optional properties:
>>>  
>>>  - #sound-dai-cells: Should be set to '<0>'.
>>>  
>>> +- AVDD-supply: phandle to the regulator supplying AVDD
>>> +
>>> +- MICVDD-supply: phandle to the regulator supplying MICVDD
>>> +
>>> +- VBAT-supply: phandle to the regulator supplying VBAT
>>
>> Lowercase.
> 
> Actually looks like there's already a DT using these properties before the
> binding was added:
> 
> arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> 
> In this case should we keep them uppercase for compatibility or carry on with
> the name changes and also update the DT? (the driver also uses uppercase names)

Driver seems to use them as well, then uppercase is fine. But you need
to describe it in commit msg, that you document existing usage, not
adding new properties.

Best regards,
Krzysztof

