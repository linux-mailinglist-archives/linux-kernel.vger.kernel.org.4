Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC4A713584
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 17:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjE0PxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 11:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjE0PxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 11:53:00 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF6CBA
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 08:52:57 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f3baf04f0cso1962780e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 08:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685202776; x=1687794776;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bLjznw17AJa9srYAX7PpPJBCrC7/RmyCURr/1TDqVk0=;
        b=YjD4CVNN4Q9wjXOI4a9yl5Nc+SlRdce5X65sQhxiffmNp28FbhJt/4wKqttaZWPInb
         v8cf2GqQFSQclKpy7/5mVC8/gevCHwnv2ECB1vh8zRcpXI5KpZ2+11KhHI/DpXW6ciq0
         yiueB0EtdTxB/bfYjeWmX3es8zBjtg9b77ocKVhClx4hfhvNaP5thankfXKGs3INX6ST
         aHKfxA++/42UMzlvZWodAuBu3Y/Qo4UnrJdP+rIlXEQXeyi7RhtRwi/20JR2v6dMXz7s
         6YJanHPLgP1ds6fuwHrl/vfDNC7VCObvHRVTJMgEn9Xa0Y78X/1n6wGO1FvHNtH91Ibj
         +iFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685202776; x=1687794776;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bLjznw17AJa9srYAX7PpPJBCrC7/RmyCURr/1TDqVk0=;
        b=idQMcNy6i7SuEtyH3F0ZqHABpCxHStQhE3EJ/bI7zIkzX6ecg6GPVJARck1hr8vfJ7
         jTR67MrKxZs9IU5eUyOgXJOZDlYJM63V2y/6mwR7DGuQxV3ACaYUwW9flq8d/pOpPswE
         DKxQfSR+fWXxCSiCG7GmVXEewfFU53kq7JPPrDVmfnI/TGBzTtL5n7NiKqPefpkaDFHg
         u5bhVAaWdD1D8VaOBpHI0POd2zPPr/atvt89/TOytlzEtZd5CZIHx0qqd5ZDZ7ogtBnW
         BCY3psSLc4xA7u/dOrzSS0xtSY0yo0A5vXeOrMEKSPwvwnIS71DnPaRDPSmgKO+pD/hh
         8p9g==
X-Gm-Message-State: AC+VfDyapw7o+Kv4qBy5zUbqdF4YfniXG+qhTUYITURL9m9e20E4B8UK
        ddoAMnGADbf6NzqXL3TfBgdeuQ==
X-Google-Smtp-Source: ACHHUZ6KnoHfXjU6y/OUhvxQQdvDRWrn3w/Nq4zoWpkMHmDXAq6Yc206wYHOv4Np18YwnN5iimBvew==
X-Received: by 2002:ac2:53a6:0:b0:4f4:b138:e998 with SMTP id j6-20020ac253a6000000b004f4b138e998mr1647222lfh.68.1685202775848;
        Sat, 27 May 2023 08:52:55 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id w9-20020ac24429000000b004f4ce1d4df6sm1166778lfl.47.2023.05.27.08.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 May 2023 08:52:55 -0700 (PDT)
Message-ID: <1aca6f57-9342-dba1-368c-76e649cde95e@linaro.org>
Date:   Sat, 27 May 2023 17:52:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/3] dt-bindings: media: camss: qcom,msm8996-camss: Add
 CAMSS power domain
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hansverk@cisco.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230526180712.8481-1-y.oudjana@protonmail.com>
 <20230526180712.8481-2-y.oudjana@protonmail.com>
 <20230526-obstruct-venus-5833511a58af@spud>
 <838b134d-46cb-6237-49b0-0c287141ebb3@linaro.org>
 <20230526-street-pox-2ff5ee106c43@spud>
 <8d89c14f-b2c2-7db2-f637-aa6d90273f4d@linaro.org>
 <631e5eec-853b-dce2-c474-62e76e83d7e6@linaro.org>
 <VKZAVR.M3FJVE7XKKY71@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <VKZAVR.M3FJVE7XKKY71@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.05.2023 08:05, Yassine Oudjana wrote:
> 
> On Fri, May 26 2023 at 10:36:32 PM +02:00:00, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>> On 26.05.2023 22:21, Bryan O'Donoghue wrote:
>>>  On 26/05/2023 21:19, Conor Dooley wrote:
>>>>  On Fri, May 26, 2023 at 09:05:47PM +0100, Bryan O'Donoghue wrote:
>>>>>  On 26/05/2023 20:46, Conor Dooley wrote:
>>>>>>>  +  - power-domain-names
>>>>>>  Why is this now required?
>>>>>>
>>>>>>  Thanks,
>>>>>>  Conor.
>>>>>>
>>>>>
>>>>>  Its an accurate description of the power/clock tree to have the top power
>>>>>  domain be switched on prior to the clocks that depend on it.
>>>>
>>>>  But what does that have to do with the *names* now being required?
>>>
>>>  oh the names
>>>
>>>  no toss that
>> this should be
>>
>> if:properties:compatible:blahblahmsm8996:then:required:power-domain-names
> 
> The only compatible in this binding is qcom,msm8996-camss, so what would this achieve?
You're right - I didn't notice and assumed it was a camss-common one.

Konrad
> 
>>
>> Konrad
>>>
>>>>
>>>>>  I think Yassine, you could probably include the majority of your
>>>>>  cover-letter text in this commit to explain this change a bit better.
>>>>
>>>>  I think it would be good to have that regardless.
>>>>
>>>>  Cheers,
>>>>  Conor.
>>>>
>>>>>  bod
>>>>     ^^^ I've been trying not to think about rugby since the weekend :(
>>>
>>>  Pockets O'Gara should have his paddy papers rescinded
> 
> 
