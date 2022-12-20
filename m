Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2040E651E9A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 11:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbiLTKQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 05:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbiLTKQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 05:16:32 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBB63B4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:16:31 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id m29so17640738lfo.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eC4q4jvQ90KMOVQHs85KxE496/zijPcFgBm5g6Iu/3E=;
        b=GCU0csYhyLdA1fUP+FjiVmbzah9iH+QaVF0tn15WKsJ4PYEdvpkzSJ3zGxOT+3R558
         IGlNh3UIZ1KBW7+Cw/2m6Mscqsqfsogrh0bGpCxCD0SVHXwHhCluNtSvNmerctLfgQtY
         y9+Mn9FGCUVv0IpJzFT+iHURKB0py8fV4V0AJSUoqn/UAUKkfDn2acYf6WUKSuEnJZiE
         BGeg5YQP3f+Q1itjz4Dp60cl1LxZgXJe9+84PjMV03I1UvD5ro6BPu12F/mziHyVPLSD
         QYLOnxe7wYkzZBG7fWAxqsfpsvZGnkd0YhC81bUbD+6uG4fVVrsxVpiJz8nCKEzW3vP7
         8Npg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eC4q4jvQ90KMOVQHs85KxE496/zijPcFgBm5g6Iu/3E=;
        b=SRMVQeJJoyeUq6fdZi7VyaTRvWIXmEZA7TCVNwl9s0jsnTBFd+8YwhR5xg4HFnpPLl
         VxC/7Z39R7EgrHgaCtRXcqEgr7m3TswEGXry7VcDctHulkqmQSrhnE38qEm9WmQb75NK
         HlkEZ2+OJbJBV4Gy6g0sNeDxX5DSf3gg1PtOUBnQWrvp9Fdu1dLG1IScgg/MFX+CyttI
         54JMUZhuY6QBW6A+xXlWdaosB5ew04hCu3+MUuzUynUMrFbmnjqn5ooZvRtk2L+RXTjE
         +eVz98GHCpnKKVzSeK4x4Hqq/5DUeJ3dnt4px5PDDyrclkh2GSLkaGIseScHHO36NwBQ
         P+2A==
X-Gm-Message-State: ANoB5pkdFgirLPhkjxUXKpV9dh8fCKJaooCIAeYIM/ObIDgM8QzNS/mY
        L52xW5s9/l0gUxFCkj/R/lsoYA==
X-Google-Smtp-Source: AA0mqf4WdhFI3RPoXCV33iInsZM3tU7zqqIoK39AHQ/gdV9jF5c3SPV50QDxMOvhX45TBpH7BfPX4w==
X-Received: by 2002:a05:6512:3e19:b0:4b0:6023:6f6f with SMTP id i25-20020a0565123e1900b004b060236f6fmr17385142lfv.57.1671531389777;
        Tue, 20 Dec 2022 02:16:29 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u23-20020a196a17000000b004b5774726dcsm1394418lfu.236.2022.12.20.02.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 02:16:29 -0800 (PST)
Message-ID: <c0e89d2b-1b99-4224-9003-c583cf5171e7@linaro.org>
Date:   Tue, 20 Dec 2022 11:16:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] dt-bindings: rtc: pcf2127: add missing pcf/pca2129
 entries
Content-Language: en-US
To:     Hugo Villeneuve <hugo@hugovil.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     bruno.thomsen@gmail.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221219194241.3817250-1-hugo@hugovil.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221219194241.3817250-1-hugo@hugovil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2022 20:42, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> The pcf2127_of_match structure in drivers/rtc/rtc-pcf2127.c also
> contains:
>     nxp,pcf2129
>     ncp,pca2129
> 
> Add these missing entries.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> index cde7b1675ead..00dbae7e23c2 100644
> --- a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> @@ -14,7 +14,10 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: nxp,pcf2127
> +    enum:
> +      - nxp,pcf2127
> +      - nxp,pcf2129
> +      - ncp,pca2129

Keep the entries sorted, e.g. alphabetically.

Best regards,
Krzysztof

