Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FE86CBB2C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjC1Jh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjC1JhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:37:11 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98556A71
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:36:43 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j24so11480497wrd.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679996202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XQV5jAujDsjlmJ7i4zzoeSJ8msTMIxUMBP2P8RrksF8=;
        b=Mig5vyIslkZvEXRrGtnwNDJ79tHpngfDxYk99Sqqz63WsvDJV6ZCXlLQWmKNLfO8H8
         2FFB/dIPxmrnuorZKOlXk168FTqEzjMfV2cYS/GntQADcvY2y50Su0U+3+zBlPzeQRoH
         B3LwTgwGUSoekmwy9sWGdWUvU0QrIYCdAV3hAen5URjiP1YLl4lnrS8RpYe3TBR+xfkk
         GjXj+EZJH6xAr1nNQDpgzzHa/3fhOBI55ZEsFA5MONcVQs1XA7IGDwbzJUtlBXeYf16B
         BFHQcmXCO0zxSpGBxmsEK2vWjevflJAX/amSeJlJ4L047/GZgTuuPAnRuNRg13LcwONs
         k4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679996202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XQV5jAujDsjlmJ7i4zzoeSJ8msTMIxUMBP2P8RrksF8=;
        b=e9FBB0dXn+ubmehs4UIowpy9MN0BMBGdQgNF0nlVQze4I3s9EwGxxmOSGOL62Zs7vK
         eaDzYcVBOLxYmnrcHR7utoxMl3YqJcMBOsLDz2Kdk8cHJ3ecggakUHAhC8jAGgz2UceF
         6zpdFjCkBx8hmO8W609uqrwPHd5B0Qa9VMZHOWJgiFK0Czh/1RalhFME9GHY8+Gvkw6+
         jc9VUTHfnBinFp9ChNcIvXLMQnDU9li5HcB5U7tj/PHomlNPRerAUhwSVHzgeySM7kpT
         mzREhrZHEog+rKK+ilsr9X09QKakKwCaatqh5Ib5Z+yaMArqqSf+vbUl0FBsccmKKl+J
         n0Kg==
X-Gm-Message-State: AAQBX9crvccKuoVczrwGJ+QrU7TLBqcnLUr2m/UCODQK0RZ9zabxTnNQ
        RDtl532jbu+pVbKf5kmCxxyRmw==
X-Google-Smtp-Source: AKy350a+LASx+WRjrECQYarn1n17idhSsDraP6ddv/ReLQYmMPK4bvDvhWHQ4zmmyRarSWf+n10QFg==
X-Received: by 2002:adf:f78b:0:b0:2ce:aed4:7f22 with SMTP id q11-20020adff78b000000b002ceaed47f22mr12920141wrp.50.1679996202349;
        Tue, 28 Mar 2023 02:36:42 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.91])
        by smtp.gmail.com with ESMTPSA id n12-20020adfe34c000000b002da75c5e143sm14794062wrj.29.2023.03.28.02.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 02:36:42 -0700 (PDT)
Message-ID: <4b8b629b-62f8-8e0d-5de2-9020a955f0e2@linaro.org>
Date:   Tue, 28 Mar 2023 10:36:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 5/8] ARM: dts: at91-sama5d27_wlsom1: Set sst26vf064b SPI
 NOR flash at its maximum frequency
Content-Language: en-US
To:     Nicolas Ferre <nicolas.ferre@microchip.com>, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org
References: <20221117105249.115649-1-tudor.ambarus@microchip.com>
 <20221117105249.115649-6-tudor.ambarus@microchip.com>
 <a6fe77b6-4ff4-3c91-0c67-a9da5a638e7b@microchip.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <a6fe77b6-4ff4-3c91-0c67-a9da5a638e7b@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/28/23 09:51, Nicolas Ferre wrote:
> Hi Tudor,

Hi!

> 
> On 17/11/2022 at 11:52, Tudor Ambarus wrote:
>> sama5d27-wlsom1 populates an sst26vf064b SPI NOR flash. Its maximum
>> operating frequency for 2.7-3.6V is 104 MHz. As the flash is operated
>> at 3.3V, increase its maximum supported frequency to 104MHz. The
>> increasing of the spi-max-frequency value requires the setting of the
>> "CE# Not Active Hold Time", thus set the spi-cs-setup-ns to a value of 7.
>>
>> The sst26vf064b datasheet specifies just a minimum value for the
>> "CE# Not Active Hold Time" and it advertises it to 5 ns. There's no
>> maximum time specified. I determined experimentally that 5 ns for the
>> spi-cs-setup-ns is not enough when the flash is operated close to its
>> maximum frequency and tests showed that 7 ns is just fine, so set the
>> spi-cs-setup-ns dt property to 7.
>>
>> With the increase of frequency the reads are now faster with ~37%.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>> ---
>>   arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
>> b/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
>> index 83bcf9fe0152..20caf40b4755 100644
>> --- a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
>> +++ b/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
>> @@ -220,7 +220,8 @@ qspi1_flash: flash@0 {
>>           #size-cells = <1>;
>>           compatible = "jedec,spi-nor";
>>           reg = <0>;
>> -        spi-max-frequency = <80000000>;
>> +        spi-max-frequency = <104000000>;
>> +        spi-cs-setup-ns = /bits/ 16 <7>;
> 
> Following the different changes that happened to this property after
> this post, am I right saying that this must now be changed to:
> 
> spi-cs-setup-delay-ns = <7>;
> 
> ?
> 

Yes, that should do it. I'm amending the series right now. Can you do a
little test on your side so that we make sure everything is in place?
After the update, something like that should be run on any board (maybe
wlsom1-ek?):
#!/bin/sh

dd if=/dev/urandom of=./qspi_test bs=1M count=6
mtd_debug write /dev/mtd5 0 6291456 qspi_test
mtd_debug erase /dev/mtd5 0 6291456
mtd_debug read /dev/mtd5 0 6291456 qspi_read
hexdump qspi_read
mtd_debug write /dev/mtd5 0 6291456 qspi_test
mtd_debug read /dev/mtd5 0 6291456 qspi_read
sha1sum qspi_test qspi_read

brb,
ta
