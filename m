Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573976E80D1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 20:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjDSSEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 14:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjDSSEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 14:04:14 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0735B92
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 11:04:13 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id kt6so629264ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 11:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681927452; x=1684519452;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mhOMRuZ4RYtVXwhrIpThNbtd7ozYp3pbSIMKq7KmV5Q=;
        b=R8fdSS20ksg1pynC9t1vSq0+5JD/pvO/96eT3IfrzjVuvnhalxXhh/yJQtfTfr3DzJ
         ryAwWLtABjI87c0z9zmAbHW3rsytORLAJOsrCtYDNe9zLQHYDtTqRw4vRgLOG6ulOlzl
         Mu6idsPej6poqU9sASR0dhAhHbbOjA8Omr6e7wCcLoICA/HqFeeMIqw3/ZJZS8htjRkT
         MXxAHk0a5hNRtOSxJAHAgYoawBVai6Kkx4swhTOEiJ8nV+Ksh5Z49NyxiKjLKsaiJdNw
         4+Iflj7FUBz1QDVxee+PQx9qC6OGbD5maWB27JYaMorrMx3GxO7YwcVeDXUZ8uSkEHqH
         J/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681927452; x=1684519452;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mhOMRuZ4RYtVXwhrIpThNbtd7ozYp3pbSIMKq7KmV5Q=;
        b=EjZ4EHm/kyXEuIr7VoP/AYgO7G+E377hjAjGZ7N+hHV3cLeX5ZMKvwZEWoCTCd6h5Q
         x09p7fWRHRrRYLOG+OoBmaEsW0pgFAfmll1lCQsdM0xvaGcTv3OK8iecIibIPiVeJjhh
         u+eca3BrbaltPPxGjQ2ez2mlLN+rWLkEXRg3SBl5fO4znURXxKWmkgIsJ70WQqUwrEoI
         PL2EpiYYnBcL7e4zup0ZSXPDImEg8wq/oe3uFhddhNVswhCI9twQXXhTpLMQ9SZyOq2y
         HkyuJ8dmMLMDGWZBvvzlcDHyXa0SptobcTMw+kUY5eZJnj5/bDJfSuSGTQgOljKuL/kp
         T7wg==
X-Gm-Message-State: AAQBX9frMRBhtjCNCUztYaPuwJU8qyeTT9PmE0Hk+zZZoBnetcMRM30C
        0eiQFHHbNEoeGsgIjnu1BP2NJQ==
X-Google-Smtp-Source: AKy350b8y+4R4SLiYhgrlKJuX9NH3AJCLiUJaiXvpzYv0lnZA9rcV8nlPVKRWSkRvRHiA5/ZxfOn8A==
X-Received: by 2002:a17:907:1245:b0:94e:6294:9d23 with SMTP id wc5-20020a170907124500b0094e62949d23mr12770897ejb.26.1681927451762;
        Wed, 19 Apr 2023 11:04:11 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:b7d8:d88b:1fac:c802? ([2a02:810d:15c0:828:b7d8:d88b:1fac:c802])
        by smtp.gmail.com with ESMTPSA id hs4-20020a1709073e8400b0094ed3abc937sm8496477ejc.82.2023.04.19.11.04.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 11:04:11 -0700 (PDT)
Message-ID: <c2db08eb-a31d-cded-cb20-c358b77d804c@linaro.org>
Date:   Wed, 19 Apr 2023 20:04:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 4/5] arm64: dts: ti: k3-j784s4-main: Add DSS and
 DP-bridge node
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>, nm@ti.com, vigneshr@ti.com,
        afd@ti.com
Cc:     s-vadapalli@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, a-bhatia1@ti.com
References: <20230419061710.290068-1-j-choudhary@ti.com>
 <20230419061710.290068-5-j-choudhary@ti.com>
 <83c8bce1-f4e2-899e-46a9-0ba9da702572@linaro.org>
 <bc58b9cc-f1a1-9c60-341c-9a00777e7142@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <bc58b9cc-f1a1-9c60-341c-9a00777e7142@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 12:35, Jayesh Choudhary wrote:
>>> +		reg-names = "common_m", "common_s0",
>>> +			"common_s1", "common_s2",
>>> +			"vidl1", "vidl2","vid1","vid2",
>>> +			"ovr1", "ovr2", "ovr3", "ovr4",
>>> +			"vp1", "vp2", "vp3", "vp4",
>>> +			"wb";
>>> +
>>> +		clocks =	<&k3_clks 218 0>,
>>
>> Broken indentation.
> 
> Indentation at both places are similar to j721e dss node.
> Changes are needed in both?

There is no DTS coding style which uses indentation before or after '='.
Just because some DTS are written wrong, should not encourage you to do
the same...

I am commenting only on this patch - it is not correct. What is wrong in
other files should be fixed in other places, not relevant to this patch.

Best regards,
Krzysztof

