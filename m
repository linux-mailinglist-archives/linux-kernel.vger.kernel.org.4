Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E90472EC49
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjFMTvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjFMTvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:51:19 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184E1B3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:51:18 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5149c76f4dbso10100862a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1686685876; x=1689277876;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9XrzWEILW2x+ufSnQTLs9RCR/ifbXpqGYfzmWq4Xzfw=;
        b=HxJgIZnokPQC4w4n/ljElh/G9CPMr7jFKAuQJSUbriAhV0lpH4aj/mKWzIIaQdPVdI
         61MCXTxiS1Gykye1NeSq90p5131JuvWrwsjBYvfLLZdGnV8/yL8yUcRtuuorlvapgKIn
         2JiRDarpT5JKkBFCsRX4AIed6dswnteP7qUJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686685876; x=1689277876;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9XrzWEILW2x+ufSnQTLs9RCR/ifbXpqGYfzmWq4Xzfw=;
        b=k+Xmn/wVMI/d3HMw08C+Re5ATrzX8n0N/z6kcqQkB4xX+E3a6okyLtqxT2sYqaYbX6
         3nGNGM4v8DS8tkXoMKmRasyN7R8XTLtCyxIH+ZSXjDAOhC3xs9k0niG7ENwNa8ALIEM8
         x6iDGJ0mLcXsXn84omW/b2A/ZFCxJaCryomY2XIN5uL5Gcbvk61dZB9E9si6woBKBhum
         TqxES5MFAENe6QNfleU32ie7x6rWW6s2p2dVviRzGeHreGWCiCX2CGp5C+HowNo8rXQ6
         YMumWr/OVjV/T5pyiS4Kn9fPXhgSvYXcwwyJxsMGlD9ANESQ5vuHz4+KLJWDZ+/gEQGn
         J9jg==
X-Gm-Message-State: AC+VfDydYyDnU28uAXISvuVSoryWTCqhP5hh0tkso3MnLNgZH++l/Ur+
        ajywvCepJovs/H2dQcfy05LE7A==
X-Google-Smtp-Source: ACHHUZ65S6x3wUe+xgz7Fe5682XAiDKrg9U4eu/Kbphk/SgJjL/tWAenrGrQqtahtTZh0ltgZ4pGpw==
X-Received: by 2002:aa7:c58a:0:b0:514:9e2d:bfd8 with SMTP id g10-20020aa7c58a000000b005149e2dbfd8mr8346139edq.34.1686685876516;
        Tue, 13 Jun 2023 12:51:16 -0700 (PDT)
Received: from [192.168.1.128] ([80.208.70.1])
        by smtp.gmail.com with ESMTPSA id p4-20020aa7d304000000b005169ffc81absm6842027edq.51.2023.06.13.12.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 12:51:16 -0700 (PDT)
Message-ID: <dd15aaeb-04ff-126b-b524-44e30c60426b@rasmusvillemoes.dk>
Date:   Tue, 13 Jun 2023 21:51:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/8] dt-bindings: rtc: isl12022: add bindings for
 battery alarm trip levels
Content-Language: en-US, da
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-4-linux@rasmusvillemoes.dk>
 <0600a505-d1bf-f4be-57ef-51d34c77501e@linaro.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <0600a505-d1bf-f4be-57ef-51d34c77501e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2023 21.09, Krzysztof Kozlowski wrote:
> On 13/06/2023 15:00, Rasmus Villemoes wrote:
>> The isl12022 has a built-in support for monitoring the voltage of the
>> backup battery, and setting bits in the status register when that
>> voltage drops below two predetermined levels (usually 85% and 75% of
>> the nominal voltage). However, since it can operate at wide range of
>> battery voltages (2.5V - 5.5V), one must configure those trip levels
>> according to which battery is used on a given board.
>>
>> Add bindings for defining these two trip levels. While the register
>> and bit names suggest that they should correspond to 85% and 75% of
>> the nominal battery voltage, the data sheet also says
>>
>>   There are total of 7 levels that could be selected for the first
>>   alarm. Any of the of levels could be selected as the first alarm
>>   with no reference as to nominal Battery voltage level.
>>
>> Hence this provides the hardware designer the ability to choose values
>> based on the discharge characteristics of the battery chosen for the
>> given product, rather than just having one battery-microvolt property
>> and having the driver choose levels close to 0.85/0.75 times that.
>>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>>  .../devicetree/bindings/rtc/intersil,isl12022.yaml | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml b/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml
>> index 7c1e638d657a..d5d3a687a34d 100644
>> --- a/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml
>> +++ b/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml
>> @@ -22,6 +22,18 @@ properties:
>>    interrupts:
>>      maxItems: 1
>>  
>> +  isil,trip-level85-microvolt:
> 
> Why encoding level85 in the property name? Your commit msg (datasheet)
> suggests this is quite flexible, so why it cannot be just list of two
> trip levels - for first and second interrupt?

Yeah, so I did consider just making it a two-element array
isil,trip-levels-microvolt. But then I didn't know how to express the
enum constraint, i.e. that the first must be one of the 2125000, ...,
4675000 values and the second one of the 1875000, ..., 4125000 ones. Is
that possible, without providing a list of 49 possible pairs? Or is it
sufficient to just write this out in prose?

I'm also happy to use other names for these. I just chose to use the 85
and 75 nomenclature because that matches the field names.

>> +    description: |
> 
> Do not need '|' unless you need to preserve formatting.

OK.

Rasmus

