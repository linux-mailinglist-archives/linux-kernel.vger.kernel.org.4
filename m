Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9307762C5FA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbiKPRKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiKPRKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:10:02 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790072C13B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:09:59 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id l8so22615712ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1r4D8rfU1yDWW4dWo6ifO0ci3Mgqwv1FlOWu/XE/YOw=;
        b=G1FxQufYFuB4pLtu9UXpQOAAM8HrhD3xOV3pzYACokkQ1QMPy7Mgfw2xw4Q7hEuSQP
         L0ocuI43O8YbZNeKeMNKVjI36i4GQj169v4C2XqrfIUL4gzsRyJixe+V3zhinBCzxl6v
         Ld8m4ZUH2qHxAHsoUhMjQxHMMFAhNkblj6HwhZ69mb6bsZxMt7dU/EYfW8accfSX3ucy
         QbSDN7wmgjt0oMk+bcysUKWQ7p0NFU+yQBUmlZa/4h3snT2JjWXEyAFzBUjVt1eR7YFj
         5pHFZFQ42RtIexX62TZa40kn7bqMOWtchDlll45/6NXIWfmvg1g+bLUQ3M0QnCySVyP3
         ISsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1r4D8rfU1yDWW4dWo6ifO0ci3Mgqwv1FlOWu/XE/YOw=;
        b=bC3iNDnNqzdpk/wwYXVMRYLzYSKZXqp5A9NdiC1MJXmGR5xYkUwyCjChhc2c0yJdJd
         g4D9t/HCk+2yBFYqRAwROyFLrsDJKIc39oCOOAVJFJxHUontMsqbUk3tiLC1PB1uVeEt
         /jTmDdkkSnSL4ZNVqNvJrYkkn6liOKfuwn4kw2JzxuaZA63F+k8nqkSlYo6UBL86XvXj
         W1/oGd2NrjOdtdcruldytfUj+R3OIN7Gp6IkNcXnfEP0/jnIXzW6INMDXgH/IVXOwN7c
         HstHhVfk8qH7/Yl5yKBkmAPe1AmiBA6RcLwRj60yuaHy9vqGkZbheF7agpKU5Rol7nDy
         jz+Q==
X-Gm-Message-State: ANoB5pmib5/0XZ+43IxOGB2a1yDPfKVvr261D0Eaug1bcidPxPuiLIbA
        tRzk/yRcPd5km4i2xReMfCl6dA==
X-Google-Smtp-Source: AA0mqf729AblIIVVU3rMV2SnXkffUGszfKYygmHz7Fv7TNmIRxLyRPgqhficbC5G+GEZ70l6ikejow==
X-Received: by 2002:a2e:8892:0:b0:277:9847:286a with SMTP id k18-20020a2e8892000000b002779847286amr7546321lji.309.1668618597885;
        Wed, 16 Nov 2022 09:09:57 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a19-20020a2eb553000000b002776eb5b1cesm3110526ljn.8.2022.11.16.09.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 09:09:57 -0800 (PST)
Message-ID: <48989f14-e377-0fa3-fd9e-69d3d5d77c25@linaro.org>
Date:   Wed, 16 Nov 2022 18:09:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: usb: dwc3: Add SM8550 compatible
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20221116150600.3011160-1-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221116150600.3011160-1-abel.vesa@linaro.org>
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

On 16/11/2022 16:06, Abel Vesa wrote:
> Document the SM8550 dwc3 compatible.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

