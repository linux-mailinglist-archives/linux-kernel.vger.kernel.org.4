Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E3E6D0CA6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbjC3RWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjC3RWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:22:15 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59B7E06A;
        Thu, 30 Mar 2023 10:22:10 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id t17-20020a05600c451100b003edc906aeeaso3544373wmo.1;
        Thu, 30 Mar 2023 10:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680196929;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ub/AQVZfAChA/d+KSB5lldfEy26j6LKXVDj7xODNFoM=;
        b=KLiv+Q7hqzdXpK0fgRBj67KNAUOqJoWJnE1LMeZ8IfLHVgdlV6kLwIuXuxWSDpUWse
         hMHaXiRocH3o8cU6G6DRwHksPLdzpPhjypTQtwojIQ7pwuCp75wpopMCg106el5i2qp0
         bkelgS1rvpqBd7PuNgpPc7o8M1Fl8jy4czasiaq1CLsC0oRxgc194CrnXs3miihYZmaR
         2/7BpBIwHW99VjxF6goFddcsgKc75BjsVAOwYFyGxVE5a3Aj0ytTDFebONzL/Z/FWUb8
         tFQ0Z92vNGSFNvQMT8Ny/BsLElNOtA85GrZ4XV3rqfA68BUKRmXmVlMK5LTLPVhC7axL
         ysHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680196929;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ub/AQVZfAChA/d+KSB5lldfEy26j6LKXVDj7xODNFoM=;
        b=HVAGOuZQVy4Jtit1uyAGxidgs0qaVijiiVvsLIbQ52lQe/As4ojoSzCLSEs80PUBw0
         yMu/ZNhvcmAQTY5NwsiZ20FLGhFDtf3S8/qbj88nVP7y9wGtnpS/e4YGMneRkryHEA4k
         3/3S2kCtbU9bQvTi5cA0pDLY/1TXO3Oy7YvSsTv0uSjCXMU6PktBjGhuOULKEhXyuKTF
         Yv6Dp04lDWIHYB1iF8bhEgsRGDl6TRapfGm5YFnB9+FysVJnYdn3MbWgy4wJomtDANSk
         CopbKP+Pa3Mnex7DuNbqD1pqbL/PQBooNM7p7F90C5qNXRWIBXl3ESTGC4G0l04XcPcf
         1PQA==
X-Gm-Message-State: AO0yUKUh+SR2SyGbze/lJSc+TxLtCe/FizQ/AfzAzvYZtjKDCQCvBT0I
        87JViPbCP9IWvtl0/htwXsQ=
X-Google-Smtp-Source: AK7set+Z7z1kVsT/1a8sP5GsrmavnXRm3sG7+NJ+W+MACV28utX/L4C5aZ+aBDDLru+8Dt00emmWtA==
X-Received: by 2002:a7b:c381:0:b0:3ed:4627:ed09 with SMTP id s1-20020a7bc381000000b003ed4627ed09mr18130818wmj.28.1680196929078;
        Thu, 30 Mar 2023 10:22:09 -0700 (PDT)
Received: from [192.168.1.135] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c358600b003ef6708bc1esm7079233wmq.43.2023.03.30.10.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 10:22:07 -0700 (PDT)
Message-ID: <5291a565-acdd-a4aa-9f33-ec6f254a0ab1@gmail.com>
Date:   Thu, 30 Mar 2023 19:22:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 05/17] arm64: dts: mediatek: add mt6357 device-tree
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, amergnat@baylibre.com,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
References: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
 <20230203-evk-board-support-v3-5-0003e80e0095@baylibre.com>
 <889be563-78d6-7148-f7d2-09ae21383ee4@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <889be563-78d6-7148-f7d2-09ae21383ee4@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/03/2023 15:17, AngeloGioacchino Del Regno wrote:
> Il 29/03/23 10:54, amergnat@baylibre.com ha scritto:
>> From: Fabien Parent <fparent@baylibre.com>
>>
>> This new device-tree add the regulators, rtc and keys support
>> for the MT6357 PMIC.
>>
>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt6357.dtsi | 282 +++++++++++++++++++++++++++++++
>>   1 file changed, 282 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt6357.dtsi 
>> b/arch/arm64/boot/dts/mediatek/mt6357.dtsi
>> new file mode 100644
>> index 000000000000..3330a03c2f74
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/mediatek/mt6357.dtsi
>> @@ -0,0 +1,282 @@
> 
> ..snip..
> 
>> +
>> +        keys {
>> +            compatible = "mediatek,mt6357-keys";
>> +
>> +            key-power {
>> +                linux,keycodes = <KEY_POWER>;
>> +                wakeup-source;
>> +            };
>> +
>> +            key-home {
>> +                linux,keycodes = <KEY_HOME>;
>> +                wakeup-source;
> 
> KEY_HOME is a wakeup-source?! are you sure?!

I think it could make sense to do that, so I just queued the patch. If that was 
an oversight, then please send a follow-up patch.

Regards,
Matthias

> 
> (P.S.: I'm just checking if that was intended)
> 
> Regards,
> Angelo
