Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45627723791
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjFFGWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbjFFGVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:21:24 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CBB10D0
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:21:14 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-514953b3aa6so7557653a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 23:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686032473; x=1688624473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EKXvzn2poVGJdsfYKbvuXacn3q92H1IebHnIe7X+uN0=;
        b=jlJ3EkL3KfeusIjNW1MwW8L0u5QdNAbDTCOSSlvaa4+8ByqWx8eKehlhPyVomF14YR
         Q4yMNx/ZNO+tbA06TnmOt5ZbY4skTbuT7ciVuRnISUxPLfBBAOU86l4FJEHL+O5YDD1D
         Ay7k2m4XLJtb+5S1L+//MRgJMhsab0PcpkMjuHulBXJLjdXDL6aSMlkna1zmqRZnfnjN
         /+DBT0Om4KsggecIH6iJ/94zgTzD9Fmnn32tzXLzRVnpPgynouzfNvjoSioFWfNywY8j
         3f8F3zKmVF/tJ5MXUWj3LeLgQ7mTAcTf+TYlzDFyAGnoAjF6qDvsyTCV97bsw69Oykzi
         PgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686032473; x=1688624473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EKXvzn2poVGJdsfYKbvuXacn3q92H1IebHnIe7X+uN0=;
        b=dNlNgmTSU94pEKid26f0Q1XRPg52EVYH5EPGFbfz9Jq6tcFXi2V/KFomhAcFri4fN8
         1Gai/SGcetQLeFAtSb7nOhjvc2bOo/it/j2soO5LBCk8n4dTyYWmvcImzSFCyLtIh88v
         VEytxgMWa0Tbidest8lgxA1C1uVw//pL/v7g9+oE6BtkYWdtFheIwxLgh/fVHlidtjYb
         t65xtZVswW+o7CKchYDGz1vXyUq2gyZ7K5AJDXf0QOyqTf0Ug1p7QMsYTV233X+IDvey
         E3+omV2uUTYuLmkJZqfv8xhG9/DJfayal0BgooPgkj3Pwg+xG5NEjdzh3lqEhl8GYekK
         iaNQ==
X-Gm-Message-State: AC+VfDwTS+yklQfBylWKNkUhyxYCgaVDKPgwztmqhKQmKsuS7jucjeED
        VjLhszU3QdrH98MDK+2hKSrMyg==
X-Google-Smtp-Source: ACHHUZ6LrRzgCaH4R/n3oEQswN/bZeXWD6KgFX1d8mHfrscBkVJdCfpXHpiKQnpgvPEbD5V6/MdiVw==
X-Received: by 2002:a17:907:96a7:b0:967:d161:61c6 with SMTP id hd39-20020a17090796a700b00967d16161c6mr1476109ejc.3.1686032473046;
        Mon, 05 Jun 2023 23:21:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id d5-20020aa7ce05000000b0051632dc69absm4649926edv.86.2023.06.05.23.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 23:21:12 -0700 (PDT)
Message-ID: <1ba84b37-ae64-ef0b-b7cd-8941916962ca@linaro.org>
Date:   Tue, 6 Jun 2023 08:21:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/2] dt-bindings: input: touchscreen: Add ilitek 9882T
 touchscreen chip
Content-Language: en-US
To:     cong yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.torokhov@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dianders@chromium.org,
        hsinyi@google.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230605060524.1178164-1-yangcong5@huaqin.corp-partner.google.com>
 <20230605060524.1178164-2-yangcong5@huaqin.corp-partner.google.com>
 <6818f4b0-4222-c3bb-c55f-bc0d26d7a681@linaro.org>
 <CAHwB_NLOrecxxP0kGS2ycXAw93XOSOiR+qPo50D292tDNKiqQQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAHwB_NLOrecxxP0kGS2ycXAw93XOSOiR+qPo50D292tDNKiqQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2023 04:18, cong yang wrote:
> Hi,Krzysztof
> 
> On Mon, Jun 5, 2023 at 6:34 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 05/06/2023 08:05, Cong Yang wrote:
>>> Add an ilitek touch screen chip ili9882t.
>>>
>>> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
>>> ---
>>>  .../bindings/input/elan,ekth6915.yaml         | 23 ++++++++++++++++---
>>>  1 file changed, 20 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
>>> index 05e6f2df604c..f0e7ffdce605 100644
>>> --- a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
>>> +++ b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
>>> @@ -15,11 +15,14 @@ description:
>>>
>>>  properties:
>>>    compatible:
>>> -    items:
>>> -      - const: elan,ekth6915
>>> +    enum:
>>> +      - elan,ekth6915
>>> +      - ilitek,ili9882t
>>>
>>>    reg:
>>> -    const: 0x10
>>> +    enum:
>>> +      - 0x10
>>> +      - 0x41
>>>
>>>    interrupts:
>>>      maxItems: 1
>>> @@ -29,11 +32,13 @@ properties:
>>>
>>>    vcc33-supply:
>>>      description: The 3.3V supply to the touchscreen.
>>> +                 If using ili9882t then this supply will not be needed.
>>
>> What does it mean "will not be needed"? Describe the hardware, not your
>> drivers.
>>
>> I don't think you tested your DTS. Submit DTS users, because I do not
>> believe you are testing your patches. You already got such comment and I
>> don't see much of improvements here.
> 
> I ran make dt_binding_check in the codebase root directory before
> sending the V2 Patch, and there were no errors or warnings (the V1
> version run reported some errors). Is there some other way to test DTS
> ?

https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/


Best regards,
Krzysztof

