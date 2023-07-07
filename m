Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FB474AB16
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 08:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjGGG06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 02:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjGGG04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 02:26:56 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075F3E1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 23:26:55 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51d946d2634so2054436a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 23:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688711213; x=1691303213;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0W3Gd8jBrQTVEqQoMXv1avQ4XCiWz9OzEFTfcGO5S9w=;
        b=MYBnj45u6lsvuU47y/JuHX0SOY1/oJw5yUoKG81Pu7RI1xlBhhgOR3wTdPJoj+VkJO
         74I1YLJOZdWGawEVLQ/jrC7hUgrP7dUgqBBFE2nxAhk/zII5kNrgSv+VoQjLWJp1VZLS
         Tszfnj20a+NJT/gj45+t0DgPbhMiX7dD2j9hZSK3mKotd2HwGN6VID9M4UNetT/S7g6+
         QMNlg0b+Fy6Zvdyb9ySaJSZrDi/NnHF8+T0pkeEI3AJVxgHbN6nMlLxInaXssakWqvK3
         cCf1PFeLS79ezXP5vt6+itYDxLG6r1N+33kA8MR0YfG3eKQBvCzhQRYggxh3LiSg7II7
         1chg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688711213; x=1691303213;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0W3Gd8jBrQTVEqQoMXv1avQ4XCiWz9OzEFTfcGO5S9w=;
        b=d7G4cxpS6xji64FIWF11A4JUlDdjbcZYMQZ054GOqgY9v7OUvFRPW5EN6mmPfjzWtw
         Md59WW+Q5OhvzofIMJMldFSewH3aoqrgpGlher2Fm0QsGvuRpevRz65z/Fe7u09HAEg4
         a9cmmgZ5LdPMy/C7gK/FRbtkQok2M8DYs/L28zI5pA9kOcWrKI4dGh8Q62QQQ4TXT0M6
         c+xKXsmmJMfO93DCzuJuhFmOVeEtWdUf30Y5dQg1/D40Lq8Dpt73dTvkPWr/HBKQUAnT
         3qvn8mcfmViix7xhDsmjLxmWcHUubZfZ5RGAPlPG5fIuHdAxKk/PLdQR5w00yS09vbKz
         bNOg==
X-Gm-Message-State: ABy/qLY3/LQkYxANqlzw5DTfJ06JYFAIXOw2iSzmodUXVaJ2Gw509vpw
        mBzd6aAiNV0gwu4LyMh588TJpw==
X-Google-Smtp-Source: APBJJlGyXXAFlZKcUiBo8uH2mXTvF+2xcpddNfdWn8QuWvicVEB5eBFG1KaGmK8LsJfFTahNxI5cRg==
X-Received: by 2002:a17:906:224d:b0:977:e87c:e633 with SMTP id 13-20020a170906224d00b00977e87ce633mr2949201ejr.23.1688711213433;
        Thu, 06 Jul 2023 23:26:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id ov24-20020a170906fc1800b0099364d9f0e6sm1727055ejb.117.2023.07.06.23.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 23:26:52 -0700 (PDT)
Message-ID: <0fd87e8f-7d09-549f-1170-3bcebbc572f6@linaro.org>
Date:   Fri, 7 Jul 2023 08:26:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFT PATCH 1/3] arm64: dts: rockchip: correct audio-codec
 interrupt flag in eaidk-610
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230705064823.9210-1-krzysztof.kozlowski@linaro.org>
 <941ead9e-9e46-b5cb-0a8b-345df6606484@linaro.org>
 <9d9245fb-463f-c967-46e5-cfc0ac832792@arm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9d9245fb-463f-c967-46e5-cfc0ac832792@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2023 19:49, Robin Murphy wrote:
> On 2023-07-06 14:54, Krzysztof Kozlowski wrote:
>> On 05/07/2023 08:48, Krzysztof Kozlowski wrote:
>>> GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
>>> These are simple defines so they could be used in DTS but they will not
>>> have the same meaning: GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE.
>>>
>>> Correct the interrupt flags, assuming the author of the code wanted same
>>> logical behavior behind the name "ACTIVE_xxx", this is:
>>>    ACTIVE_LOW  => IRQ_TYPE_LEVEL_LOW
>>
>> This should be HIGH in both cases. I will send a v2.
> 
> Also the titles say "audio-codec" but they're all touching SDIO WiFi 
> modules ;)

Thanks. Too much of copy-pasta.

Best regards,
Krzysztof

