Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D6B67797C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjAWKra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjAWKr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:47:27 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8744512F17
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 02:47:26 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so10272520wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 02:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fU1S+TXAbkoOoXXk2DZBz/HiRoFz+TiJByFLxAdsbC4=;
        b=z4y7ynnP/U9zdGxG+TFXJsdlt8qPdvyzZ2NLOD/TsOdUtn7+cvLm9xUuFcyqcw/gqJ
         TsiIqOqnY9zeb6thECpBCw75J1c0pH2IsYrb+gl1r9pwaf6Nihcw0LXnbY9WWIbnbAgK
         w33unIygCl5ZpRPQ1FYR/OdUQgtKpnp/NdpcPsVgdxnCkbqpJ3SSjWI/8IKV9xDpoZ9K
         fZaQP/rqCDdUZVcFTjZLUf05W8fcUxbUzhCfJ9H/Ky2DRYxS9IV9aOHD786Ks3Z/Dnua
         LlXcthCiuOakQr2FbG0kipHcWCPQ0Xw07g366eDaYbVYWre6xbwCfu5vGdk4phMRrK95
         aARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fU1S+TXAbkoOoXXk2DZBz/HiRoFz+TiJByFLxAdsbC4=;
        b=7oK1P5H5hXDswiQq3PaBVTlRAcuLxkS/tSXeWqt/s8gwE2Ej+7VIgPuU2Z/yz4IsRc
         iJq/BAQpdjxL1JqKGpeIKJ4NA7bP+7wIT7U+1q0KjgfH66BgowtHQYXvSq4GprbldGwQ
         7XDONYbPV2o16b2UeZSmrN8Ci5CIPLFyj2DixEuOlgOnslcuhJBB73ZClYBOY56xmANZ
         SZE8o7ugA5jjtZ0T61+ZSZz1QvueCTGZnKoZCGvBzMdpR2NHrkp+YsTDwMbZpAAg2vvY
         J5fMoAsMVxZ2g7fT1KMDJOOVvdxLbJ6G7oZtBy/FtNHM6y45DhI6/DAOW7hOeBPHfPuv
         18Pw==
X-Gm-Message-State: AFqh2koU1PeR1AsJf5dVGQDv6WnLn4/cZb7j5BuXtJz8ZUgORcqvpxK+
        NRAZYn029rHN1vGaDm69UBQbNZSdW+mmWnaJ
X-Google-Smtp-Source: AMrXdXtwrVFfBr3owCbi0x7hdO6LxKnmENNQJrZEHB9jYVbOMKDsrPVQYcTogciBJY9lDgWAGuWsZA==
X-Received: by 2002:a05:600c:4e05:b0:3db:1d8:9f25 with SMTP id b5-20020a05600c4e0500b003db01d89f25mr23064084wmq.2.1674470845144;
        Mon, 23 Jan 2023 02:47:25 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k16-20020a7bc410000000b003d99469ece1sm10267474wmi.24.2023.01.23.02.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 02:47:24 -0800 (PST)
Message-ID: <66dc1763-c88a-27a3-cdbe-9be52bdc12de@linaro.org>
Date:   Mon, 23 Jan 2023 11:47:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] memory: renesas-rpc-if: Fix missing setting address
Content-Language: en-US
To:     JaimeLiao <jaimeliao.tw@gmail.com>, linux-kernel@vger.kernel.org
Cc:     juliensu@mxic.com.tw, leoyu@mxic.com.tw, alvinzhou@mxic.com.tw,
        jaimeliao@mxic.com.tw
References: <20221123025141.4012-1-jaimeliao.tw@gmail.com>
 <167213158106.15520.12651563480098587733.b4-ty@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <167213158106.15520.12651563480098587733.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/12/2022 09:59, Krzysztof Kozlowski wrote:
> On Wed, 23 Nov 2022 10:51:41 +0800, JaimeLiao wrote:
>> In the RPC manual mode, if the data direction is not set
>> (such as the flash erase command), the address misses the
>> setting.
>>
>>
> 
> Applied, thanks!
> 
> [1/1] memory: renesas-rpc-if: Fix missing setting address
>       https://git.kernel.org/krzk/linux-mem-ctrl/c/21a1234f82cbf4258445072bb23c38fed2ce6cb3

And drop. Stop sending the same patch all over again...

Best regards,
Krzysztof

