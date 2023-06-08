Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C697278A2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbjFHHUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbjFHHUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:20:22 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8861984
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 00:20:12 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-977c89c47bdso57610166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 00:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686208811; x=1688800811;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sCl6rtqI/lnsAp34i7m13i8YaVFA5i7mUTO1m89CYUc=;
        b=l725wZUxx6r1Ycdzj7cFBsrukTjy35bP8IPHmCSPAz2hwoQ7qy8PxBKnau50bylSgD
         HR75/QKRHMZqVnep07+5VoUwjXIK1GOar8CmX+kSwjwZWQBzxsrJ3vI/jvm6cGzwUz0G
         h4BXewrylaAkKZWViWZzgE2aRhGAcI6xcMtveDLMcSp9Cl6zrvAKlUt0b7xoRBdosabR
         MOoX7D2/feSpNpjMkhKJM30W0R1//Ojj8UTP/OZW+U47/wyyxY6cduOrMp4VijBrz+7a
         NveV1pzoP2fV+SB8xaAMgkXATbpJ4PAH5tckzUVAwOU8ilr5RuWYZXWQ/NtkyW/CFKc1
         6VEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686208811; x=1688800811;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sCl6rtqI/lnsAp34i7m13i8YaVFA5i7mUTO1m89CYUc=;
        b=jI0bjnjgj5+4ijjLivLUIO3/qMChOklkQTSjxYiQWpRKE7DgmN6ieQcGKvYsNnrrAy
         dJTxjAPHNLORVUoD8xIqFtU+KuhtY8/qSSi0/VfuLRV48xoe8mWaSCZQyObDpzxle4el
         L1sOhoyqUhfV9zz4DQ1CXCXXCNIbxKOMLGG6tZ4sqDoEjeHsDKCSOekG2iGs+Q7aJk1t
         HFWpKtcaKXpNfStG/fleitodrDqHTr6wyrBLuH7VK80nv/D0BswyptoRpa4Ba3Rk0LTe
         JVJvyyMn1/ywqsWTAnhPlQTAivhwXGeqd81Ij5KvwxcscRpkIByOLfZdhSs14iMf5oRG
         T5cw==
X-Gm-Message-State: AC+VfDwGl7fuJucUrs5B0vBSA/1q3wEmyDH/f/Gjvhsxyj8/sy2OQtb1
        rRuAgChwfPsYOtkoB9Tz0kQNlQ==
X-Google-Smtp-Source: ACHHUZ5dyxvogNuartC9WpRJfkks70+K3BJ8tJOfNobMtwn0tLJXermHSdQpCm9l7vzWKuJsNrZRpA==
X-Received: by 2002:a17:907:1628:b0:974:5e8b:fc35 with SMTP id hb40-20020a170907162800b009745e8bfc35mr8746192ejc.26.1686208811151;
        Thu, 08 Jun 2023 00:20:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id j24-20020a170906051800b00965e1be3002sm309402eja.166.2023.06.08.00.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 00:20:10 -0700 (PDT)
Message-ID: <5000d481-2125-95e0-4033-d9c71a49cbd7@linaro.org>
Date:   Thu, 8 Jun 2023 09:20:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [v4 1/5] dt-bindings: mfd: Add aspeed pwm-tach binding
Content-Language: en-US
To:     Billy Tsai <billy_tsai@aspeedtech.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "lee@kernel.org" <lee@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
 <20221123061635.32025-2-billy_tsai@aspeedtech.com>
 <c4b188b1-06a4-3cb0-a758-e12942e1f67b@linaro.org>
 <ce99a709-ba4a-eb53-39ac-88a194879000@linaro.org>
 <SG2PR06MB3365AE9D075601CB62C6E7F78B50A@SG2PR06MB3365.apcprd06.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <SG2PR06MB3365AE9D075601CB62C6E7F78B50A@SG2PR06MB3365.apcprd06.prod.outlook.com>
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

On 08/06/2023 09:15, Billy Tsai wrote:
>         On 23/11/2022 09:24, Krzysztof Kozlowski wrote:
>         >> On 23/11/2022 07:16, Billy Tsai wrote:
>         >>> Add device binding for aspeed pwm-tach device which is a multi-function
>         >>> device include pwm and tach function.
>         >>
>         >> Subject: drop second, redundant "bindings".
> 
>         > Where did you implement this comment in your v6?
> 
> Sorry, I guess by "Subject: drop second, redundant "bindings"" you meant to remove the second "bindings" string from my subject. So I change the subject from "dt-bindings: hwmon: Add bindings for aspeed tach controller" and "dt-bindings: pwm: Add bindings for aspeed pwm controller" in v4 to "dt-bindings: hwmon: Add ASPEED TACH Control documentation" and "dt-bindings: pwm: Add ASPEED PWM Control documentation" in v6.

A nit, subject: drop second/last, redundant "documentation". The
"dt-bindings" prefix is already stating that these are bindings and
documentation.

> If I have misunderstood your comment, please let me know.

You replaced one redundant with other redundant. I only asked to drop
it, not replace it.


Best regards,
Krzysztof

