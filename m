Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E645E9C7D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbiIZIvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbiIZIvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:51:50 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46A53C158
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:51:48 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id t16so2601202ljh.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=dYcIJG9WEnF75GLPMbZCu90oLFLh/1KLHAzt4BbmS60=;
        b=LrEVkhz5dWz+MuDKDJepoj3kgGK84UccxvYJXbYi58hNWr3PsgJNkz2JHMVFw5Wv7X
         L7UG/EYKaeM9SCZSFKQMU9yeyIvzMkYOPNtN3hengQp9O/3e98YOOMasA/QzmHIVTewv
         IxGPB41uoKRoF1FMKj1BVfjfTc0Y03HGUnxbTzVeIoWln1HNHGhKiNfVAJ/xUaQ+iwTY
         ycDuRo8CuQhhSiYZqQksomJTW9Ghak939qCEbfQk2rWlUc5bSlsinPmoKRnwtRuSlmOT
         KnAYbTZckjgunolqHLbEj5+NNu4+o6kK+LBZyU92hiORPZDiBJqfdvYs0RsrRFruriLE
         3Z6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=dYcIJG9WEnF75GLPMbZCu90oLFLh/1KLHAzt4BbmS60=;
        b=7kRM47zZoIQHDamz6ipJYopli0xSSpTw35O3rBe/q08jgTV5IJMYyj1z+XjU1Gj2+j
         mRp/uOPoBJN2N/sAFCBVEqFQ+0T8QmXQDK08RlPHlYaiQfdrZnjDQw4+qpFg8FlU2HSS
         OgQ2IhRgmeftYXbcuTlO0qk+K6dz7XkHZiwTb1tkWtlqt0PkjNhA1t8Qaho6DSqECTNp
         gRv9BdWzHFRwj+6laZCKJMlEoc9ZjmGGUbteUSG4YhBsgCQs1ntXx1Hzj+M+TvWMGSSs
         e+OOz3tI9FyaSU21vJrY037eBzUwZo2sWQZOvhJYNJnvelTF/WfqeB+kU0umkr4MOrZu
         pPnw==
X-Gm-Message-State: ACrzQf2PNO2AvZFIywItSa0L6LlIQWtU8RpRVGz+cPHi4H1T04nfj5dd
        p+1pcD1BzVzg2zUa2oCtHgZOTw==
X-Google-Smtp-Source: AMsMyM7dWLa6d+muecNYC3so8Ps9Qpkzaa17G3C/5DdI9BVu0/8KN9Y/Ley5IXFnrWufeJj9FYO9pA==
X-Received: by 2002:a05:651c:1548:b0:26c:61b3:7129 with SMTP id y8-20020a05651c154800b0026c61b37129mr6758963ljp.381.1664182307165;
        Mon, 26 Sep 2022 01:51:47 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f9-20020a05651201c900b0048af397c827sm2454844lfp.218.2022.09.26.01.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 01:51:46 -0700 (PDT)
Message-ID: <3cabc45a-526b-0177-e29a-bbe048e97a7f@linaro.org>
Date:   Mon, 26 Sep 2022 10:51:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 2/2] dt-bindings: mfd: qcom,spmi-pmic: support more types
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220925211744.133947-1-luca@z3ntu.xyz>
 <20220925211744.133947-2-luca@z3ntu.xyz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220925211744.133947-2-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2022 23:17, Luca Weiss wrote:

Thank you for your patch. There is something to discuss/improve.

>      additionalProperties: true # FIXME qcom,pm8916-wcd-analog-codec binding not converted yet
>  
> +  "charger@[0-9a-f]+$":
> +    type: object
> +    oneOf:
> +      - $ref: /schemas/power/supply/qcom,pm8941-charger.yaml#
> +      - $ref: /schemas/power/supply/qcom,pm8941-coincell.yaml#
> +
> +  "^dcdc@[0-9a-f]+$":
> +    type: object

How about renaming this one to usb-vbus-regulator?

Best regards,
Krzysztof

