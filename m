Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17176F990D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 16:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjEGOzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 10:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEGOza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 10:55:30 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC3172BA;
        Sun,  7 May 2023 07:55:28 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-55aa9bcde31so4995137b3.0;
        Sun, 07 May 2023 07:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683471328; x=1686063328;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0a1+UeLlATmgaT4hIrkt4/5zUzk0Ow/J8sqcb3kQi/A=;
        b=D8oNiHkuVxig1gep6gO0cHT+strbDtVEhVzzvoIChhlbWN/T/LiQ8muaBiYDeiRam4
         k6Hg2eluXy0Sd5ij6o8X1aGaE0vGB1Qc3V9+XxqrgPMFf10ePTg3CnBf9YrpWpr8KrFo
         90DTLR6nzd76YT9akek53DDpYDb/WZUV27MMl+kScqkq5mqAH4kJSkzUGZicjF8NHzz2
         zKg3G2CzKJjeXH5fNmTKnilz5uqYYqIP8BehbGvWdHn0zPxjC4bNodpQf2ADdBsbvk7C
         M6oHXqcw6xkxz7hQj1kZ33FhQMNuk1vVsbAf2kk6Z+lLg0HH1AuuaFWqX/FbBplT6QQ5
         z3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683471328; x=1686063328;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0a1+UeLlATmgaT4hIrkt4/5zUzk0Ow/J8sqcb3kQi/A=;
        b=CnAZZkeQDEKm6jelKGTqMv72i+2GW/zi88BW89PiKnE54qOdB8hVUDKtf+x85KAFpV
         /uMThGFhveweA8N+5zqEVQkefiKHUKg/TeqR7QtVPnGDbwLZsaFAIrpeHOHlLhHxDjKZ
         DAJl8e0CwiAWNs7Ot0vW2vhS/w7FWMkwSDNbHYLDRiLM/w+0rdNvPh/SS4dE6cshtCHa
         J4RV6Rk2KKZlqET0lXzNbxpiLNyjZvwjrhAORFFjn5pyYXVJfGhoqOBOJ1a70h81hxcU
         SM6Sr/cKLykux5lALq750gi+2r/bzr4eAJ0DJic7JM3DMz/ySps6wUF1+5TjikyX/WNI
         VK3Q==
X-Gm-Message-State: AC+VfDx+bQONHS6hfZ/2hV+XMnb3QbMndga34whHQUNb0QNys6F6GlVi
        x6Rg2X/WgGdKxx1bAQDNDpw=
X-Google-Smtp-Source: ACHHUZ73lLFaaN5yQqcTGVDNauL6G7L1c8diOqwAnZkrCIPUGbPOEqJzxEAO4HctJp8fF4IsC5fB7A==
X-Received: by 2002:a25:aa71:0:b0:b9d:b2b6:7fd9 with SMTP id s104-20020a25aa71000000b00b9db2b67fd9mr6939647ybi.1.1683471328071;
        Sun, 07 May 2023 07:55:28 -0700 (PDT)
Received: from [192.168.75.211] ([173.23.87.62])
        by smtp.gmail.com with ESMTPSA id s4-20020a259a84000000b00b9dfcc7a1fasm1712432ybo.7.2023.05.07.07.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 07:55:27 -0700 (PDT)
Message-ID: <0bb0439e-b066-ad05-371b-73d3135b39a3@gmail.com>
Date:   Sun, 7 May 2023 09:55:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [regression] Bug 217394 - IRQ override skipping breaks the Aya
 Neo Air Plus 6800U keyboard buttons
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        "Limonciello, Mario" <mlimonci@amd.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        linux-input@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <01ea5c8e-ed2f-7568-f6ed-896329e7b673@leemhuis.info>
 <68d017d9-d815-01d4-23c1-49c0aaf5f20b@amd.com>
 <CAJsYDVKY0V4V5fCseGJ7SPW6+-4r7d04RTgkF82VgYcNLk5DtQ@mail.gmail.com>
 <1b3e5df0-6190-e560-72c8-f600f715f89e@amd.com>
Content-Language: en-US
From:   Matthew Anderson <ruinairas1992@gmail.com>
In-Reply-To: <1b3e5df0-6190-e560-72c8-f600f715f89e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Ayaneo Air Plus I modified the DSDT based on another handheld 
with a 6800U that does not have the problem and it resolved the issue. I 
hope this information helps in some way.

<             Name (_HID, EisaId ("PNP0303") /* IBM Enhanced Keyboard 
(101/102-key, PS/2 Mouse) */)  // _HID: Hardware ID
<             Name (_UID, Zero)  // _UID: Unique ID
---
 >             Name (_HID, "MSFT0001")  // _HID: Hardware ID
 >             Name (_CID, EisaId ("PNP0303") /* IBM Enhanced Keyboard 
(101/102-key, PS/2 Mouse) */)  // _CID: Compatible ID
6135c6135
<                 IRQNoFlags ()
---
 >                 IRQ (Edge, ActiveLow, Shared, )


On 5/7/23 7:41 AM, Mario Limonciello wrote:
>
> On 5/6/23 03:25, Chuanhong Guo wrote:
>> Hi Mario!
>>
>> On Thu, May 4, 2023 at 12:11 AM Limonciello, Mario <mlimonci@amd.com> 
>> wrote:
>>> +linux-input
>>>
>>> On 5/3/2023 7:58 AM, Linux regression tracking (Thorsten Leemhuis) 
>>> wrote:
>>>> Hi, Thorsten here, the Linux kernel's regression tracker.
>>>>
>>>> I noticed a regression report in bugzilla.kernel.org. As many (most?)
>>>> kernel developers don't keep an eye on it, I decided to forward it 
>>>> by mail.
>>>>
>>>> Chuanhong Guo, apparently it's cause by a change of yours.
>>>>
>>>> Note, you have to use bugzilla to reach the reporter, as I sadly[1] 
>>>> can
>>>> not CCed them in mails like this.
>>>>
>>>> Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217394 :
>>>>
>>>>>    Matthew 2023-05-03 02:28:33 UTC
>>>>>
>>>>> Reverting the changes found in this patch fixes the issue:
>>>>>> https://lore.kernel.org/all/20220712020058.90374-1-gch981213@gmail.com/ 
>>>>>>
>>>>> With that patch the AT Translated Set 2 Keyboard doesn't show up 
>>>>> with the evtest and is not usable.
>>>>>
>>>>> Hardware:
>>>>>
>>>>> Aya Neo Air Plus
>>>>> AMD Ryzen 7 6800U
>>>> See the ticket for more details.
>>>>
>>>> BTW: there apparently is another IRQ override needed for a different
>>>> machine. See https://bugzilla.kernel.org/show_bug.cgi?id=216804#c8 for
>>>> details (ignore the comments before that, the quirk entry for that
>>>> machine was merged; comment 8 and all related to it really should 
>>>> have a
>>>> separate bug; that's also why this partly fall through the cracks here
>>>> :-/ ). The user is currently trying to create a patch.
>>>>
>>> Something I'm wondering about is if it's possible for i8042 to detect
>>> the polarity is incorrect when it probes and
>>> to try to correct it.
>>>
>>> If we could do that we can probably drop 9946e39fe8d0 ("ACPI: resource:
>>> skip IRQ override on AMD Zen platforms")
>>> to fix this issue along with all the other quirks that have collected
>>> over time on i8042 polarity issues.
>>>
>> I don't really understand why there are more and more new laptops
>> appearing with broken IRQ settings in ACPI, especially considering
>> the fact that some of these laptops were released after the original
>> problem was already identified almost a year ago.
>> What exactly was the solution when AMD internally discovered this IRQ
>> mismatch problem? Did you guys changed the emulated IRQ polarity
>> without updating the ACPI table with the corresponding polarity
>> description in your reference design?
>>
> In the reference design the tables are updated to be accurate and
> reflect the appropriate polarity.  It seems that the vendors must be
> changing this and it not breaking Windows for some reason.
>
>
