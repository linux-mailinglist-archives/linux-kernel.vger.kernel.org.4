Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16832695F83
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjBNJn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbjBNJn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:43:26 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DE82333F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:43:25 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id he5so2722021wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gBLOrVXRYr24P+ivdahQYvWuegwyHZsgAi8AV6/NNYY=;
        b=WQKgHZoIu7Wx2nsNis6PCDwi30kjLm2hY2OaHfySUi9/aRulvAk+DlUOn4F+8+GZHp
         +qZ7w52VaHG/rFeDkIhney5cS9TXra3vIxi1RWkGNQk7pA5TlgmkQ3oP2NE1tDs7tGaj
         jWYqGcseJBIKUeElV5KTfrKvSwDf8Nf3rpO6ffDrOAeQIFNCg7y3XjIIPB+P0ORyegMW
         pJznC0LgBxYKH/Y4R7uuGIBd73tU1Wk7GjMO6DmU1ug6/ObDGNtTCq6NevKbKYaUx5E6
         tL1v2y/A8ChhRtscj0OvYdvEcDni5qzXntqqltXsxVJBLqmAUPntrFmRWG63yjIKG617
         bSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gBLOrVXRYr24P+ivdahQYvWuegwyHZsgAi8AV6/NNYY=;
        b=gxaZG3Jn1CtQxP102jxWEeVLlttT153d1RC/1L8bZsa2qqIgnZxPRzMDvfmFPINkqE
         zIeYR9HE6lAms6nf+8tL6/JTNVbS+nGB0iWGuQT2WjXtxlXGROaB8ouRmpKWJ0YEYxm1
         cGc2FA/bmAREoWf6SOcrmcws+4ZKh+R5E9stW0d/BU6edO/IfB8YW3oh0jWTKLfeaq7g
         52VR3fP2WwGi2ekPivSch+1K9IspAXby3XGfRpS4HHHFPQYuzjq1UKKt6f812mlWUE5t
         9sA5TD0vMpGmxW1uqRdSnP8DkXEFQSzsrkgk7H6qJwbMEE+gy/+kw6EYvgswDhhjfLv1
         dR9A==
X-Gm-Message-State: AO0yUKVOsKD+A0UgmGgWe+lWZ/Gu35qNdBrzdmUO3cjX0obmA9YBHytB
        M1BZLUT2zO2+pobk+age4QZmAg==
X-Google-Smtp-Source: AK7set+qeG/u+dE5FxqVJZ53VaHO4WsaLQUtCNnSdl37SMQiWc914K1XbQ3YhXlFNYdM7inR02ifcA==
X-Received: by 2002:a05:600c:3511:b0:3df:9858:c03a with SMTP id h17-20020a05600c351100b003df9858c03amr8956767wmq.15.1676367804155;
        Tue, 14 Feb 2023 01:43:24 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p14-20020a1c544e000000b003db06493ee7sm20740755wmi.47.2023.02.14.01.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 01:43:23 -0800 (PST)
Message-ID: <2090ab39-c82a-70d8-9322-60d9d834d360@linaro.org>
Date:   Tue, 14 Feb 2023 10:43:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 16/17] dt-bindings: arm: apple: Add t8112 j413/j473/j493
 compatibles
Content-Language: en-US
To:     Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
 <20230202-asahi-t8112-dt-v1-16-cb5442d1c229@jannau.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202-asahi-t8112-dt-v1-16-cb5442d1c229@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2023 16:41, Janne Grunau wrote:
>    - MacBook Pro (14-inch, M1 Pro, 2021)
> @@ -70,6 +76,15 @@ properties:
>            - const: apple,t8103
>            - const: apple,arm-platform
>  
> +      - description: Apple M2 SoC based platforms
> +        items:
> +          - enum:
> +              - apple,j413 # MacBook Air (M2, 2022)
> +              - apple,j473 # Mac mini (M2, 2023)
> +              - apple,j493 # MacBook Pro (13-inch, M2, 2022)
> +          - const: apple,t8112
> +          - const: apple,arm-platform

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

