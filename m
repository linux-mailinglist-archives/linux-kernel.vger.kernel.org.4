Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6394963A74E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 12:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiK1LnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 06:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiK1LnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:43:17 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9280A10B9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:43:16 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id d3so12825312ljl.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y/NMdKpvhQ7cYen/mRGTvw+CDxQ+zYX5fNUIZk143oU=;
        b=zPPIZYgrwVjHLzBWjVMvmXXqJo7dVQcVfNrE3MVLyPOZHpdHEcG8UpD1BY4g5euhIe
         nLXA8Ksvo7aVHwGrUGMpF/Nuwbv2JMboQz+9ZkkbChF3UF57IkRrQtJDZHE97HxkmChu
         L2r8eu0jHe95NZf98vkGQyVbHw9WaSBAK/7AY9IuMC0nsOttBjkFxEJFfk6ayfXxE9Ef
         xPl9rExhKXLBHXwR7K6hDygN0b21lbSOi+Bqb2VDVkZkYQGCduttL+BohwwyZrzPId6h
         yNcxQsFW5KECtYlth79xa8erpyTxgIdWutVOa2gDsEpx7YuXlrVVfzOeab0OGn86UrOo
         BAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y/NMdKpvhQ7cYen/mRGTvw+CDxQ+zYX5fNUIZk143oU=;
        b=t8+rC2c337mb/MyWjAsc38qW2ld3oU40ceCKltjU9d74SfeXLWvaH7T3ZmWCTV+PBv
         bt00J5pOjTHJlR13eYBoXujLKqSjN5s8oZGZaq61JUwZJzScndsO7Ry0KJSpsd6XSsMs
         tXWDo5HyvhCnJHZhQwLuPKrHGl/u3bluwNDYlG6wfenU2moJw27fC4aJDGHZHKIhL0Cx
         qNQ7N4Eq+AsFeoO8yfpUQopkq/jmqOQ3yln1mDb4T3oRBSd5N6Ovyi6qzy/DMiACL+Np
         zzOyKWVQrhFlAQ7wWUSkiZJy2RUlJ8WwDh9PqA9cqTTftfmbwKuaqm1oX5P/YJgdZeZm
         8M9w==
X-Gm-Message-State: ANoB5pk7A+ABkfQDaSGuF7NEBijigX2ykvH8R1Z0D0IIQpRURB96TdAC
        5zA9FKFybfwrQchViFmpWW94yQ==
X-Google-Smtp-Source: AA0mqf7JcyuuiKV19YXlSN9PwOCS11wpzt/G/7BdhxRJZAX3qBlz4emKPnOW9rw04xAqKRp63FvXaQ==
X-Received: by 2002:a2e:800e:0:b0:279:8e27:b42f with SMTP id j14-20020a2e800e000000b002798e27b42fmr4917410ljg.106.1669635794980;
        Mon, 28 Nov 2022 03:43:14 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o6-20020ac25e26000000b00492e3a8366esm1696734lfg.9.2022.11.28.03.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 03:43:14 -0800 (PST)
Message-ID: <1aeecc8a-9fa7-dc69-c4fc-1238bbfda85e@linaro.org>
Date:   Mon, 28 Nov 2022 12:43:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/5] dt-bindings: power: Add NNA power domain
Content-Language: en-US
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     italonicola@collabora.com,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Amlogic Meson SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221128111740.39003-1-tomeu.vizoso@collabora.com>
 <20221128111740.39003-3-tomeu.vizoso@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221128111740.39003-3-tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2022 12:17, Tomeu Vizoso wrote:

Missing commit msg.

Same problem with missing changelog.

> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---


Best regards,
Krzysztof

