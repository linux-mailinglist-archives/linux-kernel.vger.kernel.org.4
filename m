Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325386DFC91
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjDLRS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjDLRS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:18:56 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2531EF1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:18:54 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id z9so3674366ejx.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681319932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EPJEH3FoLa1rfORHEvQ5hjrz23haruAfnpdzErS1ai8=;
        b=s2XGuKnZ2nJ/CbhNLWaF9g6Aw1AASjqRguCq/D6DA+klNrvJZIkgYlNc2EFnohENtg
         QGTEkJnTpMRTX4q9xwPh9epf6chdYwTReYS4zPt/caqyyLW3frW/tqhxs4la3udTCSlQ
         jmIuYycDtBM4FfkT14BrGTcj0Ix591OWbAWb0yIWQJecQze7rUYqBsZrDmROIYeR4xVP
         EuMj6cafKkwtjvG0DfHNw2Z6H3VjCezbcWJCf6B4edaNx5G3LkEQQ1NyOEWfjVURJ6Oq
         RceuXiSNIfta9YZYdPldBKrJ+xjeHs58nOvWd0pZ6IYMTc78ZDZjTIhQN5wgQH64SWam
         nuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681319932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EPJEH3FoLa1rfORHEvQ5hjrz23haruAfnpdzErS1ai8=;
        b=Ac8YdLJMrDYBKXxt3bvtHcPgKl/uJ7Yfi5BMNPl6eY6UlYvYL1JD+t4B7t6CfcmbnB
         GNpxAYkrwU5GnfPRzQW6hN0H9iIVEwj9mGH4NMLj4izliszpwL4D0LhRRDljFSMd+zDj
         zutFPOJq041fPnmQBgTkMgpNMOa2hn3xb9xnhPJbcoqN0POiy9ef5vl2q7YmuIgdM3hT
         1opvDUPuLXrtr32raj5yRfDn9gDy13ddyYJUP91h+mSD5GV2l7j1n/zmaRSHbIPPL69v
         ssJFFcaAtSr6iKir6L4aRidAet0FpjV58/hC31uZf2KvlSMh270JjkY3SlIOU6qU/lII
         8XPA==
X-Gm-Message-State: AAQBX9cJH64VdkcfUaOjUh9keBj48W+oGh8e0uEhd0ZBGfyIDd14kIkM
        XPwkHymT5714nsVInTke2QYheQ==
X-Google-Smtp-Source: AKy350b2pPcG4c3cLsNSSyAIMbVMGJak6H/xG31Zx0n6zpMq7dL2KDnNzHOX21gVkB4uw41Husb0Pw==
X-Received: by 2002:a17:906:7a44:b0:94e:4586:f135 with SMTP id i4-20020a1709067a4400b0094e4586f135mr4091908ejo.6.1681319932471;
        Wed, 12 Apr 2023 10:18:52 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:938a:b3db:7c59:795e? ([2a02:810d:15c0:828:938a:b3db:7c59:795e])
        by smtp.gmail.com with ESMTPSA id q11-20020a50aa8b000000b00504706aa54esm6654415edc.57.2023.04.12.10.18.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 10:18:52 -0700 (PDT)
Message-ID: <b76b764d-79b2-2a83-33a4-b2bed5c25d69@linaro.org>
Date:   Wed, 12 Apr 2023 19:18:51 +0200
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
 <317c09a8-4df3-0a33-62b4-f5a496dfa0ca@linaro.org>
 <20230412170111.GS1391488@zorba>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230412170111.GS1391488@zorba>
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

On 12/04/2023 19:01, Daniel Walker (danielwa) wrote:
>>
>> Yes, I understand this. But also how corporations work should not really
>> be my problem. Especially that many of them were able to relicense even
>> existing work, not mentioning new work. New work is piece of cake
>> comparing with army of lawyers for existing, released work! Yet they
>> could...
>>
>>>
>>> What benefit does a BSD license hold for my employer over GPL v2 ?
>>
>> As BSD is permissive, it does not force the employer or its customer to
>> release the derived works to customers. GPL requires it (simplifying
>> now). The employer and its customer have now choice. Dual license gives
>> more choices. More choices is beneficial for the company or its
>> customers, isn't?
> 
> I don't think we derive value from this because Cisco only sells chips internally, not
> externally.

My answer was generic: dual license is beneficial for a company. Not
specific: dual license is beneficial for Cisco. It might be the case you
do not have benefits from dual license, but you also do not loose anything.

Anyway, if SW release (for such chip) ever reaches external customer,
then it matters. GPL compliance is for some lawyers huge pain and scary
stuff, although should not be...

> 
>>
>>>
>>> Here the licenses currently used by the bindings,
>>>
>>>       1 # SPDX-License-Identifier: BSD-2-Clause
>>>       1 # SPDX-License-Identifier: (GPL-2.0-only)
>>>       1 # SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
>>>       1 # SPDX-License-Identifier: (GPL-2.0-or-later)
>>>       3 # SPDX-License-Identifier: (GPL-2.0+ OR X11)
>>>       4 # SPDX-License-Identifier: GPL-2.0-or-later
>>>       4 # SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>>       6 # SPDX-License-Identifier: (GPL-2.0)
>>>       7 # SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
>>>       7 # SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
>>>      11 # SPDX-License-Identifier: GPL-2.0+
>>>      12 # SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
>>>      12 # SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>      33 # SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
>>>      47 # SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>>>      56 # SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
>>>     102 # SPDX-License-Identifier: GPL-2.0-only
>>>     350 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>     511 # SPDX-License-Identifier: GPL-2.0
>>>     610 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>    1570 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>
>>> Can you explain why so many are allowed to use GPL v2 , but my company is not
>>> allowed? Shouldn't these all be dual licensed if the project only allows dual
>>> license?
>>
>> The rule is for new bindings. All new bindings are forced to follow this
>> rule. Why do you think we treat Cisco special? Who else was allowed? Can
>> we be specific?
>>
>> Linking here existing bindings is not really an argument. What does it
>> prove?
> 
> It shows the "rule" is not consistent. Sometime GPL v2 is ok, sometimes not.
> 
> Here's is the last GPL v2 only binding added,
> 
> commit f9b8556d5799b612404e19b21dd7624d551f71df
> Author: Johan Jonker <jbx6244@gmail.com>
> Date:   Thu Dec 22 15:28:53 2022 +0100
> 
>     dt-bindings: usb: convert fcs,fusb302.txt to yaml

This is not a new binding. Read again the title.

> 
>     Convert fcs,fusb302.txt to yaml.
> 
>     Changed:
>       Add vbus-supply property
> 
>     Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>     Reviewed-by: Rob Herring <robh@kernel.org>
>     Link: https://lore.kernel.org/r/0336a3c4-4a43-c983-11d7-e2ae16187fc8@gmail.com
>     Signed-off-by: Rob Herring <robh@kernel.org>
> 
> 
> This was only a few months ago. It's a new yaml file with a new license line, made
> from an existing text file. I can see how maybe this uses parts of the GPL v2
> txt files so you could not relicense to BSD.

It's not a new binding. The license was GPLv 2.0, so it would have to be
relicensed with agreement of all copyright holders.

> 
> here's one less than a year ago,
> 
> commit bdeb3cf013d0d1d09ff3bf66ba139ab259dab3a4
> Author: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Date:   Mon Jul 4 20:24:48 2022 +0300
> 
>     dt-bindings: clock: separate bindings for MSM8916 GCC device
> 
>     Separate bindings for GCC on Qualcomm MSM8916 platforms. This adds new
>     clocks/clock-names properties to be used for clock links.
> 
>     Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
>     Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>     Signed-off-by: Bjorn Andersson <andersson@kernel.org>
>     Link: https://lore.kernel.org/r/20220704172453.838303-3-dmitry.baryshkov@linaro.org
> 
> 
> uses one line from a text file that's GPL v2. 

It was probably based on old binding (from which it separated) which was
GPL-2.0. As derivative work it had to be also GPL-2.0.

However that binding actually should be relicensed, because we have the
right to do it for Qualcomm. Also mistakes happen, on submitters side
and reviewers as well. Feel free to find all mistakes I did in review.
There will be tons of them. Only the one who does not review, makes no
mistakes.


>>>
>>> It's very likely that new bindings will be made by making a copy of other
>>> bindings, then make modifications. If my company copied bindings which are GPL
>>> v2, then we are required to honor the license of the prior binding
>>> and that means we legally aren't allowed to relicense under BSD AFAIK.
>>
>> So copy some bindings which are dual-licensed... Since this is new work,
>> you can do it.
> 
> Writing the binding is already done. It's hard to go back.

You can go back any time. Just "rm -fr" and write again. Since there is
no other copyright holder than you (and/or your employer), you can do
pretty much anything you wish with it.

> 
> Is this dual license mandate documented someplace,

Run checkpatch and do not send patches which fail.

> because it seems like a
> massive trap.

Trap? Of what? Srsly... I heard GPL is a trap, but never about dual or
BSD license.

> 
>>>
>>> Also the documentation for the bindings here Documentation/devicetree/
>>>
>>> changesets.rst
>>> dynamic-resolution-notes.rst
>>> index.rst
>>> kernel-api.rst
>>> of_unittest.rst
>>> overlay-notes.rst
>>> usage-model.rst
>>>
>>> all the rst files are GPL v2 and not dual license.
>>
>> These are not bindings, so I do not understand your argument. What do
>> you prove? That non-bindings do not have to use bindings rules? Yes,
>> they are not bindings...
>>
>> Anyway, I feel like we are making some useless circles and wasting quite
>> a lot of energy on trivial rule. I tried to explain it, but if you do
>> not like it - it's your choice. It will be a NAK.
> 
> I'm pointing out that your dual license mandate has problems. Another issue is
> you have dts files exclusively GPL v2,

It's not a problem... but even if it was, why do you not want to
dual-license them as well?

> and the dt bindings have dts fragments
> which then have to be relicensed under BSD.

Point me to the DTS fragment in this patch. I could not find it.

> 
> Are you as well going to nak our dts files? Or are those ok without bindings ?

1. All compatibles must be documented, so if your DTS does not follow
this rule I will NAK.
2. New platforms are supposed to have zero dtbs_check warnings, which is
depending on above (1) plus enforces DT schema conversion.


Best regards,
Krzysztof

