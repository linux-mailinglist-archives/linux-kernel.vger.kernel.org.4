Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F04B6AD8E0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCGINL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCGINI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:13:08 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1102F1CF7A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 00:13:07 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s11so48931891edy.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 00:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678176785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ebi9MqJM2rLRf0HSN4orh6m6hlkXC3F34t4OkD8rs5Y=;
        b=T/8LQ56A+DCv2G/Yqt6nlZ7Ong4A4WqREAUMpClvksBr0tW6ClJVjDxxYzAmHjeWiw
         puIZz+WKU/rUOHPvNuEQBeld2exBzfEgQ/sJFQ6MbTemwQeXjuoklaO1kSKmLR2EZ4Lx
         wC8HU/R+kBQBYje7LI2oq6g4KifmQnVARlQ7S6mjZdUFlIfa2KUyJJphSMZaxJSTNFeB
         +nK5UoF1lItnTCv0sK63mCq8qiOSAw+fJRRIgE7h2RKv8wDyU9zHW90bTUhLGp00m7kp
         8Utac6QY6gxH8qOQEjoDlrg7Aa0Q1rWabkw1kHbdzT8Mf+UI6UKSDb18U0CysscMIq2X
         BiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678176785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ebi9MqJM2rLRf0HSN4orh6m6hlkXC3F34t4OkD8rs5Y=;
        b=eXH5p+Scwu9K5LsD2t+JaazZKoGoqVcfMWgnm8LQR4ODEAmP4GDgRMqxMt6/30ipW8
         fyDHN9XZ7R+R1N0lMtDPxj5Cd/YSEcQplLhGeahmOY6o22FhsZkXwgEI6GZ33Xk7fC+r
         Mx+E8jwVUjEihK1h+ptMMsdR0vhWlZ7gQ0J3pEgq0E0fp0cZcmUx+gf8WBZvs6gOGFCa
         gxpEHb3KYngvNNHAmgumQQRBLjbaaLMzZW20WiGsyT4txPz2suV2Z0L0qEb3n0x9eXDL
         +zb94LobueYsAyVd22W9WYWdBfsv/PhWe8ZWKBekEDbq6gW2Rd0rmdNuKofMMnyF3r03
         BjYQ==
X-Gm-Message-State: AO0yUKW0ymzBXC6agdOMbQWK84oJxk32ZMawA+7JYOIPkysaZSxNTS28
        7USMtSLJ0ewqQCW2sJ/UaEb2Xw==
X-Google-Smtp-Source: AK7set+/dBFG4ZgrEGv+wZafXcyEgE0rxM7bbP+OzMVJLXtuh4vHOX5WFn5lvpAatboWhU1FUB804w==
X-Received: by 2002:a17:907:8b16:b0:8b1:2e7c:df49 with SMTP id sz22-20020a1709078b1600b008b12e7cdf49mr15401797ejc.7.1678176785582;
        Tue, 07 Mar 2023 00:13:05 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:5310:35c7:6f9e:2cd3? ([2a02:810d:15c0:828:5310:35c7:6f9e:2cd3])
        by smtp.gmail.com with ESMTPSA id h25-20020a1709063b5900b008d0dbf15b8bsm5693956ejf.212.2023.03.07.00.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 00:13:05 -0800 (PST)
Message-ID: <a6425bde-5b6d-2fb2-2396-a35677b19e8f@linaro.org>
Date:   Tue, 7 Mar 2023 09:13:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4] dt-bindings: ata: Add UniPhier controller binding
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230222155906.19403-1-hayashi.kunihiko@socionext.com>
 <9d36818f-3ce3-0fb6-1a3e-85e3879af08c@opensource.wdc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9d36818f-3ce3-0fb6-1a3e-85e3879af08c@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2023 02:22, Damien Le Moal wrote:
> On 2/23/23 00:59, Kunihiko Hayashi wrote:
>> Add UniPhier SATA controller compatible string to the platform binding.
>> This controller needs three reset controls for Pro4 SoC, or two reset
>> controls for PXs2 and PXs3 SoCs.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> 
> Rob,
> 
> Are you OK with this patch ? I can take it for 6.4.
> 

You got Review (which includes also "Ack"), what are you missing here?

Best regards,
Krzysztof

