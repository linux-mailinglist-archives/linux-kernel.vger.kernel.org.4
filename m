Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACCF6E8C9B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbjDTIWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbjDTIWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:22:37 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403A730E9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:22:34 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63b51fd2972so648607b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1681978954; x=1684570954;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4DMeRQEVjnGvjTdMi1WDO2hzeB7OEvrm9xDgZ4E+Odo=;
        b=QsRx8DNEii1hHTwSRfTSltb2l0lXFk0fCbxNCvZISBIq4XBmSA7sjqnLDT4TA64nOo
         UKTDF4H9mkYwEHsMrO7V7z9BsqqFg1yIOa6Nytq8FbIicP6QIILbOiPHslcqmwe+KqVI
         iO4yxMkWXD4mbVcGfk+MLYRSPkD+ux4z5oUgr4A+j016QJ9JeX87mwRf20WWczPa2Ca7
         EDTFqYcfYAkDxxJHRgUN7ut5KPblRJ5QCBwkVanjaap/PPrm9JZutQnItT/6n4cFCgcW
         xDdgFajk0Ad2Uw/DiCJtT3FPplUIbO+z9GuJPNymyj+41I6M+5Ptlt41v4CjVxjLm6Lt
         AekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681978954; x=1684570954;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4DMeRQEVjnGvjTdMi1WDO2hzeB7OEvrm9xDgZ4E+Odo=;
        b=IpAkmFO8ApOm4jSdXfHM49XGkIuOt7EMwTfD1Z2kz3H5ASstQ3ysHjDsZsXbPXQdUK
         i0oAVtPCUR+Hvf2TeITN2+atTa6fKRX/FFlc3rnDQ8fTlqe3JUYFYtjVWhy/tO7Iw8DD
         pwUcpdqpStb2LQ02+zlx6f0ziFWJ5QIbzzue4ibr6w5E4VR3x1XJeqK7A/hIXlyH+Drh
         Jl3UK34AuViyT2pRMKdFrYCtlCXRXP6g1x6PwMkRL4+eslITgxzDdy3nWcxuWvhoTOO8
         fB9Nx/pNdByUx2PfhG5N6hLGrXTUMD5HFNMzs7aW3YFP/QSiFP4+zxzcArV869Sjwaoy
         6ZUQ==
X-Gm-Message-State: AAQBX9dXBvY0qdKt8bdLuS9bQ8p2c9EZiw9PgJKhT0sf+qFtya8gs1Oo
        XpsdprhPbNsLbaqIPv8P6JuM1A==
X-Google-Smtp-Source: AKy350anJUB02TZaTTaDOpXkS2MoMiQXMYqeZve3utmSFoK5bryH/5VMg+DIE9xO6tLGwF/vrZcZsA==
X-Received: by 2002:a17:902:c40d:b0:1a9:2823:dac2 with SMTP id k13-20020a170902c40d00b001a92823dac2mr1138514plk.57.1681978953690;
        Thu, 20 Apr 2023 01:22:33 -0700 (PDT)
Received: from ?IPV6:2405:201:d02f:d855:461d:14be:2cce:b776? ([2405:201:d02f:d855:461d:14be:2cce:b776])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902c71200b001a240f053aasm669738plp.180.2023.04.20.01.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 01:22:33 -0700 (PDT)
Message-ID: <9f425205-c395-648a-3f42-a776c7580a8f@9elements.com>
Date:   Thu, 20 Apr 2023 13:52:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] dt-bindings: regulator: Add dt property
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230418145051.4192963-1-Naresh.Solanki@9elements.com>
 <0da2b301-8780-48c0-a5dc-326474011e8d@hatter.bewilderbeest.net>
Content-Language: en-US
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <0da2b301-8780-48c0-a5dc-326474011e8d@hatter.bewilderbeest.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zev,

On 20-04-2023 05:31 am, Zev Weiss wrote:
> On Tue, Apr 18, 2023 at 07:50:50AM PDT, Naresh Solanki wrote:
>> Add DT property regulator-supplies.
>> This enables us to couple one or more regulator output to gether. This
>> is use in case of Single connector having 2 or more supplies.
>>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> ---
>> .../bindings/regulator/regulator-output.yaml         | 12 +++++++++---
>> 1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/regulator/regulator-output.yaml 
>> b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
>> index 078b37a1a71a..17f683d3c1f3 100644
>> --- a/Documentation/devicetree/bindings/regulator/regulator-output.yaml
>> +++ b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
>> @@ -21,13 +21,19 @@ properties:
>>   compatible:
>>     const: regulator-output
>>
>> -  vout-supply:
>> +  regulator-supplies:
>>     description:
>> -      Phandle of the regulator supplying the output.
>> +      Specifies the name of the output supply provided by the regulator.
>> +      Defaults to "vout".
>> +    default: "vout"
>> +
> 
> Was this meant to be specified as a string-array to allow providing 
> multiple names?
Yes. This is string-array.
> 
>> +patternProperties:
>> +  ".*-supply":
>> +    description:
>> +      Specified the phandle for various supplies
>>
>> required:
>>   - compatible
>> -  - vout-supply
>>
>> additionalProperties: false
>>
>>
> 
> I think it would be nice to also update the examples to show what a 
> multi-supply instance would look like.
Ack. Will do that.
> 
> A slightly more descriptive subject line would also be good -- "Add dt 
> property" is a bit vague.
Suggestion ?
How about like 'Allow multiple supplies' or 'Add support for multiple 
supplies'
> 
>> base-commit: c55470f8b0616b0adb758077dbae9b19c5aac005
>> -- 
>> 2.39.1
>>
Regards,
Naresh
