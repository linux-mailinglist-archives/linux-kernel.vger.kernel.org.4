Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF070621BE3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiKHS2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiKHS2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:28:09 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842C050F2C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 10:28:07 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id a15so22376568ljb.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 10:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hHKr619QPayYxsSRYbswMzokC2JQ4Oi/Wq2gqRIuOvM=;
        b=PVmG5m8jAq2xwxpCSN2uSale2A+FhaQo5+RlVsuw/VPlmvJ++fN3FbObkhywrsVrhq
         2OOpuQTtFoO/wqwno+MccxXfMk0Vp0oXmprXPKDWQVE1Rr47knMPpFqkRPB0qp+9izt5
         eciwb3kGckOkI7G5Sd6QX7WlMzfizvLq78Ywi1x9k02ZPuBGIDZ37rvU35Mnnpy+MJbc
         b+OaPaSKLq+Ocya6nO3G5y5ufYCbQdpUPKwhNcTE0RKtDz6fBfuWpn9l6Da6yFIBFv28
         ANwo376m1jRFaBW9vIrnFuYnX4G4Am4tLwB1JUBT6ROnvQfW9Qm0moglQcRCrc/vtJcM
         994w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hHKr619QPayYxsSRYbswMzokC2JQ4Oi/Wq2gqRIuOvM=;
        b=4pr4O1AFjzx+iQQSfw0plArjFMBRqLZ402YCf0nq/o470GtGaNPLkCYx2a0IjoYOlF
         n9T2YKXCAQbseH/QpNQO4+rdBNxjZEWTTnTIakbcKWlsF3gdAoNtjN322ZKcF4UWuVwg
         ELHzu5SaR7FKPzRAskZWmuPN7lmoDdq7LffSdSSPq39G6xM1xnBnjN3RxJCSlxjF53Yd
         MOoPAn+bMeq70bo2Tv/F/NYMNBEgvMlx5PmrGLwAgmLBBipSL7GUQb5X8RnOS7/VokCE
         ZyHqNSeBpg/Xng+lqddfmU7qOz2xlDwG12XOPJustGh98fkZ/lLymK3L11nfwc2l+uw5
         bjBA==
X-Gm-Message-State: ACrzQf1XJzuS0ZmZluXM0+8skXNVd4Z5WpMqxLrPy9T5N94lYcI4XcbI
        r5fvipG4/weVGWZwSyjKSLVi2w==
X-Google-Smtp-Source: AMsMyM5Nym6RZ34g67gWCqGyki2McZepT8/2ocl0CW4TUh1qgTO+dZr2F897iV+DpfibrKwv+Ei9vQ==
X-Received: by 2002:a2e:a106:0:b0:277:3d6:a751 with SMTP id s6-20020a2ea106000000b0027703d6a751mr20209408ljl.201.1667932085827;
        Tue, 08 Nov 2022 10:28:05 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id w1-20020a19c501000000b004b177293a8dsm1870138lfe.210.2022.11.08.10.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 10:28:05 -0800 (PST)
Message-ID: <2326682f-3b2b-0a2e-0601-2d79390ab92a@linaro.org>
Date:   Tue, 8 Nov 2022 19:28:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: Add support for
 phyBOARD-Electra-AM642
Content-Language: en-US
To:     Wadim Egorov <W.Egorov@phytec.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "upstream@phytec.de" <upstream@phytec.de>, "nm@ti.com" <nm@ti.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "kristo@kernel.org" <kristo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
References: <20221108175050.285340-1-w.egorov@phytec.de>
 <20221108175050.285340-2-w.egorov@phytec.de>
 <414f8281-80ba-dd2c-e5f9-9e9cde1ad1e0@linaro.org>
 <4963de6e-275b-e1d2-859c-7c7364b4599b@phytec.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4963de6e-275b-e1d2-859c-7c7364b4599b@phytec.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2022 19:25, Wadim Egorov wrote:
> 
>>> +	leds {
>>> +		compatible = "gpio-leds";
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&user_leds_pins_default>;
>>> +
>>> +		led-1 {
>>> +			color = <LED_COLOR_ID_RED>;
>>> +			gpios = <&main_gpio0 15 GPIO_ACTIVE_HIGH>;
>>> +			linux,default-trigger = "mmc0";
>>> +			function = LED_FUNCTION_DISK;
>>> +		};
>>> +
>>> +		led-2 {
>>> +			color = <LED_COLOR_ID_GREEN>;
>>> +			gpios = <&main_gpio0 16 GPIO_ACTIVE_HIGH>;
>>> +			linux,default-trigger = "mmc1";
>>> +			function = LED_FUNCTION_DISK;
>>> +		};
>>> +	};
>>> +
>>> +	vcc_3v3_mmc: regulator-sd {
>> This is a friendly reminder during the review process.
>>
>> It seems my previous comments were not fully addressed. Maybe my
>> feedback got lost between the quotes, maybe you just forgot to apply it.
>> Please go back to the previous discussion and either implement all
>> requested changes or keep discussing them.
> 
> But what is wrong with the "regulator-sd" node name?

Uh, you are right, this is correct, my eyes are playing tricks on me...

Best regards,
Krzysztof

