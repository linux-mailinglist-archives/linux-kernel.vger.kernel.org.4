Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FB56043BE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiJSLrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbiJSLqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:46:55 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24A819E011
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 04:26:21 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r13so28387770wrj.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 04:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nXFGzSS2/u4bVAOtY2OBuez9ms3I4wdkLTeUoseOY3A=;
        b=dAwR0NuwlhUCkeBGQ6sh1KnbolBlC0LAC8xBMz3KtBC/YA7DtkI/75dUzKhfABYoom
         1F29QCCJDyyv+oypS5Q5HFIZOQNSuQKQ4piod2wBha4ZeUBgM48TzD5ThK0h0BkhezNU
         PPvBXURYF7ZhVtKZ2auhrbnW+kCQX9YH/YMA+3g38rm1DR6n5H2mVl0739mUr8a9cD9c
         lVv5PT/D3VkyWmo5RyY1K0fdMQsDmr3/bxK1O0JIEwJUhG4tu3D4c07HN5ZBm+EUvIjY
         k0fTnJ75ht8At1VXZANo36FPJ/BUUI7E4NEh3QjnekedsnJp64CKp4vs10F7ejxqNGoG
         4jjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nXFGzSS2/u4bVAOtY2OBuez9ms3I4wdkLTeUoseOY3A=;
        b=UH1tjBXKo7NZewr+Dp26JuOIk2Fq5WmjMszPYM5xaPjH2EGqRkhPFKu0Zk25j/NtjX
         NAbuDT2BD43PXitKvhCLSVrmqs7HFN8OE2EoVcanYUdugBhRiPDXEMxGV/U7neQs1qWc
         90FNzIB6a3ewMXFn3GYKbb4hYiMySUkoBO7OX5BzMd0VtDPWBYouY02BMpv4/WV3F8NE
         Y9hU+KmawLD/CTMTJQOGBk6JluGXjFOnZXYU2Bm2LoyTeYw57qh9A2P5vfNsXNY9y2kM
         UHc0hPZbDRAvYnIrKQ27gFH1BQQ7xwE3JwDNtmKzt4vqRuGDPBkH+/BVU0ru6kex52O3
         lLAQ==
X-Gm-Message-State: ACrzQf1Rcl4OHL+thap4XiNdRNPJEXLKpRsQcDMlNd5Qx7lJmlksWrww
        X8SLDVvVGFY1yx/4RE2SZxqI958LvBzqLFnT
X-Google-Smtp-Source: AMsMyM6R+x5K/qnLw6cpJ0EZKFwazhL6E5XYy0THkjOXdiu8+PRsamzUWkh2rEIb+FAD6dQLyr2RWQ==
X-Received: by 2002:a05:6000:1568:b0:22e:6691:57aa with SMTP id 8-20020a056000156800b0022e669157aamr4569795wrz.708.1666177740730;
        Wed, 19 Oct 2022 04:09:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b15b:4b56:592a:c397? ([2a01:e0a:982:cbb0:b15b:4b56:592a:c397])
        by smtp.gmail.com with ESMTPSA id e26-20020a05600c4b9a00b003a5537bb2besm15694485wmp.25.2022.10.19.04.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 04:09:00 -0700 (PDT)
Message-ID: <402500e8-b4fe-9b8f-d634-e329191af1b8@linaro.org>
Date:   Wed, 19 Oct 2022 13:08:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: dts: meson: Enable active coling using gpio-fan on
 Odroid N2/N2+
Content-Language: en-US
To:     Anand Moon <linux.amoon@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221018195122.8877-1-linux.amoon@gmail.com>
 <CAFBinCCqXBk9Xq0k=NA3zGi8spwyPQN7dMVWcjE+pXkXYf+FKQ@mail.gmail.com>
 <CANAwSgSR6jHRQR6QgzUop_B4gcOsQnfc6LoUXrP0CSTasZkVfQ@mail.gmail.com>
 <CANAwSgRLZfon5qUFeKW9U9AbHvSa=uKVaVgqghVk554-H1LVKw@mail.gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <CANAwSgRLZfon5qUFeKW9U9AbHvSa=uKVaVgqghVk554-H1LVKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On 19/10/2022 11:48, Anand Moon wrote:
> Hi Martin,
> 
> On Wed, 19 Oct 2022 at 08:36, Anand Moon <linux.amoon@gmail.com> wrote:
>>
>> Hi Martin,
>>
>> On Wed, 19 Oct 2022 at 02:46, Martin Blumenstingl
>> <martin.blumenstingl@googlemail.com> wrote:
>>>
>>> Hello Anand,
>>>
>>> On Tue, Oct 18, 2022 at 9:53 PM Anand Moon <linux.amoon@gmail.com> wrote:
>>>>
>>>> Odroid N2/N2+ support active cooling via gpio-fan controller.
>>>> Add fan controls and tip point for cpu and ddr thermal sensor
>>>> on this boards.
>>> In the schematics for board rev 0.6 [0] I cannot find any information
>>> about a fan connector.
>>> The schematics for board rev 0.3 [1] on the other hand document a PWM
>>> based fan connector on page 16.
>>> So now I am not sure whether your patch only applies to certain board
>>> revisions, the schematics are incorrect, etc.
>>>
>>> Can you please provide some details about the fan connector on
>>> Odroid-N2/N2+ and which hardware revisions are supported (and which
>>> aren't) by your patch?
>>>
>>>
>> Ok I got this wrong the schematics below there is pwm controller, not
>> gpio controller
>> GPIOAO.BIT10 (PWM)
>> I will correct the patch sorry for the mistake I did not look more carefully.
>>
> 
> As per the schematics GPIOAO_10 is controlled by PWMAO_D
> But looking into the datasheet [0] I could not find the relevant
> PWMAO_D pmw ip block to link the fan to the PWM controller.
> 
> [0] https://dn.odroid.com/S922X/ODROID-N2/Datasheet/S922X_Public_Datasheet_V0.2.pdf
> 
> I could get the PWM node but is not working for me.
> 
> @@ -547,6 +588,14 @@ &pwm_ab {
>          status = "okay";
>   };
> 
> +&pwm_AO_ab {

&pwm_AO_cd not _ab

> +       pinctrl-1 = <&pwm_ao_d_10_pins>;
> +       pinctrl-names = "default";
> +       clocks = <&xtal>;
> +       clock-names = "clkin0";
> +       status = "okay";
> +};
> +
> 
> Thanks
> -Anand
> 
> 
>>> Thank you!
>>> Martin
>>>
>>>
>>> [0] https://dn.odroid.com/S922X/ODROID-N2/Schematic/odroid-n2_rev0.6_20210121.pdf
>>> [1] https://dn.odroid.com/S922X/ODROID-N2/Schematic/odroid-n2_rev0.3_20190117.pdf
>> Thanks
>> -Anand

Neil

