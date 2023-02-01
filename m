Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4203E686147
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 09:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjBAIIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 03:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbjBAIIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 03:08:38 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1363749437
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 00:08:36 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r2so16442040wrv.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 00:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fPMQb9ClpEWunoZz1SRe7U0hhsmgySgDI2+LUjx4p1s=;
        b=Wnvz4a5tihLzWQ3UGZK5oxgZvkkZABlKkArVeCdLwp0FnuzvvFHfJqA7i29ZsuH5mt
         NB/JSGhuiTfbuEV09T5RltL4eloJo2pyUNrQQaIBWqmid4vGirVGr0ZlOfXcddYWM2Dz
         CoWMeE0mQ7Opa57MlGv7udJLN+IU7udA1FujAx1G5KVQQEEQJIoQ041elSVEXGI5O3Dp
         ny9+UaQqgs3yD5JDWECyMc8koD3rStLcN0IsuVWGLKk3nQtb8J8ZruWO740jgV/18nu7
         dUW/HWWSb+kjonp+rRzVWq1JXYzPEG1YSr54GR+KbnjUPGYoWJk1AG7tOc7yuEv7BZxn
         uK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fPMQb9ClpEWunoZz1SRe7U0hhsmgySgDI2+LUjx4p1s=;
        b=QZp6r8Ip6CZDVeZJ30JX1cfxmekJgEJkRZYejLyKjpnJ65Vz1+rEO8okf2StftiyDG
         pT0vdKZhLAJyCB0tUzljo3jxuf/1mZZIsG+OlrCTDWi+/du6o4xjzSnLxNZRLJUkbmlo
         SFm7ukKNPTsj86AvKVMEu+JyFP+4E+hbGLswDFzd1C0B2IsPqTSbIYoasJ8OEVVuZrY1
         sCwUjHgSibaUdZ/8BvtOvaHH5edjS7kTOLfSli8HX6Xf0cdXtAaAywjekj3TW075/Y7d
         ebT/3sH4AL9wAKWF1OjSNJSJpjS492Xq2sjaMlqag4cIowHX4ukHSOWrAWvBSoj/SsWd
         fr+Q==
X-Gm-Message-State: AO0yUKVsCJJQ+G/5RvWtRqtFdF6IJouq+Mh2ktdPz9keqcvdFWbGIrxZ
        T6DJUnl8u/oOkXGdRlYxooRoEQ==
X-Google-Smtp-Source: AK7set9AeNdwZS/UJ9g7Dad8wwPgTBxvI+2rWkgtcVhilHAuC/iLNmynZ6qONCst5pTutyqG1/HQHw==
X-Received: by 2002:a5d:65c6:0:b0:2bf:d17c:609b with SMTP id e6-20020a5d65c6000000b002bfd17c609bmr1361527wrw.64.1675238914573;
        Wed, 01 Feb 2023 00:08:34 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m3-20020a056000180300b002755e301eeasm16731971wrh.100.2023.02.01.00.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 00:08:34 -0800 (PST)
Message-ID: <a738fdec-0218-e0a5-8750-e39ff87967a5@linaro.org>
Date:   Wed, 1 Feb 2023 09:08:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 2/5] dt-bindings: mfd: Add ADI MAX77541/MAX77540
Content-Language: en-US
To:     "Sahin, Okan" <Okan.Sahin@analog.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20230118063822.14521-1-okan.sahin@analog.com>
 <20230118063822.14521-3-okan.sahin@analog.com>
 <c4433cba-ce35-e5d3-f04b-ba8f9f501732@linaro.org>
 <MN2PR03MB51685B56D49CBB590BBE6B7EE7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
 <04ac07ef-ee4b-abb8-9fb2-114e3a646a2f@linaro.org>
 <MN2PR03MB5168884376CEE35E73739A95E7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
 <f67f81fd-c770-45b2-9c5e-7ea53e956db9@linaro.org>
 <MN2PR03MB5168CACCB1367E84DECEFC62E7D19@MN2PR03MB5168.namprd03.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <MN2PR03MB5168CACCB1367E84DECEFC62E7D19@MN2PR03MB5168.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2023 08:46, Sahin, Okan wrote:
>> "bindings are before usage" - what's unclear?
>>
>> How can you use binding before defining it?
>>
>> Best regards,
>> Krzysztof
> 
> Hi Krysztof,
> 
> It is crystal clear that "bindings are before usage", but what I want to know is what is the correct order of patchset for mfd device? Max77541 is multi-functional device. It has both adc and regulator subdevices. I thought I need to put mfd driver first, yet it looks wrong to me right now?

MFD driver is also usually the last.

Best regards,
Krzysztof

