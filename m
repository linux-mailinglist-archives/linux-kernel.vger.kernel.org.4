Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206E76ECA4E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjDXK3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjDXK2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:28:46 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E1B4226;
        Mon, 24 Apr 2023 03:26:55 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4edbd6cc46bso4524144e87.2;
        Mon, 24 Apr 2023 03:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682332013; x=1684924013;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SemMbIf9FAx8zOAJPJSoYfcqskJMokFHulRfLk4rUCM=;
        b=NQSNi12/apyGbynQPTr8J/nHJi9Ksgg4+NLv2TUsBJFYriuuoRHxKmJibVwv2UJG2X
         OHLm5OEXaIjmCggQGkYxBOqXwCQt5WWWiBSyxAVowxiwUFAezgOcMwQPvagcYMhQU6fM
         EHzQzlFfnaUjLZDjGa13TE560+uA72BysJcahWiTGTDsXNPpUDiGHtYBhq9eI60FVlvw
         1dROvhA4ofvvFudRCBn3eYoGd6ONbGewxto322/ARqTCPt4R1BzoVfIi3+GZBwK2WQXl
         5jufZgKfjoByPlp5PtDEcrm4JsYo+u1Q+3a3Xq0N9tTe18kqVNWev+sMrt1RUiPptMrM
         5t1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682332013; x=1684924013;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SemMbIf9FAx8zOAJPJSoYfcqskJMokFHulRfLk4rUCM=;
        b=RwQWBhVIZQ0Fu6/XpMGTu7QDRWvz7Km2ttTnNq0pLorp1yZgiSRs4Ze2iNABDVsMao
         6HQnByDp1vns8TqhRf6UI2Iw6j7/W17gs5UsGWcEaAcXhriZOhi8NLJVEeV4bGQjvhK2
         bfosjEB9uO+DBrZ9zCOf3u576gYlg0RCQEK+dQUoVsikvjUGq6Qmy+qnPzaoTOWqCt5J
         Vrtwpx7xHrwPGWdpZXyjGfDXMiZ6G3tTuLc0MHADWXoGaQ8Gd1aYShcLOpY/nRBhP+pE
         WdcN7jmrc9zNtSgjZL5LgXD+eQhl3QvQoQ+19Nw528382f+KogndrcxMM3gAtUZQPtP3
         zI9w==
X-Gm-Message-State: AAQBX9fceuGgG3tZ7vq+vbhHB/IOwA0XYYcoZTwgp3krq3dJ7fhlQoor
        VYPgOuNH085zU2NcwojKggk=
X-Google-Smtp-Source: AKy350YX6plUcUHiQ7QMC85zfFEuKR+sc82CJmUAcBpcwPzqvEBUOyqNRrTOIkRQYOOTZ7bwnVTW4A==
X-Received: by 2002:a05:6512:7a:b0:4ec:9c2e:7ee3 with SMTP id i26-20020a056512007a00b004ec9c2e7ee3mr3059443lfo.42.1682332013449;
        Mon, 24 Apr 2023 03:26:53 -0700 (PDT)
Received: from [192.168.1.111] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id r16-20020ac252b0000000b004edc9e9eec5sm1616992lfm.138.2023.04.24.03.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 03:26:53 -0700 (PDT)
Message-ID: <eb089eaa-8c13-67f7-8b67-e2a3b74bd809@gmail.com>
Date:   Mon, 24 Apr 2023 13:26:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1682067567.git.mazziesaccount@gmail.com>
 <30daff0d94cd4d05de0194808ab9a6984caf78dc.1682067567.git.mazziesaccount@gmail.com>
 <06d60a20-a620-b9f6-adc3-337973dfb8a8@linaro.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: iio: light: ROHM BU27008
In-Reply-To: <06d60a20-a620-b9f6-adc3-337973dfb8a8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/23 13:12, Krzysztof Kozlowski wrote:
> On 21/04/2023 11:38, Matti Vaittinen wrote:
>> The ROHM BU27008 is a sensor with 5 photodiodes (red, green, blue, clear
>> and IR) with four configurable channels. Red and green being always
>> available and two out of the rest three (blue, clear, IR) can be
>> selected to be simultaneously measured. Typical application is adjusting
>> LCD backlight of TVs, mobile phones and tablet PCs.
>>
>> Add BU27008 dt-bindings.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> ---
>>   .../bindings/iio/light/rohm-bu27008.yaml      | 49 +++++++++++++++++++
>>   1 file changed, 49 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/light/rohm-bu27008.yaml
> 
> Filename like compatible, so rohm,bu27008.yaml

Thanks Krzysztof. I should've remembered this as you told me the same 
thing during the bu27034 review. Feel free to kick me atthe ELC-E if I 
do the same mistake with bu27010 as well ^^;
> 
>>
>> diff --git a/Documentation/devicetree/bindings/iio/light/rohm-bu27008.yaml b/Documentation/devicetree/bindings/iio/light/rohm-bu27008.yaml
>> new file mode 100644
>> index 000000000000..d942c2817680
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/light/rohm-bu27008.yaml
>> @@ -0,0 +1,49 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/light/bu27008.yaml#
> 
> Does not look like you tested the bindings. Please run `make
> dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).
> 

I actually did. But I did first run the dt_binding_check without 
filename - causing it to check all the in-tree bindings - which took a 
while. So, I went to have a lunch. When I came back I re-ran the check 
with the filename (DT_SCHEMA_FILES=...) - which gave me no errors.

I _assume_ this is because running the check for all bindings had 
already done <add step here> generating the warning, while re-running 
the check with the filename omitted the <add step here> and no longer 
displayed the warning.

In any case, I missed warning from full-check, and checker missed the 
warning when re-ran.

> 
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: ROHM BU27008 color sensor
>> +
>> +maintainers:
>> +  - Matti Vaittinen <mazziesaccount@gmail.com>
>> +
>> +description: |
> 
> Do not need '|' unless you need to preserve formatting.

Ok, thanks.

I'll fix these for v2 :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

