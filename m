Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4336A5DDA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 18:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjB1RAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 12:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjB1Q76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 11:59:58 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB41A9E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:59:56 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id eg37so42635958edb.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677603595;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G3CAwyg7sB/9VuXMErbSf0ksJrW8GjtJmRw6jmJ2whs=;
        b=CiOdaYBTbHw6f8urOsU3nUebrs2v3qJsywYf6Nui2a5tSCT3NcF2tQNX0guRJQmn9q
         3FgqpB4jjah97YIi9brUuV/4Q6LNCCpC8V8d4a883AbzFaQx67mjd8Gjw6u4ezEzq9t+
         5Pv6rROtmlR6Q6oIHX7k6BdVkopNJlbskTkLcb1ps9RQzFFEcv/BJ9mEwMDGdCLcvKxO
         ITAXDPRJr8gJsvg6Qg+DPKhVCD8anRcj12lMKSDwd/YjAvI+RehW3zj035/2IpgmBRmq
         2eIyeeokNUAG/DR3v04QtwNoNq8u/y/lVJ4ko/M6DiX4C5CDANNU3ohtXKWX6p+70WxM
         wcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677603595;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G3CAwyg7sB/9VuXMErbSf0ksJrW8GjtJmRw6jmJ2whs=;
        b=XIG180J/sgSARXtkzNftgXgCgBGsoju8i+P1+ttjcs5Z0wbL6b+z8epuB17J4W686J
         0V2KURtHyA7OIi4gmhOgi2TNE7MWWbvcYU5wPeMVMRRQnTpVj4wFWqmG0/vyxV/5Q5fr
         q3G5J/WPEs1WNqmBC7pkY6EBZvibrgB0dYXu2ROmSeRwVqSIwBZ95ZHpRUg3GI/9Q4PZ
         Z9Ix3rRIPU7xIiaPS1zXubBs3l9E1f3uNgpw6yT3cEMBNIR8OfeAer6pPC0KawfDhWKw
         JmEH8Cq8O368vohq0d9th1phj3DB3NIHq6BrjxwTS41r44p1Fl+qP+SpDAmbhsAPBwSn
         EuLQ==
X-Gm-Message-State: AO0yUKW4oScmZaG1aLdRIxAJN/ey0erVvLDddDkcRK4vBDdWVWvA6FNj
        F9WAP0qOecTOZlm9sKgK8Zgq23LGuWGvkUU0
X-Google-Smtp-Source: AK7set+dcX85NV/5y0rU/jfP/eUeE5rM4EcjfwgjoYFl+zNApB95vzbxhyvm070CBuKcjzf8qpWuRA==
X-Received: by 2002:a17:906:3b82:b0:889:d998:1576 with SMTP id u2-20020a1709063b8200b00889d9981576mr3063369ejf.66.1677603595302;
        Tue, 28 Feb 2023 08:59:55 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m30-20020a50d7de000000b004acb3026af2sm4637945edj.59.2023.02.28.08.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 08:59:54 -0800 (PST)
Message-ID: <be911895-4944-e983-1af5-b11ff5e8e7cc@linaro.org>
Date:   Tue, 28 Feb 2023 17:59:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 4/4] dt-bindings: syscon: Add StarFive syscon doc
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     William Qiu <william.qiu@starfivetech.com>,
        Rob Herring <robh@kernel.org>, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <20230215113249.47727-5-william.qiu@starfivetech.com>
 <20230220234335.GA615198-robh@kernel.org>
 <348796cc-72d9-4dcf-9f09-4c2aa55cb858@starfivetech.com>
 <20230227222904.GC1048218-robh@kernel.org>
 <f8d2b665-ce5d-81f8-8c55-81f1a4cb62b9@starfivetech.com>
 <54f51fa0-7821-b67b-b782-eb9a35b7bba9@linaro.org>
 <CAJM55Z85fitjBOcCLqad9W-a7h3iN9bxtctVGzPgqCbf5fWobw@mail.gmail.com>
 <a0168d89-3c30-55e1-cf4c-37f7fe90aae4@linaro.org>
 <CAJM55Z8dR4TDJNeO-qiS9CurfCWM1ccNigOA1fDb7S1VKCxv2Q@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJM55Z8dR4TDJNeO-qiS9CurfCWM1ccNigOA1fDb7S1VKCxv2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2023 15:59, Emil Renner Berthing wrote:
> On Tue, 28 Feb 2023 at 12:28, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> On 28/02/2023 12:02, Emil Renner Berthing wrote:
>>> On Tue, 28 Feb 2023 at 11:40, Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 28/02/2023 10:05, William Qiu wrote:
>>>>>
>>>>>
>>>>> On 2023/2/28 6:29, Rob Herring wrote:
>>>>>> On Tue, Feb 21, 2023 at 10:44:02AM +0800, William Qiu wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2023/2/21 7:43, Rob Herring wrote:
>>>>>>>> On Wed, Feb 15, 2023 at 07:32:49PM +0800, William Qiu wrote:
>>>>>>>>> Add documentation to describe StarFive System Controller Registers.
>>>>>>>>>
>>>>>>>>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>>>>>>>>> ---
>>>>>>>>>  .../bindings/soc/starfive/jh7110-syscon.yaml  | 51 +++++++++++++++++++
>>>>>>>>>  MAINTAINERS                                   |  5 ++
>>>>>>>>>  2 files changed, 56 insertions(+)
>>>>>>>>>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
>>>>>>>>>
>>>>>>>>> diff --git a/Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml b/Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
>>>>>>>>> new file mode 100644
>>>>>>>>> index 000000000000..fa4d8522a454
>>>>>>>>> --- /dev/null
>>>>>>>>> +++ b/Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
>>>>>>>>> @@ -0,0 +1,51 @@
>>>>>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>>>>>>> +%YAML 1.2
>>>>>>>>> +---
>>>>>>>>> +$id: http://devicetree.org/schemas/soc/starfive/jh7110-syscon.yaml#
>>>>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>>>>> +
>>>>>>>>> +title: StarFive JH7110 SoC system controller
>>>>>>>>> +
>>>>>>>>> +maintainers:
>>>>>>>>> +  - William Qiu <william.qiu@starfivetech.com>
>>>>>>>>> +
>>>>>>>>> +description: |
>>>>>>>>> +  The StarFive JH7110 SoC system controller provides register information such
>>>>>>>>> +  as offset, mask and shift to configure related modules such as MMC and PCIe.
>>>>>>>>> +
>>>>>>>>> +properties:
>>>>>>>>> +  compatible:
>>>>>>>>> +    items:
>>>>>>>>> +      - enum:
>>>>>>>>> +          - starfive,jh7110-stg-syscon
>>>>>>>>> +          - starfive,jh7110-sys-syscon
>>>>>>>>> +          - starfive,jh7110-aon-syscon
>>>>>>>>
>>>>>>>> Is 'syscon' really part of what the blocks are called? Is just 'stg',
>>>>>>>> 'sys' and 'aon' not unique enough?
>>>>>>>>
>>>>>>>> Rob
>>>>>>> Hi Rob,
>>>>>>>
>>>>>>> In StarFive SoC, we do have syscrg/aoncrg/stgcrg, which is uesd to be the clock
>>>>>>> controller, so 'syscon' is added to avoid confusion.
>>>>>>
>>>>>> You've only added to my confusion. 'syscrg' and 'sys-syscon' are 2
>>>>>> different h/w blocks and unrelated to each other? Or 'syscrg' is the
>>>>>> clock portion of 'sys-syscon'? In that case, 'syscrg' should be a child
>>>>>> of 'sys-syscon' or possibly just all one node. Please provide details on
>>>>>> the entire h/w block so we can provide better input on the bindings.
>>>>>>
>>>>>> Rob
>>>>>
>>>>> Hi Rob,
>>>>>
>>>>> It's my description that's problematic.'syscon' here refers to the hardware module
>>>>> inside our JH7110, which is different from the syscon interface in linux. The syscon
>>>>> I added now uses the syscon interface of linux to read and write the syscon register
>>>>> in our JH7110. So we decided to name it that way.
>>>>
>>>> You didn't really answer Rob's questions.
>>>>
>>>> Also, syscon is Linux term, so are you sure hardware module is called
>>>> like this? Hardware engineers took pure Linux name and used it?
>>>
>>> Yes, from the documentation I could find[1] there are CRG blocks
>>> (Clock and Reset Generator) and SYSCON blocks:
>>> SYS CRG
>>> STG CRG
>>> AON CRG
>>> SYS SYSCON
>>> STG SYSCON
>>> AON SYSCON
>>>
>>> The CRG blocks contain registers to control clocks and resets that
>>> follow a pattern used by the clock and reset drivers. The SYSCON
>>> blocks just seem to contain registers to control whatever didn't fit
>>> in any other blocks, but might be vaguely related to the peripherals
>>> that run off clocks controlled by the corresponding CRG block.
>>
>> The memory map [1] suggests these are indeed separate address spaces,
>> e.g. AON CRG, AON SYSCON and AON GPIO, but now I would argue that this
>> might be still one device - AON (or STG, SYS). Just like PCIE0 has four
>> address spaces, it does not mean you have four separate PCIE0 devices.
>> You have only one PCIE0, just like you have only one AON, one STG and
>> one SYS (System).
> 
> I see what you mean, but if you look into what the registers in the
> SYSCON blocks actually do it's not clear to me that they should be
> grouped with the clocks/resets any more than say the pinctrl/GPIO
> node. Maybe it's my fault for not giving you the full picture. Eg. for
> "system" and "always-on" there are blocks:
> 
> SYS CRG
> SYS SYSCON
> SYS IOMUX
> AON CRG
> AON SYSCON
> AON IOMUX
> 
> ..and it really don't see why eg. SYS CRG and SYS SYSCON should be
> thought of as one device, but not include SYS IOMUX then.

... include sys iomux as well, just like GPIO is included for AON.

> 
> As an examly the SYS SYSCON includes registers to control:
> - remapping of different peripherals from SD controller to video encoders
> - voltage select for certain GPIO pins
> - phy interface selection for ethernet and CAN
> - QuadSPI delay chain and SRAM configuration
> - PLL configuration
> - endian selection for the SD controller
> 
> To me this is pretty much exactly described by the syscon device tree binding:
> "System controller node represents a register region containing a set
> of miscellaneous registers. The registers are not cohesive enough to
> represent as any specific type of device. [..]"
> In any case it's clear that however the SYSCON blocks are represented
> in the device tree, a driver for it would need to export registers in
> the SYSCON block for other drivers to use.

You started entire sentence with "but" so you disagree but with what
exactly? The naming? But syscon is fine - hardware manual calls it like
that.

The point was that AON is one device (consisting of multiple blocks).

Best regards,
Krzysztof

