Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7695C662459
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 12:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjAILis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 06:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbjAILin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 06:38:43 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491E53B0
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 03:38:41 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id i17-20020a05600c355100b003d99434b1cfso6445012wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 03:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uWRQwZU7Q5uXmRpQpJb8/BTaeDI/2pDdqBknaeuYMoc=;
        b=y1NBPAWB/5QSk15IQF0sayDsBGK9DTwzo64Fwhce+Wv3f7tVbPw++Vm7KjFJ/ePuIH
         alZSxq4wMtI3JYRZn3zmZrqmW5U+tcE/36mSZS+ao+PBouUNXkLt8uMAN3EDUZoM8y1Z
         V38rcAlr6k9TL1waTrhaRP8dMZcyQgFxWY3TRRWCtw3tASJlyK9l3O/MWYqVGJgAknVC
         jyzHq/yTgZ5C7OdYW+njoDU4LjZ+sYY1fS9XGuRSIkUPXzN3ekBZA31uKMfMGcdTnJze
         j7zyR4Zp7HBcTCJS529n0Jvj5PuGWJpqpZXzP6IkeqqXkPlbC7aVB/jHNAVTFf8RXMND
         S+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uWRQwZU7Q5uXmRpQpJb8/BTaeDI/2pDdqBknaeuYMoc=;
        b=wDlpxTxIjVgtvDmwFgO3XQq4pjIqHIdIBvMaq25YyYvBkcA04MfBjl7DxEkH0uAXIV
         WaRgKNyDv9Vv2y3GLv/onsg9hC6MXZ69SWvRejj4D643AJSsIACkFmpSz9qRdToJfark
         izA5O+HkQZ4oHXUEEVxLJE2uUpAjBBbrqoi+LLWl/wfbGRrHFQJBjCebrjthcYug373S
         P+PbuXVBdjxFCOLDQCaghk3mNvddZNkfz/wb4WuDJdJ5mVGna0EpCPrwaqF1qh0Q4LU7
         ZWKAYmIHTnzm8y6aKeoDfzea1FyFhZuG01rwCbnz7C+v0IjjFRNHkUME77MJYnBUsQnO
         z9SA==
X-Gm-Message-State: AFqh2kqQRgJDi9vlXeE7tCMMPjZOumqJ3hV2kTk2bHyZjJkneQwMXT+z
        MmAfOR9YV8qWqISqbp6bVJTbyw==
X-Google-Smtp-Source: AMrXdXsgKZSO61ZWkew6Daa4r2uBx8Xe/DlWi/W5u/PDxgxQsVfDr2oBgtSbr4LJo3JD2nU14fQRlg==
X-Received: by 2002:a05:600c:1f12:b0:3cf:8155:2adc with SMTP id bd18-20020a05600c1f1200b003cf81552adcmr47185923wmb.33.1673264319841;
        Mon, 09 Jan 2023 03:38:39 -0800 (PST)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id r126-20020a1c2b84000000b003d35c845cbbsm15439361wmr.21.2023.01.09.03.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 03:38:39 -0800 (PST)
Message-ID: <6c784b12-ea81-2ac9-ff99-e33f5c123483@linaro.org>
Date:   Mon, 9 Jan 2023 12:38:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 03/12] dt-bindings: nvmem: convert
 amlogic-meson-mx-efuse.txt to dt-schema
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Eric Dumazet <edumazet@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
References: <20221117-b4-amlogic-bindings-convert-v1-0-3f025599b968@linaro.org>
 <20221117-b4-amlogic-bindings-convert-v1-3-3f025599b968@linaro.org>
 <CAFBinCANM=AOw1bbGCheFy20mqQ1ym_maK0C1sYpjceoNH-dNQ@mail.gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <CAFBinCANM=AOw1bbGCheFy20mqQ1ym_maK0C1sYpjceoNH-dNQ@mail.gmail.com>
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

On 26/11/2022 00:04, Martin Blumenstingl wrote:
> Hi Neil,
> 
> thanks for your work on this!
> 
> On Fri, Nov 18, 2022 at 3:33 PM Neil Armstrong
> <neil.armstrong@linaro.org> wrote:
> [...]
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +
>> +        sn: sn@14 {
>> +            reg = <0x14 0x10>;
>> +        };
>> +
>> +        eth_mac: mac@34 {
>> +            reg = <0x34 0x10>;
>> +        };
>> +
>> +        bid: bid@46 {
>> +            reg = <0x46 0x30>;
>> +        };
> I assume you took these examples from the newer, GX eFuse?
> Unfortunately on boards with these older SoCs the serial number and
> MAC address are often not stored in the eFuse.
> This is just an example, so I won't be sad if we keep them. To avoid
> confusion I suggest switching to different examples:
>    ethernet_mac_address: mac@1b4 {
>      reg = <0x1b4 0x6>;
>    };
>    temperature_calib: calib@1f4 {
>       reg = <0x1f4 0x4>;
>    };
> 
> What do you think?


Sure switched to it !

Neil
> 
> 
> Best regards,
> Martin

