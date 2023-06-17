Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F36733F19
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 09:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345698AbjFQHS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 03:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFQHS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 03:18:27 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA0C1BB
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 00:18:26 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-518b69d5b5dso2163555a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 00:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686986305; x=1689578305;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gYO/xtxlWPcKQ7hELr1wNbt6Yex6spo4iuTcaVDyh50=;
        b=ERmskQTJkmvZr0JF/CqtyK8A8snSpwONS0miaSQurei5HvBAXJ+jALKUKLmfELAtsZ
         L1iHN5MdtJ2J29yNWkw9P0QcZv4Ls1PDU/EQjzwBJ4ID397aw7FL6O0LxtWk7efvvxCR
         qGhFoL41YSaWx25ayvE9KuPrj/z+XlQN1CH0fT8fAZh9SvW3B20i5GKhUiCar3pxD/ja
         CCsZUkAEPia7dVSwVmQK818xhZux2O0yk+WomGkxmURLBrfhY987U1uxB9PgN4+ECpMJ
         b5aNOPVlEH3kXW/WE0YbYvfWg3MfHYk02MiSIsEygP+iuJfjSeljQx9qxu1qPVdBlc8q
         Rn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686986305; x=1689578305;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gYO/xtxlWPcKQ7hELr1wNbt6Yex6spo4iuTcaVDyh50=;
        b=FoF+BiPp1ScItLzAcVpFJ6sZetd8b7FSWC9UhbAvJnDlFWVSww9ROYhMb26ZGWbfgY
         jv0s/4oFprtGUA5Tzi2r93oYT9xVJCEscLGmTCG+IT+BBheMaRm+7b+txxUQTyD8xIFW
         xnIKRxTy78MQYEYMJu3XG3WwDFLYAl41QfF+ugix4wDCi8HaiQs4DBsXHBsMaguk1n1c
         DL1ooC/nl6BV404OuZtrm3D402jHrednGfsUqP1t6JCB1RFtPvhoSNijA78YHaDCUvQA
         C15Vjy6nT2UxmzLdOTCuxHITH2TUzL2M7p62kh2EVAEjWQmrHXN/yveODnWFdHvxxeKR
         sYKg==
X-Gm-Message-State: AC+VfDxtPNanAbyuS1POkoMcVh7Xfy0Xpp3JpUyr8TNsM/32+D7/q5D4
        6A9C4YZvGHt/EKHGZCvu+r17qg==
X-Google-Smtp-Source: ACHHUZ4VodyCOcH6E8x7P28sx/QC9CHkCBqC3wS9Tm2EsRe/6ThiqAEA/myotQc2a5gu4m1GooOQOg==
X-Received: by 2002:a17:907:1611:b0:974:76:dcdd with SMTP id hb17-20020a170907161100b009740076dcddmr4572904ejc.55.1686986304810;
        Sat, 17 Jun 2023 00:18:24 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id r26-20020a1709067fda00b0096a1ba4e0d1sm11726076ejs.32.2023.06.17.00.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jun 2023 00:18:24 -0700 (PDT)
Message-ID: <1531062a-ce5f-8af0-b569-1b9eac3e7eac@linaro.org>
Date:   Sat, 17 Jun 2023 09:18:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] dt-bindings: arm: socionext: add bindings for the
 Synquacer platform
Content-Language: en-US
To:     Jassi Brar <jaswinder.singh@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org,
        ilias.apalodimas@linaro.org, masahisa.kojima@linaro.org
References: <20230616035813.255062-1-jaswinder.singh@linaro.org>
 <165dd295-1b3a-5062-772a-613a7bf6fd45@linaro.org>
 <CAJe_ZhdV3yaKUVD43duO4hkGMByJhq7x9bN+eBXJdBXdxgDneg@mail.gmail.com>
 <e2b98d80-8e9a-6083-3bc5-677bef0d3263@linaro.org>
 <CAJe_ZhfeYmxjR7Hcht0F9rc97VG2JCFEEFB+S5kUhSCmsut3Cg@mail.gmail.com>
 <661800ab-c363-49f2-4889-c458a7b298c4@linaro.org>
 <CAJe_Zhe9CKNC_B6y_YxEY_Nz765GQghg1ivYSOROJH8A7FKcnA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJe_Zhe9CKNC_B6y_YxEY_Nz765GQghg1ivYSOROJH8A7FKcnA@mail.gmail.com>
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

On 17/06/2023 01:18, Jassi Brar wrote:
> On Fri, 16 Jun 2023 at 15:34, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 16/06/2023 22:06, Jassi Brar wrote:
>>> On Fri, 16 Jun 2023 at 11:47, Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 16/06/2023 18:23, Jassi Brar wrote:
>>>>> On Fri, 16 Jun 2023 at 05:15, Krzysztof Kozlowski
>>>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>>>
>>>>>> On 16/06/2023 05:58, jaswinder.singh@linaro.org wrote:
>>>>>>> From: Jassi Brar <jaswinder.singh@linaro.org>
>>>>>>>
>>>>>>> Socionext's DeveloperBox is based on the SC2A11B SoC (Synquacer).
>>>>>>> Specify bindings for the platform and boards based on that.
>>>>>>
>>>>>> A nit, subject: drop second/last, redundant "bindings". The
>>>>>> "dt-bindings" prefix is already stating that these are bindings.
>>>>>>
>>>>> I can remove it, but I see many mentions like "Fix bindings for"  "Add
>>>>> binding for" etc in the subject line.
>>>>
>>>> Can we fix them as well?
>>>>
>>> ??
>> What else I can say to such argument?
>>
> It was not an argument, I agreed to remove it. I just observed that
> the nit-pick was arbitrary.
> And frankly
>    "dt-bindings: arm: socionext: add Synquacer"   is as misleading as
>    "dt-bindings: arm: socionext: add bindings for the Synquacer"   is improper.

"add Synquacer boards"
it is both precise and correct. No misleading.


> 
> 
>>>>>>
>>>>>> Binding without it's user is usually useless. Where is the user?
>>>>>>
>>>>> It is required for SystemReady-2.0 certification.
>>>>
>>>> For what? If there is no user, it is not required for SR. We don't
>>>> document compatibles for something which does not exist in the projects.
>>>>
>>> The dts/dtsi for synquacer will be added later.
>>> I am sure you are aware that there are countless bindings without
>>> actual use in any dts/dtsi.
>>
>> Bindings without user (so no DTSI and no driver)? Just few, not countless.
>>
> I disagree. But I don't have time to write a script to find
> compatibles/enums and properties in yaml/txt files that are not in any
> dts/dtsi file.
>  By that logic synquacer's spi/netsec/i2c/exiu bindings and drivers in
> kernel are illegit too?

Don't know which one you talk about.

> 
> Also the user may not be in Linux, but we keep "os-agnostic" bindings in Linux.

I did not say anything about Linux here. Look:

"does not exist in the projects."

> The synquacer dts/dtsi are in u-boot upstream. SR testsuite looks up

Sure, can you point it? U-Boot upstream is a valid project. Just like
many other upstream ones.

> the underlying platform name and checks if the bindings are merged
> upstream.
> While I am not against also submitting dts/dtsi in linux, I don't
> think the binding should be held at ransom.
> 
>>> When exactly did it become mandatory to
>>> have dts/dtsi for the bindings to be merged upstream?
>>
>> It was always. We do not want/need to document downstream stuff or
>> anything  just because it is somewhere there.
>>
> I am not asking you to merge an obscure internal revision of some SoC.
> Synquacer is a public development platform and a "96board" already
> certified for SR-1.0.

Without any reference to any project using this, it looks like you are.
Sorry.

Best regards,
Krzysztof

