Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212E4700067
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 08:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239972AbjELG3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 02:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239970AbjELG3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 02:29:10 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5E75FC5
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 23:28:50 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bc1612940so17203437a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 23:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683872911; x=1686464911;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qCw15SfYMK2B6owlUD8kxxoz9ExQiSv5RRYqltzPr4g=;
        b=dI539FzGixTzW5ymZ3qLWPWh6IrFwVqFA46o4Sr5mT4Ee/rexUM9QVQogWTzgdPvzV
         EOiNj0Ard/Bx0c1fJrZ2zCdXwYDn3L/T9WO16QRB9H0AjMRdJJ/gPLWeEmYRa7UUlqft
         V/AYkl+XWx69xo+8hzmAaSNDvEfG4A4WxCBK6mVF2GHK5RGInzudH0Lbs9xL8XSmr52F
         sERqE3g24+vBDhNh2Qa4ClqjmRcMJhkVhNtlq/r7OOi22F9Dr2mcQjt9nyhWyXQy/oBU
         xKAk/VlfKgwRfqoxFxBHcGs4OKLnIaOzab2rIsh2DyrptGX53ZjA/SsxAq1iW93s62d9
         RFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683872911; x=1686464911;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qCw15SfYMK2B6owlUD8kxxoz9ExQiSv5RRYqltzPr4g=;
        b=ZpFRlEeR/ckOof2WoNuo1V2WqEX0IAeE865bRORv/yafmE3x3JCOOBOmNaY7916el8
         ogQMi6g9jPYZg/3ygqV8DlG87fIrp6ZQPxOJDk5keyRiEeYHzBi879E3Z11TdtFnSw/d
         eVtlKFZI0qGhvJGp6+Ef6BhBE9fM9Zv+sNC57e+R5FBM/KpXDpLEKG6ngGnsZctfn4MT
         ZRgp9/qMDdDF2gJCzuSA+/Hfq/wFnJ1j92v8Ol23DYrmAmOYFwrCYUI90Ci2QVeoA5MD
         9JAdjICdRPs9sCAO9vygDPaKU4lm3JYTYehOzfu5stXATD92WshQ4i1gc8s81lLTzLfQ
         6EWA==
X-Gm-Message-State: AC+VfDxeM/2vJRub+RlM9tkj+6BckaGF21jLECKKlzTY0mHrtlV6A6xN
        iF4NiALv4EudqcGnXWofwph2YQ==
X-Google-Smtp-Source: ACHHUZ6rMumRQiudxsHtEc4TaOEwlKOYxPgYOeRKFTkuhqtDE0NvrtkgljDUlatBGvXrPI1NjJ6HLQ==
X-Received: by 2002:a17:906:eec5:b0:965:bdd1:1d22 with SMTP id wu5-20020a170906eec500b00965bdd11d22mr20510547ejb.68.1683872911361;
        Thu, 11 May 2023 23:28:31 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7ede:fc7b:2328:3883? ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id f7-20020a170906494700b00965bf86c00asm5066016ejt.143.2023.05.11.23.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 23:28:30 -0700 (PDT)
Message-ID: <4d18eb55-a44c-4033-93cd-35c02cb179b3@linaro.org>
Date:   Fri, 12 May 2023 08:28:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: iio: temperature: Add DT bindings for TMP006
Content-Language: en-US
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>, broonie@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <ZFvo2TIiPiMFlbXC@yoga>
 <fc104fdd-3894-aa94-12dc-4c73b26d4159@linaro.org> <ZF08pzGPyReL1uAf@yoga>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZF08pzGPyReL1uAf@yoga>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2023 21:06, Anup Sharma wrote:
> On Thu, May 11, 2023 at 11:28:50AM +0200, Krzysztof Kozlowski wrote:
>> On 10/05/2023 20:56, Anup Sharma wrote:
>>> Add devicetree binding document for TMP006, IR thermopile sensor.
>>
>> Why? Where is any user of this? DTS? Driver?
>>
> 
> The support for TMP006 is available at driver/iio/temperature

There is no such compatible in the kernel. If you add OF support, you
should change the driver.


Best regards,
Krzysztof

