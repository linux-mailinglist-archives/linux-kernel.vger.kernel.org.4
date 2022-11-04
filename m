Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AD7619E38
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiKDRNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiKDRNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:13:40 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7938A31F8F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 10:13:37 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id e15so3621977qvo.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 10:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V9d/XoPw51yk/pI4pLP90kowufRsgkaEdGWppnSDAkE=;
        b=nl4idPg6vMNt0oI4SBlEgipBnS7ZrmdQOCvz6ALUQsrc6BtD+bhod/KyLM/Kn/yaFT
         Eph1kx+nWdV831rx21gd82njO+H3KEqvuuZpksRl50C6FOSwK13ypYmNzEBskoMGSzDN
         JPoVFdVF3QbsUHrWqWYNE5TouaK9k/mA4mGmEj3ab+JKZExUVYOlRV5nixFt9/s+XCeu
         /C97BPwdv8CAXzZBsvL+57TRksCg3zBJe4NsCAooCbem6tMyzBDespTm6OjfUuEiWESp
         G7oJqsoYXPhOrT1PcFEIml0PBvyu/6ERlh8j1dmHM1BH6JHKwcWvAXz/eulmJzGTBOCs
         74Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9d/XoPw51yk/pI4pLP90kowufRsgkaEdGWppnSDAkE=;
        b=FvDWnGhESsvTsJdw6egLbvKRDUmZ4u0IZXNIr6UyK6E4LVwVwue55lhdI47M7bNwl+
         O/noT9ETYFsjqRsA/5765wv9dEkJQeCv1TU8/P+rHAeAm6Zx0mbC2iPs7iJxmTyz3P9V
         XX0ZldEl+8YD+cMfXv5kUk15DgOyM+dXAOBf1Lj1QiKocUpVsdgZjuE6ZyWFSqTYdgUp
         xFPM4+avZOL3RKlhWMBu/3Q24R2574/igndMxn3taFf4hu/eduolQio25vaKuZZzpk2Y
         JoIkYxZRAYobHGDTL4e3jkLpXNeAnIL9joiQHk95xxR4rerHdskEqnOfi/wQXRhmRaHs
         Hb9w==
X-Gm-Message-State: ACrzQf3G//IPf36+fHmw82rIWl0akYMz1FLmx+xvMcX9kwRUEEWnnebt
        cL8b3FHbdiCLs9ysw14VUlapVg==
X-Google-Smtp-Source: AMsMyM5My89DYXgpJIfD94Z5eFq3R7YTf92Y24BjUOWx99Z2hVSwPVsG1a0ndzH4FuZ8R0AdzYVsCg==
X-Received: by 2002:ad4:5962:0:b0:4bb:6b78:c599 with SMTP id eq2-20020ad45962000000b004bb6b78c599mr32894711qvb.35.1667582016609;
        Fri, 04 Nov 2022 10:13:36 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id 145-20020a370b97000000b006eeb3165565sm3176724qkl.80.2022.11.04.10.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 10:13:35 -0700 (PDT)
Message-ID: <61945062-4261-ba3d-0d39-8c1cc46ad33b@linaro.org>
Date:   Fri, 4 Nov 2022 13:13:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] dt-bindings: net: nxp,sja1105: document spi-cpol/cpha
Content-Language: en-US
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221102185232.131168-1-krzysztof.kozlowski@linaro.org>
 <20221103233319.m2wq5o2w3ccvw5cu@skbuf>
 <698c3a72-f694-01ac-80ba-13bd40bb6534@linaro.org>
 <20221104020326.4l63prl7vxgi3od7@skbuf>
 <6056fe63-26f8-bbda-112a-5b7cf25570ad@linaro.org>
 <20221104165230.oquh3dzisai2dt7e@skbuf>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221104165230.oquh3dzisai2dt7e@skbuf>
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

On 04/11/2022 12:52, Vladimir Oltean wrote:
> On Fri, Nov 04, 2022 at 09:09:02AM -0400, Krzysztof Kozlowski wrote:
>>> I think that spi-cpha/spi-cpol belongs to spi-peripheral-props.yaml just
>>> as much as the others do.
>>>
>>> The distinction "device specific, not controller specific" is arbitrary
>>> to me. These are settings that the controller has to make in order to
>>> talk to that specific peripheral. Same as many others in that file.
>>
>> Not every fruit is an orange, but every orange is a fruit. You do not
>> put "color: orange" to schema for fruits. You put it to the schema for
>> oranges.
>>
>> IOW, CPHA/CPOL are not valid for most devices, so they cannot be in
>> spi-peripheral-props.yaml.
> 
> Ok, then this patch is not correct either. The "nxp,sja1105*" devices
> need to have only "spi-cpha", and the "nxp,sja1110*" devices need to
> have only "spi-cpol".

Sure, I'll add allOf:if:then based on your input.

Best regards,
Krzysztof

