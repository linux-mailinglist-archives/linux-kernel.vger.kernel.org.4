Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93BC676D67
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 15:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjAVOHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 09:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjAVOHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 09:07:19 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E556B1EFFD
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 06:07:17 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so6800851wmq.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 06:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YMFpKweYlwLdiHhHA/4B+vISjsfwbnz4pmYsFErLgYQ=;
        b=RMGEn6ejTDJFJ5rNS1sH74RjcCpiRHFUpfIC3XlYvV01IfJx1xwRyJNP2WVVzkrdwl
         qYYB67s6Bf7wJj4B+qZWOa7w6MQK4VohaYpvv24sQGPKGSDpvjYwYQYMxtu/taQtsR10
         vOkQWmylvVRa2l+dymzAUvTDk9uiO9H2cZVi2DAZkaNOLY54YIUD9htbQGDjg5/1ygW/
         7BlGOUh+GH6y4CHjmle+MCUF4tj/PCfyFB8XByjcGvpyVmfDciUyvFtB8XaiIuk+9Zw0
         Jj2jiKeVFEN9GG5qub6/OFbpfs/EWTj7Mpi4JLzY8iWUSqpQfn9nJljRVJBmEniGq1Xg
         kPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YMFpKweYlwLdiHhHA/4B+vISjsfwbnz4pmYsFErLgYQ=;
        b=xS0NUjJNqM9b+BSR+aLMztYsctIp0skrAlFSkfjvKnW7+ftNKqKSrGeJ0i+5WSEraR
         QvXacp038ijZwzzuAnpnyQc2v2iJOyzHMHw2mwa6Gzdpm66pyqfAbupj7L7tjIGXDjo3
         AtB3rRXtSj+x/3pJO2UWb3wUz9wXYM7pw1n2qOTMoV0jkk6+mx5f/rieDkGwBiAY1Adn
         ESQn4DWgtYi5ZTxv7GgejM0JDWVBeUb+eSLvQ1uMjd1ekFiyjwlKHzdH5mRB+XOlUIFc
         rrGLALbgBv68qT7NBr7KCujlE1oST0J0b6tMMT1qyUoireD5MEtFSgoEEDbB04MXMB7W
         rndw==
X-Gm-Message-State: AFqh2krtAUYqsoeFNnpXrKUgHaqn0IdNKcXjAzKk5IwU4tc5LHGV9oLQ
        ZEOfsmVYnfFpPdBm3XAZpz4nNQ==
X-Google-Smtp-Source: AMrXdXu3y+dMp2zCLYty/4P4oTz+KIifjny4XEkDjTu7U+ZTZfk+WkcnXbPqJXvYM6xQ9HPBntMBKw==
X-Received: by 2002:a05:600c:354a:b0:3da:1f6a:7b36 with SMTP id i10-20020a05600c354a00b003da1f6a7b36mr20933067wmq.0.1674396436494;
        Sun, 22 Jan 2023 06:07:16 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003db30be4a54sm8377883wms.38.2023.01.22.06.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 06:07:16 -0800 (PST)
Message-ID: <ec897c39-b6df-82fc-bd9e-84c6213acb1b@linaro.org>
Date:   Sun, 22 Jan 2023 15:07:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH RESEND v10 4/5] dt-bindings: media: i2c: imx334 add new
 link_freq
Content-Language: en-US
To:     shravan kumar <shravan.chippa@microchip.com>,
        paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     festevam@gmail.com, kernel@pengutronix.de, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sakari Ailus <sakari.ailus@iki.fi>
References: <20230121033713.3535351-1-shravan.chippa@microchip.com>
 <20230121033713.3535351-5-shravan.chippa@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230121033713.3535351-5-shravan.chippa@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2023 04:37, shravan kumar wrote:
> From: Shravan Chippa <shravan.chippa@microchip.com>
> 
> Add new supported link frequency in dt example.

You got comment to fix you CC list. Why not following my feedback?

Best regards,
Krzysztof

