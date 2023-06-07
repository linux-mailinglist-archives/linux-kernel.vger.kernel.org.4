Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D937258D5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239641AbjFGI4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239623AbjFGI4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:56:12 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6F81BF7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 01:55:13 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-516a008e495so369611a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 01:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686128112; x=1688720112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RTpA5qOAPRS8MQZfyN8Ss9cXLKE3reuQWNe17eVOs98=;
        b=D2ESwCvV3EMJ4Ca9Xo0YrNr2h8zDu3w8UAFRDTvjKd+CzOHysYAMrUv95WmgXW6pef
         PsKk6OT+GE3LhG59KbziqQ8SX2zQaEPT9u8GVDR84WIwdNAJaeEZI0k91AdVnjG4fkba
         7QfIE+0YEtfGCqwMJjmHD0uUn7sG3yGccZKVA9w7gvuWa2pSa7UzCkUG/q57UumGb1EA
         4OKi4guQJOqGhlKfXqujVgAzpzyCQ7hJotGxoUFQ9FHVd4N13KRLYrRg+JJE1C5Pxxon
         yqRiF+kOeMILJ7ArRRRzkzEFaxvUjTteQsnxlZPRwwLMcnLuFClt6rOtK1yjIsDrIlmd
         ftfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686128112; x=1688720112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RTpA5qOAPRS8MQZfyN8Ss9cXLKE3reuQWNe17eVOs98=;
        b=QVcWM1/omvUwn1J2k3Q2Vyiw0EI8CUtsl6htVqHNctDVTBJTnxPpnaKEWJmIiOJZzD
         Z9F9eYs7mPCanD88Sor1A1NjMDQ9NFj8kY4S2Khbw+lTU0L08sJtPlGmkEdZTj52DuX0
         Rpx6j8pcSJDVwoANMzM+gq46bOFW9lEuoeBEMPIsKG4gkKOyKbNbtC7pgpn42zm1ToCX
         ONIv5eXUUpumBdmT6rOh9zPex9ehOaCPiqw9zpfAluuAF3rzzhb3Rx3b+XlJKsqgmlL9
         eQhB300uycYCmSkuco9phbf/AZpbJMfadqAT/HEk0/kJ/Lu/gA292Sr4AJ7zTK3lqAHo
         jpeg==
X-Gm-Message-State: AC+VfDzhovEBlFFMMLDT3uK+RjJf76M39N4Ebol0/jTa9Y6CDH9g/lkl
        rc26vu16GknyAOtQ+/krfGtyUA==
X-Google-Smtp-Source: ACHHUZ68EljsPgkNMfLt/pjzYCbcf3rch3Eqf0hQ739bCBHvP3l1XP1YD46PoScoXp1Rg3YgbqRIWg==
X-Received: by 2002:aa7:c59a:0:b0:514:9e47:4319 with SMTP id g26-20020aa7c59a000000b005149e474319mr4990483edq.5.1686128111991;
        Wed, 07 Jun 2023 01:55:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id u6-20020aa7d0c6000000b0050488d1d376sm5951735edo.0.2023.06.07.01.55.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 01:55:11 -0700 (PDT)
Message-ID: <c8fe71a4-f8bb-d0a5-a227-14040fa024a9@linaro.org>
Date:   Wed, 7 Jun 2023 10:55:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [v5 3/5] dt-bindings: mfd: Add aspeed pwm-tach binding
Content-Language: en-US
To:     Billy Tsai <billy_tsai@aspeedtech.com>,
        Patrick Williams <patrick@stwcx.xyz>
Cc:     "jdelvare@suse.com" <jdelvare@suse.com>,
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
References: <20230606094535.5388-1-billy_tsai@aspeedtech.com>
 <20230606094535.5388-4-billy_tsai@aspeedtech.com>
 <35bf0a69-bcf6-ae35-eb3c-e74cfcf9c571@linaro.org>
 <ZH89fXknZlhGmM_H@heinlein.vulture-banana.ts.net>
 <c28f963e-d13c-6b5c-c389-996e986f81d5@linaro.org>
 <SG2PR06MB33652E18980E9CF8E4F0894D8B53A@SG2PR06MB3365.apcprd06.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <SG2PR06MB33652E18980E9CF8E4F0894D8B53A@SG2PR06MB3365.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 08:26, Billy Tsai wrote:
>         >>
>         >> He felt what he was trying to accomplish met the documented
>         >> expectations.  Are there some changes that need to be done in mfd.txt to
>         >> further clarify when to use it and when not to?
> 
>         > I think mfd.txt clearly states:
>         > "For more complex devices, when the nexus driver has to
>         > probe registers to figure out what child devices exist etc, this should
>         > not be used. In the latter case the child devices will be determined by
>         > the operating system."
> 
> About the mfd:
> For our pwm and tach devices, there is no need to check/apply any hardware register from parent to determine child’s existence or functional.
> They don’t have any dependency on the parent node. In fact, it doesn’t require a specific driver to bind with the "aspeed,ast2600-pwm-tach" label. Their purpose is solely to share the same clock, reset phandle and base address. The main reason for using simple-mfd in this case is because these two independent devices share the same base address.

Actually one more thoughts. I have doubt that you have two independent
devices. If you share the clock, reset line and register address space,
this means *you do not have two independent devices*.

You have most likely only one device.

Best regards,
Krzysztof

