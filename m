Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCE764B730
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiLMOUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbiLMOT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:19:59 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4154020BCA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:19:58 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id b9so3431661ljr.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EMyYtrU31qIqDBD9DxhVXcwRAXD72OPOTw3x1Svfa2k=;
        b=SDEyNxDxgIElp7BRSiViRI9XVucIw2MTgwHgLm/AUJw75Yf7ntxXinMq5YYDzQmrWD
         dDHl95SVdIEaCSwG/Y+mTUcilt7S47a6SsCDbBWuVlvJ8OrxCBVBer+/74KXonJkNvDN
         4OXEdCPaBrbCiMvDPWV+uHiSDx4b3PkR91CTIdAgIefluA4pYs8V4L7h4EzmaCkpmERW
         hzZcquDFHGKMxjCf/Ap65baerwoBkZy4D5eF8S2PZ2RuX06/S/tLlpIQoqLX6w3/urnL
         fGwwn1Xn5apIeqKLt6TdncMdOuuxpD2MqdiQn51x+wNvg10PdI/Qt/LdNWh3a3IMzygR
         Jxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EMyYtrU31qIqDBD9DxhVXcwRAXD72OPOTw3x1Svfa2k=;
        b=kiHlUL/uvbietRTUwJmT84JQkCre7WUExYuxyBaSxajBIkOSWrLRO1nEe7KBfzMNWH
         R389Y5L3Iu2wl7SvsZFrY81Py7qJk9fotoJl02mYEtFBDJL0LE4nXuCSLVBmOhMILi46
         EW+VgbOVafaH6ZceXrQBfWBzjLrNwfwGpjv1b5+95Hv/XlV8F2SVvY6mnC9iQfUDmClI
         YLIdQarNeF4Ecaif1A1+CRHFVgQUH5i7sYV0fCJ3xDt3gOLva/0vmuCBa7R5DJXpKcTN
         oOZkA8cAEnFGuFAD8NAcPJxfqJc7EdmTyfFZVB0dONDpvbZeb2mJHrfnn7LKTFT6Etb8
         89xA==
X-Gm-Message-State: ANoB5plNwT9N8b6SX6o9VxVZU9XhnNx/7slhy6zeRmkoFz4Pr6/03XIx
        xuDjPlJGshDQZagyUrzspLHciA==
X-Google-Smtp-Source: AA0mqf62Rjtx/IsL79mhl1BYRYlsELpLE4pnLyB3o6ubxKNCcGj1PBfDe9vSzoz90bd+J9hIKQD9lQ==
X-Received: by 2002:a05:651c:17a2:b0:277:13a1:1886 with SMTP id bn34-20020a05651c17a200b0027713a11886mr6603214ljb.6.1670941196605;
        Tue, 13 Dec 2022 06:19:56 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s26-20020a05651c201a00b002770fb5722fsm275824ljo.123.2022.12.13.06.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 06:19:56 -0800 (PST)
Message-ID: <2172e561-ec0f-5c4e-96d2-ceb2010f2673@linaro.org>
Date:   Tue, 13 Dec 2022 15:19:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: correct indentation and style in
 examples
To:     Rob Herring <robh@kernel.org>
Cc:     Kun Yi <kunyi@google.com>, Jonathan Cameron <jic23@kernel.org>,
        Krishna Chatradhi <ch.naveen@samsung.com>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org,
        Supreeth Venkatesh <supreeth.venkatesh@amd.com>,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Akshay Gupta <Akshay.Gupta@amd.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Luka Perkov <luka.perkov@sartura.hr>
References: <20221213092643.20404-1-krzysztof.kozlowski@linaro.org>
 <167093911583.912886.13512120412056690614.robh@kernel.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <167093911583.912886.13512120412056690614.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2022 14:46, Rob Herring wrote:
> 
> On Tue, 13 Dec 2022 10:26:41 +0100, Krzysztof Kozlowski wrote:
>> Fix mixed indentation to 4-spaces, remove unnecessary suffix from
>> i2c node name and use lower-case hex.  No functional impact.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../bindings/hwmon/adi,adm1177.yaml           | 12 ++---
>>  .../bindings/hwmon/adi,adm1266.yaml           |  6 +--
>>  .../bindings/hwmon/adi,axi-fan-control.yaml   | 20 ++++-----
>>  .../bindings/hwmon/adi,ltc2947.yaml           | 20 ++++-----
>>  .../bindings/hwmon/adi,ltc2992.yaml           | 26 +++++------
>>  .../devicetree/bindings/hwmon/amd,sbrmi.yaml  |  6 +--
>>  .../devicetree/bindings/hwmon/amd,sbtsi.yaml  |  6 +--
>>  .../devicetree/bindings/hwmon/iio-hwmon.yaml  |  8 ++--
>>  .../bindings/hwmon/national,lm90.yaml         | 44 +++++++++----------
>>  .../bindings/hwmon/ntc-thermistor.yaml        |  2 +-
>>  .../bindings/hwmon/nuvoton,nct7802.yaml       | 16 +++----
>>  .../devicetree/bindings/hwmon/ti,tmp513.yaml  | 22 +++++-----
>>  .../bindings/hwmon/ti,tps23861.yaml           | 16 +++----
>>  13 files changed, 102 insertions(+), 102 deletions(-)
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 

This is fixed in second patch which points to: I need to change their order.

Best regards,
Krzysztof

