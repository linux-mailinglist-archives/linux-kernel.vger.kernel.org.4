Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3072E6835D7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjAaS5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjAaS5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:57:08 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24FA59267
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:57:03 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d14so15152833wrr.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=koCfgPABV8Epk2uhsIa3+bxa1VIQcy8atWQ8PzegVkU=;
        b=EK27b5DOne8CRgvIHl6Y2/Vvq3NixvSguwMwgD6AJC0fqaOw8tGba/6dfruRRb0mQd
         fohyudu/x2R6VRjg3zkHEf0C2kfshkkblOFDCR3tQ4ZDsT/Aayg4gaxFToSLo42mnHqS
         2xD2/H5ff1qQ6rPwsXKGL9yW+KdccUtKMu/iWok7p3FG+qXO1+xuIhAnWHyi3WjaXPUL
         oHobFx0dBlUI5FRPpYQV6VcM4fdipqJ0sLlk0BbpWrhP+br62sUSlM8FHaire/zbbLOx
         /wlX8CifwvFWVuv3fzLTA86yQlh4ffLY5SRHkj8Ix3mMXkSg9FADFkqHf2AL7z1h19Lg
         g/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=koCfgPABV8Epk2uhsIa3+bxa1VIQcy8atWQ8PzegVkU=;
        b=viS6wNg0r8JJZHmPHFxU83lVO0JFqdgoUKsk4+/W/XNyrjS8OuaceJ+9C23tFmd4E4
         YJ7OujhTSYGQZPjXzXSxL688nibu6UkwcnuSY7QDreEhi/Bbz1z8cUtOpGYHu4oYsDLC
         xnoQnMA/vbvjoyVOnH7PCzknlxOFAMQ6TzD6wISiDdycgURG0DOv+qdXsqR6zu5tXKIP
         4g7Jk0Hk4+TKmbXZzbGFhCmIUTBYiyuglDrlSqDDbqZWFDz+9UogSfJTnC1xuKpYJ1OF
         wVamW0T0UiebfHpa7AvGlfc3No5WXRgp+zmB429PwB92rmmm9zpC87GBCQSLqoIGV4vV
         3TRw==
X-Gm-Message-State: AO0yUKWn11RuTwGv46hIqhPgT85KRiAZBmqTT8IAzm8ISIjbBbsyABmj
        WcqyL5sAvdBtGcP2SlsQia0EPQ==
X-Google-Smtp-Source: AK7set/nmjOCflpMPfwLqC/I3rcVtck7nZbUopSbWf2ygMtn4iNFOv5iBEiBrqKK5Y3cLV2X8AwqLQ==
X-Received: by 2002:a5d:4dc4:0:b0:2bf:b9f2:6f88 with SMTP id f4-20020a5d4dc4000000b002bfb9f26f88mr3772308wru.33.1675191422445;
        Tue, 31 Jan 2023 10:57:02 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q3-20020adff503000000b002bfae1398bbsm15928669wro.42.2023.01.31.10.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 10:57:02 -0800 (PST)
Message-ID: <271c387f-41b9-3932-ba9f-60f1bea24019@linaro.org>
Date:   Tue, 31 Jan 2023 19:56:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH net-next v3 1/5] dt-bindings: net: Add Motorcomm yt8xxx
 ethernet phy
Content-Language: en-US
To:     Frank Sae <Frank.Sae@motor-comm.com>,
        Peter Geis <pgwipeout@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        yanhong.wang@starfivetech.com
Cc:     xiaogang.fan@motor-comm.com, fei.zhang@motor-comm.com,
        hua.sun@motor-comm.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230130063539.3700-1-Frank.Sae@motor-comm.com>
 <20230130063539.3700-2-Frank.Sae@motor-comm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230130063539.3700-2-Frank.Sae@motor-comm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2023 07:35, Frank Sae wrote:
>  Add a YAML binding document for the Motorcom yt8xxx Ethernet phy driver.
>  
> Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
> ---

Some of my comments from your v2 still apply. This was sent before I
replied to v2, so it's okay - but fix the points I asked.

Best regards,
Krzysztof

