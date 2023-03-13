Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1774B6B6F94
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 07:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCMGon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 02:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjCMGom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 02:44:42 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406E234002
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 23:44:40 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id ek18so13213735edb.6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 23:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678689879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AQbMIvuYRw2k1RIiNkeO4I7jGAvRPvwf6HrYCDn6EqE=;
        b=N3VsugGVx7u15+HcGPueog998EhT/wYdrZEZvKkZ3hdu8Pt90aVGZdkT5j33Nvy8xs
         hBIpMZfS0Tfd2P5tZ9q0Q2ZU2VmhYga5Vuz0pS8TAMJavWzNOoOSykHfjl5ywDe0TIIx
         58RetBNGVqhlvWy4AOPM7PhU9IB7Q3y8CLpyBPuxJZW6LimANI0HjoghLf5z59CYW6rv
         gGe+ke/7YbjR7OCZOtWmgZkfd5qURtQa6OAxVgYiajf5RhAVuIAzWetI3bxUyjw71sg7
         om7H6yqj2YPEsxHeq4hyhqD5h4rVQLQYaYlMfU5AIes6JOi7LG90bhOs4067sqqmx+qo
         6MEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678689879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AQbMIvuYRw2k1RIiNkeO4I7jGAvRPvwf6HrYCDn6EqE=;
        b=W3ModAuJIWuvx3Ss0AIBpWjPvzDscYwKIWQX7sjPuwTyTgznzSgWlaAHnCXPWx/KxB
         U6NEW8AC+fkgDjplIFPaE53oyHfJS1mcn8TQtGFtJ9ABD+X+geWl78d5skdisN/R8Oog
         1rgRax4Wr3Hrn5WI4p810eojLBkqvyy9e5csWN7IgTZ2qEpLTAcRPi8yqaLxgNV5pYg2
         BZvokCP6vVatAIz/nLT+/488FBFbkgOrKka1ACi2hE6kgBpqoxgeMx7BPyqBokyYSbO4
         76M8JKhwY81vUIIsOD0Z3DUox/xEV35qAASQIEAKi089RlC6gEXisOX85+0rJkJZRXkq
         ARxQ==
X-Gm-Message-State: AO0yUKVP9bx6/x10GAnnkkaRScOVAJIAU8/KyLTQQ1gmvDh9QqiL5XyI
        tdi3z7AEW45/GsP5tOfde4A5qw==
X-Google-Smtp-Source: AK7set/keJih8O/WxmIJ8nCvWOTD5UO/SgBGnepYzgvNBKU/BNqqQHqef1u5/b/TIpYbKeLm1e5k3w==
X-Received: by 2002:a17:906:30d3:b0:8b1:3d04:c2da with SMTP id b19-20020a17090630d300b008b13d04c2damr36058580ejb.45.1678689878761;
        Sun, 12 Mar 2023 23:44:38 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:f052:f15:3f90:fcb3? ([2a02:810d:15c0:828:f052:f15:3f90:fcb3])
        by smtp.gmail.com with ESMTPSA id i11-20020a170906090b00b008edc39530fbsm3017685ejd.219.2023.03.12.23.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 23:44:38 -0700 (PDT)
Message-ID: <27a92399-e99b-018c-16a3-cbfb8a303b43@linaro.org>
Date:   Mon, 13 Mar 2023 07:44:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [Patch v6] dt-bindings: media: s5p-mfc: convert bindings to
 json-schema
Content-Language: en-US
To:     Aakarsh Jain <aakarsh.jain@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        stanimir.varbanov@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, andi@etezian.org,
        alim.akhtar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com
References: <CGME20230301035153epcas5p40f576188a9a69835c1050135219a3720@epcas5p4.samsung.com>
 <20230301035144.8645-1-aakarsh.jain@samsung.com>
 <8b5bea40-6f7b-1d00-ac23-83a28c7dacbc@linaro.org>
 <046b01d94d1a$418146a0$c483d3e0$@samsung.com>
 <9b93849d-d4a4-67ba-e8a0-ee6c7209bd65@linaro.org>
 <000701d95257$e97ebd50$bc7c37f0$@samsung.com>
 <81e78cf6-b8b3-0cab-d190-aa22abbc5c2d@linaro.org>
 <001901d95263$eac4b460$c04e1d20$@samsung.com>
 <49106943-450a-11c0-99ce-159d40471bf2@linaro.org>
 <010601d9555f$bde202a0$39a607e0$@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <010601d9555f$bde202a0$39a607e0$@samsung.com>
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

On 13/03/2023 04:56, Aakarsh Jain wrote:

> Also, "samsung,mfc-v7" compatible is used for both SOCs Exynos 5420 & Exynos 3250.
> And for both SOCs, clock and IOMMUs properties are different. So in order to differentiate that, will keep it in this way.
>   - if:
>       properties:
>         compatible:
>           contains:
>             enum:
>               - samsung,mfc-v7
>     then:
>       properties:
>         clocks:
>           minItems: 1
>           maxItems: 2
>         iommus:
>           minItems: 1
>           maxItems: 2
> 
> I hope that will be fine?

Yes. We should use as some point SoC specific compatibles everywhere,
but it can be added later.

Best regards,
Krzysztof

