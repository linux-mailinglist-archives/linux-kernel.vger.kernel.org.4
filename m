Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8066F3526
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 19:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjEARmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 13:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjEARma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 13:42:30 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AAC1A8
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 10:42:29 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-94f1a6e66c9so554792366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 10:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682962948; x=1685554948;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Hx7Uqf2u4ii+hWk1DAs1K3lE7Hz3F+8InAIubm1hNc=;
        b=aHXOuCWGGde0OFTu1kJpf2J6M1yo16UOnpBxStDUShjjOeODNI8MrFPc/HTfB5MOg9
         N69t2fSeYfVrrLgA6npfAQp1KglzxgB5Vl0smurrmLWPym4v2/YRLFjhJcTFfOQysHMO
         VQ6NJCjKxawpRM2Ccn8y1SVWwCAhz67SBxFV/5vaa4tvRyg7RDbdmB0Ldt/MK+jkqgpD
         9e7pQTuNpC8qhrp+OXZGHyx+F4j2PuWZJAh3WIiTP6GMjz8VCQGMr1gOnIdxWd+458QX
         ctWKexcT1DAgb5910aI6LSCQHw8+KqalcMjwe4/LANbrg6w3p1xbWrnItylsooa0NOG3
         o3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682962948; x=1685554948;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Hx7Uqf2u4ii+hWk1DAs1K3lE7Hz3F+8InAIubm1hNc=;
        b=kFftBCwNeTt12dAsuqzusjBHAfpufyf8t/gJk8wyTeZPztlYMz+ixQXoYSuCC71PIX
         JujUAd6e67TXSd6iVZ+eyWZRP6Imz8bqLexCIDSZZVPbAWbo2mAIknlRtED8yK9hgYH3
         XbAr5nlnXo3hqccULmwEyI4RyfGdlJ2+BV4Cry+wEzLs1Mia76L/W0TWLb7cXq2OZA7M
         7TVEHqHxgTly75hpH8Lqv3WCC7RVP1ZzJ1oFrcetfJoZsjU/AHhbHjr0H1ceIy/JM35r
         4qTNYIxY0z0ZOW6WvzCNBXNGwtI1lHG6kxk4sm0EI2gB+CSbw4iaSGrb9gsv53VX7qOP
         HEUA==
X-Gm-Message-State: AC+VfDzsOhrjqOLivX2GLTZ7YvV6vnQE4JYvV5znhRBUACTT8yZxXL5y
        rGqChaRgVNvU3nOr0Xho/LClMQ==
X-Google-Smtp-Source: ACHHUZ7IDwo8YiK+H04uo8GyQYbX717ONevaHw113rWwlS3H4A1KYCepB+JFzHF3YyJwI8rZyfrXLw==
X-Received: by 2002:a17:907:7b93:b0:953:517a:8f1a with SMTP id ne19-20020a1709077b9300b00953517a8f1amr14185760ejc.58.1682962947847;
        Mon, 01 May 2023 10:42:27 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:637a:fd0c:58fd:9f00? ([2a02:810d:15c0:828:637a:fd0c:58fd:9f00])
        by smtp.gmail.com with ESMTPSA id rp22-20020a170906d97600b0094f3e169ca5sm14948105ejb.158.2023.05.01.10.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 10:42:23 -0700 (PDT)
Message-ID: <3b42d309-058b-575b-dd37-cd67678c4a75@linaro.org>
Date:   Mon, 1 May 2023 19:42:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/2] dt-bindings: gnss: Add U-Blox Zed-F9
Content-Language: en-US
To:     alison@she-devel.com, johan@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        achaiken@aurora.tech
References: <20230501170124.1218603-1-alison@she-devel.com>
 <20230501170124.1218603-3-alison@she-devel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230501170124.1218603-3-alison@she-devel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2023 19:01, alison@she-devel.com wrote:
> From: Alison Chaiken <achaiken@aurora.tech>
> 
> Add support for the U-Blox Zed-F9P GNSS device.
> 
> Signed-off-by: Alison Chaiken <achaiken@aurora.tech>
> ---

Something is not right here. Either your SoB is missing or you are one
person but use entirely different addresses and names to send patches.
Your From in the email does not have even the first and last name. Use
the same address, that's the easiest.

Best regards,
Krzysztof

