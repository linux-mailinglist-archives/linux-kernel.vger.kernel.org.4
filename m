Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DD8701886
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 19:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjEMRhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 13:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjEMRhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 13:37:39 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81EC10F
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 10:37:37 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-953343581a4so1744716066b.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683999456; x=1686591456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=phEaoLqXnuHVjhKK/074Q+ATg9GGDFAIHK3RaliX/xs=;
        b=evSV/R5ffLjVwauCYY48D1u+m+e/VX17IimUCeC218UBpgANY/+ME4eqapH7Yj1bTq
         xOvbH10IfQYFcEFSpJA/qOGU+H1S+s9SJXp1ym6ZMvaC8bGppNn/tOLlS+eQXhtabKOq
         ZZiowXQeo7lgL3OsiH2dkUtArpkqSZLBAUQL4F2ivc78Q0SMMtkY1aXWZyWqvNoJoKQ8
         gX2TKhWmxEJTJ6omiYxBAL6Mtde07NztQGyu/SQD5kN20pM11pHSffzWQm3/D5zFs7hy
         DdxupsruO6PEYFIfy5VFVeMCgr0uXrYQ0woqBhW2ZrQH02iJ/hhztq/tQSCMWdik/m0b
         aPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683999456; x=1686591456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phEaoLqXnuHVjhKK/074Q+ATg9GGDFAIHK3RaliX/xs=;
        b=gQGKQ2t9HSb9mzzHjIiBw6FdPo6k9CiyJSq199Fj/5q6tv2GzdPkaCstRb/NPxab2G
         GPxotHy2yT5sN0JLslgBKtzFtKyln7w+mWYuk1FgRqOkCspgCMyX8aQvwZO5WESMEtqA
         0L0Xuf7Pkgg9zhLR0yKX8xa0eAz/SbokfQYEVpJpP9ZGTVyEUPPGp3OO4aMJ++oPkach
         n3tgYTctgjou5gU6qk/FoKX56SNONCC40ydxC0qL8zyb+lTsoH/nVZqXwSVB+qiljHSe
         weD3H5tfhasUOoe0k51R5IKhWsUgAi0AWKE0nIOJzkaIlIdkOgqHsm4rD2nD2g0J4oZe
         emBA==
X-Gm-Message-State: AC+VfDydTHW+9KD3tk3RZpxPu5aM5gtrodS23V5Nl/1l9CKKp5iMpcEH
        7jMcT20kMxK/C74OYHcJo424rw==
X-Google-Smtp-Source: ACHHUZ7Ff9s2f9f/z+N90bS59Y0tGzNori+ir7oCbpWhVrC2abp4fhHbcXH203MWt1UyD/1QZkhKsw==
X-Received: by 2002:a17:906:58c8:b0:966:168d:8c5 with SMTP id e8-20020a17090658c800b00966168d08c5mr24174817ejs.57.1683999456087;
        Sat, 13 May 2023 10:37:36 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bc2d:23f8:43c2:2aed? ([2a02:810d:15c0:828:bc2d:23f8:43c2:2aed])
        by smtp.gmail.com with ESMTPSA id jr18-20020a170906515200b00965f5d778e3sm7043541ejc.120.2023.05.13.10.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 10:37:35 -0700 (PDT)
Message-ID: <a65abc07-eace-eaa6-e821-2eed438e068b@linaro.org>
Date:   Sat, 13 May 2023 19:37:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] ASoC: MAINTAINERS: drop Krzysztof Kozlowski from Samsung
 audio
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        'Sylwester Nawrocki' <s.nawrocki@samsung.com>,
        'Liam Girdwood' <lgirdwood@gmail.com>,
        'Mark Brown' <broonie@kernel.org>,
        'Jaroslav Kysela' <perex@perex.cz>,
        'Takashi Iwai' <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     'Arnd Bergmann' <arnd@arndb.de>, 'Olof Johansson' <olof@lixom.net>,
        p.rajanbabu@samsung.com,
        =?UTF-8?B?J+2MkOy5tOymiCc=?= <pankaj.dubey@samsung.com>
References: <CGME20230513090242epcas5p34625f5b6f0a180263e6607a38e0c996f@epcas5p3.samsung.com>
 <20230513090228.4340-1-krzysztof.kozlowski@linaro.org>
 <000001d985a8$9fd3fb50$df7bf1f0$@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <000001d985a8$9fd3fb50$df7bf1f0$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2023 16:38, Alim Akhtar wrote:
> Hello Krzysztof,
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Saturday, May 13, 2023 2:32 PM
>> To: linux-samsung-soc@vger.kernel.org; Sylwester Nawrocki
>> <s.nawrocki@samsung.com>; Liam Girdwood <lgirdwood@gmail.com>;
>> Mark Brown <broonie@kernel.org>; Jaroslav Kysela <perex@perex.cz>;
>> Takashi Iwai <tiwai@suse.com>; alsa-devel@alsa-project.org; linux-
>> kernel@vger.kernel.org
>> Cc: Alim Akhtar <alim.akhtar@samsung.com>; Arnd Bergmann
>> <arnd@arndb.de>; Olof Johansson <olof@lixom.net>; Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org>
>> Subject: [PATCH] ASoC: MAINTAINERS: drop Krzysztof Kozlowski from
>> Samsung audio
>>
>> Remove Krzysztof Kozlowski from maintainer of Samsung SoC Audio drivers
>> and change the status to maintenance (no one is reality being paid for
>> looking at this).
>>
> Thank you! For your over the year’s contribution and support in
> maintaining and enhancing Samsung SoC Audio driver. Your input always helps
> and I hope that will continue in future as well.

Thanks! Although I did not contribute that much to the Samsung Audio
driver, but rather tried to keep it reviewed and in some shape.

> While at it, I know Padmanabhna (CCed) was recently doing and is working on
> I2S driver and Audio codec driver upstreaming to add support for some of
> the recent platforms. I will check with him if he has interest to take up
> this.

That would be great!

Best regards,
Krzysztof

