Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807696A7E0F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjCBJl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjCBJl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:41:26 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3BA38EBE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 01:41:24 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id me6-20020a17090b17c600b0023816b0c7ceso2262906pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 01:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1677750084;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EXsUOtBQPag9Bf8J6jfkXWMjUC1eSQEKfj0tXrG/FaM=;
        b=gr9VDny4XZh2/bnqnWr7pwU9w7+hkY0jOKx1CeF2TYq3sO7puWTITZz+dfFqbnG9QB
         TdRUbIAEXVgmA3oU8X1mq2SlURoEp/w2D7rGVz4oDsa1GHUnzxAitng++FOupyX29gRU
         Y0fcJA0rgEzhfDmyek0l+kIfl+ITr+9CH7JkfuFao73n2W4KqdwUYZCs9eaW7IvR17LI
         Mb7h7/i9PaUh64W73XRHYAL5h/gh4ACGUuRfpKRfocC1sO9L5y3ClAzrhFmqA5fjS+AG
         4vkwvflQXVnJRiyNP9I2SBFncE3WbCTV7kTl43BLbXxjxbgIFoaPxMjnxS0Ul0sWkL5Y
         LREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677750084;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EXsUOtBQPag9Bf8J6jfkXWMjUC1eSQEKfj0tXrG/FaM=;
        b=eK/4OaWX+T/JNzsAPP54EsVS/hJv1ZTY1tU66L5bcfUhTAubSSrbbwmiVOLRp2/8+p
         VH42wHU6DLGTwiqq1dB4PG6aaal9KMh6MdBzMnQEa81rJodGtX3glpmsD+lSvndasJZN
         Qii8yQBRpPA5V2jsoXXHwq1Vs/RvfvFc+4Uqdqv6mne2EiN6onH5pmXHwr+ZV6ft3L88
         Hu0k2JeU7hZPNJTz7xKUv94qqez96LUCueOm1iLpniTigo/WD0Yyat/DJu1ldkrnQCtv
         BHUZ0YGErL7eKxgaJcatnhcPBgAcuvlXsmBjz0VROC3IF56RhSIDSs7HXAqm5yjJnhmv
         x8Kg==
X-Gm-Message-State: AO0yUKU+14XN0LnXLPm8jsEhH9tT6TtDgkeDETdgmBziMiqywxCOe3vK
        5BW6CvMKn9R4+zjvoVmtXu4Syw==
X-Google-Smtp-Source: AK7set+WOIPvQCE6zWYJJP6qka5O1MdfE2BeTG7SWInH5XBQICcdaRXKYlbEVpEdqaETnJBSaUGB/w==
X-Received: by 2002:a17:902:7594:b0:19c:b7da:fbdf with SMTP id j20-20020a170902759400b0019cb7dafbdfmr9231927pll.26.1677750084220;
        Thu, 02 Mar 2023 01:41:24 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id l10-20020a170902d34a00b0019c93a9a854sm9812814plk.213.2023.03.02.01.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 01:41:23 -0800 (PST)
Message-ID: <6d1f7d62-e1a8-b814-80cc-4db1100fdb0c@9elements.com>
Date:   Thu, 2 Mar 2023 15:11:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] dt-bindings: mfd: Add MAX5970 and MAX5978
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230301091234.3159953-1-Naresh.Solanki@9elements.com>
 <dcace8f8-8591-40df-895b-155f0604665d@linaro.org>
Content-Language: en-US
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <dcace8f8-8591-40df-895b-155f0604665d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Krzytof,

On 02-03-2023 01:56 pm, Krzysztof Kozlowski wrote:
> On 01/03/2023 10:12, Naresh Solanki wrote:
>> From: Marcello Sylvester Bauer <sylv@sylv.io>
>>
>> The MAX597x is a hot swap controller with configurable fault protection.
>> It also has 10bit ADC for current & voltage measurements.
>>
>> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
>> Co-developed-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>> Co-developed-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> 
> It's v12 or what? Where are previous tags? Or you ignored entire review
> and sent something new?
> 
> You already got the comments about it, so basically you ignore it second
> time...
> 
> Where is the changelog?
My bad I missed updating the same. Will include it.
> 
>> ---
>>   .../bindings/mfd/maxim,max5970.yaml           | 151 ++++++++++++++++++
>>   1 file changed, 151 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
>> new file mode 100644
>> index 000000000000..6ee269afdab2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
>> @@ -0,0 +1,151 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mfd/maxim,max5970.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Regulator for MAX5970 smart switch from Maxim Integrated.
> 
> Drop the full stop. It's title, so follows the title grammar rules (you
> could also capitalize it but it's matter of style
> https://www.grammarly.com/blog/capitalization-in-the-titles/).
Sure.
> 
> I don't know whether I should review rest or not... just in case I don't
> want to waste my time, so I'll skip it.
> 
> 
> Best regards,
> Krzysztof
> 
