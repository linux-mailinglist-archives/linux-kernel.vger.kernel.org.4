Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658146D6528
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbjDDOWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235771AbjDDOWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:22:15 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE46449F;
        Tue,  4 Apr 2023 07:22:14 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-17683b570b8so34681423fac.13;
        Tue, 04 Apr 2023 07:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680618134;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=818uoQcqFpRfOwtGiVH6lha3tDNbDaxb6v/S7UADaBU=;
        b=nD8tMq24jTMTPUcgwZF+n5Q1p9OUS0rdreKR9FMa1uks4hiyeeLlz6m24RLr4OVa3Y
         M89HEipjKy44w9X4hhmz0zhVdQnhAJ3fRIzxO3N7tQlaoOPu1BlViJx3sL4w0TCTA6mH
         Jv3/P/twetrSm7lU4bR7Preu1a2GVd2SqtZbQmQjphVgejbDsHE4PXNFFV9QtFmvy5g0
         AVlue76+Cwc4ezdgW3fmauQ/lJVTBYbSKMRTczFeLlY8CAGkUaYm1pFbN928jfRiFeVi
         pqmt4bgo8XLlUVzBVUU9EcSORff1tNIGsQIyI3fsYMAJhume7Qjc7m1GRFyyODydY8rM
         MxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680618134;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=818uoQcqFpRfOwtGiVH6lha3tDNbDaxb6v/S7UADaBU=;
        b=luErF/5U0rjlY1cHKv1TEiKdqCOTchG2U+kYDdfAdwZ/26Amwplnss0tNyMwEySFpR
         cBc+AyDzvg7mbsF+9sF0vNtZojaxuHUpMIMUxt1R4nkqQcl5gaLLfUE6QXz8OCkw8dmU
         dytLZxDrGeEvcKz5OQlIG0KJVbOQYzEVyOzjLkRGVQ80EGd+6KIcHX1ZpqpIzxe6ljGZ
         8B39hzgfLvEpyUG1+cbpV58cPGJggnd8kSgftc3EwH6K8I+QSXRSbg3jLcGDQTcqg5Zo
         jGj0BvKahGV0WKkIQQuNZeRJgFkvG6p+I744sW2KqEhN0jWNCa6vfneWL1z1yNeB+cea
         rHbw==
X-Gm-Message-State: AAQBX9fW/cTnBChR1LSl6jp+yCIec7Ho61uy958fhDvFIh+j2JDcrtxb
        0bK1H4hAiotpUxSMxFr589c=
X-Google-Smtp-Source: AKy350bk7R/QlO6ayN2c9pBOUWWppaiidy1pXwEJUzHZrvPXrkcdz0oQVNFc6Sj9wXilZSNTdyiunA==
X-Received: by 2002:a05:6870:ac10:b0:17a:d9b2:ab70 with SMTP id kw16-20020a056870ac1000b0017ad9b2ab70mr1717804oab.7.1680618133811;
        Tue, 04 Apr 2023 07:22:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a4-20020a05680802c400b00383ef58c15bsm5150639oid.28.2023.04.04.07.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 07:22:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6441032d-d641-c00c-5c1b-66f65af6e6b9@roeck-us.net>
Date:   Tue, 4 Apr 2023 07:22:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: pwm-fan: Convert to DT schema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
References: <20230403105052.426135-1-cristian.ciocaltea@collabora.com>
 <20230403105052.426135-2-cristian.ciocaltea@collabora.com>
 <20230404141749.GB3793612-robh@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230404141749.GB3793612-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/23 07:17, Rob Herring wrote:
> On Mon, Apr 03, 2023 at 01:50:51PM +0300, Cristian Ciocaltea wrote:
>> Convert the PWM fan bindings to DT schema format.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>   .../devicetree/bindings/hwmon/pwm-fan.txt     |  68 +----------
>>   .../devicetree/bindings/hwmon/pwm-fan.yaml    | 109 ++++++++++++++++++
>>   2 files changed, 110 insertions(+), 67 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
...
>> +
>> +  pulses-per-revolution:
>> +    description:
>> +      Define the number of pulses per fan revolution for each tachometer
>> +      input as an integer (default is 2 interrupts per revolution).
> 
> default: 2
> 
>> +      The value must be greater than zero.
> 
> minimum: 1
> 
> maximum: ??? I assume there's some practical limit here much less than
> 2^32.
> 

Should be 1 to 4.

Guenter

