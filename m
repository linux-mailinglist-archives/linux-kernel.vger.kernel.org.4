Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73946D0CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjC3RbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbjC3RbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:31:06 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B008DBD1;
        Thu, 30 Mar 2023 10:31:03 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so12300744wmq.3;
        Thu, 30 Mar 2023 10:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680197461;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hVxoqrhc3yrtGubZ0RHjnJ/hxiODwV3KHU0a9jTWrR8=;
        b=fJbwrNSH8a/qPjoFa8TTfzC4kyyATGF1Sz673IqjXu8HgDpeMUNr+lyW9bY6JAUGLE
         EId0OhaO/7JG1wZareEy+SxWAjWvLr/cH0w85cZZ698VBJ76M5PYqmuXi+5SZbdFa03h
         LT4WNwKHNta2j511KzE1u3mQ3mV5jaK29QRJMTCaUdnoA5ocXzZMHzTVsKJg8x3RLnoo
         F6frH37WQnAJrkPStf7B7pbvejEcWWoMm0ndnhmHnoiZWuuzOQrTZ4j/IqkUEEHyqVYN
         76/CA0bADuwpIfTDV2DpL20N6EmIRed/h3HMVC/eO4l38NrRpDrslA++UbDKHmzXiixO
         D68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680197461;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hVxoqrhc3yrtGubZ0RHjnJ/hxiODwV3KHU0a9jTWrR8=;
        b=CDcpd4MXGJE3d4qyME073j9N6cgaE4geMOJEuoZpcUwVaheLiNyMxQN8pPy+BeVDKb
         XCJjrrUEcAiarXEoAMxurJIsANge507GJoGxcWWymkdc8gQMVoikGysZdyuOOv1qgITf
         kW1J+UOKW7Wl7uCOfxcK//46B0Z5qc18mdzPwfP6fcAvJJgu49GArICKo19nYP6NdGj4
         FodyE94Hmxj4nElDwY205a27FAhoLvfQMvk+IF5uye7EY0+TPo/SCy0hLhUltl8dH19+
         1U8mHnlCF5hsZn8083D6ezXcbTFsB/j+Enq5vWSG0eRK6MmCV1EVoFotZGb9J3AjQuBS
         N4XA==
X-Gm-Message-State: AAQBX9dvHEn6c39UVquxchAgkPYwGftyvfyTBxJ71a0TfFtGKkSuzNMJ
        p6gOg0Gz3ryUWE+4YX/jpUk=
X-Google-Smtp-Source: AKy350ZbVWPX16B0VmtNoa+uELKUsvvda6aqmDybw6P4+CSguTo5raie1R2mhEBS+W4lPD3qEOepew==
X-Received: by 2002:a1c:7406:0:b0:3da:2ba4:b97 with SMTP id p6-20020a1c7406000000b003da2ba40b97mr4684708wmc.19.1680197461365;
        Thu, 30 Mar 2023 10:31:01 -0700 (PDT)
Received: from [192.168.1.135] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id r16-20020a05600c35d000b003ee9f396dcesm6948932wmq.30.2023.03.30.10.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 10:31:00 -0700 (PDT)
Message-ID: <395a1fbf-4d97-930b-5dca-33f14b337837@gmail.com>
Date:   Thu, 30 Mar 2023 19:30:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 11/17] arm64: dts: mediatek: add usb controller support
 for mt8365-evk
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
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
 <20230203-evk-board-support-v3-11-0003e80e0095@baylibre.com>
 <5b213d2f-4694-5548-9cce-f01dacda9c84@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <5b213d2f-4694-5548-9cce-f01dacda9c84@collabora.com>
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



On 29/03/2023 15:26, AngeloGioacchino Del Regno wrote:
> Il 29/03/23 10:54, Alexandre Mergnat ha scritto:
>> This patch add support for SuperSpeed USB, in OTG mode, on micro connector.
>> It also add support for the Extensible Host Controller Interface USB.
>>
>> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts 
>> b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
>> index 22ec332fe9c9..868ee0d160e4 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
>> @@ -319,6 +319,28 @@ &pwm {
>>       status = "okay";
>>   };
>> +&ssusb {
>> +    pinctrl-0 = <&usb_pins>;
>> +    pinctrl-names = "default";
>> +    maximum-speed = "high-speed";
>> +    usb-role-switch;
>> +    dr_mode = "otg";
>> +    vusb33-supply = <&mt6357_vusb33_reg>;
>> +    status = "okay";
> 
> Order by name please.
> 
> P.S.: status can go at the bottom, even if v < s :-)

You mean v > s ;-)

Yes please reorder keep the status to the bottom that's somehow identical 
throughout the kernel.

Regards,
Matthias

> 
> Thanks,
> Angelo
