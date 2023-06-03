Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846A5720F32
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 12:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjFCKZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 06:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjFCKZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 06:25:13 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDC7B8
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 03:25:11 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-97467e06511so221418866b.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Jun 2023 03:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685787910; x=1688379910;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v+jZuOe65re37AzNecWfF6HpJCyT3y03+7tLInXnNWQ=;
        b=m6aTXbeftyu4E9hUYm1P1nRqzPfy4R3eGl0ZtZuw9TPm9lMxue/YmBkOvGrJKmPt/4
         EAOabbpQktUMfZO+vU+yYIDjoQ0ARk9lbiBlS8QhbF2d9YmO0SALs7UlCA3EYbcZwgb8
         LQ9C1nQ4jFUUTlJP9qwmQUSqzLarNWg/1myyPYsTGe2+iKdDmGzc5gSXUQtIMMsm7rKR
         Yq5k0LhEVxSmNzrePBHpfo15VAp/M495OFkzZgw/2cpwC6bvEbsduI5HcJQbY0jo0npZ
         5ewet5wjRCKTjFLKgKixZ7GRjVMvcQaZP/YuRYD2idrD2t6eeTcDSyMImvWeQNLGqr2y
         pR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685787910; x=1688379910;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v+jZuOe65re37AzNecWfF6HpJCyT3y03+7tLInXnNWQ=;
        b=U3KkAqbqvQlW/ftTYMBtYIMp/w0vLBB64JPOgQdMmVIZqGhnd8VrHbrgzEqcu6xrnK
         Fq9deB4MBYkJTEk0SdPbSUfvXaxamprQL+gvM6lVTwfEjy6ugYWUe/VMCykpbHbFVLrY
         +BrXbqB3uGlkBt2gQG9UKeGp/x++NPicsfieiThz0DD/GXnp7lKjMZWT0OxBZuZqo43K
         CddDSbBC5XsXO+scmHCoqXJbmIeK+XLAgSZ0e+sFmx4EKvfj9zraeXf70NzfhFJqrDsJ
         74vWMUuw+IfHTzd3ftdUVYqD4wEzHR397o/uNSEeRCGxFdhRHJVOAWjsjcW88kQnzJxy
         f4gw==
X-Gm-Message-State: AC+VfDxGGb5Cy/qRO65X3u4gMXMumSkXiBhGRjionVH6ZB76XaXPWj1Y
        E0Nf8bFzlv5RzQ1WgrHxbLtERkBy98dXKKnL3FE7qQ==
X-Google-Smtp-Source: ACHHUZ6opopcUXNqIYZla8BAwCRp4JdG6D/Dr2DYaziUe9IcX8o7/9dboGLzXJAKPkuZdY5jTsXaRw==
X-Received: by 2002:a17:906:dc91:b0:974:1c98:d38e with SMTP id cs17-20020a170906dc9100b009741c98d38emr1382426ejc.2.1685787910267;
        Sat, 03 Jun 2023 03:25:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id bw6-20020a170906c1c600b0096a91ab434fsm1797055ejb.40.2023.06.03.03.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Jun 2023 03:25:09 -0700 (PDT)
Message-ID: <447e880f-2b68-c0e0-6345-67811b1cda3e@linaro.org>
Date:   Sat, 3 Jun 2023 12:25:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v5 1/3] dt-bindings: thermal: tsens: Add ipq9574
 compatible
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Praveenkumar I <quic_ipkumar@quicinc.com>
References: <cover.1685703605.git.quic_varada@quicinc.com>
 <1daf835b3c77fd84ad55b0195816fabc3f0ab800.1685703605.git.quic_varada@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1daf835b3c77fd84ad55b0195816fabc3f0ab800.1685703605.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2023 13:03, Varadarajan Narayanan wrote:
> From: Praveenkumar I <quic_ipkumar@quicinc.com>
> 
> Qualcomm IPQ9574 has tsens v2.3.1 block, which is similar to IPQ8074 tsens.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

