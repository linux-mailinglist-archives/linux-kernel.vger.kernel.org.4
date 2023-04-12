Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D174D6DFAF1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjDLQOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDLQOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:14:02 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89594DC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:14:00 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ga37so30560443ejc.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681316039;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=idrvpPrHTD6wP5XCqyrMjCRsNdPCmtw6stdSlCmFO24=;
        b=Lvr4n+vdwOsKCRRHU+lM8f6VK55d2s9o4za0iu9Giod9ZlN+FKKo2udOIfs6ig9RPD
         L30nlu5hKbwws+dWtoBeJnzAu+Z9Bi0LplFF3XrFvIWA0TGge4ojAnlqXkyd9FqVa8Hw
         ni9I+CqEfv91bA1PXXlBxjT59ZpYuPH0QRv+oRwZVL/8e8c0ISh1+9oRvAiud4HW06TP
         oDZe4GW4O6EDjPEoORzxuaE5fIQyDaWMzy90kWwbsDrOk64NQFmDqQn9edWBgYdrmTsu
         WhJ2/LGNz0dcsiT1HayXcszxbVq0uE3SEGVnYqwdqffIbDYzx1ENVNyDEkMGlEzACiE9
         +I+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681316039;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=idrvpPrHTD6wP5XCqyrMjCRsNdPCmtw6stdSlCmFO24=;
        b=iTWYUw8ujqntXZwhMCSkS5OlWmSZZqWhfmLFj7NFuvfTwRkooPhZZkATal3rwVmf14
         VM8VIKN1oqGcv038kC4lfosbtvZSG2Nk0ndd8rMSjNB2+4VpUms5t4QDdQD6BnbnqHBN
         q+3HgGauNaB1sfLpym5ER1EXi1sDqHmevPpBnlEwXNTTjqwlNbluTO/PMAyEGejdufBf
         DDJ8WCnkBwsK3c4Q2MApCh7+1LAFAhGWMZMZybGKENqo8QAfQ4yf1G1vdwTDD5SdeKn0
         ZrYTQof79WAWIsBjq6tfqkgZtsOZBzNlh8FmpQRaE0vC34mx4IJmBuksFpw6nXVXzz6x
         EqEw==
X-Gm-Message-State: AAQBX9cWAPc0jsvrHxMK2tm80to3LCUC7Lt6LIxzjZbx6hKSIYpQ0sev
        mM13sgVKWbxeNIStELlHHeubhQ==
X-Google-Smtp-Source: AKy350al+QvYAnezsER7ELzQ+QJQ6CT1znYak3wiZ3R8SA/Fj5g+xLtjwjXwdll4fSVADMl4DVBXYA==
X-Received: by 2002:a17:907:7e91:b0:94e:6b23:2b0 with SMTP id qb17-20020a1709077e9100b0094e6b2302b0mr2492432ejc.57.1681316038959;
        Wed, 12 Apr 2023 09:13:58 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:938a:b3db:7c59:795e? ([2a02:810d:15c0:828:938a:b3db:7c59:795e])
        by smtp.gmail.com with ESMTPSA id o12-20020a1709064f8c00b0093f322187f0sm7399161eju.189.2023.04.12.09.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 09:13:58 -0700 (PDT)
Message-ID: <317c09a8-4df3-0a33-62b4-f5a496dfa0ca@linaro.org>
Date:   Wed, 12 Apr 2023 18:13:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 2/2] dt-bindings: cisco: document the CrayAR
 compatibles
Content-Language: en-US
To:     "Daniel Walker (danielwa)" <danielwa@cisco.com>
Cc:     "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        "Marcin Wierzbicki -X (mawierzb - GLOBALLOGIC INC at Cisco)" 
        <mawierzb@cisco.com>, Rob Herring <robh+dt@kernel.org>,
        Daniel Walker <dwalker@fifo99.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230405223028.1268141-2-danielwa@cisco.com>
 <6a9f041b-1c35-4691-8451-7119cd05ed17@linaro.org>
 <20230407160413.GD1391488@zorba>
 <6af9effe-89c0-7630-9a72-a5a6351e0a95@linaro.org>
 <20230410170915.GE1391488@zorba> <20230410175054.GF1391488@zorba>
 <c1319685-49cc-9326-f4f9-1190ff633450@linaro.org>
 <20230412150452.GQ1391488@zorba>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230412150452.GQ1391488@zorba>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 17:04, Daniel Walker (danielwa) wrote:
> On Wed, Apr 12, 2023 at 09:24:48AM +0200, Krzysztof Kozlowski wrote:
>> On 10/04/2023 19:51, Daniel Walker (danielwa) wrote:
>>> On Mon, Apr 10, 2023 at 05:09:15PM +0000, Daniel Walker (danielwa) wrote:
>>>> On Mon, Apr 10, 2023 at 05:28:03PM +0200, Krzysztof Kozlowski wrote:
>>>>> On 07/04/2023 18:04, Daniel Walker (danielwa) wrote:
>>>>>> On Thu, Apr 06, 2023 at 09:12:34AM +0200, Krzysztof Kozlowski wrote:
>>>>>>>> @@ -0,0 +1,27 @@
>>>>>>>> +# SPDX-License-Identifier: GPL-2.0-only
>>>>>>>
>>>>>>> Dual license.
>>>>>>>
>>>>>>
>>>>>> What are my choices here? I see this,
>>>>>>
>>>>>> # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>>
>>>>> Yes, the one suggested by the checkpatch. Did you run it?
>>>>  
>>>>  I don't recall if I did or not.
>>>>
>>>>>>
>>>>>> Which appears to be what your suggesting. I also see this,
>>>>>>
>>>>>> # SPDX-License-Identifier: GPL-2.0
>>>>>>
>>>>>> I'd rather use the later.
>>>>>
>>>>> Why? Bindings should be licensed under BSD, so what is the reason to
>>>>> make here exception?
>>>>
>>>> I'm sure I can re-license my submissions. I'd have to look into it.
>>>
>>> I'm _not_ sure.
>>
>>
>> This is a new file - it did not exist in v1 - thus you had to write it.
>> If you wrote it, you (or your employer) hold all copyrights, so yes, you
>> (or your employer) can relicense it.
>>
>> I cannot imagine the case why employer would not like to have dual
>> license here (it's beneficial to him, so employer would be acting
>> against himself), but if you need to convince him, you can just say,
>> that contributing to Open Source project means accepting the licenses in
>> that project. The license for new bindings in this project is (GPL-2.0
>> or BSD-2), like pointed by checkpatch.
> 
> 
> Yes, my employer holds the copyright. However, corporations don't work in the way
> you imagine. There is no one "owner" to speak to about re-licensing. The people
> who determine the license is an army of lawyers, with an extensive approval
> process.

Yes, I understand this. But also how corporations work should not really
be my problem. Especially that many of them were able to relicense even
existing work, not mentioning new work. New work is piece of cake
comparing with army of lawyers for existing, released work! Yet they
could...

> 
> What benefit does a BSD license hold for my employer over GPL v2 ?

As BSD is permissive, it does not force the employer or its customer to
release the derived works to customers. GPL requires it (simplifying
now). The employer and its customer have now choice. Dual license gives
more choices. More choices is beneficial for the company or its
customers, isn't?


> 
> Here the licenses currently used by the bindings,
> 
>       1 # SPDX-License-Identifier: BSD-2-Clause
>       1 # SPDX-License-Identifier: (GPL-2.0-only)
>       1 # SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
>       1 # SPDX-License-Identifier: (GPL-2.0-or-later)
>       3 # SPDX-License-Identifier: (GPL-2.0+ OR X11)
>       4 # SPDX-License-Identifier: GPL-2.0-or-later
>       4 # SPDX-License-Identifier: (GPL-2.0 OR MIT)
>       6 # SPDX-License-Identifier: (GPL-2.0)
>       7 # SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
>       7 # SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
>      11 # SPDX-License-Identifier: GPL-2.0+
>      12 # SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
>      12 # SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>      33 # SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
>      47 # SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>      56 # SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
>     102 # SPDX-License-Identifier: GPL-2.0-only
>     350 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>     511 # SPDX-License-Identifier: GPL-2.0
>     610 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>    1570 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> 
> Can you explain why so many are allowed to use GPL v2 , but my company is not
> allowed? Shouldn't these all be dual licensed if the project only allows dual
> license?

The rule is for new bindings. All new bindings are forced to follow this
rule. Why do you think we treat Cisco special? Who else was allowed? Can
we be specific?

Linking here existing bindings is not really an argument. What does it
prove?


> 
> It's very likely that new bindings will be made by making a copy of other
> bindings, then make modifications. If my company copied bindings which are GPL
> v2, then we are required to honor the license of the prior binding
> and that means we legally aren't allowed to relicense under BSD AFAIK.

So copy some bindings which are dual-licensed... Since this is new work,
you can do it.

> 
> Also the documentation for the bindings here Documentation/devicetree/
> 
> changesets.rst
> dynamic-resolution-notes.rst
> index.rst
> kernel-api.rst
> of_unittest.rst
> overlay-notes.rst
> usage-model.rst
> 
> all the rst files are GPL v2 and not dual license.

These are not bindings, so I do not understand your argument. What do
you prove? That non-bindings do not have to use bindings rules? Yes,
they are not bindings...

Anyway, I feel like we are making some useless circles and wasting quite
a lot of energy on trivial rule. I tried to explain it, but if you do
not like it - it's your choice. It will be a NAK.

Best regards,
Krzysztof

