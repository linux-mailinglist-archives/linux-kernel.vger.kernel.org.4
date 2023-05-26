Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B6F712E2D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 22:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbjEZUgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 16:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjEZUgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 16:36:39 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA94F3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:36:36 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f4b80bf93aso1276930e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685133395; x=1687725395;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0QFhrmXQWyPgc4s42uFYQSvB0IVUNfYN59jpnyyV6Vs=;
        b=uJWgr7gdiQRVYWMqQwr6at476XhkdPRKqV5e+zq3kYUgSg+Vq0zR0rqKQvcdqE80zV
         ySerW8QnhZC9QcacTabho3bPAe3k4220XZ/Rxpj//ImMZrbB/SlkXLS2aI4uYoGTu5rb
         7O35mirEZq4n72JQaHdjN41K/PvVtNNIhQ6RcAcgKR+fyAhuxZJQFBFnkhWzhhoewP24
         OMc+QXO/xSPVno7k8WwVL3Tf//PUC9Zx4LmRoskhFrdlf1v5CfhVGrjFp6jPc4DwRsC4
         Es5S/5R6Lyk59x+EYckgmsk6fjoWaccyat0y7TYka4uXPxSShMjimp9GWblHiiq56uPj
         dlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685133395; x=1687725395;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0QFhrmXQWyPgc4s42uFYQSvB0IVUNfYN59jpnyyV6Vs=;
        b=Wcc0NL6+i4wW6x2uOe/v/Sq/39/ENAKsjUoDn4P1DYz+0FrFphm1d3VMERUnfA7vuD
         KWj0Cy0I07hhaUDMm6+DLw0MVBPjOeuLSfWHlYeo2EfxEgPM2h7u3gUnX1Qbb9KFRDdO
         o0npjZG9gq73AuMXIfPh+k7f4H+6luCWGqEdBytyUihJcJNGlXJ6rT97SO95z4CYTRUh
         SkOcUyq7HJhnSmPtSMKAv3CFBJWyFjeHeFv8CMDSsVe4onuY7ZuwiGEbQbx6Gv3Inqs1
         UjEgQ+BLPtyuI9aHxoxxAaangdWqS6ewP2Wvc+lUJFpdy4U9rt+gNgFcRlpQc2XuMDOd
         5LsA==
X-Gm-Message-State: AC+VfDxSgs9eqsdmH0lVlUwJg67DP5cshjWm6YcdY/FJR0+RA7CYSL+R
        J5yvQdEb1eqXxpUjKpM65FQhDg==
X-Google-Smtp-Source: ACHHUZ6lWok7qQ7Kt8GzUmHwRGY5EScRevrnB5nxrPp83bTTphSpwPirF9ZqNpltX2qMqoQ5yMBvYQ==
X-Received: by 2002:ac2:5ed0:0:b0:4f3:b207:65ff with SMTP id d16-20020ac25ed0000000b004f3b20765ffmr833070lfq.24.1685133394986;
        Fri, 26 May 2023 13:36:34 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id w25-20020a05651204d900b004cc8196a308sm774572lfq.98.2023.05.26.13.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 13:36:34 -0700 (PDT)
Message-ID: <631e5eec-853b-dce2-c474-62e76e83d7e6@linaro.org>
Date:   Fri, 26 May 2023 22:36:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/3] dt-bindings: media: camss: qcom,msm8996-camss: Add
 CAMSS power domain
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Conor Dooley <conor@kernel.org>
Cc:     Yassine Oudjana <yassine.oudjana@gmail.com>,
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <8d89c14f-b2c2-7db2-f637-aa6d90273f4d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.05.2023 22:21, Bryan O'Donoghue wrote:
> On 26/05/2023 21:19, Conor Dooley wrote:
>> On Fri, May 26, 2023 at 09:05:47PM +0100, Bryan O'Donoghue wrote:
>>> On 26/05/2023 20:46, Conor Dooley wrote:
>>>>> +  - power-domain-names
>>>> Why is this now required?
>>>>
>>>> Thanks,
>>>> Conor.
>>>>
>>>
>>> Its an accurate description of the power/clock tree to have the top power
>>> domain be switched on prior to the clocks that depend on it.
>>
>> But what does that have to do with the *names* now being required?
> 
> oh the names
> 
> no toss that
this should be

if:properties:compatible:blahblahmsm8996:then:required:power-domain-names

Konrad
> 
>>
>>> I think Yassine, you could probably include the majority of your
>>> cover-letter text in this commit to explain this change a bit better.
>>
>> I think it would be good to have that regardless.
>>
>> Cheers,
>> Conor.
>>
>>> bod
>>    ^^^ I've been trying not to think about rugby since the weekend :(
> 
> Pockets O'Gara should have his paddy papers rescinded
