Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C506B2EC6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 21:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjCIUee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 15:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCIUeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 15:34:31 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9A2E388E;
        Thu,  9 Mar 2023 12:34:29 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id e13so3118062wro.10;
        Thu, 09 Mar 2023 12:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678394068;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7VHKM1TZh/tpZ43OaDrF8rGSweyNHxW44fC7EAr49fo=;
        b=WAVzbaZbnD3x4HuwSI9TrmKRgwe7QVY8gXLTbm6xVVf56nymD2XpBzn1XFD3vo/BWG
         gt3ukYKdL85ATHA8iaFqyl2Heey+2Rk+FZTe1VtAg64rtwUKp2aZb0DS5tixa9EA3rpR
         rIugBIOBKrla+wQkGFDGrrfwl0n94u58IkLCQ/5XCY28ElgzNpybIyJvDaCeH+G5P5rL
         /VZ9zz2xAu/tqpVGqU7cobsOlW+9s8oGKZkGoLvRll5lr/5pnWN5csvHw420DF28mDun
         ABi/NyXaGH7CaA3LLzGuKk/TG7Zg0C99147WVcreH3l4tIYWqiicKa0uWvQpQpjx0swQ
         DYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678394068;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7VHKM1TZh/tpZ43OaDrF8rGSweyNHxW44fC7EAr49fo=;
        b=TULt1wNYAEhFkAsftlEqgYyH/MMwkxafWzNSgAqrNIzWcSUBlH9a4oNizShxG7f8+m
         /N3EntP1J0vk07X5bgrg3/m8ZWWhjf2glDZpJtiKxi23S3HVGXXkTgoXqRP6TFY/2YqH
         NA47eB/8f9fpVIAzmQVeJhgaSgFWv0+oQzav/H0zWNYNy1Xrp3B3YLc7uA2cxqVZbKs+
         ZwfqcW7xPgqcbz/WZrrfn1XPyLffJXG/g1IwmG5Me7SqYk+/+JpWEyGnt/naQxCkqfI0
         GdivfTVFl5SpV/vvC3odu39kKVb4gkWPSYOSG+i9p32QFIL/FDeqjuXrKiDmOKrt9UzK
         olPQ==
X-Gm-Message-State: AO0yUKXlKVOld84XCP+pLL42vvrPTT/Pxb7ZAxYlCHnxY1g33ClW90NP
        3XwqlCkGab2zDGSi2E19tsM=
X-Google-Smtp-Source: AK7set+dQIZVtc0jXwLDVyZYQ1ZzOrtWt5RnkRmTPOM2tIXe3JOOw/0SFV7LQaziZLFrP7BzsnxKKw==
X-Received: by 2002:a5d:4c52:0:b0:2c9:5675:7def with SMTP id n18-20020a5d4c52000000b002c956757defmr14949964wrt.2.1678394067753;
        Thu, 09 Mar 2023 12:34:27 -0800 (PST)
Received: from [10.23.0.3] ([194.126.177.54])
        by smtp.gmail.com with ESMTPSA id b10-20020adff24a000000b002c559405a1csm312023wrp.20.2023.03.09.12.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 12:34:27 -0800 (PST)
Message-ID: <e20e489b-c033-7a38-9750-24b9abb22a0c@gmail.com>
Date:   Thu, 9 Mar 2023 21:34:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 3/4] dt-bindings: firmware: Add Qualcomm QSEECOM
 interface
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230305022119.1331495-1-luzmaximilian@gmail.com>
 <20230305022119.1331495-4-luzmaximilian@gmail.com>
 <20230308221657.GA3935330-robh@kernel.org>
 <93657561-d545-7ead-7f6c-dd2c62aab319@gmail.com>
 <c92a44fe-7057-2d81-41fc-2e84ae60f881@linaro.org>
 <951c717b-d094-4190-a04b-3ce9007d1554@gmail.com>
 <57b436d2-79f9-a7c1-ab97-0b555beb6468@linaro.org>
Content-Language: en-US
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <57b436d2-79f9-a7c1-ab97-0b555beb6468@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/23 09:19, Dmitry Baryshkov wrote:
> On 09/03/2023 04:27, Maximilian Luz wrote:
>> On 3/9/23 02:33, Dmitry Baryshkov wrote:
>>> On 09/03/2023 00:44, Maximilian Luz wrote:
>>>> On 3/8/23 23:16, Rob Herring wrote:
>>>>> On Sun, Mar 05, 2023 at 03:21:18AM +0100, Maximilian Luz wrote:
>>>>>> Add bindings for the Qualcomm Secure Execution Environment interface
>>>>>> (QSEECOM).
>>>>>
>>>>> Pretty sure I already asked, but no answer in the commit message. Why do
>>>>> we need this? You've already declared the platform supports SCM calls
>>>>> with "qcom,scm". Why can't you probe whether you have QSEECOM or not? DT
>>>>> is for non-discoverable h/w we are stuck with.
>>>>
>>>> Yes, you've asked this before but I can only repeat what I've written in
>>>> my last response to your question: I am not aware of any way to properly
>>>> discover the interface at runtime from software.
>>>>
>>>> If it makes you happy, I can put this in the commit message as well...
>>>>
>>>>> Why is software made non-discoverable too?
>>>>
>>>> Please direct that question at the Qualcomm guys who actually designed
>>>> that interface. I can't give you an answer to that, and I'm not all that
>>>> happy about this either.
>>>>
>>>> To reiterate: I've reverse engineered this based on the Windows driver.
>>>> The Windows driver loads on an ACPI HID and it doesn't use any function
>>>> to check/verify whether the interface is actually present. Adding a DT
>>>> entry is the straight-forward adaption to having a HID in ACPI.
>>>>
>>>>> Nodes with only a compatible string are usually just an abuse of DT to
>>>>> instantiate some driver.
>>>>
>>>> If you or anyone here has any idea on how to discover the presence of
>>>> this, please feel free to let me know and I'd be happy to implement
>>>> that. Until then, I unfortunately don't see any other way of dealing
>>>> with this.
>>>
>>> You can probably try requesting QSEECOM version. According to msm-3.18:
>>>
>>>          uint32_t feature = 10;
>>>
>>>          rc = qseecom_scm_call(6, 3, &feature, sizeof(feature),
>>>                  &resp, sizeof(resp));
>>>          pr_info("qseecom.qsee_version = 0x%x\n", resp.result);
>>>          if (rc) {
>>>                  pr_err("Failed to get QSEE version info %d\n", rc);
>>>                  goto exit_del_cdev;
>>>          }
>>>
>>
>> Thanks! I'll give that a try.
>>
>> As I can't test this on a device that doesn't have qseecom, it would
>> probably be a good idea if someone could test this on a device that has
>> qcom_scm but no qseecom (if those even exist) to make sure this doesn't
>> misbehave.
> 
> I could not find a vendor dts which doesn't have the qseecom device (checked the source trees from 3.4 to the latest revisions).
> 

Thanks for checking!

So that only leaves one potential issue: The re-entrant/blocking calls
not being handled at the moment. If we detect qseecom based on the
version and then try to query the app ID, we could get some devices that
use those.

I'm not sure what the consequences there are, i.e. if we're potentially
blocking something else if one of those calls blocks on such devices. Is
there any way we can detect this beforehand?

The current proposal isn't very good at handling that either as it
assumes that this depends on the SoC generation (which it probably
doesn't). So I guess one possibility is to make the list of app-names to
be checked SoC specific as well. That at least limits the scope
somewhat. Maybe you have some other ideas?

Regards,
Max
