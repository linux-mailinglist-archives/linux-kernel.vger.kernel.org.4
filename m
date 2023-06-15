Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08917310CA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjFOHdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243416AbjFOHc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:32:56 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1422D5D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:32:40 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51a2661614cso484701a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686814359; x=1689406359;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0T01BUR4iszPkfnXV4jgUMkmxhDftwtafpe9lYKGnDA=;
        b=WOUH9Nbt08zqpgFCndvBJAwWodKyinVlSsIdRlxu87njqklXzJoKG4tz78RGoxdBMq
         eMPmQWN3FREY1Ofwo4Rc0CohiZJVMxyAvmSGkzuEVsAMdNhhxTGtBqoTdH4VWEQngAhG
         OoTIasWySTORlamWrug9m4lSJoF/Sc0MEHiQGWnCSaAAsSGOMkbhIjYob3LEKIjc3oij
         ic8vMYSm0Q+7JNL4EcWSBa+3SIJACce3UAStkO4WqWeNQlnW6sgZlPwlRSUgWcRUIE3f
         LZ85xIWqFDjQtqta6bkVgbGksYO37nndDM0NETnZfQvOwI/BsoZEl0wZ5FsnWi7Vak28
         XuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686814359; x=1689406359;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0T01BUR4iszPkfnXV4jgUMkmxhDftwtafpe9lYKGnDA=;
        b=fLhaOAzK9EZ8e3uBGWtK+UfuI0LwJdBhjI3crCjSmQ7WgWUHm+dqlHONno/GSOh0Pm
         ZbaUgBNoaaSVrFuF7mSwaGVJYNA2/EBUv0C0TUsmsx4hXIj+kbcB5W00l1cwvOzgFSTq
         VAK6Sw9QkNesu4KhnFYyAp+gmKKPA4gpW6+dJ3p1lK3mmsh98I9stvCPLHZ7jsSvHf7j
         ynFPcp0beinRnymH9KBbg1gYA1GizlOpnwb2UzvhGEll6eRq8VQw8p+cYgs53AK04Hih
         69gPSZgSs0OUQg3UInSXBtx0eVbySUnUQPtPFkh1ckkruSp5a0bi36zQ2sdxWNvL9Tj6
         uX1A==
X-Gm-Message-State: AC+VfDx9vm8yRmiwSUJ8R0pwm3nNfmcOs7DdF1jApe70TRRcL9Gtn8tX
        Vjra+rvCg05f0BAvrJ5l31t0mw==
X-Google-Smtp-Source: ACHHUZ4vc4UKj8FD6SlKtS2PYzsT6NzQeOIOWArA5HI/qAH+CQhyfwIsc1QUnMosg4S/oHU9avvWTg==
X-Received: by 2002:aa7:d756:0:b0:516:416b:f736 with SMTP id a22-20020aa7d756000000b00516416bf736mr11247984eds.35.1686814358858;
        Thu, 15 Jun 2023 00:32:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id m9-20020aa7c489000000b0051422f31b1bsm8437975edq.63.2023.06.15.00.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 00:32:38 -0700 (PDT)
Message-ID: <df613aa9-00ea-2a8d-cf61-f1e85d26cd4d@linaro.org>
Date:   Thu, 15 Jun 2023 09:32:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] dt-bindings: clock: drop unneeded quotes and use absolute
 /schemas path
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <20230609140751.65129-1-krzysztof.kozlowski@linaro.org>
 <b07d3bfae4702417010ed5ee14739bb0.sboyd@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b07d3bfae4702417010ed5ee14739bb0.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2023 02:35, Stephen Boyd wrote:
> Quoting Krzysztof Kozlowski (2023-06-09 07:07:51)
>> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
>> checking for this can be enabled in yamllint.  Also absolute path
>> starting with /schemas is preferred.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
> 
> It's not clear if I should pick this up. Do you want to take it through
> some DT tree?

Please grab it.

Best regards,
Krzysztof

