Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB2867E544
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjA0Mcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjA0Mcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:32:42 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7113C2C
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:32:40 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so5320913wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zOZLnCCSB4bMWTg2//OMRb+a8xBlO3pQtkZONx7me9k=;
        b=MBLQfSlFVm5e6eH4hLBrw51ODKea5IRMHFX6KcL1hiqtbCc5VyjKH9Uh7cEoRUUOWp
         rMBuWGZzfF8rCVg795QqTXKqrA0gLK5n5c87uTtCoR1YDMVaedTxj0VNOjuCt13lliRp
         ESkiVIJBDAHKWOrRLKoKeSXBkiv0GUFeHQBEm2CdN/zZKEWiqZH5DRKyXImCyn5B1ed0
         YqU0BA6+zRU7OUqHUbSkM3cf647JBpELsZiEhhgkmO0RqwZ4OaEZ+Q7IkJgHhI3Onw32
         s1NKfJPqM+Ucopvvv7N6ux9gyX3fiAHyxFBm1nCp+u2z0BWDMP3woH2iXrEFlvaPdsgj
         Ry3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zOZLnCCSB4bMWTg2//OMRb+a8xBlO3pQtkZONx7me9k=;
        b=0zDQrN5YaXM252icZB0BmIkkSbAQ9MzAwPh2oDURQjoR6SGEehWlcxluq98Sg7mCb2
         0sGuYeF0CzJDFwP1UiZh41JSolEfrpA/RyJ2YmXREAYYI1wURkzKFX/qB0hLFNpC1+zX
         2u4966eGAfZ9F501cs0ZJVh8w5WTwmWt7MRAc4rzvfzkLKkhB/hfo4jmoe0a65mM3erL
         A6DTVXH/2KmWljNOT5bPMd5aJWr+2ldHL0evhSraVQ6py3VPKYaqMU7pjrw5SC09AH0j
         m6Z4WUpoeqOLyhAnwg7MHXPBYBDeJQwiz0HMyJaLhZ0Oas32KBwsaePf/PT9uxsvzKXX
         4vZg==
X-Gm-Message-State: AFqh2koe6TfnFI/ypFB1QeOqwh0qZRq7dj1k3FHKPiVY0xqnedsBb1tR
        h9y/+mKoysJUlaP2tqpyAPPuFw==
X-Google-Smtp-Source: AMrXdXsW1aVVkxLXdl4r65UZK22XQvImWGDpqsMZdSeZ7sW59AK47O9+z8LSxQk4XKzqNihmVuGDYA==
X-Received: by 2002:a05:600c:a13:b0:3db:1de2:af31 with SMTP id z19-20020a05600c0a1300b003db1de2af31mr31652904wmp.37.1674822759169;
        Fri, 27 Jan 2023 04:32:39 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c418c00b003d9780466b0sm4143686wmh.31.2023.01.27.04.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 04:32:38 -0800 (PST)
Message-ID: <c8c923d3-26d0-00ed-9639-251504950593@linaro.org>
Date:   Fri, 27 Jan 2023 13:32:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] dt-bindings: arm: amlogic: add support for Radxa
 Zero2
Content-Language: en-US
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230127110928.3387654-1-christianshewitt@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230127110928.3387654-1-christianshewitt@gmail.com>
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

On 27/01/2023 12:09, Christian Hewitt wrote:
> The Radxa Zero2 is a small form-factor SBC using the Amlogic
> A311D chip.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

