Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202BB6C8D27
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 12:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjCYLBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 07:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCYLBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 07:01:51 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3198A75
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 04:01:50 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w9so17375992edc.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 04:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679742109;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zafUbUEAV6rjedbLPFbfMgyY+HDLY0SQ0UIeszhwa4Y=;
        b=luQ+jJETbggWlEZ4mKxSwssRXNVCRBhmGBdRXYfwA8AVwFvxv/0GHEQlxcSYJMCnhK
         lnlzGrQrkBIDr69Ea1z3xGRAq6SKGFTe/kJIpzkeDBfzoOwGd2P5TfM8rNAsZkTxilKw
         Ml3E1+Io9DrIPJ8K5EOhA5NEohODS5gxhgssK1CuUFQxv6NREZYdcpHsnGkD4OlHHF/c
         lTch3pnAcVH1PPQ0WPSnBUZwvdsohMUk7HUFW5zINr25Bd7wxgchnyStHWgBt55HwjmW
         nPzWt37I7CAvsKOsslrq91E8tF0cKPvgak3lzIhjGP+uSyGyqeERnK71ShTfZg3ZwZda
         EBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679742109;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zafUbUEAV6rjedbLPFbfMgyY+HDLY0SQ0UIeszhwa4Y=;
        b=py/egCE6VnQ/1ZGgCoT0nx4l/SXaUMGs4Qg8uuKOHSG8gHhmaiFDU04/4hYBPbovYO
         np0320VSrFOH5jedlBUWx9FGhTjTzB+BpniYlyCNsT6KEYmH9k6IdF0zmqC96yb+Jh6p
         QZOl556jc0tMnIupR2e+Mh0OFabB6YUXQARutFWQIXadinHk2yCTTvrv9pvboy86cvIV
         3ADz2sBBAPdUTkDTliBlNOJtIxrZ8OSjLp68iWHnPmQumOQKn2zo7K0TbcyoEfJyipov
         hO9N2vZCbxjd+KV6t+dWG+qqV/OQA+CxOoIo97CGiGU6tV9TdSnDZvr+X9Wn3O6druMj
         /xWw==
X-Gm-Message-State: AAQBX9dh7a9TmLWTWzvVYPu59S2Nl3BbmzWHXAN2a0BYoDFe68Uti+KR
        9wcgpKsrx2ffxAumyeKzRwP/SEF4iXZl7llpITk=
X-Google-Smtp-Source: AKy350bzYt5sqH0jJm2NqtOhFix6zch6UBRqw1JweY5kSlupQfB/ZdKaWtQxICM37T2obD95X71I8Q==
X-Received: by 2002:a17:906:25d5:b0:932:40f4:5c44 with SMTP id n21-20020a17090625d500b0093240f45c44mr5703891ejb.36.1679742108965;
        Sat, 25 Mar 2023 04:01:48 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d230:b2c7:d55:c9c8? ([2a02:810d:15c0:828:d230:b2c7:d55:c9c8])
        by smtp.gmail.com with ESMTPSA id r5-20020a1709064d0500b00923f05b2931sm11560427eju.118.2023.03.25.04.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Mar 2023 04:01:48 -0700 (PDT)
Message-ID: <03009090-e1e9-a176-c629-dee99993e9ad@linaro.org>
Date:   Sat, 25 Mar 2023 12:01:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] crypto - img-hash: Depend on OF and silence compile
 test warning
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
References: <20230319144439.31399-1-krzysztof.kozlowski@linaro.org>
 <ZB14gXqnkBzhdm0i@gondor.apana.org.au>
 <2dd13286-c518-66a7-44f4-b6c4f8acd061@linaro.org>
 <ZB6NxI9/llX7oFdg@gondor.apana.org.au>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZB6NxI9/llX7oFdg@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2023 06:59, Herbert Xu wrote:
> On Fri, Mar 24, 2023 at 11:51:43AM +0100, Krzysztof Kozlowski wrote:
>>
>>> You should either add a dependency on OF or __maybe_unused.
>>> Adding both makes no sense.
>>
>> Of course it makes, otherwise you have warnings which is also fixed here.
> 
> It won't create a warning if you depend on OF without COMPILE_TEST.

In that case yes, but we want COMPILE_TEST for build coverage.

> 
> Anyway, I think adding __maybe_unused by itself is sufficient.



Best regards,
Krzysztof

