Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EB76E1D9F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 09:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjDNH40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 03:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjDNH4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 03:56:13 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB352769A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 00:56:10 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id qb20so43140337ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 00:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681458969; x=1684050969;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jO+txe0/tju7TBj8YyUNP1mhhIUo+JM8IABYNNwZkrU=;
        b=P2p1Pab0C8LFNjEyySM/Keqgkei3qF4Z8GHYSoWA8GmQTkzPhxJa/4AklwidKiap4I
         r6NjChvpg3OHYZzdwfzPIFKnH/nzDlAmzMzGOdeWIkKcRLQCH4juzGJOad/vqsqGBlqk
         nlyPEvpzhirFoLSut2BvpV0i3iMt5Hsn3wSzMq7Wf4cWzuW6ytOcBAn5+lYTiHLVDEXG
         vAv6Ghskc1agCXPWAyV5dlu80Ejxzf9nhb20cm6H7fOi6Z2Vrddg6T4Q0IfA34DVyraj
         o1n23Hp/P8hRMQxhmKeXkFquKOF42bCFTozbjEI/7MeqhWtKPhF5SHB5mAFeGsNPsmvt
         gONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681458969; x=1684050969;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jO+txe0/tju7TBj8YyUNP1mhhIUo+JM8IABYNNwZkrU=;
        b=LbvxEbvD/H3GjMAwgQY0piTWGcQSHDEDy3eEVZPKoepzWROQlxNFXctwc0kBSOpDUm
         /r+sLBatPa9YkVF0xQuwzgW53m+4tG2oF83jrIbZqhvhBt92aXJovDjyyhmYyv+DK6kb
         HaUy5tvBiYZAuGNRu9Mx9KoSwIchJB0y95hLyw9jPzTmUmB2aEBn6ZBtFjXlgwGnfwZw
         eQ9AsIIYqkvUh3FkfA/+fxffjzjl3HB9ZIg0BeHxnN1UMfCiw11bdD1uIWTyhwYYun8B
         xcEfAbFXOIACZYjC/XQvOtsIPc2CG22FKARobY8lIJZRJwMNEvj8lLEOF4je9pA3O/h0
         U0WQ==
X-Gm-Message-State: AAQBX9fqRtwncCpa89nP41UB7QSjgl7PlrGDNx0gM26gix+TijjnpJ8f
        WwO1a5Gda+15glsjShkR1TV1Ug==
X-Google-Smtp-Source: AKy350ZgBFckEN9fwytkjaYI9qzUHXg8J2Y+dj5ceEZhD0V/5bXD+O4dL45kZIF0pZIK7aNwp2tMlA==
X-Received: by 2002:a17:906:2449:b0:94a:8f3a:1a77 with SMTP id a9-20020a170906244900b0094a8f3a1a77mr5107342ejb.8.1681458969092;
        Fri, 14 Apr 2023 00:56:09 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8a60:6b0f:105a:eefb? ([2a02:810d:15c0:828:8a60:6b0f:105a:eefb])
        by smtp.gmail.com with ESMTPSA id 7-20020a170906328700b0094e1344ddfdsm2073873ejw.34.2023.04.14.00.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 00:56:08 -0700 (PDT)
Message-ID: <577ecd98-94eb-3795-4859-ffad03192f89@linaro.org>
Date:   Fri, 14 Apr 2023 09:56:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 5/8] dt-bindings: iio: adc: qcom,spmi-vadc: Allow 1/16 for
 pre-scaling
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org
References: <20230414-pmi632-v1-0-fe94dc414832@z3ntu.xyz>
 <20230414-pmi632-v1-5-fe94dc414832@z3ntu.xyz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230414-pmi632-v1-5-fe94dc414832@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 01:17, Luca Weiss wrote:
> The channel ADC5_USB_IN_V_16 is using 1/16 pre-scaling on at least
> pm7250b and pmi632. Allow that in the schema.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

