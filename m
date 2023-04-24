Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E356EC769
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 09:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjDXHt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 03:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjDXHtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:49:53 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1C010E0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 00:49:51 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1a814fe0ddeso46592255ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 00:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1682322591; x=1684914591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GO24WXWfCTLwBE/ozcKbOtSXwD5bqdw++c+e1svOB+Q=;
        b=BT4zn/i4A+GcPJbM3S+qH0ai+Bltc3OvAM7QIhkEWEgkrF6cwwjtUfDSYXjyexUTHg
         +vc0cyIfMal61gfdzucPZp6X4oRToJ31pYIhUZMWfUHSJcdBw3rp3CspODBvbC2ekFXC
         M+zc85CmWV5ltNo8UCO/LZHuX1MM4jMyVyxcIqOZceWnC0wYpI0Ou8SJDci33k4DKwtT
         4tVBeSr1fbrzHpO0If5FRl9bwHwYIB73Ic5wUQK33umASC5mi09+45xKO+jgx/C8nZ4s
         BF0rn24NlWYCYYKtB5q+UPFTcBw0GvR8VkUs4ihfw1VPu0FV4RSgzgJnjICJNtZFfFm/
         lVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682322591; x=1684914591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GO24WXWfCTLwBE/ozcKbOtSXwD5bqdw++c+e1svOB+Q=;
        b=gdVGQ1bjQqi+46ahtyaKekIwauFCogx0bo5RIF2uuvLPSDGTyAxnYqE9cGWlqtqG/R
         rb1vAm/gtviN3Lb5nsV+YD92Lqco70yOWHLx1VrwODyAkN5AF0Hiw1DNN1bblVivozMF
         HgI3e50FJcSEJkkKLS076gAQBgLuLyz0D83794bNsCEr7UIaPcA7jcK7ni5GNK0itz7Q
         x5MV7+lk6OjwoJFr7D6C1EdGraYgVULSHwBnEKNskHYhf5PVMpu+y0H6YgFwnMzF4oGM
         4IkEr3JIs2wJ+bmSfQhaio0TtjFTwWVC4m4FJJtre+vbqMvR6rzTZBjesTiYVF6UgDQj
         ev6A==
X-Gm-Message-State: AAQBX9cX1+2YnTXyWnqGdkMYNmo3mHcuhcqcLRpjsgmrScC2wHTr5/mH
        ktg3G6IRHzqWJidDqYC8r46QJWFNI6I6Edo3MWU=
X-Google-Smtp-Source: AKy350ZOZKJs8gSDtDUu2uc+8imsRM/UgIJ8XFhbNcLTrGky+TNXqXY7/e8ZOCna0oN6CIwrz4tHRA==
X-Received: by 2002:a17:902:e742:b0:1a9:1b4:9fd5 with SMTP id p2-20020a170902e74200b001a901b49fd5mr15136501plf.68.1682322590943;
        Mon, 24 Apr 2023 00:49:50 -0700 (PDT)
Received: from ?IPV6:2405:201:d02f:d855:461d:14be:2cce:b776? ([2405:201:d02f:d855:461d:14be:2cce:b776])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902bf4800b00198d7b52eefsm6046954pls.257.2023.04.24.00.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 00:49:50 -0700 (PDT)
Message-ID: <51b6feba-de3b-0d9f-222d-09bed5050cc3@9elements.com>
Date:   Mon, 24 Apr 2023 13:19:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] dt-bindings: regulator: Add dt property
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230418145051.4192963-1-Naresh.Solanki@9elements.com>
 <0da2b301-8780-48c0-a5dc-326474011e8d@hatter.bewilderbeest.net>
 <9f425205-c395-648a-3f42-a776c7580a8f@9elements.com>
 <20230421181013.GA1561415-robh@kernel.org>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <20230421181013.GA1561415-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 21-04-2023 11:40 pm, Rob Herring wrote:
> On Thu, Apr 20, 2023 at 01:52:30PM +0530, Naresh Solanki wrote:
>> Hi Zev,
>>
>> On 20-04-2023 05:31 am, Zev Weiss wrote:
>>> On Tue, Apr 18, 2023 at 07:50:50AM PDT, Naresh Solanki wrote:
>>>> Add DT property regulator-supplies.
>>>> This enables us to couple one or more regulator output to gether. This
>>>> is use in case of Single connector having 2 or more supplies.
>>>>
>>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>>> ---
>>>> .../bindings/regulator/regulator-output.yaml         | 12 +++++++++---
>>>> 1 file changed, 9 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/regulator/regulator-output.yaml
>>>> b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
>>>> index 078b37a1a71a..17f683d3c1f3 100644
>>>> --- a/Documentation/devicetree/bindings/regulator/regulator-output.yaml
>>>> +++ b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
>>>> @@ -21,13 +21,19 @@ properties:
>>>>    compatible:
>>>>      const: regulator-output
>>>>
>>>> -  vout-supply:
>>>> +  regulator-supplies:
>>>>      description:
>>>> -      Phandle of the regulator supplying the output.
>>>> +      Specifies the name of the output supply provided by the regulator.
>>>> +      Defaults to "vout".
>>>> +    default: "vout"
>>>> +
>>>
>>> Was this meant to be specified as a string-array to allow providing
>>> multiple names?
>> Yes. This is string-array.
>>>
>>>> +patternProperties:
>>>> +  ".*-supply":
>>>> +    description:
>>>> +      Specified the phandle for various supplies
>>>>
>>>> required:
>>>>    - compatible
>>>> -  - vout-supply
>>>>
>>>> additionalProperties: false
>>>>
>>>>
>>>
>>> I think it would be nice to also update the examples to show what a
>>> multi-supply instance would look like.
>> Ack. Will do that.
>>>
>>> A slightly more descriptive subject line would also be good -- "Add dt
>>> property" is a bit vague.
>> Suggestion ?
>> How about like 'Allow multiple supplies' or 'Add support for multiple
>> supplies'
> 
> And indicate this is for regulator-output, As-is looks like it's
> something for all regulators.
Thanks for bringing that to my notice. Will make:
dt-bindings: regulator-output: Add dt property
> 
> Rob
Regards,
Naresh
