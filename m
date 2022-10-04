Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F01C5F460B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJDO5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJDO5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:57:16 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51A426AE8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 07:57:14 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id k19so2051906lji.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 07:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=1yXZ0CWIkY+Be5TJwvLWjyqsQMykcG2932nB5Fmia7c=;
        b=ae0FQRtj6b3RZ5fEgfrvbdBQsuvQkHIpByzRfAn3f7HQZlvHSX8Hr3nqho94miQOvL
         nh1baKq7HxXHcwQkavOp818eo3VfVBgP/zLc9vuVzbETe/98yZQeavRD6AFT6vzzYgdO
         cTZSagpwrj2wgV7N1wLxgd8fCma3Y9l6yVTI1oDwbcDly6626PQxTUSzP1MwPn27Yfo9
         vLXUHDvQVQr6/eh8TeTVHxXaaag42kkMsTIpeYU6xYoGAP/Puo0i8ppox8w7krfrVgVp
         sO6Dm1TQfWuMCcfNtgrZz1NS1E/BmmC1JYSaXZKWUCHkOixpSqQxTCsdizOINpvg/MEY
         Zklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1yXZ0CWIkY+Be5TJwvLWjyqsQMykcG2932nB5Fmia7c=;
        b=rqVkGJV9wHZEneHMx1B8AWKAIISEtgTtnKp2CSKwAKP442DmyVB4Rvc2tz99P4kWSa
         KOBhNqwlv6Irx4NN93D65XdhGd9XHT7iK0Q3X8K1h4lkZEZyDcgFaXoPkpfvyQlm45GE
         aB7N3dCcxX3Iwtm5XBx3fcBrQ8bWskITUwKPTQ5h6vT7OrXpwDVw3oVRfnm6np/tMuJ7
         491XHdQmxXgeHqizVWGwz9M+PEwx31TUJplemwWX/4HFUPBpMlShA0nengxa/MM1hBlY
         ZDEs5AxwQAe9+VY7ZQsTJmyrcFsoGjK8envGZjODwss1UtOT8Fn4OFDhMs9w7bOfMld6
         KHQA==
X-Gm-Message-State: ACrzQf2ZCePb1aWQoJdDXn9gs+TQe2ou1cInBW3tAB29vZm9F7uoDz3w
        fV4mJ6uXAgvxzFAIlVeLsgG9aA==
X-Google-Smtp-Source: AMsMyM4M0ZuBIqfAgIooUuidg91Pc4bHu8QL/AB+nfSqAtrM1bWqhJoApIv7Xwy5rdRCSW2vB62/eQ==
X-Received: by 2002:a2e:bba2:0:b0:26b:e4ba:851d with SMTP id y34-20020a2ebba2000000b0026be4ba851dmr8725853lje.45.1664895433020;
        Tue, 04 Oct 2022 07:57:13 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v21-20020a05651203b500b0049d0a98f73csm1120402lfp.154.2022.10.04.07.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 07:57:12 -0700 (PDT)
Message-ID: <1dcdc4e3-520c-3f6d-9994-9eedc2211c6d@linaro.org>
Date:   Tue, 4 Oct 2022 16:57:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] dt-bindings: display: panel: use
 spi-peripheral-props.yaml
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Markuss Broks <markuss.broks@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Dillon Min <dillon.minfei@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221004120907.72767-1-krzysztof.kozlowski@linaro.org>
 <YzwvDEKAzbqjSYjT@pendragon.ideasonboard.com>
 <64a355f2-e9a1-dcca-cb86-48805acae8d5@linaro.org>
 <YzwyT28hf7daYqa1@pendragon.ideasonboard.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YzwyT28hf7daYqa1@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2022 15:17, Laurent Pinchart wrote:
> Hi Krzysztof,
> 
> On Tue, Oct 04, 2022 at 03:10:29PM +0200, Krzysztof Kozlowski wrote:
>> On 04/10/2022 15:03, Laurent Pinchart wrote:
>>> On Tue, Oct 04, 2022 at 02:09:07PM +0200, Krzysztof Kozlowski wrote:
>>>> For devices connectable by SPI bus (e.g. already using
>>>> "spi-max-frequency" property), reference the "spi-peripheral-props.yaml"
>>>> schema to allow using all SPI device properties, even these which device
>>>> bindings author did not tried yet.
>>>
>>> Isn't this done implicitly by spi-controller.yaml ? SPI devices that are
>>> children of an SPI controller should match the patternProperties
>>> "^.*@[0-9a-f]+$" in that file, which has a $ref: spi-peripheral-props.yaml.
>>> Is there something I'm missing ?
>>
>> You are correct about one side of this - SPI controller bindings.
>> However these schemas here have clear: additional/unevaluatedProperties:
>> false, thus when they find DTS like:
>> panel@xxx {
>>   compatible = "one of these spi panels";
>>   ...
>>   spi-cs-high;
>>   spi-rx-delay-us = <50>;
>>   ... and some more from specific controllers
>> }
>>
>> you will get errors, because the panel schema does not allow them.
>>
>> The bindings were done (some time ago) in such way, that they require
>> that both SPI controller and SPI device reference spi-props.
> 
> You're absolutely right that additionalProperties needs to be replaced
> by unevaluatedProperties. Can the additions of $ref be dropped, or is
> that needed too ?

I just wrote above  - you need to reference the spi-props. Otherwise all
the SPI-related properties will be unknown/unevaluated.

Best regards,
Krzysztof

