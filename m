Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EA06792DD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 09:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjAXIRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 03:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjAXIRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 03:17:18 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C121BF0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:17:17 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id q5so8391284wrv.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kLCH4vzF1S5fETKgbedPA51jeuB1hlnoXHacM1L7F8A=;
        b=PUCx69XU/ALNSOnNm3wvq0dYsW6xQff+/756CSvgawj5VkarkYeNnvrg5pkIHXeJvC
         tH6jWQZXJGE7SPgHqrLg7MYzAdvLRGLlYUkq5Ip8xwrNY1UH11hLEN22hByAXNFspFKz
         aZiO/3UlZaGGnmfbNQVMLEqgOxtE/FItMeLb3VFNY6HFcQIqWYJKC82PhT8+A4lF1xzN
         ives3T43i1wpt4rZaeNlGoK12ltSem8VVpphw5DSpJkrSdkNYAJAG+SJA/nv4iQKPwSE
         Hb6ajPifB6TjJitYVTr0H5+W327fGX0kdXDAr8Z8xIvJ51i/+rSc8RaavuRsdyXrWZ/k
         JXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kLCH4vzF1S5fETKgbedPA51jeuB1hlnoXHacM1L7F8A=;
        b=k2liJCwhNZ0ew/b8Mh4vqMHdARip/jSebP48HLljRmFeoRS+1gPzCW7a0yLHwoa7ij
         K0/TAP2ewZNhIpa3/+aseBLS//YcpNs54hw4oHfbH8ygjblbw1mVsNNcdsP3YBRNcynp
         MlYwabkXFpLz5L3GgoV2JgvijJ8aYDL5bQcpGKoqTdysyiola5wffhGX/moUqY2LL0/j
         04AgChjWVLWTX1VoQ/mihWU698mvaYKn1LhCbsXCrWFRykVBGpJxcshKYyEkQqxcNAbd
         Rcw1dkbyKIRsqL4vpbA2TAgVzKiJ3ojRCyDrz5oHy+SCc75CmM+c+MdW33zY7YLbBGh+
         s8Nw==
X-Gm-Message-State: AFqh2krcFDjLdH1OTMCuqzmkY8c9KCqvBCDJ+8lOL1KuWFHc8HbeJESF
        0U0KSTVMab2xsykgm0enTjnEpQ==
X-Google-Smtp-Source: AMrXdXuKhilEOYXCaWzj5MnYT6+XRh6z0kCNN3okw51LIYDecgd5E8Ez0G9+d3ehflLkb16p29wJdA==
X-Received: by 2002:a05:6000:608:b0:2bd:db84:d663 with SMTP id bn8-20020a056000060800b002bddb84d663mr21417965wrb.5.1674548235969;
        Tue, 24 Jan 2023 00:17:15 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id x15-20020a5d650f000000b002bdda9856b5sm1263775wru.50.2023.01.24.00.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 00:17:15 -0800 (PST)
Message-ID: <955f4b2a-a750-11a2-0423-72023935723b@linaro.org>
Date:   Tue, 24 Jan 2023 09:17:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/2] dt-bindings: mmc: correct pwrseq node names
Content-Language: en-US
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Tony Huang <tonyhuang.sunplus@gmail.com>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Markus Pargmann <mpa@pengutronix.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-tegra@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20230120085722.171965-1-krzysztof.kozlowski@linaro.org>
 <20230120085722.171965-2-krzysztof.kozlowski@linaro.org>
 <2138388.Mh6RI2rZIc@diego>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2138388.Mh6RI2rZIc@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2023 10:38, Heiko Stübner wrote:
> Am Freitag, 20. Januar 2023, 09:57:22 CET schrieb Krzysztof Kozlowski:
>> Node names should be generic and should not contain underscores.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.yaml   | 2 +-
>>  Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml | 2 +-
>>  Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml | 2 +-
>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.yaml b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.yaml
>> index 911a5996e099..588be73168fa 100644
>> --- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.yaml
>> @@ -41,7 +41,7 @@ additionalProperties: false
>>  examples:
>>    - |
>>      #include <dt-bindings/gpio/gpio.h>
>> -    sdhci0_pwrseq {
>> +    pwrseq {
> 
> [applicable for all 3 examples]
> 
> hmm, power-sequences are not necessarily tied to an address and I guess
> it will be very much a common case to have multiple ones on a system.
> 
> So might it be better to follow other patterns (like leds) to number them
> or suggest a "foo-pwrseq" / "pwrseq-foo"?

In such cases one can add number or descriptive suffix (pwrseq-0,
pwrseq-foo), just like we do for regulators. However the examples have
here only one node and in such case "pwrseq" is enough.

Best regards,
Krzysztof

