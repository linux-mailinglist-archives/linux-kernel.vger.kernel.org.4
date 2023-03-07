Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F8C6AD9A2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjCGIxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCGIxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:53:51 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9495E34F62
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 00:53:49 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id x3so49207814edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 00:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678179228;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sKXXQjtzTzvcKxhZvQH1RFw66ohEz782zi0q3Qyu7cc=;
        b=QAsSTyiomi+ruA88zTpIwyZulf4KAzhB2dEYhkFLm6VRxFq1v1KP9ka9vTsyz6HeEF
         9MFQnoiQmg8gTQcpqdNoJKw/WcAui06f/it3C9D1uCzo9Q7sukWT3ABPHTIos6YDdCLz
         C/r8Q3NUS4Z/Eacmggtzg0mi+28qheqamhM8AeDKfexljD+zupdNc6I3Hw52SoPxR++x
         SE5d9AruYmuIBoDqiztlZ0kgPtE2dP3Sdx6Jr9SocDefglZE1Ru1opNy+r9bes9VwkQL
         gi3IyMgzLrNDDKIsDaGsoR1t2eNr4/DcjRh+lXLobC8aNGh5KZN2SUzZ3wbRPAdRc5V6
         aWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678179228;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sKXXQjtzTzvcKxhZvQH1RFw66ohEz782zi0q3Qyu7cc=;
        b=8DuUO6bwAFvY7rEOuMuGXKtnEGILQvFOeeAoBOydwqlBChws+cHGZBBLyJ734rmyti
         pjHvHKHm7iUfnfR8RBEjkU0KKHy9RMwBFaplll9KRppzNgDes9P8ItzWFmaghWpmq2L0
         9OZyJvvJs7wLuFnk5LAk2RwkFsQqXYEmb6CLBSsNByVHcCFbObunteEDrYgl5iCJUb16
         BMvS22A44/1yd41oJIRkLWVMNgifFzyk/+tmqQ9DuMhs8R7SkSuuiFF9L/UgdBCEIeE+
         ftZTUnwHLfUPCIIKacMK3Wf10dRtcIpk6vtzsn6uqfFxc1b01RsC7Z5PHTaJq5LfjMUk
         Zv0A==
X-Gm-Message-State: AO0yUKVSR09NX406GSJaT2mrFPI+btqoFgvhHFQ4xYjyKP84QfwGDDrl
        NQaYfjhXJRf/5FKfrPG/j578mA==
X-Google-Smtp-Source: AK7set/hvgOrx8Z4w64DF+Eg1pfeMgRjBCWMrB2J1hvjR31iR0/WOuuzcMrMBdu4qBOUYtovYsAbTg==
X-Received: by 2002:a17:906:3f5d:b0:871:178d:fc1e with SMTP id f29-20020a1709063f5d00b00871178dfc1emr12731473ejj.77.1678179228112;
        Tue, 07 Mar 2023 00:53:48 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:5310:35c7:6f9e:2cd3? ([2a02:810d:15c0:828:5310:35c7:6f9e:2cd3])
        by smtp.gmail.com with ESMTPSA id j17-20020a50d011000000b004e48f8df7e2sm2877227edf.72.2023.03.07.00.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 00:53:47 -0800 (PST)
Message-ID: <553587ba-ab8b-6cfd-ae4e-d9f6c67b214d@linaro.org>
Date:   Tue, 7 Mar 2023 09:53:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: ad74413r: allow setting sink
 current for digital input
Content-Language: en-US
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230302134922.1120217-1-linux@rasmusvillemoes.dk>
 <20230306094301.1357543-1-linux@rasmusvillemoes.dk>
 <20230306094301.1357543-2-linux@rasmusvillemoes.dk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230306094301.1357543-2-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2023 10:43, Rasmus Villemoes wrote:
> Depending on the actual hardware wired up to a digital input channel,
> it may be necessary to configure the ad74413r to sink a small
> current. For example, in the case of a simple mechanical switch, the
> charge on the external 68 nF capacitor (cf. the data sheet's Figure
> 34) will keep the channel as reading high even after the switch is
> turned off again.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  .../devicetree/bindings/iio/addac/adi,ad74413r.yaml      | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
> index 9eb3ecc8bbc8..590ea7936ad7 100644
> --- a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
> +++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
> @@ -101,6 +101,15 @@ patternProperties:
>            When not configured as a comparator, the GPO will be treated as an
>            output-only GPIO.
>  
> +      drive-strength-microamp:
> +        description: |
> +          For channels configured as digital input, this configures the sink
> +          current.
> +        minimum: 0
> +        maximum: 1800
> +        default: 0
> +        multipleOf: 120

You could add it also to the example, but it's fine:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

