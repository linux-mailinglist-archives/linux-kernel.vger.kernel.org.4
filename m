Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D385B2FBC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiIIHZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiIIHZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:25:20 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AFD5142A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:25:19 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id y18so771499ljh.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 00:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=rttukWzjV+xvcl0ZdZLEMjvbrPV71XhE0mBEoNsIC0c=;
        b=Jxi/U+JbUv3v+EznlTNHFlFyGSGuivl713KuaNpo0EYtSonAZkVxGMDug+GbhlR8uc
         snrfxroNbjYlhnESeju+kc6rjCo+Yog10pZs6pyzXdiWnYo0AVK0unUR1B1UKheb5aRo
         qNfMmLglHF+PYeMYwodLsLirOEOYRnHWnnYj9kj959eoG3RFklnldruNtJ1T4bfOauPg
         dvrCrP2WUd6D2aHWgXHFA4ZLWnbe8rC2+mNfL6PzJ4zo0gPdp1JMWDXiXiin3IBcLWKy
         I5emIXWiaiMjFsF5IOrQkBYxzD4cPMjbwY/DlWwbfTtYg8dzA8zT6N5ISOBYHiJ0YxDl
         OmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rttukWzjV+xvcl0ZdZLEMjvbrPV71XhE0mBEoNsIC0c=;
        b=Ll78dUosvPKT20qOgC5Nwyp30KTXPWZP0OWf7N3tsv3lYkCjIrfJGfndzaeVV6ZC2/
         I5g6EiEJ8Za3Z0vPp7xChs6UF8qmnqNKu27oEo5vhxyVx2x8J7pq7ZKkA2P5ub9s2mpi
         cmN0pnS61sbQjJsdSvxA26UmNXEX/lY41mRP1lW5XCFeq2hh2JoInGKgX0RAxReZnCct
         xHHiqtEkKpA8I3F9JTWBjLLPYXv7ukaIntzX4rrUVTl8OJqx1MXWtOWhTy9N6Y1gM+X/
         HlDxKtvlZGwwh7Qu321hGfAfA8tXTPJwQvJZeUY4iqpYWWPgi+62XHcwKbl//hPGQZvI
         +j3g==
X-Gm-Message-State: ACgBeo29W/SU5yn0lPpfV7Gfj4VqIKu0An4s3jZ/3yfdXA0rMxgxxzuy
        wWsOuauMAsTodRs9b7V/1tbf2A==
X-Google-Smtp-Source: AA6agR487qrszdElZPRRzQQW9lkjNAr16pE+IjQUMK7QInOwDo6bp/ebol2FUs+Rq7JZuSI89hhdBw==
X-Received: by 2002:a2e:bd03:0:b0:261:8b4d:7c5c with SMTP id n3-20020a2ebd03000000b002618b4d7c5cmr3798042ljq.194.1662708317694;
        Fri, 09 Sep 2022 00:25:17 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id h14-20020ac25d6e000000b00496d254bbd9sm150794lft.271.2022.09.09.00.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 00:25:17 -0700 (PDT)
Message-ID: <66cf260e-b8b2-b3d1-7e8e-d1cfd99989b8@linaro.org>
Date:   Fri, 9 Sep 2022 09:25:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] dt-bindings: sound: ts3a227e: add control of debounce
 times
Content-Language: en-US
To:     Astrid Rost <astridr@axis.com>, Mark Brown <broonie@kernel.org>
Cc:     Astrid Rost <astrid.rost@axis.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel@axis.com,
        alsa-devel-mejlinglistan <alsa-devel@alsa-project.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220907135827.16209-1-astrid.rost@axis.com>
 <2b81d814-f47a-e548-83dc-b1e38857e8ce@linaro.org>
 <Yxn9o1MVMPnFO3PM@sirena.org.uk>
 <b42e7fe4-9e1b-fdda-44f2-aa87b06425c8@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b42e7fe4-9e1b-fdda-44f2-aa87b06425c8@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2022 09:16, Astrid Rost wrote:
> Hello,
> 
>  > Use standard property units "-ms".
> 
> I made it in exactly the same way as it is done for the "ti,micbias:".
> 
> - ti,micbias:   Intended MICBIAS voltage (datasheet section 9.6.7).
>        Select 0/1/2/3/4/5/6/7 to specify MICBIAS voltage
>        2.1V/2.2V/2.3V/2.4V/2.5V/2.6V/2.7V/2.8V
>        Default value is "1" (2.2V).

That's not correct way. Logical units should be encoded in logical
units, e.g. microvolt. This makes the binding re-usable, extendable
(imagine new device from the family where these values map to something
else!) and also the easiest to read.

> ?> Anyway new properties cannot be accepted. This has to be converted to DT
> ?> schema (YAML).
> 
>  > Doing a whole binding conversion feels like a bit of a steep requirement
>  > when people are just adding a simple property, it's a lot of stop energy
>  > to figure out the tooling, do the conversion and deal with all the
>  > bikeshedding that the tools don't catch.  It's definitely nice if people
>  > want to look at that, for more complex binding changes it gets more
>  > reasonable but for trivial properties it's disproportionate.
> 
> Thanks, I am not really sure how yaml works. But I can have a look.

Documentation/devicetree/bindings/writing-schema.rst
(and example-schema in the same place)

Best regards,
Krzysztof
