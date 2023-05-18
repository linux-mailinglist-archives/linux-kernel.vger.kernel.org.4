Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098D4707E2B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 12:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjERKd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 06:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjERKdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 06:33:22 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3A91FE5
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 03:33:20 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-96652cb7673so296582466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 03:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684405998; x=1686997998;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G5DY7urOobiZRjR4OZIaCLmieV4AgS5HJDFTf9UwQ/Q=;
        b=iNzIegnvt/v1fYGMpoz9S98aOmexlCzQv28VuU/BJtCYsN/YFiuledKJJU82aaTO2X
         QFANvBymphaZl0YqelxhZ5qN5/UXKPKS8dF1hu2OC622ogu2FUl+qy7wFrhNlKA6+Zti
         5yLLHbVuhb9H4XD2WTkxWeNiPKO7WPuTYn9CgNWscdCeVao8YuYa1Kvxb4ihG2Mmt9j2
         e/idYHt0+nwycKdQBM+EHbRPTLLr6NHAhCG8z0LTMkxGXEiA/pKmCrif2e39JJ21Sz/O
         2WSDSuvKJ5FqH3M8Gm2CXPlMtXFzXdZbuE6y078K5mvux2sqdNctv/6kb9H/SSm9sGNT
         4+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684405998; x=1686997998;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G5DY7urOobiZRjR4OZIaCLmieV4AgS5HJDFTf9UwQ/Q=;
        b=QMyuQ0m9lqHWgcRhlJ7k1jI0xwLp3+AvbYSSvsqSxaZZ1xzSEp/2EGzYYU9zCzx7AZ
         diYqMUXcou/7ZSTl4R0MZvs8s6ARZF8HcpBgYKj5YoCApBJl1ZCVYSLGVCyAuENV56UG
         ajRFh80eulbczedD0AW9H+eWEMooK8dmnaGtOxWhvVe7+Bqv1k1DsAb2AeTMagp3UDBt
         UzVb5lGkYkBWeyXiuvENmyjJfZNK/tKtEpj7uOVAjFlutnQnvFjIn70eBKO7p4mZWfRm
         ch07yMKKZPpwyTGgHChfNo2NMTmgut0eDNVyebs6eaO4JEi91u1MY3bcBaJnMVQEANmM
         06gQ==
X-Gm-Message-State: AC+VfDw6od1oizREmMssAwxBBcbpjDplKux5uRfA7tRgByMchH+Guoh7
        Sv+YTnTKyzOUXZNYrrtHnSVtqQ==
X-Google-Smtp-Source: ACHHUZ7XP3poLOlWhhHsfzSWukjrGK+hIXKzIa0zdvIlPCzVZhQVUHfqf8Fja+Sd1wTHDINFUlDorg==
X-Received: by 2002:a17:907:728e:b0:96a:e7cc:b8b1 with SMTP id dt14-20020a170907728e00b0096ae7ccb8b1mr16378653ejc.56.1684405998503;
        Thu, 18 May 2023 03:33:18 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a2b:c408:5834:f48e? ([2a02:810d:15c0:828:a2b:c408:5834:f48e])
        by smtp.gmail.com with ESMTPSA id bv17-20020a170906b1d100b00965c529f103sm777804ejb.86.2023.05.18.03.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 03:33:18 -0700 (PDT)
Message-ID: <cc4109d6-3125-0738-537d-34f9fa2c2fa1@linaro.org>
Date:   Thu, 18 May 2023 12:33:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RESEND PATCH 00/12] ASoC: codecs: do not store status in state
 containe
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20230518072753.7361-1-krzysztof.kozlowski@linaro.org>
 <ZGX8v3qjkmfMf+J1@finisterre.sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZGX8v3qjkmfMf+J1@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2023 12:23, Mark Brown wrote:
> On Thu, May 18, 2023 at 09:27:41AM +0200, Krzysztof Kozlowski wrote:
>> Hi,
>>
>> Resend due to missing cover letter, so adding per-series tags was
>> not possible.
> 
> Please write proper cover letters, but don't resend for this.  You
> constantly raise small review errors in other people's submissions...

Since you asked for a cover letter and you did not apply the patchset (I
checked in your tree), that seemed like a feedback for something you
want me to fix.

If you want to give feedback which person should not immediately fix,
please state it explicitly or through applying patches.

If you give imprecise messages, don't be surprised you receive different
results.

Best regards,
Krzysztof

