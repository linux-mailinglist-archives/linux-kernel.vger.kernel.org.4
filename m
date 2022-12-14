Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AEF64CE25
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 17:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238908AbiLNQgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 11:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239092AbiLNQfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:35:41 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4871B17A91;
        Wed, 14 Dec 2022 08:35:13 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1442977d77dso17291147fac.6;
        Wed, 14 Dec 2022 08:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=P7BkHVo7lr7IoLxj4xozJR7ZfwY1TDrJJZ/qfyWx7lo=;
        b=ZPJNEtQ9wJ+DV4Dw4CjmW5qiwP8u2MNp2GcqLcoE2CLFKf/pkdihOjjRGcISdALmY/
         lYj5e/aHTNtAxVddERrRtjz+mT2qfE+2PrBmyIXG8b3nJjlraBGzguHdgZz/clWlRrRu
         zPA0LuRN7H7mWJESqaoYcdieI4kbaYfyXOKap+UdcGRRbMCkyyl8ojZ5YL8KXH6C72Xc
         KIKduj6epwd4YyCq5MKepAIFhlkWbBvvDUTiETtqcIwqfzrmOy8V59Zl9l8bKSty3Fyt
         1cm5t4gC7FQkMXgUc4wzSlKNFDwyUi5sYwxqxpypJZ1sFXPbWDnMFc0yzBWO3xUI/Qjw
         1FXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P7BkHVo7lr7IoLxj4xozJR7ZfwY1TDrJJZ/qfyWx7lo=;
        b=GNZCwZVrvqHEG/iVo0PVd6WP/G5TPCLPfvNyI+EE/KFbZl6Z4Wdk7GbAN3RsNTtE8L
         QE/wbJIUm7gTQr/LdATWwcMjxzO63p/k8slByvkKj5dAv9CzW9M70426ZvhbRNbI/zIw
         uwkIjnyKU6mvlL6Ftj33Zrre2Ov2nluJhfpVIvoi1VG8bEzLH/6u/W/HstrxRDbEkqB7
         cYU1Jy48O3knzrZXxEoiRrMFu4MSmbSYQlOv0VH2XPycJmlySCQ0siVP23zadoAG/Pes
         KAPvuSK+gogpu+q6jUVIaXnuv5T4IENnDz2qlglN4w8uLvYGQ2+I2eDxc55pEsZio5EO
         5V8w==
X-Gm-Message-State: ANoB5png6uoGVlyf1zoupMIRThY9g90TEZLvIaKg5hPTOgieSXsDvGRm
        WjzC/STACG0yQ4r2sOXdpc+bToUTS3U=
X-Google-Smtp-Source: AA0mqf5I0qwaz6CoKiv1lNLzxBrKXK9kWDmPd0i+okA26FaqgtNUM4DzbWncbGIWvCTUo+hru9Ls1A==
X-Received: by 2002:a05:6870:3049:b0:144:fc01:370 with SMTP id u9-20020a056870304900b00144fc010370mr12389841oau.0.1671035712365;
        Wed, 14 Dec 2022 08:35:12 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j19-20020a056870021300b001446d5702b5sm2844422oad.56.2022.12.14.08.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 08:35:11 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <79a2245d-0a69-836a-fb78-30d2d3ae5185@roeck-us.net>
Date:   Wed, 14 Dec 2022 08:35:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: correct indentation and style in
 examples
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Akshay Gupta <Akshay.Gupta@amd.com>,
        linux-hwmon@vger.kernel.org,
        Eric Tremblay <etremblay@distech-controls.com>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        Kun Yi <kunyi@google.com>, Jonathan Cameron <jic23@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Krishna Chatradhi <ch.naveen@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Supreeth Venkatesh <supreeth.venkatesh@amd.com>,
        devicetree@vger.kernel.org
References: <20221213092643.20404-1-krzysztof.kozlowski@linaro.org>
 <167094291641.992665.14962893906742419729.robh@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <167094291641.992665.14962893906742419729.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/22 06:48, Rob Herring wrote:
> 
> On Tue, 13 Dec 2022 10:26:41 +0100, Krzysztof Kozlowski wrote:
>> Fix mixed indentation to 4-spaces, remove unnecessary suffix from
>> i2c node name and use lower-case hex.  No functional impact.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   .../bindings/hwmon/adi,adm1177.yaml           | 12 ++---
>>   .../bindings/hwmon/adi,adm1266.yaml           |  6 +--
>>   .../bindings/hwmon/adi,axi-fan-control.yaml   | 20 ++++-----
>>   .../bindings/hwmon/adi,ltc2947.yaml           | 20 ++++-----
>>   .../bindings/hwmon/adi,ltc2992.yaml           | 26 +++++------
>>   .../devicetree/bindings/hwmon/amd,sbrmi.yaml  |  6 +--
>>   .../devicetree/bindings/hwmon/amd,sbtsi.yaml  |  6 +--
>>   .../devicetree/bindings/hwmon/iio-hwmon.yaml  |  8 ++--
>>   .../bindings/hwmon/national,lm90.yaml         | 44 +++++++++----------
>>   .../bindings/hwmon/ntc-thermistor.yaml        |  2 +-
>>   .../bindings/hwmon/nuvoton,nct7802.yaml       | 16 +++----
>>   .../devicetree/bindings/hwmon/ti,tmp513.yaml  | 22 +++++-----
>>   .../bindings/hwmon/ti,tps23861.yaml           | 16 +++----
>>   13 files changed, 102 insertions(+), 102 deletions(-)
>>
> 
> Reviewed-by: Rob Herring <robh@kernel.org>


Are you going to apply the series through your tree, or should I
apply it through hwmon ? I am asking because you applied the
ntc-thermistor patch, so it might sense to apply this series
as well.

Thanks,
Guenter

