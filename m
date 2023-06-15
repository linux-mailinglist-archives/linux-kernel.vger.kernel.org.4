Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A727315B6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343783AbjFOKqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245751AbjFOKqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:46:09 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B74F2130;
        Thu, 15 Jun 2023 03:46:07 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-66615629689so2019241b3a.2;
        Thu, 15 Jun 2023 03:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686825966; x=1689417966;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ceGenVHiIhT8J4bTA/hroU5FeyMJg9le+aNbGkYaWs=;
        b=cqkhwrEoP1Xx4HkeZu5R/+cfyAHIBHX6TaK8vAygzYjfEBnkTuPEyjb7EDM2+5xUCT
         tewXBd4oev5wmuT8BpIT0dibvzMotcXJ3131B8zrQno0tEE/vGwiuLIcI6HPPZMh1f8E
         KTtKk5yZe6X//wDWP7iOVG9QVMslFP/Yn/GCf5kt6ckER0YQaPn40jem+PupxfpQnk9/
         T4RkO5Af8COpzQ4O9kqrMaxtTwr3TjBWZl61GSbaqB8dworaBA4xPEAXXzYXPGIsMVC7
         W91xGTuaoxrWPwMcH4eOYo/DARMWkrOkcBnRkEfc4isFwxEzNOuXwy61yXgND3kppN0C
         fXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686825966; x=1689417966;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ceGenVHiIhT8J4bTA/hroU5FeyMJg9le+aNbGkYaWs=;
        b=XOy5gPgS1gYpD01yxXSBvdFPoKpC/qtahXz57hngaXZ6z1tq0onDAvieYPLJQqit3T
         pEmVmzR0EfCo4yll1fEq6/VE6xiCCeBlf+CyXiwLVqQmJYrC3CM9P29GPNz/a96jTOYM
         MbvTqFpnYbcb4dHTAnt4f9Y0lQwFt2Icd+zHyjWevRB2pd59w7Jh/FObwZogtCVwrj4O
         2iHg54bkIg3vnVvDHT1MKs5BpxTqBEVxnVUT1CEikXMFyON5WrAIVHG+EEBvDhVyw1/q
         HNYV+69PtxuiPz2QDNfNyrVgyKXu1A7zIEXr13lCqiwbgpKzc2scs3bhQGEb1MCUM572
         SJNQ==
X-Gm-Message-State: AC+VfDyKIq7gS/DSjEHh0rHxa3aefKpLDGmslJ4H8gddsj4kkxwmFjxJ
        IW17nviYpUtX+1TNryq23AA=
X-Google-Smtp-Source: ACHHUZ5KeIs+4puHmWbUL4V38X9p8iuVjK6/GwQTDrX/TdnxlKj0c4p7Y6LS7F2orDmZvyOSppxlKg==
X-Received: by 2002:a05:6a20:2e13:b0:11e:7273:7edd with SMTP id be19-20020a056a202e1300b0011e72737eddmr693906pzb.23.1686825966256;
        Thu, 15 Jun 2023 03:46:06 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id p3-20020a62ab03000000b00646e7d2b5a7sm1136778pff.112.2023.06.15.03.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 03:46:05 -0700 (PDT)
Message-ID: <4fd20e8d-49fd-be07-e4e5-0860fdb07125@gmail.com>
Date:   Thu, 15 Jun 2023 18:46:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v14 1/1] tty: serial: Add Nuvoton ma35d1 serial driver
 support
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, Lee Jones <lee@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        soc@kernel.org, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230612025355.547871-1-ychuang570808@gmail.com>
 <20230612025355.547871-2-ychuang570808@gmail.com>
 <2023061338-lunchbox-snorkel-e6a9@gregkh>
 <f8eb6114-8248-8886-b301-c2886e50e016@gmail.com>
 <2023061356-matchbook-footwear-d142@gregkh>
 <35e768ad-7f15-48a4-9c38-09570026cf71@app.fastmail.com>
 <2023061555-enlighten-worshiper-c92d@gregkh>
Content-Language: en-US
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <2023061555-enlighten-worshiper-c92d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/15 下午 06:19, Greg Kroah-Hartman wrote:
> On Tue, Jun 13, 2023 at 05:44:23PM +0200, Arnd Bergmann wrote:
>> On Tue, Jun 13, 2023, at 16:49, Greg KH wrote:
>>> On Tue, Jun 13, 2023 at 06:58:32PM +0800, Jacky Huang wrote:
>>>> On 2023/6/13 下午 06:28, Greg KH wrote:
>>>>> On Mon, Jun 12, 2023 at 02:53:55AM +0000, Jacky Huang wrote:
>>>>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>>>>
>>>>>> This adds UART and console driver for Nuvoton ma35d1 Soc.
>>>>>> It supports full-duplex communication, FIFO control, and
>>>>>> hardware flow control.
>>>>> You get a full 72 columns for your changelog :)
>>>>>
>>>>>> --- a/include/uapi/linux/serial_core.h
>>>>>> +++ b/include/uapi/linux/serial_core.h
>>>>>> @@ -279,4 +279,7 @@
>>>>>>    /* Sunplus UART */
>>>>>>    #define PORT_SUNPLUS	123
>>>>>> +/* Nuvoton MA35 SoC */
>>>>>> +#define PORT_MA35	124
>>>>>> +
>>>>> Why is this change needed?  What userspace code is going to rely on it?
>>>>>
>>>>> thanks,
>>>>>
>>>>> greg k-h
>>>> Because the serial driver requires a port->type, and almost all serial
>>>> drivers defined their port type here. We follow the practice of most serial
>>>> drivers here.
>>>> If we don't do it this way, we would have to directly assign a value to
>>>> port->type. However, such modifications were questioned in the past,
>>>> which is why we changed it back to defining the port type in serial_core.h.
>>> I really really want to get rid of this list, as it's a UAPI that no one
>>> uses.  So please don't use it, it doesn't help anything, and while the
>>> serial driver might require it, it doesn't actually do anything with
>>> that field, right?  So why don't we just set all of the values to the
>>> same one?
>> I don't see how Jacky can come up with a patch to do this correctly
>> without more specific guidance to what exactly you are looking for,
>> after the last 123 people that added support for a new port got
>> that merged.
> I keep complaining about this, when I notice it.  Just use the "default"
> port type in the serial driver and don't add a new type here and it
> should just work, right?
>
>> I checked debian codesearch and found only three obscure packages that
>> accidentally include this header instead of including linux/serial.h,
>> a couple of lists of all kernel headers, and none that include it on
>> purpose. I agree that this header should really not exist in uapi,
>> but the question is what exactly to do about it.
>>
>> Possible changes would be:
>>
>> - add a special value PORT_* constant other than PORT_UNKNOWN that
>>    can be used by serial drivers instead of a unique value, and
>>    ensure that the serial core can handle drivers using it.
> Why do we need a special constant?
>
>> - move all values used by the 8250 driver from serial_core.h
>>    to serial.h, as this driver actually uses the constants.
> Makes sense.
>
>> - Move the remaining contents of uapi/linux/serial.h into the
>>    non-uapi version.
>>
>> - Change all drivers that only reference a single PORT_*
>>    value to use the generic one.
> I think this is the best thing to do.
>
> thanks,
>
> greg k-h

I will remove the definition of PORT_MA35 without modifying serial_core.h.

However, we still need to assign a value to port->type. So, can we follow
the approach used in the LiteUART driver and directly assign port->type = 1?


Best regards,
Jacky Huang
