Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBFF6D9888
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238745AbjDFNsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238763AbjDFNrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:47:48 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D06D9011
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 06:47:47 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m2so39584587wrh.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 06:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680788866; x=1683380866;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TdAF+ibqcFz4f6UdI5r5abisS6qF8hg1G7lhZkeAXYk=;
        b=K6Ue2kLas1nzxCZUBRilJ1kLLpCsofAICEsJrL3smruTXD1fR2+bSTlwWm69gOqaHp
         9uaqsG6fQa46Uvu5my78Cjt03M8AaUhxNziPqotWdcYotbaORHzuS7B3eS4a9ZRHgdYE
         ThlcZhhS90jD8rO/JFHXXew8RDycI/LjF8sHSUahfMlaGiFzrmwuBrpcWzKsFY7jsK/M
         5JCoFTCv0eC0tD/7quPpsG4QuybO3sB1x2OkAVtUMJ+k7At8CoyhhMeKH3Y6hYsbHbDt
         Zi4/vYcSUe+0b0kX0svtL/mTywrW+vQSI/R1jA66acc6DLkmiGj2tr8ODPOc9qmmtyS4
         Df7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680788866; x=1683380866;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TdAF+ibqcFz4f6UdI5r5abisS6qF8hg1G7lhZkeAXYk=;
        b=HFNW+9ecqf3siIiuWSh3rGjO7GblihEbZNJkM74/jJF0j5d0RdGO/gI0KqXi8S8usH
         Mn46ttVY75/iIgrPyjFm5R+tbZSOCYv5A4GxdkV5VqW9rO9O7mkUs4A1sfj9wXaVpPM3
         8bHPvP/04fMLDS9T2T3ON6sENm/3yWKHIZ2RciWVuFHE6FargM0gwWOba4vqrUoX2xWu
         Tkx1ZfaOqJYwhJ+sqSq9UvyGnSIe/KKk9YhR1xrAoqPcnw9TiwoVs/pQq96t43g/icA0
         EJiQgrX0SPX8rf457j0wj8I/CAQLXEtit2ELeVnangASslpD6nLq0hW2upW/RNv+v0ZD
         JmxA==
X-Gm-Message-State: AAQBX9c2QYjN4gDhJtbX5OD6mZp9NKdG5l3y26MdiHIEuT4+/g+BUCz0
        BCvVM9myvHwUPH/ahzqAKeEJ5Wpon4EeYjjjGFU=
X-Google-Smtp-Source: AKy350bmrAdsX6X1rSge/32ODk27bBZ6G1w66+evfQeyDqDJLrT1HXoEPotxLtDd29dO11qj7Fvguw==
X-Received: by 2002:adf:db92:0:b0:2cf:f04b:fb23 with SMTP id u18-20020adfdb92000000b002cff04bfb23mr5865244wri.59.1680788865687;
        Thu, 06 Apr 2023 06:47:45 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:6630:ee96:3710:24c8? ([2a05:6e02:1041:c10:6630:ee96:3710:24c8])
        by smtp.googlemail.com with ESMTPSA id v6-20020a5d4b06000000b002c55b0e6ef1sm1862281wrq.4.2023.04.06.06.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 06:47:45 -0700 (PDT)
Message-ID: <f88d563d-2626-630e-8168-727160549cf7@linaro.org>
Date:   Thu, 6 Apr 2023 15:47:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] clocksource/drivers/timer-ti-dm: Use
 of_address_to_resource()
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
References: <20230319163220.226273-1-robh@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230319163220.226273-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2023 17:32, Rob Herring wrote:
> Replace of_get_address() and of_translate_address() calls with single
> call to of_address_to_resource().
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

