Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408236407C9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 14:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbiLBNiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 08:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbiLBNh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 08:37:57 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B414D2228F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 05:37:55 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso4898368wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 05:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QlnSVyeNJBQ8zK66UIaHiEDYVNMWbpzHfG8l8D5rLsg=;
        b=N45ciQYnHxOkUVsrs81RcyjRL8lTXLnrCIzyNfU4Mg6zbWfU49CRo+PqHjsVIKBoXT
         o67vBMVFPcjPEa6uLCxzEX/3nODc9VzaI2/0L5ZMoLgVx3/YYyxlkt9BbeKrivOgIBY9
         FrN1XaYYbW7ryAFxm7WhDYKRVhyCrDVpgxu0a91ruf/k4f8k3qqQ6Pkn7kiVFWJnJmzk
         tlg+xqNuv845UMmYNayu9JRIWC9zUioWCeVpdjHEryy2gimAcMFW4riHu7L1HrLQWg92
         rXvkQYqvR7jcYjdubRJOF/X9nI0GamMU0015SCD1QWjXOs3aExEUAhg+DYFWWqApo4MP
         OuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QlnSVyeNJBQ8zK66UIaHiEDYVNMWbpzHfG8l8D5rLsg=;
        b=fHc0MJqdjsJA97RM1EyrnzRELJXqEOBTmmbIDq5krk5S0fxQxIMv/d2TTP1cgwGxZt
         54RAXooHHycIMyyUWvVm6yP18W5vi/ltYnatHJk/JGus87/fQb5drHC7YDLXWB5LlM8z
         HwdwALplk65czFiQqwZfIXHkTD02kRbQzizujAm4EGy72dlvqj4FicBTTWoR/YtWqCa2
         vwaLjJWtoZ1FlWif2VwA2HfM28B7PBF4CO/MVNJklr2qkHhNsIM+T/snOsX0CVwF8AVn
         hH3ehGaCx7VCN7qiU8oSLEP6dkaQdh+d7BJHs1UP/xVm5R6buip0q6xO+kQvGFNMUTkR
         unIw==
X-Gm-Message-State: ANoB5pkJtoGRqKXs3gUjFNws28olWIviflhy17i1M9HD14SPCjxo2MvB
        pmq8vNNYdyKCqcwfeNbVYLHHxA==
X-Google-Smtp-Source: AA0mqf6OqpNKEm+sXTPS3e9MaetKH8+YfTL0xVUNaCagbT7KYStNnsov4FfzoOxwxySoBKlrDnQTTQ==
X-Received: by 2002:a05:600c:3108:b0:3cf:8058:43b8 with SMTP id g8-20020a05600c310800b003cf805843b8mr39657323wmo.95.1669988274183;
        Fri, 02 Dec 2022 05:37:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:c6e:eb0:b551:55ee? ([2a01:e0a:982:cbb0:c6e:eb0:b551:55ee])
        by smtp.gmail.com with ESMTPSA id q128-20020a1c4386000000b003c71358a42dsm16811398wma.18.2022.12.02.05.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 05:37:53 -0800 (PST)
Message-ID: <10ac1cc2-a4cc-3d00-9d6a-550f2d5e4d9d@linaro.org>
Date:   Fri, 2 Dec 2022 14:37:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v8 11/11] arm64: dts: meson: a1: introduce PLL and
 Peripherals clk controllers
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     jian.hu@amlogic.com, kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
 <20221201225703.6507-12-ddrokosov@sberdevices.ru>
 <1jlenq6mc7.fsf@starbuckisacylon.baylibre.com>
Organization: Linaro Developer Services
In-Reply-To: <1jlenq6mc7.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2022 13:03, Jerome Brunet wrote:
> 
> On Fri 02 Dec 2022 at 01:57, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> 
>> This patch adds clkc_periphs and clkc_pll dts nodes to A1 SoC main dtsi.
>> The first one clk controller is responsible for all SoC peripherals
>> clocks excluding audio clocks. The second one clk controller is used by
>> A1 SoC PLLs. Actually, there are two different APB heads, so we have two
>> different drivers.
> 
> Please send this change through a separate patcheset.
> 
> One patcheset/series for clk (and bindings)
> Another one for the DTS (usually sent after the first one is accepted)

Yes please split out the DT in a separate patchset, but only send then once
the bindings are fully reviewed and accepted.

Start from v1 for the DT patchset, no need to continue the current numbering.

Thanks,
Neil

> 
>>
>> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
>> ---
>>   arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 27 ++++++++++++++++++++++-
>>   1 file changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
>> index b4000cf65a9a..38e6517c603c 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
>> @@ -6,6 +6,8 @@
>>   #include <dt-bindings/interrupt-controller/irq.h>
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/gpio/meson-a1-gpio.h>
>> +#include <dt-bindings/clock/a1-pll-clkc.h>
>> +#include <dt-bindings/clock/a1-clkc.h>
>>   
>>   / {
>>   	compatible = "amlogic,a1";
>> @@ -81,7 +83,6 @@ apb: bus@fe000000 {
>>   			#size-cells = <2>;
>>   			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x1000000>;
>>   
>> -
>>   			reset: reset-controller@0 {
>>   				compatible = "amlogic,meson-a1-reset";
>>   				reg = <0x0 0x0 0x0 0x8c>;
>> @@ -124,6 +125,30 @@ uart_AO_B: serial@2000 {
>>   				clock-names = "xtal", "pclk", "baud";
>>   				status = "disabled";
>>   			};
>> +
>> +			clkc_periphs: periphs-clock-controller@800 {
> 
> device name should be generic so
> 
> clkc_periphs: clock-controller@800 would be better
> 
>> +				compatible = "amlogic,a1-periphs-clkc";
>> +				reg = <0 0x800 0 0x104>;
>> +				#clock-cells = <1>;
>> +				clocks = <&clkc_pll CLKID_FCLK_DIV2>,
>> +					 <&clkc_pll CLKID_FCLK_DIV3>,
>> +					 <&clkc_pll CLKID_FCLK_DIV5>,
>> +					 <&clkc_pll CLKID_FCLK_DIV7>,
>> +					 <&clkc_pll CLKID_HIFI_PLL>,
>> +					 <&xtal>;
>> +				clock-names = "fclk_div2", "fclk_div3",
>> +					      "fclk_div5", "fclk_div7",
>> +					      "hifi_pll", "xtal";
>> +			};
>> +
>> +			clkc_pll: pll-clock-controller@7c80 {
> 
> Same here
> 
>> +				compatible = "amlogic,a1-pll-clkc";
>> +				reg = <0 0x7c80 0 0x18c>;
>> +				#clock-cells = <1>;
>> +				clocks = <&clkc_periphs CLKID_XTAL_FIXPLL>,
>> +					 <&clkc_periphs CLKID_XTAL_HIFIPLL>;
>> +				clock-names = "xtal_fixpll", "xtal_hifipll";
>> +			};
>>   		};
>>   
>>   		gic: interrupt-controller@ff901000 {
> 

